Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839A322768
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533779; cv=none; b=N4O3PZSqI8OFekAGvUCA6D88x1WePOyx/KqQTItekHSXHsDtcQxhD9WX5LCvlVyaxizlE3F2S2WRq6FBx3p4sM3se/k20UmObJrpkoqkfS8qLzfWUX7F+uX1gMJIpKV6TW8lq++LCcMZjhiW3Sj7fKpigm+rBEzlKYRW1iy5sFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533779; c=relaxed/simple;
	bh=+IWkKAkXV84a6l7FgFmgeCWP8H8DV7Tk1DD5krGrjgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC6FKSimnRyDbKv9ylbY6QjOWIH+Yk3wsUn2TrKWw17EcYg9wQ+k3nZaLJ7y7lS/+lgA6W8oDPFba0d66sETQEHu7r84Oq4T0msKd+c3aCWPu9z1eh32XaL31P0Tg36n27QB2cxUHSsTDxqT10KLVXlxf4/qQX3uNB/vkv+DJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAHWdzdy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAHWdzdy"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bb662d56b5aso100519766b.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777533776; x=1778138576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jSug2YRE1SrykhAI0zwsGiM0QCuGCDO5eNghgh5RXQI=;
        b=sAHWdzdyg2tjt7rFarsc5ROM6jxvdm3hdA1Zp7atOfbRJ8aqtlyAdzgV0OaCFjT2dM
         gxPqyhqxYvsYE3M06jkUSlKMgBTjKQ7yw8PyX06rtqqUwMGalX71Tb3y54Yhgf6rNOwT
         oZ4xYvT/s7loV/+QQE/VTKKXKTdRERSX/ssRThGC+FWtb7PsJRdcXhatzOKPziAkBae4
         TC0VWbjbGfjkbeyZ3zKfeS8ASAoCE3EOqNzj3Lk/dXMC6yXXyZ/ACVA4PzEj5ffMOw9Y
         keZI920FgZk49g7e5YYbThOoCCYLfauKXyhq0eYTcUrLaFr/rMubbNX8R/DwqMbdaE17
         bL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533776; x=1778138576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSug2YRE1SrykhAI0zwsGiM0QCuGCDO5eNghgh5RXQI=;
        b=b+mKN8dVDnH0Pms6UztUbfJ3f2dbUWhIfvDAjfHUXVACJMBBNv63ftikwTfZO7Qxe0
         S/amTCxUuzJOvOSGaZuYFD0a2vn1ioP4Z6JPUO2HxggANXGM8hHpYMQchaHQZG7Oi+5C
         OmiqV5mBs40TyRYFY7i+Pj1Z4yqo8JLVInnQ7ktLZOhg29WCi1uH/hXTjMhGyv8A12Ng
         TE43iWldtec4fVs2WRNTBzu18m+OyHZJGqqtccCshlVsJll3I4W/4qMJ5v0HrI2Yy3L3
         Lfcj2yMDg1bRnpkjl1n5X5WkhLIUKP1SFofP18Cnk8c2wQKfYmHnUqoRFg64x62X0js1
         bBrA==
X-Gm-Message-State: AOJu0YxgVggMgXuFhvH8ZNtwwMGuKMBPyUUygdbmfOf+aH2I0HjjHkAl
	otiH1ymwEGmd5a3NvCA9aFjKyJnZEat1azXUOlEo0Io6o7BtXHQE8uv3nHGu2CSKI5bskNLBzwQ
	4uhrrzA==
X-Gm-Gg: AeBDievs6wRzzpZvpaX+kQ35AAhsxjfWOfdxDq6yFSs9Jda4mRYKy729uM+VRhGK1X1
	DbKKyZ4EWYBYD4unG25MWK54YqKIRA32qIn5x8hHbSJDTDHskhNzL5Te/1Gj+d/3C1xdLkoLCFd
	Oc3RE8kUz2VkjXEUd5/rDnJ+2Nik9J8fk7vEy7kHuQiKWW10spkyJPkCMchqM0SdDR/R0pu85LJ
	XQpK7mwOZgUgDsRO83xKZ9ZGNeYdRqZ7G5ojPjXl38dAv52J/GoEYR8A2UrtfZGEo4cZQKEH7gl
	m+DOyQx8kUPv8riCGEYV4NRnIabMq65AY2Wv4tyToSmfz+2ixR1El+iPMyV/X4QdDV7zPLFTBbM
	XXn7CCztvCCUf5fcRQn8ZoU814Hf9XT9VGGxuEMhall+CCP9pOdpJnykQ6uftIpWyxMWW4ZCj8A
	x495dQs32rFJHxW2Jg2UCeahBHvH44rDSsIiIw3jsnjIK7EM4UT4VEKxGlPGm1G6ig3VHE89oTS
	pHqVZgavl9H
