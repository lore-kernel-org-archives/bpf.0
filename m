Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610995;
	b=2rr7XeqBVtf4GlEgp/U+t/zQ602z2G6HE5euBWFxI68prEpe7ebbgJm6f15VZZJzMEQ1
	 7vsG/mS2jrZCQrAApbZA9qIEVHqAG+jYMhSFm1h58Sl+RuGp0BUgSCL4F32RK1QMsquyh
	 3wwr1Z86UoAu0IHHF7V2btKszB6FlzFCDQDiS704fkX8QHmbne91Y6yGtc0K3zBf185fp
	 bN6HjgHeLXldTgL2lFw/5T6xYrn2J3WYL7TGPUTkdMoYNNBpKvyDu76tbYQ1k9YSSpSVU
	 oW/9n9G4cMm3/VWzlDMtU9/kITwgK0nfiSA7RjeQZZGTmyc6wLuEnUkFVntbxZuv5UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
	b=v96h+CRL7DoWItANslEuwhPrIfc0pp5cbpGbdXRMUhNhkDvfrS+0X5tOzcvPfr22bY4R
	 weOQ/nme/swFdj3yCVecdyzdQWIJxHb8rIY+ucF8PWqD9NI44mZu8WG8RNQyLsUcyLBc2
	 AttF8BCDqwPPSgAYDyv2nQqmrFDqEX7mAG+MsmzSMB1aaWDpvMyqAZF+/I6g6Aj3GacLL
	 K/97P+5wgo2AMfa6r8RNfGbnepzp9dR3vXLnY6Ta23BCDfD331ns76nAh/LS2NuMWYonr
	 P8t6S5DkPb75ZLvujm5aK0Qo6rUr0mrfZplwBMScxzSocjHiWHCUJMSQvNO/M6wuN1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D68606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13D68606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso56528275e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610993; x=1796215793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=ijrvPjrs4XPMGxLv2/cLDzYf1DTkp26koBrs+YwuqX5elYJruc4hClaOIjF62Q3+YN
         LRHIUBC22PWGF/rAGALu7SoOt5zqUHESVTCa5vHMQJoFy4B5gkLHeV5hugIirMLPKc1z
         lwkIjSkykztPQpKhyKTDraxT5P3oaH7NzwApTcr02ARr2hT5KerzhwRvxghSP1A3P/Bp
         EtgDED95aoU7Ek6mxljMaLWO6Bx5amJKRdXl3ABZkqxCYsSCC5SlDmTZNR4DGfcavrRk
         HtSpSZ/UepV+pwNgpwEHfsqbflJPpiVU5KOF/FpJhp5lP9+HVdK4ulKpQ0NMqA1E55T/
         7WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610993; x=1796215793;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=IQQ6t5q4VJjoCKCcTIa3k7GJvvTgrus/005mkQU42VrIHEZVY54jqse7tlANzB20Ol
         9MOMrEhDz7+23SiH/XrkdmJx8Tog2bno6Gh12UODMu+foiP4OwSgw4iWyml5n5LMPqA8
         19wiaX2eFkkc0wQ36/fTLZ+2FRaiRy3fcBEGfVuicdxyWonBfgNkrgx3bSqowvkYyVih
         bKB96BKGBpnt8o2njqaZrcReh8CPNCtOXhPfghOrctBUwTjt66hUtWdTK8MRMzhnxPDY
         AZSyngBb3szQDGyrI9yV3k9xZicvD6ewD+Atty1keuyDxXP1ksW4hTf/8oxaKrLyvS8j
         uN3g==
X-Forwarded-Encrypted: i=1; AL+hErF+GONx/KBfiiRBt5g7hv5f8qv3hPRiIXlFzOHo+dT0MwiUHOc/rc4OW6+zplXRr9pDpms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8D0tHMjGm1Qt8GiD8ops0+gH29lgnTpv/6PhIFJNrDU1+2EmKd
	6L1PjIjn/i1pzgN+zKFGkI+O7D/9R9c/aHJyfCT2vpJC72dvMwTUUruzW4EyS4AW2rKI
X-Gm-Gg: AZFdTZeqASaLD0vdApC1rq9wWhDSYs9i9sjpwNIllHVZd9i2zCnBFkojdNITfFs1t6X
	mhYH1WZR+b5CBIXOK8Fy6N1g4w58MOKvDZw6nH6UsPLUsQnTHRfV2w3TJ7oTPUGu6UpNcFR4BM5
	vg5SDOtxPu1USmGyrWoJj/1GNo7CrBPhy9+ooInWPae7crcp+OxW5iOicYiLmwCDpICzE9kw3GF
	sXfK4S9oXqTh8OnZGPNEfJfzLN0B8VL3razAcBk38n3ADBfKTlKsZpTJXNZZGCgBxkaYrO5mzu+
	VZ/lYMbKbCelf7d+jsZ5sz11QeJq9iGw6TL1jBtw+NqC0DZ7f9OSnBUWWSb5ym4rEMfaTeFtrU+
	ESp+OisI93nZO83BLiv2LL1+DkRGsSHBWvlGLDDr2mbJ2oOeW0VqLGq31P37q/Zua3wC50KGv7g
	jF6rXONGLYFkBR7/YREo+/Rtt9hBurCFu5a58Wv0PSKQzw0wUWXrrKYAueZiGLTaACUMtdLCAlW
	7gMcQlmsJJwdxZewA1pBEhgCbQQBK5xqsw6afCOzHs/YwQWB3GGesPTDls3ISYqjrgjSmap3pOE
	7S9zMRKMUH84/tGoQ3FN54TsrrtoErkiLmXrdRBwRnwR3bMEE+S2TJelDJTKruXNzMM2ipfRn0A
	4KGknY4M8/A0g7EgmS+p6Kwu+02h9javxhGqnIj9SPYWs104hZ62XbQ==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr364999585e9.16.1795610993400;
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm710678895e9.13.2026.11.25.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Message-ID: <34297f66e07c1a64d81205c7669801738676f356.camel@amutable.com>
Subject: Re: [PATCH v2 11/13] fs: remove d_real_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:49:52 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build
> instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0Documentation/filesystems/porting.rst | 10 ++++++++++
> =C2=A0include/linux/dcache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
> =C2=A02 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst
> b/Documentation/filesystems/porting.rst
> index c38f5df755bb5..aa0fc43907017 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *.
> mnt_idmap() and file_mnt_idmap()
> =C2=A0return one. The idmapping is immutable so nothing should have
> modified it
> =C2=A0anyway. References are taken and dropped via mnt_idmap_get() and
> =C2=A0mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and
> returns an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a
> metacopy file
> +in a data-only layer. Use d_real_data_inode(), which returns the
> inode hosting
> +the data or an ERR_PTR(), and handle the error. Use
> d_real_metadata_inode() for
> +the inode hosting the metadata and handle its errors as well.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index fd8853622f250..fe1aa8fea0c7a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct
> dentry *dentry, enum d_real_type type
> =C2=A0		return dentry;
> =C2=A0}
> =C2=A0
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real
> inode.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry
> *dentry)
> -{
> -	/* This usage of d_real() results in const dentry */
> -	return d_inode(d_real((struct dentry *) dentry,
> D_REAL_DATA));
> -}
> -
> =C2=A0/**
> =C2=A0 * d_real_data_inode - Return the real inode hosting the data
> =C2=A0 * @dentry: The dentry to query
