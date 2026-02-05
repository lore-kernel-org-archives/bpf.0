Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475672C3255
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770335448; cv=none; b=XVZOmoHG+lhTpKd5pqixtJkE2zb3M5hLx4GvjZLJ2J4QqLZ5SnYhEIrXTWMZwy8nLVSaEtbL0AMUd7lOFYzEhRsT+ZNrFszWhmrz+IfHjlqEjN1X1wV2GG0H0Mq4DVCUv99CGE5EU9SPdtRcFmhJT4EpbPGV1JpeqUe3731fcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770335448; c=relaxed/simple;
	bh=CNNRNQ4GNN2fH+YWzjAuYxu77VTUmDj768qNAiZZpgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAOvzIPe7zCanhNcT9lasOaLkU52VNxejvZyUUB56LPT2NyVbNCJw/9yv/87aKYyc72sYN/ULDKKrXQTkG+xOr1CIVKmCSmvfVZRWahW6PqBPvcB42brgd/EFTu24HL5GVzQ0x+/Fb0F5l5c3+fkPOTSCnt0i8Gx/QUuvp4dtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cvsd7R4t; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cvsd7R4t"
Message-ID: <019b0f02-d177-457f-89e2-96727ee48cff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770335445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y25yw26X0uLgNUX3PLur9FBnw2AOsyUH4p7znwi6P+g=;
	b=cvsd7R4tr/WS9B8q8Dbu/vPpNcKjxLItB1KG/gaXYakNirFQKFmNueqsB5nSR1VtpYbp+c
	BPM8URfEOFCcigD0o6f/THQuyrWPSbynJem4Ymn+jlzL27yGj8rko1yokLOm8ZeV8jQnBH
	OtiHGinWVUT96ne9YQQWIlhbphuz2i0=
Date: Thu, 5 Feb 2026 15:50:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BPF CI] OOMs on s390x runners
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <8553c4ab-9b42-46a8-9187-38ba4f63fff0@linux.dev>
 <62cab7f1-06ea-434b-99e5-ba8b1a7d7eb5@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <62cab7f1-06ea-434b-99e5-ba8b1a7d7eb5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/21/26 2:56 PM, Ilya Leoshkevich wrote:
> 
> On 1/20/26 18:59, Ihor Solodrai wrote:
>> Hi Ilya,
>>
>> The BPF selftests regularly fail on s390x runners with OOMs.
>>
>> The s390x hosts that I've been maintaining have 16G of memory, hosting
>> 2 runners each. VMs (qemu instances) running the tests currently get
>> 5G of memory each.
>>
>> I noticed that the s390x runners didn't have swap set up, so I added
>> an ansible config to set up a swapfile. This seems to have helped with
>> OOM failures.
>>
>> https://github.com/libbpf/ci/commit/8767dc05ab84c88da198af3c651511e731ddbac7
>>
>> I spot checked a couple of recent failures, and all of them happened
>> on the "ebpf1-worker-*" runners that you've been maintaining IIRC.
>> Here is a couple of examples:
>>    - https://github.com/kernel-patches/bpf/actions/runs/21178791628/job/60916006746
>>    - https://github.com/kernel-patches/bpf/actions/runs/21163448380/job/60863171062
>>    - https://github.com/kernel-patches/bpf/actions/runs/21157785072/job/60846570064
>>
>> Could you please re-provision the hosts with the swap setup?
>> Let's see if that helps.
>>
>> Thanks!
> 
> Hi Ihor,
> 
> 
> Thanks for the scripts!
> 
> I reprovisioned all 5 builders, everything looks healthy.
> 
> I will check on them again tomorrow morning.

Hi Ilya.

We ended up disabling KASAN for s390x and that helped with OOMs.

I noticed a couple "no space left on device" errors on your runners
today, could you please take a look? Example:

https://github.com/kernel-patches/bpf/actions/runs/21732338737/job/62690585484

Thanks!

> 
> 
> Best regards,
> 
> Ilya
> 

