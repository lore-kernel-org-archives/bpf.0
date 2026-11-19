Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116522;
	b=3/im1dVnWzKuzHy+0nWhV41tUtvokW+OiydL9OGw5c6Q5uS5K6qBdzd5Zbat2AFTzn9p
	 jhSD+DGSdY8AVzoCieoyB1YamDWgukPuSFr5XCGfbn9fbx9yZFczHBVtKC+n5Yk6KqH/1
	 ddIWdhSmnbSxeoTzixvo5vQQZ4Ny3zwpTj6OQVZBXo5egaV/YY6ewVuRbCVu2dLc8mYOV
	 zEHYojG5+9ov1Ivhwy8vrueuQXP9DxvPWuFfbKDunNId098gDG4JkX3n56DSxIvFt5e4O
	 ZLNjiREdFUdJuAyEhPpcbxYudCI8gKE/dhju8XaHoKBTaGPDv2hkPCxQkePNMDW4XbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=daCieWNeyyAkEEfSGL+gig14C8b2lK6bD4Sqxa/vxJ8=;
	b=TZtbgSzSJFHU+2w0HGMCkNp4Y3y4DZ4wqiYZcgkjZxySKxWp/8VMXcAAqLj6aVJrXK4B
	 YmLbLi9sr/jnoXi/oMzDFR9WGNLmsXvp7Py/gKZA+pMNsWMxrbcLLnUbvcV2fOFeP5JQ3
	 B3ngfoWiu/HAKECNlxxVLifK6lJpjIDudpsvhcXBQDIIF7Xek9WhtH1meBq/JnBEDvXVe
	 94T/PFa4/1a3XqZHlNj15Ggjdk3mBu7sG9n9HiQ6v6VuEB0JshlJwGY7lgkt3Y8Xe3JjD
	 +P3wUyZznQn6FVaVY2i5YQKu5LwdpvIs4nCYDs15HOpQdFy9McrtWo1/43uxk/tTAAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tu20Gqk/";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C8606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 19:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE9C8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tu20Gqk/
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso28084f8f.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795116520; x=1795721320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=daCieWNeyyAkEEfSGL+gig14C8b2lK6bD4Sqxa/vxJ8=;
        b=tu20Gqk/R+74eslqU7J+Qfe6fCPgO4z10zl9W/g+ahjktmWwy2JW7Pyk5DMtk7Npri
         DWK9YC+vyF0laiaM1V8JE130P3Pqean1axFhXx+ax8wiPIS8RTV2CI9DzjfJpEtsZS9i
         395vPURZPnd/woNmWSQGqV1wsOaaS0EvS07d6VsHDfCXlJIFEcJeHbMBg+1mGEeyAP9J
         9jEn4aCTbjergCG7KG8jEJP/Bc6R4SurYMYyhWGcjp/uKMxa57LL3Xh0jIct8EWFkklv
         w7xXc2qeAuPOJWrEowkLN7t9bplc32MaJzEPItjHzhJgE0XGCB24Rv04zi/6it5NEALW
         oY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116520; x=1795721320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daCieWNeyyAkEEfSGL+gig14C8b2lK6bD4Sqxa/vxJ8=;
        b=P8zFmngtGjCzQxTmHboWED2RZKlJsVbJjUAVdds47WeeRFQhrfyI7m1Q9kdIVeVUE1
         iAwW5t7lXXUx1imulm+Ewe8fyaWb7iI+W8vTP1WMO55DuCah0EDHFrTjSWKtth6oQF62
         O+PD137ZKEdsxVKXvSQTTcbZ8s9NqqgL2Czs6XhmJFY4yguuCefkxgh/6wFP348KFD4I
         n+h93j65qfiGqIY8jFBlpTiDulO2wwfLYrakk88OTFdTxQ3Z4kZuluvRazA6eM6O6guV
         PMF0oUMfR7YFAbphNihfDcRBvdiXrEEpKSaATQoFLGuX93wz1QOFOBtGK6AWedQccG/5
         FUnw==
X-Forwarded-Encrypted: i=1; AL+hErGMrgDHo4XT8HH0nLQsakp824y87VnFN41toU4Q1gBs7VM4cpXdxo6s3G4/s8kcvW2KLiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BTT2blPNGZ8X+szQ7zBF3kib6E6d/HeIY1uPPddLgfY3wJVNQ
	JCVmwGSYjyhoTW439I0V5k5CN9r+pfgFq9ARc1SRxMbi82zViKxT72l6
