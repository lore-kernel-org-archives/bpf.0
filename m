Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795080001;
	b=ZWmCDkl24es6XCtaivstJxmIB03/h9yLeQjH0GxNC5HfyViyhmIeVHY6frB2Rax6X0tB
	 GSncDBHozyvoEAAApYZwtDrv1BwmlcAK9mIo0KmwHVm6er165tPvCoNvAxAxD+7gRGNtv
	 DKnogOEP5suAC656oO+BZRSEhg5qXtNTg+4ClHJBuKaYLi3b2hSifAWyCCFb7vzw/o2RT
	 EO9spKMM2pPyyXkUPYdEb3FqYe0wmdBzgt0CLjh82S2Temn+K9imNXrsu5fvYGijtqWkt
	 xwYBBfu6Q80IvQy1kZQlKebRfqyOAQOYxJiUL4/erS7ufOLugTC7Ce3J4O7DifarlUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ti7zYfewVTPLw6o7ketmyvxMhRKCPMrEBC1dAP5uxT4=;
	b=V8yxC2XmPOemg1WfFTSiGyZI2wgi/KoW1TL/7yMD2loKKovYjgwmN2H8bLCTvmJj0bSa
	 ZlieRuhg9Llfj9h2ZMa3k/qP7c/hRjZQyAbaxYreRXfSJiWuyrlduzdD/qyFrSug/XL7S
	 BgTw/ZBBw79JrXKg/LFqfOtchR1LRw12OCmM6sgrqto693IhpvrYzqgE4vKTbJl2LVZ4N
	 sQUpTC6MgEI+KmKLruhfmRNRUZeR1m+Oltk6mmSKtUaUAdlf3mWGkUuKxbn6sX2yVRSdt
	 nhTKOR3uYawxFVsI4MtIpm8fd0DkI69MU8MtG3wDi5Jhd05jvJLNSa31eO7GvhS4XYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EkOk1PBC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62149606A335
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 09:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62149606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EkOk1PBC
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40e30c26a4so149587766b.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795080000; cv=none;
        d=google.com; s=arc-20260327;
        b=MsKVHNuuOsPVlIkPHZ7QqsUeM0aoX82jdAcmsnjJsTCy/JYzIUhP5vo7GJGiqW5aBk
         Qz+31rTJ8Mhj0xywC03YeXMKrWYMFqwIbkwSgxdomsC08k6nrMnznd3JsrcULzTKwoDd
         Nip/2ZIzq7xKoZgTIILTSx3B7EYAuHGQNujy0zauOckjWXRg2tmahFerg7VZhsuo1qZh
         kEOA7hqYUJl9izSzYnWqx6ASTyvo5/ykRynV+fjXmpCZXbwO5youkA1WD6Cwci1X21kK
         XdY2ZOZIuIsb/VSigBRHmGGSFyOyglZA9J0QAp/xVgiwGLsIYQfM+EblX9Do90adOkj/
         Prnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ti7zYfewVTPLw6o7ketmyvxMhRKCPMrEBC1dAP5uxT4=;
        fh=dTZIjqDE7NWFAIfyb0e3JCqELr8P+687UN4MrHqdLq8=;
        b=ovdlj5AGHBkQvHPEpsOKvZfEeRkd4n/EsvqtNhGWaEwsRpSIzApJc8lg2hcLNGKwh2
         t51lYySR7Qgj7RbgZ6Px9g9337OZHcc9LLnP3EkKYEoc865nGUOkdWQfvLAwGUE0XDHJ
         d3ua34VDn0p6u3MlgiV/JbC+AfbdqRt9dXjVt/CKJ99+zRP0HtbvqigpCjqP9qNefkqj
         tfwSp/6WVnIfpKYC9FKI8m/OU56lzLHsSDtU7WFUwg2qGcmzbT3kdu8AIMLDTpcxMDWW
         tatkAcYrbIhW6kxaZ3HGOLsux3zqfKoG7N09usdCyMu5mP335hrJ3lVtKsvxnSEvAVpU
         fN6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795080000; x=1795684800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ti7zYfewVTPLw6o7ketmyvxMhRKCPMrEBC1dAP5uxT4=;
        b=EkOk1PBCMgiSWI/XNDC6j87bo/JDyXhwWSKT7KNf3tIjZn7tp6QFghruYqBhwrnaHh
         l4wZdzAJmlOIPC8iWaJ7ngwdy1HbOL4Kugu9fvqGhpQht29d9utB/pDKKBVFfYIxjL9F
         sES+ZEY7KLg3uU24NJyfI6VEygksoQOswuWcQMC5xFUMLihcDekPGXI9MN1T30wP1FbJ
         mDRuhnxif+ZSVfXF67RgfNJnpFou3Vy2qNQNa4NGt5Hb+iA7sJFxs2gbE4m3MIphzT3W
         Ul0e5Rdzoacx5eSgIzidb/z7WxKHv9yri14fD+yIxk+ztRXMK0nt2nRw65ZQklBNUFUw
         mc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795080000; x=1795684800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ti7zYfewVTPLw6o7ketmyvxMhRKCPMrEBC1dAP5uxT4=;
        b=WqbIXS1iFkxsxibg/tOtLb7zjhqxG/QrVxhJWlMRgBmnE2NR2Q4UpKYEX47vt+N+7s
         KukAnF2uwcVl5I2i3og90P1stIm/7c9albeuT/xgiIaEg88iB5o7BlpaYvAeUtjcb6Kn
         Wu3pJjYYFmCVJbUpktvpmmTB6TqrnZ2WxiRSnkrPSMez8pxnMd/k9KFe8VCqSA+RqHs1
         10eDxOPnQbs3IwhysLMN5JNQdaZG6Vh1bnVCPiJIE4NQkKRZ5QozLShkMII3fuJ/t50I
         1In0Rp4/lWO7MEbWZ4HEMkQlRnF/fR4C1K6R4gIsFbV+AwpDzzChoe4aZl3dBnog9OAP
         nbBQ==
