Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3817721
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032179; cv=none; b=Pys9WzVE2lj+mqxt75KxPGcvO1Ig0ooDP/LVhGNPCx4TkwVZx8o4zC3599/PGyy44h+dARlK4v9ExlSa/6rsfHwmz9blZ32JbMGLC3kEDsQS/eA02ZqfPdW3w0ViqcUhMAM2ay/65vN7QcqqGuLqKOIhxESmIBFoYVZWi8V8awQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032179; c=relaxed/simple;
	bh=x6ck6pZJMzYWwY4L+lSoOQagLPVp0+Q3bGPk7fzUPEs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a37C7u2KK0Yr89vJfgzK0qYVSMeyuooGg8R0LsHfuOEc+PF4al9OqPAPFWLkbLLbRaZ9ObNJNai9anVnCiUbj/RQOm7N2q95Q7ajsEeDlWb6WMwGPKwhjEI3QJaVjtgm3MBRwjR2eCPaR8oIAnN6JVi9Lfsv7wa91YL2qyVNcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDeQ12wg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDeQ12wg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3022152a12.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 21:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712032178; x=1712636978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQNiTko5+6yC0DFKcQM3ZYntLjVNlk5HYjEM5GaTHe8=;
        b=MDeQ12wgHGmXQHEayTrCshgMGRK75x9U053mx4xxZLFAnFC84SCY7MFFWbUDjQ1lAV
         62jHEH2fRP5SDZa1axd72Zacg19EovSKqlDExUAJ4MCS5wKwnSYQr3jmr2quLTJAlXOB
         66tEnHawKzhQOPYvfU8jfJMGBb7mPBT/8POR92EIUcH1HuDAftM1cBPukMx5xZYMnImH
         NyqFAq4UyAxcR5DZ00pUy/GQawx23sQT8FWLvWkI2Vn8yGNm/k866i9vGZtTm2yVG/El
         A0ama+yfF0UjVUtIwmJvvkXuTute0fsok6mGJKrwww+XtSoWwS+1uqbYJV0HCn7PZGAB
         zmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712032178; x=1712636978;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQNiTko5+6yC0DFKcQM3ZYntLjVNlk5HYjEM5GaTHe8=;
        b=idXCUhzzk/G3Rrc96h6BJSQOZSGg/cA5blVgNioDbVM+gXJfswC9l1AhlGSa3U0a9H
         rj6tEpQK1EZHYamtP222+LyBkVPZpCmy6kKeRRP8tIu9ec5OlZVLqcBDI3pi0nPx1o4F
         s4F99KXehM4qSe+gE5ynaEYyNXJhLw0XuKjGWnyYahxP/Nyl3eiJKKbUmE766SjQORf3
         OuhhV2QxK2ffNXez5spYUaHuksXy1Bn42UcmzWcFCEqCPeszN09DISRPM1PqvOJjlmGb
         PZ/oPMvWzgDMt1GMwAb6FXvKCIdWkaVukppIZ/t92qyvmEA5qmooBWhmsXpbQFR5XATo
         3Fxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4TMPQeP+tNRW6+B1V2wRXP6kfYPxqE/EYlRZNfzGweT8i/jk8jJPrl1+SSQ7qnU5rbazCwiew9C9oNAjJUCDvUExu
X-Gm-Message-State: AOJu0Yxw87wjfk7YOXRBIvzZ9MMOjMSObfixL3Yerrm4WaYKJ0qxM6v9
	8cPqpDajFSfCdM5mcjqmNXRbl6NHhKIs3LysL63JkyhxBII0bRn6/kWiQ2N3
X-Google-Smtp-Source: AGHT+IGAGhvtHlJwoGzI2d1lJsqxrsw7KL0w+nDKaXChEmVgLNiC+Xm+v+CiU2cLHFHz807Op8OZPw==
X-Received: by 2002:a17:90a:f005:b0:29b:a345:620a with SMTP id bt5-20020a17090af00500b0029ba345620amr16451314pjb.20.1712032177513;
        Mon, 01 Apr 2024 21:29:37 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id cq24-20020a17090af99800b002a23440cfd2sm3648299pjb.46.2024.04.01.21.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 21:29:37 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:29:36 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <660b89b056220_1a14020831@john.notmuch>
In-Reply-To: <20240402025446.3215182-1-yonghong.song@linux.dev>
References: <20240402025446.3215182-1-yonghong.song@linux.dev>
Subject: RE: [PATCH bpf-next] selftests/bpf: Using llvm may_goto inline asm
 for cond_break macro
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> Currently, cond_break macro uses bytes to encode the may_goto insn.
> Patch [1] in llvm implemented may_goto insn in BPF backend.
> Replace byte-level encoding with llvm inline asm for better usability.
> Using llvm may_goto insn is controlled by macro __BPF_FEATURE_MAY_GOTO.
> 
>   [1] https://github.com/llvm/llvm-project/commit/0e0bfacff71859d1f9212205f8f873d47029d3fb
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/bpf_experimental.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index a5b9df38c162..3329ea080865 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -326,6 +326,16 @@ l_true:												\
>         })
>  #endif
>  
> +#ifdef __BPF_FEATURE_MAY_GOTO
> +#define cond_break					\
> +	({ __label__ l_break, l_continue;		\
> +	 asm volatile goto("may_goto %l[l_break]"	\
> +		      :::: l_break);			\
> +	goto l_continue;				\
> +	l_break: break;					\
> +	l_continue:;					\
> +	})
> +#else
>  #define cond_break					\
>  	({ __label__ l_break, l_continue;		\
>  	 asm volatile goto("1:.byte 0xe5;			\
> @@ -337,6 +347,7 @@ l_true:												\
>  	l_break: break;					\
>  	l_continue:;					\
>  	})
> +#endif
>  
>  #ifndef bpf_nop_mov
>  #define bpf_nop_mov(var) \
> -- 
> 2.43.0
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
