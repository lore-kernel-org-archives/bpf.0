Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6663479889
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028483; cv=none; b=sZaoFt6w4jgiE2jax1L7Ya22Gr/0FEC3/1NhEZdPK73aXws5BZsGSUK+Q0dVYOgZ4awsuRxes57sxz7UGTFTdIqsa9hrOqXos+QMiRsgT1eZDGv9WVn3N7/oK0M5MjFGt1WirPC8pnrRFFnaM6olKiXtdqKO+43dLZ/KhTK3JBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028483; c=relaxed/simple;
	bh=Y99ilbLrRENRwJW/P4xjAwZSFPBHEC9V6LB/IkSVoe8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kOTBgflnxcFlIB6FKD1RW6hHaNgCBGvQG4kr1YLDeof7LA+6/ijz7gSw42hcDRIgCcjNt5H/pvebdBUPXfpqoWVXyGDRNL+KN/h5L2NVfTUPi8NeSXXKU+WeTF14M1xiKI+nl/S9dIo7DgyuRUwnkbJcvUf49nv9CA/90tdeeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+oBtx4j; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+oBtx4j"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-473ba029526so321378f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028480; x=1786633280; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dioGFzjSs7KaCLGjqP+oJJAaenl4kyHQ52JQwiLek4Y=;
        b=P+oBtx4jbjDsnp764e/9NP0YE7aPqkGqrINCFmGDwQf1tKB2guJqb1etCjsWADYoMz
         Jitx7iSr9hFEX1/Ns5Vovq8cnOBMFM5PYqCPtY8SYTDRmP5/Fhn5oRWCxI+KgknvQcL4
         p+bNmEbzVIY6h+PW3qedOqrctG/FAzveTSRElwj+qzRSCDr9EcyYh39BVFYY6/yU6H0I
         cJCdo9TB0jZZ2uP+i2RuQ7VGG2up/o8HQlt3Oe2mCCiF1U3QbqH3FGpbgJQu5HVFEs2s
         NsBoB7p5YeLpViQAfDbmLXPnQxGzgaliKhwVLDa3G4xDaSdjhG4+KRD7VwUah7FQwce8
         ltZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028480; x=1786633280;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dioGFzjSs7KaCLGjqP+oJJAaenl4kyHQ52JQwiLek4Y=;
        b=KlPRWQYcNbLGDc28JFD3e3h/z1lvT9p/8twoYpbGnlAkVfAJ2De5BqzvXbFoDjrYVP
         ugcRlXef2ZLpuu41L+wxfMzaPG8zJ0kqmQmmeY1H80pOtSYFCCOEGp9EvU3/hj8ctV1B
         SXplXinhyWyNTAz7C5FvHvcmgw4Np+AygCYR7gYfiKPozRlPAe6AVyKietZDjl3FWec7
         V4t9x3zdGeZinsgBpgAxxKwCLeSnCYBNM8s4a7i/Dg6jvPq+EooaIZK4gBEeZ5u2NYwx
         qR8S6YmAA8nDCBLZ6n4QiLMrXDLbzlHh4HGiCNETjrcd8PAR8Z3gO8i42z0w5XR1mxKy
         Tdwg==
X-Forwarded-Encrypted: i=1; AHgh+RoG1ekcQslislblsCXvdGjhoczKcBhM//bDplmmHYVkc4WoOTsV5++fK3iZGFETj6cmxeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjUBFD84HtzUagxY3fou4G6e0RlfP1NL9BRgdbC2UPwt1hoJN
	CP8BUoXBooMMMgf43cXakWPTXZBm5mh874tAZqgMzoWo/A8QXf659/5O
X-Gm-Gg: AR+sD12YA+0RELJHiZDfPEsmkF7lpwAp/xpEwfrKKtGvdXDaQR3Iy3F2nJH/n4dCECC
	Znke2dmv5mkcu8kJdJLRmMQxfB0juUfpcqFeca/DtBvQLMNmzWFUisOchdw0RhsvLPDzx1Hcg1i
	KH6UQBmhwzN8AwBBakGjFf4vMIpl4UrgMWG+XytgAoFQuo8ykx/L8wD3Lwx/SoezGhJzLP0zYT8
	ePcX/RviGy9mMU74dV3tLWYyYpy4/ueCRLhYiDQLboKhH+0bUcdUYkgxv6qaZ9vzEI1mCyB+qsw
	DpPs5pVvg997ZXw5d8diOm9d0FuG12iYf6iAtPHA4A3nXw6KMTfzMG+dZVmqbL0EGpYcVuEGSHL
	4mgE6VgbgcMceTpOpolA1V/x0Z2qMX+H1PIRA0EPfbRW23ZG4aZhg0OsTGPsTzkXxz46/iFlJ/Q
	RPqAdLC8P3ttDO+RnR1o8TWoLs5BCiyWCIfHd1DnzqqBJXDU34UXK0rbAv+4uW5/JJbgvD0iTg5
	/a8HHX/Yop7HBmarnR4/opqnVmjhrR+sptDI+JwwpnGfnOBdGqFnrft4cfnxna97yqtBvK+MCvi
	LkHctInvIKSCt+60kQsXPgkPVtI=
