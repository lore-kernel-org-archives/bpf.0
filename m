Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDA3AF66C
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179019; cv=none; b=fW3Ox2HgJjFbuuSMedq06D6IBPIhLTVva6/ZNcbmLyUiLFWOl3FWcB8vdJmwe630z8YUQdBFL48fjNq5OqrHHlZSTs0tIFoVp7RKEiTZAJ/TfTIImUzrpHyt84+D3TdI9GNXf9EgE1nNdBdcWDU5Z0RISW6upraXTitblCyNRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179019; c=relaxed/simple;
	bh=EgePiNzqOHlTmn6eSyFm2yZCk87uMBnatvuh+2WL9Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moDdc6rawKQHnITbgGT7W5XxAdeg+ut2NinIwvN5U/W3ROhD8eh5yu2ya+SZVRkhk14J4prfIY8FkeZwVhSgSJJO5FJJtjnTFbpjdtNeZg+K+8sZom4TYrlEP+JX4PrfxrgCfmQz83lo5OyVJEFjpT25arjWG6lEM58h0HEawhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFNyEfrh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFNyEfrh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2531f453eeso519862566b.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179016; x=1788783816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R3xu2DcsHieX60WKk129vxVnsq8TaDh4751No9WMxO4=;
        b=QFNyEfrhzEdFwz9IJjHXQZI6h7RHfiWmibkJPkLREcKrIQaaoRqQiLpoP324N3hmwV
         Dm4Lv+/UavLx3xOdvu9lHaYmDupERS8gk9mBnaJmAUN92ADf1WZdgn7gT/oUZ60wy4+q
         iDVZU2uKeV/Od5JNJ9RJAhnq58YCfTgPH3TXRuyP2caxEZGHTzjtN/tXNuAei2cfZl8R
         vI+FYe+SYpomW7XstjF+d5Y+djNs848QcP8HRvGHFax25yETOo27n8C0dngDpesVpHo7
         oNg/JaqY+bz/qp192czofsr8eBiB4RAp0DsFEqzpSU5/uTYgzKJeImj/PMQ9lTqMGxQa
         AM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179016; x=1788783816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3xu2DcsHieX60WKk129vxVnsq8TaDh4751No9WMxO4=;
        b=A8PQL7IfLqvmc4wI//SyysLpa7c1FGmrLHJZmsHsqbVZJ7OhQRrs8pNB6UiAKqpGwF
         XTLtWZQ0kqUi/JdwGJrCd3R89k2DodkXK4s0b2XzFzQ7K/iks/Lx7XcwykpG5gsgGPOa
         NEVXbnghl7PgIXtIKAoK95dYbpMTbnJ2ohIPqNzUdGDQQtX/S8ux3vQreX2K0LR9o088
         mi3e5jSzTtPE0EprLE6zgCgLh7Di8cd6LA62OhKzA/SvAjxX6gkU64KZ2y99Z775CwD1
         YU0XMmLjPMolzcBLuIuv4Ur1LXT02rEmkwCZVt7Ux4G1o/5c6ywVRleqcyECH0h63jib
         Telg==
X-Gm-Message-State: AFuF++k8lTn2zxl7bkAs0XUaDOzZ2/kDPw/ueqKJ5see6+H9CQ1ZcJ0R
	603R94VEvp8SR86VPnDbW19Lh/lzRCZn0S0PlvqV/TkqaOwg71l31o6+
X-Gm-Gg: AR+sD121TkzhAU/DESwgnz4eCucgCaos8ABWSWgFADH/0uJTvDtSWhDwHbPULgb+Y9r
	tzvdDMPKJM/HJeocGNvB45cJRHkLsGzMB4HyninagpuDqGonrcpNg5JQW+mLfrXSbBj9faOo3Zp
	DyqeGDc7d89OTS6hNRTdgoXpKdTZ/KwoqmqIqnSXQBzBpgJrSkyRCGDkZDs/GAnE2350hp+nxRv
	Hv+cDp3FZoeBSZ7GlyCqqYuZxKYLVwrFQ5+J0KyKO1xxcYjej/Vyhsr4HjAQq/4+dM7um9dHEgK
	pRfMJPgygllIV4lTEHYImlwYppkDOvsungGjcYo3sodl6jgvjSZzC8UrNnTWTKCgoQCRifmlriM
	HstmVMLJOIVw25lrBamPiQtbVkjjAHIzQSjNcqTPI1QVIi++l9SRfiZqBRqD0N+5/xFepHVods8
	gTvOIU/WkeCVxNjpWUlbT+m9qeebwd8DtfwYhXeunLQLrylTz76GoSn48Y/OC83JlcCyuA
