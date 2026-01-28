Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4FE25742F
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626429; cv=none; b=HwjWYDMpOLPb30BsF4YrfpY4Sx12CJmn7TyNlSF6yOvZM4aOfbRHqiOJo5v48rZrxIYr5MFyPV4fwxTANgvLGl86Nmv6YGFEsT1eBd8bdpLFFLP4eYjFzag8jHSmGyHGv+wDRi+y9gC//zgkZZyUX9q27Abx/+xZHDX4Zu6hNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626429; c=relaxed/simple;
	bh=TgeaP33jHnx3T+ks7p1hcLs6YqV+hkkXYsSw5Il6dWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=upOfcqd/TIyMTwaGr8qFu0nFLFP1bJa7H/PHeO15AKGcaxGAV7BAUuikt0udx+pwQAC7EWnyZfAaLCjbuhEj1k3NKa0V8RWpCo3EdSg2eGBKtq/r4Dz9WERiQJDZBzOwdTDqrl2CD6WXNqTSeMkq/TWv0GrMKHzkyVIliKEBt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AiR8drud; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AiR8drud"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769626426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJruoHUytnpG3ZhxXfZjCqC5GgpnkyryTXuXTZBPFBA=;
	b=AiR8drudioF/zHusMvMimGJ7lmtE6yo06ti5MBR8zPKeMC3E7W8qGAFrzChckidE7V+tcX
	fq06RMNyFUHzisbB8KCXW3j0bOPXDIhjTmGSs239vRQM4q9MmPdro008x7tfr5OyRGNVDa
	mXxOKqWlSgBItKfxXfuohXWj1nkv5KI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Matt
 Bobrowski <mattbobrowski@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
In-Reply-To: <aXnwzpeaggySKRzd@tiehlicka> (Michal Hocko's message of "Wed, 28
	Jan 2026 12:19:42 +0100")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-8-roman.gushchin@linux.dev>
	<aXnwzpeaggySKRzd@tiehlicka>
Date: Wed, 28 Jan 2026 10:53:20 -0800
Message-ID: <871pj91sdb.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> Once additional point I forgot to mention previously
>
> On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
>> @@ -1168,6 +1180,13 @@ bool out_of_memory(struct oom_control *oc)
>>  		return true;
>>  	}
>>  
>> +	/*
>> +	 * Let bpf handle the OOM first. If it was able to free up some memory,
>> +	 * bail out. Otherwise fall back to the kernel OOM killer.
>> +	 */
>> +	if (bpf_handle_oom(oc))
>> +		return true;
>> +
>>  	select_bad_process(oc);
>>  	/* Found nothing?!?! */
>>  	if (!oc->chosen) {
>
> Should this check for is_sysrq_oom and always use the in kernel OOM
> handling for Sysrq triggered ooms as a failsafe measure?

Yep, good point. Will implement in v4.

Thanks!
