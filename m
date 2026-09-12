Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E1344DBD
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233906; cv=none; b=llizd/XchBRWqX0SDA6IY0AhlBwxjD6IKAznWKGwE2M4IUeFBlkLtyjlDKuUbZYfCN7eUm7nNRb8SHZAme+LYnuc4tbJHppT6dvDqMG55LYmPVOcxhiXfOBHK7IL5NUtS2TOZaFabzfhGA9Vuc8tpAlYT2RHk8Zny/KVWBi4eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233906; c=relaxed/simple;
	bh=m0SRPRt3WBqJSxx5NiuwxWIPjGMspL81k82/yO0gkxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsPZoS90zFnBvDJy27hzql1y7485MKDNbteRClqU15rleoKxH4zwGSf5IiAzdnjVIbS9MooQsxg9lgrouzDb9TjFlvtKGjU/B2N6XICYS51+hEDkhOVUVvp8/M6dPmij86MGggJtnVuxNK8a9cHn1lHORUQkvL4btYRfkw/0Glc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tC/FSgnE; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tC/FSgnE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m0SRPRt3WBqJSxx5NiuwxWIPjGMspL81k82/yO0gkxI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789233902; v=1; x=1789838702;
 b=tC/FSgnECqVRiCjV1fQD7lc79wLTJ5eXI6DPzw7NUkQp5gspwL4r2dqdPD9LNm/gOtHTFK0S
 8dNvkVUOpyDk8o5BWDyGvKCpHr3OS8XxOnvBzPogCu3RmXk43VnE4OgCuQhGyhRh4si7Uw7QnsZ
 q1IdgLt2BYkp5qxY+p+weSVw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02098445213dc316;
	Sat, 12 Sep 2026 17:25:01 +0000
X-Mizu-Trace-ID: 02098445213dc316
X-Migadu-Flow: FLOW_OUT
Message-ID: <c3b0d2af-f70f-44ba-979f-c57c5361aff0@linux.dev>
Date: Sat, 12 Sep 2026 10:24:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 14/15] selftests/bpf: Add tests for by-value
 kfunc arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260911155025.2012309-1-yonghong.song@linux.dev>
 <d6ca13c4e7f5b00fdc9bcea63467374b84e1e8facd74e2322f8e92f3d06a7a24@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d6ca13c4e7f5b00fdc9bcea63467374b84e1e8facd74e2322f8e92f3d06a7a24@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/26 9:47 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
>> new file mode 100644
>> index 000000000000..8b0e7aed1ff1
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
> [ ... ]
>
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64 __load_if_JITed()
>> +__description("aggregate kfunc argument: struct at the tail")
>> +__success __retval(0)
>> +int aggregate_arg_kfunc_tail(struct __sk_buff *skb)
>> +{
>> +	u64 a = 1, b = 2;
>> +	struct prog_test_pair_arg s = { .lo = a, .hi = b };
>> +
>> +	if (bpf_kfunc_call_test_pair_arg_tail(1, 2, 3, 4, 5, s, 6) != a + b + 21)
>> +		return 1;
>> +	return 0;
>> +}
> Do these tests actually verify that arguments end up in the correct slots?
>
> Looking at the test pattern: bpf_kfunc_call_test_pair_arg_tail(1, 2, 3,
> 4, 5, s, 6) expects 'a + b + 21', but the kfunc returns the sum of all
> its arguments unweighted:
>
> tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:
>      __bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_tail(
>          u64 a, u64 b, u64 c, u64 d, u64 e,
>          struct prog_test_pair_arg s, u64 f)
>      {
>          return a + b + c + d + e + s.lo + s.hi + f;
>      }
>
> The check is invariant under any permutation of values across argument
> slots. It will catch a value that is lost, duplicated or garbage, but
> not a value that ends up in the wrong slot.
>
> Concrete case in this test: aggregate_arg_kfunc_tail is the one case
> where x86-64 moves an argument down into a still-live register (BPF
> slots a..e -> 0..4, s -> 6,7, f -> 5, so f travels through
> BPF_JIT_ARG_TMP). If the scratch handling swapped f with s.lo, the
> callee would read s.lo = 6, f = a, and 1+2+3+4+5 + 6 + b + a still
> equals a + b + 21, so the test passes.
>
> The same holds for the two halves of every 16-byte argument:
> '(u64)(v >> 64) + (u64)v' and 's.lo + s.hi' are symmetric, so a hi/lo
> swap of an __int128 or of prog_test_pair_arg is invisible in all nine
> value tests.
>
> The commit message states "Every test checks the value the kfunc
> returns, so a misplaced argument shows up rather than passing quietly."
> Does this hold if the values are commutative?

I will change kfunc to have different values with different multiplier
for each argument to make the test more robust.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527

