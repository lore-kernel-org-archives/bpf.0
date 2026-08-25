Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69785440A34
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668182; cv=none; b=eVYZoE80ycuZxEoMRaqeBqB8q4RfWQXo6et8ld2cVFFEF1dGYPq5BbXnBEymAs4+QGjL1rwALJkWbfHiDZjMY6+0wXV8//s0dORLviwcW5laGpFUUOqEfqS27yKp63efndQ/sUK2Oa10M14QLd+d17RFr+r983NzdBnOix+Z3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668182; c=relaxed/simple;
	bh=h5gsTwFytki5g7HvBa3yfBVgfxrlRvmqG20J6fnfP1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrvIDsP0YsX7eNYfkebMrd0BbHxNbylP2b9JyRINz069WfRoZ6s7WalanBi2nivqJ5LZ8Egyh0RWFMElw0ZVSbgRFMeWV0k9aGlcxqqOG3ah3ldrlH3tSCfR7qIWoNRGMb1i5qP0q4ea2a18jKjifI5YBnGh1VUCqXDOutK16T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v5sCgYIH; arc=none smtp.client-ip=91.218.175.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v5sCgYIH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h5gsTwFytki5g7HvBa3yfBVgfxrlRvmqG20J6fnfP1E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787668178; v=1; x=1788272978;
 b=v5sCgYIH0i6THyUjgzErmhp+Stvh6G0J4K8ApmTBhEL3gSrpFquRlKySoNOGZw+TxUQ5MmlL
 +0LoSGfld8HuVa5ed9Jx36B5IXuBaLh2INPUrAkmXtVnbk0cOBYznplrldVW/FCWXq+iHuCw5tB
 Z7jbXlD3MOF9Hn/6oiGWIVI4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.29.144] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 86448ddc2c970569;
	Tue, 25 Aug 2026 14:29:28 +0000
X-Mizu-Trace-ID: 86448ddc2c970569
X-Migadu-Flow: FLOW_OUT
Message-ID: <016aecc5-b3dc-4d8d-be1b-67b9b4b0a24e@linux.dev>
Date: Tue, 25 Aug 2026 22:29:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] libbpf: Fix usdt attach failure when nop10
 crosses page boundary
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Jiawei Zhao <phoenix500526@163.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260824092847.361683-1-jiayuan.chen@linux.dev>
 <ao2fomkGLiwm032U@krava>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <ao2fomkGLiwm032U@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 9:58 PM, Jiri Olsa wrote:
> On Mon, Aug 24, 2026 at 05:28:36PM +0800, Jiayuan Chen wrote:
>> The kernel refuses to attach to a nop10 that crosses a page boundary,
>> since it can't be atomically rewritten:
>>
>> 	/* can_optimize(), arch/x86/kernel/uprobes.c */
>> 	/* We can't do cross page atomic writes yet. */
>> 	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= OPT_INSN_SIZE;
>>
>> Whether the nop10 crosses a page is purely up to the binary layout, so
>> this does happen in practice. libbpf doesn't check for it and blindly
>> shifts the uprobe onto the nop10, and the attach then fails with
>> -ENOTSUPP. Just keep the uprobe on the preceding 1-byte nop in that
>> case, it works everywhere as a regular int3 uprobe.
>>
>> Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   tools/lib/bpf/usdt.c | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
>> index 2e56e3ab5b6c..c266ac93cbdd 100644
>> --- a/tools/lib/bpf/usdt.c
>> +++ b/tools/lib/bpf/usdt.c
>> @@ -614,11 +614,28 @@ static bool has_nop_combo(int fd, long off)
>>   		return false;
>>   	return memcmp(buf, nop_combo, 11) == 0;
>>   }
>> +
>> +/*
>> + * The kernel refuses to attach to a nop10 that crosses a page boundary,
>> + * as it can't be atomically rewritten. Page offset of the probe is the
>> + * same in the file and in any mapping, so this can be checked statically.
>> + */
>> +static bool nop10_within_page(long off)
>> +{
>> +	long page_sz = getpagesize();
>> +
>> +	return off % page_sz + 10 <= page_sz;
> could this be another check in has_nop_combo ? so we do not
> need to introduce another stub
>
> otherwise lgtm, thanks
>
> jirka
>
Thanks Jirka

Sound reasonable, I will do it.

