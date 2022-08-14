Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799DC25B06
	for <bpf@archiver.kernel.org>; Sun, 14 Aug 2022 20:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiHNUYa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 14 Aug 2022 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNUY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 16:24:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B911E3F6
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 13:24:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so7362421edd.13
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=tx7ZPmi7etTZwSg5dTQ5XCgwiSXZitCQE8bpHf299+Q=;
        b=mCRjE6spi40YULCk27MiMzHyZiOrj89Tg/x30HlvdAepuClX5EpoBPpnWqFc3g/TPc
         CMS7+pw9A85xUbvjzeuiqPGlXPjY8Bb9ZHWo5FuySd0uHhy922g+SnXcISw6boYSCLko
         Ccv9iaubn3zf5qStd9M1j9Gizebzu57HWjMT6lCTtLaY5dTP1BXKMiCAsn6jzm3AcKsP
         KJHXbkjFH9DAeExAUIZ+Ngoiw8BviHfjorwOe40oAvAk/7vCxhdYktmCnrg1XGdGRXnL
         zKOhfUtLWLzkneqxdKxBN2AZp/Z4XO0P7+5h+mO6ionyQk6YUnn1ZSx6bc3gOtcHt+W6
         jebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=tx7ZPmi7etTZwSg5dTQ5XCgwiSXZitCQE8bpHf299+Q=;
        b=GIti6zPASSR2RQUWj98WhCoqFqx1dhiksiGlmkTOv2yH4mIeJLBAflOKSF6Jd792aQ
         ofaC1ya1huU6FDb6DAHN0qER9feFJZ8lhIn8DFYVHFOOGx58+v71UqkLfLXefz8dyZM1
         RKGGTmI6MpzGnq2L7heROZoHyfWU14gW64FriJPXSg5tI0YoT04JZIXdM5c1gnu4A7tI
         Smtq/3xyLpFchOmTufD1oVcWr8r5Weh46LoPl9xjTdnUeSGXkxtdD5PMLB+ZwRIaMq/y
         8RBeZWVlzDN0MTM2wL0Tz7Lkc4EvBUoE02PKijajmaXLtHlteyond+FQIcCuuRSVSHuc
         /SYQ==
X-Gm-Message-State: ACgBeo3H4Zwx1LpDm27Tlnj1mxolAvTK8j08FDSRkfa769QiBsqfGRhp
        Ob7e03EuxziR9ljZu2Nv9mQ=
X-Google-Smtp-Source: AA6agR745sy+mi+aSfB6+g5QBOOaaHdSR9OW7C1+nQ7eJB54UgwGwXfgFeE6Zkvu0bsNNakdGoVkKw==
X-Received: by 2002:aa7:d49a:0:b0:43c:fed4:c656 with SMTP id b26-20020aa7d49a000000b0043cfed4c656mr11556340edr.312.1660508666760;
        Sun, 14 Aug 2022 13:24:26 -0700 (PDT)
Received: from krava ([83.240.61.159])
        by smtp.gmail.com with ESMTPSA id y19-20020a170906071300b007303fe58eb2sm3260375ejb.154.2022.08.14.13.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 13:24:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 14 Aug 2022 22:24:24 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Message-ID: <YvlZ+ETaaTD3hwrM@krava>
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812052435.523068-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 10:24:35PM -0700, Yonghong Song wrote:

SNIP

>  }
>  
>  static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> @@ -2020,6 +2081,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> +	int struct_val_off, extra_nregs = 0;
>  	u8 **branches = NULL;
>  	u8 *prog;
>  	bool save_ret;
> @@ -2028,6 +2090,20 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	if (nr_args > 6)
>  		return -ENOTSUPP;
>  
> +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
> +			/* Only support up to 16 bytes struct which should keep
> +			 * values in registers.
> +			 */

it seems that if the struct contains 'double' field, it's passed in
SSE register, which we don't support is save/restore

we should probably check struct's BTF in btf_distill_func_proto and
fail if we found anything else than regular regs types?

> +			if (m->arg_size[i] > 16)
> +				return -ENOTSUPP;
> +
> +			extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
> +		}
> +	}
> +	if (nr_args + extra_nregs > 6)

should this value be minus the number of actually found struct arguments?

> +		return -ENOTSUPP;
> +
>  	/* Generated trampoline stack layout:
>  	 *
>  	 * RBP + 8         [ return address  ]
> @@ -2066,6 +2142,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
>  	run_ctx_off = stack_size;
>  
> +	/* For structure argument */
> +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> +			stack_size += (m->arg_size[i] + 7) & ~0x7;
> +	}
> +	struct_val_off = stack_size;

could you please update the 'Generated trampoline stack layout' table
above with this offset

thanks,
jirka

> +
>  	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>  		/* skip patched call instruction and point orig_call to actual
>  		 * body of the kernel function.
> @@ -2101,7 +2184,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
>  	}
>  
> -	save_regs(m, &prog, nr_args, regs_off);
> +	save_regs(m, &prog, nr_args, regs_off, struct_val_off);
>  
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>  		/* arg1: mov rdi, im */
> @@ -2131,7 +2214,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	}
>  
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		restore_regs(m, &prog, nr_args, regs_off);
> +		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
>  
>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
>  			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> @@ -2172,7 +2255,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  		}
>  
>  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_regs(m, &prog, nr_args, regs_off);
> +		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
>  
>  	/* This needs to be done regardless. If there were fmod_ret programs,
>  	 * the return value is only updated on the stack and still needs to be
> -- 
> 2.30.2
> 
