Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A345212554
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328934; cv=none; b=obo7V0miomB/+KQCI63ONDCh/Ah9yECQrNGUST5a5M2ciWZTmx/WK53L7rD9OUShNLIChvNpY61seSMtlfhfWB470yCtyvt+URTFbj6xOV3IQjhbI+TRk6aGYvv/RxJAdtfqqWjqr1jMWTCJ6aYaluanqhsCAz6SVC+FKoeWkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328934; c=relaxed/simple;
	bh=0q8qi+BvzHsZTlhep1GlKwYfa6F2OrKA0CfnYpdGEqA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YFGjGt3NCTycSs9m7g4rOTnX2+ZoA2ofd6DDcx57MuWN0O6U+PcNqN0feaFhR5tMz6kMBrXmD6jfljSmzIToMQG1OE3+H0Owvm6DUHLddeUQszR0Y9T4tndwrcMzvCzMltnG9Li1a0xzTPVPOD6lVLGoS4maZmjTEhyvTXVEnu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBszFA/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBszFA/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8DA1F00898;
	Mon,  1 Jun 2026 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780328932;
	bh=vOlHn5I0H9zcyXCbaE/FlBNe3JmVbFU92w8VF0m4Uho=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MBszFA/Y5pQHHoOMifJVPh5FaQ2QfK2Fan+fbXgcvIgz+yNqfNesVoyu6QsXgRRiy
	 LHeLmdM7igDL2guSvOLDczTaL0iQIrzNfzmcNX7rHckK3AW4KxZaeuNs9Rdo4WHHJy
	 rfH8jxmu7aYSw8ZZd/Jio/jXtHGQNyKV/Z2GC7nOySG6ZpkSqxxICNTiikEPtUKkLy
	 5vMaa97XfjymkbCjRz2/sEMdahhINmbaj+t6fwHmb8oqHqriuh6K0eSRjlU64QeJlk
	 glbsQ1gbglVIbLX9Q7brRDv7D4/0i6gpbbAwRWevDeCwAaPBUciKqGss5eajaRJiWO
	 Umha/T7uMbX3Q==
Content-Type: multipart/mixed; boundary="===============8964048924121261250=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2037d4c2af418cb44e8e9bbab5c78914c78c1b29d80d3e66afec378495347e74@mail.kernel.org>
In-Reply-To: <20260601150248.394863-5-daniel@iogearbox.net>
References: <20260601150248.394863-5-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 4/7] libbpf: Skip initial_value override on signed loaders
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  1 Jun 2026 15:48:52 +0000 (UTC)

--===============8964048924121261250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 66a02039da8c..a5d9c7a5261b 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -1187,27 +1187,36 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
>  	value = add_data(gen, pvalue, value_size);
>  	key = add_data(gen, &zero, sizeof(zero));
>
> -	/* if (map_desc[map_idx].initial_value) {
> +	/*
> +	 * if (map_desc[map_idx].initial_value) {
>  	 *    if (ctx->flags & BPF_SKEL_KERNEL)
>  	 *        bpf_probe_read_kernel(value, value_size, initial_value);
>  	 *    else
>  	 *        bpf_copy_from_user(value, value_size, initial_value);
>  	 * }
> +	 *
> +	 * The runtime initial_value comes from the host-supplied loader
> +	 * ctx and would overwrite the blob value after emit_signature_match()
> +	 * has already validated map->sha[]. For a signed loader (gen_hash)
> +	 * the attested blob value must be authoritative, so skip the override
> +	 * and leave the hashed value in place.
>  	 */
> -	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
> -			      sizeof(struct bpf_loader_ctx) +
> -			      sizeof(struct bpf_map_desc) * map_idx +
> -			      offsetof(struct bpf_map_desc, initial_value)));
> -	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
> -	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> -					 0, 0, 0, value));
> -	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
> -	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
> -			      offsetof(struct bpf_loader_ctx, flags)));
> -	emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
> -	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
> -	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
> -	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
> +	if (!OPTS_GET(gen->opts, gen_hash, false)) {
> +		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
> +				      sizeof(struct bpf_loader_ctx) +
> +				      sizeof(struct bpf_map_desc) * map_idx +
> +				      offsetof(struct bpf_map_desc, initial_value)));
> +		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, value));
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
> +		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
> +				      offsetof(struct bpf_loader_ctx, flags)));
> +		emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
> +		emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
> +		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
> +		emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
> +	}
>
>  	map_update_attr = add_data(gen, &attr, attr_size);
>  	pr_debug("gen: map_update_elem: idx %d, value: off %d size %d, attr: off %d size %d\n",

This is a pre-existing issue, but while this patch closes the
map-in-map bypass for exclusive maps, does a similar bypass still
exist through BPF iterators?

Looking at bpf_iter_attach_map() in kernel/bpf/map_iter.c, when a BPF
map iterator is attached via BPF_LINK_CREATE:

	map = bpf_map_get_with_uref(linfo->map.map_fd);
	if (IS_ERR(map))
		return PTR_ERR(map);

	// [...]

	if (key_acc_size > key_size || value_acc_size > value_size) {
		err = -EACCES;
		goto put_map;
	}

This function retrieves the target map but appears to lack checks
against map->excl_prog_sha, map->frozen, and BPF_F_RDONLY_PROG.

Furthermore, the iterator context defined in bpf_map_elem_reg_info()
sets up the value argument without the MEM_RDONLY flag:

	{ offsetof(struct bpf_iter__bpf_map_elem, value),
	  PTR_TO_BUF | PTR_MAYBE_NULL },

Because MEM_RDONLY is omitted, the verifier permits BPF programs to
perform direct memory writes to ctx->value.

Could this allow a program to locate the FD of an exclusive, frozen
map via its ID, attach a custom BPF map iterator, and arbitrarily
overwrite the contents of the protected map?

This concern was raised by sashiko-bot in v2 review comments at:
https://lore.kernel.org/bpf/20260601151810.68BCF1F00893@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26764265302
--===============8964048924121261250==--
