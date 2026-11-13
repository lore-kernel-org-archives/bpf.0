Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564140;
	b=dLITM5JMX8Dq0fNNLGit4jxqmjKh1037uVPDiflFzXWOWkbwSR/a8NB0xf/hMfQicA6v
	 YNj/SLS7DnnLo+wzuLO9T5pj47/E2Vs3EinuVMx4kH/rghbA7USiLnkjhFVOq5up+pi4S
	 Ax28KP3LAKh0ecnGdEEGaycFVS/Q40aOA3FFtX2WCVzROlFGPbsf1dFP1gqm2ZA9UUwoW
	 HDuV+S90XgQJZNrQXaqgJn1wPCJm9uQxeU9mc8YfYH4TVj1Rj9Pm9fL5EBlvTO/bf1Dcj
	 IRl+E8tTxAa7kbMJvovLMGICm1KuYR1umJNbsVyRKp+sWv3GFs9aZvZ/HC2OdvDmu+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
	b=Yt+4ehoo2dPKBU+3NVrKWo+JjJ/oLZOcEpsXr3hxcyLOgUCT5bu0wj3Lea5xwdLZyYkb
	 zSib22WLY3Kx8OT10QS9t+/aRnMEafH+Ey5f8rQAoYRzvUPHHNuQ53bSSAjP2By6vPzER
	 km+kMkwSQHmEKU8gWI++lOZHLQ939WNSvQyzND2xHYVZuzG/OBR6pHuNFt6D2sFx7Qn/G
	 t69Q6WueoPttfbOZr4zY5K1+QCGlgmpB8my6deCKlQlMQOT3ngGjEM3Q5cMczjpayJT+f
	 YhNlTXhfEVQ9T2zzNpOSgvJ0KJ/EO4BzE0v0DCDG/ya5iJZ28O4YYGjPfzhGhVVotag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mxnEK0OE;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3370606A327
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3370606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mxnEK0OE
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso1233858a12.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564138; x=1795168938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
        b=mxnEK0OEI7AZoc/CfUYBfL7b57vnPAty4yH1m7TS29a3jfzgxF6O21C+4eoAVH56Q9
         piX6TGhock7wjcI74HawyxxvBGzm9YxMDwhPO59HW6wNIzGY38ltasaZh4hFELwGRqEv
         EACaW/+rYd6+QPU5/79gIyHIHlnigPDAQAFlfCT0ngxFbKNdFkIgPJ4AQQVbJxYRU4kd
         sGda4OaUFoBKprw0qaI3K+cYJzK6vhQ24s+osuqJwxviEyFLXhcz7lQ/DUhHhDlN7iYr
         P/EQDWGz9doNbLrGEB0hB+YKjuFHlmGHIGpXLhiZ/HiYA8bpaS50WmEcn/ZjJ0UCEMyu
         vVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564138; x=1795168938;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
        b=T3CaF/hAdCXHR2bx3C5rSkEdf5gSC8qwc2ESO+eU1c3K+P+Sop5RVfmFr0naygRH9l
         fEncFuthBKehBTwDqVySgAMDtiexPOUblWq46dkQMpO+qWL2Ue2zhANuAy7f+3PwzHv2
         dxovPlU0lfF/Gh7tR/iEDqcLgkNviSMUuPf8xnLxYrLO6XMAw9E3dUtAAGlO8c/Hjvdb
         D5n1pfqpzTH0AEH8blVs91MmQtrOleq36uKOzLH4wAgpZPBcBDyOouYwFsN4LooayebO
         Bsc5wgCovfhQqNwtqerwI8MHADgr+ZGqMaZ8qXbGxMXRf0z9v2zyfseWlkWxBt52joUK
         ArCA==
X-Forwarded-Encrypted: i=1; AL+hErHSq4Fpf997bZOOQVbBoTrqKmz+vBegO1kqEgEmQ3tqprVTiZxo+DYTaZaDPikGYfvmG78=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w+z6Ci287JPdCCHXggtawb5YDiurnNKkJnLwwKeeb5NV0SiuZ
	oL/kUC9R/3AvkJrKTxjZqeDr+YtlF3NF7/v4jLabccr3RKW3jstTPe6Tp46+RUHucZwo
