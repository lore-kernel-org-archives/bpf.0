Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20D3C1411
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253739; cv=none; b=YKybVsmwCJOAtHp9QqjqXWAj+vyqH2F/nLxRJeUduoC0NPrEU9SCUW4ciCKSPBFI4xLFmKhD60PoG2lIs+A3uH8dPSKmc0WFb8Qxk1ZaD3B/vT8ozLknlcUzMmCkTWWOE6xPLT1GnUbEixDfQSsTX8GVlt364QUvyJ70gJKU7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253739; c=relaxed/simple;
	bh=e+xEvWkA7KBbY3IFA1U0+EfnEJr6TeleGCqvF70+Zho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qpMupAq/LHQFTxjY6IyhEZlr5ClWgUN4+p0w3SeHnXl3zcCmHa+cirGKM8DdoCykP5nV6g0QKy9aJmEXLZEAXSjpFH35NUFAUgZITAE+EdvbSkrjBIvgotZOszX1VdFH4VomvECyDlMKnfH1fNVBYb3pKvhtV5ZggucS6pElJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGGkE2SE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGGkE2SE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71D71F000E9;
	Tue, 23 Jun 2026 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782253737;
	bh=+TfWLF/sLIoMJd0PeOJfsDMYWHOSHfakSG03oJJT2jM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SGGkE2SE4dBDX7dYQ0mXlBXjDEjGKhGdlaGq5NojzGpYw2XcVEL7/vefjiSnBSJjI
	 ofKRMDF0iKVYHHVDR/fjhkfmnK95jjD+Z399y0FjfWlcIvbzrV0i5YhkzRjn8EkeDh
	 XBevRcdFmRn+WHEFVVp2fgbVz0CX4nxwL0Xb8x7GFVuotCPd+hc0z0iJc8MRVayvqd
	 J0JRiu9plJ0C9tXufaQ5ixYWiaEtgjLxNEQ+3QPOmcVWuU8C9c5h09L4wl6SYJS3np
	 Jy+2wZRQHJjWHPNyYkm8WQJdF5o4q5s8ycBEMZVD4lO/tHI26IwD5T934f+ceYfUXt
	 5D4cIBTh4WAEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v9 8/8] powerpc64/bpf: fix percpu private stack leak
 on JIT failure
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623231411.6216-9-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
 <20260623231411.6216-9-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:28:57 +0000
Message-Id: <20260623222857.B71D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_jit_free() ignores the return value of bpf_jit_binary_pack_fin=
alize(), leading to a double free, use-after-free, and modmem underflow if =
finalization fails.
- [Medium] The exact same percpu memory leak fixed in powerpc by this patch=
 is also present in the arm64 BPF JIT compiler.
--

commit bd7becf49ebb21e1322fb30107d94244f94e35a2
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc64/bpf: fix percpu private stack leak on JIT failure

This patch fixes a percpu private stack leak on JIT failure in the powerpc64
BPF JIT compiler. It ensures the private stack is freed whenever JIT
compilation fails by checking !fp->jited instead of !image.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel=
.org
Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stac=
k")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 8396ff556f026..cdd16b979c10c 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -403,7 +403,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verif=
ier_env *env, struct bpf_pr
>  				(void *)fimage + FUNCTION_DESCR_SIZE);
> =20
>  out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {

[Severity: Medium]
This is a pre-existing issue, but the exact same percpu memory leak fixed
here in powerpc is also present in the arm64 BPF JIT compiler.

In arm64's bpf_int_jit_compile(), if JIT fails after ro_header is allocated:

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    if (header) {
        bpf_arch_text_copy(&ro_header->size, &header->size,
                   sizeof(header->size));
        bpf_jit_binary_pack_free(ro_header, header);
    }
    goto out_off;
    ...
out_off:
    if (!ro_header && priv_stack_ptr) {
        free_percpu(priv_stack_ptr);
        prog->aux->priv_stack_ptr =3D NULL;
    }
    ...
}

Because ro_header is freed but not set to NULL, it bypasses the cleanup at
out_off, leaking the private stack allocation. Should a similar fix be
applied to arm64?

[Severity: High]
This is a pre-existing issue, but there is a double-free vulnerability in
bpf_jit_free() that affects powerpc, arm64, and x86 when finalization fails.

In arch/powerpc/net/bpf_jit_comp.c:bpf_jit_free():

    if (jit_data) {
        bpf_jit_binary_pack_finalize(jit_data->fhdr, jit_data->hdr);
        ...
    }
    hdr =3D bpf_jit_binary_pack_hdr(fp);
    bpf_jit_binary_pack_free(hdr, NULL);

If bpf_jit_binary_pack_finalize() fails (e.g., due to memory permission
errors), it explicitly frees the RO header internally. However, its return
value is ignored here. The code proceeds to extract the same header and call
bpf_jit_binary_pack_free() again, leading to a double-free and use-after-fr=
ee
(dereferencing the freed size).

The exact same vulnerability exists in the arm64 and x86 JIT compilers. Does
the return value of bpf_jit_binary_pack_finalize() need to be checked to
prevent this double free?

>  			fp->aux->priv_stack_ptr =3D NULL;
>  			free_percpu(priv_stack_ptr);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623231411.6216=
-1-adubey@linux.ibm.com?part=3D8
