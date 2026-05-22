Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B55385D8A
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491329; cv=none; b=pDY5F56dvaSMdKNO0Z5IWJZ4u2PqysqJ47N3UdnMZ9kT7G6+NCEr7K9hUbalqDYlIUIRiR5+BTYUKnoMbdYcEjc+PJj/JDkV4HW9aMydWzG+qgK1roleeM1IgygY2jsPFYrlBNTq83Y9g4LCE51BwfxKF2BeIucZTKgjS7P+bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491329; c=relaxed/simple;
	bh=bSl3wL03ppKM7BOZ77tVceqREjU0jsd/V+sdo5sNMgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QW6t7cwG7Jao0z9aQeexmGBjp7Xdd9vdHB/rRkOE0w/xwAWu2p4i5lL8CU4V51wgjsZ6cFZkE6fQWmirbZEp/xpkNJfuAy78u9uE9UREPyHL1PJ7Eh0WEd5kQK0eTrzh6i25Gcxv1RDZ5BBSI/7cl21EdfAcIKZ/T8VrwRrSCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/AeuhLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/AeuhLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014831F000E9;
	Fri, 22 May 2026 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491328;
	bh=UWmonR8tEoSa+UmT3zZNPyKcVcBB1HW6rr2VRxgZAiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/AeuhLtQO6PYJwzvuN0Aiia3aVtKA/DcNq+dY8FHdBRNh6K0D0wxll5IicbQ04+l
	 +AmG61Sripp2fcThS+lgOwMcv+XBCIe309XddzmPqOpujA/aDYoRvb9/BEm07k4Kgv
	 cygDya1HujzWGEMefMWSjoPFnXaow3+SB/q8A1Bj1SpyMj5c/yg99jQInBWz4oap5d
	 W/J/6jnJfhsF413rEtkjYcNoSBsp72rlKlgsYMvUtULHnWQVkHJXVmpkZct9pC3xqo
	 8x2KxJddlJQU217/AxQBIKaXHmpJyhaMq58aqJYETNbB9tlPU7eeXFghyJMzCdOuw+
	 dG5lAxxtO5xmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata
 maps in the signed loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "KP Singh" <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522215337.662271-3-kpsingh@kernel.org>
References: <20260522215337.662271-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:08:47 +0000
Message-Id: <20260522230848.014831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Hardcoded fixed offsets for kernel-internal `struct bpf_map` i=
n userspace-generated BPF code without CO-RE relocations.
- [High] The loader program unconditionally emits an 8-byte read for the `e=
xcl_prog_sha` pointer field, causing a guaranteed verifier rejection on 32-=
bit kernels.
- [High] The metadata map exclusivity check can be bypassed via map-in-map,=
 reintroducing the TOCTOU vulnerability.
--

commit afb36fdfc7cc8ff5eb04ebacf8fda203221aa679
Author: KP Singh <kpsingh@kernel.org>

bpf, libbpf: reject non-exclusive metadata maps in the signed loader

This commit adds a check in the gen_loader to verify that the metadata map
is exclusive before allowing it to be used. It places excl_prog_sha right
after the sha field in struct bpf_map and reads it at a fixed offset to
ensure another program cannot mutate the contents after signature validatio=
n.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd191c5fdb0a5..11bec73db1994 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -295,6 +295,7 @@ struct bpf_map_owner {
> =20
>  struct bpf_map {
>  	u8 sha[SHA256_DIGEST_SIZE];
> +	char *excl_prog_sha;
>  	const struct bpf_map_ops *ops;
>  	struct bpf_map *inner_map_meta;

[Severity: High]
Does this exclusivity check handle map-in-map scenarios correctly? Since
bpf_map_meta_alloc() does not copy excl_prog_sha into the inner_map_meta,
could an attacker load a program against an inner_map_meta (which has a
NULL excl_prog_sha), and then insert the exclusive frozen map into the
map-in-map at runtime? It appears this might allow a malicious program to
dynamically look up the inner map and mutate the frozen map using
bpf_map_update_elem(), bypassing the intended security guarantee.

[ ... ]

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f260..5077472b9fd25 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -600,6 +600,23 @@ static void emit_signature_match(struct bpf_gen *gen)
>  			gen->error =3D -ERANGE;
>  		}
>  	}
> +
> +	/*
> +	 * Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE *=
 sizeof(__u64)));

[Severity: Critical]
Does this hardcode a fixed offset (32) for a kernel-internal structure
without using CO-RE? Since light skeleton headers are distributed in
userspace, if struct bpf_map changes in future kernel releases, won't
these older generated skeletons be rejected by the verifier or silently
read incorrect data? This seems to unintentionally freeze the internal
ABI of struct bpf_map for light skeletons.

[Severity: High]
Will this unconditionally emit an 8-byte read for the excl_prog_sha
pointer field, even on 32-bit systems? Since pointers are 4 bytes on
32-bit architectures, won't the BPF verifier strictly reject this 8-byte
read against a 4-byte BTF pointer field due to the size mismatch? The commit
message mentions target pointer size tracking is needed as a follow-up,
but does this mean 32-bit skeletons will be guaranteed to fail loading
until that follow-up is merged?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522215337.6622=
71-1-kpsingh@kernel.org?part=3D2
