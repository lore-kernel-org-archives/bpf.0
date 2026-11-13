Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564824;
	b=QrQom7v16tu6UXSmynf06epp6S8caTINZuFKGFGdzrFZlEoB3goPiyypy6pGAhd/6h8R
	 2RCcvUG+I/Lb9Gccr1r7Ti0AT/3StWYMlh5qPr9hYPm3YdIRGCKkzfT8nHDhg22mczz2P
	 VKGxqQmjWTgA1nlB2rcRVi89n9raSNz3YpyHF1r41RE3g+Uuahx+2kijiF2FAHgJwKzVE
	 3SKs5YU/lDAzfEgCMcV8rp6JwTjCondtnXyXpVpDW2BI9f5/xmtIU728QrmSf5Ej8G2uU
	 k1XpNLdAQQNMLj70PWIpahoo0PRxgogcbvY68LNTr23h1wFWDxc0Ygy4+SYGQwYfMcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=dyI+WX/nMpEbuZe2NOKzL7CJGKPkRaTQzsSaelKUh1qaBwFP6OxSoAdkxn6a5vaAipfC
	 eoyB+QJNbDacSVRZTrNDrJg4LAbzuH8owN3OLBYuuEW/sTjJJjSX02uSUNtIEIFbHmVIY
	 rQaVXr9WyLCm+AtLde6AnL/75RnWoyupUJKkeYb6oB2lhh1FZoNfwt5ozFJrqBqqv8hvP
	 f20lrQ2H/d91BTaSCOBVovE0WZDjWyirJEebnYrUn1zMMEioPh9rFC/byuU4fyzU+/sSu
	 GlYieKDXeU9+tipP/QOE4bDfqc5O0y1KA9lskB5DrbiJQHMVczSLIW/vllb3g3z17FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008D60A2611
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0008D60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso1051560a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=19xXxW1W5uwBtHoo3nIVxS195TQW6YUk6dbH1EKsvY0ba3+YKlnBLeXgl48LbCazvX
         N/k4hrHy4P1uQiWcN9rqISs7lV8In+43MxTZSMYEMVYLU5MLUqbRI1RTZ3p+9KYvsvjs
         uBUKQh74G5e1uWdHrkejFgqCGJ1OOD22KKOFU30GiWc+S8oj44bS4ObsRqi1CY1KPZcN
         xRF2kt71SZFZijvYHIMfIJQfVOLdbMtSZQgty16xaqXz3qetCsE++ra65/zGvMiL0uzd
         UIV9FBbAhgsBYgINX7Uu66jwMt82phuFGFhndwYZH3aKaHPaEANnM6lsxIk+DgFingPz
         pA+w==
X-Forwarded-Encrypted: i=1; AL+hErF51F9j2IBv/DZYPN8Tq3tZ2fMaFOv3QrQHG0rbs05EEU66gPO0KFWXGGouS410ye00qtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KNCbUUF6pwHmOjx5gJsSB21kmXfgLS3KUc6QzJCFhP9EcYaJT
	m0zbBqneO96l2RogWr/JSW4t9dcdSqRRX74FGM9hxR6PboAAWSgcofKjTlKwTyDUjREU
X-Gm-Gg: AYBFou3ZbzKZ+uW++1G5CtBBlzoYQQrxPMPIw8pe0XjgXRgZyOUA3uAbUygZ5BuUQE1
	DAyluMCQxlTUy/f1tVVms1SSXIa4Folm2TSoYLEfs3GxLH3itD4IuVN6xbHeJrJzbRV09rDm/QR
	7tKfZorPZWsXdJMr0n7eYf/Tl0jVEJo3lPJ4n0GRd98EzP0Kd3fr2D6j0SZwikWRcnQYcB+Us+R
	7DaDmv0eM/HTv7766KOdc8dWvkQJOhhh91KWjiKOdnp07a2e0PY8RE4l5hik+Cs/BrkZDBARLQ8
	bV68SVrdWfVEkq/fNRkmMzcxrswjN+B96ZRxnETO3kQAPfMkec5oMmo8Qo/7HWTAEPbjsKOoSiz
	wgx2Docrz9ynTkrKrbmq+rI05mEIpb9WVY0G70xVECJXbA7zfye0A90NfOOkI3spk9wXFy53yDc
	UlBqsvFXtT1mLiLODf60/nmI+27iQJtorWYGFyLpF2l43zo3Ew8ZhuzlBhhUnXCG6Pl1f+gfa0L
	PfryOB7dYC1afUZOHfzQwPfcfEZUFrTWD4uxQeJJDMCHw1XwAZCvxw+1tVR6sbxh3VqTziB4tk4
	YKr/ZXi0zw1tcAK3G6qBsenT6y6N9tb00PiI/XokBbmc41efbXngd7klYNo+R2+pm++ln9CDcHX
	N9lGiGEnj
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
