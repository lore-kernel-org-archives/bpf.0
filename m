Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9B346FA0
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161526; cv=none; b=RT3/sUmifTgzajGLLU/fLBMgIgTyFw0o8/gI/r6T0UzgJrasBrJou97kiDpNvGnAd4zz1JCMdHXvS8KgUFfTvpzipWq95tBj2v9BH8GVVI0WsQDJSp8JZVtdYHiJX0/N5QyLJ85eAkmY5OB/gLx4cY3p6ibKp56tsLFJqGSBkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161526; c=relaxed/simple;
	bh=bN/+L8jG/vVkOojiYkHVJtg/ppe/d+xGB+pGYcIK92I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=na71s/59qqGdh6G0RipqxEsiPSwNTfr+dfLAtME+QVV8vgOfacU1Cgtr8coDrjvodLTZmEZ5pYpeY04sgXKsF9A1Jbu5vdH0q7C58RIdX4tttcl8UZR+fravnoIAbLnHrgfqa85JrjcDmcaSEFmX1m4OWGXY4s3/MT8Ky5hgVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY8lM5/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY8lM5/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D391F000E9;
	Mon, 31 Aug 2026 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161524;
	bh=r25PUVWcoLeaAq7tvdIbYBvDPkrwgZRCezK2AgWiG00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PY8lM5/xQE0w9/AFtMwSpHESdf4yRP/ncvUHo8TiyPeNP0VqPXgjiG5vV8HwF0InV
	 rAtmnApnyNjs9DH1QPMwkZ+NFnDXVG76WcW9jiqvYU8ncK9i1jtqZa1hE/JyNNbp1C
	 YnkO0+3+F3/L3pfIh4LiN/IpHe54T4c1MBbqg/6sOjo+C4p68bMSHe8abzD906aihn
	 qWZlANyKdEsP5tnvZBHAOE0cU+z2jmlMPJJsFMsO5udNUB7+T1aN73PP5h0LOAZfjk
	 +qSrG2+BRjjSWyzvXjd1sWP1h7m5MmWTvx2nHfXdVaOlI4hRVpEXI7eVF+LxV0+rPB
	 JghIZ58VDGMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/8] powerpc64/bpf: fix percpu private stack leak on
 JIT failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:32:04 +0000
Message-Id: <20260831073204.87D391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The ARM64 BPF JIT compiler leaks the percpu private stack on JIT f=
ailure.
- [High] bpf_jit_binary_pack_finalize uses uninitialized memory for size on=
 failure, causing a system crash and leaking modmem charges.
--

commit a7adca4200815295703e0e825b2bdfcafd6b972e
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc64/bpf: fix percpu private stack leak on JIT failure

The existing conditional statement in bpf_int_jit_compile() frees the
percpu private stack only when the image buffer was never allocated.
If bpf_jit_build_body() fails, the image buffer is already allocated,
so the percpu stack is not freed and leaks. This fix implements freeing
the private stack whenever fp->jited was not set, i.e., compilation did
not succeed.

Link: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel.o=
rg

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index a875521ff904d..8f7501954d9f0 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -357,7 +357,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verif=
ier_env *env, struct bpf_pr
>  				(void *)fimage + FUNCTION_DESCR_SIZE);
> =20
>  out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {
>  			fp->aux->priv_stack_ptr =3D NULL;
>  			free_percpu(priv_stack_ptr);
>  		}

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
...
out_off:
		if (!ro_header && priv_stack_ptr) {
			free_percpu(priv_stack_ptr);
			prog->aux->priv_stack_ptr =3D NULL;
		}
...
}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this fix I
noticed a similar issue in the ARM64 JIT compiler. Does this code leak the
percpu private stack if JIT compilation fails after header allocation?

If bpf_jit_build_body() fails, the error path frees the header but does not
nullify the ro_header pointer. The subsequent cleanup block evaluates to fa=
lse,
failing to free priv_stack_ptr. Since prog->jited remains 0, bpf_jit_free()
also skips freeing it.


kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
...
	ptr =3D bpf_arch_text_copy(ro_header, rw_header, rw_header->size);

	kvfree(rw_header);

	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}
...
}

[Severity: High]
This is a pre-existing issue, but I spotted a potential memory corruption
and resource leak in the BPF core during JIT finalize. Can this error path
cause a system crash and leak modmem charges?

If bpf_arch_text_copy() fails, the size field in ro_header remains
uninitialized (for example, filled with breakpoint instructions by
bpf_fill_ill_insns()). Calling bpf_prog_pack_free() with this wild size
could corrupt the allocator.

Also, does this error path permanently leak the module memory charge by
returning without calling bpf_jit_uncharge_modmem(size)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788154635.gi=
t.skb99@linux.ibm.com?part=3D2
