Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564919;
	b=jtXEC84GyE3y6538C71PFJCdGtfssf6t51eD04l/2EoqKKy4s3RIXrsO48JUI+QsYzr4
	 gp83OjtiH9qu4YbXD+4IGYcVI6Zi6xzSelbrgmIqodY60Vm/WD8pqO+8sTYFHEO//Jl6N
	 pIJgLpvTJ99kqswmcL8n8uz2y/gzAvVm7E/d6Wng57p2MENGi9ozHDmb3izi3JymFdqzd
	 NWWvFQBQcfq1XJ624g9s4vZ9EFLIN+zREyrJBKXT9FyeL8YPHBoNkkgCqeSArUpw4KRo3
	 knV0K5ANvYGNSJGEN/peXCW26YMZszon0K5bEgujv9PScrz7+k15hSdeIA9G1Lou0wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
	b=iqWKBrSXA+DZuKoERfSvKSSaZClBRg2sLffKLEf9Zt4x7i6tJGbCnoALCMTQSU9fWwMI
	 39i6h+UCd+kjRNylEZT+I6UdRbNxQ+wmj97UZYAbu8VeOi+48nuaVEtBE8nW6F6tCe2GX
	 tsfz4e5iDL67Te+VgbFkrZ36NlNUQR6dzgNNfmHQMPqwEaBpLjWGviFPAQRyRcD/Iq75e
	 1aJ9gRxlk/fdG1OSYuWp47oAyvIZYhVdOKM+bpAs4Xw53Pdujdu86xVqcRkzigbGH93Vd
	 sKcar44kQo7nDrK1W5Wbj8CBiWgC2b+u26h6yAFa216PpUvFTR01FCs/AD4jsYcTksw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XokUN4uh;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774A606A8A8
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9774A606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XokUN4uh
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so3785125e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564917; x=1795169717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=XokUN4uhZ5cnIDNPS9kLjfaPp8ZSmyDY7nHz3ffF9uftFGQzzc0NaUd0CPxl6tmm/G
         EB2bqVZrrrQULKzHfxmMlarOF7+NP4G1EuGLp1x7hwkFzcf5DKQIlYH5+zTWTg0qLXK8
         Q27+pu7matN83z4kFimCCYFY9EtcVBpSYh+f+WbPWczzC82gi2dU1+IxENiNgIvD4ssI
         1POQJndyP8zOY9I/drEtHc8Rir/wcokVwFCL8xkdsULqRcKqvw/m2pftg5e6OYSufYMA
         FPm06vn59Z5lYx4UA2FpKr0UjB0BBdejlJLIE+RKFWt9/d0/clXrD3SuYpmwDbHdW+74
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564917; x=1795169717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=JX0mHrxsrfWBNR7z6r1K9/tTi6+4tqMx72W5foUD3Wil6hkrzjA2V6+pqwvEis72h3
         L7cdLPT1RTlnhwjLjHWSzDmM02g2uqoxPelgElZf7/hf9yd/raild+GO9cJAS+3l3qXw
         I2FmUrCPAFXRmIjaIgs4/P3SkgkVqmIq5IKQA69aAvgFhveDw/yBdxSuWoWKvt9NviNy
         EQ5Lh6oKgGh+AHvlAgjku/nRqLphBuDu1v23eMwlIR1kEq54B7lxqZlktMghHnEHB9oW
         d9s7kWfKV/lkaTNxb8dLHJ5MxKC4PE/gPnoMmN910qVnwi6/xhWN2ooipLKpgI6urudS
         UCyw==
X-Forwarded-Encrypted: i=1; AL+hErEYgmRnU7RF2NL8LP8l+ejjITlnM4MZ4c9Yafz2YL4+vKypEaO00EpOtDmHCvtE7cAE83o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HPstWLC0ymeSvXq1V6I6uSv7YmefRU6qI7lVPaaVtT0dROUOk
	RaWt0tTkTWtfuWBGrcAbW5sOEC+YaC0zscLJc7W1gDH4ay3+ik2l9Lv9CiiJwLkHKJ0R
X-Gm-Gg: AYBFou2n78MZ0oodV7Mex0iY86yCzXK5PXLXL3lqRcKevEnHaz5e92T9YhPhJ9G7gnQ
	1p3OgNMfCROBI5HgT4sjepNZwZ9SCGcHP4rAxjeGtikKVLi/D9B/y372ogQazAsMrtV46U3iAJm
	sCh0lVd9GsAplA50HkCxkXXArVoo13ZsL7a3rii9XbHGOx6BmCNMkNh9gE9L24BVEK0pDykHzOa
	ONn2qsq4GdGNEPG1AK2od95GcCXRSt/27mIMwmnjA4e8mIIlH6a33jvo1+MJ9qnse1y0r29QVwS
	/Yl0TsahZAzaMdnThy8dTD7MHIla/N7+dCm6f0f9eXJbT61BZghVNsMmljbwyDyxwdSer9pC5s2
	plwZp/IwEfW5U4VzKRsloGZ0fh/HuJoKdbK7eV0b5kxRvsnD14+0sT0lGcq5m+GbF6dnRKwDGbL
	Yp9TfNANChKWDL/s2KiTHQfbbKlYQyp8pcoEd8psaeQjBCAw2on+dl/USz2ukfNTy/zpR5O/3IT
	toqGCY81rKmhq9TVBdjxF36qNlKk5xEYPdcfvq2n+RWG2NqZAtru5d4/4IHYrxaHB7U+03R8C3Q
	iYbv0qWC5hdgjWhd50ki28WMHmfMAbDmz9gnFqYMdOvdamUotk46uA7Orikcsuc=
X-Received: by 2002:a05:600c:4f84:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb5599ade1mr43492835e9.0.1794564916955;
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm31982365e9.0.2026.11.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Message-ID: <e2edfa06d185acd86b46945622b6eb6dff97b307.camel@amutable.com>
Subject: Re: [PATCH RFC 33/41] fs: add file_is_pseudo()
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
Date: Fri, 13 Nov 2026 11:15:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
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
> Add a helper to check whether a file is a regular file on a pseudo
> filesystem. Only regular files count. Device nodes on pseudo
> filesystems
> such as devpts, binderfs or the block devices on bdevfs are what they
> are.
>=20
> Look at the inode that actually provides the data via d_real_inode().
> overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
> securityfs as lower layers and reads of such an overlayfs file are
> served by the file on the pseudo filesystem. Checking the overlayfs
> inode would miss that.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0include/linux/fs.h | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..407ffb6342ec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2553,6 +2553,18 @@ static inline const struct inode
> *file_user_inode(const struct file *f)
> =C2=A0	return file_inode(f);
> =C2=A0}
> =C2=A0
> +/*
> + * Regular files on pseudo filesystems are kernel interfaces and
> must not be
> + * used as storage. Look through stacking filesystems at the inode
> that
> + * provides the data.
> + */
> +static inline bool file_is_pseudo(const struct file *file)
> +{
> +	const struct inode *inode =3D d_real_inode(file-
> >f_path.dentry);
> +
> +	return S_ISREG(inode->i_mode) && (inode->i_sb->s_iflags &
> SB_I_PSEUDO);
> +}
> +
> =C2=A0static inline struct file *file_clone_open(struct file *file)
> =C2=A0{
> =C2=A0	return dentry_open(&file->f_path, file->f_flags, file-
> >f_cred);
