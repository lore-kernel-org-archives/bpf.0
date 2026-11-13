Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564223;
	b=zUfKG2bf6Bva+pOAtbYwozUza3edYupcZQSqC1Cus6iO8peRpg6NkRWO+6mXnuCrkWSz
	 oTtd5fUMuD4P5mstleCIBCyakhQFqaGVG3NZmWEKR/HkkfOE92bMaS+ROApAOfhuT7OAN
	 D7FuMhDp41/cQhjhWMWq0M2s0WgCqM4ySBtk6IpWMKOThg7Ei1gBZPKM7lwqvmVpRXWC8
	 gL95GQfs1ghxHrHk1SZoULOzax4GBx952+35v0VEmAFRwcy1807lR1YxYecrdI02dCkQ1
	 rYMRqXjO4dNjURPhkxzYKQKSS2onNIy0nhYablzi5IlwBc1i369kFFbLNr2reDgrHsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	b=fT3XPd5HKM1xVZdc/NPUxnH+rqMRo9bwz2HJz/ZJN0MtyaHUzqkNwDeehJeSRfYV/E+6
	 vC6dfBwG/Hvcq08WaoOMkGZYtV1+mC9d3FPEHriyxYz5gKGqDNBF/+pXxRmqlPe0P6vI8
	 zAS5g84NjZh2Ex23IKguEGeM9jCFzEcNaFRhtlohwAn1KNITBwSs1s4nfJDARR/xIx/rC
	 DmXxqpW32inAJGjSj7FgfiVJLe5LnjOqt9bIKnpa9pzab7VXdA0/mwpB9iItM1cCMLLBi
	 csZlKrpxfDr7zEmNn367kGfvgROwbmB6ZGcPLS/6Ol90tO4PF/ice7m23bYgBm56adA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="YppAuU/f";
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C560A262A
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63C560A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YppAuU/f
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so1442635a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=YppAuU/f77eWMTZ8F/Y/RTjltBDd6igz4EttMolmckndL9mvAt3euwqVCnUFPcnj1L
         wpVFClVgg0YlcE6bTABHQT1NnQyujG09t70SZ+IGoHQq0qQgGGwB+4JQikI2kaQwvi8W
         H3KupRONVF9kXu90kRN/xwbfNoANJajav9pnhnb3IMIJ4A6DWEq+8017kOKRrUT+YN/m
         jRUDmGHXRq1c+43Y1O2K5XEGEQl+nQ8YkAZ+/5vrEItOhIamTuHGEOkZUAeGsE8baOwB
         Dj4haSBpRwT/bMXANPqkevI0ogqYaGkZDRE/CPrkXlmZ9T16K5sayD5Snik8DtXgYcT5
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=R3z/hflPvDneVPJFkjwAJWVc1lXMjozUNqsp5fg77Qodoi35rVRk8sLxHI2FADSFtA
         9Zuj3VffY+pVVQQ+APxDjd9VAFgU96CzztNQ3dTfXZ5/LGwwlQ/BBa8eb92vIytYt36a
         F9qVOKqdYVdcSrnQctwsXGEHqzIcWybGtSDF5A7aUlmi3dfLWwlpAO4LFJ3Y70VMFHF7
         E0Zu8WUvf0U95ppj+h85/MY3j4sfNke83+amz19MUFoAKzq5ln0q6wohw5noe27Fg4tu
         6L3Foq6nrjLOQsKwii2ngVTxHKcH/Vb5H6SHOru8tbwnxvVhLz8QPT5BYqYzEmwarzGt
         Nrhg==
X-Forwarded-Encrypted: i=1; AL+hErHgapobKVOcR4L1LEx3NVtSgvFhbOpHgwECIi02zifnQklre7/4TJK0mD7dAzYWnTI/v9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m1NhLWS75a/RQdkIwKZXkb4WcKPOelomymhz9wA6PsX4/2t8P
	HHyy1r7L4jNDyRINytJzbFTvUgl4boscs7vA0oZrSFA2e8xwPQG4pc687B/Cbhw/6hpP
X-Gm-Gg: AYBFou1yDerjkMR40MAeUcvCuk/rrjdAClazba3N0cjEX2TyOTcHNNZ8eFEt45OMRdK
	+qU4lP7/tBbQQbEYb0yGHV7f7DMm7bczkbsBl4S3Su39wkARXY2S5HAegqiFaWjnsMzrLdAxt2E
	hzQYY7ulkrGCSUca85ErTP5SnenFJm/tuCU6ZawRpV4oHsKfcj1bB05HALfbtHJOvDHIG2SMpdT
	Nh0hfg/pxSluKu/K+mZKWh1k/OhKFIBpucbwTLCJR6AldzPijbtEFVSau/UEe7mhsehC4bMH9fW
	tqsSurJJCmmxvizdRPDixgHc2U65IX0+NPpy1C0BG4hhV8tAl1Rmwc9yhapbVfAnSIIOrvbYBGL
	x8n09baNJehAVI7RHNJnIk9DctmNo/+V0L8CkAEcLOjQAmPFELXAkOy58WaY4pBdxelAOB0zWRI
	f254UEbWnqBSobAidMA4YcS6Fh2+HEG3xnLfdIKBE7krI5ua8Kg2irokIsSilSB711RyVoald8L
	hNk7Zwg1sL9oAOU5bNMa5B2k+MQEA20yRHTMj3H5aJdgfJLnkldQWtBr5U55BQ99YZXG2iovkXH
	M3kyfCL/r/33zFsrd6hUM4pe8FDqf5pvxB1etWRKY6jozGHhjx90Ln4Ue+WAkE0=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}
