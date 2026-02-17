Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F34280A5A
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370815; cv=none; b=POvz/tz5gThx1Xzuy4mgRpuvSOAMVzsW03vgssfuRyDZESnalhFUDVcEM8LWJjbSz2TpK5sU472H7Kl3LYg1p9rQqwymdRImr7COVtOzrZjSmrqkOHA2dKXv26s11G82KLcxAs12XuUuKqYyo1GNlaHEq9YrrU7q4tJbsHDFeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370815; c=relaxed/simple;
	bh=j/RworCfYk3woL5j7jSZnA+8/H6/CtqlnalefOGhQ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN7wli/175nygjMXpDUb9QIkFyEpGWxhp/ei/vWpY/U3u0Mw66THakIi5hp7cyO1VxgQozEt1QXhb81wfsdgmNUKNBszVob547e0ButFU1iQ4Y+J4RO5+GGb94DBrlm0PShGb7fWQzf3bjl6Vvnz5crHZMc6oVNdeZg/8V94A4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvUgKJjp; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dvUgKJjp"
Message-ID: <1bc24867-edde-408e-ac1b-2ca2a41622b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771370801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izRud62R72/Q2Ixi4S6gHYCThWIGKo49JaBchMF76Ec=;
	b=dvUgKJjppqqboXgBoZKaB4cz2Esw42wpPBtkPU6knhjUY3Ytr5JrgAkXRmkCmGDPJvglJb
	eqEu9t+/BQCH2FCdPQAPF4IqKb+K3biw+N26A4IzBVv4lh3FgpQiQ6teOYmTe7qVJ6gPXR
	tdFSB1BpLVg+pypxTGQYPEAJlLTq3WQ=
Date: Tue, 17 Feb 2026 15:26:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
To: Jakub Kicinski <kuba@kernel.org>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <249d6576-2259-4785-87b6-619052b4ce75@linux.dev>
 <20260211075240.70095-1-yangfeng59949@163.com>
 <6528c028-1224-4737-b902-e631641ddb37@linux.dev>
 <20260217140831.52fac4ca@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260217140831.52fac4ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/17/26 2:08 PM, Jakub Kicinski wrote:
> On Tue, 17 Feb 2026 10:08:29 -0800 Martin KaFai Lau wrote:
>>> The reason for the CI test failure.
>>
>> Make sense, but the early point stays the same: the user-provided skb
>> can have unexpected data. Either an skb->protocol is not handled here,
>> or the earlier dst lookup has an error. I don't know what the current
>> active users left in lwt are. Unless there is an issue with missing
>> skb_dst() in other mainstream program types (e.g., tc), I would prefer
>> to add a check in bpf_lwt_push_ip_encap() instead of complicating
>> bpf_prog_test_run_skb() further.
> 
> Can bpf_prog_test_run_skb() simply not support LWT then?

It is a bold move. If we are open to this idea, we can consider to 
retire the lwt support completely instead of only retiring lwt in the 
test_run_skb alone. I think it will still take time to announce and 
deprecate it?

> Having fastpath checks for test harness really feels like duct tape

Adding route lookup on ip[v6]_hdr does not work well either and is a 
larger duct tape on the test_run_skb side.

An option is to always set skb to 'some' dst (loopback or 
ipv6.fib6_null_entry) on all is_lwt cases without doing the lookup. It 
is only to get it going. It is a duct tape also imo but maybe a middle 
ground.
