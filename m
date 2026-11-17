Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911803;
	b=5YeyEbAoJ4OVgNcIhlNnVaM5+8to8r0Bes9gWb1WBN9zk65+GnHwdtCe7YKGJCS1y3f+
	 BiBRGRPG9AJ+AX/AmtS6Z1p6NxOqbN8uxw1e+ddkWx1gl7G8tCYHUujew7yRv9SMVEy1o
	 C0y1episBl5AIdNouuQv2dr2vkKYGo1CE/5bAstZKlH9BqIMi5+HH3MZ7O4M8dumTCvUX
	 +CqDc3i5Ntj4uI3o54v3A/U6zLiwck9V7jZhR4cManvIzgMmVsHdYN1ouUY8+d1jhM70n
	 qnsth/B/dO0MyDtJhw94KItUViqFGS2Ng3MPr2jFUexY7v5W9haGXONNCUU2lrmArDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911803;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=W7/QaHpkHyTfOK9xU5LhKZLTEQkM2Ku0OEx+IVzZMX4=;
	b=Vbox4y17yQOSun7s+4TsxObdu4nT/vI9uUYFW7z2fL0Nx6j1w2FXCvQDZG1YHmE3XBLa
	 TroKS0O6wLyo9UFHBEWXG6dqs05LSlMkKsK0QuWfx039RJ/H7TG3nObiwt6vq5YmrfVqn
	 ZRyAFFIqQU1ET8gKUhnyrAykbTty+nJoUYYOTmwUh83ZxDCpiGjm5QkbeiRE2vlnqc3AF
	 qTgMZ+1v7l568GaQLe+yZp++M53GkX6Mj+ny+eZk2cUDLla9TR6PdgVdCppZazo3k+5fw
	 nXyg7EyTKOIQW2N1/1t+SLq0qUX+54IdOeW4Fv3/pEpKzvZtn7jrwB8vzLlanQq1x6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/v1YVZF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F966606A333;
	Tue, 17 Nov 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/v1YVZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87761F000C5;
	Tue, 17 Nov 2026 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911802;
	bh=W7/QaHpkHyTfOK9xU5LhKZLTEQkM2Ku0OEx+IVzZMX4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=W/v1YVZFlJz5yB+18UCRiF+kRuXtBh6JtwtFIgtu0xwblRXGDHHEdULz42uN9CUf0
	 gwZxE7J8vRe8/uox/AwWfKwR9arlpQD/lzIq+1LU3NMEBy/SqiZfi3gvtbRpKD9wyC
	 r6d4hZuv+c6KgwLBc8oWjnlE8cgQwdQ73p7kZFnqZQLFHLxCe/aGzcIsMw8XYvKB2H
	 bI575yp6At7xfQgYVQkN6AFRCDaOnjx1VcAr3yJ0u3Pm02b7cpWBuZ+PH1dK7V0wHZ
	 ja5xalKQB8zEKw0ImYll5rNCCSZYe4fu/LA7EgeAug/ZS05GCh0IdCroENonrXopnV
	 eCcGPz9T9u5Yg==
Content-Type: multipart/mixed; boundary="===============4015773494338833298=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <146c493fb3b8d5f5171ad146cdc23e4f2693e1e142ad11ca67db5eae60cd4abb@mail.kernel.org>
In-Reply-To: <20261117095110.2736779-1-visitorckw@gmail.com>
References: <20261117095110.2736779-1-visitorckw@gmail.com>
Subject: Re: [PATCH v10] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,corbet@lwn.net,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,gerg@linux-m68k.org
Cc: skhan@linuxfoundation.org,rdunlap@infradead.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,marscheng@google.com,eleanor15x@gmail.com,jserv@ccns.ncku.edu.tw,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,visitorckw@gmail.com,daniel@thingy.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 17 Nov 2026 10:36:39 +0000 (UTC)

--===============4015773494338833298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> m68k, bpf: Add initial BPF JIT compiler support

TL;DR: bpf_int_jit_compile() has no check for an already-JITed prog, so
jit_subprogs()'s second pass may leak the first executable image, e.g. with an
exception_callback tag, letting a CAP_BPF user exhaust JIT memory.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
> +{
> +	struct bpf_binary_header *header;
> +	struct jit_ctx ctx;
> +	unsigned int image_size;
> +	u8 *image_ptr;
> +
> +	if (!prog->jit_requested)
> +		return prog;
> +

[ ... ]

> +	header = bpf_jit_binary_alloc(image_size, &image_ptr, 2, jit_fill_hole);
> +	if (!header)
> +		goto out_off;

[ ... ]

> +	prog->bpf_func = (void *)ctx.target;
> +	prog->jited = 1;
> +	prog->jited_len = image_size;
> +	goto out_off;

If jit_subprogs() calls bpf_int_jit_compile() a second time on a func[i]
that is already JITed, doesn't this allocate a new header and overwrite
prog->bpf_func, leaving the first image unfreed?

jit_subprogs() in kernel/bpf/fixups.c calls bpf_int_jit_compile() twice
for every subprog, once in the first loop and again in the extra pass:

    old_bpf_func = func[i]->bpf_func;
    tmp = bpf_int_jit_compile(env, func[i]);
    if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
        verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
        err = -ENOTSUPP;
        goto out_free;
    }

On the second call only prog->jit_requested is checked, which is still
set, so both passes run again.  bpf_jit_binary_alloc() returns a new
header and prog->bpf_func is overwritten.  The out_free path then calls
bpf_jit_free(func[i]), which frees only the header that
bpf_jit_binary_hdr(func[i]) finds, i.e. the new one.  The first image
and its bpf_jit_charge_modmem() charge are never released.

Rejecting BPF_PSEUDO_CALL in emit_call() and BPF_PSEUDO_FUNC in
build_insn() doesn't cover every path to the extra pass.  A program whose
main function has an "exception_callback:" BTF decl tag gets a second
subprog via bpf_find_exception_callback_insn_off() -> add_subprog() in
kernel/bpf/verifier.c.  The main program doesn't need to call that
subprog or use bpf_throw().  Both functions JIT successfully in the first
loop since they contain no calls, and the extra pass then leaks func[0]'s
first image on every load.  A CAP_BPF user (needed for BTF) loading such
programs repeatedly could leak executable memory without bound and keep
growing bpf_jit_current.

The JITs that support bpf-to-bpf calls (x86, arm64, riscv, powerpc,
loongarch, parisc, arc) detect the extra pass via prog->jited or jit_data
and reuse the image.  Would an early return when prog->jited is already
set work here?  jit_subprogs() would then see the same bpf_func and
finish, and that seems safe because any real call or callback has already
made the first pass fail.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44061095782
--===============4015773494338833298==--
