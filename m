Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8728690
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939265; cv=none; b=qfjzZEbZ2yEXDS/G96uNddiI8//OmDUcjucO/Gk3at2wtHWL55BdA8mtvhQFRS0V0qgasd0bjMOyaudG40y7+P4GDpXGQHMCAA0oWefZ799YK2wPQQjQ70GaMFOoeRVxNwAf+tXUJCceaKba+5lnKBwWWCm/JocwVK05acYLeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939265; c=relaxed/simple;
	bh=PiAvSTSmjnV67k6uaMX03KR6CJRJgU8zuU0Pom3Zlfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ue/Hj27dq8Jp29ZMZ4+uvXk9vnGDVbgq2bqQafE7rwk+YeZ2XgsuD9ZbtLL3cxzffO8CsEGQhYPgctaBf7acWtZRRhEmA7rmBIzAyjIP5tOXF8cvYQHOmR7catV8XIPaL0G38iYGL8Y5TrFAqJb2BXjl+VaaKzNciqYZd5WMLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=umQMPqd1; arc=none smtp.client-ip=91.218.175.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="umQMPqd1"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PiAvSTSmjnV67k6uaMX03KR6CJRJgU8zuU0Pom3Zlfw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786939261; v=1; x=1787544061;
 b=umQMPqd1oRgCq46RHszNmXKdl4+tEX2uN72Xn5Js+8bUL66kfQtjbCPFBacLS9bwVC5RRIDT
 kuGt9CqMnVsGd8fKXyzqUICrQHZUKgVPAOTzZLFvQrke7ztJDxJJd79IxltsjR4lhVbBl1F5Q6J
 HD9PrA124mwNZ2zei/GSuNRI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id f56ebb9910e0a748;
	Mon, 17 Aug 2026 04:01:01 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d7a1070-e6f9-41d0-886f-c02f418f7604@linux.dev>
Date: Sun, 16 Aug 2026 21:00:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 10/11] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200302.1997359-1-yonghong.song@linux.dev>
 <d1a79a5bee37759da16f5944905dee8aa4a01604.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d1a79a5bee37759da16f5944905dee8aa4a01604.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 6:03 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-13 at 13:03 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> new file mode 100644
>> index 000000000000..cfb21bcf704b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> ...
>
>> +struct ptr_pair {
>> +	void *p;
>> +	__u64 x;
>> +};
>> +
>> +static __naked __noinline struct ptr_pair static_ret_ptr_pair(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = r1;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__naked int aggregate_ret_static_ptr_pair(void)
> This test is redundant, already covered by a previous patch.

Ack.

>
>> +{
>> +	asm volatile (
>> +	"call %[static_ret_ptr_pair];"
>> +	"r1 = *(u32 *)(r2 + 0);"	/* deref the returned ctx pointer */
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(static_ret_ptr_pair)
>> +	: __clobber_all);
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
> ...
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
>> index b66576307f73..2c1889fc28ef 100644
>> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
>> @@ -50,6 +50,66 @@ int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
>> +int aggregate_ret_kfunc_li_c_test(struct __sk_buff *skb)
> ...
>> +int aggregate_ret_kfunc_ii_c_test(struct __sk_buff *skb)
> ...
>> +int aggregate_ret_kfunc_uu_c_test(struct __sk_buff *skb)
> I don't think three tests above a warranted, the previous patch
> already tested returning 16-byte structs. Maybe a test with a small
> structs of two ints, but I'd skip even that.
> This would drop a ton of code from the back of the patch.

Ack. Will do.

>
> ...

