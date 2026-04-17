Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277F355F25;
	Fri, 17 Apr 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425098; cv=none; b=YT0SuRjYABBmIgrUNn5xRpdeMfGxnCMLYeOKqhS3Lfvi1Bpp5kqPb9jMo0Vp4DMV2AQwKl5oaBo52MkigBynnSuJdw1BYW6+UFcQQHEqhaTOgSqjqhvCo9WHN8HKaueQN8qK+hwRba6OtK0SeFl2DSlQgolb8oV8T3XihIwFFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425098; c=relaxed/simple;
	bh=qIHzrIjAG7eZMmBid1ybL5n8DAh+tyTX3zK1k+xZ5fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyNPgQUo1BixkiF9UjGh4oMMv3I2taDcB9nNgr5A0EOT+5yp+WTteNVPZrwLcqlN2pjwUOdof+kbeq8vwiPZmGEQcMiMqeAYtk64199NBT7kD4Tg3iRl0AuPLb5vxkpuarQWGc1BCqSyrDUndS4s5MljaKnJoq/u95PIYSZqRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RYTGQy11; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RYTGQy11"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/l/+ed3RRp2/S+303s10M691ayGdGFJnBkltqUFJEhs=; b=RYTGQy11fwIdGrnW/s6GTbhsGA
	2/BO/hf8V9glLTZsUBGYANcW7rx6jGs4Cg0asOz96wgQ2ylH6iI1+XS7egQU7bDAdFg/Dqp+zcD8S
	v35+yJGIg9wa1rrBs9MAUn6nyOoKrWAe33bnjlG9PVfWUflORkgxMdlmCixkP7pPuTquIpHz6N1Li
	drPC+9Sd+BjMQMAK26OK+2amxaoJ3D3vgGdSx3dZwUjy+FOmtldu+f4SSi/UAzhzzwUT/kVUkJgeT
	4odj9XfYQWaTBFcna6FCU4Scuni1GG9+G35QnwcEo/LTh/JtWHa8RoRuUJbVaTMK/k7WhujtH6V3L
	8pTWihOg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDhJe-000P7F-0u;
	Fri, 17 Apr 2026 13:24:54 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDhJe-0000V9-1C;
	Fri, 17 Apr 2026 13:24:53 +0200
Message-ID: <8a34a3da-45c3-4968-9c51-0ecb865d8f9f@iogearbox.net>
Date: Fri, 17 Apr 2026 13:24:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XDP BPF JIT memory leak on armv7
To: Puranjay Mohan <puranjay12@gmail.com>, Jonas Rebmann <jre@pengutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Russell King
 <linux@armlinux.org.uk>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de>
 <96a56535-6016-402e-ad25-237427c2caaf@iogearbox.net>
 <CANk7y0h8F2rhosKzHuf7eewuwCofjNLut0pQ=v-gehHdMcT0Bw@mail.gmail.com>
 <afb5bbb7-3ad7-4632-9909-4c003f8ea44a@pengutronix.de>
 <CANk7y0h42MFVGpTwNxGPRnUbW6r7uB8EqWR-PGWAd7UJVLqSOw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CANk7y0h42MFVGpTwNxGPRnUbW6r7uB8EqWR-PGWAd7UJVLqSOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27974/Fri Apr 17 08:24:08 2026)

On 4/17/26 11:56 AM, Puranjay Mohan wrote:
>> On 2026-04-16 16:36, Daniel Borkmann wrote:
>>> I don't have access to arm32, but it looks like its completely missing the
>>> ability to do BPF to BPF calls.. you would need something like the below
>>> (uncompiled / untested).
>>
>> Applying your Patch to latest master leads to a paging error [1] and
>> segmentation fault in xdp_program__attach when I run
>> ./xdp_pass_user -d lo
>>
>>> I think the problem is that BPF to BPF calls are not supported but the
>>> JIT doesn't reject them as well, so the best way to fix this would be
>>> to do:
>>>
>>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>>> index deeb8f292454..91fef10e88bc 100644
>>> --- a/arch/arm/net/bpf_jit_32.c
>>> +++ b/arch/arm/net/bpf_jit_32.c
>>> @@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn
>>> *insn, struct jit_ctx *ctx)
>>>           /* function call */
>>>           case BPF_JMP | BPF_CALL:
>>>           {
>>> +               if (insn->src_reg == BPF_PSEUDO_CALL)
>>> +                       goto notyet;
>>>                   const s8 *r0 = bpf2a32[BPF_REG_0];
>>>                   const s8 *r1 = bpf2a32[BPF_REG_1];
>>>                   const s8 *r2 = bpf2a32[BPF_REG_2];
>>>
>>> This will cause the memory to be freed properly.
>>
>> This works for me and resolves the issue.
>>
>> Tested-by: Jonas Rebmann <jre@pengutronix.de>
> 
> Thanks for testing, let me send the patch to the list.

Sounds good, I think it might also be worth to check the other
JITs which are not mainstream to see if they have the extra
pass and if not then adding similar not-yet bailout to them.

Cheers,
Daniel
