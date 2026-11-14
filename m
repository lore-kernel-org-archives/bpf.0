Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794698411;
	b=yxAQdWyYFfkFND/coJmPpzNdJ6lOMGQ8PuZQtCmzeuUEN2NQ3Rjba3XWXqwNn+TGbGki
	 bZGQyYNgu45Xdvd2lZ08sPDIb3ShHREeDUcPPZ+1p42aWaLN4omN4GPgYOODYnLORQjin
	 jVeW+xglpESpka9c4YUG3ZKlyGWx17/pLmmzjrur3ZpuEW5Ud9PZ7lOjMT3FrX5Kt9DkR
	 empAj/QStfBmC0UvEJaykKC+auWrnxkQN3hCb112rzPzAGy/NlW0CaVdc3/ZfK94kmQux
	 BetH1PKhf2zFMyFVzrUePSEf7Sl0WVB6SBlB+5l82FMCzAkJ1oOwSG9LbPaXQG+aXOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	b=EOaSYgpp9HuY7fs9Olll352dnUmG8/U2JUNr9gnX4FiAjUA0cqgrtLw8iOIlFEJ9Nnu5
	 XzB8kEVj1Z8HCkInpvbRy2O9/t45TC6fJQn0Ogmvw85yvscjOXTgUr+AypZtftqpR0bSv
	 +s+x+6+dwQ5jLmUqdK0Y6s+cJpe9O3J6JGF8hE0W2hzyChIT9852zPj3iVynEql8WMM2j
	 tLmr2qX5/hQUrdt34SJvLsRBbdpT5HpSsY7q4TOFUdJufVnnH0Ie9ugiK46F7fA/yzY6N
	 oNz+8IjBfeWsJwvm5XcClDvVvSLFAZ+EmimgGXyhZsBqHPLVPLqp2+ThQvihxmR62eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A25606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 23:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A25606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so4611872a12.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=pdYU1bSoz65yMgH1C4S6s511jLpajRzvY/CwIwsrQA+hyGdXWsssBUrAthnC2jXE1U
         NGUc638AdbKYZQf6ZutJapQCMmwnmdF1ACN0o2L6ixkl5jSyQaZZ1z9LzLuFvOIeiYsX
         nX4oz/MT5mPR6x4F56OaWRyL9LyfAn40P8lCIJI0MdsTOVgr9bfpSHuGc89TT23QZDe6
         Wm7B8MpwIMTHD8Ij2Xr9+F3XIK0ToP3NVs6nWR98d7fialoD5i1JpKBlfb5vBJtkTUd7
         A8Uq+rAjyQudBaGH6SM3dHznicR0Dmm4K4j2AMdV1uIiXEIJJr7MGmhHQP4XrHkvTWRC
         lt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=+yX4TaL3+I+rBeBFSGTCqQYKkcosc9MhbWFRw+RFT1k=;
        b=NTBhp4FF7MKgTT2CfGFGz4HasJ09pn7jqKVE/VWeSjkPMyzeO/K4JOquPeQW0f7ZUX
         kBUX2oALdytuHq0L6wnBLxV5AzZRxgmCtXzsBlQZA3DxyXdfIlUARa3l5ZAWxzggaVBO
         SaF8okvVIUDg76U0ikNQHwaJJIFmQBfuSkdMca1kibt7d+yQdweNdTwz+R4GNBxfjEz9
         Aab/Jhyt5KnKvhc7HfKyPsl6OjhUX4jUmKVqRvKAK1A17RjHW94CwLj3EnxxsPMklrqN
         1oU8hAuvQhX3e2fVNuHOHY4fQg2LQMN0G8+jHGhFR8gxebbMlc2rZTDeL/CgLPW1+/L1
         uSXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=bZ4A5V+6Vs4HKIPLNbCXlaoHg6GUiZAgPE1CoHup/u8F9XnmCFMSb6naMqQFAl++mw
         +LZR0jt78s/FhrwMU+95xN0Ho10rZ/g9p6M/dfGpr9SfvlaOXM2WfiTCtO0CejnyefhK
         5gg17lDjyCI6S+pTTK/DIWzHtcTY1JHkLI4t/I/Teu6/Lgz9A0oKfkx231Ay53Fdu4Kp
         zCo0ecwmPzO3ZOIddRCFMjOjLH94BU3oXsC8cOhJgJSeLFwZkZlFyxo1cq6JVw7hHb6A
         21NW8PziNlBat7d4DfM9UgO0YIScpglsDnmQoGQNIOQhlOx3hw76q6t8+8jTPfBn24eS
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=e79Mx5BaI5dQC0UKvLrc1PHkmKL5jZ6OXvdZ5voqh7Y93fJGtAlV1rGwDGW2APYc1s
         sdmKoB0GBz+9TtrHWGKqK1NHhGFAW2VqRP3mf7pu4EWPgTT+xfYourkaLmQ66eKK8Nzd
         1iYNdx65cobohKMQGKe3lTheWq+OBU8l0XyJTMDhlPaQ6JjhJfN00v3b4O2jCajDHaMK
         6xiI6BLCAG0gYt1c+B5wk8LrGVV0W1hZSrh8yKLdeHDCcm0+irZjFO/PBLguSCDgdEdn
         y7N2I4LYwQeB5TDyYTCdNH/4Nq1aiyGZsdW1AgsrtHT7t1Vlx0Mf/GAXcwxRUFnA8lOg
         61jQ==
X-Forwarded-Encrypted: i=1; AL+hErEx/T8GGMVozga+knrZQD13EkgI1e4w8Uhx98iIgEPipwJ54ohxGrypabiM11fH2xyPqCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JYK7DTKeCISe/KbjCXzOUWl45KpOZVsm6klqMiEQj/hqESD9I
	W6/IkebLDrrIez964Q1xMjuaWXjvGm/3bbl1gorlI+HB2HjhNWx/6L/TUCbWx2dt408VLUBtrnn
	WqukL1Fn+vS1wz7Z7SjioRwTX9yco8rU=
X-Gm-Gg: AYBFou0EMn9zFvXdsqZsIm6cucpUXdU4vC59n8/yic6+o3LIQmGTS3S/Y8aK6I8ZuBg
	JNtmQDKmWfwknMkceTD37apzBBiYva4eZhh3z+3QXBB7hYU6zYKEpcSuVrq6Hbg+fC0XOdTpA+f
	dn5co5GGKzuMaBkDSVH5hHQ0uQTaxLFm6KY+FyBQC1MwwW2Y88VCggEQhCa2cLXdfAXeEjlenHF
	Nksw+Di+y14shhd7PwixJiz2LIlnL+f5k4vbvaDpPMAiJageYpuM0Dd/7HAN2ANKSncldLxBFl4
	orxQ+7+x6rNARVSStvvO7ULpZdbWKVJGvonPVrStwz1mWfR9o32Its/ChEkVOsMT2ky40SBuNAt
	0enuatIYQlGuThRtCNk9V/oa6iatElpRsXOXb3BSdoRSAtLeWpmqCx0Q9Adw0yTXZV185zw==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.
