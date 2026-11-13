Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564378;
	b=uywl3WPRLqQWzIjh+Etka7Xf7YYg88mSdgnVGxhqOAajlPL6rX5Hj035M9FAyKVVu7x8
	 Az2bSD75YrHAt0BGGmlh9YWXKumImHcTlP8OWpXz2Clfa73ApFRbG1SwtW1/AoHy9q+yD
	 Cf4jRtNCFpAQ4TedPnfi1e0SNFlSeXTyYW3x0/pE4MUppwlvJl64vbOORCdgVAfYUZ2lV
	 xC6JOhOVcqwKg/NbzhdZtxwKaUeCcr3wAwCaZLiEBgrgRne69bIaxdqueBu7ivUq0j4nA
	 viLpSKdO6EaaUCF8EDpxHSH/Drmtf4l+0yucZCgFBkxZitSd5FY0H0uTod0eUMtpSEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
	b=rHSwRO0SAFDLDbYXF/s4xWZ21GIHqmUXJ0ycqnV6uny5qap9+SooT0oZr5Hhv/U1+3dC
	 w5ntZHlkQVOaVgAOkPlL4CYyuFKS1O/Y+OeB4KpZv3wfvkbyOiXE1u0NqAd4UhURy26LB
	 RzdpQgokKNB31mRJX39Sk3332p/dFBlX61g3XaETTq/Akr7TeWppfBHX4uo19YFhWOn8z
	 Mh1/zml3zspbPY8wRKbilAnO7/+FPpzuAYxnhccWi/U0CgPS3vFyzHybW3YxOV6aLyWik
	 SkyagLJ+Ri5jm+2asmhIfj1qJz+831CkTsvflNCDP8QXvd/WZSskzpozEdm7CO1QaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00F606A338
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC00F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso1517181a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564376; x=1795169176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=WDdVkHgloKbBDmiudlEZ3ZWe+zg0BVZ0Jxwgdy+X6nc8ZJ9FIVi7F/SYJVqBRxNf3G
         3Gnq29xgDZdSKYiYaDVmU8W0xCuGm4Eu82rb/A8U6D5iLEOgHTmlDog4vSfdCU82B9rm
         qMGycG7Kl4j8h61zt+kqUkohzwqy0DPARMdjq2hKw51hdb6jylA1cwqwSD8nreSBsEB9
         DkDXk5ueYK99P4pH+jY8EwMoZnNW6BehoecLG+1JSq6wWJXsZMYgAdKGybKKFJkxuO0p
         O8Ri4u2My3QdIqEe8fwKAquZP0382+IuLTCd4KpBNa7znuGAHwPb5rxafjOggGTtG7Td
         r9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564376; x=1795169176;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=VRm3jYUz5gOoaOVUZCLgcKZbVnOeu2/o+er4GIPFd3baktIktOl7H9zXzRRQE4hlyy
         6UUMwZQPQ5SWwTUcyj2mOpNFpcpLL/IDghV2cbD8InaGyV6OGGHG6DTjaV9gHpSHiBOE
         V29mJdm1GyQrgUO3BhxihziEUu6Tqd0P+EbDaE8dPVOxQC5lU8jvtnPBpjdhUs3o8xoB
         F3336zwpPnEnw2V+ygzYk1RMgA6IBsJvGbJjdmApjgtrIuddS70uviR8mj9JNEaMSbPx
         OIcYQ9691W2jlkzC5i9ihVrm49wWJlmHdvkLwIi5GNVlCOxEPrth7tkxzKJ7KA3pbl1K
         X2Nw==
X-Forwarded-Encrypted: i=1; AL+hErECxw9DcEy+AxtMO40l7rYnnVeXVlv31A86OCvz4ddF9QKYRnzF0u3JVCZa+kJRSu15vXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aG+CgMgWQWIC68LHlIURexzun/dlKZa8FlWUpubQf1lu8PZYY
	Zpec4gjXaoqwbnbGftFFi+xJW3mUS8xpixysPB1vsAGek5sBK4XeE2vuP3uuSWnw3grt
X-Gm-Gg: AYBFou283Sk235E/rqOGgsFVJFvw0v053dJVCUc1Kds+EYOZ2eCxI0lbQ9p6+BNlq2N
	LLyG7de8VpJnwK0CH1jj0tJYDP4qlwxfCmMoYB7SCfkHfMRKylnttG098ZACPUA/ZG7/ecwxTcW
	Yp8XwSn2zD6VD4H3irz2482L19zdYWSMH69vKPFAbeV2tRDBs3a6DwqpMV4OgPem6mW3T3q0XSf
	Kkp3gMGX5P1ptq2MIXi3vTY6yrJt12bJXmWhFGB27qW81Rr2ug7542jlJ0AO5ch6eJ0ZxR5Yy79
	y75F/PLekszjFPGZIPrtLEYntuas09rH4XT30Z7R9iDoovEWgCoug+//8aRsxIix3MWIHsWTd8Y
	piV99M5xPB7LeCAif83wcVkrg37BAJC9mu4rRWRNDvw8XA1CySLViOGNK3Qt/YoWKrFOTBPq0pv
	kiv6mgQQ8NK7I5IoMkojMbcX2CEUH/IZRvYnk0zl6bp/56zgCsHYwZ8KgEUIVFeme6BPY22uA8f
	ayt+/XRBjmggC0uHLkbHcRDC/rwAbwsS8IKWIq5CnA0KFSoHnsEPZ4X4IhT6T0TL4dtkzLdFtOu
	kbjj4U9v13KOkH+o0UFluvZGuEFZ6FmatcgEod3FdK86KRvJGb5d2SiOgZmdMmw=
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr1685420a12.20.1794564376161;
        Fri, 13 Nov 2026 02:06:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm706711a12.4.2026.11.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:15 -0800 (PST)
Message-ID: <4dfa19dd41ec1a202182284d9617926a259288a7.camel@amutable.com>
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:06:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
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
> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/configfs/mount.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index d8cac1cbf3bd..60ba24e7ae2b 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> @@ -106,6 +107,7 @@ static const struct fs_context_operations
> configfs_context_ops =3D {
> =C2=A0
> =C2=A0static int configfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &configfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
