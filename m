Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF8632
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513951; cv=none; b=Zlew3ye10I8cFTSw6vhssM/NWbg9SAxnaY28RS4uFzX2/Om9zE+JEfhGjf2zTwgd65t6oIRfZokQF5ceUU0FULk/PkxRy0hMsTOw2AN2D0cztuSS4fhEF6OmJAjIfXlrvAeB0tKvZTkSXP2wcL8IIic4GXlPcSmks1elpNYtzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513951; c=relaxed/simple;
	bh=AR89T9beCgS/CzC6ae0e9mB6mKgLnyPCepyQ2hq1WSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRlXbnClSnXPEi76ZeoYYYn5GnhqS5oyZIa87lw3AeyUP4XSXmh1gzaYPw/QLlkkAUf5QaL2psxt0hDtF9XET5lQj18/wzk+nFZC9tEeCYEkNxlyS+5YFMfO8yQFdS4vgftFuZ5egV0enyxWKW62A3JbDcyTSCffm/EcYc0oE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1chaNnr; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1chaNnr"
Message-ID: <513fee2b-35cd-474e-bbe4-26a9b2b62b37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711513947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AR89T9beCgS/CzC6ae0e9mB6mKgLnyPCepyQ2hq1WSw=;
	b=a1chaNnrwKwbIDyJkA5j23ziEIQGOU6XJfPiCIQY7EESCcW95+7QcwJEBiK3M2At3FsDSI
	jo0muFNC3dd/X3TplCB+CMmytrfG/lFOPNZP9mPUQDNmNZmR7EtOUtMNfrnTuFqytGwUB5
	eA0k9sDDOKofti2a5bS81j6IxrQrr0g=
Date: Tue, 26 Mar 2024 21:32:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next v2 1/1] bpf: Mitigate latency spikes associated with
 freeing non-preallocated htab
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20240327032022.78391-1-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240327032022.78391-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/26/24 8:20 PM, Yafang Shao wrote:
> Following the recent upgrade of one of our BPF programs, we encountered
> significant latency spikes affecting other applications running on the same
> host. After thorough investigation, we identified that these spikes were
> primarily caused by the prolonged duration required to free a
> non-preallocated htab with approximately 2 million keys.
>
> Notably, our kernel configuration lacks the presence of CONFIG_PREEMPT. In
> scenarios where kernel execution extends excessively, other threads might
> be starved of CPU time, resulting in latency issues across the system. To
> mitigate this, we've adopted a proactive approach by incorporating
> cond_resched() calls within the kernel code. This ensures that during
> lengthy kernel operations, the scheduler is invoked periodically to provide
> opportunities for other threads to execute.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

