```sass
@mixin border-bottom-1px() {
	background-image: linear-gradient(90deg, #e6e6e6, #e6e6e6 50%, #fff 50%);
	background-image: -webkit-linear-gradient(90deg, #e6e6e6, #e6e6e6 50%, #fff 50%);
	background-size: 100% 1px;
	background-repeat: no-repeat;
	background-position: bottom;
}

@mixin border-bottom-1px-dpr2() {
	border-bottom: 1px solid rgba(230,230,230,.6);
	@media (-webkit-min-device-pixel-ratio: 2) {
		border-bottom: none;
		@include border-bottom-1px();
	}
}
```
