Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675457;
	b=1tzCgZf7HvzNu82DY0/Kwl+2OhGEY5IfwFbNK+whPWt/LuHkO/eT6p5AqAnrL0uedVr4
	 5JlujlazWxDhfaYtF8HPK4PzRaM8ajEHo+C6xPHAnmomu3jgYdsUgszPv4u8qFdTFkuPX
	 UOjuKcyNJau8Um7qvxdVjbZ32m0/W6jqIFyVEozhkcRSzr5WJW2x0QA1z1PBVH8a4qPM5
	 tcyio3iKQXGy5pCHlG8mox5dXVQgv6PG1z/loOhtybtzf2veTnGxG/OJbvdGLxIgsQCzn
	 7++0IkaA4vdrAiOa50qTa3HX8Td1ct43wLHRkEny7A8joiJLMnisZHYxDZed9usR/NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675457;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=UG5dM8wTz0phXeS2KwK++HpacRT4Qh9JbKBkugWMdEQ=;
	b=JwIRpIjDwDz29BtuzC0u0jUGgwKAwoyMF93pv7DM/kgMoDrQXaAs+L2WRzlAQBWTogF9
	 grJTDkxLehzuDva1p9+bZr/5wd29Z0VQEpF6iswvG+ok1FdgE90fdKqea2t0NN2orHtdu
	 yPqmstvRjJBv8clOiz3ftURQl/F71uIz9AeTwsacFQJxaoEasn3kskZoUUt/zf0+ty5Kj
	 w/owtjYYQphLZWNsH916s22iOCyxZc2ZORgZGfNlODbLia64i2iofuGIabboyt8BTuZlz
	 9JtEg8K+Ngy/eKUcu5PtZbdCeqPgZdpM30yeSGF6p3j4D+l/ekOkb/DmItr4jX4DNJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=CdrYRwh4;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4B606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 13:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B4B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=CdrYRwh4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UG5dM8wTz0phXeS2KwK++HpacRT4Qh9JbKBkugWMdEQ=; b=CdrYRwh4kRwP03eHt/9Fw/hYq8
	GFQzbGRRvjqduIM/MwuwX4owFlgLeVYXIFlhTzuhdkCEwxLBn+WvDSmwXIg4LJom5qw6ZxyRlL+Wm
	SYzjVjZRU8ZvNJfXzD0KCiNv88/WNa5OaT7cUG3eB6P05TwkF/EFQysQ/m4X9s/ebwaSW6ZIAhwFD
	ycrXtSuAT0FbgxrRir1x4Swft9yLp2gLxmce5f4O9WWN0HNuhruBKgX48GYib4p/jdY2RZnADYhWx
	HW092iYxWLCx+6FVjlew/+lQrEp8U86XdFqvJuSpEji9ou5RCseP3pYRUcuJXDWKufBNkytt8pkE+
	Quqzzpqw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJsm8-0003qC-2D;
	Thu, 22 Oct 2026 15:24:08 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJsm7-000Q02-2I;
	Thu, 22 Oct 2026 15:24:07 +0200
Message-ID: <3e02a21a-1e38-4010-a034-594ee164c84c@iogearbox.net>
Date: Thu, 22 Oct 2026 15:24:07 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test JIT jumps which
 change at a repeated image length
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
 <6896375813cf93e6e3c7ae7a8f329d9fa73568dadcb55b7ab364e5c18ce817c3@mail.kernel.org>
 <2de8122f-45de-42b1-b070-acf60ffe7c96@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <2de8122f-45de-42b1-b070-acf60ffe7c96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28161/Thu Oct 22 08:24:11 2026)

On 10/22/26 3:05 PM, Mykyta Yatsenko wrote:
> On 10/22/26 1:44 PM, bot+bpf-ci@kernel.org wrote:
>>> selftests/bpf: Test JIT jumps which change at a repeated image length
>>
>> TL;DR: Test issue: the new jit_insns subtest asserts the program was JITed, so
>> it may fail instead of skipping when no JIT is available (JIT disabled or
>> unsupported architecture); suggests gating on is_jit_enabled().
>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
>>> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
>>
>> [ ... ]
>>
>>> @@ -2881,6 +2881,63 @@ static void test_convergence(void)
>>>   	}
>>>   }
>>>
>>> +/*
>>> + * On x86-64 a backward jump sized from its own previous-pass address grew
>>> + * here while others shrank, so two passes gave the same image length with
>>> + * jumps still changing. The fillers are 7 and 2 bytes of native code, the
>>> + * conditional jumps are never taken.
>>> + */
>>> +static void test_same_len_not_converged(void)
>>> +{
>>
>> [ ... ]
>>
>>> +	int fd;
>>> +
>>> +	fd = load_prog(insns, ARRAY_SIZE(insns), "same len not converged");
>>> +	if (fd < 0)
>>> +		return;
>>> +	ASSERT_GT(jited_len(fd), 0, "same len not converged jited");
>>
>> This isn't a bug, but should this assertion be skipped when no JIT is
>> available?
> 
> We should probably skip this entire test file if JIT is off. Out of scope
> of this change though.
Agree, out of scope in here.
