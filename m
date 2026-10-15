Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5765563FA7
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091515; cv=none; b=hyHkkXU9M9pFPOhKz6fliK9fkag1lLpGZapjWU4RF1ojmHfBnRERS5qoN8rMfvj8JzEMtpzU05Z02bavWkdFlu07kpPMnxtqu3kOyMNY4ZbOR4mqZHl519awBSvLhI84F6PJrqMAcQYNPslpLkGYf9GcLtvlrF8Mv1UqynkSV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091515; c=relaxed/simple;
	bh=xzee/0yqAEm/WEjVAETytUom5KRsTMwxZgN+OtU9wGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyr9pG5W+nRk/Z6tE3tQho69lXosea0id1LORcBgWJ8LC7FJ1VIN8Upa+8aj2pFzKbz+L3GMEHBUNbbfJx7oTau9U1AHHte2xVzrQZ1m8PFv3FLjfrDQWu64UcDBWjaEZEDAt1lMcWCo2YeBPegsyV9yemh+qFuFxwMja+tQoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jdBA3xUI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jdBA3xUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lw8JhJHISve9WdBceHdXlgC5H7WMWvJ4PuRWcnJHOzs=; b=jdBA3xUIpTmkiUDZ8oKdsIvbX9
	fUb6bSEzG2shEFjdTE4vEdyJIAqKJwJGTZjlIDWf4IxwmyaPCnFjKt+jTiZXK3u6aqVE6WHHtpBNs
	1ggAErjibn59FdOXAJVOMPtY8fgqLMukB7zi5qKcq1oN3qAiiFu+hPG4X4mqBBxI3XQMAQoAYM6QN
	PObZsGEjy+TAcbC7b9t3KcULKJ1bam/SLLYjoNpg/Y2Kp/nQmJ3kc6eqaOOqKi9LSBbP3YMD/dCDr
	qvsX26BlIct8iIsWxSooyrckoTX5p1FrcMTuFwStU4M3akF0fvM+tkU7mWBVONfTUYc8fhr/2Mivz
	RohVYmfA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHQrk-0004Oi-2N;
	Thu, 15 Oct 2026 21:11:48 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHQrk-0006rM-17;
	Thu, 15 Oct 2026 21:11:48 +0200
Message-ID: <fad8ce87-cb3c-4774-9194-e767587236f3@iogearbox.net>
Date: Thu, 15 Oct 2026 21:11:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add JIT cBPF-related
 instruction tests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, memxor@gmail.com
Cc: bpf@vger.kernel.org
References: <20261015171917.599025-1-daniel@iogearbox.net>
 <20261015171917.599025-2-daniel@iogearbox.net>
 <DM5NCJVIY5GR.3KH59CI540I82@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <DM5NCJVIY5GR.3KH59CI540I82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28154/Thu Oct 15 08:24:22 2026)

On 10/15/26 9:08 PM, Alexei Starovoitov wrote:
> On Thu Oct 15, 2026 at 5:19 PM UTC, Daniel Borkmann wrote:
>> The classic BPF cases of the removed test_bpf module ran their programs
>> on a hand-built skb. Run them as socket filters instead via jit_insns_cbpf
>> test suite. This covers all previous test_bpf cases as well as a few corner
>> cases beyond that.
>>
>>    # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t jit_insns_cbpf
>>    [...]
>>    #193/1   jit_insns_cbpf/classic:OK
>>    #193/2   jit_insns_cbpf/checker:OK
>>    #193/3   jit_insns_cbpf/frags:OK
>>    #193/4   jit_insns_cbpf/packets:OK
>>    #193/5   jit_insns_cbpf/blinded:OK
>>    #193     jit_insns_cbpf:OK
>>    Summary: 1/5 PASSED, 0 SKIPPED, 0/0 FAILED
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[...]
> 
> I don't like it. It just copies old test_lib.ko into test_progs.
> 
> I'd prefer to keep cbpf untested. It's not like anyone is working on it.

Ack, that's fair, its not actively worked on anymore anyway.

Thanks,
Daniel
