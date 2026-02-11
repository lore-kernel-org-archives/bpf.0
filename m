Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E501FC8
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770768510; cv=none; b=KK0yOn6LwzDVYkyqp6EYeTl9wdOttoJEBJ8hnvua28q7pyZ7ocKDIfaFL14lenDuFfE1Z0sGrbNznu/0gSBLPndwqL6KhHosgmH0rspHr30x2gTCtb0ppKV+v6lY643aZYtPSDijsj7aUZSoSgHO2kUBjpoNHO+DYSo86G0dQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770768510; c=relaxed/simple;
	bh=96qR/xLfAYMnto0gImcY6cOnCCPs8kn6HB3PKHfAJq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=DuUOqrzAAxNnyE/vvjLXJks4jnxEADq80HZATC9xpu9cOeQG0yyXNFEANjRWRvTOp1Ps6BIRp4K/wjqJwLZlyFcjLAhGk0quBoDHdjE5GU4whms/nnZ+qwlk7kI/fyjfDhxrKXjkkr9u7/CQsVFtayUI4pCkHsC76wbo85+A1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DvPiil+0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DvPiil+0"
Message-ID: <33a19d40-e8f4-4eec-a82e-d0a1048a34a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770768507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIoP330HPaFOfWiyQhZ3ErU3F0yvlIRY7j8eKX3uIyA=;
	b=DvPiil+08NkkC07U4Mi+ejoFNcLQJP6jxGSBLJHj6uZmG6vnrt4DM8hFDjLwYKNLdlqsJg
	DNGHomZwWLWpi1cClZQfklhGwWvK7j81IU8Tt5coCh4EKsrIOa1GtknFwTMi/jlxdyMNaT
	D32/81y+/dEAdtoCHgjMe5XX9Z4IkqA=
Date: Tue, 10 Feb 2026 16:08:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Mainline BPF selftests failure due to rcu_tasks_trace and
 do_filp_open changes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
References: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
Content-Language: en-US
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/9/26 11:34 PM, Shung-Hsi Yu wrote:
> Testing with Linus' tree (4adc13ed7c28), BPF selftests in failing in the
> following cases across test_progs{,-no_alu32,-cpuv4}:
> 
> 1. map_kptr: failed to create kprobe 'rcu_tasks_trace_postgp+0x0'
> 
>    rcu_tasks_trace_postgp() no longer exists with commit c27cea4416a3
>    ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")[2]
> 
> 2. test_profiler: failed to create kretprobe 'do_filp_open+0x0'
> 
>    renamed to do_file_open() in commit 541003b576c3 ("rename
>    do_filp_open() to do_file_open()")[3]
> 

Hi Shung-Hsi,

I've just sent out a fix for test_profiler [1].

As for map_kptr, I disabled it temporarily on BPF CI.  I looked into
this a little, and the test relies on kprobing a static function,
which isn't very reliable.  Kumar has some ideas how to make the test
better, stay tuned.

[1] https://lore.kernel.org/bpf/20260210235855.215679-1-ihor.solodrai@linux.dev/

> Not familiar with when fix for these are usually done/sent. I suppose
> after 7.0-rc1?

AFAIU yes, the patches fixing this would go through -rc PRs.

> 
> 1: https://github.com/shunghsiyu/libbpf/actions/runs/21850240572/job/63055018509
> 2: https://lore.kernel.org/all/b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop/
> 3: https://lore.kernel.org/all/20260114043310.3885463-32-viro@zeniv.linux.org.uk/

