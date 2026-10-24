Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792816580;
	b=29mOvk/KmUwPqTyuFXYGY8ODIXlDS0wCqYeV/Jnypx/nKEW/b396SA4QldNDl8+GrCKf
	 TWmTFstuiTSnpgEBp9UMQttUpDDFCZp4Ulapmrv8NQ1Gmsunlko1WW8IguQdv/dmwlB24
	 oGIYwCvzHtWVh4153ljZrgIQiz26izZpkK+8AD6Iakwrn4n17XzX/ZkCadOdO94wGz7yo
	 xLRFWqfTT8r1XpnXdkayOk8ygg7ec/vLXDrWI/RwDT719My85FQaxsA39IIk2UofHUK5u
	 VZeQFFLdbT+kUNUGEfkBwOsafPjFCS4L5rCFxI6YF0Q0vwTEZ8ibNfSXcggLG6D7/gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792816580;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/xOHDajFF3o4xN4B/1VnY05hUtt8gBxeUxaaYUwlIws=;
	b=rR8g39UM/52fSxPgtJJnX1YlQcjGyQFP67b2dcIbsXF4S5zxNQZQZl9qoYMYD19Hxgi0
	 uuaP0eHK0BP9e5dNabH4PIMqfh1QADipZnF9PDkbZbot+GFoJItictx+VB+2xQllwkVws
	 1JrBWZoRhzs3WbJ9b/ibsJsOr0rR2H4/Itx/y6VsMsj2urGePFg1wA65rEGUZfRm5Nu1F
	 +Tr99tU02Bt2gy3gG8dbQqvFgB710IP9qqVBIxKgyE7zMKUsN6CcfleOKRVZvDSsDOPVg
	 b396Ap3hDcY4mhriMuaB4qtfPVJqce3F913gqw9ApwO+0f3rlit5+rFAsSx1PfcqWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M2yG0xb/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF69606A31A;
	Sat, 24 Oct 2026 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2yG0xb/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90CC1F01825;
	Sat, 24 Oct 2026 04:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792816580;
	bh=/xOHDajFF3o4xN4B/1VnY05hUtt8gBxeUxaaYUwlIws=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M2yG0xb/190Kcv3ADRcpnpu4Hw9PuCaY6Tu7IliLHlkuAO+W9ebsJzuedr9cxzL4R
	 J0VZS2z+2rdJAXnzQdRyE409tekZpTgVlj5SRu+yUSTIoBaRy7/7s7xKGzF8XmUavs
	 IRqTJ53H3lWajZabgYf9BnQ1ko7w0waAsgQX2kC3GywhMVgg/lLT7bZAd26qQcXmxA
	 yv2s+VMRMjXDGmLkkHMCR8YLGkjHE8cvs/utpZQbJ9U+t/xXaiJeBxDmCfLmfQekBo
	 VRvvV0I1tgtrtSt/+0N2Xekn11bsAQ9Bbj0/EoC6Swj2vVsRqIyUUr6tu9EBLCSs6f
	 OoaL8OgNHGFWw==
Content-Type: multipart/mixed; boundary="===============1203158203768635065=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7fe212a5137bf5211aef0a489098fa17f460e7cbc307afb2ca434af4674126bd@mail.kernel.org>
In-Reply-To: <20261024035902.44566-1-hackerowskiy@gmail.com>
References: <20261024035902.44566-1-hackerowskiy@gmail.com>
Subject: Re: [PATCH] libbpf: fix helper macro C++ compatibility
From: bot+bpf-ci@kernel.org
To: hackerowskiy@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,hackerowskiy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 04:36:19 +0000 (UTC)

--===============1203158203768635065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: fix helper macro C++ compatibility

TL;DR:
- bpf_for() and bpf_repeat() may still fail to compile in C++ (void *
  initializer left unchanged)
- Fixes: tag looks inaccurate and would pull this into stable trees
- Nit: generated-header comment misplaced

>     libbpf: fix helper macro C++ compatibility
>
>     C++26 warns about the GNU named variadic parameter syntax in
>     bpf_helpers.h, which prevents consumers from using the header with
>     -Werror=variadic-macros. Replace the named parameters with __VA_ARGS__.
>
>     C++ also rejects implicit conversions used by helper argument packing,
>     bpf_for_each, and generated helper function pointers. Use explicit
>     integer and typed pointer casts so these helpers can be parsed and used
>     from C++.
>
>     Verified with GCC and Clang C++26 syntax checks using helper macros,
>     an ARM64-targeted BPF C smoke build, and generated helper definitions
>     from scripts/bpf_doc.py. checkpatch.pl reports no errors or warnings.
>
>     AI assistance: OpenAI Codex helped reproduce the C++26 failures and
>     draft changes to tools/lib/bpf/bpf_helpers.h and scripts/bpf_doc.py.
>     The human submitter must review the changes and test results before
>     submission.
>
>     Fixes: d6a6a55518c1 ("libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h")
>     Closes: https://github.com/libbpf/libbpf/issues/974
>     Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>