X-Received: by 2002:a17:907:9494:b0:ba3:a8ef:67d8 with SMTP id a640c23a62f3a-bbb8891bd41mr65661466b.2.1777533775878;
        Thu, 30 Apr 2026 00:22:55 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6fcbbsm192952466b.3.2026.04.30.00.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:22:55 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:22:51 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: fix crash in bpf_[set|remove]_dentry_xattr
 for negative dentries
Message-ID: <afMDSyrki9A1TzVK@google.com>
References: <20260429205438.2601592-1-mattbobrowski@google.com>
 <20260429221005.6D1C6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429221005.6D1C6C19425@smtp.kernel.org>

On Wed, Apr 29, 2026 at 10:10:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Incomplete Fix: Negative dentries still trigger WARN_ON splats in bpf_get_dentry_xattr and _locked variants
> - [High] BPF verifier blindly substitutes locked kfuncs, allowing arbitrary VFS lock bypass
> - [High] Missing VFS parameter sanitization allows out-of-bounds xattr sizes and arbitrary flags
> --
> 
> commit 07ec989f2fe3141fcb87e29833232a3f0591690d
> Author: Matt Bobrowski <mattbobrowski@google.com>
> 
> bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries
> 
> This commit adds a NULL check for the inode in bpf_set_dentry_xattr() and
> bpf_remove_dentry_xattr() to prevent a NULL pointer dereference when a
> negative dentry is passed. If the inode is NULL, the functions now return
> -EINVAL instead of attempting to lock it.
> 
> Closes: https://lore.kernel.org/bpf/1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn/
> 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 9d27be058494..a0d58d5e3022 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -289,6 +289,9 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
> >  	struct inode *inode = d_inode(dentry);
> >  	int ret;
> >  
> > +	if (!inode)
> > +		return -EINVAL;
> 
> Are similar checks needed for bpf_get_dentry_xattr() and the _locked variants
> (bpf_set_dentry_xattr_locked() and bpf_remove_dentry_xattr_locked())?
> 
> If a negative dentry is passed to those functions, they will extract a NULL
> inode and pass it to bpf_xattr_write_permission() or
> bpf_xattr_read_permission(), which will trigger a WARN_ON(!inode) splat:
> 
> fs/bpf_fs_kfuncs.c:bpf_set_dentry_xattr_locked() {
> 	...
> 	struct inode *inode = d_inode(dentry);
> 	...
> 	ret = bpf_xattr_write_permission(name__str, inode);
> 	...
> }
> 
> Could a user-controlled BPF program intentionally pass a negative dentry to
> trigger this warning, causing a denial of service on systems with
> panic_on_warn enabled?

Yes, dropping the WARN_ON(!inode) makes sense to me. By definition,
attempting to set an extended attribute on a negative dentry is
considered as an invalid operation, so it should be handled
gracefully.

> > +
> >  	inode_lock(inode);
> >  	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
> 
> This isn't a regression from this patch, but does the BPF verifier safely
> handle the substitution of these locked kfuncs?
> 
> If a program is attached to an LSM hook that holds an inode lock, the
> verifier unconditionally rewrites calls to bpf_set_dentry_xattr() to
> bpf_set_dentry_xattr_locked(). The verifier doesn't check if the dentry
> argument provided to the kfunc is the specific context argument that the
> VFS already locked.
> 
> Can a BPF program obtain a trusted pointer to an unrelated, unlocked dentry
> and pass it to the kfunc, causing the substituted _locked variant to execute
> __vfs_setxattr() without acquiring the proper VFS locks?

Probably a valid concern and the current approach does seem a little
fragile. This too should be reviewed in further depth separately
though.

> Additionally, do these kfuncs bypass necessary VFS parameter sanitization?
> 
> The standard setxattr system call sanitizes inputs in setxattr_copy(),
> rejecting sizes larger than XATTR_SIZE_MAX and masking flags. Since
> bpf_set_dentry_xattr() and its _locked variant directly invoke __vfs_setxattr(),
> a BPF program can supply arbitrary unvalidated flags and massive values up
> to 4GB.
> 
> Could this bypass lead to huge allocations, integer overflows, or
> out-of-bounds accesses in drivers that assume VFS-enforced bounds?

I believe this is a valid concern and should be addressed separately
in a follow up patch. Thank you for bringing this to our attention.

> >  	inode_unlock(inode);
> >  	return ret;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260429205438.2601592-1-mattbobrowski@google.com?part=1
