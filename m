Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DE21A453
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061956; cv=pass; b=NSkwKTz9d5VjNkHV8RCgP69/FWGqmd5Pd7q5c6BoA2vhzzpXsgRM0SA3UjyWLlOHJC0mNn598C3CsgK9NaAkN7yPpn34kLqZphhQpyuER+eY3BEhx6Rkv3QaWnLiliO9aF9E/ZDMHJCQdvjSn3dvak2ClaMWzGI2pRQ6EP6OfRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061956; c=relaxed/simple;
	bh=OLw7F5+O4Ix+dDCWbCivhj5jjpeD5EwA49kGQoV1BwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnlDdEh8ANxbvtp3QlD4EVCo5ybgRO9UXrOoj69dSCF2/q3xCZfB8fuMLW+lXpPXBP5DSHBri1im1KnGe91mnsxqjucIyLUg0lPl2OgWWkhYSv9t/mR/4bVIquchflv9l35JMf+IgZvaLJr8gUw+bJfBPoAYCCWr7p+an65jW1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMWWXe/U; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMWWXe/U"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso3036406e87.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 17:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786061953; cv=none;
        d=google.com; s=arc-20260327;
        b=Rh/ojoxt5bsM+TENhe5OlMFJ6O/QzyNjpE81B87z2hWi1pRU7VUprDTrnegzv1nTiX
         EjLNrByJsWagQaTEYaMTQkdB9SLnM2UzNxR6frQta4w3xLP2ACX6M/vBGKHn2UW6XCLt
         7jvHGt+bZjNlPw91SFAHPibzX7nSJxRssnUZoKXKgbE5PsG3S5AeVd3Fvb51vGHJ4oR9
         vSeY09vydwivLwnBxnEXQoAYiVfwvINhGniHkixkZFrqY9EmLbdbA/XbP0OhGQZAR/nW
         N16r4ktHeSZBkylCZsyZDaJ8ktkJ6XexZuF361+0a6UBsqfmPPgBlz/KMy9o/pdfGLbT
         v8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iQmXi+4UEmQnTAgK3Lk/oOEKoHH/eshJX8JwrI8pjI=;
        fh=MeZE3C9IgdjbgwIbB+9VkhFSbmflnkxJQtQ8HKlhn84=;
        b=gEEBZxrSlBaUenDpqI3IYMcU1dfbx1lWvzlEnSzgdyHHaiPvU/3PODqtBFwEPOPV+V
         tFjA2TR4AG3z76JaViVZu+OEc5UIVs3+gAjpp8zWdYgQHmLQ9xqEKw9Eaa92Y1ZlCE/a
         hFtAG2xyO/+wRtqLpRQbP+rno3En9tJ1LtGTTz7LTnKgy3B9ypZ3yzcqGilth5ONFU62
         stRh+dSD+QEFmnd2nERnVislH+ISGjTNUP2ZE1aqfCfQrN+/Hyq7OFlX4H+DK1bKuJM1
         3i7nrmPelntzWs3HKBY9IxG4B9nfaXPglOOBoKyxTqNyclLNmT90Cbo3p9HGKo5bZOOh
         WRww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786061953; x=1786666753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iQmXi+4UEmQnTAgK3Lk/oOEKoHH/eshJX8JwrI8pjI=;
        b=YMWWXe/UmXJCgT5IvO5g7L/+5rW3NsvH8nphFYUMq1/ak6zJf1smTq3k3/u2z9QTvT
         iKI/bCUMoXzRXAWLH+PO4ydnsKbPEKodefV7iKnShkEXls+16nL85StAl5tokGMUEkcR
         Utw+uTx5T25NgR2a13w4rko0/pt7R6wCONR5o17mUJcRswb33LRzCTidn7FKi68PsQYH
         e1cKJIK+zvO3REwSJaWl5tIee5FSR94LDH2QSp4nnK/eILTCNxx3RZI0G5DFULdySo+M
         CIl1VIBk1ARlhgrsSYg3Twep224RgmqPTvx1QTk6va0IzwEmuVGwQGK27EGbf2manq4j
         B/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786061953; x=1786666753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iQmXi+4UEmQnTAgK3Lk/oOEKoHH/eshJX8JwrI8pjI=;
        b=abZB+50PHTWxhDkWylgjsS4caQoXdAGeHEYi2tO1Lc9zdnVS8eYuojm3Fw6Vrd64iN
         9WEGKEj/KM+YnUYVpkpiD768iYzVN+J4a+juTnLoz1wE526mdwGkejwKvc38KdFCSAb2
         /QkJLA1OoKAEUNaBjSXsjR8UouM7I/HyZjPCEuDS0K+7fuDcyqL7aRV1EXZt1opXFSRf
         6rYgeBkTBgwa8kRcvS55q1V6Fard6TqVGVWBb8wQXIzAAKzaA6Qs/efZsPWGzLk8gWrb
         k1Uley2sSak5YEOUuA1yKn8WMcShu82wKhzvQDSYta0ghI4Y2PNV4KREanavXhJeSJla
         zK8g==
