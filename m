Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F2388397
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921543; cv=none; b=t48lMd6iLehqmb/PlRBLUOCzHksNU9covjkawDF8ZAxNfFpBh+nRdA/jOjHwxZkde3kj78cQLNAW7WBZDbFbLxIs9NCXmhFK2V0pWF80Pz5XnQYiCJnT56JnBy0eOS0LTD3Ambz4m6HDjHGwGYYAa1ml2+MmWbFIdLKISxcsybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921543; c=relaxed/simple;
	bh=GYSs0WxWe0wLEsNsCZ2UVX3U9+8fEaEgUswpha9s9J8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZcmJghtpGTqnQOfKOVZ6md5EcnZ199YXqW9MRv+jrJhor9Tq06wOpA/f+t1mdUxraWNWhBJUBfHcf+zaJECRePQgVzje5kgFR5YfcpaPV/HIVglq1hE7gu+i1fR4TVH4Y+D16B3u5faxEgayj4lQsoP51uUhhPZKhl2g7fa1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSSGASuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSSGASuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226651F000E9;
	Fri, 24 Jul 2026 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921539;
	bh=gvR119GGhKvWBipUIeEQfRJeYD5MlZmAq8rBSFp/Ok8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jSSGASuOOU/DDJi9jGKqUkILC5wxlmu9yIG6adMYX3dwCtWvAUq8ra3RSnOaIsnkz
	 Zi1WvrlGD6G4qCujr9+P0dsG7VBwHTh+JySjo/8iSWKQglAJTvMQEFG0U+xnDL3Yes
	 GLoYj4cWPwbIhWXdIkJGExkMNTs8ync+jrEAxg5408YVROJNaCl+z8BCKH5oDNFs5A
	 r8qBcJHxASTND2+DYT07rckEQrD/XhSjZyi1OBonBCWYoqWzXoxC5t7cDDxGefgcy2
	 kYLlCu8GNc5FGmIe+X2pBwHsQqLkIVZDJUPcM4C349qcRZQUb+YCFpT+d/XEXSQeZ0
	 j48k6NhLNFeeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724190813.1458271-8-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-8-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 19:32:18 +0000
Message-Id: <20260724193219.226651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An integer overflow in `check_mem_reg` when calculating the st=
ack access size allows global subprograms to bypass memory bounds checks, l=
eading to out-of-bounds kernel memory accesses.
- [Critical] Global subprograms unconditionally accept literal NULL scalars=
 for non-nullable pointer arguments, potentially leading to a kernel crash =
due to NULL pointer dereferences.
--

--- Patch [7]: [PATCH bpf-next v2 07/18] bpf: Check fixed-size mem args of =
helpers and kfuncs the same way ---
commit 7f7a12884bb4c90a70c0a9e694af984eca478eee
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check fixed-size mem args of helpers and kfuncs the same way

Fixed-size memory arguments went through two paths: helpers called
check_helper_mem_access() directly, while kfuncs and global subprogs
used check_mem_reg(). Route the helper MEM_FIXED_SIZE case through
check_mem_reg() too so all three share the same check.

This also fixes a bug in the helper path. When passing a NULL to
PTR_MAYBE_NULL | ARG_PTR_TO_FIXED_SIZE_MEM argument, the program would
be falsely rejected by check_helper_mem_access().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e56f726c12a8..4606294e444a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg
>  		mark_ptr_not_null_reg(reg);
>  	}
> =20
> -	int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem_size =
: mem_size;
> +	size =3D (!helper && base_type(reg->type) =3D=3D PTR_TO_STACK) ? -(int)=
mem_size : mem_size;

[Severity: Critical]
This is a pre-existing issue, but does the -(int)mem_size cast introduce an
integer overflow risk for global subprograms?

If a user defines a BTF struct with a size close to U32_MAX (e.g. 0xFFFFFFF=
C),
-(int)mem_size evaluates to a small positive integer like 4.=20

The verifier would only validate this small 4-byte region on the caller's
stack, while the global subprogram is verified separately with a PTR_TO_MEM
of the original massive size.

Could this allow the subprogram to read and write out-of-bounds kernel memo=
ry
beyond the provided stack object?

> =20
> -	err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ, true, =
meta);
> -	err =3D err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE=
, true, meta);
> +	if (access_type & BPF_READ)
> +		err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ, true,=
 meta);
> +	if (!err && (access_type & BPF_WRITE))
> +		err =3D check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true=
, meta);

[ ... ]

> @@ -9251,7 +9255,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
>  			ret =3D check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
>  			if (ret < 0)
>  				return ret;
> -			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
> +			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRIT=
E, NULL))
>  				return -EINVAL;
>  			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)=
) {

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for global
subprograms to bypass nullability requirements here?

When check_mem_reg() is called just above this line, it returns 0 early for
literal NULL scalars:

kernel/bpf/verifier.c:check_mem_reg() {
    if (bpf_register_is_null(reg))
        return 0;
    ...
}

Because of this early return, the nullability check immediately following
check_mem_reg() in btf_check_func_arg_match() fails to catch the NULL.
The check relies on the PTR_MAYBE_NULL flag, which a literal NULL scalar
(SCALAR_VALUE) does not have.

Does this allow global subprograms to accept unvalidated NULL pointers
even for arguments not marked as nullable, leading to potential NULL
pointer dereferences?

>  				bpf_log(log, "%s is expected to be non-NULL\n",
>  					reg_arg_name(env, argno));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1458=
271-1-ameryhung@gmail.com?part=3D7
