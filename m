Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC34CF462;
	Fri, 16 Oct 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177273; cv=none; b=nOj5B7mRL0526gzFtFztjv5w5jv6XnsLkEzPatjDEryiC3Prf1VBu7di7Ytb5n+meL1sekjATGtv6WGGbgo+QJUkV1IBguu2KYX3IYJiC08o7wJV9OEsCjhUJTsuzwiFmtXM7gUH4eGstAD8dNvW0sehhg4d6b0PpPqKJ2ZiOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177273; c=relaxed/simple;
	bh=y/Tka1nU8/Q78MTF3y1OR8RQ5+1zMlPLmR72fIp6atg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/2FvRyO01wUZyTukJK4MfuxC9YhvWF9PjEkREaCyp47cUbO6KKe/4T1enDc1LAfA9d4GgG2GFrQ2QbyRt6NIeH9aeNLjIfkq2FwM0KsZiNWg/2QvIZdvD0GxS9hmY0oSweyef/+zsqgJb9U2pmwbjzRlAAHKmJnUtyYqhiOnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qpZAlarf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qpZAlarf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sKQfbbu2a1i//FLpsUtsi4Xzn/bWTFUH9/zyd4KERFQ=; b=qpZAlarfALa+dQcNhp9LxR3rp6
	t1pUYvejwZupTuFnfRHWeOZBRc85nMdkAAy5IwgZ8spT23Blb2M9hhUW3xv6ugQaz4GxovAi8sRW2
	92ed5fy9f09pdIR7jUQNGWX8r6Evsybd6jvdnrlCbjJcNCwjDPYDUsuofB71UeyJwIpG43cynRHoL
	2DtD2KfFL7zUdjRuTtZD6gcKlq1OPO7HnOusvTOOkGwyVpGHw6ITT9DY4m9+x4hZo9OwHoGZmDg2M
	VcIl2PrRL58gcacP8Ufc2PSQLP2u7aCZ3E9dTH0wB4vLfIs2QXoaUo0KJ9hdkz3UiP+/mV1avMLou
	jCMrB8vg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHnAz-000OdO-00;
	Fri, 16 Oct 2026 21:01:09 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHnAx-000O4J-21;
	Fri, 16 Oct 2026 21:01:07 +0200
Message-ID: <a8f2f84e-7dc0-473d-afb1-af710d621f69@iogearbox.net>
Date: Fri, 16 Oct 2026 21:01:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/6] net: configurable extra TX headroom for local
 egress
To: Dragos Tatulea <dtatulea@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>, David Keogh <dkeogh@amazon.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 Alasdair McWilliam <alasdair@mcwilliam.dev>,
 "open list:BPF [RINGBUF]" <bpf@vger.kernel.org>
Cc: Nimrod Oren <noren@nvidia.com>, nh-open-source@amazon.com,
 linux-kernel@vger.kernel.org
References: <20261015235335.4162993-1-dkeogh@amazon.com>
 <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org>
 <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 10/16/26 8:48 PM, Dragos Tatulea wrote:
> On 16.10.26 10:02, David Woodhouse wrote:
>> On Thu, 2026-10-15 at 23:53 +0000, David Keogh wrote:
>>>
>>> Measurements (net-next at commit 05b5019b0, veth, 500000 UDP datagrams, a
>>> 20-byte ip-in-ip push attached at TC egress, only tx_extra_headroom varied):
>>>
>>>    tx_extra_headroom   pskb_expand_head reallocs / 500k
>>>    0 (off)             500003   (~1 per packet)
>>>    64                  4        (background)
>>>    128                 2        (background)
>>
>> I remember frowning at this years ago, in the context of PPPoE.
>>
>> I have the same question I had back then: why, if *every* packet ends
>> up having to call pskb_expand_head() because it didn't have enough
>> headroom, does our kernel need to be *told* by userspace that it needs
>> to expand the allocations?
>>
>> We gained dev->needed_headroom and ip_tunnel_adj_headroom() since then,
>> and the kernel doesn't actually need to be told.
>>
>> You explained why you don't want to use dev->needed_headroom; I don't
>> have much of an opinion on that front. But if you do want to introduce
>> a new tx_extra_headroom, could we try really hard to have it auto-
>> tuning?
> For TC-BPF I suppose only the BPF program knows how much extra
> headroom is needed.
> 
> Maybe this tx_extra_headroom could be declared as a BTF decl tag
> in the program. If this is the only usecase there's no need for a
> rtnetlink uAPI.
Fwiw, there was some work in this area here in the past ...

   - b9ed315d3c4c ("netkit: Allow for configuring needed_{head,tail}room")
   - b73b8146d7ff ("rtnetlink: add needed_{head,tail}room attributes")

... which we've integrated into Cilium which orchestrates the K8s
Pods + BPF progs, so it can calc needed headroom for the Pod's netdev
based on the config/needs in the hostns (e.g. tunneling).

Cheers,
Daniel