X-Forwarded-Encrypted: i=1; AHgh+RpOOzXPxU+L8Xun9WDnm1EQ6e7rseCb5YldGS/JEhzqXqA0WEmiW6wpEz1sT3Ytgg84jKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkj9PfBPMHOx2hOEfHRKviG7dizrVd5zHtiMeppBWB68Yo5dXy
	KogK+sNH1CB9MyFnh+eCXskE6qmg/f/5oj03VfcuvVCrYgpYTKzCeYLuObE1OoUdDwmxbvU789f
	WgYvyoDmHIKSiWEX+lodDOedkZSoeKzX8P5KyfOEo
X-Gm-Gg: AR+sD11p1IlUiucAChBW3qyKWFXqm5og3iKkx8Rzh/RgdegGxEWROlKCXQsDFEp1Paa
	usfkuhqWEFkRPdwcFIo/A3uL2W2dBbf/W0E8EyzMLMld4Jilpm/3hhlbQkUoYwT4CvxCb2G+7c7
	M69yKVTVE8K5fJlGpcLat/2vNKuj61vMVc6vghJ0Pq0fvkDlcGtLQMCv6TgllqKmQQGSD0+E6PP
	MPSZcB6Fc9VS1Oo5zLZJIHtGAUjI5MkOPdRHkeiQPY1+lqNqgWXZ8wUA8MEfUHeErCJc1tShuMi
	7qej6uJEE2xpP2X+I0LJFEQ6M4d7P/KnecrAXzHAB8t8okRxmAuygnZHUtQZ8LML2EDBQAQ/c10
	=
X-Received: by 2002:a2e:ad10:0:b0:396:8ac1:53a7 with SMTP id
 38308e7fff4ca-39fbb1d39a6mr23161831fa.8.1786061952286; Thu, 06 Aug 2026
 17:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-10-hramamurthy@google.com> <20260805183711.2f31aa2d@kernel.org>
In-Reply-To: <20260805183711.2f31aa2d@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 6 Aug 2026 17:18:59 -0700
X-Gm-Features: AUfX_mxLEdsv-9T-gvq-o3w3bVO4ym-rfR_8aT9kttq6yWUhMrCBLiJtFct1XnQ
Message-ID: <CALuQH+W6A8H_YhKsqebtD+kMAs-AYT+U_7ygVfTUx_R0LbniPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/15] gve: simplify reset logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  3 Aug 2026 18:46:24 +0000 Harshitha Ramamurthy wrote:
> > -static void gve_trigger_reset(struct gve_priv *priv);
> > -
> > -static void gve_teardown_device_resources(struct gve_priv *priv)
> > +/**
> > + * Request the device to release any allocated shared resources.
> > + *
> > + * If any part of the teardown step fails, the failure is documented, =
but is
> > + * otherwise ignored. It is expected that a device reset is triggered
> > + * immediately after tearing down device resources, which would clear =
any
> > + * lingering state on the device.
> > + */
> > +static void gve_teardown_control_plane_resources(struct gve_priv *priv=
)
> >  {
>
> Triggers a warning on W=3D1 builds:
>
> Warning: drivers/net/ethernet/google/gve/gve_main.c:705 This comment star=
ts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-g=
uide/kernel-doc.rst
>  * Request the device to release any allocated shared resources.

Thanks for bringing this up. I will fix this in V4, and address any
actionable review bot feedback.

-- Josh
