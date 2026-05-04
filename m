Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F630F7E8
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887781; cv=none; b=sykdwpbifMM5Ni+YU6jrzzGg4vWFVhn2sbwEuDwS7pWX+BqS1OPLViN0m1qYNOGu2YECQ96UiRJHrXw/hMF2V6fc0kFpElX5IHhu0Gv0vGXb685DwRPsrr4LKS3fIHBi1o0jRCg/mVQGHmmbcZ5IwG370PLyR8phGsn9wd+5lI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887781; c=relaxed/simple;
	bh=A7F+8JY/oUHvwYS3RIujPxLnpqoQHRXWv0S0HpWioVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq1DOw7Yi05ZVMOXxlnY4nFvYTR4l3i5AVo/QkkfkisgTmiMjR0PxztfkZbf2IYjWA8clJX7G4X2B24k6cG3kZOvQKLZYH4xF1X9H79DjCSq/pzEQDlKs2nGAGsOSRfQKECXalQUHVZKfKz15i1kVVMI9EDoa6K0YRwltcvY0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V39RQqPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V39RQqPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ABCC2BCB8;
	Mon,  4 May 2026 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777887781;
	bh=A7F+8JY/oUHvwYS3RIujPxLnpqoQHRXWv0S0HpWioVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V39RQqPE65F7L4pBXmKJHFBN8+XBS0Z03jhAAs7uLv0m3zlieAIer2l4nyN3Mt4f/
	 SzNziX9E4MR7h6k4RnYBNob+eN8SLUTNVyHzaFzluPk6NvqM0uvJUItiBRUez7H5qd
	 ngEn/6uILnxd2ZJtiOD18GrjFUmxLdHnH25HiX5SonMjpN64jv64AVwHvVOUAkXxFV
	 d4IouM/vRYm9I6z8/rGfUadfTJ47np9+n6B85JGWmU9DYMP0+y0Rw04oy23AoS/rCc
	 871r8uJGRZyPjn4FLTg1Ncj+w1UgGG4swEgYnIjdUUjzr+FrcP6+ttM/kxlhNx4StA
	 n952CCN5C5k/g==
Date: Mon, 4 May 2026 11:42:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: enforce VFS constraints for xattr
 related BPF kfuncs
Message-ID: <20260504-anzweifeln-sackkarre-911bc140473f@brauner>
References: <20260504085428.2865671-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504085428.2865671-1-mattbobrowski@google.com>

On Mon, May 04, 2026 at 08:54:27AM +0000, Matt Bobrowski wrote:
> Enforce VFS constraints and semantics regarding name and value lengths
> within the xattr related BPF kfuncs. Specifically, reject names that
> are empty or longer than XATTR_NAME_MAX, and values larger than
> XATTR_SIZE_MAX. Also validate the supplied flags to ensure that only
> XATTR_CREATE and XATTR_REPLACE can be used alongside the default flag
> value 0.
> 
> Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
> Closes: https://lore.kernel.org/bpf/20260429221005.6D1C6C19425@smtp.kernel.org/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
> Changes in v2:
>  - New helper bpf_xattr_validate_name() incorporated into pre-existing
>    BPF kfunc bpf_cgroup_read_xattr() (Sashiko AI).
> 
> fs/bpf_fs_kfuncs.c | 85 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..eb9aef1e135e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -93,6 +93,21 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
>  	return len;
>  }
>  
> +static int bpf_xattr_validate_name(const char *name)
> +{
> +	u32 name_len;
> +
> +	/*
> +	 * Impose the same restrictions on the supplied name as done so within
> +	 * the VFS by helpers like import_xattr_name().
> +	 */
> +	name_len = strlen(name);
> +	if (!name_len || name_len > XATTR_NAME_MAX)
> +		return -ERANGE;
> +
> +	return 0;
> +}

Can you please unify the check between import_xattr_name() and bpf,
please. This just asks for someone starting to return different errnos
from the two locations if we need any additional checks at some point...

