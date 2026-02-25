Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981142472A2
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032589; cv=none; b=OQy+fs9FAV5BluAxvDw6PPGoszN7xgntL7Vw4NC+QShTzl1hJx8Tr1rP1mhaLYTteJKPDx0NfteCrwv6tehLUNVq9t/9Mt2pOCuMJl/xELyQGX1rtddgsKSQ86UFnY7m7AtQU6CUZ7CFZu3qq1hL3qYIVYcNkWkO996YmbqjEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032589; c=relaxed/simple;
	bh=2v4+h7fONrljMow2c+RVTQnuVYSvEGGP7MQ7qIyqGpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdUqdqXFifr7BRMWxtZ+yVpNEHoAHgCTHpIPPFtKXrXnxtxoc+jLYmH/S60/dfYVI5whe7m1tqCsXXmrGvChb5BAwkaBXljq+KSn3X/rs6x4jRG8ixMDHJU7yWR+Jff424nAU0BRQnLTUSj8HDymocWBv5fEpX9ld3gP7mtULOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtFB3V3h; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtFB3V3h"
Message-ID: <0383ff36-df20-4376-9374-99ff32a527f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772032575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ht1IsfkuNiCWNDQxQQ9oeNsmgvwISL3gSGHhQ9b5ks=;
	b=wtFB3V3hJzoIj/6NCuu3CNIh/Ni0VeK128IyhG0t+3YpgSOC3/IIplpDBSjrRLxQ6uFU0E
	OOT9IHx1+YFteW01mvPoNroI5jrz/FoIOqnIUUeLVf1zFZQyfPr/axPf9h3HUj1g1i7JCN
	dmNqcRNbf5fp3U4Vq8kXZ1O+wL5qpXg=
Date: Wed, 25 Feb 2026 23:15:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/8] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Feng Yang <yangfeng@kylinos.cn>, Menglong Dong <menglong8.dong@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
References: <20260224154024.12504-1-leon.hwang@linux.dev>
 <20260224154024.12504-3-leon.hwang@linux.dev>
 <CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/25 00:57, Alexei Starovoitov wrote:
> On Tue, Feb 24, 2026 at 7:41 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> uprobe programs that can modify pt_regs require different runtime
>> assumptions than pt_regs-read-only uprobe programs. Mixing both in
>> one prog_array can make owner expectations diverge from callee behavior.
>>
>> Reject the combination of !kprobe_write_ctx progs with kprobe_write_ctx
>> progs in __bpf_prog_map_compatible() to address the issue.
>>
>> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h | 7 ++++---
>>  kernel/bpf/core.c   | 3 +++
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index b78b53198a2e..2a2f6448a5fb 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -285,9 +285,10 @@ struct bpf_list_node_kern {
>>   */
>>  struct bpf_map_owner {
>>         enum bpf_prog_type type;
>> -       bool jited;
>> -       bool xdp_has_frags;
>> -       bool sleepable;
>> +       u32 jited:1,
>> +           xdp_has_frags:1,
>> +           sleepable:1,
>> +           kprobe_write_ctx:1;
> 
> Don't you see how much churn you're adding this way?
> Every patch has to touch two lines instead of one.
> Use
> u32 jited:1;
> u32 xdp_has_frags:1;
> 

Ack.

> also the bot is correct on patch 2 and 3.

Agreed.

Here's a concrete example that breaks the constraint:

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
	bpf_tail_call_static(regs, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

The constraint can be broken by:

* Load prog_a first.
  At this point, owner->kprobe_write_ctx=true.
* Load prog_b next.
  At this point, prog_b passes the prog map compatibility validation.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, the regs will be updated via prog_a.

> Don't be fancy. Require strict conformance both ways in *all* patches.
> 

It was to avoid awkward UX.

For example, the tail call from prog_a (kprobe_write_ctx=true) to prog_b
(kprobe_write_ctx=false) should be allowed. If prog_b is required to be
kprobe_write_ctx=true, prog_b will break user's expectation that prog_b
should not always update ctx.

The same awkward UX applies to call_get_func_ip, call_session_cookie,
and call_session_is_return.

I'll find a way to avoid such awkward UX by keeping the one-directional
validation, and to avoid the aforementioned constraint-broken issue at
the same time.

> And your codex selftests are garbage. I don't have other words
> to describe it. They are not testing the actual bug that
> your patches are fixing. Think of what you're doing.
> Asking LLM to write a test for your other patch is not what you
> should be asking it to do. The selftest should be such that
> it proves the unsafety/crash before the fix.
> 

OK. I'll reimplement the selftests by myself in the next revision.

Thanks,
Leon

