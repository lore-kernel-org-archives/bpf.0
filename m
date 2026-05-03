Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A11A681B
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840007; cv=none; b=dSMvO022knPY4t1DKFkZcvLWpXZqoJ1QeNP5wUsxR8KKblYpiqMt74HVZk4yNJdBmQG0SGqkuYww/kltDvxx0JO2fT7cxofLxzsPeNdFbcB0hP34PMpZsb+oYyjSVWmxNHgs4XWVq1d9xcIRRCMbnDqAfXkEIABPRUVZMADNc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840007; c=relaxed/simple;
	bh=4GPDdW/kb/p8IO34Aom5AWXZLvd5QY5mtKP75wRGpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYy2CXczTZNTPAe6eUp5UDQ30VEtO3nGFlPyMGyet/LzLQ97E2L86Xl1ZmVCA8apgKSYt5b4zb2UMUFfke8uDMfKJjQGvIY260x8IsbMuVctVmRLVXkWhcDMq7zp4KIWb8TEPNNS/7IwncXguvKRyAw9UcikiXbBtUW+DNldA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gr42/4Sq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gr42/4Sq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso5601521a12.1
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777840004; x=1778444804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQRL4REtOh0BkmxGM6AmGpKUqhTH6/K+b8aIEMQPDzk=;
        b=gr42/4Sqzemo8D7/LPKdNBGcWKW1hXg9rd+EfVEiqv/VVtZRd8ni58EHeyxjSysIxZ
         w1chEZm5Q/khZVoKJ+LA6DxAFBJ54wgy0hiHIOHGtlU3vxlOoEVt/3ksKxwCMoaNXqpJ
         zpNiGHrH1Kc0x2wTeZbeQIwfo0KvVfLElPzP83Mlu7heqetb1FHW3e6wxXJe8HCP867W
         rAde+iOh+S0NpXmM3/Ti+2RnmE3+WxpPbQc20yO+yoQkp5I0FkqX0UngvjsbnPDqYVcX
         kXvz3RGTxFrtFi79xkK9ouYJeptTGytR2hnrx9fWnW53VQIPlXj4chlnz9hm3uyKwV0v
         X4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777840004; x=1778444804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQRL4REtOh0BkmxGM6AmGpKUqhTH6/K+b8aIEMQPDzk=;
        b=GAWP2ure2Nya+5yU7QFHa+uRioWxD/3gEfovp9n4kQ+8Wg+i4xoP/wLa3pLJOSgrBp
         Z2hPSnGvrpxZ8eVYEjqqVY7kJuQxWkpD8fo9jUbnUwt7wXZh/Nkk0Z5IgN6UZvbbyVC8
         pmtNYzkP5A+3t6ptKCZo+7vXbHaxwNaSizRqnsSSjy8GHrWRJj3ofu80gFM8C9Lnoz1O
         1IIWRUMpXEwraOzHZAcv23+fjcgNKHPByZGKeE8qhjIUxd2+OILtEBxzWZVclMIqHvb+
         94SRovzMgzizk0uNeLT6hEpoZJOKK3/+xIuBTNyTxsIKyjJorqsTvqvHj7WpiMS1W7xf
         YY2g==
X-Gm-Message-State: AOJu0YwzWcOx/6Yq81aowM8QucaGq3IDxdjlyBDWjocUcXEdOrc1WR8+
	lFSWRIFhlHxPiUqIIag4I6ykuagFTuda0dza0T7bce0iwojP8ahTE6rMJyt0JZZn8Q==