> +
>  static bool match_security_bpf_prefix(const char *name__str)
>  {
>  	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
> @@ -117,10 +132,10 @@ static int bpf_xattr_read_permission(const char *name, struct inode *inode)
>   * @name__str: name of the xattr
>   * @value_p: output buffer of the xattr value
>   *
> - * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
> + * Get xattr *name__str* of *dentry* and store the output in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefixes "user." or
> - * "security.bpf." are allowed.
> + * For security reasons, only *name__str* values prefixed with "user." or
> + * "security.bpf." are permitted.
>   *
>   * Return: length of the xattr value on success, a negative value on error.
>   */
> @@ -133,6 +148,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>  	void *value;
>  	int ret;
>  
> +	ret = bpf_xattr_validate_name(name__str);
> +	if (ret)
> +		return ret;
> +
>  	value_len = __bpf_dynptr_size(value_ptr);
>  	value = __bpf_dynptr_data_rw(value_ptr, value_len);
>  	if (!value)
> @@ -150,10 +169,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>   * @name__str: name of the xattr
>   * @value_p: output buffer of the xattr value
>   *
> - * Get xattr *name__str* of *file* and store the output in *value_ptr*.
> + * Get xattr *name__str* of *file* and store the output in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefixes "user." or
> - * "security.bpf." are allowed.
> + * For security reasons, only *name__str* values prefixed with "user." or
> + * "security.bpf." are permitted.
>   *
>   * Return: length of the xattr value on success, a negative value on error.
>   */
> @@ -187,10 +206,18 @@ static int bpf_xattr_write_permission(const char *name, struct inode *inode)
>   * @value_p: xattr value
>   * @flags: flags to pass into filesystem operations
>   *
> - * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + * Set xattr *name__str* of *dentry* to the value in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefix "security.bpf."
> - * is allowed.
> + * For security reasons, only *name__str* values prefixed with "security.bpf."
> + * are permitted.
> + *
> + * The length constraints imposed on both the xattr name and value abide those
> + * that are also enforced by the VFS. Additionally, the flags argument respects
> + * what's enforced by the VFS in the same way. By default, the flag value of 0
> + * is permitted and an xattr will be created if it does not exist, or the value
> + * will be replaced if the xattr already exists. More course grained control
> + * over these exact semantics is permitted by explicitly specifying either
> + * XATTR_CREATE or XATTR_REPLACE.
>   *
>   * The caller already locked dentry->d_inode.
>   *
> @@ -206,7 +233,17 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>  	u32 value_len;
>  	int ret;
>  
> +	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
> +		return -EINVAL;
> +
> +	ret = bpf_xattr_validate_name(name__str);
> +	if (ret)
> +		return ret;
> +
>  	value_len = __bpf_dynptr_size(value_ptr);
> +	if (value_len > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +

Hm, this is also open-coded in fs/xattr.c and here now. I wonder whether
we can easily build this around the same infra as fs/xattr.c is. So use
struct kernel_xattr_ctx and struct kname because then all codepaths:

syscall/internal, io_uring and the bpf interface are the same thing with
shared helpers and behavior.

>  	value = __bpf_dynptr_data(value_ptr, value_len);
>  	if (!value)
>  		return -EINVAL;
> @@ -237,8 +274,8 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>   *
>   * Rmove xattr *name__str* of *dentry*.
>   *
> - * For security reasons, only *name__str* with prefix "security.bpf."
> - * is allowed.
> + * For security reasons, only *name__str* values prefixed with "security.bpf."
> + * are permitted.
>   *
>   * The caller already locked dentry->d_inode.
>   *
> @@ -249,6 +286,10 @@ int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
>  	struct inode *inode = d_inode(dentry);
>  	int ret;
>  
> +	ret = bpf_xattr_validate_name(name__str);
> +	if (ret)
> +		return ret;
> +
>  	ret = bpf_xattr_write_permission(name__str, inode);
>  	if (ret)
>  		return ret;
> @@ -274,11 +315,19 @@ __bpf_kfunc_start_defs();
>   * @value_p: xattr value
>   * @flags: flags to pass into filesystem operations
>   *
> - * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + * Set xattr *name__str* of *dentry* to the value in *value_p*.
>   *
>   * For security reasons, only *name__str* with prefix "security.bpf."
>   * is allowed.
>   *
> + * The length constraints imposed on both the xattr name and value abide those
> + * that are also enforced by the VFS. Additionally, the flags argument respects
> + * what's enforced by the VFS in the same way. By default, the flag value of 0
> + * is permitted and an xattr will be created if it does not exist, or the value
> + * will be replaced if the xattr already exists. More course grained control
> + * over these exact semantics is permitted by explicitly specifying either
> + * XATTR_CREATE or XATTR_REPLACE.
> + *
>   * The caller has not locked dentry->d_inode.
>   *
>   * Return: 0 on success, a negative value on error.
> @@ -327,18 +376,24 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
>   * @name__str: name of the xattr
>   * @value_p: output buffer of the xattr value
>   *
> - * Get xattr *name__str* of *cgroup* and store the output in *value_ptr*.
> + * Get xattr *name__str* of *cgroup* and store the output in *value_p*.
>   *
> - * For security reasons, only *name__str* with prefix "user." is allowed.
> + * For security reasons, only *name__str* values prefixed with "user." are
> + * permitted.
>   *
>   * Return: length of the xattr value on success, a negative value on error.
>   */
>  __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
> -					struct bpf_dynptr *value_p)
> +				      struct bpf_dynptr *value_p)
>  {
>  	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
>  	u32 value_len;
>  	void *value;
> +	int ret;
> +
> +	ret = bpf_xattr_validate_name(name__str);
> +	if (ret)
> +		return ret;
>  
>  	/* Only allow reading "user.*" xattrs */
>  	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