X-Gm-Gg: AZFdTZcTYPTt9YNJUAq1tqaOkFVVDPE/tS1ej8AjfIKD7LsC4UcE61ji66j431lGI08
	wWmwLJnrN7rcZ33Cr4jDu64W0Izew1ccfYchelx7MkfaYlkF24V9/aFuIX7bB3IV+jnFqR2OQ0l
	Y4eKyERDxxOchP/3yYg+ynxXNMJOI6nGXQSUDNbItsJamzYwqJCZX8XYlNYZken4kmL8VKwOUbJ
	OGA80DpPLH2ar9PGd/nqZdByuHPxM4BkJ/AHy5ojbROiS4wItruNOdrH7vbAF5GBxgMqUrtkvDc
	rnmoCYmp//A9nOsDymJQ1fHFJA/QTAmq4tdR7onUndGfiHQLWZEl3u53+t6vNqadvUl2EN70mq9
	NG0pIeHfRz3HCn4pEvottCsUByVMs42bkSGN3y9O14/28d7inyrNqvZeAbrH012FYWwtAiMJ9l9
	14nAnWb0ix1ip3DCdGBwkE/7zNfk7IVJDfvl1X+/pQX9bURWl7wwUn0OjMzo5PFrlN3bCwBZKiv
	KEdwjhA55LEysPEH6kPti83ED3px5WQMmijmSZUx25SOG2hIQzkoNlBJwdgwFHiizeMds/4HTRo
	y4PoX7y15UZ7/Mx2XvrQskXsE2kvZVqChYUN76g=
X-Received: by 2002:a05:6000:4b1e:b0:48c:7143:610c with SMTP id ffacd0b85a97d-4abb2910b8fmr809897f8f.36.1795116520113;
        Thu, 19 Nov 2026 11:28:40 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm1477581f8f.21.2026.11.19.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:28:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 20:28:37 +0100
To: bot+bpf-ci@kernel.org
Cc: mike.bazov@gmail.com, song@kernel.org, ihor.solodrai@linux.dev,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, emil@etsalapatis.com, kpsingh@kernel.org,
	matt@bobrowski.net, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
Message-ID: <av9N5RqhdRhW1fVh@krava>
References: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
 <77d978d7f9343e907651b4d4d81ec1c1405dce42f75e33b169f729f208029fcc@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d978d7f9343e907651b4d4d81ec1c1405dce42f75e33b169f729f208029fcc@mail.kernel.org>

On Thu, Nov 19, 2026 at 11:14:51AM +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: Use an on-stack pt_regs in the raw tracepoint helpers
> 
> TL;DR: Without the per-CPU slots, nested raw_tp/fentry programs may hit the
> WARN_ON_ONCE in bpf_perf_event_output() (panic with panic_on_warn); the commit
> message's claim of no more -EBUSY also looks wrong.
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> >  BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args *, args,
> >  	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
> >  {
> > -	struct pt_regs *regs = get_bpf_raw_tp_regs();
> > -	int ret;
> > -
> > -	if (IS_ERR(regs))
> > -		return PTR_ERR(regs);
> > -
> > -	perf_fetch_caller_regs(regs);
> > -	ret = ____bpf_perf_event_output(regs, map, flags, data, size);
> > +	struct pt_regs regs = {};
> >  
> > -	put_bpf_raw_tp_regs();
> > -	return ret;
> > +	perf_fetch_caller_regs(&regs);
> > +	return ____bpf_perf_event_output(&regs, map, flags, data, size);
> >  }
> 
> Can this reach the WARN_ON_ONCE() in bpf_perf_event_output() using only
> raw_tp and tracing programs?
> 
> bpf_perf_event_output() still has a three-level limit:
> 
>     nest_level = this_cpu_inc_return(bpf_trace_nest_level);
> 
>     if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
>         err = -EBUSY;
>         goto out;
>     }
> 
> Before this patch, every raw_tp/tracing caller first took a
> bpf_raw_tp_nest_level slot, so a fourth nested caller got a silent -EBUSY
> from get_bpf_raw_tp_regs().  That function's WARN_ON_ONCE was removed by
> commit 3880cdbed1c4 ("bpf: Fix WARN() in get_bpf_raw_tp_regs") after a
> syzbot report of this kind of nesting.  The WARN above could only fire if a
> kprobe, tracepoint or perf_event program was also in the chain.
> 
> With the slots gone, a chain of only raw_tp/tracing programs can get there.
> For example, a raw_tp program A calls bpf_perf_event_output() (nest 1),
> and its __bpf_perf_event_output() calls perf_event_output().  Fentry
> programs B, C and D attached to perf_event_output() also call
> bpf_perf_event_output(), and each is let through once by its own
> prog->active check, so they run at nest 2, 3 and 4.  At D the WARN_ON_ONCE
> fires, and with panic_on_warn the kernel panics.  The same depth is
> reachable across task, softirq, hardirq and NMI context.
> 
> This also seems to contradict the commit message:
> 
> > the helpers no longer fail with -EBUSY when nested more than three deep
> 
> For bpf_perf_event_output() the three-level limit remains, coming from
> bpf_trace_sds and bpf_trace_nest_level.
> 
> Should the WARN_ON_ONCE in bpf_perf_event_output() be dropped, as
> 3880cdbed1c4 did for get_bpf_raw_tp_regs(), and should the commit message
> say that bpf_perf_event_output() keeps its three-level limit?

+1 we can now nest more than 3 times, hitting that limit shouldn't warn

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44508926690

