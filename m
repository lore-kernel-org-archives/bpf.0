Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665058;
	b=237zi2CN9vrScLiww5nEPa5ODSpGSnPdJXiy6JL+kEFKggAgyzevVDu8AjP5pWxlE58F
	 200BSy8VvfhjefXirLSf7gzaXgNAOmP6T5/YV/r3UlaDI6iaEHFjJQA1zBIRid58wwbZU
	 2CMUsdtbyucyAceMBhSdOz9miQA6I9gnllJ7bSG69DXeJKVEPw+q2ponXw0EPq4Z1Zilr
	 ZddBbT6tQuVhONkcgj2NUA03U8SwTcNosw9Ge3xNxxZycPWOdyRMdDyYWiSbge0GDj6CD
	 vYL3cAASVJ5z3CTO5paO7Z0po8x4CUUXC1IpS1NuXZIaq6n6ZZ6IsoLzSFcR+zN2PWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665058;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=X3pJmibSN99OuYP6q4g7bu118mku30brr0Vub0OEfOU=;
	b=W8t/AVQNA7Zdi9LwN8DAC44VGqouX53L6pSgqGDtR+2tCH9H/32GeDqYWJod+34Meqki
	 h6f0Y+EE37tafw6sD8hooFCTBW4c/4TDB4rDmbu99cpk4ClT8sKv2m1u1zQLXg+04HdWn
	 2LF7j8IUcqM2/SUY9ETKX2Jd0jIblumGxN9rG3W+RdwdXiLICa5Ug+EHp1YKBfLB1w0L9
	 nZUwc0kicQuc4qZTcPUMq+oTtYZU0+R3X4NqlvZ8Ur3SN56ODLaCN9HDy+0uA/yzuq5Nl
	 AJ7fr3JN61TQfVisIlZRp6csR2zbOwj42qzmp6anjbVcToklHdW3bw8h2KJ+xTk85OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BeA4Xt04;
	arc=none smtp.remote-ip=91.218.175.202
Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CA606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 00:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BeA4Xt04
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u6OutePaN+dDyY3y03wImIJngxn+HuKbK2jJs2uPzHU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793665055; v=1; x=1794269855;
 b=BeA4Xt04qlYyc+3ocxQ9rbi4bKdBXXAoqsbX//Lhn0a6qk7FQNUv3nEQt4hSqI68HdwebQrQ
 KiL/jZ1KNPZWzMVWhkcrBUoiojbhLisv+qY5ZNddFZsOClCpdTO96+NSco1nimUywVguuT6i8KL
 AXO8ZJQFISmKxLfulVZqyVpM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 653cbf8e80750eea;
	Tue, 03 Nov 2026 00:17:35 +0000
X-Mizu-Trace-ID: 653cbf8e80750eea
X-Migadu-Flow: FLOW_OUT
Message-ID: <daeba59a-62c0-4c24-a9d4-014c238e34db@linux.dev>
Date: Mon, 2 Nov 2026 16:17:30 -0800
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
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: skip the struct_ops arena
 tests without compiler support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jose.marchesi@oracle.com, david.faust@oss.qualcomm.com
References: <20261102220717.4079739-1-vineet.gupta@linux.dev>
 <20261102220717.4079739-9-vineet.gupta@linux.dev>
 <DML33YRVJEMW.2HUSMGKYHA4HT@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DML33YRVJEMW.2HUSMGKYHA4HT@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 2:39 PM, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 02:07 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
>> These are not driven by test_loader, so __skip_without_arena does not
>> reach them.  Use the flag-in-.data pattern linked_externs.c already
>> uses for the same situation: the program exports skip_tests, and the
>> host checks it before attaching and reports SKIP.
> cast_kern() is cleaner...
> It's a nop when the compiler supports arena.

Nice, definitely better than what I had since now more code is exercised 
than being skipped.

Thx,
-Vineet

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
> index 8aa8639..3fffa24 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
> @@ -86,7 +86,6 @@ struct bpf_testmod_ops3 testmod_arena = {
>   SEC("syscall")
>   int trigger(void *ctx)
>   {
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   	u64 __arena *val;
>   	int ret;
>
> @@ -94,6 +93,7 @@ int trigger(void *ctx)
>   	if (!val)
>   		return 1;
>
> +	cast_kern(val);
>   	*val = 41;
>   	ret = bpf_testmod_ops3_call_test_arena((u64 *)val);
>   	if (ret)
> @@ -134,6 +134,5 @@ int trigger(void *ctx)
>   		return 11;
>
>   	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
> -#endif
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
> index 495faa0..3455ca9 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
> @@ -45,13 +45,13 @@ int unrelated(void *ctx)
>   SEC("syscall")
>   int trigger(void *ctx)
>   {
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   	u64 __arena *val;
>
>   	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>   	if (!val)
>   		return 1;
>
> +	cast_kern(val);
>   	*val = 41;
>   	if (bpf_testmod_ops3_call_test_arena((u64 *)val))
>   		return 2;
> @@ -59,6 +59,5 @@ int trigger(void *ctx)
>   		return 3;
>
>   	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
> -#endif
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
> index a2218cd..afbe59f 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
> @@ -80,7 +80,6 @@ struct bpf_testmod_ops3 testmod_arena_member = {
>   SEC("syscall")
>   int trigger(void *ctx)
>   {
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   	u64 __arena *val;
>   	int ret;
>
> @@ -88,6 +87,7 @@ int trigger(void *ctx)
>   	if (!val)
>   		return 1;
>
> +	cast_kern(val);
>   	*val = 41;
>   	ret = bpf_testmod_ops3_call_test_arena_member((u64 *)val);
>   	if (ret)
> @@ -104,6 +104,5 @@ int trigger(void *ctx)
>   		return 4;
>
>   	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
> -#endif
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
> index 09b4c74..c4e134e 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
> @@ -63,7 +63,6 @@ struct bpf_testmod_ops3 testmod_arena_member_render = {
>   SEC("syscall")
>   int trigger(void *ctx)
>   {
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   	u64 __arena *val;
>   	int ret;
>
> @@ -71,6 +70,7 @@ int trigger(void *ctx)
>   	if (!val)
>   		return 1;
>
> +	cast_kern(val);
>   	*val = 41;
>   	ret = bpf_testmod_ops3_call_test_arena_member((u64 *)val);
>   	if (ret)
> @@ -80,6 +80,5 @@ int trigger(void *ctx)
>   		return 3;
>
>   	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
> -#endif
>   	return 0;
>   }

