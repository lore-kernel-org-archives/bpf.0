Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904852F60B2
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314577; cv=none; b=dI9+Y6PXp0wXPpQ2E1Wf0OwdlhUeP30W+CiJ14soEoHQAdkiwQ3VUPY888WPOnKQyMuZKqkL25rbkkTq4rI8kafOfwLw4zIPQJAAtNEXrrchG9RxfqMSEjAzr+i9D7ffdYuZf5GyEHO6vamiHDl4Vt+kGaFuWQJOUb+7LzxNAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314577; c=relaxed/simple;
	bh=WBwBlyt5GTNWCRURF/BUfPDWlA9HR/MBXF526IRokHw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=og/vr5PhgBtDgRXDg64Eo3gIU2QTBHv8ffqlXi4L1rot+fLxF71qqrB4fdvqOXl4Tc65QZg2tW2a+G0vccFB0a2DBiucKRW5fTWzMCaOtWCzISIe1xJxh2mBxZmrNxDq1ifc3pUil8fl7xThnEcgiDW9RnXAJcyueB09fJyooss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8urCCuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8urCCuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD63D1F000FF;
	Sun, 13 Sep 2026 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789314576;
	bh=U7pgyZRdoUsn5xFqu0UPRArOMWjQXOnvyVr7jq7EuTs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y8urCCuowTEb94cGWHxUkIMeRqnuJul6hB6aH/piRC1/ShkGRjob7Zn+e8I392wVK
	 Jdyye5KdomA5nsTksOISVdG+rYc9yLnadQQca4ItMMQIFwIfFGJt33IlUPPv26mw+m
	 Lw8bZBcY6aG7sd/YrjAyCdoySqBcL/nwALk6KFW5ZKXzXxJ5jAOlsDHhkWBjFTLbD7
	 A/IG/a6YPw4T8wvQ3fQTkfU6KIllJo69x2YbcxTwvWS4VDJ0kCpUsA2FscsN0dQE8I
	 dEoc6nuFsPn1ZNBFfZ6EynsFzGwXRC53oQcY/U9cbPaZFQdCJp9JJaHfZnBo1mweC1
	 7OTxhrW4G0Drg==
Content-Type: multipart/mixed; boundary="===============5879122226337089223=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c88b94cceb5d2332a02316af00f61b39582683fad8d75358b2d40aaec133790@mail.kernel.org>
In-Reply-To: <20260913145233.1446643-2-caomingpei@gmail.com>
References: <20260913145233.1446643-2-caomingpei@gmail.com>
Subject: Re: [PATCH bpf v2 1/3] libbpf: Validate struct_ops member offsets before data access
From: bot+bpf-ci@kernel.org
To: caomingpei@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ameryhung@gmail.com,qmo@kernel.org,caomingpei@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 13 Sep 2026 15:49:35 +0000 (UTC)

--===============5879122226337089223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee..2791b4858593 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -1208,29 +1228,50 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>  		return -ENOMEM;
>
>  	data = st_ops->data;
> -	kern_data_off = kern_data_member->offset / 8;
>  	kern_data = st_ops->kern_vdata + kern_data_off;
>
>  	member = btf_members(type);
>  	for (i = 0; i < btf_vlen(type); i++, member++) {
>  		const struct btf_type *mtype, *kern_mtype;
> -		__u32 mtype_id, kern_mtype_id;
> +		__u32 bit_offset, mtype_id, kern_mtype_id;
>  		void *mdata, *kern_mdata;
>  		struct bpf_program *prog;
>  		__s64 msize, kern_msize;
> +		__u64 maccess_size;
>  		__u32 moff, kern_moff;
>  		__u32 kern_member_idx;
>  		const char *mname;
>
>  		mname = btf__name_by_offset(btf, member->name_off);
> -		moff = member->offset / 8;
> -		mdata = data + moff;
> +		if (btf_member_bitfield_size(type, i)) {
> +			pr_warn("struct_ops init_kern %s: local bitfield %s is not supported\n",
> +				map->name, mname);
> +			return -ENOTSUP;
> +		}
> +
>  		msize = btf__resolve_size(btf, member->type);
>  		if (msize < 0) {
>  			pr_warn("struct_ops init_kern %s: failed to resolve the size of member %s\n",
>  				map->name, mname);
>  			return msize;
>  		}
> +		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
> +		maccess_size = msize;
> +		if (btf_is_ptr(mtype) && maccess_size < sizeof(prog))
> +			maccess_size = sizeof(prog);
> +		bit_offset = btf_member_bit_offset(type, i);
> +		if (bit_offset % 8) {
> +			pr_warn("struct_ops init_kern %s: member %s has a non-byte-aligned offset\n",
> +				map->name, mname);
> +			return -EINVAL;
> +		}
> +		moff = bit_offset / 8;
> +		if (moff > type->size || maccess_size > type->size - moff) {
> +			pr_warn("struct_ops init_kern %s: member %s is outside the %u-byte local struct_ops type\n",
> +				map->name, mname, type->size);
> +			return -EINVAL;
> +		}
> +		mdata = data + moff;

This isn't a bug, but could the commit message mention the pointer load
change and the maccess_size widening? The changelog describes rejecting
bitfields and checking ranges, but doesn't explain why the punned load
prog = *(void **)mdata becomes memcpy(&prog, mdata, sizeof(prog)) or why
maccess_size is widened to sizeof(prog) for pointer members. Both look
deliberate - once an arbitrary moff is accepted, mdata need not be
pointer-aligned, and the read is sizeof(struct bpf_program *) wide rather
than msize wide - but a reader has to reconstruct that rationale from the
code.

[ ... ]

> @@ -1281,7 +1338,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>  		}
>
>  		if (btf_is_ptr(mtype)) {
> -			prog = *(void **)mdata;
> +			memcpy(&prog, mdata, sizeof(prog));
>  			/* just like for !kern_member case above, reset declaratively
>  			 * set (at compile time) program's autload to false,
>  			 * if user replaced it with another program or NULL

[ ... ]

> @@ -1352,8 +1409,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>  			continue;
>  		}
>
> -		kern_msize = btf__resolve_size(kern_btf, kern_mtype_id);
> -		if (kern_msize < 0 || msize != kern_msize) {
> +		if (msize != kern_msize) {
>  			pr_warn("struct_ops init_kern %s: Error in size of member %s: %zd != %zd(kernel)\n",
>  				map->name, mname, (ssize_t)msize,
>  				(ssize_t)kern_msize);

This isn't a bug, but with the btf__resolve_size(kern_btf, kern_mtype_id)
call gone, is kern_mtype_id still read anywhere? The patch writes it via
skip_mods_and_typedefs() calls but the last consumer is removed here.
skip_mods_and_typedefs() accepts NULL for res_id, so both call sites could
pass NULL and the local could be dropped.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34765254213
--===============5879122226337089223==--
