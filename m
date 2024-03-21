Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69E12B171
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055308; cv=none; b=sZJr4IYCGnvISGKmAwjlTxjvwfR9k4dp/iJe1KTxcuUthcD45yRUz+jPDrl9QQFlwL6Ns5X89BLvB3McphUaKYygDKJerZGv88gCOeg+BxDPEc/ZmAHyL5WgJu0Up15AA+/1vLWeeyND+9sCI0/73u3rh67W1Gior8UmQuDgQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055308; c=relaxed/simple;
	bh=XCgWKPcKHb3ng3X65AQ2pMHtmO8lafZQQ3k23Ywp8DI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6wVgg+3uucMhwRnLnIIwTSMOk3Wgd/S25uclWACoXOLA35/8P9ZM7KOnq74abyBwMYln7TUYIJDQ/4G1BT7EnNbVKLbC9Oy2i6ZVBZzGea8CdsAFcdUggFD1l2EsqcHvIPI+WiTTbpi9OMDDB4CSop3Xase8uzkaH6WnefwjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGcjydo+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGcjydo+"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so4294423a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055304; x=1711660104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeZM/ZF9kNLlkY1VRzOrm14meMaTAHHQPtFHcCLeqrU=;
        b=LGcjydo+Q/ygjz3DIBgFD3Cve4oxROG5bYXgLHf9aFN+SzM9c7sv5zmNl1T4JLJbF5
         Fa9IG+5GGxpDqU3aNFNPP4ATyouJbdsP9r+r4+ttyNEzAPBv9n46eICtOrvQI/XSRXmG
         Jic574+sjbcVVCjuk4TnlwFhHhjkdIsFH6qDPm+k1J+6UCCELBIpdYDm+qrVcL3I+m6h
         konmSe8AXMCW2FunpkIJdTr6XQcGwtxS/if/OZl/fjzM/q6EeYmQkArYP2JKSAb5j198
         IqG5qj+lWUDhqKwgls+npZX7xqNjGfLQ5tlpM1p/CNAI9giSmUBaBiJESefED372+O8N
         +eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055304; x=1711660104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeZM/ZF9kNLlkY1VRzOrm14meMaTAHHQPtFHcCLeqrU=;
        b=idvwIuZvJahO3DsFMEriyWvd2pGHL1CqnhU8wh4kASK5q3+LfElH2EhuN0uQOdozF1
         ajFV2GwEtPuMWZLA7/6Zjbc/39R+XbnnhNC2nUy6zqGUtJsnn4E63oCot4bdahd7MTSm
         RaBe8M43e31ptsw4oQS22HvQjUGt7KUNjuGDwYhc7SV8DHTQAw6Sfja9Rp08bC/1Az1C
         dgnczvhjQuJ4zQZMkJ7FtYoGCGlTsCTlxqs5fyqb/w4P02uO42hFVXl3fKahMHdyECxg
         R9WGr6RZDiqxhP79nNFKzqTt0JUt7SFPFAiDHRGzRrzrJFzR3a9U8c1nBdRCuLZ0admf
         S5yQ==
X-Gm-Message-State: AOJu0YxtxJpEF3D3UWBlDNMPKyg89XNsqnpMN7LhCIWzo0+7kecjMcZl
	p+ySOgJXEJywfocxFHhsYmY0p22vSFvG+gCgWkgnJ/8AU6JVMkMR
X-Google-Smtp-Source: AGHT+IEp5rcBZ3JJoKbDLnYtjq03mD+H/0pdBvEzTsqXxqflS4u9CGT6kEw+zQzCg/5PIbQSNUZpUA==
X-Received: by 2002:a50:bb4a:0:b0:568:9b14:d6c7 with SMTP id y68-20020a50bb4a000000b005689b14d6c7mr136174ede.16.1711055303924;
        Thu, 21 Mar 2024 14:08:23 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id c2-20020a0564021f8200b0056bcec9c89esm253893edc.92.2024.03.21.14.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:08:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 22:08:21 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, peterz@infradead.org, song@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: inline bpf_get_branch_snapshot() helper
Message-ID: <ZfyhxfpOudwCVaD-@krava>
References: <20240321180501.734779-1-andrii@kernel.org>
 <20240321180501.734779-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321180501.734779-3-andrii@kernel.org>

On Thu, Mar 21, 2024 at 11:05:00AM -0700, Andrii Nakryiko wrote:
> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> inline BPF code which calls directly into underlying callback of
> perf_snapshot_branch_stack static call. This callback is set early
> during kernel initialization and is never updated or reset, so it's ok
> to fetch actual implementation using static_call_query() and call
> directly into it.
> 
> This change eliminates a full function call and saves one LBR entry
> in PERF_SAMPLE_BRANCH_ANY LBR mode.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de7813947981..4fb6c468e199 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20130,6 +20130,43 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			goto next_insn;
>  		}
>  
> +		/* Implement bpf_get_branch_snapshot inline. */
> +		if (prog->jit_requested && BITS_PER_LONG == 64 &&
> +		    insn->imm == BPF_FUNC_get_branch_snapshot) {
> +			/* We are dealing with the following func protos:
> +			 * u64 bpf_get_branch_snapshot(void *buf, u32 size, u64 flags);
> +			 * int perf_snapshot_branch_stack(struct perf_branch_entry *entries, u32 cnt);
> +			 */
> +			const u32 br_entry_size = sizeof(struct perf_branch_entry);
> +
> +			/* if (unlikely(flags)) return -EINVAL */
> +			insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 5);

nit, you moved the flags check on top, which I think makes sense and
we should do it in bpf_get_branch_snapshot as well to keep it same

jirka

> +			/* transform size (bytes) into entry_cnt */
> +			insn_buf[1] = BPF_ALU32_IMM(BPF_DIV, BPF_REG_2, br_entry_size);
> +			/* call perf_snapshot_branch_stack implementation */
> +			insn_buf[2] = BPF_EMIT_CALL(static_call_query(perf_snapshot_branch_stack));
> +			/* if (entry_cnt == 0) return -ENOENT */
> +			insn_buf[3] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4);
> +			/* return entry_cnt * sizeof(struct perf_branch_entry) */
> +			insn_buf[4] = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, br_entry_size);
> +			insn_buf[5] = BPF_JMP_A(3);
> +			/* return -EINVAL; */
> +			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
> +			insn_buf[7] = BPF_JMP_A(1);
> +			/* return -ENOENT; */
> +			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
> +			cnt = 9;
> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			continue;
> +		}
> +
>  		/* Implement bpf_kptr_xchg inline */
>  		if (prog->jit_requested && BITS_PER_LONG == 64 &&
>  		    insn->imm == BPF_FUNC_kptr_xchg &&
> -- 
> 2.43.0
> 
> 
