Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7208473C88
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107907; cv=none; b=TpwCEpHbC4jMS+gQE8xCQyWl8h1xq6fo7QOnFHVCArw3Wh5ydWGLq8eJwROk8gl4FJPFHoCQiiGMLirjtHuKfipyMae5eSfWx1Y92WhIbMT8fGweISNXMd60V5gE5ISR+9InInR0cbsIdPvQqUW0T4LKQA5nZN6/FCwtrWIFhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107907; c=relaxed/simple;
	bh=O/m2pqCzaYrCW86t1l0OBHOXHBiAmqoY3OYda+XIzmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IQ7Y1JtAHI+t98Iq4q8pvGbmoMY//NrHRpvWVhoeR1iHqXgosZvXVss0vBXhJZEoeuQQdWylWSGWlkUaKSrCJyZ9Oa59R/EWYwxqhmPtKpcewUHLhqaMcwfL16gRfdvhcCAvUEycmHVJrcS/TIZoItJEhxJmUAIx92Xo1tGawTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx4F1+uZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx4F1+uZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1804F1F00A3A;
	Fri,  7 Aug 2026 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107899;
	bh=dEkTUXvIXaYA1Pcv1Nf1NJ/a0zJope5+BrgRnG4yGHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mx4F1+uZRxhpTVoQdVqqtjB8baSxva2gPRUjpOiOHfMCWuhb8dmBp41mTOvs/tcOW
	 qiU55aEi+0KsdgImQNthgWNYQws81R8KSJmAPLq5VhO8K/2iwSOGp2sS6Q7wWoJccK
	 5m2UB8XMBmlDant+ZXedJJ75xWXeXXIqep6fk5gWg4CsczSLXfUSi5v6FCgY9cZStK
	 75xd0J6HiwqN+w7Do+jMww10WHSAOkW23DNKvcEvE0Vcnay8yiovQUtJXXQP1gms7/
	 WO4EznCST38kONCpfdq2UX1qQnwfSJbCBRGj5+HB1CG2izeYh35gK0cwgkJg1lOglu
	 PiFs9406bGUEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH  v11 8/8] powerpc64/bpf: fix percpu private stack leak
 on JIT failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <6bbf4249e47dc14ac65d72c304bf9335cf10b206.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
 <6bbf4249e47dc14ac65d72c304bf9335cf10b206.1786099877.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 13:04:58 +0000
Message-Id: <20260807130459.1804F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In `bpf_jit_binary_pack_finalize()`, if `bpf_arch_text_copy()`=
 fails, it uses uninitialized `ro_header->size` to free the pack (causing b=
itmap corruption) and fails to uncharge modmem.
- [Critical] If `bpf_jit_binary_pack_finalize()` fails during `bpf_jit_free=
()`, the JIT memory pack is double-freed.
- [High] The ARM64 BPF JIT compiler has the exact same percpu private stack=
 memory leak on failure paths that this patch fixes for PowerPC.
--

--- Patch [8]: [PATCH  v11 8/8] powerpc64/bpf: fix percpu private stack lea=
k on JIT failure ---
commit e1be4be6e638db0714dd1f4ef6a5f98e6f888db6
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc64/bpf: fix percpu private stack leak on JIT failure

The existing conditional statement in bpf_int_jit_compile() frees the
percpu private stack at out_addrs only when the image buffer was never
allocated.

Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel=
.org

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 2cc1124ed5303..395f1458db2e6 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -404,7 +404,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verif=
ier_env *env, struct bpf_pr
>  				(void *)fimage + FUNCTION_DESCR_SIZE);
> =20
>  out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {
>  			fp->aux->priv_stack_ptr =3D NULL;
>  			free_percpu(priv_stack_ptr);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but the ARM64 BPF JIT compiler
has the exact same percpu private stack memory leak on failure paths that
this patch addresses for PowerPC.

In arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile():

    out_off:
		if (!ro_header && priv_stack_ptr) {
			free_percpu(priv_stack_ptr);
			prog->aux->priv_stack_ptr =3D NULL;
		}

On failure paths jumping from out_free_hdr, ro_header is not NULL, causing
the percpu stack free to be skipped. Could this also exhaust percpu memory
on ARM64?

[Severity: Critical]
This is a pre-existing issue, but if bpf_jit_binary_pack_finalize() fails
during bpf_jit_free(), does this double-free the JIT memory pack?

In arch/powerpc/net/bpf_jit_comp.c:bpf_jit_free():

		if (jit_data) {
			bpf_jit_binary_pack_finalize(jit_data->fhdr,
                                                     jit_data->hdr);
			kvfree(jit_data->addrs);
			kfree(jit_data);
		}
		hdr =3D bpf_jit_binary_pack_hdr(fp);
		bpf_jit_binary_pack_free(hdr, NULL);

If jit_subprogs() aborts early and calls bpf_jit_free() on subprograms,
bpf_jit_binary_pack_finalize() is called. If its internal text copy fails,
it internally frees ro_header. However, the return value of
bpf_jit_binary_pack_finalize() is ignored here, and bpf_jit_binary_pack_fre=
e()
is called again, which seems to double-free the same pack structure.

The same pattern appears to exist in arch/x86/net/bpf_jit_comp.c:bpf_jit_fr=
ee()
as well.

[Severity: Critical]
This is a pre-existing issue, but does bpf_jit_binary_pack_finalize() use
uninitialized memory if bpf_arch_text_copy() fails?

In kernel/bpf/core.c:bpf_jit_binary_pack_finalize():

	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}

If bpf_arch_text_copy() fails, ro_header->size has not been initialized.
Could this clear arbitrary memory regions in the shared pack allocator bitm=
ap
and permanently leak the module memory charge since bpf_jit_uncharge_modmem=
()
is missing on this error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786099877.gi=
t.skb99@linux.ibm.com?part=3D8