X-Received: by 2002:a5d:5d89:0:b0:47f:ece1:1eca with SMTP id ffacd0b85a97d-47ff8584853mr6549157f8f.1.1786028479664;
        Thu, 06 Aug 2026 08:01:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b819dsm7067045f8f.16.2026.08.06.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 17:01:18 +0200
Message-Id: <DKHY982BEJN7.2ZUBJJEXR8X7B@gmail.com>
Cc: <puranjay@kernel.org>, <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] bpf: Track overlapping RCU protection
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260805233940.3966981-1-dingning04@gmail.com>
 <DKHQUVB5TV0R.1OLK7GG1APAOR@gmail.com>
 <DKHR95T6P1ZC.G09YF6M1QEL2@gmail.com>
In-Reply-To: <DKHR95T6P1ZC.G09YF6M1QEL2@gmail.com>

On Thu Aug 6, 2026 at 11:32 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Thu Aug 6, 2026 at 11:13 AM CEST, Kumar Kartikeya Dwivedi wrote:
>> On Thu Aug 6, 2026 at 1:39 AM CEST, Ning Ding wrote:
>>> Preemption-disabled and IRQ-disabled regions provide RCU protection, bu=
t
>>> the verifier does not account for them. Current implementation can inva=
lidate
>>> a task kptr while another RCU source remains active, or keep it valid
>>> after the final source ends.
>>>
>>> Track these regions and invalidate RCU-protected pointers only after th=
e
>>> last protection ends. Add task kptr tests for overlapping protection an=
d
>>> final-exit rejection.
>>>
>>> This follows review of the applied spin-unlock fix series [1].
>>>
>>> Tested in QEMU/KVM:
>>>   ./test_progs -t task_kfunc
>>>   ./test_progs -t preempt_lock
>>>   ./test_progs -t irq
>>>
>>
>> Overall, looks good. There are various failures in CI, so you might need=
 to
>> update or adjust existing selftests.
>>
>> Make sure to include selftest changes for _existing_ tests within the ke=
rnel
>> commit making changes, so as to preserve bisection. Your extra tests sho=
uld
>> still go in a separate commit.
>>
>> Also, do we need that was_in_rcu_cs logic for bpf_spin_lock(). Would it =
be
>> possible to drop it and do it the same way you've done it for other case=
s?
>> If that makes sense, I would fold that cleanup in the first patch as wel=
l.
>>
>> https://patchwork.kernel.org/project/netdevbpf/patch/20260805233940.3966=
981-2-dingning04@gmail.com
>>
>> pw-bot: cr
>>
>
> I think from cursory look, the reason is that we forced any MEM_RCU point=
er to
> be invalidated before, even when program wasn't sleepable, which does not=
 happen
> now. The failing test used a non-sleepable program. So making it sleepabl=
e should
> preserve the failure case. In some ways, this is probably an improvement =
over
> current behavior.
>

I fixed this up since it was minor and applied the series. Thanks.

>>> [1] https://lore.kernel.org/r/20260803112615.3362122-1-dingning04@gmail=
.com
>>>
>>> Ning Ding (2):
>>>   bpf: Account for preempt and IRQ state in RCU protection
>>>   selftests/bpf: Test overlapping RCU protection
>>>
>>>  kernel/bpf/verifier.c                         |  13 +-
>>>  .../selftests/bpf/prog_tests/task_kfunc.c     |   6 +
>>>  .../selftests/bpf/progs/task_kfunc_common.h   |   2 +
>>>  .../selftests/bpf/progs/task_kfunc_failure.c  |  49 ++++++
>>>  .../selftests/bpf/progs/task_kfunc_success.c  | 147 ++++++++++++++++++
>>>  5 files changed, 214 insertions(+), 3 deletions(-)
>>>
>>>
>>> base-commit: 11c1e836710dcba03e50454a4eedfdbaf8d3050e

