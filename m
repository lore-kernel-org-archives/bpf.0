Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500307404E
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716516; cv=none; b=HGPa0E88pKaZGPw2WRsOoJeSathuuSdIvrsCQd6IiWuG59/Jxae58+1dhfBW620s0WRozKJUBRouNboLeixbd5IkleXVZVFpeGOb3qqKfq4nGu0io8p05YNwgs0xPmfAHEhlFtdAx5oaNirVJ49GWP52L1ZiPt9O0aDGLuH2Z3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716516; c=relaxed/simple;
	bh=GTcAyc+tWM7skK1McyRj0kpf8UsTCgFPbQ9HvYQWzRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjY1g6F7hzKWjT1OLInqBolwdqHxc0MzIGSSXEhHi6qg1rRmqWIOSFs5kzNuYAI8n8QMOeAj0OR9baywseFxo8HUHmAG7dsMIRoIbXK4CsX8w34BdkX1K0zFXHiwKWE4MiuOjVGN2cAPWUfLtNyfOKmVbrnRoLz+6sjJ4e9MtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+YtSHRt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+YtSHRt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so91557445e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 05:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772716514; x=1773321314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNs09FtE1jojC+QO6B7t4m0dp5VWSRxHvoxZTDrwiTM=;
        b=Y+YtSHRtn4W7B81hLBKrkHhEx82uX05oXs+aD1mPQuIRD0y3caAyiMTohQATyKW3la
         5Pf16g4GrNTYfAe56/Zl07/77q6q5/RcFoO5wt7WCsTDPVyVyKtuIXNwSjddOW1b9fIh
         WsmEP3taBMyMF9eN/uaRhsfI6uFUYDaa0hSCvD8kbgFFKGj+GJHWGs9q/3sXEu4lMsOh
         omwsHyqs7jkAlyLrCxFkoWp1aa1u72cNwRBgitQcq7o/tM5ha6empANJVU4NAR7lWE4f
         vj4xFpag+P/TwOa5mejqbelVR4obEmnVu7xSYY41ajr9FcEb7O5/Vu/ehdiLPpj3L8q8
         XyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772716514; x=1773321314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNs09FtE1jojC+QO6B7t4m0dp5VWSRxHvoxZTDrwiTM=;
        b=JVu0pZbv3BqAMm3w1muqF95D7jP5pRWplQAwTmtan7jNhk6PJVmsDGo1B5pkmY0NNy
         GGDPdE5H/NRf+iMaTI/dHeuvMAVldtv5jZVQN/Pscn/6xKvTUK5IsAcEkmO8IMStOw9H
         svOczcXyZ19OsTDCT970JEXx587aW3VPc8xhvqqxf4rdMkQnVLFR36ifjuDTNvd+pSR/
         oJHyIbF7SbkFCmLSjlgT+W0FXw5x0D2VkFKCJLrlfPv5qo4kpx2zWdqSU74pdyA67tna
         MlUqLKgGC70YF8phrV79/kvDyXaqYsPru+L09cvGuiRHKD57++W1fmJsN5n01PjsLVQA
         vpbg==
X-Forwarded-Encrypted: i=1; AJvYcCW37VRhMLxt/i5UhjdtNCvK6ANOhJ9ug3F0HtqcKEvvzUVQVZklxtsR5Ctv5+uC19NzxH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFovBsCNPAHYQK/UbzrF17ipnk1ATA1bmfHsFXREfin5kGN+T
	0oYnZwJnAzpqTVMGAIYAVCh0pxuRskyhHE/1RHpBpMq6QJVFcMPyPaDf
