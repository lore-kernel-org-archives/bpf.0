Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228E377555
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995269; cv=none; b=KA7No185+iXOD/+/+DDVgkHTFEsusidSjDB4sentJ8XfG4cuBg9QmUiUpJA9bVY+aUEWE3w9OOlN7rArAO1x2s0/QStRtKs9X6ovA/mOaHqbq31e2scom+fKq2CWxQ95f9NiwGZ3N5VywMZRi72/jaFI0lZkQg1hZmMWF5rYYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995269; c=relaxed/simple;
	bh=+17KCbozy3jXzy4wrcmS8WJtVe393mXaBjyIMEJGxZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwPfU5Yud923zDYb1l2+Pcvs1muANk4ik80GkaZB81RCKam+enZA22VGpfK0sDVw1oH0BbOkA5FXin7ybCBvyxIOQ5auB/1MfLoWB+yfTVO9F2T52wnIFv/yog1uINQxhww0XukdeLL+rCnvYe3yF/ely4d4sqs5e+g5y2XZthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFh0nWyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFh0nWyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309A31F000E9;
	Sat, 25 Jul 2026 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784995264;
	bh=TOKeYd2Nixgdulm8sLZsCciLmPploD8QLeMCpX+kYY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFh0nWyOKDH06j90aJi3pB38/kix/uThKtYv0m0Z+J6Q3wkRNV/adAnkKrY09iMxx
	 VEU/TmBR5ADP43DcxFz563SuxOcoGFktEb9QAGj2gnltdCBn4NpUra6n1EHYaAyKGA
	 LHjTlxD2FQlSMb76u8d9P56dkTEasSBoOp/JStxeIbHnB5qf5K9rIONXxWkiaUSRfA
	 taYPRsYEBcmjOcTwH/KySetg+JbA7a+Z5OtmYsLVyOBm6H9BAzUl/+WIT+zCnm9Aby
	 IbzGr6IaKSJSvxDafgyX8DD1R2nhpL3Zc25fLx20u5Pvj8KWRwYQJy/hxbPc187RUJ
	 XGSRnyf/iJOzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 6/9] bpf, arm64: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725154915.2488611-7-pulehui@huaweicloud.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-7-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 16:01:03 +0000
Message-Id: <20260725160104.309A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `bpf_jit_free()` ignores the return value of `bpf_jit_binary_p=
ack_finalize()`, leading to a Use-After-Free and Double Free if finalizatio=
n fails.
- [High] Pre-existing percpu memory leak of `priv_stack_ptr` on BPF JIT com=
pilation failure.
- [High] The identical memory leak of `ctx.offset` fixed by this patch in A=
RM64 remains unfixed in the LoongArch BPF JIT compiler.
--

--- Patch [6]: [PATCH bpf-next v3 6/9] bpf, arm64: Fix memory leak in bpf_j=
it_free ---
commit c1be108f68505531829d01d1fddc5f23ead947da
Author: Pu Lehui <pulehui@huawei.com>

bpf, arm64: Fix memory leak in bpf_jit_free

When JIT compilation fails for a subprogram, the BPF core cleans up
previously compiled subprograms by calling bpf_jit_free(). This commit adds
a missing kvfree(jit_data->ctx.offset) to bpf_jit_free() in ARM64,
preventing a memory leak of the JIT context offsets array.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4cdc7dfb05ba9..f4e4d4578e38a 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3237,6 +3237,7 @@ void bpf_jit_free(struct bpf_prog *prog)

[Severity: High]
This isn't a bug introduced by this patch, but is there a pre-existing
percpu memory leak of priv_stack_ptr when JIT compilation fails?

Looking at bpf_int_jit_compile() when build_body() fails, out_free_hdr frees
ro_header but does not set it to NULL. In the out_off block:

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    if (!ro_header && priv_stack_ptr) {
        free_percpu(priv_stack_ptr);
        prog->aux->priv_stack_ptr =3D NULL;
    }
    ...
}

Because ro_header is a dangling pointer, this check evaluates to false,
skipping the free. Later, when the BPF core aborts and calls
bpf_jit_free(prog), prog->jited is 0:

arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
    if (prog->jited) {
        ...
    }
    ...
}

This skips the cleanup block entirely, leaving priv_stack_ptr permanently
leaked. Would it be appropriate to address this as well?

>  		 */
>  		if (jit_data) {
>  			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);

[Severity: Critical]
This is a pre-existing issue, but could ignoring the return value of
bpf_jit_binary_pack_finalize() here lead to a use-after-free and double fre=
e?

If bpf_arch_text_copy() fails during finalization,
bpf_jit_binary_pack_finalize() frees the ro_header internally and returns an
error:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
    ...
    if (IS_ERR(ptr)) {
        bpf_prog_pack_free(ro_header, ro_header->size);
        return PTR_ERR(ptr);
    }
    ...
}

Since bpf_jit_free() ignores this error, it proceeds to retrieve the freed
header and unconditionally frees it again:

arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
    ...
    prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();
    hdr =3D bpf_jit_binary_pack_hdr(prog);
    bpf_jit_binary_pack_free(hdr, NULL);
}

Inside bpf_jit_binary_pack_free(), it reads ro_header->size (use-after-free)
and calls bpf_prog_pack_free() on it again (double free). Can this cause
memory corruption?

> +			kvfree(jit_data->ctx.offset);

[Severity: High]
This isn't a bug introduced by this patch, but does the LoongArch BPF JIT
compiler suffer from this exact same memory leak?

Looking at the LoongArch implementation, it uses the same multi-pass logic
for subprograms and preserves ctx.offset in jit_data. However, its
bpf_jit_free() does not free ctx.offset:

arch/loongarch/net/bpf_jit.c:bpf_jit_free() {
    ...
    if (jit_data) {
        bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
        kfree(jit_data);
    }
    ...
}

Should a similar kvfree() be added to arch/loongarch/net/bpf_jit.c?

>  			kfree(jit_data);
>  		}
>  		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725154915.2488=
611-1-pulehui@huaweicloud.com?part=3D6