X-Received: by 2002:a17:906:39d3:b0:c08:417e:3696 with SMTP id a640c23a62f3a-c25b3da372amr3820866b.20.1788179016049;
        Mon, 31 Aug 2026 05:23:36 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1febf3sm417033366b.52.2026.08.31.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:23:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:34:16 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>, rachelmenge@gmail.com,
	hargar@microsoft.com, apais@microsoft.com
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add compiler-layout
 terminal gotox test
Message-ID: <apV0yDcJ5dS7ZRCp@mail.gmail.com>
References: <20260830073125.360934-1-sidchintamaneni@gmail.com>
 <20260830073125.360934-2-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830073125.360934-2-sidchintamaneni@gmail.com>

On 26/08/30 07:31AM, Siddharth Chintamaneni wrote:
> Add coverage for the instruction layout emitted by LLVM for a computed
> goto. The jump-table targets precede the dispatch block and gotox is the
> final instruction in the subprogram.

I would shorten this, and remove mention of compiler altogether (this
is not a compiler bug after all). Just explain that we add a test
where gotox is the terminal instruction of a program.

> An equivalent unoptimized C source is:
> 
>     int bpf_prog_trigger_syscall_prog(void *ctx)
>     {
>             __label__ l1, l2;
>             void *tgt;
>             int ret = 0;
> 
>             if (ctx)
>                     tgt = &&l1;
>             else
>                     tgt = &&l2;
>             goto *tgt;
>     l1:
>             ret += 1;
>     l2:
>             ret += 2;
>             return 0;
>     }

This is absolutely not obvious why this must necessarily 
translate to the test you're added. Also, again, this tests
the verification, not code generation. Just omit this C chunk.

> 
> Tested:
> 
>     #646/5 verifier_gotox/jump_table_compiler_layout:OK
>     #646 verifier_gotox:OK
>     Summary: 1/28 PASSED, 0 SKIPPED, 0/0 FAILED

This output is not adding any information, please omit it.

> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_gotox.c      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> index 5b18c9a27717..0ea445287175 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -47,6 +47,61 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  
> +SEC("socket")
> +__success __retval(0)
> +__naked void jump_table_compiler_layout(void)
> +{
> +	asm volatile ("						        \
> +	.pushsection .jumptables,\"\",@progbits;			\
> +jt_l1_%=:								\
> +	.quad l1_%= - socket;						\
> +	.size jt_l1_%=, 8;						\
> +	.global jt_l1_%=;						\
> +jt_l2_%=:								\
> +	.quad l2_%= - socket;						\
> +	.size jt_l2_%=, 8;						\
> +	.global jt_l2_%=;						\
> +	.popsection;							\
> +									\
> +	*(u64 *)(r10 - 8) = r1;						\
> +	*(u32 *)(r10 - 20) = 0;						\
> +	r1 = *(u64 *)(r10 - 8);						\
> +	if r1 == 0 goto select_l2_%=;					\
> +	goto select_l1_%=;						\
> +select_l1_%=:								\
> +	r1 = jt_l1_%= ll;						\
> +	r1 = *(u64 *)(r1 + 0);						\
> +	*(u64 *)(r10 - 16) = r1;					\
> +	goto selected_%=;						\
> +select_l2_%=:								\
> +	r1 = jt_l2_%= ll;						\
> +	r1 = *(u64 *)(r1 + 0);						\
> +	*(u64 *)(r10 - 16) = r1;					\
> +	goto selected_%=;						\
> +selected_%=:								\
> +	r1 = *(u64 *)(r10 - 16);					\
> +	*(u64 *)(r10 - 32) = r1;					\
> +	goto dispatch_%=;						\
> +l1_%=:									\
> +	w1 = *(u32 *)(r10 - 20);					\
> +	w1 += 1;							\
> +	*(u32 *)(r10 - 20) = w1;					\
> +	goto l2_%=;							\
> +l2_%=:									\
> +	w1 = *(u32 *)(r10 - 20);					\
> +	w1 += 2;							\
> +	*(u32 *)(r10 - 20) = w1;					\
> +	w0 = 0;								\
> +	exit;								\
> +dispatch_%=:								\
> +	r1 = *(u64 *)(r10 - 32);					\
> +	.8byte %[gotox_r1];						\
> +"	:
> +	: __imm_insn(gotox_r1, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> +					    BPF_REG_1, 0, 0, 0))
> +	: __clobber_all);
> +}

This assembly can be simplified, no reason to pass something
generated from C. Just create a JT with one target, and jump
to it from the end. Something around

      0: rX = &jump_table  /* jump_table[1] = { &&ret, } */
      1: rX = *rX
      2: goto end
    ret:
      3: return 0
    end:
      4: gotox *rX

Also, if you want a full selftest coverage, another selftest should
check the same thing for a subprogram, not the main prog.

> +
>  /*
>   * Gotox is forbidden when there is no jump table loaded
>   * which points to the sub-function where the gotox is used
> -- 
> 2.43.0
> 