X-Gm-Gg: ATEYQzzFTH8qezS3XVLjGgkfh0rSEdzcM0G8ztkzdWO5IN4fijhKULXt/vhP9Q7v4UN
	rN2km8ECBCn6Y0mJrqBkQO/t1FrVm4tK0/WXSvTliRUllhhs6ukVx6PV48Nd56+vAMPqltiJiBC
	bgNLTBveytwVd2EUvQ1c4/qp1WVXvUegATjHxxCIttjEojizZB8b+1dTpHrMy68N2xlI6dzZBW2
	KkHflnoLQZa3qrI0p8U97NCsasNTWZSVOJHWCI9KTit/p5PIgNwzzpcmRgAi9x/oOJ132oq4GT1
	jRwbPGEMb7XLFkTQAzU+9hgXSLFXdV9EH8EfsPm9e5ncBNoEUS7CtYxK9Xmjk09nZieTkem8r/i
	oyLhDSyY+Vx76S2o3MHXuFFKQa6R3y5ubxQog7H8ThcM+zTAQIvz+iyagc1uO95vR/foDqhlTml
	ixI3W5eOtAe+oOgBd2jHlU4cXqB+yvhirHF91FzbaDwR5KlsnKSERTDC9fa2dnzJatBO/744The
	5l3YQg+4/P/41ZFDcs9TJf1Sl1mBRE4wV/8lC6ChV3IbRv/5wT4SWLrvMuclKUV063rcLwE9JWe
	sJgQfPmIPJE=
X-Received: by 2002:a05:600c:530e:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-485198be61fmr99059465e9.35.1772716513363;
        Thu, 05 Mar 2026 05:15:13 -0800 (PST)
Received: from Tunnel (2a01cb09b0519f207c62a4b1b291a19e.ipv6.abo.wanadoo.fr. [2a01:cb09:b051:9f20:7c62:a4b1:b291:a19e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8a9542sm73409075e9.1.2026.03.05.05.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:15:12 -0800 (PST)
Date: Thu, 5 Mar 2026 14:15:10 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <aamB3iv2njtHWgPB@Tunnel>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
 <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
 <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>

On Thu, Mar 05, 2026 at 03:10:00AM -0800, Eduard Zingerman wrote:
> On Thu, 2026-03-05 at 14:54 +0800, Shung-Hsi Yu wrote:
> > On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
> > > On 3/3/26 11:27 AM, Paul Chaignon wrote:

[...]

> > > Side note: you might be interested to know that Eduard is working on
> > > consolidating signed and unsigned domains [1].
> > 
> > \o/
> > 
> > When I last look into this[1] there's was the "Interval Analysis and
> > Machine Arithmetic: Why Signedness Ignorance Is Bliss" paper[2] that
> > looks rather promising. And lately there was also "Program Analysis
> > Combining Generalized Bit-Level and Word-Level Abstractions"[3] (haven't
> > read) that seems more specific to BPF verifier.
> 
> Thank you for the links, I've only seen [1].
> I was about to send [a], feeling really smug about cbmc tests.
> But then a much simpler solution [b] occurred when figuring out why
> 64-bit test can't be written.

If I understand [b] correctly, it's the 32-bits equivalent of
00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary"). I
didn't make the 32bits change back then, but it makes sense that we
would eventually need it :)

If you end up sending [b] as a patchset, note that we still have a
selftest for which we skip the invariant violation check:

  $ git grep -hB3 "\!BPF_F_TEST_REG_INVARIANTS" tools/testing/selftests/bpf/progs/verifier_bounds.c
  SEC("xdp")
  __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
  __success __retval(0)
  __flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */

I believe, with your patch, we would be able to invert that test flag. 

> 
> I'll probably continue playing with cnums at leisure pace.
> 
> [a] https://github.com/eddyz87/bpf/tree/cnum-sync-bounds
> [b] https://github.com/eddyz87/bpf/tree/32-bit-range-overflow

IIUC, your current patch doesn't maintain a cnum domain alongside the
existing abstract domain, but instead builds it only when needed, in
is_scalar_branch_taken. Would your long-term goal still be to replace
the existing four ranges with two cnum domains?

Either way, I believe it will require significant changes in Agni so
I'm interested to see where this goes :)
