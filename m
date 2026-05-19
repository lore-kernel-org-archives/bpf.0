Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641453BD643
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222972; cv=none; b=Q1SEettlJSaNZ4UQn6iqc/8bZGGVj8JCCShi687kWRTC+FTqWoTaMTbqvbs+IeXmHmIhla+tuTuAL9Yy02PhRtv+OTezcg+OmoRRnXoFb3qlQlKO8WmiIWj2FHh8gMto29ZEwjan5DfnQiG+KfcLsFOjdRIrl3T5OLk/p6HX2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222972; c=relaxed/simple;
	bh=hX1kjjf8tRNTUTvCD6JssEYipiPDum5U4tW7nuUBhUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pibzOKyWQeIzVHAv4UqAxiSLjxybVRTmX60pi5K72hkBHA6N5W2rWFWfmHIYtKzcGv1Ku0nnHRC0gZtgNYd5d+xYaQ1u+n25hejNM8A4aUF8a8KA5oTFI7snYwySoZAFXl796V8WZ9ysZ+Exj2QV3qRFSNO/gvn5UUamD/iRQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro9y5YN+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro9y5YN+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2544371f8f.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222969; x=1779827769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DMmhPTSKZ7glMxvBJLhvmMzc5am2XArv/AoR87EDIP0=;
        b=Ro9y5YN+oOR+sjd6HoWZTZWhogSpL4kgb7bZPNT9pLwhaYH8XP9Pk2437Xr0eHiRP7
         0R/vNi/qsVQ/rWGYCOh55xCMGH7oosjXW6038ksNgBuUJw+7VfTlzaorMjOBP9XXF7mf
         olVxukv8FpohnD/PzH9suVlSPv9z0POiLzOrVa2Xwr63fcU3hwdeiHnIUrLm5cQS8UC2
         oE99Or0XhxRBIVxZLhYwefmhmWyFHfabL//4S1GDhss5oL2G2XvcHOxkr9QDVC8oEN5g
         piQkZNcFvsuDci7KJQNRd2P6YG4D74CJm0aancB2cz3yxieQU82HiVmU9Q8V0qZyeWzb
         IH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222969; x=1779827769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMmhPTSKZ7glMxvBJLhvmMzc5am2XArv/AoR87EDIP0=;
        b=dL86uy7vfcU7J8+uJ4R1sEk1p3875P1hf9uIb8efFLd8DIe1p/TFuX//Ocj/agyZ8H
         bDWj/1JEAusNy75xOsKs4oZwMY6HeGCVv8NXZbsoIJLTVWAdZazJqE9Z8f/GhXLpzAoR
         TmSlHjY7ciHdpp78+SBb/KpN7+xDWtRqyY+g/su/UAC/R1LXRuDvdrUAAIXULi6JWkCk
         An2bEbGadwJ/jbDa88N73Lm+yN/quzwdaM8UA9zC1pNWHpDUBFX9jLq/hO1MB2m9/En3
         TNL4LAjnTgFkb/DkiFMDsNGLkajVq5pb51kYU4AjRUQv3vE/NaD69hpTm1180V2FYa6H
         7ayA==
X-Gm-Message-State: AOJu0YzVFByTC7XFKU8boM8Q5riZizSElwj+tujlJ5K7vpSlIIWyAkmR
	b/OTGbmzrt/xf1icOCMNNjDTNcdO9Lag8lgd7cLBHv2afkZbgW20YhCsjba0bQK5
