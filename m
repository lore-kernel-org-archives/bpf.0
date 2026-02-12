Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27ABE573
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920060; cv=none; b=WoJ9ZBhlvnGdauFJvM2J7t5mO6Bcq/YniqXcLXOwjG0VxHBz1UDAMFYNmWf0LMuY3xwi+xaTykcuB0cy5m+jZ3jaNblpXLxpiArx89pN81cObGo5aqVJhbWC5zHccqdh16ak8XvH4WAzxJ7TEbbORouiKAoXx1mWM5hHb/HJrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920060; c=relaxed/simple;
	bh=49/VR3Nb+6MGxgEYoaUIKYYX4teBb+AOfHNS9MPE3e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOjtsmLH6LcZpX0FPG6eJLKW65Oll5TFwMrQ0QXYBp0IrnjFGKxLEJZjCl3xE+YSjqcE44m+877SDd/PUl6jMvvS29enJHkTB8Ui+h0xYH9fTIp4SGTg8Oae3/Ahtm6Rq/3q5uenE1RwQpXfjzS5pbzY9j7hcKuJMafaPh55lq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyAgySc5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyAgySc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770920059; x=1802456059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=49/VR3Nb+6MGxgEYoaUIKYYX4teBb+AOfHNS9MPE3e8=;
  b=WyAgySc5Y33JEpgQhEGuo5Xro7Fy8zXLmHjHFl/XF9UDxvjiVc0Oe78v
   w08OykarOyzxC5NXcE8xcFfwytU2SiyLbDavP1OTq6Dy+ZdeyCbTPpGgm
   aLCsdH/teBqECIZepOl+4SakYk+0z6e9pkbg7Z4HV2FM0zZPogLYSjbLz
   qW2lCm8KoqSKiU/7euzx87ilSQiQxKOGdX7zAtOtM/bhgxlTEc+h+XUIZ
   npGB4i/pIFUb88f0Lz2WkVvAPHtclI9qlo6DgGF5XMViNuUXKRHeRPbjV
   U+5jBd026a1Ag+Q60qBQaH7WYJMTXecaxfa8iTawt0CxKtyhtaRNRKZcW
   g==;
X-CSE-ConnectionGUID: +akxaLfJQI2+2261Ly2dbQ==
X-CSE-MsgGUID: 9XTNdp6FTTmS1gwGvr5TaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72284428"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72284428"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 10:14:18 -0800
X-CSE-ConnectionGUID: OlYWUcH1QOiJNlr9+Lr7xQ==
X-CSE-MsgGUID: YyWr5ChGRJ+efFirdVAiJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211459613"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.202]) ([10.125.108.202])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 10:14:18 -0800
Message-ID: <d6d37293-592f-4109-90e9-20b77b023476@intel.com>
Date: Thu, 12 Feb 2026 10:14:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] eBPF isolation with pkeys
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, catalin.marinas@arm.com, david@kernel.org,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, sebastian.osterlund@intel.com,
 dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com
References: <aY3+Raf8eZqipCd6@e129823.arm.com>
 <f20ec2ee-90f2-4ef7-bc3d-088f9ef6c38a@intel.com>
 <aY4KfM6wFaSjHWri@e129823.arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aY4KfM6wFaSjHWri@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

BTW, one high-level thing: what you're talking about here really is a
kind of hardening or kernel self-protection. It's in the spirit of Kees
Cook's work: how can kernel security be resilient even in the face of
kernel bugs and attackers exploiting those bugs?

Those who buy into the idea of Kees's work will likely agree with the
premise of this patch set. Those that don't, won't. :)

On 2/12/26 09:14, Yeoreum Yun wrote:
>>> To that end, this discussion introduces a set of new allocator APIs and
>>> explores more extensible API designs:
>>>
>>>   - kmalloc_pkey series
>>>   - vmalloc_pkey series
>>>   - alloc_percpu_pkey series
>>
>> It all sounds fun, but this doesn't exactly seem very generic. The memory
>> that sched_ext needs to access is super different from, say, what a
>> socket-filtering eBPF program would need.
>>
>> So this doesn't seem to be likely to be true "eBPF isolation" as much as
>> sched_ext+eBPP isolation.
> 
> Our current isolation model focuses on restricting writes and execution.
> Therefore, if we allocate only the memory that eBPF programs must write
> directly with a separate pkey (e.g., packet data or sock),
> it seems to me that socket-filtering programs could also benefit from
> the same isolation.
This means that subsystems using eBPF need to allocate their data
structures separately, or at least in a pkey-aware manner. They either
need to declare the memory at allocation time, or need to be able to pay
the cost (and the collateral damage) of changing its pkey after allocation.

This _might_ be doable for the scheduler. It probably has a limited set
of things that get written to. Most of it is statically allocated.

Networking isn't my strong suit, but packet memory seems rather
dynamically allocated and also needs to be written to by eBPF programs.
I suspect anything that slows packet allocation down by even a few
cycles is a non-starter.

IMNHO, _any_ approach to solving this problem that start with: we just
need a new allocator or modification to existing kernel allocators to
track a new memory type makes it a dead end. Or, best case, a very
surgical, targeted solution.
