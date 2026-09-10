Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5383DA7DD
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058825; cv=none; b=bOfq00cTCi+HKx86i6P4b0F2sM6Fq3eEtDtKH68yqpDwE5mvDUo4ta/XqkLHfpvoydG8B8/xDQ0fAaLqx83v/vCUYKBgSuXlKnqf1KDpfZs4Y5aMYC+yLu7mwoxnpMv4ydMNGTA9JE3Pzu6INwIw9xwzA1bgwz1e6OQWpDFSIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058825; c=relaxed/simple;
	bh=bOWqcUp3rt4n2pUquLgXuHM5ZhkBZTDfC7YuS23Xo6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls37+Bfw6szEPjeClD6MVGQZZH/zmfLteqfyTg2FOPRL4sH24GOJVxD6CHVhdcVxNa0rOaaMiYW7FWLBYXa+8R5KOEsAwBnSXOmxgHWOZ0aI+todFdtqVg6UcONIgUnsfjNKzwUCvh5sgJ62+sPMVhEN7J+s0ftqqiVK3BgsvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=X2pN7t/x; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="X2pN7t/x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0kiOR+OB6jzi2nFG3Jh1JVXEp2aHV+P32zzPWvgnD7M=; b=X2pN7t/x4+NcfwC26VuqY+wABj
	zp9mA2LswJ9YOKya9amUrIS4LP0JjnZPT/ur/HS1TNEJMnwCtPruY9JnWoG6hLuWGdjqY21JokrR7
	VxHZ3EcZbJ2Iv/oInAosAvv+O9tJ3ZV8vYmAIXxJpGE9fgq1F+q/d1I1EDiCfEv0cYE314795XDLn
	aXqus2e3eGWLso2KlP/28iOZHyqpOKKZUKSuK606hX8BIfWWkph1wykGdl809YQtdldi+1+j4DPQA
	dJoYpnhQG/9DGLjU8IzUCzn9g9pWV5f81zAN9XdRgZ+wGU/NCPSsrO5nS1+8jGw7n3uBaBDUgzV2M
	i3/7h05w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4hvO-000Ikq-1C;
	Thu, 10 Sep 2026 18:46:58 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4hvO-000B7N-0W;
	Thu, 10 Sep 2026 18:46:58 +0200
Message-ID: <9ac1c47b-db0a-4f56-9e1f-6128ea406104@iogearbox.net>
Date: Thu, 10 Sep 2026 18:46:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SECURITY REPORT] Logic bug in eBPF verifier
 (reg_bounds_sanity_check)
To: Daksh Vohra <vohradaksh4@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAOgkP-w9MqFwZs-rgVPAky4r8oih_=Q6rzf=kwpwhi=jr0wUPw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAOgkP-w9MqFwZs-rgVPAky4r8oih_=Q6rzf=kwpwhi=jr0wUPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

[-security list]

On 9/10/26 4:06 PM, Daksh Vohra wrote:
>   Dear Linux Kernel Security Team,
>   I am writing to report a logic vulnerability that I found in the eBPF
> Verifier subsystem within the latest code in kernel/bpf/verifier.c.
> Summary: The function "reg_bounds_sanity_check" has a flawed error
> recovery path. When the verifier detects a math or range error (an
> invariant violation), it jumps to the "out:" label. To prevent an
> immediate crash, it calls "__mark_reg_unbounded(reg)" to reset the
> register's boundaries, and then allows the verification process to
> continue. The Problem: While "__mark_reg_unbounded" resets the min/max
> range boundaries of the register, it completely forgets to clear
> "reg->id" and "reg->delta". This means the register still keeps its
> relationship link to other registers. The Risk: An attacker can easily
> exploit this missing step: 1. They link two registers together (for
> example, executing R1 = R2, so they both share the same tracking ID).
> 2. They intentionally perform a complex math operation on R2 that
> breaks the verifier's invariants. 3. The function
> "reg_bounds_sanity_check" catches the error on R2 and resets its
> ranges, but leaves the "reg->id" alive. 4. Later, when a conditional
> jump handles R2, the function "sync_linked_regs" fires. Because R2
> still has the matching ID, the verifier will copy the corrupted or
> completely wiped bounds of R2 directly over the safe bounds of R1.
> This creates a serious type confusion / state mismatch, allowing a
> program to completely bypass the verifier and perform out-of-bounds
> memory operations inside the kernel. Suggested Fix: The register's ID
> and delta relationship tracking must be safely cleared whenever an
> internal invariant violation recovery happens: ---

Do you have a concrete stand-alone repro I can try against latest
bpf tree [0]? We addressed a number of clear_scalar_id issues in
the past..

   [0] git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

> a/kernel/bpf/verifier.c +++ b/kernel/bpf/verifier.c @@ -... @@ static
> int reg_bounds_sanity_check(struct bpf_verifier_env *env, out:
> verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s
> r64={.base=%#llx... if (env->test_reg_invariants) return -EFAULT; +
> clear_scalar_id(reg); + reg->delta = 0; __mark_reg_unbounded(reg);
> return 0; } Please look into this issue and let me know if you need
> any additional information regarding the tracking mismatch.
>   Best regards,
>   Daksh Vohra

