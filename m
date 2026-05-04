Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9703A5E62
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891185; cv=none; b=eqU6nB2cece1Zf9v4JX4sIqe6MvAI8+5LriA3wsdbg1VZnUgJ8Jj2DJaizMsyhEEM1Rpgxn3bwV1uPFqBsAt2T/hE2Ym5YULASDCUPuMj7KQwK2f5DuJNMbsi7axGBYf2Vxd4mNRqceyYIpf6ZDquyJiDssoY7AY5xtNAhLpEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891185; c=relaxed/simple;
	bh=HiTErpuqFVSslF098bJ8btSDZbP0y9XQfoTQqUphJ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpv9c3hzN/0X7hPkM3zZIpc5zwqOYVJt8zhyQF0d+h1nA5CwcmXB5dvwgCNMdXwHyUIohuigoTC8AgluzYrumYapGLcI1TfMVm5ONjto76XGDTK4AjGrzMI+1I+TSFfz1zJTVJq8rXYD0RSjSYm+tBY9ZOENGVxD555xI6Di4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYdUrHzb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYdUrHzb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso6124330a12.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777891182; x=1778495982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX1d5M5RvOYvFUvKAGcNOcL7WzsNE4biHw6Lj8CwwOw=;
        b=nYdUrHzb4aooM/p2bFCOVcFEokBCaMiNCk++WxeMxy0JOf8CZqxlZu3GMI3X/VsK2C
         DOW16RgKonh6BXVaPxE8ZbJf6HxJxfHS4xps+sEPxa//ofVIvnNxE6dQxYqQeBqdADw3
         LILshf957ZqpEnMETbpLHOAoTUilZCQ8Vum06cNbRC+oUt7Sc8OEqqiXSBGDXHm+WJk7
         RT+J9lbiY1vRklKhWV1Cr2gWpOiQo3kaXCKBYfF203XzEzCLvhu5Gy8k48sHfvfNavnZ
         b/oc4i460NdeWnRcZhZF4w7FqXIv9Hkem5UR/oCL3eVOtdGeZHJ9JZHXvLJSNu2zPyyH
         Z95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777891182; x=1778495982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX1d5M5RvOYvFUvKAGcNOcL7WzsNE4biHw6Lj8CwwOw=;
        b=pLGQokV5/rs++UCtYhwksgXw11b3ezZMvjzATQxUOqSmawMZFelLfIrhWQYK4hX9Cj
         zf7tqwygOojCdI6ob2yTkXasSsEXND7xSfuCuqt8y9UaE/sYOvxlwOT1XZQpXyc1TBQR
         Lo0gIh7v7ue7IVgwtdKkJ6dPs0rCc1/0yptGnfdMfCXOAls5j5N9kbszeMZocH9WnQFX
         moS95dsSQUo2af0+K1Ns99jSRZI7fMpGWGERXPnqRkkNelV/lPLjX9/DBTxK9480e4OE
         wqowJRT35TMPMxxEXCiW9jouJGITGqaRnOdDCcnuKodTiRIFs6F0hrXwYXf1P9b2L1au
         qVOg==
X-Gm-Message-State: AOJu0YwQYYbDI5EIXS5Byllrjemkqe+G3Uzep0URC12o+RL/O3nKCg3H
	X5EL/UCSvTfBDp5g+2a0QggHmbk4dYmkykTSfOlJI+GaO8vKdv5pgyAaswWy4Nd0uv6NBqpALBu
	BSlTRnOtO
X-Gm-Gg: AeBDiesaakF0VGtz3BUMD6djUWTvwapT6UnWh1Dd9xgGHlyOuKEw0x1NEjS/iIHs30O
	pwuoKngWV1OaK3VJJ2CvJ1WaLgokFQyOTyGvCj2/A45hXjvld/fsNSkyhQT3PXKKALU7YP0omM7
	1z6d038RCqw0rZRmDLJ3j14SnAd+cGY1wRYSAX0uqaePmOuH12AT0m3GzJ2U+9g0jnN90HnWXDK
	P2H5pVVQYIstP6ajiQWKzAhe8C+JGOeXGIcZD05ZWCPnLLsfuC66DAy82DtoJsU0WyS7XaPbFDk
	PLPDqHL/lXRlgJqKjldZCdZ/b0FjiUVJvHW1npFNZtqm/xvT9mJFGMLrva2DCbYqwVaPx9YohsI
	MviDM0shOyGyAe0jbJYzM3EaxE1bpb0tus7LiaS5yA0w8y4ln6/YblYauuHFkAXvtXtZwi7Om2V
	189Z/47U0+84/Iee+5vz6XFAlNc+hJVxLLs9mQh8X4Y26cf/TMP62jiSM60Ps4UgU1BJ+5mM8HN
	NslewscRCp8Pbg=
X-Received: by 2002:a17:907:6d13:b0:bae:9df4:d9e6 with SMTP id a640c23a62f3a-bbffb7472e8mr450836066b.30.1777891181557;
        Mon, 04 May 2026 03:39:41 -0700 (PDT)
