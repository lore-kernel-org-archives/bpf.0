Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEB397E91
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761732; cv=none; b=j9HcGfAywMloUd79vLbXmUIQtICDKbnkToUSklE7xmYEwanwXKBEWFB62VybHxBAcFWRE0fckgDgfzgDaViaHqBRSVuhELr4F6fqMtIepgKMHHrV3ZlJkrF+GV4FbTInkhypAUMLHV+t/CSrzCLVlCg3khUObKeTPAPyjk6zSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761732; c=relaxed/simple;
	bh=zp8m0hZfqXYdsZ8Gpssb//3/JgQgTLa24jkQvLUpf3o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWk3IwJMM54I8R9X9E/hwAogxztNlngqBAJ0SXP/WP2fX1sC2hVJongzLn+Kq0Bqfz+qGZ4z69a7ltVQB2h4aWE+fWK0cWK1oymJIGG+2fr1xVASGsMMLuUzWVI76pZj4CBNECTPByiDZ6UKeNBqtU/nK3K2LRPbeH9o2QpIiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LThFAbjs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LThFAbjs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso53245145e9.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761729; x=1777366529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDeAb0ooy5qQHA5qWOHd2pXo48UvQ+5ANorl5Zuk5Uo=;
        b=LThFAbjsyMAQ0b5zNpcUjvatr1t3/3w9OTqTlXYc7SffylrT8g/aVvG/FmYUUy4MGy
         nOPcsuYZS+I+nUjMdMZ7pB9y/wYuP9AF1DQNlx//PJVo1kjsLg3aCaLqwuW3KOv6ai3m
         /sxkJ6LR63i9vCCbpkp6QQX37hj/RMcFu9FXElML+/5Hz5efg8VaJOGcjnCKbTkFAEQE
         TcqWHcT18PwFD9cgF5794Q8G93QCWo5w8hyKPlkQXZsTuTYgA/Q1SyDN0vev+mKB3uRd
         itqmDERyUKTFk/ZjfwZtJuvJhkWQ+G1Q2bCaS6X+j+D1QvMQBbOIvIVqIyb8WwQQ3jST
         1k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761729; x=1777366529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDeAb0ooy5qQHA5qWOHd2pXo48UvQ+5ANorl5Zuk5Uo=;
        b=Le0SiZdDtMdwTQUPadJdc35QOCXrpcco85pxSQWEKp5IOmJ5VeeLtRKy0KaXfeCIFq
         kyQy3PmvsHdG4Y/YI1KJl2j42+xiZi8Z/BM9oPvyhmYzaijOt5njbSmVRBY6tKq9yqxY
         PjTJBKMyDILpjjDAbnXRXfo+wAvm8/SlQNjp6ANhmHBKnIzyf7M4GcpsL6OKA5tyn9Rn
         t4zg6y6UNR4bGOfoJrMtthLjMv4M7edbBmBlO3Z8VEdr312iGxKy7BxRf8R0cY9GCPo8
         ATdtSnYMpD5vzGyW8jrNS8b/6z4TY1cfudJHlsHbnQLIf/wxQ+INqcxsmmy+nLcTc2Ou
         2J/g==
X-Forwarded-Encrypted: i=1; AFNElJ+kLgqe5SUn9vzZX2I1lhKbn44hnblN6GEz6D4eevrCkGPt9WyCGCHFDKVhY2h6t30N2nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnUoO1JlRJC/IKfrM+f2hoVZAUP5GZj8Qv5oOFY9M0LHjwhTa
	Pcf2WBbfCc/Skp0NiLLcIHWWJFhw+j5v8qKEeEMDJQeRcFqWc+IFbXnwWA1/Iunw
X-Gm-Gg: AeBDiesrjuVbG6KaiiT+5HihiNcL5cPz97uS5BWb1cJxMtzNca2YmaDDrdbBkfDa4py
	+JsoI6gQ9q+h03QTppg+BhSIQk9TvPSAAtbI6gu4LaclK8zVrMHu2ao0IozsL0y8e/6B2y7ILtt
	/PN1UPTF0B6DrcY/mI43Kg2GXeFxBwP8RVl4rtUzFYT+JlrDqhqtjlFf463vMx4FyL0lIpQbUx1
	zFu5R1CQZ/SD3di0Bt5kWrf22N1/6L2UB449Pim1IuWQbzIxUrXsja+iScnApDN5yfPugQsKPv6
	QgzT7ETKSTDQnt26GwCVK7PSaI7xehA331ppIO19Tmo3qSfvxuAp5YizwhjfoWxbHgsFvks/G+N
	+kvhwYKAxd69vTHXKHV+P2S+yKhguaJbnNvLZoSVMF5/Wl0SdA2igEJnHbv4lkUhHQ8cwCw3KP7
	MljR0Y+DKbJG9M9LpAZw==
X-Received: by 2002:a05:600c:a30b:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-488fb7467e9mr172104105e9.7.1776761729296;
        Tue, 21 Apr 2026 01:55:29 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm169553525e9.1.2026.04.21.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:26 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	hengqi.chen@gmail.com, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, menglong8.dong@gmail.com,
	rostedt@kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 08/28] bpf: Add struct bpf_tramp_node object
Message-ID: <aec7fuUhFjKLt6iQ@krava>
References: <20260417192502.194548-9-jolsa@kernel.org>
 <fb38d0f3976f2225ae9781d2292bb79f4d787183360f050c08de3b4490790974@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb38d0f3976f2225ae9781d2292bb79f4d787183360f050c08de3b4490790974@mail.kernel.org>

On Sat, Apr 18, 2026 at 06:10:55AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 50103b3794fb..b97d9f68fc40 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > @@ -827,14 +827,14 @@ static void bpf_trampoline_restore_args_stack(u32 *image, struct codegen_context
> >  static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_image,
> >  					 void *rw_image_end, void *ro_image,
> >  					 const struct btf_func_model *m, u32 flags,
> > -					 struct bpf_tramp_links *tlinks,
> > +					 struct bpf_tramp_nodes *tnodes,
> >  					 void *func_addr)
> >  {
> >  	int regs_off, func_meta_off, ip_off, run_ctx_off, retval_off;
> >  	int nvr_off, alt_lr_off, r4_off = 0;
> > -	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> > -	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> > -	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> > +	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
> > +	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
> > +	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
> >  	int i, ret, nr_regs, retaddr_off, bpf_frame_size = 0;
> >  	struct codegen_context codegen_ctx, *ctx;
> >  	int cookie_off, cookie_cnt, cookie_ctx_off;
> > -	int fsession_cnt = bpf_fsession_cnt(tlinks);
> > +	int fsession_cnt = bpf_fsession_cnt(tnodes);
>                                             ^^^^^
> 
> This line wasn't actually updated in the diff. The parameter was renamed from
> tlinks to tnodes, but this call site still references the old name. Does this
> compile?
> 
> The same issue appears later in the function:
> 
> >  	cookie_off = bpf_frame_size;
> > -	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> > +	cookie_cnt = bpf_fsession_cookie_cnt(tnodes);

ugh, it clashed with latest update for fsession,
and I skip the build test for some reason, will fix

jirka
