Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE1285C9D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084589; cv=none; b=dUsHXpxNNsuotqNGeMjefFObz5eWi4oj0cWpzvW4u0yzop0PFSpPjCCoBuHfLt6Qcxq/1jkq3kLx+DL5IB4GGZSRO2GuRfC0LuTaiHe8BgSP5T1EV6jodFL5a3tTZYXvPXgodxxmcZmfeyTVNz79zWugDHSYj8mlMGsKKU4stAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084589; c=relaxed/simple;
	bh=6/2onErcooePOiOE7CEJaZC2/IrTBptbmixftJVcsTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKhGJvUWUC/Xr83ES7AqnU1uYmmcgPZMaA2D5uKQmxsSVxJyeWe9KDpXM435wFUBMn7kO3OHRQUOw7ftlRElywMFqq+WCcGw9QyrQ9mpg/54TvhrwcPPEEhWH6/e7kwyZhybfAX/Q6dhiAe5SusUDbW8lBL2K43rgdyuuxsq/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bIvrQvcl; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bIvrQvcl"
Message-ID: <42d449a1-a67e-4ebb-bf89-272072ade681@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773084586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLZ3rZ1nBafkxSG74iDxaRzJlfo2vRV/ytjdSWJSrTQ=;
	b=bIvrQvclCXg8jrDnSAALX/qMfzbYmqqMh59lfEuRLWGqPtnCFFcbHkCTj/10TTJDFq4cYW
	1ghQ5mW2PJT25Jshi2NkM1lsNSRvEeJQ9jUk8qfc1jTC4y73o7jTIP2DklWB73twjDpzyS
	1uDxKIbqCshSvtcbT17vqgdTSNi0YnM=
Date: Mon, 9 Mar 2026 12:29:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/4] bpf: Introduce bpf_netpoll
To: Mahe Tardy <mahe.tardy@gmail.com>, song@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com
References: <20260309131635.302424-1-mahe.tardy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260309131635.302424-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/9/26 6:16 AM, Mahe Tardy wrote:
> This patch series introduces bpf_netpoll, a set of BPF kfuncs that allow
> BPF programs to send UDP packets via the netpoll infrastructure. This
> provides a mechanism for BPF programs (e.g., LSM hooks) to emit
> telemetry over UDP without depending on the regular networking stack.
> 
> For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
> and again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
> during his presentation of BpfJailer[^2].
> 
> The main use case is to be able to completely dispense with
> agents/daemons for BPF programs after startup. In the case of
> Isovalent's Tetragon, the idea would be to be able to emit security
> alerts or export data from BPF even when the agent is down. For meta,
> according to Liam presentation[^2], this could replace logging via
> ringbuffers which created cross-binary versioning issues.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration), for example used by the network bpf_crypto kfuncs.
> 
> Further patches would extend the bpf_netpoll_send kfunc to more program
> types. Note that network program types should not encounter recursion
> issues as netpoll bypasses the network stack and sends directly to the
> driver.

netpoll may be an easy replacement for bpf_ringbuf_output, which can be 
used in different running contexts. If it is to replace the user space 
daemon in production, it loses too many things from the networking 
stack: routing, tc, etc. It could escape the current tc/tracing bpf 
prog, monitoring, QoS marking, qdisc, etc. There is still the encryption 
piece as well.