X-Forwarded-Encrypted: i=1; AL+hErECGltrrXvxpVJ6wWNLCwMvODzogvC+AeOsEs89OFU/M/qMrHHtliD3SyyxXoyePMNvlSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8odpLBu8j44hshmTJOtmg0lCDQ/sJIXSo8uTjmVLpKtt50UGf+
	W0iOrMZq9C9c3VkhoamtLW60+pX4lMlMgFqjp7PfN8nwNPC2cqVP7ZoPPeuPvrzJA5RpBpxEb7s
	KYQBFBQ2O+Zjr5sYVqy5QnPe1lzac94PUyomKoqkKRg==
X-Gm-Gg: AYBFou1s0r+EoZKa3skep4bj8I+/HLv/4sBdhSQdTKjpHG4j9MptP6T3izhu1xAM4wh
	nWs7S5jIqEH0N9wvSO7Hwkiz3WxlFDsJdNGdM5Ry5Daty5pIGX0X8kD33i+ZbjOGRWXtexDe0UJ
	3SQ5cRVVFAXrI0tkeeq7dV7dMQc3dVq/BcPQN+0CWI9HYr4sOIbvHm2W1F0pnRprUZxQATcgkNU
	OysBxLUVMI6e/Of8nDrNFNg3H2nhFL0Fg1nEAe3QJ9W/7vYvNiFRYmg45O3ljofStuojyVKl+GL
	wbTam5ezY6YYnyNVFd/RH79gAvqFa1MnhvqRlJS8RatBxlyG8cl/C2lsFVAgR12MTKMSPFDOXTx
	1uPzHY9PfMT7yduYcD0rOKyKdTgNzjoutNUlsqSyWJNmIs7MlrhV0BkjwgA0oHIVlJ/45zQ==
X-Received: by 2002:a17:907:9692:b0:c40:9b35:ad91 with SMTP id
 a640c23a62f3a-c51318163ecmr59215466b.13.1795079999707; Thu, 19 Nov 2026
 01:19:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118184729.2302130-1-m-malladi@ti.com> <20261118184729.2302130-3-m-malladi@ti.com>
In-Reply-To: <20261118184729.2302130-3-m-malladi@ti.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 19 Nov 2026 10:19:48 +0100
X-Gm-Features: AclHuK8e8ffnAD8pzuAiTxnaJvnDKX5k-oyRRYloR7_BmjnaSSX9Hh_xNi7mzEk
Message-ID: <CAAofZF4XYd5z8X56DRARMxbu3t7QX48T7V69MPBw9TW1BQAmKg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow
 classification support
To: Meghana Malladi <m-malladi@ti.com>
Cc: kees+treewide@kernel.org, laixiangwu@cmss.chinamobile.com, 
	philippe.schenker@impulsing.ch, haokexin@gmail.com, devnexen@gmail.com, 
	horms@kernel.org, jacob.e.keller@intel.com, sdf@fomichev.me, 
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org, 
	davem@davemloft.net, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com, 
	Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 18, 2026 at 7:50=E2=80=AFPM Meghana Malladi <m-malladi@ti.com> =
wrote:
> [...]
> +       mutex_lock(&emac->rxnfc.rxnfc_lock);
> +
> +       /* Check max rules */
> +       if (emac->rxnfc.rxnfc_rule_count >=3D ICSSG_RXNFC_MAX_RULES) {
> +               ret =3D -ENOSPC;
> +               goto unlock;
> +       }
>  [...]
> +
> +unlock:
> +       mutex_unlock(&emac->rxnfc.rxnfc_lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_add);

nit: instead of mutex_lock() you can use guard() [1]:

    guard(mutex)(&emac->rxnfc.rxnfc_lock)

and remove all the "goto unlock", returning directly. This handles the
automatic cleanup.

Same for other places where you're using mutex_lock() / mutex_unlock().

- [1] https://docs.kernel.org/core-api/cleanup.html

--=20

Marco Crivellari

SUSE Labs
