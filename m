Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484B24E4A1
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830196; cv=none; b=MaRDV2SC/D6G/hi88peiMLJP+XLXOxJajt+oSHBHZ4J73nqkHkonUbKXSGq+ErXFXNyGMvDe4fcsY/maYeY+LQejSQECTgeVFRk1WzUg5kjw3+y2d70VszDeG6Bv/7U2AWWib3oPOt7EFZWtg/PmubmFA1k4neFBfiRAi3/jvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830196; c=relaxed/simple;
	bh=CsLUMhDKWk6917zeC7Q4fp01kfFvxxmwjHzH4wty3Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jug5LRXE7qMTrszgq16uFXEuIzh5tVmWEqyoOWgpX4aH0ce2RZQFw75KjvKgs7hYC9vg6k3sJBpHIrOZi3gyghU8SKi9eHjPYC/a0PyodcAfvyqya554SL85p9bY0Eqy5EailSXv3djKHHlxol60iUVl8gR74hCLe1jHj1T7Qow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUiwnunX; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUiwnunX"
Message-ID: <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782830192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldTuy5PWL74Sf+b2yy1Ups+I/uhlfwfaH7fk6MSKw1c=;
	b=QUiwnunXmQJ1qgo64/yicYie49iBhhtsQeRXdbpcKKTMmDxtlmQ3ZGzanWerhf/6g7I3mp
	xXFMS7mKrWP8jJ8ECplJG204v9xyah97W0n1sYAq4a6+wyXqJ8pSGGnrE/9n6TST/Fz24O
	F9S9t4mR/60qqJ0NjixNf7qkvSHFGKk=
Date: Tue, 30 Jun 2026 22:36:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
To: KaFai Wan <kafai.wan@linux.dev>, bpf@vger.kernel.org,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <20260626154330.33619-2-leon.hwang@linux.dev>
 <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/30 22:29, KaFai Wan wrote:
> On Fri, 2026-06-26 at 23:43 +0800, Leon Hwang wrote:
[...]
>>  /* Fix up helper call offsets on JIT fallback path. */
>> -static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
>> +static int bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
>>  {
>>  	struct bpf_insn *insn = fp->insnsi;
>>  	const struct bpf_func_proto *fn;
>>  	int i;
>>  
>> -	if (!env || !env->ops->get_func_proto)
>> -		return;
>> +	if (!env)
>> +		return 0;
>>  
>>  	for (i = 0; i < fp->len; i++, insn++) {
>> -		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) {
>> +		if (env->ops->get_func_proto && bpf_helper_call(insn) &&
>> +		    bpf_jit_inlines_helper_call(insn->imm)) {
>>  			fn = env->ops->get_func_proto(insn->imm, env->prog);
>>  			if (fn && fn->func)
>>  				insn->imm = fn->func - __bpf_call_base;
> It might be better to use the BPF_CALL_IMM macro. insn->imm = BPF_CALL_IMM(fn->func);


Makes sense.

This might be applied to Tiezhu's patch.

Thanks,
Leon

>>  		}
>> +
>> +		if (bpf_insn_requires_jit(insn))
>> +			return -EOPNOTSUPP;
>>  	}
>> [...]

