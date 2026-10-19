Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2848B361;
	Mon, 19 Oct 2026 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397606; cv=none; b=XhUTZkU5QQFDQtFjNwFecjCbmR1+XYYDy6pDe987CNlZp+M6wqp2dQt6RJwHZL94fFLGwnTibey1vpNIET0D3+4x5CvdOilzj+qXhZpk6eXo1D2WzgRyhWBygW8v/7Almd6DNDRzpED+ILJXuqD04dpc8Gd8C5/fHnSCMj1YYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397606; c=relaxed/simple;
	bh=gIzpGRWvqLbb9ph/eyqYU4OFDwD7mz3LFO7FNrfcvEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXFlAi/DVYJgupxwX1aIPrPM0hB4UjD9YqviHrqhK+8Y4YsgW+fDYTbaeOUc58KEp7CR/RRyBjVDU/ySpa2x3AwpHHLkGnELkufNM7qnyyCigJix4idoUTljYHtmJ66oVS8RMme2gcGvjQqZCir/1k2cgzYcG0ivEGDqurS57IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gJqSdIkR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gJqSdIkR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lLWon7BvSMKLgYPE8Op8ElmpAlPeSBZB0KgNvJox+3k=; b=gJqSdIkRlBB3ejPbFX/YFVWV7b
	xfYjsua7p1q5+gvfKXs6oofQG3+9kyV0hhDaIJ3KLMasSXGk+El4slRevwRDpJPNDpBY5exjOeJFQ
	1GE+o2Rx6a2XdcX5cU9KBnIMm9meDRk27QJ76RKsWFAXjeI2/qztEQwU/qQKL/w1dHu3qMSoAOD+m
	+srsvZDHQffLmDv5SrDgStw/FPkus/YEoEmuIVcNIoDirlAVyAE/N6FvAo4L2RdzSv9GNkMb8ixlF
	/HdUApI0MU1n74GF4CtZ//SfgD0wNgYIN38r56AvMpTU5OogeK+hKItVgg0O93LJc9m5PWnLFCr+Z
	xnVO00+w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIiUj-0003Va-2B;
	Mon, 19 Oct 2026 10:13:21 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIiUi-000561-39;
	Mon, 19 Oct 2026 10:13:20 +0200
Message-ID: <5dd53087-2f6a-4f29-b3c7-5d5bbd374519@iogearbox.net>
Date: Mon, 19 Oct 2026 10:13:20 +0200
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
 <f875feab-1f3d-002f-6b9b-52c375753bcd@loongson.cn>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <f875feab-1f3d-002f-6b9b-52c375753bcd@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28158/Mon Oct 19 08:26:01 2026)

On 10/19/26 9:49 AM, Tiezhu Yang wrote:
> On 2026/10/19 下午3:18, Tiezhu Yang wrote:
>> On 2026/10/19 下午2:47, Daniel Borkmann wrote:
>>> On 10/19/26 6:01 AM, Tiezhu Yang wrote:
>>>> Normalize two inline assembly test descriptions in jit_insns_arena.c
>>>> from space-separated strings to snake_case.
>>>>
>>>> It is done for consistency with other neighboring subtests registered
>>>> in test_jit_insns() (such as alu_imm, alu_reg, etc.). This also makes
>>>> it convenient to execute these subtests directly from the command line
>>>> without being forced to use shell quoting.
>>>>
>>>> Otherwise, unquoted shell word-splitting causes test_progs to reject
>>>> the extra arguments before the filter code runs:
>>>>
>>>> $ sudo ./test_progs -t jit_insns/arena access with zero offset
>>>> Usage: test_progs [OPTION...]
>>>> Try `test_progs --help' or `test_progs --usage' for more information.
>>>>
>>>> $ sudo ./test_progs -t jit_insns/cast to a user address
>>>> Usage: test_progs [OPTION...]
>>>> Try `test_progs --help' or `test_progs --usage' for more information.
>>>>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> Do these not work already?
>>>
>>>    ./test_progs -t jit_insns/arena_zero_off
>>>    ./test_progs -t jit_insns/cast_to_user
>>
>> Yes, they work.
>>
>> I misunderstood that the name is "cast to a user address" in the output
>> rather than "cast_to_user" before, there is difference between the
>> description and the name.
>>
>> Something like this:
>>
>> $ sudo ./test_progs -t jit_insns/cast_to_user
>> #191/2   jit_insns/cast to a user address:OK
>> #191     jit_insns:OK
>> #192     jit_insns_blinded:OK
>> Summary: 2/1 PASSED, 0 SKIPPED, 0/0 FAILED
>>
>> Anyway, if this patch is not necessary, please ignore it.
> 
> By the way, IMO, it is better to remove the __description strings,
> so that the test output style matches the actual program names like
> other neighboring subtests. This prevents developers from being
> misled into copying space-separated strings from the standard output.
> 
> What do you think about something like this?
That's cleaner to just remove, lets go with that. In the meantime I've
tossed the old commit from bpf-next, so please send a v3.