Received: from google.com (5.180.204.35.bc.googleusercontent.com. [35.204.180.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d977b7esm397286166b.48.2026.05.04.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:39:40 -0700 (PDT)
Date: Mon, 4 May 2026 10:39:36 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: enforce VFS constraints for xattr
 related BPF kfuncs
Message-ID: <afh3aEKMctxTg7pL@google.com>
References: <20260504085428.2865671-1-mattbobrowski@google.com>
 <20260504-anzweifeln-sackkarre-911bc140473f@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-anzweifeln-sackkarre-911bc140473f@brauner>

On Mon, May 04, 2026 at 11:42:56AM +0200, Christian Brauner wrote:
> On Mon, May 04, 2026 at 08:54:27AM +0000, Matt Bobrowski wrote:
> > Enforce VFS constraints and semantics regarding name and value lengths
> > within the xattr related BPF kfuncs. Specifically, reject names that
> > are empty or longer than XATTR_NAME_MAX, and values larger than
> > XATTR_SIZE_MAX. Also validate the supplied flags to ensure that only
> > XATTR_CREATE and XATTR_REPLACE can be used alongside the default flag
> > value 0.
> > 
> > Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
> > Closes: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> > Changes in v2:
> >  - New helper bpf_xattr_validate_name() incorporated into pre-existing
> >    BPF kfunc bpf_cgroup_read_xattr() (Sashiko AI).
> > 
> > fs/bpf_fs_kfuncs.c | 85 ++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 70 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 9d27be058494..eb9aef1e135e 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -93,6 +93,21 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
> >  	return len;
> >  }
> >  
> > +static int bpf_xattr_validate_name(const char *name)
> > +{
> > +	u32 name_len;
> > +
> > +	/*
> > +	 * Impose the same restrictions on the supplied name as done so within
> > +	 * the VFS by helpers like import_xattr_name().
> > +	 */
> > +	name_len = strlen(name);
> > +	if (!name_len || name_len > XATTR_NAME_MAX)
> > +		return -ERANGE;
> > +
> > +	return 0;
> > +}
> 
> Can you please unify the check between import_xattr_name() and bpf,
> please. This just asks for someone starting to return different errnos
> from the two locations if we need any additional checks at some point...

I'm glad you suggested this because I was thinking the exact same
thing, although wasn't sure whether you'd be open to it.

> > +
> >  static bool match_security_bpf_prefix(const char *name__str)
> >  {
> >  	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
> > @@ -117,10 +132,10 @@ static int bpf_xattr_read_permission(const char *name, struct inode *inode)
> >   * @name__str: name of the xattr
> >   * @value_p: output buffer of the xattr value
> >   *
> > - * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
> > + * Get xattr *name__str* of *dentry* and store the output in *value_p*.
> >   *
> > - * For security reasons, only *name__str* with prefixes "user." or
> > - * "security.bpf." are allowed.
> > + * For security reasons, only *name__str* values prefixed with "user." or
> > + * "security.bpf." are permitted.
> >   *
> >   * Return: length of the xattr value on success, a negative value on error.
> >   */
> > @@ -133,6 +148,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
> >  	void *value;
> >  	int ret;
> >  
> > +	ret = bpf_xattr_validate_name(name__str);
> > +	if (ret)
> > +		return ret;
> > +
> >  	value_len = __bpf_dynptr_size(value_ptr);
> >  	value = __bpf_dynptr_data_rw(value_ptr, value_len);
> >  	if (!value)
> > @@ -150,10 +169,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
> >   * @name__str: name of the xattr
> >   * @value_p: output buffer of the xattr value
> >   *
> > - * Get xattr *name__str* of *file* and store the output in *value_ptr*.
> > + * Get xattr *name__str* of *file* and store the output in *value_p*.
> >   *
> > - * For security reasons, only *name__str* with prefixes "user." or
> > - * "security.bpf." are allowed.
> > + * For security reasons, only *name__str* values prefixed with "user." or
> > + * "security.bpf." are permitted.
> >   *
> >   * Return: length of the xattr value on success, a negative value on error.
> >   */
> > @@ -187,10 +206,18 @@ static int bpf_xattr_write_permission(const char *name, struct inode *inode)
> >   * @value_p: xattr value
> >   * @flags: flags to pass into filesystem operations
> >   *
> > - * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> > + * Set xattr *name__str* of *dentry* to the value in *value_p*.
> >   *
> > - * For security reasons, only *name__str* with prefix "security.bpf."
> > - * is allowed.
> > + * For security reasons, only *name__str* values prefixed with "security.bpf."
> > + * are permitted.
> > + *
> > + * The length constraints imposed on both the xattr name and value abide those
> > + * that are also enforced by the VFS. Additionally, the flags argument respects
> > + * what's enforced by the VFS in the same way. By default, the flag value of 0
> > + * is permitted and an xattr will be created if it does not exist, or the value
> > + * will be replaced if the xattr already exists. More course grained control
> > + * over these exact semantics is permitted by explicitly specifying either
> > + * XATTR_CREATE or XATTR_REPLACE.
> >   *
> >   * The caller already locked dentry->d_inode.
> >   *
> > @@ -206,7 +233,17 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> >  	u32 value_len;
> >  	int ret;
> >  
> > +	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
> > +		return -EINVAL;
> > +
> > +	ret = bpf_xattr_validate_name(name__str);
> > +	if (ret)
> > +		return ret;
> > +
> >  	value_len = __bpf_dynptr_size(value_ptr);
> > +	if (value_len > XATTR_SIZE_MAX)
> > +		return -E2BIG;
> > +
> 
> Hm, this is also open-coded in fs/xattr.c and here now. I wonder whether
> we can easily build this around the same infra as fs/xattr.c is. So use
> struct kernel_xattr_ctx and struct kname because then all codepaths:
> 
> syscall/internal, io_uring and the bpf interface are the same thing with
> shared helpers and behavior.

At this point, I can't really see why this couldn't be done. I'll try
and introduce a set of shareable helpers which are tasked with
enforcing these constraints uniformly across all of these various
subsystems.
