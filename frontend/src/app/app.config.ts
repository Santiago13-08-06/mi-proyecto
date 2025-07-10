import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideHttpClient, withFetch, withInterceptors } from '@angular/common/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { routes } from './app.routes';
import { authInterceptor } from './interceptors/auth.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(
      withFetch(),
      withInterceptors([authInterceptor])
    ),
    importProvidersFrom(
      ToastrModule.forRoot({
        positionClass: 'toast-top-center',
        timeOut: 2500,
        closeButton: true,
        progressBar: true,
        tapToDismiss: true,
        easing: 'ease-in',
        easeTime: 300,
      }),
      BrowserAnimationsModule
    )
  ]
};
