Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD739D6CA
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133683; cv=none; b=loNXYKMfRabKGPjAO34b1O7iq7LYtXF/OtPLBIdLLK230cHFof4EskEjRCcQnj84fGA0joOXtcWB6+Q3NPDklCvDxOOxC7J53BrNac/UEDhleK+0aQZXTWQ2ISZxp6Cl8OyR3tnUAS0X/qcGosY+45kGVI7Ao1HnV3yvrLbCEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133683; c=relaxed/simple;
	bh=+n1hq0x6+klD0p5GgDcO2qOfFMcoNj5XNIwZbETbod8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr2ye9ZzBM9RwVGG41XKPo7HnhqHYAKyl94ktWpZqKxqarkU5K6UN3GJiXBNj7loo5+TJj+ujHtMWmXDkwheFpXvkSzTtLjQYPqgppwc16xTJZ8RUn9OU7IKgiphhBQzMrMdztmu7SrRV1DrJgBWJMSO1d2CckFo5LJdxT9upys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEAtze+0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEAtze+0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1560194f8f.1
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780133679; x=1780738479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IihLrlGVkYHUkHDD/9dWzS/POFj3zmhX0InkDFhzTtI=;
        b=rEAtze+0sc1hhSUe5vW6/3OEcLr66RD9HPjPRCSSKqu8WKYSEktHZkXVJ1b9k46a9E
         fG93dqpIjg5jqegw2QnGtWMwQ/wgzhz8GL4+7bEPa5TjO5ufelD9m57ygjpwBhhDm9q+
         LjayypEuAz+TL8MXIRL5PtUCxeXrObpW9+y8fAo1PHbTnWNDa+7MywV/Gvd3FC55LtpQ
         iC0nR3Mc/MWm6P7oZX9igzp2jWdJYO9mkDSgLF1xE2+1I8cHpZkIEkwvd88zoRdKgVR1
         t+M6UdDOtt8LBJOlEFUbWCZR4qQQ59R0acpI6PRmed3RGV+IMeN5CClVt0ZbFMIo3sF3
         Hitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780133679; x=1780738479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IihLrlGVkYHUkHDD/9dWzS/POFj3zmhX0InkDFhzTtI=;
        b=Ly6u/UDJgfMnQalkNxsx1O7CpX5HA+3EWa6+5XzZOnKU9X+zfw/nNoefjXX/FJJthy
         AOqe39x85xCmPyfB+MKPXUDFOU5eboOCLuuITurs4mHhcSlLUhe2UbKXvuI+rIuVNvxt
         7LKAXKrw2qiXJvFnoUd1Hl3az3thPd/1yCfmX4InfHeY3/DGZY3rCbYOrSNuVl5g4I3Q
         SPm8Yymit1h2NpNILIUfVKJK3YcRd7LPEALMvdffMniG5BHTtEIs8QIXc67DwdPMC8Ly
         /h39mIJd76S0/BLaeRmDl8biVuHl35CZy7XWTHFhZXx9DPfgeP6zav40i4Gk+00Y1yrU
         mZLA==
X-Forwarded-Encrypted: i=1; AFNElJ+voUYFSVJyQEGim3ltAVJd3znamKov4W2Nt+eEAUOUrNmatI0UgBResSiKVjP7SSHPM+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nucqVaelY6ttF+pa9EnryVkph2HwWr81UuLtDHOzU2dKhWtU
	4K7U7TiaB0xN7Dz9AOqL/Gs2RsxdtRzyQfuL7Vg/nTzROrEnK8LRWFxdwbkurw==
