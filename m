Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860E3CF963
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975513; cv=none; b=c/4vzVzmNV+sT+L1W4z1oOk+YtvbkA4+AailcweonILmnVR67jeQkhFIn8YuuntF0sxSfkDxrNwYorK3KdGmqdY0Hc31P5B5CqD5pLKQK32ja67Arv6Kiyjg9SZvWSF0KmLMnPbEHk/rPXj28v+Sw+VICsA++sadKXuX9PwpkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975513; c=relaxed/simple;
	bh=fDcLNSGwmQ/iaXf8Gv995YLtuvCbtgY62a4ytpL+4/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=exFLsCQw9wcLrRjHjUDnHk2UVQhT1RgoppFjFJChz7Bjiss7/QeWaiTAda0m6MNmeutIzEHi/U4hNk0z1xTvIMOtu3e4wgcZhku2zlM/1BZ4to/bZMCxiW/efLZZw7YSxGtlZf2YTMhKNOTeBgCeo22YeLDJNyhgz8bhBfSGKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ila0eAT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ila0eAT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155841F000E9;
	Sat, 25 Jul 2026 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975512;
	bh=ahU8/jroF41nMCrK2ZKzd7LZjWKPVSMkiQ//X3K/Ppk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ila0eAT/0vks50G/vrGN+qgREauiXCLKirQRckE4b/oof+Q7c55O7eEojkU7jBLyy
	 oW5DnbRE1MXG2eXBZH3eTyp76FunyPKfTDY98PnO5tQmwmIFw67maj5/Ty5OeRceZ8
	 c3aLMvMR7eAAD5bgZDEQ+LDfaoDg/d9XshLpu3QUlHUVKTh02eZsFDImMZ+zoJfI76
	 5St9aPM4bRylvJ4U60ThhrQDa7Bg1W+Muerka8/Vs2Emcu7H6mhRizib5X7gK8vzXy
	 4xFg3AtyY1ozJPxQo9tkCCYRiVGBjSQdCCqnD/3mAyF8DoR1CvvU6tRLUDSmhknS7D
	 Y7RaNQISyX6dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] bpf, arm64: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725102020.2287770-2-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
 <20260725102020.2287770-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:31:51 +0000
Message-Id: <20260725103152.155841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `bpf_jit_binary_pack_finalize()` fails during `bpf_jit_free()`,=
 it leads to a Use-After-Free and Double-Free of `ro_header`.
- [Medium] Pre-existing memory leaks of intermediate JIT state (`jit_data`,=
 `ctx.offset`, etc.) in other architectures when JIT compilation of subprog=
rams aborts.
- [Medium] The per-CPU private stack (`priv_stack_ptr`) is permanently leak=
ed when JIT compilation fails after allocating `ro_header` on ARM64.
--

--- Patch [1]: [PATCH bpf-next v2 1/7] bpf, arm64: Fix memory leak in bpf_j=
it_free ---
commit da1c3e7675f67e35f9b079e317bc882f8ea47e77
Author: Pu Lehui <pulehui@huawei.com>

bpf, arm64: Fix memory leak in bpf_jit_free

When bpf_int_jit_compile() is called for subprograms, it returns early
during the first pass (!prog->is_func || extra_pass is false), keeping
ctx->offset alive for the subsequent extra pass.

If JIT compilation fails for a later subprogram, the BPF core aborts and
calls bpf_jit_free() to clean up the first subprogram. However,
bpf_jit_free() fails to free jit_data->ctx.offset, which causes a memory
leak of the JIT context offsets array.

Fix this by adding the missing kvfree(jit_data->ctx.offset) in
bpf_jit_free().

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4cdc7dfb05ba9..f4e4d4578e38a 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3237,6 +3237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  		 */
>  		if (jit_data) {
>  			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);

[Severity: High]
This isn't a bug introduced by this patch, but does ignoring the return
value of bpf_jit_binary_pack_finalize() here cause a use-after-free?

If bpf_jit_binary_pack_finalize() fails internally, it frees ro_header.
However, because the return value is ignored, execution continues to:

    hdr =3D bpf_jit_binary_pack_hdr(prog);
    bpf_jit_binary_pack_free(hdr, NULL);

This would retrieve the already-freed ro_header and call
bpf_jit_binary_pack_free() on it again, leading to a double-free. Is
it necessary to check the return value of bpf_jit_binary_pack_finalize()
here?

> +			kvfree(jit_data->ctx.offset);

[Severity: Medium]
This is a pre-existing issue, but does this same intermediate JIT state
leak in other architectures when JIT compilation of subprograms aborts?

For example, architectures like S390 and SPARC64 allocate jit_data in
bpf_int_jit_compile() but appear to lack a bpf_jit_free() override to
clean it up, falling back to the weak generic implementation which only
frees the binary header.

Additionally, LoongArch's bpf_jit_free() frees jit_data but seems to miss
the same kvfree(jit_data->ctx.offset) that this patch adds for ARM64.

Could these other architectures be updated to prevent permanent memory
leaks of jit_data and ctx.offset on error paths?

[Severity: Medium]
This is also a pre-existing issue, but does the error handling in
bpf_int_jit_compile() permanently leak the private stack?

If bpf_int_jit_compile() fails after allocating ro_header, it jumps to
out_free_hdr:

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
out_free_hdr:
    if (header) {
        bpf_arch_text_copy(&ro_header->size, &header->size,
                           sizeof(header->size));
        bpf_jit_binary_pack_free(ro_header, header);
    }
    goto out_off;

out_off:
    if (!ro_header && priv_stack_ptr) {
        free_percpu(priv_stack_ptr);
        prog->aux->priv_stack_ptr =3D NULL;
    }
    ...
}

Because ro_header is freed but never set to NULL before jumping to out_off,
the (!ro_header && priv_stack_ptr) condition evaluates to false, skipping
the free_percpu() call. Since prog->jited is set to 0, bpf_jit_free() also
bypasses its cleanup block, permanently leaking priv_stack_ptr.

Should ro_header be set to NULL in out_free_hdr to ensure the private stack
is properly freed?

>  			kfree(jit_data);
>  		}
>  		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725102020.2287=
770-1-pulehui@huaweicloud.com?part=3D1
