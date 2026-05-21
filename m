Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45030C15F
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382362; cv=none; b=ZyAujV48m9ySqGKE9PruAcyqsBmQh1ZMHlV3ZfBK4NXjhvXLrUHxLPcZLwBs1vn3Gkht4+4xsw1YD8o20xcCZYso4vl/0QSNCBXh5NKE7GUM8PPMy5UoA30hT5isuce4AJgtyYL9yhIjKQ4m0CQ1FmbOCpc6FW+TUv9o/zxydHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382362; c=relaxed/simple;
	bh=kDA2VjByEpqgyctQ4qR4C2pSxnq0tKUmAdm3gvg0h0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7w6kLAO8ZASKpoS46jmOx1niyRLXRefsPWnSAC3beakQ7UyopkRuz9h8RGDRVJKfTlqBGN0uuthE1gJDZ4WXtCvKr4GGvj1L8L5M0jPQ9Dsi+b2qcmDL2obSivx9uzakMESfrmH9V65qzFIseFOQDcreW77RdQOWKUci5MU/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKPB0V1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKPB0V1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95EA1F000E9;
	Thu, 21 May 2026 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779382361;
	bh=djz0vs+NlcsZ/dyKfqWbhNrVLlqWadcl/zqfMlE7kT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oKPB0V1+7rbudv/8ZqMBDofKSNrMg9aJqAv/oDKMA7PzrRAuE7lqAYTrb9t1lxGR4
	 lPs8QVd7NUrmhkC5D144G7RM+tIpYKoQ4TADtEu5WcXUU4IYwXaZyglqCY0Zk0jR35
	 zZRJXM1mcEOZ7TzXTbvcK9LGOuUaosg9K7gpCjcJQDlCVav1PK4jZcHPA/vdyPFO7i
	 51l6fRzdqMgjf495EqcsZu1xgFidljxRJWdRedGUn5rI2pAMxECf2WZ2F0Skb6MY+u
	 Se6qj3MZob6fEqqs7mrFy35X6zjDuWfijzpfPgLnrC0NaDM6MUTN38l19JhCkgU8J/
	 tGhDTpmdj5upw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps
 in the signed loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "KP Singh" <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521152217.2345235-3-kpsingh@kernel.org>
References: <20260521152217.2345235-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 16:52:40 +0000
Message-Id: <20260521165240.D95EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The BPF verifier will reject the `gen_loader` program on 32-bit ar=
chitectures because it accesses a 4-byte pointer using an 8-byte read.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem stand=
ard.
--

commit 878a81f0d9571d5734eccfbe01c3dfe58050f954
Author: KP Singh <kpsingh@kernel.org>

bpf, libbpf: reject non-exclusive metadata maps in the signed loader

The loader verifies map->sha against the metadata hash in its
instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is called
on the frozen map.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f260..fee35c26deb87 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
[ ... ]
> @@ -600,6 +600,22 @@ static void emit_signature_match(struct bpf_gen *gen)
>  			gen->error =3D -ERANGE;
>  		}
>  	}
> +
> +	/* Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF
subsystem style guidelines? It looks like the opening /* should be on its
own line.

> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE *=
 sizeof(__u64)));

[Severity: High]
Will this 8-byte read pass the verifier on 32-bit architectures?

While __bpf_md_ptr pads the C struct field to 8 bytes, unnamed bitfields
are not emitted in BTF. The kernel's BTF will represent the pointer member
with a size of 4 bytes on 32-bit systems.=20

Since btf_struct_walk() enforces that the memory access size exactly matches
the BTF pointer size, it seems the verifier will reject this BPF_DW access
with a cannot access ptr member error on 32-bit architectures.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index e2767d27d8aaf..baef2e93cb414 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
[ ... ]
> @@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
>  	: __clobber_all);
>  }
> =20
> -/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, acc=
essing
> - * into this array is valid. The opts field is now at offset 33.
> +/* The first 32 bytes of struct bpf_map are the SHA256 hash; accessing i=
nto
> + * this array is valid. excl_prog_sha follows at offset 32 (8 bytes via
> + * __bpf_md_ptr), then ops at offset 40. Reading at offset 41 crosses in=
to
> + * the ops pointer and must be rejected.
>   */

[Severity: Low]
This isn't a bug, but should this multi-line comment also have the
opening /* on a standalone line according to the BPF style guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521152217.2345=
235-1-kpsingh@kernel.org?part=3D2