X-Gm-Gg: AeBDieuO6W0Ke4rA6jx3X/HIT4mYjP5TzpbXglHuIQoD+2egRLVyMhgysDACnWPMkHu
	SaTfciL0Otf96NzUtLFSfH13ccXqR1sneftSjZ1jJfQMmJLtoSW4iTOglR5Hrg3WqdjnhgV5HzQ
	NdfoDaBsBNofvMvq/TXdhiVH1Eow4ikqShsGbHdCuvEH+l+MkqK1hBU2fPC0r3RoZvJeernJlAN
	eWui7vQEbDCt78f6l2LqziAOvriYwGRgDyy9UaMYbmU8Xhwyny/9zm8DiQeEyDYa0+kEUY9o89t
	SuQQ6cuOx5zgPvxdEDIn49ePQhSfLmKNiJKBn+D/v+0RKE4Usb5dMZPiDaFDaeoWQ9FOLPPA2bb
	WBnywXy5PY98uU3DPSdTRkhVVwLDL5pFwCi+pOcGjYyORsttN8IfU50l9Xylzm6AFDLZOEvHjQ8
	+1uLcL7QIeYXUSIkQWcNU4UXl3Jcp8cMatyNx4vP2qERvbO6TrFEsCXOz47atYZ0mFF0Gks6FrL
	/LQg9ShYHX+obY=
X-Received: by 2002:a05:6402:a0d4:b0:670:6b0f:f77f with SMTP id 4fb4d7f45d1cf-67c1ababf30mr2394719a12.17.1777840003434;
        Sun, 03 May 2026 13:26:43 -0700 (PDT)
Received: from google.com (5.180.204.35.bc.googleusercontent.com. [35.204.180.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292adsm2778252a12.6.2026.05.03.13.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:26:42 -0700 (PDT)
Date: Sun, 3 May 2026 20:26:38 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	2022090917019@std.uestc.edu.cn, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2] bpf: fix crash in
 bpf_[set|remove]_dentry_xattr for negative dentries
Message-ID: <afevfk3BfkSjT0ec@google.com>
References: <20260430073836.2894001-1-mattbobrowski@google.com>
 <68b132c306faed4b808eee7f6929c0286fae1171538412df75e0666db64640cb@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b132c306faed4b808eee7f6929c0286fae1171538412df75e0666db64640cb@mail.kernel.org>

On Thu, Apr 30, 2026 at 08:14:07AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 9d27be058494..8642a754b37d 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> 
> [ ... ]
> 
> > @@ -289,6 +289,9 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
> >  	struct inode *inode = d_inode(dentry);
> >  	int ret;
> >
> > +	if (!inode)
> > +		return -EINVAL;
> > +
> >  	inode_lock(inode);
> >  	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
> 
> An earlier review comment from sashiko-bot raised concerns about the
> BPF verifier's unconditional rewriting of bpf_set_dentry_xattr() calls
> to bpf_set_dentry_xattr_locked() in LSM hooks that already hold inode
> locks.
> 
> The concern is that the verifier doesn't check whether the dentry
> argument provided to the kfunc is the specific context argument that
> the VFS already locked. Could a BPF program obtain a trusted pointer to
> an unrelated, unlocked dentry and pass it to the kfunc, causing the
> substituted _locked variant to execute __vfs_setxattr() without
> acquiring the proper VFS locks?
> 
> This concern was acknowledged as valid and worth reviewing separately,
> but remains unaddressed in v2.
> 
> Reference: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/
> 
> [ ... ]
> 
> In bpf_set_dentry_xattr_locked():
> 
> >  	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name__str,
> >  			     value, value_len, flags);
> >  	if (!ret) {
> 
> An earlier review comment from sashiko-bot pointed out that the
> standard setxattr system call sanitizes inputs in setxattr_copy(),
> rejecting sizes larger than XATTR_SIZE_MAX and masking flags.
> 
> Since bpf_set_dentry_xattr() and its _locked variant directly invoke
> __vfs_setxattr(), a BPF program can supply arbitrary unvalidated flags
> and massive values up to 4GB.
> 
> Could this bypass lead to huge allocations, integer overflows, or
> out-of-bounds accesses in drivers that assume VFS-enforced bounds?
> 
> This concern was acknowledged as valid and to be addressed in a
> follow-up patch, but remains unaddressed in v2.
> 
> Reference: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/

Yeah, I think this is a legitimate concern and we should be abiding
whatever the VFS enforces with regards to xattr name/value length
related limitations. I've addressed this within a separate follow up
patch series here:

* https://lore.kernel.org/bpf/20260503200819.1530328-1-mattbobrowski@google.com/T/#t

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25153819489

