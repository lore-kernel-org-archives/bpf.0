Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923937E5D9
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453548; cv=none; b=JzFshLhnj1EQU0GxAJfRDpN70w0e8OeqJdV/ApC2aDmQlLfXlX20R7MtWwmT46b3OmNstpR9Lx6MeUXv7hFCTQZQ7lvSO7GtuGHqLMOqvftGDbXLb/7tiGFIqFz8GIjBdrqaF7hyzMVljNfCztDWeNjfUP0yeO/KCeUi4l+ykrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453548; c=relaxed/simple;
	bh=aLMBrcPWTZCdw0WfHdJOhtUC+4XxhD23zOXG0xPYfwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2gb4WxHGDpK2L7fXDTlEvhimM+P2Qbf+DHpJTH2QOa78kvJpqCrUCgwMsn8HGIifX5LAZEEaKnLr86lP3FxI/x13+HKmt3/rll9c+f1/rA4oFmIJdFzcXo6w2JMNgYlB+0vE455EpFOQQBWDBxU6V9Yk7wOmswPiJ6yS1osEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edbliV5G; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edbliV5G"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso186355b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785453546; x=1786058346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H7ePSkr4Nohk5yi+jX5ROWCggJE59bixaFcCgsHLMHk=;
        b=edbliV5G7b/1Qrv2bl2TeMx0WztMNGLPvmr2HV96YcOwrnRpm9E+RdN6NuwVHLl434
         Ft1P6cdVGYlHPL6pFDgxPs4tHwXlDAjZegnLp8LgCJ3HG5Kn6DWFjDGCKuWLRUM2YJ07
         jFuSfhFOCqlNUMAl0TBFo6JNSDyQy7XPSPQl8QGHQyQPBjK3WGYZl1gSP/CGrTu8/meO
         iPMVRGyc+RwruDIvdcSTqFuEUm99mpvT/czcJSWakn8dxSruIC7Zpf1fNsAKd2IjKZFq
         N2uowuQYFSiA0oFcX4HsRUr1Mj+GDY8LdtMckDkKMjijajQ72SPcAIwJa+Et08RTVMYn
         8F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453546; x=1786058346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7ePSkr4Nohk5yi+jX5ROWCggJE59bixaFcCgsHLMHk=;
        b=PAXpXW42Kzj0Nfcs/WtyC7MgS0MEAWCXQx1yJVBp40US19qMRhLa2qQRK4ZckSZWT7
         7VIdfnXIISs7IecdpfE+59DPGWNTFa+INBwhYy6FoILrDa0r92rGUnC+3qfGPBuCr8/q
         8sBQXwcnolvf3xm6adglfl/gcY2FCZNM4fzlqabZb+w1ijAMvR9IzwtvZ4QvIu4UjVZ/
         OrFlgnEqCTIiGKygCd0JMRW9QdWiupEYxSZ5llBYTMYIHBioRs5j+u3cIkYspr0rK/Qn
         nBQnC6UIudfMeqEHFlNvw6v59FhQURVv9lztvdZGZ9qBB/qSMsr89HWC+ZnBYnptY3Fx
         2ntA==
X-Forwarded-Encrypted: i=1; AHgh+Rq32tfJFVyZTo7/U4kP78+FA1CFr6Ebc+zCnqFCtJDIkj7rjO/eI+JtKCrwsknCChI7cmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLONqW+DN5r5rGHkYi9y4flCaEHQJnBa/cb4RhXlLD1+JyFiZJ
	419BRZRV/WAXnbiKLPupnqnJdPOyFHPOy85qvQE6GlfNH6A8rpbplRMHgSTWXRinFcI=
X-Gm-Gg: AR+sD12VJRnGI59DgfcewKXQDPZdWITXnpSs3W483pvJ/lFYfDSs3eEM70+dPAKOst/
	nQY7++ENggffkWs+K3+jYKD/G+6cViS17SYd1e5C1462cPoNyK3wvbL2TI4xnwGb7clic5LaC5t
	HN2W8SWfqNOPc4PsndhctS3CBjk/cjIUopHSfYe4HkXbCdZ5aqjCaIJPIegs2ZIPVghzpkOI53E
	ibND3o3Nu/0PVbCy0SJypxabH4pYd5MjVcNzNKX5/BgHMI4GeVYOvUDm1UcU+ADsNI+6w/+NhUl
	FKBHmuZsZ0AW5z+kmM7pOI9g1436e/ZL9C07xdTrVDrIuzTC48a3rRfL95uh1UIpn4yAJW5CPDl
	zTtimpr9a8deBU89rQk8Cv4MuN8mGu0P/AlxLhdvYVWPv7dLcINW3hFw7eAtgSS+IzEu1qUJ6KX
	oW43LkICFyhw6lpD/PM3uOAOUlFg6v+MO5ExdR7EMeKcFJ12gm0CHMOw==
X-Received: by 2002:a05:6a00:b8a:b0:848:2f58:e1eb with SMTP id d2e1a72fcca58-84ec9f635d1mr1760230b3a.38.1785453546109;
        Thu, 30 Jul 2026 16:19:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe238ffsm3773363b3a.12.2026.07.30.16.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:19:05 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:19:01 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v2 0/1] xsk: fix unaccounted ring allocations causing
 memory exhaustion
Message-ID: <amvaYrq3bpuT5sqQ@devvm7509.cco0.facebook.com>
References: <20260730153832.11238-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730153832.11238-1-zihanx@nebusec.ai>

On 07/30, Zihan Xi wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/xdp/xsk_queue.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> ---- details below ----
> 
> Bug details:
> 
> AF_XDP lets user space allocate RX, TX, UMEM fill and UMEM completion
> rings with setsockopt() and mmap them into the process. The shared
> xskq_create() helper allocates the ring backing memory, but unlike UMEM
> registration it does not account those pages against RLIMIT_MEMLOCK /
> user->locked_vm.
> 
> As a result, a process with CAP_NET_RAW in a user and network namespace
> can request very large rings and pin a large amount of kernel memory
> before bind or any packet I/O. In our original report the resulting OOM
> ended in a panic because that guest had panic_on_oom enabled. The panic
> was only the environment-specific end result; the bug itself is the
> missing resource boundary that lets ring allocations consume excessive
> memory in the first place.
> 
> The first version tried to bound these allocations with sysctl_optmem_max,
> but that was the wrong resource model. We also evaluated a memcg-accounted
> vmalloc path as suggested,

[..]

> but memcg attribution by itself did not impose
> a default enforcement boundary in our validation setup.

Can you expand on this? Maybe we don't pass some GFP_ACCOUNT flag or
something?

> AF_XDP already
> uses RLIMIT_MEMLOCK / user->locked_vm to bound pinned UMEM pages, and the
> ring pages are likewise user-controlled, mmapable and long-lived. This
> version therefore accounts AF_XDP ring allocations with the existing
> mm_account_pinned_pages() helper and unaccounts them when the queue is
> destroyed, so ring memory is constrained by the same default limit model
> already used for AF_XDP UMEM pages.

We get RLIMIT_MEMLOCK just because the users do mmap(), nothing af_xdp
specific. Idk, manually doing accounting seems a bit wrong, memcg/kmem seems
like the way to go. (also, panic on oom also still seems wrong)