X-Gm-Gg: Acq92OF9vhNroPuECXA/G3Rv474RHEV4C/wFvI8nYwd7OQAc4wjvE5ZBECiWvJiajAm
	YBbxA1msMqDeddiGGGy6qSiwZAjJXiGX7sspdHpOkYe+TmVH3g220xLnsLSOlMrWzrtlBGlA326
	yGKGJsZ7DSL4U7tfDdEvLvfNhdp0xmSy3cbNuurQKFSi98Ucn321GS5Jga3JO4H6xYVIPSkOLEl
	YPOBTM7YcFwUepXuJ90VJ+cO2eTaOPZ2EaVBONe3T8mgyfdPFeR13b4a8Ts+rBNq3rhTwL/xJIs
	gBW5UDobcEA0bBg4mxjHiuPIVCB5seoHJUxYFi2H2V2w8EXc85rH38mb3n2ZPyQ8WRBm1DT+uBO
	F6iGBG3i6GON6JdppypA3Mboc9JSCNrIA9fK82yc4Dr13Gica1leF2iTAkSnKi+yjc3AMHIQVM0
	sqX6Pc2SZZmnBvhlB7rjtbX7VUHg==
X-Received: by 2002:a5d:59ca:0:b0:45e:739b:3e43 with SMTP id ffacd0b85a97d-45ef6a90517mr5169087f8f.0.1780133679364;
        Sat, 30 May 2026 02:34:39 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0403sm9960159f8f.6.2026.05.30.02.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 02:34:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 30 May 2026 11:34:36 +0200
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	kernel-team@fb.com, yonghong.song@linux.dev
Subject: Re: [PATCH RFC bpf-next v3 4/6] bpf: report hot simulated callchains
 when 1M instructions limit is met
Message-ID: <ahqvLKBAA88GWHgP@krava>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>
 <ahlpI7sRJt1FQdYg@krava>
 <17304ac9808245282aa2f03f26665cccd6fc185f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17304ac9808245282aa2f03f26665cccd6fc185f.camel@gmail.com>

On Fri, May 29, 2026 at 11:44:39AM -0700, Eduard Zingerman wrote:
> On Fri, 2026-05-29 at 12:23 +0200, Jiri Olsa wrote:
> > On Wed, May 27, 2026 at 12:29:52AM -0700, Eduard Zingerman wrote:
> > 
> > SNIP
> > 
> > > +
> > >  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> > >  {
> > >  	int err;
> > > @@ -17381,6 +17527,7 @@ static int do_check(struct bpf_verifier_env *env)
> > >  		insn_aux = &env->insn_aux_data[env->insn_idx];
> > >  
> > >  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> > > +			print_hotspots(env);
> > 
> > hi,
> > this is really cool feature, I've already used it to fix issues :)
> 
> Hi Jiri, thank you for the feedback!
> Anything you find lacking?

so in my case the first 2 stacktraces identified data copy deep in
the code, which was wrongly done with standard loop instead of bpf_iter,
so it led me directly to the problem

In another run I got the 'Most varying ...' output and it wasn't
that obvious for me how helpful that could be, but I did not check
on that in detail yet

> 
> After discussion with Alexei (who is somewhat skeptical of the whole idea),
> I plan to add:
> - samples for values residing in the diverging registers
> - walk back from iter_next call using jump history and
>   print 5-10 instructions modifying the register in question
>   (in a manner similar to backtracking done for mark chain precision).
> 
> > Would it be possible to make this configurable? like to be able
> > to get this output for program that passed and display more than
> > 3 hottest callchains?
> 
> For sure, there are several options for a way to toggle this print out:
> - unconditionally make it a part of v1 log;
> - add it as a bit in bpf_attr->log_level.
> 
> I'd say that v1 log is a better option here.

sounds good, I think it's negligible compared to the rest of the log

> 
> As for number of callchains printed, I'd like to avoid tweaking

I guess it's better to have it hardcoded, no need to configure that

> bpf_attr. So this leaves several options:
> - make it top 5-7-10, just hardcode a bigger number.
> - add a threshold value specifying how many times a callchain should
>   be visited to get printed. E.g. only print callchains visited more
>   than 1000 times, if such don't exist then put threshold to 100,
>   if such don't exist, print top 3.

+1 to just print top X stacks

thanks,
jirka
