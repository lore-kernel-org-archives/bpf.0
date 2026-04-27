Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678D34B662
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280161; cv=none; b=AfoRQaM6xwbmzzOg1779xNnC+R0cJkFQa3zlAKYysSIJ4x8nj+odoPUutob4o2NzZoWlnbEEFdgPMS5fXkQf+DrcgOf0q+VjtcIpnQspWKLIcEYtsqgwQaopTTS9Nwf900lCeN/SGSlASG0M4BSza3auvfONjuGunb/VdHTabnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280161; c=relaxed/simple;
	bh=nSyNAYP9VF/vH2DSSAUwmYJlU6QfNhzTTn25r5ShNpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIGBErkofXQyZsUcsnAPleFjT+bwgC2KNRb3OI3Xp31p35RQW+AnzyK/DKGG4ZqDpOpfXQFDjwT0sxvSvdVMGwlUuQyzsWR8xT5AdZJ3qohinVNK07Z0nllAuAiBnskofKKcQaLxjuXQ/Ds5Mx8XYLSA/Jumvea5xsCYnBpMoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqy3ZDz1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqy3ZDz1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso67188535e9.1
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 01:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280159; x=1777884959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gg8xcE5nVzUCLwlpOgMSnuz5hEr/6m+rEcYGBUox7Sc=;
        b=Pqy3ZDz1tTR/rf+VytVOaA6RPcjXIe33Qh/JhNFS5gRt8z44ExeSONgjfycO92+tHx
         hnVv3K48lGvo/gnrVk/t1+BmIKatXrVd2MEko20CZxecm/i3MMr3ejHbntqP2024TgYn
         xvP3lSS+Lmxd7IjADHxmNiAEt/0zEeXKfAxtnqNqzO4HNX5vzgFaJos2jY/DpV/+PeT8
         P5SRX/cAf25frpEx0Ofiinc/WZ2O1ifpNvBfr/gN5hI/i9Uc0WGnBSsNyslbXOOOPNiU
         aKZs9+Hi3hdBRx2r4roWEXUfCzYf5BVpJPdG+2Zyo7K+nqmhRQm146+Hd2a4Y0LCAKR3
         ChyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280159; x=1777884959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gg8xcE5nVzUCLwlpOgMSnuz5hEr/6m+rEcYGBUox7Sc=;
        b=G1ibHrwjNF/26SD+9vX/Q+a7XujgwDxVHM/RY5Ze7+EbCuuJowv1K+hn0I0+z1M0X1
         wDD0o1pphTTPzSnJRUQaPr+LhcbPHctLcPQ74IGKviWhN7bvfKYvRTZjpn0BaFi3pPxB
         1/FA/Z8syXX9TPE7j2zUzZ/Ikwee21AbHzJnbc+mju+aABvpUM+jhdqIX1yXb18oZZLW
         c6ZnQTDD4VECj2TE+gnki4F3ggp0j1bYLgb9q22rEGD2jV0eORoMU/h5F9sflU8LG0dm
         he7mdQYWST0zIBadFuF+cZ08xvk1DCybo9VgJ4BrXFIkxCn+93HdzJ8UVUQo82pXQvfj
         3N7A==
X-Forwarded-Encrypted: i=1; AFNElJ899PlPiY0DEn6I5bWU6nhV7kpdOOmRZk5nMebyZj/IIS4FXcQPQdWzJUqTGFvz/X1sg8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYxvy0P3HJXDeGGyr3auoiiPdzwm0gA/kvtrVsMJiVcCobfLo
	RJ9RNaBMjA4REXcx/+oiJFzfAOEidbpsQQsepub8pwILgvdfyVkSOPOd
X-Gm-Gg: AeBDiettgViI4mfwzTPGadDLSwvAT3MCi5gTEO13WYQk+5c9yR9M9nDrk1L4jLI8tGO
	lYzQjABn12jT2ZypBK4XnDSzol2Gws06RrxoPOb+M2Pkj7itIjdRRefNLUklVU4qnILf/AY/LqP
	9XlANwOEcK66WCYZ8kqWGOycKo8tHRM2aDQsuZ2GT6ADWtSt1cbWE/8ub67jg5wU5Y0hkCCNb67
	lYl+YBpFzQ9bw1H5Bhj886Wk9NFJIxPS4DTRQXJZ65/QkjhM0ULDQlN+yYUfVWYoI7QD83cLjyc
	ynpMLujrLKVV4RLqTmiIAyOKvuULill/CTfOSBRzh6ZQ8ankE8KpTVqtXEtdxQDUGLgga5RGBtq
	4xtMiNg9XqGElBf1kbDvgpa6hKhbB54qf9rmxFDe0eYJx8ftGdMb3J83oKqxQ2VTMALwKuzpQb5
	k92+f3mueVZHgIRipJMlmF7L6XhHCZYC5fjiqlrQcb0dNbEHzhfld3hPQXeRY5wDUhz//XmV6Dg
	sFQe3xwRvcMy2st1+P2vprFx2bgxBcaV0BNemDdFnSZB7/gpiySi3fDI3XeVWhep6PPxAo=
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-4891ae14f23mr447767705e9.28.1777280158625;
        Mon, 27 Apr 2026 01:55:58 -0700 (PDT)
