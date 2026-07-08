Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161E3E9C1F
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493658; cv=none; b=GEN2CgJFsxFfRpvivFdDvwhG/2ayOz8vPlHMHBReBgY9NY1Z0foZSwzror5brYtzSDR4ipbnSaJu/KXmmFHrJiMLLWKUESGfA9mk9krcP1Rdr62cQwSom4jmBTy2TIJbi8zxuLc4EQ3c7gwaJ9jcHCBkTIZ5T5cZse9Xm8tf6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493658; c=relaxed/simple;
	bh=WhMldWnpgxnGKWeCKUmYe1TZBKuW99FUny9jjhd3eu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4pOfdYu15TxA4Ncp+lbrpjhSlCLdUWbSwmHye2K+oZoClI362cMQpxjn9qb5nToyL4KWqIcfW9owDZJQiUh0eSK73zS4GfeTeLVzdtRxuAUHJRvttaSldzgi5NFJU6b7qU49V23LnsLHc11FGYvEPYxcJvYUyXWN9VddBc+jrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeLhJIcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeLhJIcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4A1F000E9;
	Wed,  8 Jul 2026 06:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783493646;
	bh=8A0crWUxVoqSCyEXFIuituX9pq0uSvsH3eYs8CdghJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LeLhJIcdRcrCTHXTAHdLFtpmzEYNFjls5YKe1qs/hB747MAxFooSdJXYDZYHPMq0Q
	 THNqqRXRvwUpD/XqJKbxC3sm52qE5b5mufG57d356nYxYZaEji7SKJQjv4f2xttRbU
	 8WgBKtULgTKaaCHus1SimwEzuAwiGYYWXazYVmtfsFJGD6Jd4vZ4gQjaQI0EuL7aSC
	 2JgXsQgL8mCJI4J07IMfhTdvsFuDZc1s6sKyCAnGdk7SLVlTQvnnL3JwaHvyY9b/hU
	 FzVXyZIij5viiQurEbOuO1nDBVLRwhNoN0viy+fhFJklWEjgq5M/TdxfmiTF9BOwum
	 UcL9JpXFotALA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 2/7] riscv, bpf: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708064436.2971933-3-pulehui@huaweicloud.com>
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
 <20260708064436.2971933-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 06:54:05 +0000
Message-Id: <20260708065406.66B4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_jit_free() ignores the error return value of bpf_jit_binar=
y_pack_finalize(), leading to a Use-After-Free, Double-Free, and potential =
JIT memory charge limit corruption.
- [High] The identical memory leak fixed in RISC-V remains present in ARM64=
 and LoongArch BPF JIT implementations.
- [High] Memory charge limit (modmem) is permanently leaked when bpf_jit_bi=
nary_pack_finalize() fails in bpf_int_jit_compile().
--

--- Patch [2]: [PATCH bpf-next v6 2/7] riscv, bpf: Fix memory leak in bpf_j=
it_free ---
commit 9c17e0351f5dcd9f2cb6815fc5c5e2c47b738ba2
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Fix memory leak in bpf_jit_free

This commit fixes a memory leak in the RISC-V BPF JIT compiler. When a
subprogram fails to compile, it cleans up earlier subprograms but previously
failed to free the jit_data->ctx.offset array.

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -234,6 +234,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  		 */
>  		if (jit_data) {
>  			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);

[Severity: Critical]
This is a pre-existing issue, but does ignoring the return value of
bpf_jit_binary_pack_finalize() here cause a use-after-free and double-free?

If bpf_jit_binary_pack_finalize() fails (for example, due to a text copy
failure), it frees the ro_header memory chunk and returns an error:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
    ...
    if (IS_ERR(ptr)) {
        bpf_prog_pack_free(ro_header, ro_header->size);
        return PTR_ERR(ptr);
    }
    ...
}

Since bpf_jit_free() ignores this failure, it extracts the now-freed
ro_header via bpf_jit_binary_pack_hdr() below, and unconditionally passes
it to bpf_jit_binary_pack_free(). Inside that function, the freed ro_header
is dereferenced to read its size, leading to a use-after-free, double-free,
and uncharging the modmem with garbage data.

Can this be triggered by an unprivileged BPF program load?

[Severity: High]
This is also a pre-existing issue, but does bpf_jit_binary_pack_finalize()
fail to uncharge the modmem limit when it returns an error?

As shown above, bpf_jit_binary_pack_finalize() frees ro_header on failure
but does not call bpf_jit_uncharge_modmem(). In other callers like
bpf_int_jit_compile(), the error handler detects the failure, clears the
header pointers, and skips calling bpf_jit_binary_pack_free() completely:

arch/riscv/net/bpf_jit_core.c:bpf_int_jit_compile() {
    ...
    if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data-=
>header))) {
        /* ro_header has been freed */
        jit_data->ro_header =3D NULL;
        jit_data->header =3D NULL;
        goto out_free_hdr;
    }
    ...
}

Since out_free_hdr skips bpf_jit_binary_pack_free() when header is NULL,
the modmem uncharge is permanently bypassed. Does this leak the
bpf_jit_limit capacity?

> +			kfree(jit_data->ctx.offset);

[Severity: High]
This isn't a bug introduced by this patch, but do arm64 and loongarch have
the exact same memory leak that is being fixed here for riscv?

Looking at bpf_jit_free() in arch/arm64/net/bpf_jit_comp.c:

arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
    ...
    if (jit_data) {
        bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
        kfree(jit_data);
    }
    ...
}

And similarly in arch/loongarch/net/bpf_jit.c:

arch/loongarch/net/bpf_jit.c:bpf_jit_free() {
    ...
    if (jit_data) {
        bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
        kfree(jit_data);
    }
    ...
}

Neither architecture frees the jit_data->ctx.offset array before freeing
jit_data. Should a similar fix be applied to those architectures?

>  			kfree(jit_data);
>  		}
>  		hdr =3D bpf_jit_binary_pack_hdr(prog);
>  		bpf_jit_binary_pack_free(hdr, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708064436.2971=
933-1-pulehui@huaweicloud.com?part=3D2
