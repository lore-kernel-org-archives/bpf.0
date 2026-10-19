Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF161485955;
	Mon, 19 Oct 2026 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395842; cv=none; b=kkVyQQK6XAt0OAcM8pAI7AKwtIQrjWx0rfYM1pq9f7wQFXHS3UlxnYjU2bHW0ejeGkY1a1vNCTRMBfInrnydjFG+VuiUbhhe6n6rFARCXtE6oPLMVVRPbPvbcrpIzZf7frfvehXcSBzbWIDd8rCsCuli1hfkHO7h/4FsPL8WZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395842; c=relaxed/simple;
	bh=Qrl/30TvAG5g/rCWfCPBCBTPrIC/Mw5YnYWOrzImG/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZuFrSKOY9koBmhjud9yuBj62k0V8g2SsuR8PveAYB+gWpxT7x97z4E6m/99u3gz+3WRndVaB07k5QkpO81a7nZMtziTcO6cti2UbQ+BnCw6OFcg0HWYcoMOsYRSHMQcyInG+wYDDGxEE/YKrEJ6aCvQwPdmtxyIgiTnBXDIGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Q6n6aQo4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Q6n6aQo4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fON541dSDMWUmSBQmdQzELWqCAGta3A/OGm0i3HJqVs=; b=Q6n6aQo4xWhztLxC+djcGN1AjP
	+W7MyfkMRkd/wC2lrsEmiXxKgsAxAegL87P5oY9/VS7LqdgxwswGyL+tuvlgfMZgvN8KSu4je9G3k
	UeHsqM9AruD7dVlOQcuXWLvK6wxIUR8eMOtpdAMNIoVUc1gxhLbVVFazHJhM1lY16uNHLjQ5kOd+E
	8BuTRyIwbgpt+WRFzARjdzzVYxL56K44QnivpW6FGDIob3puuOEZsGSxAn1R1HiNICC6c2ha1S1qv
	YRaXV/mnKiwhyYr2+AA5CcXMoUR5/9euMbsmB5XjmmDAEjQryy2bor6yZF8nEJMFcQq2fk3HTRruk
	OOAUEewA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIi2G-000N7L-1I;
	Mon, 19 Oct 2026 09:43:56 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIi2F-000HtG-28;
	Mon, 19 Oct 2026 09:43:55 +0200
Message-ID: <910eee7f-cf91-4d52-b465-ec0b7c63a2db@iogearbox.net>
Date: Mon, 19 Oct 2026 09:43:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Use snake_case for subtest
 descriptions in jit_insns_arena.c
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019040106.27309-1-yangtiezhu@loongson.cn>
 <d13c66a3-0519-48c1-88fe-55bc755b79a2@iogearbox.net>
 <84434f7a-1c38-03ea-3062-8e8cf364fd4e@loongson.cn>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <84434f7a-1c38-03ea-3062-8e8cf364fd4e@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28158/Mon Oct 19 08:26:01 2026)

On 10/19/26 9:18 AM, Tiezhu Yang wrote:
> On 2026/10/19 下午2:47, Daniel Borkmann wrote:
>> On 10/19/26 6:01 AM, Tiezhu Yang wrote:
>>> Normalize two inline assembly test descriptions in jit_insns_arena.c
>>> from space-separated strings to snake_case.
>>>
>>> It is done for consistency with other neighboring subtests registered
>>> in test_jit_insns() (such as alu_imm, alu_reg, etc.). This also makes
>>> it convenient to execute these subtests directly from the command line
>>> without being forced to use shell quoting.
>>>
>>> Otherwise, unquoted shell word-splitting causes test_progs to reject
>>> the extra arguments before the filter code runs:
>>>
>>> $ sudo ./test_progs -t jit_insns/arena access with zero offset
>>> Usage: test_progs [OPTION...]
>>> Try `test_progs --help' or `test_progs --usage' for more information.
>>>
>>> $ sudo ./test_progs -t jit_insns/cast to a user address
>>> Usage: test_progs [OPTION...]
>>> Try `test_progs --help' or `test_progs --usage' for more information.
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> Do these not work already?
>>
>>    ./test_progs -t jit_insns/arena_zero_off
>>    ./test_progs -t jit_insns/cast_to_user
> 
> Yes, they work.
> 
> I misunderstood that the name is "cast to a user address" in the output
> rather than "cast_to_user" before, there is difference between the
> description and the name.
> 
> Something like this:
> 
> $ sudo ./test_progs -t jit_insns/cast_to_user
> #191/2   jit_insns/cast to a user address:OK
> #191     jit_insns:OK
> #192     jit_insns_blinded:OK
> Summary: 2/1 PASSED, 0 SKIPPED, 0/0 FAILED

That makes a lot more sense as reasoning. I've applied the patch to bpf-next
and also adapted the commit message accordingly. Thanks!
