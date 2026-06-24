Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4043806CE
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274274; cv=none; b=MZEbw4m31RVJ03rh3YED6cvdeKEeCgAXf1rRL45Q51MpbBaV2nsAvRQqiEbxc462rZMuc+pZ8l5HnRlPg9Gi6+y+Tt8sCv4QsvCW9mwwRiZJwOhYbq+G3gR0vFyY5IXiqflOfRiw8D7j+GaMamocJIX6ShSHJeV2/BO6CVAExiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274274; c=relaxed/simple;
	bh=yxne3rfo6/Syw1X9iDJNv/+5pODoTBkJi8GSeGKSbKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mfm44waOR9HxpoVDS83sxsM7PQUxg+zBgelcR1e60RUJP5NNX89MyyaL+/59Mu4rb+pcrBDwHwG3jKmVKI8+6vJQC6U95f5kbn0KkDWPXmNYSM2zt33ymOc6+QITbadUmBhDN4dENKhO6lSH8k3RkCRr5jB3jSWGLJ9xQ2CBwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+sgOfcr; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+sgOfcr"
Message-ID: <d5262e2a-5457-4ca6-950e-33463cc9422d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782274270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DMJrn2is9GoO0HnE/GJFIxrPMDjz9XLRNv9kWshaGU=;
	b=R+sgOfcrt7S94hb8fqW8fLlkDYMUGQiAJt8s7r9InHrAKCcQsNDSrUxbQAnRJ6U0z8UwLF
	FK1BJw+PXmq3SJ5NGNvOeO3cZ+9lwgTWzri7Hdz61sqt6HLTdUoEBSTqiXdQEraPVfhxfd
	hWOi+wJcAR8JTP5wESvketTFwf12qcE=
Date: Wed, 24 Jun 2026 12:11:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 04/11] bpf: Introduce global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-5-leon.hwang@linux.dev>
 <CAEf4Bza8aqNsiiBHJ64+Sj-2twUFxeSuBZ89tVroig3OWC9_Ng@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bza8aqNsiiBHJ64+Sj-2twUFxeSuBZ89tVroig3OWC9_Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/6/26 06:45, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2026 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> +
>> +static int percpu_array_map_direct_value_meta(const struct bpf_map *map, u64 imm, u32 *off)
>> +{
>> +       struct bpf_array *array = container_of(map, struct bpf_array, map);
>> +       u64 base = (u64)(__force unsigned long) array->pptrs[0];
>> +       u64 range = array->elem_size;
>> +
>> +       if (map->max_entries != 1)
>> +               return -EOPNOTSUPP;
>> +       if (imm < base || imm >= base + range)
> 
> nit: not sure what's the value of range local variable, single place
> where you use array->elem_size
> 

Hmm, this was copied from array_map_direct_value_meta().

Will drop "range", and use "array->elem_size" here.

>> +               return -ENOENT;
>> +       if (!bpf_jit_supports_percpu_insn())
>> +               return -EOPNOTSUPP;
>> +
>> +       *off = imm - base;
>> +       return 0;
>> +}
>> +
[...]
>> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
>> index b2a19acadb91..5787246bef30 100644
>> --- a/kernel/bpf/const_fold.c
>> +++ b/kernel/bpf/const_fold.c
>> @@ -182,7 +182,6 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
>>                 u64 val = 0;
>>
>>                 if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
>> -                   map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
> 
> can you please elaborate on why this change is needed?
> 

This was suggested by Alexei in v4:
https://lore.kernel.org/bpf/CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com/

Thanks,
Leon

>>                     off < 0 || off + size > map->value_size ||
>>                     bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>>                         *dst = unknown;
> 
> [...]