Received: from [10.30.6.33] (93-47-80-68.ip112.fastwebnet.it. [93.47.80.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm73703654f8f.22.2026.04.27.01.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 01:55:58 -0700 (PDT)
Message-ID: <12c2bec8-ffb9-4b01-8bea-819c6ec77c5e@gmail.com>
Date: Mon, 27 Apr 2026 09:55:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix missing submitter_task ownership check in
 bpf_io_reg()
To: Ali Raza <elirazamumtaz@gmail.com>
Cc: axboe@kernel.dk, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 krisman@suse.de, linux-kernel@vger.kernel.org
References: <e49d1391-b06f-4d60-98ff-0f034f2ed9e9@gmail.com>
 <20260423084024.31721-1-elirazamumtaz@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260423084024.31721-1-elirazamumtaz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 09:40, Ali Raza wrote:
> On 4/22/26 10:20 PM, Gabriel Krisman Bertazi wrote:
>> How is this a protection?  I thought ctx->submitter_task is about
>> IORING_SETUP_SINGLE_ISSUER. there is no permission or capability over
>> it against other processes.
> 
> You are correct.  submitter_task is a SINGLE_ISSUER mechanism, not a
> cross-process security boundary.  The "parallel path" framing in the
> commit message was inaccurate.
> 
> The code confirms it - submitter_task is only assigned under
> IORING_SETUP_SINGLE_ISSUER, either at ring creation [1]:
> 
>      if (ctx->flags & IORING_SETUP_SINGLE_ISSUER
>          && !(ctx->flags & IORING_SETUP_R_DISABLED))
>          ctx->submitter_task = get_task_struct(current);
> 
> or deferred to IORING_REGISTER_ENABLE_RINGS [2]:
> 
>      if (ctx->flags & IORING_SETUP_SINGLE_ISSUER) {
>          ctx->submitter_task = get_task_struct(current);
> 
> The check at [3] I cited returns -EEXIST to prevent a second process from
> registering on a SINGLE_ISSUER ring - it has the effect of blocking
> cross-process access but that is not its purpose.
> 
> The commit message's Requires: line was also incomplete:
> IORING_SETUP_R_DISABLED is a prerequisite but was omitted.  Without
> R_DISABLED, submitter_task is assigned to the ring creator immediately
> at [1], so the attacker who creates the ring already satisfies
> submitter_task == current - no timing window exists and the attack is
> impossible regardless of whether the check is present.
> 
>> I'd argue this is a non-issue.  If you have CAP_PERFMON, you are able to
>> mess with the process in many ways beyond this.  Otherwise, how a
>> process would be able to get the fd in the first place?
> 
> On CAP_PERFMON I'd push back slightly: it is narrow (BPF program loading,
> perf monitoring) and does not grant ptrace, arbitrary file write, or
> process control.  The BPF struct_ops path is specifically what
> CAP_PERFMON enables here, not a general process manipulation capability.
> 
> But the fd acquisition question is the real barrier, and on that point
> you, Jens, and Pavel are all correct.  As Pavel noted, any application
> that accepts a ring fd from an untrusted source and calls ENABLE_RINGS on
> it is already catastrophically broken - the BPF vector is just one of
> many things an attacker could do in that scenario.  There is no realistic
> path to get a privileged process into that state without it already being
> compromised by other means.
> 
> The fix itself closes a genuine asymmetry - bpf_io_reg() is the only

Not a fix, submitter_task was not made to be a security mechanism in
the first place.

> registration path without this guard. I can resubmit with an elaborated
> commit message, if Pavel thinks it's worth applying.

That might be fine to add. I omitted it because it happens off the bpf
syscall path and not through the io_uring registration syscall, i.e. it'll
break if bpf folks decide to defer registration to a worker thread
for some reason. It's of low probability to be a problem, so it might
be okay.

If you're rebasing, don't forget to use the latest branch and look
up how it checks ctx->flags around submitter task.

-- 
Pavel Begunkov

