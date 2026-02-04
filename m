Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AB38551C
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245075; cv=none; b=CTAsmql+zvmMsOkFnPBMwlxLdrtfFNq+vNSDW5r1/Hu/XucD8XykYkKj76lX7kQpRcjzpaSUIGa6vWI0xJRfR4U6eLtBl49SAm/WS1AC78GEQANjO8y/yXWJBpRUzhEKFKKcnlNiF+s+8M13Q9hT9zkMotuSSWkAT0e/d0JbN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245075; c=relaxed/simple;
	bh=oRv8IAXE2m2eev4ZylxxZFrc5LS8Dd1TT9UnZ1lCPaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W31hhTLYmp0xFMpeYVfY1Va/jM8ihweAQuKchTyyS1aC8kA5ndUPMwvzR9mnRphKoeiDy4o6fKG1ygomPkUc5sdxUvGZO232qtoLc0dL7DIIpQtcYT9Tc6PjPcKx+NpUoxB6Fp7ODRN90Bm6tcBfk+G8NgChVJZjwP7Gsc3tuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mDPzL3+A; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mDPzL3+A"
Message-ID: <f08dc67a-059f-4f5c-86c1-4c51b8939b56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770245062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSUw9bwce56DZz1u0SBYzca0iWcxiBGlQ0CXcrp4AYI=;
	b=mDPzL3+A/l8YA/8AOIjYxDOpOrMvFbzLLt4BD/BscIZoPJPl8fLn7lD9vjLJ0O1y3VBBda
	kTPKWCzlXm2iLMwKgFgB2GdV8a/VLew+98xf+55kK6ORiOXPbM7cXSv0kLSLn07SdxTxxT
	7WT4SdYQEAu7HGPZMLcxCuhZVDVBKGY=
Date: Wed, 4 Feb 2026 14:44:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: Misc changes around AF_UNIX.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Network Development <netdev@vger.kernel.org>
References: <20260203213442.682838-1-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203213442.682838-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/3/26 1:30 PM, Kuniyuki Iwashima wrote:
> Patch 1 adapts sk_is_XXX() helpers in __cgroup_bpf_run_filter_sock_addr().
> Patch 2 removes an unnecessary sk_fullsock() in bpf_skc_to_unix_sock().
> 
> 
> Kuniyuki Iwashima (2):
>    bpf: Use sk_is_inet() and sk_is_unix() in
>      __cgroup_bpf_run_filter_sock_addr().
>    bpf: Don't check sk_fullsock() in bpf_skc_to_unix_sock().
> 
>   kernel/bpf/cgroup.c | 6 +-----
>   net/core/filter.c   | 2 +-

The bot is slow. The change in filter.c is small and the cycle is 
closing, so I have landed them to the bpf_next/master.

I just noticed the netdev list is not in cc, so added it here also.

