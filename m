Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA348A8A7
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873939; cv=none; b=Gf424p9XPHWBb24WgBF1RCe7Pt8AsetozhIpVtMyGz2KdtU3/3n2rIJue1wY6oicV8URG7Ei5s4dT1AEhVVCVdTlNGKoinnQRedlihGL/xM6xR5SU72iLL/nBVklv+JptRl/rL6WYE6va3Gz5oZxxItye4LN21Lc0IVXwhtSz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873939; c=relaxed/simple;
	bh=1M7ug/sxKhOtsQJmyJtUxR9ektFotu+w13JBmovkxCQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIYrsET9z3uxNLzbd64o/Fuu/nAjYZGR3jFH22WnnJIpzFLaheNjw6C9xMqLA5Zm4dsTFC5VCwatoi0TSp8yjM1tnvobXtiH5M5ZDG5UMT1Z4auA3bMt/lik6A5OLr7ZZX54aeZg32UvGKknJ/7DlXxdkJoAq3cDwX7poVESF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyewmlN1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyewmlN1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49800c6a846so1699825e9.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785873936; x=1786478736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iJy0GdGhRxEzrVsVSP9irAxMBATEUI2j9kdPpxJjlgQ=;
        b=nyewmlN1G+cf5bKOij6G5Nuai5XbRDTDsHtRZn+okPqGiBSO2MLBMd/vPZOU+h6YF5
         38xWXeE7MNrxuOYGpRzBq8Z3j0B4YGiFpvu/ICy0Il9UUE2pNaFefxxj8bbEQxIc4OqU
         p+a3/ZrHZPurvA3k5JyEA1JyIg8QpjNG/GDB5sc/Xsnkm6FlIDN4Cw1NgH4+OKEvYCh1
         4GyLctAvkhxHjDLednG+qFLIsJ8bB2whcfZhWNbRI+94n6e7MWSeMmj0xrxfzFhNxSg9
         f4LR4dkT+qyjBj2vnOiKTlfAlLMlRwfvocVOgiOZs1nf464nXe6niOf/qo+4kMk8M1NW
         2GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873936; x=1786478736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iJy0GdGhRxEzrVsVSP9irAxMBATEUI2j9kdPpxJjlgQ=;
        b=E6vlDP6M1h0TvznP7Eb7UOy68e67P2h7fHX9J3PFU3JAP4u/FgSPDXm9B/OX5EOm3b
         Yifw60q+18cV37XmofBPNoc5JBiYYwpmkXiMFeRb0latO2T7+ukAt+76JvnePVUjs3eG
         wwDCVoHXjdLJKSkKcqx3p7NqFt57jFR5MbRtNWT10GnBmf9qLjkPwqUann28u4gREhWb
         Upc9DZKjlnY+uSgqU3lI9Ig9CNQQyMYbr40xeQaZwlfz39XtdQEBED6OxrxVNZfPeB7M
         naMUXP2MbLIWxUrrkzVT9jCNrce5csisp3mcBXwy+ScpKmt4kqL2k2pmlGAnOT3Npt7+
         SRyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPAxPuIrhZZf10Uz5KOjjWLhHt1b5HI/rV54P0Qad1r3VFU1jv2XWLh0vOJroEHwL6fpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aPd95ezzVO+O/a4VvZ9rGJRRK9ezqRcIkaErGDnKwwYo51Nl
	c2LKjyspCOEaE9pOjjs2HTvYHKpccimJy04qrlAK8wBKAhuk+bIml6TQ
X-Gm-Gg: AR+sD11xZ7KztsblP0LFL7M2mUyk1pH877mETMaLr4InUvPsK0xUspnxilP9lgJPbCW
	gWQauMZY08ISbaBep/Dwoq4j0TcJevwPuguUBxvMyEu79ho641qENoSieIT/rUY0V1ExrlX5hZs
	06iS+1K+8VU6+QhqbrgAhCGop8psjC5JVt9rOKGZgONg/eMekMvIgPytDNgY3AurgnClPxPcSjd
	w0nzKsjdpbYUCdghJloSrPmQEymv9LZGn4ZQwDRnoNdM4NOknwL3BbSnnLfbVnZJPA4wteRA3J7
	5kz7ImruLIgtHDPonl6CiusB9voLTqSOamLMK39ue1JzCVG6038VFpiwHidd5VYOudat+4CsAWw
	aLGQ8LAUVRnP/lNqiG1rxa5570qQoSDyNKywFW7uFUCGreDw+FCZ78f8bRdncbMFWrDyjTnQn4q
	xwdZEwC4Ur19KosJMAC9L6UgRluKX8XwgInMh8HqIphc52a+ic
X-Received: by 2002:a05:600c:a47:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4994e7ad575mr9017585e9.7.1785873935628;
        Tue, 04 Aug 2026 13:05:35 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e98adc4sm3887605e9.2.2026.08.04.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:05:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Aug 2026 22:05:33 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, qmo@kernel.org,
	chen.dylane@linux.dev, info@starlabs.sg, contact@arnaud-lcm.com,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 08/12] bpf: Remove trace_in argument from
 __bpf_get_stack
Message-ID: <anJGDYo4M_GV8Om8@krava>
References: <20260803210149.296496-9-jolsa@kernel.org>
 <fa27c03a75e22229f58d1ccdce161e05fb274645e3072cdd591201f14b4f1cc3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa27c03a75e22229f58d1ccdce161e05fb274645e3072cdd591201f14b4f1cc3@mail.kernel.org>

On Mon, Aug 03, 2026 at 10:21:34PM +0000, bot+bpf-ci@kernel.org wrote:

SNIP

> > +	if (kernel && user_build_id)
> > +		return -EINVAL;
> > +
> > +	elem_size = user_build_id ? sizeof(struct bpf_stack_build_id) : sizeof(u64);
> > +	if (unlikely(size % elem_size))
> > +		return -EINVAL;
> > +
> > +	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
> > +	trace->nr = min_t(u32, trace->nr, max_depth);
> > +
> > +	if (trace->nr < skip)
> > +		return -EFAULT;
> > +
> > +	nr_trace = callchain_store(trace, buf, elem_size, flags);
> > +	return callchain_finalize(buf, size, nr_trace, elem_size, flags, false /* !may_fault */);
> > +}
> 
> This isn't a bug, but would naming this variable trace_nr match
> __bpf_get_stack() and the callchain_*() parameters it feeds?
> 
> Looking at __bpf_get_stack():
> 
> kernel/bpf/stackmap.c:__bpf_get_stack() {
> 	u32 trace_nr, elem_size, max_depth;
> 	...
> 	trace_nr = callchain_store(trace, buf, elem_size, flags);
> 	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
> }
> 
> And the shared helpers both expect trace_nr:
> 
> kernel/bpf/stackmap.c:callchain_store(struct perf_callchain_entry *trace, ...) {
> 	for (i = skip; i < trace_nr; i++) {
> 		...
> 	}
> 	return trace_nr - skip;
> }
> 
> kernel/bpf/stackmap.c:callchain_finalize(void *buf, u32 size, u32 trace_nr, ...) {
> 	u32 copy_len = trace_nr * elem_size;
> 	...
> }
> 
> The new helper uses nr_trace for the same role, making the two otherwise
> parallel functions read differently.

that rename actualy uncovered that later __bpf_get_stack_pe used both
trace_nr and nr_trace.. we're fine with just one trace_nr, will change

jirka