X-Gm-Gg: Acq92OGw+IVJYT083Re863hOwQbYgb2pM3/YpKXxYGc2sJrx5bGqZJ172/UojWh0KAQ
	Oyiq02RFqeNLqUFZZSdsvWooZq8q4UAa/wzh/Kr2BIFD/KbLc6nfEWWpq6pu2ah0up+xJcQo5Fy
	tPO9Oz7iM9iYWr1FT/0sDaEqexkq/Q5eUQ+w6fb2ofzpnlr+6PfUEGlnRGC8wHXVyigRRtIZBKr
	qdZfqJbmuu1mI1F0puh4JtYxOhfEpQqC6no1jX8Q9RDbC9ToHZY6ZiA9qiKv09YTlMcy+rwkhvY
	rHGq9qsg7tnWan+iTbmqeyWRgRJ1DhwcEi93lJOCPrZTkRrwilsDIXPxcPELAwbffYWlu/uLskx
	hKIayDSc5DTkxVnyKd630qk0AQbPbsjyfmUcy3IXQdRvTGJBEvoyHvNXFPheGRpuug+yh7TW5gk
	lgyGqVhdTo2n0U+HjHtJ7CJQPyOrisU05e
X-Received: by 2002:a05:6000:25c6:b0:454:a12c:6cdb with SMTP id ffacd0b85a97d-45e5c57d4bcmr34441760f8f.2.1779222968510;
        Tue, 19 May 2026 13:36:08 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm52258659f8f.31.2026.05.19.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:36:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 May 2026 22:36:06 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 05/11] libbpf: Detect uprobe syscall with new error
Message-ID: <agzJtkZuSRVK3YR_@krava>
References: <20260518105957.123445-6-jolsa@kernel.org>
 <20260518113126.938ECC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518113126.938ECC2BCB7@smtp.kernel.org>

On Mon, May 18, 2026 at 11:31:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing kernel dependency causes immediate selftest failure and libbpf feature detection breakage.
> - [High] libbpf feature detection breaks backward compatibility by not accepting the old ENXIO error code.
> --
> 
> commit 674b83913f8f61b2f16ba8f8b86e6bf8e84da5a3
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Detect uprobe syscall with new error
> 
> This commit updates libbpf's feature detection and the uprobe selftests to
> expect the uprobe syscall to return -EPROTO instead of -ENXIO. This is in
> response to an optimized uprobe fix that changed the syscall's error code.
> 
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index 4f19a0d79b0cf..a37aaea5253e5 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_fd)
> >  static int probe_uprobe_syscall(int token_fd)
> >  {
> >  	/*
> > -	 * If kernel supports uprobe() syscall, it will return -ENXIO when called
> > +	 * If kernel supports uprobe() syscall, it will return -EPROTO when called
> >  	 * from the outside of a kernel-generated uprobe trampoline.
> >  	 */
> > -	return syscall(__NR_uprobe) < 0 && errno == ENXIO;
> > +	return syscall(__NR_uprobe) < 0 && errno == EPROTO;
> 
> Is it possible this change breaks libbpf's backward compatibility with older
> kernels? Since probe_uprobe_syscall() detects uprobe syscall support on
> various kernel versions, replacing the check rather than allowing either
> (e.g., errno == ENXIO || errno == EPROTO) might cause libbpf to silently
> fail to detect uprobe support on kernels that predate the EPROTO change.

that's the idea, we don't want the feature to be used for kernel that
return -ENXIO

> 
> Also, looking at arch/x86/kernel/uprobes.c, the kernel-side change does
> not appear to be present in the tree yet:
> 
> SYSCALL_DEFINE0(uprobe)
> {
> 	...
> 	/* Allow execution only from uprobe trampolines. */
> 	if (!in_uprobe_trampoline(regs->ip))
> 		return -ENXIO;

huh? it's changed already via previous commit:
  uprobes/x86: Move optimized uprobe from nop5 to nop10

jirka

> 
> Will replacing this check cause immediate regressions for both feature
> detection and the selftests until the kernel dependency is merged?
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 955a37751b52d..c944136252c6d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -762,7 +762,7 @@ static void test_uprobe_error(void)
> >  	long err = syscall(__NR_uprobe);
> >  
> >  	ASSERT_EQ(err, -1, "error");
> > -	ASSERT_EQ(errno, ENXIO, "errno");
> > +	ASSERT_EQ(errno, EPROTO, "errno");
> 
> Similarly, does this selftest change introduce an immediate regression if
> the running kernel still returns -ENXIO?
> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260518105957.123445-6-jolsa@kernel.org?part=1