X-Gm-Gg: AYBFou3vA9p1K++FDI1IoG4i59MguluJMCZk1HrEQbbK8Vae5DRW+xqsPRBz96NegaQ
	tscqMzmQTCG0guLbi6886LynFKaPqwk0tCkU/94F15anH83WMioZLjaUhhH/bKdKGHjo1KBFYzi
	eyzs7X7kpvA7xEzM2kiq51HGRSxxmW+zsWngWDAnzSrryw7N0mqImLM7B7byIywglZyNi2XiMbL
	3hgfIgqJBnz5HtUK5Y8DQHvg27xIIOCLJZHZTPPDlnpq9CaygrSQptP0YDQ/5jnO10GVNOyYcmv
	zVSzGEvnlFwRVFgo/EKr4NN7gF5cnNHm6AWRdyxVSMwIECN9xMOdoQbECDSveV8dp3sQVk8gW/m
	CBwim5SHv72pSawN/6fCy8ll1DvZ78IMHwaqDQ3vcQdRKK2vHuyxDf2mGLYQCyVmqN/ptw6c29t
	vNR8v4zmQxG0kUzJr/Jv209xbrFCKzg7MGxi+gi8LMEnGXh6mw3GDaNrX7mSnZXyM98b7SOn0IE
	O7xtmiwCN3Mkuz3zYMbF0YRZQfcs8I8LgOkDTLoKOwS06vi19FZEH1nVloN6pnvuQSKeDydEk4E
	GgEmpGwA8yvGGJUYGisELARCHlXR+iN7JfC3bBO9Et1NulEUMu5YgQczF5Q/+Ic=
X-Received: by 2002:a05:6402:c4e1:10b0:6b6:eefc:ae7a with SMTP id 4fb4d7f45d1cf-6b7c088f8ecmr1236733a12.4.1794564138223;
        Fri, 13 Nov 2026 02:02:18 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23c672asm734155a12.15.2026.11.13.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:17 -0800 (PST)
Message-ID: <f4ce8239f22046e90cf4807853282a570c73707a.camel@amutable.com>
Subject: Re: [PATCH RFC 04/41] fs: add SB_I_PSEUDO
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
Date: Fri, 13 Nov 2026 11:02:15 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
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
> Currently, there's no way to tell whether the files of a filesystem
> store data or whether they are kernel interfaces. Files on pseudo
> filesystems such as procfs or sysfs generate their contents when
> they're
> read and writes to them are commands to the kernel.
>=20
> But a few places in the kernel take an arbitrary file and use it as
> storage: loop, zloop, the nvme target's file backend, the scsi
> target's
> fileio backend, fuse passthrough, the usb mass storage gadget and
> erofs
> file-backed mounts. At most they check the file type and whether the
> file implements ->read_iter() and ->write_iter(). That's not enough.
> kernfs provides both for every sysfs attribute for example.
>=20
> Add SB_I_PSEUDO so a filesystem can state that its regular files are
> kernel interfaces and must not be used as storage.
>=20
> Pseudo filesystems also never hold executables or device nodes. But
> currently each of them decides on its own whether to raise
> SB_I_NOEXEC
> and SB_I_NODEV. Some do, most don't. Add fc_init_pseudo() as the
> common
> initialization point for all pseudo filesystems that raises all three
> flags and switch init_pseudo() over to it. The following patches
> convert the mountable pseudo filesystems.
>=20
> Nothing checks SB_I_PSEUDO yet so no functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/libfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0include/linux/fs/super_types.h |=C2=A0 1 +
> =C2=A0include/linux/pseudo_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++=
+++++
> =C2=A03 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 96a6e9b1535f..8c8789489fdf 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -735,7 +735,7 @@ struct pseudo_fs_context *init_pseudo(struct
> fs_context *fc,
> =C2=A0		fc->fs_private =3D ctx;
> =C2=A0		fc->ops =3D &pseudo_fs_context_ops;
> =C2=A0		fc->sb_flags |=3D SB_NOUSER;
> -		fc->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +		fc_init_pseudo(fc);
> =C2=A0		fc->global =3D true;
> =C2=A0	}
> =C2=A0	return ctx;
> diff --git a/include/linux/fs/super_types.h
> b/include/linux/fs/super_types.h
> index 72f4288e16c5..472200bdf081 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -359,5 +359,6 @@ struct super_block {
> =C2=A0#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on
> this superblock */
> =C2=A0#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this
> superblock */
> =C2=A0#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee
> data persistence on sync */
> +#define SB_I_PSEUDO	0x00010000	/* regular files are kernel
> interfaces, not storage */
> =C2=A0
> =C2=A0#endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
> index a651e60d9410..0ca408aa60af 100644
> --- a/include/linux/pseudo_fs.h
> +++ b/include/linux/pseudo_fs.h
> @@ -2,6 +2,7 @@
> =C2=A0#define __LINUX_PSEUDO_FS__
> =C2=A0
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/fs/super_types.h>
> =C2=A0
> =C2=A0struct pseudo_fs_context {
> =C2=A0	const struct super_operations *ops;
> @@ -15,4 +16,14 @@ struct pseudo_fs_context {
> =C2=A0struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long magic);
> =C2=A0
> +/*
> + * Common initialization for all pseudo filesystems, mountable or
> not. Their
> + * regular files are kernel interfaces. They don't store data and
> pseudo
> + * filesystems never hold executables or device nodes.
> + */
> +static inline void fc_init_pseudo(struct fs_context *fc)
> +{
> +	fc->s_iflags |=3D SB_I_PSEUDO | SB_I_NOEXEC | SB_I_NODEV;
> +}
> +
> =C2=A0#endif
