Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B530FF08
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782262770; cv=none; b=AMWNMP/jbOLkDJIfyWAkQRi1xnXtG4ysHksQdZnMKL2FvgBI8MW1vVFVNxzm25GcylHyPQsVt8/UQ2WwwtaDNhL4YdK4CRPgpJK+oYh1FmNq1OqqKRpQdOz2nIgegNLk5qdNtPc2n05o0Qc4QgpNzQVWpdLWsG34vJUPDg5zH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782262770; c=relaxed/simple;
	bh=nQIwXgwQtQb7ULfLTF2xhE1CjeK5B39z7Jzs/dq3Xpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htQvpy6mlTLvxfaddf59XW0lahV3PR/b/ivNUmcccThm8fGsjx/VukgsU7mcQ0NbyQZxVxxCte3gGBvL8OQeUK8yPE39xheBFQm/2v3tX29+JEM2UlxYinTcHswR4zmZmsyT4SjD6OeCUTAEcA6S6Ln0iwdUk0fqQ6idaDYJ7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QMrdSV7D; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QMrdSV7D"
Message-ID: <16f991c7-eb45-48a2-b1d6-fe01ba6ff454@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782262767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ImmX9+zLu4TiH9gtqXiXpawSaNEsZ/ibzBQdMPAw/s=;
	b=QMrdSV7DqGY/Gkit/0x+eUqnPMyv40pH/fR2ivAmP9tWcaljLIq24whXBu/dBBM4KUvzM7
	GH9AFmH9Xy/jND4EsP5d45PvM+MnnmqM4vNCU6viiiF0XbaHOofR5LRLoG5sYp5+jq2UBv
	7BoNkAAUCwC9DvHYa2/rntbuIhLm22I=
Date: Tue, 23 Jun 2026 17:59:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Add kfunc set test to
 resolve_btfids
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
 <20260617210619.1562858-5-ihor.solodrai@linux.dev> <ajPlJ81PL_YaHsBo@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <ajPlJ81PL_YaHsBo@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 5:31 AM, Jiri Olsa wrote:
> On Wed, Jun 17, 2026 at 02:06:19PM -0700, Ihor Solodrai wrote:
>> Extend the resolve_btfids selftest to cover kfunc sets defined with
>> BTF_KFUNCS_START/BTF_KFUNCS_END.
>>
>> The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
>> resolves function IDs, and checks the kfunc set is sorted.
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  .../selftests/bpf/prog_tests/resolve_btfids.c | 63 ++++++++++++++++---
>>  tools/testing/selftests/bpf/progs/btf_data.c  | 10 +++
>>  2 files changed, 66 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> index 6bcadee50bb8..65ede3ac5845 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
>> @@ -12,6 +12,10 @@
>>  
>>  #define BTF_DATA_FILE "resolve_btfids.test.o.BTF"
>>  
>> +#ifndef KF_FASTCALL
>> +#define KF_FASTCALL (1 << 12)
>> +#endif
>> +
>>  struct symbol {
>>  	const char	*name;
>>  	int		 type;
>> @@ -28,6 +32,17 @@ struct symbol test_symbols[] = {
>>  	{ "func",    BTF_KIND_FUNC,    -1 },
>>  };
>>  
>> +struct kfunc_symbol {
>> +	const char	*name;
>> +	s32		 id;
>> +	u32		 flags;
>> +};
>> +
>> +static struct kfunc_symbol kfunc_symbols[] = {
>> +	{ "kfunc_a", -1, 0 },
>> +	{ "kfunc_b", -1, KF_FASTCALL },
>> +};
>> +
>>  /* Align the .BTF_ids section to 4 bytes */
>>  asm (
>>  ".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
>> @@ -35,9 +50,9 @@ asm (
>>  ".popsection;                             \n");
>>  
>>  /*
>> - * test_list_local and test_set are .local symbols placed in .BTF_ids by
>> - * inline asm, and are read here directly by C name. To the compiler they
>> - * are plain, default-visibility extern objects.
>> + * test_list_local, test_set and test_kfunc_set are .local symbols placed
>> + * in .BTF_ids by inline asm, and are read here directly by C name. To the
>> + * compiler they are plain, default-visibility extern objects.
>>   *
>>   * When test_progs is linked as a position-independent executable (PIE),
>>   * taking the address of such an extern is routed through the GOT. The
>> @@ -69,6 +84,11 @@ BTF_ID(struct,  S)
>>  BTF_ID(union,   U)
>>  BTF_ID(func,    func)
>>  BTF_SET_END(test_set)
>> +
>> +BTF_KFUNCS_START(test_kfunc_set)
>> +BTF_ID_FLAGS(func, kfunc_a)
>> +BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
>> +BTF_KFUNCS_END(test_kfunc_set)
>>  #pragma GCC visibility pop
>>  
>>  extern __u32 test_list_global[];
>> @@ -92,6 +112,8 @@ __resolve_symbol(struct btf *btf, int type_id)
>>  	if (!ASSERT_OK_PTR(type, "btf__type_by_id"))
>>  		return -1;
>>  
>> +	str = btf__name_by_offset(btf, type->name_off);
> 
> should we assert str != NULL like below?

Andrii commented earlier that there is no point in double checking
strings returned by btf__name_by_offset(), we should always expect a
valid string. Crashing is fine if it's not the case.

The check below is removed.

> 
> jirka
> 
>> +
>>  	for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
>>  		if (test_symbols[i].id >= 0)
>>  			continue;
>> @@ -99,14 +121,20 @@ __resolve_symbol(struct btf *btf, int type_id)
>>  		if (BTF_INFO_KIND(type->info) != test_symbols[i].type)
>>  			continue;
>>  
>> -		str = btf__name_by_offset(btf, type->name_off);
>> -		if (!ASSERT_OK_PTR(str, "btf__name_by_offset"))
>> -			return -1;
>> -
>>  		if (!strcmp(str, test_symbols[i].name))
>>  			test_symbols[i].id = type_id;
>>  	}
>>  
> 
> SNIP

