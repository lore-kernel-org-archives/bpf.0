Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4B345CCD
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910738; cv=none; b=rZWW8JbXeW6/gJDgKrYNjfM7Q1QgUS0wpREnISqxeZ1Eqd9JNHa6ruH2RQQGPYdRjvgSwAjybJ+Bi4U8B8W52MHDBggQunY4BHx3j0hiJ0UmkqfXW+L4uUfUWHSpzZZy/R72BZJqL2kdZIpL2zgxdufLzVit+LkiHBHA/HhIuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910738; c=relaxed/simple;
	bh=QQ2g3pyGOmJI3ymEOu6wTDJD5ib9x62qFCyeGhhSZWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E0l+wANSwKQS8kPRKvSg/pvdXZ/694LFEPtli98msPsQIiYTAAgM0ISvQeoF+jHjpjeoasbCabyehK6mHB5thGNeI2Tbd1DL+86YTlcTpqXm2lAxUFnToZNyYZKHkjf+iHDxB2LaSOIfX2+LlraF0Nb8rXztNNHRn2F06gO80KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU+6em/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU+6em/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5367E1F00AC4;
	Wed,  5 Aug 2026 06:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910737;
	bh=+BRAWXwOOnWK4x/r1H2HNe0zkD2IOrjAwljA+h/0pGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XU+6em/CNXqZgW1lfietNExIwtr4OC4d/7ZnNcT5s0B6SiRzLgJusdamD/hnARXET
	 QA5sWK/jC+2qM5bvFj8eZtnF4punj7EyM5by+e4AVVXHJFUEzx25LxzFE2g4qJNxaH
	 87kyRnDZVt3WoFUGcUCiwGDer3Nu1DKqv6tfyDCwvJUlGMSRpgVBRqUr9QA9x2X4vv
	 BD8lCOJ8ig97tQebyXgW5yJCqsy6Ta4WqkDRffi5OAHW6xoZz3DHB82ZBCgTh5JzUv
	 lzeF9sDlfIqO52hWItpUwfPQndKxF5m1aN5/BOPAIhOMm4cv5kDi9G34AxCogcl4+X
	 ssLoy8PdX78Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/8] powerpc64/bpf: fix percpu private stack leak on
 JIT failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <cf132f76a7af898af9f9690952067e213430c43f.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <cf132f76a7af898af9f9690952067e213430c43f.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:18:56 +0000
Message-Id: <20260805061857.5367E1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Percpu private stack memory is permanently leaked in ARM64 JIT on =
compilation error paths.
--

--- Patch [8]: [PATCH v10 8/8] powerpc64/bpf: fix percpu private stack leak=
 on JIT failure ---
commit 04e1b164f2198ac765746ea52f6d89ebc5ed346a
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc64/bpf: fix percpu private stack leak on JIT failure

This commit fixes a percpu memory leak in the powerpc64 BPF JIT compiler.
It ensures the private stack is properly freed on error paths by checking
if compilation succeeded, rather than relying on whether the image buffer
was allocated.

Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel=
.org

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 3c20bb13cfd70..825999f8717bd 100644
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
This is a pre-existing issue, but does a similar memory leak exist in the
ARM64 BPF JIT error path?

Looking at bpf_int_jit_compile() in arch/arm64/net/bpf_jit_comp.c:

out_free_hdr:
        ...
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

If the code jumps to out_free_hdr, ro_header is freed but not set to NULL.
When execution proceeds to out_off, the !ro_header check will evaluate to f=
alse.

Since prog->jited is also set to 0 on these error paths, bpf_jit_free() will
skip freeing the private stack as well.

Could this allow a user to deliberately trigger JIT failures (for example,
by hitting limits during passes) to repeatedly leak percpu memory and
exhaust the allocator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785906979.gi=
t.skb99@linux.ibm.com?part=3D8
