Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E13F4105
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434552; cv=none; b=GDNpJh9mEeZqcOzMtU0S3s/xO1GngXCa/0f+4EbZhFhtZBb5rArfWFB1244FPE1YVqJtoxURZrPgpThcpXedRAOWoatDvNZWYdAj4mp4oWd2WXBugQBAdgYlggkmVWlvmAI05IbgEWlr4YKzgbkBhUji2UkgDEoBQjT8GcwfarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434552; c=relaxed/simple;
	bh=obzgy79jsMsX7CFtYCimhmncG4DiqG06mP8212i1ONw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ez1qjWuAVHOevr9BAH4Ych1UAKQo9Y05EQgq+M2itI/kqUp+9AgCOrQ65J2NVfE7zCehbUVNGpVeUSyMt+bC9WkOfruU3HgVK8hLfY9o5J4trwiaqys3q+QnxeUKXzD3RGwQ9yx9oaQ7uRdcQaImHSvQYoO0jXIL/E/WCQs8T6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQNgHrGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQNgHrGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466981F000E9;
	Tue,  7 Jul 2026 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434548;
	bh=HVWcqgO7UpZqfxpRBNXi474Gh/EZn0wugMa+aRl6qQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lQNgHrGQspk9vzCcQvKuU4OvaKX4uOC3meoI63u2OL1iQlen3QIxiJZFDOYPYBn8v
	 SsDD7XEUvlocrzC+JhAVAhKQfJcrqR4YleUimCzmNrL8xBTWoiOvvVHLRcvelsbWLl
	 yv4TlNiXs/p4X3T8QVUqGkpAr1vKlxGgHjyax8s3bsTeo9xnmyjv/HNbruuVtb8Hd9
	 ilKoIBFXfq1/01qqu+jW7zvWEQYEPsUpWssg+Kbp4knxR+IIciPQG264NgD3bt+6ra
	 slSRMtmp8iVMTZzK0Ew8bvCqioI2yTXYNPZr+gvNnvlXtNHLlaMPalow/ar3Lb9mEJ
	 9c07dOjOvnHrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/6] riscv, bpf: Using kvzalloc_objs to
 allocate cache buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707142219.2871758-3-pulehui@huaweicloud.com>
References: <20260707142219.2871758-1-pulehui@huaweicloud.com>
 <20260707142219.2871758-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:29:07 +0000
Message-Id: <20260707142908.466981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kvfree(jit_data->ctx.offset)` in `bpf_jit_free` causes a =
memory leak of the JIT context offsets when JIT compilation aborts during s=
ubprogram processing.
--

--- Patch [2]: [PATCH bpf-next v5 2/6] riscv, bpf: Using kvzalloc_objs to a=
llocate cache buffer ---
commit a49923246dc7e8b492561a3a183fc88dc6914fa1
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Using kvzalloc_objs to allocate cache buffer

It is unnecessary to allocate continuous physical memory for cache
buffer, and when ebpf program is too large, it may cause memory
allocation failure.

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index ce3bd3762e08c..367ae923ea40c 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -72,7 +72,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifie=
r_env *env, struct bpf_pr
>  	ctx->arena_vm_start =3D bpf_arena_get_kern_vm_start(prog->aux->arena);
>  	ctx->user_vm_start =3D bpf_arena_get_user_vm_start(prog->aux->arena);
>  	ctx->prog =3D prog;
> -	ctx->offset =3D kzalloc_objs(int, prog->len);
> +	ctx->offset =3D kvzalloc_objs(int, prog->len);

[Severity: High]
This is a pre-existing issue, but does this leak the ctx->offset array if J=
IT
compilation aborts during subprogram processing?

For subprograms during the first pass (!prog->is_func || extra_pass is fals=
e),
bpf_int_jit_compile() returns early, keeping ctx->offset alive for the
subsequent extra pass.

If a later subprogram fails JIT compilation, the BPF core aborts and calls
bpf_jit_free() to clean up the first subprogram:

arch/riscv/net/bpf_jit_core.c:bpf_jit_free() {
	...
		if (jit_data) {
			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
			kfree(jit_data);
		}
	...
}

It appears jit_data->ctx.offset is not freed during this cleanup, which cou=
ld
lead to a memory leak.

>  	if (!ctx->offset)
>  		goto out_offset;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707142219.2871=
758-1-pulehui@huaweicloud.com?part=3D2
