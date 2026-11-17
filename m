Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916195;
	b=p17sWcOckQIjFr176FRblTpJXuF7iIS/Et2n4zmxKHrp+uB/M6CVNnrbOET9o9ZIz4Ks
	 jqIPuWALyfYu61Xms2Ew1QiTTcIckVBV1Zzl3XxVgf6IPsxALsKjwsTiIhFd8LPi261hS
	 7Oll9peOTmoJvossxwTa+b1SuqbQW2YFokerUDDPTSErgMk+pwpbNw2/Q/UJWC5jB2wZn
	 yGwm8C4QLvD3zRcM85DXggX+zQNAW3Lz4Vog4qpYgHlAmYy+YM91Izbg94tOP44GQuaKn
	 14uzzLdmoNS1Yqu6vmNevbXQBiay/R7dWdqEyU8TT6I0iGxSjFIzgbQLHAALKN4omkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916195;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=18ZHHDBDT2iiqQ6vinpecoUhNdWbTNjIuab4R2JSkRw=;
	b=0ve7fikwlSM+Q6ZZOD4IqQmjr5Bsl66Ae20CY+AdMFKMkBIPett0cy3CaSbfrAKZa/sI
	 2cvN4vdbBsfEGLHld9LCGlRHD54mAF0fh+aOD+zzsv392hKAKSeOeQw0AX9BeQDHJNwLi
	 96xHEfdyTNtKjZkkKG4fdk9zgIN0KqYhiqFB8gjUfx7DUWAmjr9zx63WED2ZOQecZNRec
	 xqAEsGJGrINleLFFD7NEa4RXPRJTRdeHWRdCLD5cHxLppYKoXw7/xMgzpXS4lWRcDfe6j
	 8JazIJBB9nQOHtD4SLWplemt8p3vOgweZq9Np1zIuWDkiRjfQGnpNcqHaoe2ztAk44A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k194TiNJ;
	arc=none smtp.remote-ip=91.218.175.182
Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23D606A33D
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C23D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k194TiNJ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AiYQuQkup3uVDt+BqI8T8e63CilYInTtTsRGRSVebRM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794916192; v=1; x=1795520992;
 b=k194TiNJciQ9zfSjJr2C7HMEZ4rPmX3eliMeO0gINyXW7ICPYnFO7E/FjK4UVXSF025/k9vA
 5pGRGp5pXqhBusaeb/Lp2Bp6L3E0qKnuA9ZxGNj+Nrol3ZEA0uvOCR485ac8NvmJTcGGdKMEC92
 EPJOsIcllTvjmYaeYT7Etywo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 68b5ba9fa6b5c9ee;
	Tue, 17 Nov 2026 11:49:51 +0000
X-Mizu-Trace-ID: 68b5ba9fa6b5c9ee
X-Migadu-Flow: FLOW_OUT
Message-ID: <dde3f6de-06bd-4e36-ad03-1c36eb3be645@linux.dev>
Date: Tue, 17 Nov 2026 19:49:45 +0800
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
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix CO-RE relocation of anonymous
 unions for bpf-gcc
To: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, ast@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sechang Lim
 <rhkrqnwk98@gmail.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117094544.148437-1-jiayuan.chen@linux.dev>
 <5efc22be-a517-4587-8e43-609bc876b54f@rbox.co>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <5efc22be-a517-4587-8e43-609bc876b54f@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/17/26 7:19 PM, Michal Luczaj wrote:
> On 11/17/26 10:45, Jiayuan Chen wrote:
>> bpf-gcc fails to load test_trace_iter_unix:
>>
>>   Error: #766/6 verifier_sockmap_mutate/test_trace_iter_unix
>>   libbpf: elf: skipping section(3) .data (size 0)
>>   libbpf: elf: skipping unrecognized data section(18) .comment
>>   run_subtest:PASS:obj_open_mem 0 nsec
>>   libbpf: prog 'test_trace_iter_unix': relo #0: insn #0 (LDX/ST/STX) accesses field incorrectly. ...
>>   libbpf: prog 'test_trace_iter_unix': BPF program load failed: -EINVAL
>>   libbpf: prog 'test_trace_iter_unix': failed to load: -EINVAL
>>   libbpf: failed to load object 'verifier_sockmap_mutate'
>>   run_subtest:PASS:unexpected_load_success 0 nsec
>>   validate_msgs:FAIL:1014 expect_msg
>>   VERIFIER LOG:
>>   =============
>>   0: R1=ctx() R10=fp0
>>   ;  @ verifier_sockmap_mutate.c:124
>>   0: <invalid CO-RE relocation>
>>   failed to resolve CO-RE relocation <byte_off> [4] struct bpf_iter__unix (0:0 @ offset 0)
>>   processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>   =============
>>   EXPECTED   SUBSTR: 'cannot update sockmap in this context'
>>
>> GCC only applies preserve_access_index to types that carry the attribute
>> themselves. The anonymous union holding the sock pointer doesn't, so the
>> CO-RE access stops at the union ("0:0") instead of reaching the pointer
>> ("0:0:0"), and libbpf rejects the relocation. Mark the unions too.
>>
>> Fixes: e16c83fa764f ("selftests/bpf: Add negative test for sockmap update from non-sockmap iter")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
>> index 1516fe1524bb..68b1a5323470 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
>> @@ -16,13 +16,13 @@ struct sock {
>>  struct bpf_iter__sockmap {
>>  	union {
>>  		struct sock *sk;
>> -	};
>> +	} __attribute__((preserve_access_index));
>>  } __attribute__((preserve_access_index));
>>  
>>  struct bpf_iter__unix {
>>  	union {
>>  		struct sock *unix_sk;
>> -	};
>> +	} __attribute__((preserve_access_index));
>>  } __attribute__((preserve_access_index));
>>  
>>  struct {
> What about dropping the unions?
>
> -struct sock {
> -} __attribute__((preserve_access_index));
> -
>  struct bpf_iter__sockmap {
> -       union {
> -               struct sock *sk;
> -       };
> +       struct sock *sk;
>  } __attribute__((preserve_access_index));
>
>  struct bpf_iter__unix {
> -       union {
> -               struct sock *unix_sk;
> -       };
> +       struct sock *unix_sk;
>  } __attribute__((preserve_access_index));
>
> Works under clang.



Right. I grepped the tree and verifier_sockmap_mutate.c is the only place
that puts an anonymous union inside a hand-written preserve_access_index
struct, so the test doesn't need it.


