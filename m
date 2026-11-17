Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904089;
	b=ULHKxrs0gy3GaPLxLIvMTuzsYU5IENYJJTM5r7EAqbnCfaIuVcfyPyqYImwBhYQMrBbp
	 5/h0HN2NSjh3HB0K5mcs91jiM72mmSEJTVEucgHA0+50Q1+mWWzvUbVXZ0A3f6A5gk64G
	 s5p5sektBjcaWLiybtjGIMuLn/vvWUZPTC/i8yX6hfL992bVkXQp6P3HPucEgwozSHnHn
	 /s/6DgJFssNarhrx28gm5GANL3yqG+OYFX0PrvNPFCfQIdzMGgIID6h3R8gViCXipJ42Y
	 2UhuYXvPJdfAuuhfuY2m/uHLnrVZqG5uzzUuJqCotOD6GQIj8Sxpt3DODdW/5fWP2GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
	b=k4lSOgBq5VJSzfHpHo66VBwpiAhO7aa0JSK5oJ6DSdY4vRTL0SG4Acr9WI78PxUJfYzK
	 S9PThjuW3EwUG9/WzGtxH53hIXYVp/KvexDrBT7FS/kVrIX5i2E0HqDb7zharHNtcIAYU
	 seIIakoMYHXR7ridZL3e2BlkOPBw3QF5A+iUAtD42kHMjzBGqjQStWAp2oh0tgyERuH7T
	 I60AK4vDbmUI9E4nJrZKt5G+oSuMRpFef3aWARHv009QkKZYtKc9QGBQAcyr+o5QtTRON
	 fOUdS3pKV1wklH7XEbt4kfdsvXaHv8of6a7FELdq74Q4egLlay50vhixHfvnMTeJLhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE12606A896
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE12606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so47025635e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904086; x=1795508886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=G5kPAzk6YKyHaocuCdT5IFslrUJH5/ldhNVhV6xYWUthrOIppv7Y8kBtZdevqAkpzI
         BDRFsu2jrF+YCozPia7EV1j3KLeZC6Lnc8BgBdPYFaePytvbOESC0m4eRkryqhoEbPxE
         WM5n2Fa2IGRg+WkSIkgfyoTemIrDdEbfzZV+2Eacmamzzj+t+HuCPRqV+GPswkKxuMa/
         2fm9UdrHUV6v7jtlgmqycAcrxGUcSbURHcUFMMj9LS/XjgTFJtp8hDDDARovdS596Fjm
         xwkar34XXNuYsLWY+RNo1AZ45FE/L69efZRvwjPbSAF3CGRgr3AaMHZz6Kf/cz8pCVs/
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904086; x=1795508886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=nVqtXcOAecGDmLvfMwQP4N8KxhoGlCRPMRoi3w6bLLXtbhYFiClM+plN0TA+cfOw1Z
         IDN1qdLanf3fFz62P6+p5K9rUiIhbUHy0+opK9baCFtMnmxXI9Gi3KQPjoZtwvf0ukeE
         3KF65K8erZaaSuSINTJwJ0VYdkN/Z22RVIGgmqn1sNXvDUFz21jxBTziWPlMSOQ0NBcN
         /F2qkz7upBOCwop4Mpv/nnLPXXiO2hzEdvFmjEpDhSZ7Wz5dUsRjWfIPrXpllUrK06K2
         L3Y5ENfd6KvMidSvwig7BV3wbZSyXzCBvi9Xgdq1+mx7NvPb1va56GH+zxkYRE4KLVO1
         pZPQ==
X-Forwarded-Encrypted: i=1; AL+hErE+StCxbl0eTr527yUHt8zQUaR2cpMP15RwM1jtk+s6KaiCqLdeZ9/6rshT0XLXKB/Zuew=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YvdBZiJ4pEKtGMRvnbG7jZZyMOxNUFStNIp/wANOrmxjHwNDN
	ddSoWyk2MFrA/XYEi1C3WFP3cCvyZWM/26M79HjVsOfV6DjIfGzon2N8iahbBT9wyVfN
X-Gm-Gg: AYBFou09VlkkM2MccLs4BJ8txzGomFeyr6LguODl+Mo9Pp2x0X7It5JiJ5U7/vhTiwC
	/uMM/wFOqlwA85ImcJFjAVSZzod2lgSHgP2EOPURk+jwHUsE1W4JGS8v9sC8mjuvhxNAWQHpKcZ
	R4VpYSWBuKNtTnAkKVXCuVCxgl//Ko+EqyVZ4I/GPpw8NG1IfvDPd0m/AkQSE6LRWCJBC8eKmga
	I6HGkzbkN9gKpT6To18JMfgEaofOc2Ljuyb/py/rUi7djpcVyciFWm2hhbWelJ+76fZqzxV4RDz
	qFJQTj9tWeM0A3fvxxibTfaUR24QttbjUUf2D671C2EGUtF4C+mNy3yBqPPwQZn9g10c2ode1HV
	qQAjlf7FrY+Mc71VGfiISUljEAMKShKGf5j0nIJxJ8UqQJ52tRb93uTp5gMDv/MA/CMLdmSLIQW
	QIdeW+EqWjuh4YYwzGd0PAcqz5pcpIVOFaP5AKXTAwjpx2PiMiNEcSx9Fiz/iLfMNsaaV4LdUm2
	v2rgsLhcH13AYGHxLVNt8QO7xICcRqlB0KoUpQTEsV0Alwl6WMOUaz33Q3n2apS27SH0J5UW94M
	PG4mOO+aucToY+Fkjc6O6Q76JrEZF9g0BgwalX6QeLMgV4mGSXr4Xwyt8bPY8NaNw2ln6XI0J6E
	VVJxgkuXhuHLuZIq81OjNpDESIjTktgicfKuS6/JshtOI3oGIv/zyJBcI
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr209766355e9.19.1794904086313;
        Tue, 17 Nov 2026 00:28:06 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm74782845e9.8.2026.11.17.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:05 -0800 (PST)
Message-ID: <fa0ce0f7ecdbe91cc6773bcbe86be137d2129944.camel@amutable.com>
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chuck Lever	 <cel@kernel.org>, Chris Down
 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:04 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/nfsd/nfsctl.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf9..ce2666deddbd9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/cache.h>
> =C2=A0#include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &nfsd_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
