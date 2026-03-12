Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3D33D507
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282295; cv=none; b=g2qfp2MDIxq3sJr1wTI/41TOaRCy5nlttTKF4iOEKNIIq3wEr0KPEAtEzMHkdNlMssSkm2C6nAhu1LqjGq6Mhs89Md6bHQbNJJgh10JgOlV1YdWluyCuobSz+AieMizm60cYlL/eO5XBW5/cwntPumFXwiMXAmYkVqPlLwl0bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282295; c=relaxed/simple;
	bh=t/o8JZUco4a+9p05JAFPQThPlGv3WyinrLjprD+EYkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kh6rc95kjc33qc5lSBkIEoK4WpoS7SuzgxhA6jWfjLpj9jJ1x1Ayf2ScqBtfYjZN2zSfakPG+xh8pZ4BD0Z0JueAcjc3J/0CD6wObWScVQo3mgeALzSLUsInVf59lHO2Ep96RydMXlDpbOR+2L2KJoe/n3u9zL3qdhed2Adkbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuIml8+b; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuIml8+b"
Message-ID: <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773282281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+NS9REi3OjQ/Mu3hl26dakXZd5lzaswGeV0mI0VxH4=;
	b=WuIml8+bFNWIai4pwtX4tSQzikrGoTasWPFRug7mytOWFiHVJNt6mTJkktE1FTWXVKRaLT
	g1ZTGbjjaTi+mrujNQC9o7G5g6Q2iRFeWZg+YXNo/pvsk4EKezOY3WBmG3CzbloTpKjOfJ
	6jEHTin93tow6aBkkOPbIY/3bFRGEoI=
Date: Thu, 12 Mar 2026 10:24:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260303150639.85007-1-leon.hwang@linux.dev>
 <20260303150639.85007-4-leon.hwang@linux.dev> <abHwii5stH93Vz5E@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <abHwii5stH93Vz5E@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/3/26 06:45, Jiri Olsa wrote:
> On Tue, Mar 03, 2026 at 11:06:36PM +0800, Leon Hwang wrote:
>> Uprobe programs that modify regs require different runtime assumptions
>> than those that do not. Mixing !kprobe_write_ctx progs with
>> kprobe_write_ctx progs via tail calls could break these assumptions.
>>
>> To address this, reject the combination of !kprobe_write_ctx progs with
>> kprobe_write_ctx progs in bpf_map_owner_matches(), which prevents the
>> tail callee from modifying regs unexpectedly.
> 
> hi,
> could you please give some example where this is actual problem?
> I'd expect it's up to user (whoever installs the tailcall map) to
> avoid such situations.
> 
The self test in patch #6 can verify the problem, that
kprobe_write_ctx=true progs can be abused to modify struct pt_regs via
tail calls when tracing kernel functions using kprobe_write_ctx=false prog.

Explain the problem by reusing the test code:

int dummy_run;
u64 data;

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} prog_array_dummy SEC(".maps");

SEC("?kprobe")
int dummy_kprobe(void *ctx)
{
	dummy_run++;
	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
	return 0;
}

SEC("?kprobe")
int kprobe(struct pt_regs *regs)
{
	data = regs->di = 0;
	return 0;
}

The "kprobe" prog will be added to "prog_array_dummy" map.

In user space, the "dummy_kprobe" prog will attach to kernel function
"bpf_entry_test1".

Actually, without this patch, when "bpf_fentry_test1" runs, the arg "a"
will be updated as 0. Thus, bpf_prog_test_run_tracing() returns -EFAULT
instead of 0.

bpf_prog_test_run_tracing()
|-->bpf_fentry_test1()
    |-->dummy_kprobe()
        |-->kprobe() /* via tail call */
            |-->regs->di = 0;
    return 1; /* instead of 2 */
return -EFAULT;

Yep, the commit log is not clear to describe this abuse problem. Will
update it.

Thanks,
Leon