Is this Fixes: tag accurate?

d6a6a55518c1 only moved BPF_SEQ_PRINTF and BPF_SNPRINTF from bpf_tracing.h
to bpf_helpers.h.  Their args... syntax came from c09add2fbc5a
("tools/libbpf: Add bpf_iter support").

The other constructs changed here came from different commits:

  - bpf_printk()'s args... and ##args from c2758baa9798 ("libbpf: Modify
    bpf_printk to choose helper based on arg count")
  - bpf_for_each()'s (void *)0 initializer from the open-coded iterator
    work, moved into bpf_helpers.h by c5e647416708
  - the "(void *) %d" helper initializer in the generated header from
    7a387bed47f7 ("scripts/bpf: teach bpf_helpers_doc.py to dump BPF
    helper definitions")

None of those commits broke C++ support for the header.  It never had C++
support, so this patch looks like it adds it rather than fixing a
regression.

The tag would also mark this change for stable trees back to v5.14, many of
which do not have bpf_for_each(), bpf_stream_printk() or __bpf_vprintk().

Should the Fixes: tag be dropped, given that Closes: already gives the
motivation?

> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 15d113a1bc1d..02e31ad509af 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -829,6 +829,11 @@ class PrinterHelpersHeader(Printer):
>  /* Forward declarations of BPF structs */'''
>  
>          print(header)
> +        print("#ifdef __cplusplus")
> +        print("#define ___bpf_helper_stub(id, name) reinterpret_cast<decltype(+name)>(id)")
> +        print("#else")
> +        print("#define ___bpf_helper_stub(id, name) ((void *)(id))")
> +        print("#endif")
>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
>          print('')

This isn't a bug, but the header string ends with the comment
"/* Forward declarations of BPF structs */", and this new block is printed
right after it, before the struct declarations.  The generated
bpf_helper_defs.h now reads:

    /* Forward declarations of BPF structs */
    #ifdef __cplusplus
    #define ___bpf_helper_stub(id, name) reinterpret_cast<decltype(+name)>(id)
    #else
    #define ___bpf_helper_stub(id, name) ((void *)(id))
    #endif
    struct bpf_fib_lookup;

So the comment now sits on top of the macro block instead of the forward
declarations.  Could the #ifdef block be printed before the comment, or after
the forward declarations and the blank line, so the comment stays next to the
declarations it describes?

[ ... ]

> @@ -382,16 +403,18 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
>   * extension: __attribute__((cleanup(<func>))), supported by both GCC and
>   * Clang.
>   */
> -#define bpf_for_each(type, cur, args...) for (							\
> +#define bpf_for_each(type, cur, ...) for (							\
>  	/* initialize and define destructor */							\
>  	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
>  						    cleanup(bpf_iter_##type##_destroy))),	\
>  	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
>  			       *___p __attribute__((unused)) = (				\
> -					bpf_iter_##type##_new(&___it, ##args),			\
> +						bpf_iter_##type##_new(&___it, \
> +								       ##__VA_ARGS__), \
>  	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
>  	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
> -					(void)bpf_iter_##type##_destroy, (void *)0);		\
> +					(void)bpf_iter_##type##_destroy, \
> +					(struct bpf_iter_##type *)0); \
>  	/* iteration and termination check */							\
>  	(((cur) = bpf_iter_##type##_next(&___it)));						\
>  )

The commit message says C++ rejects the implicit conversions used by
bpf_for_each(), and this changes its ___p initializer from (void *)0 to
(struct bpf_iter_##type *)0.  The sibling macros bpf_for() and bpf_repeat()
still end their ___p initializer with:

    (void)bpf_iter_num_destroy, (void *)0);

___p is declared as struct bpf_iter_num * there (in the same declaration as
___it), and C++ does not allow an implicit conversion from void * to
struct bpf_iter_num *.

Won't a C++ BPF program that uses bpf_for(i, 0, N) or bpf_repeat(N) still
fail to compile with the same error this patch fixes for bpf_for_each()?
Since the stated goal is that "these helpers can be parsed and used from
C++", should bpf_for() and bpf_repeat() get the same
(struct bpf_iter_num *)0 change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40061559445
--===============1203158203768635065==--
