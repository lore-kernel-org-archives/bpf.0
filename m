Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74C248873
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209298; cv=none; b=Lxk3oqFyFOycuNodHR8vTjADmnQsJb7SoQaJNc32JdbQ+HVZ+cDVGGfenda2OyAsWjKfSUZs9cl5zNapg67xN8EWNPNDna6Vqgm84pBdAk8JWJXjFyH2ZiuOEmrmqDd3igQ/qQI9z1Hs447Vje/M6gxA1BWCvBr3Nh24fWkHlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209298; c=relaxed/simple;
	bh=yuFmRRaqBsfsJtPzYQeET22mlNX3TLApgKW5NcDr0/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyC73EZpcNjmTWeWP8E43SBkQHXSa23B6nHdyyNkbPlJg/p01Ft37nvW/rkKGrUPwjju+Ijo4Ny8OJv+mr4imBsCl/SZOMyildZsHuWZMtv4YNVwnqKG1usq8mb/VieT1GcBNwXB2ako0LM62iO3JL9jR59JtzIKPCRUCHqcFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mt4xVg55; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mt4xVg55"
Message-ID: <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773209293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y100CRDfV1C4AfUX3CFuMBL8rdzaBp7aumsvj5bJ3cw=;
	b=Mt4xVg55KXvaOlTYrAvE9l2oeBY5rJUiL6KvvpD7gUCExOFiQeezpUDZJRY377lxwR9ZLh
	/Lx5p2chXG622JVCIuIvbeEPbiZaxzXyOP+Y66b1bdCBNklJ8Pf+P2/IYrJ9Y8RUvJRkzu
	Ojht2vp7Mw+4japTyXIHJk2/ZEu27sk=
Date: Wed, 11 Mar 2026 14:08:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 yangfeng@kylinos.cn, menglong8.dong@gmail.com, puranjay@kernel.org,
 bjorn@kernel.org, pulehui@huawei.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260303150639.85007-4-leon.hwang@linux.dev>
 <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
 <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/3/26 01:23, Kumar Kartikeya Dwivedi wrote:
> On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>
>> [ ... ]
>>
>>> +     switch (match) {
>>> +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
>>> +             if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
>>> +                     return false;
>>> +             break;
>>> +
>>> +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
>>> +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
>>> +                     return false;
>>> +             break;
>>> +     }
>>
>> In the v1 review, Alexei Starovoitov asked for strict conformance
>> both ways rather than one-directional validation:
>>
>>     "Don't be fancy. Require strict conformance both ways
>>     in *all* patches."
>>
>> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/
>>
>> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
>> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
>> but allowing the reverse.  Was this an intentional design choice, and
>> if so, should the changelog note the disagreement?
>>
> 
> Let's follow the approach Alexei outlined, while the changes look ok
> to me, let's remove the one way check and just do
> owner->kprobe_write_ctx != aux->kprobe_write_ctx, same for the other
> two checks. With this we can also get rid of this INIT vs UPDATE
> distinction.
> 
> Other than that I think patches are good, please also test both
> directions in the selftest in next respin.
> 

Hi Kumar,

Thanks for your review.

I agreed that both-ways check could simplify the code. But, the UX could
not be great.

Let me explain it with an example.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("?kprobe")
int prog_a(struct pt_regs *regs)
{
	regs->ax = 0;
	bpf_tail_call_static(regs, &jmp_table, 0);
	return 0;
}

SEC("?kprobe")
int prog_b(struct pt_regs *regs)
{
	return 0;
}

prog_a is kprobe_write_ctx.
prog_b is !kprobe_write_ctx. And, it will be added to jmp_table.

With both-ways check, prog_b is required to modify regs. I think it's
too restrictive for users to use prog_b as tail callee.

With one-way-check of this patch, prog_b can be used as tail callee to
keep regs as-is.

This was what I was concerned about, and the reason why I did not follow
Alexei's approach.

Thanks,
Leon

