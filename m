Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53873E1217
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962147; cv=none; b=ih75BS64Ye3nCnNht0fLFgd9IVU4vfpmDuNhv7SZ+aGIScZo1j9Z0e8U6YrZgoMnQxPNdsoGFs3VQgREjJSZfuwYF5jj2wRlCn47dQH/OQpqRoQ2+Eko/x2Z4GcR1Dkg2EekmANoNTSHuN6vaz7e5iQBDGjYjxI3ba9NoMVgQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962147; c=relaxed/simple;
	bh=3T5Z5zgqiJwwwvdf2hpNzGcVRiEyF17pTxhs+i8PQKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jq4Up5uFya1wJe4d+LUcxWqxEI2go981qxlTGOzzmlnM7jVXeM17cK5LInFfV4/TsG/VSqIJHEYjbiv9CHSN32p15Ft4pt5YFxBb7pCar7WHcVaR3yjp1/dsAMjDvIdLJ9lHM1oRLB0oNGGsApFRfWtbdaS+eL2SFX3p6AeUfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az80eKlp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az80eKlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF5C19423;
	Tue, 31 Mar 2026 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774962147;
	bh=3T5Z5zgqiJwwwvdf2hpNzGcVRiEyF17pTxhs+i8PQKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Az80eKlpB30Sz2dscF5ufjN5+p6fCWzkX9/CnavlRsEYLCH/20NveUdKNLjtNsQom
	 ZuK6ABEBJqs3PYaVzll7gc6IYV2CmxblCkfZLZ3bQQW7hBl4DTG8VgNXsf4HwvRkhD
	 F92Z3Qz9VVWmzMJRRviRId+YvutQnecmEQUCRHjUXR5vKKbd7rmuLMbEV8l6+9YYJc
	 mlJfx6/067f6sR21L9N19vahOaUrjxoNV7p0TXIJf/HYqnp+MhK5d315IzTVv5ipzO
	 0rN5mrCUiTzX6RYko8hs9RdN+zUXDZj97n6NYgcuRCgtqHww6CGtqVBV5V5EZDtvK7
	 lU/tQ9M7jePOQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bot+bpf-ci@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, eddyz87@gmail.com,
 cupertino.miranda@oracle.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev, Puranjay
 Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: impose global ordering
 for test decl_tags
In-Reply-To: <fdf52b7b106f1747fc2e4bf11fa34b28f140b5abb1c698c6800ad167130c10b6@mail.kernel.org>
References: <20260330-selftests-global-tags-ordering-v2-3-c0ac61e81098@gmail.com>
 <fdf52b7b106f1747fc2e4bf11fa34b28f140b5abb1c698c6800ad167130c10b6@mail.kernel.org>
Date: Tue, 31 Mar 2026 14:02:13 +0100
Message-ID: <m2mrzo17ai.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> index 50ca1b6ec8150..3f784cc76f8f5 100644
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
>
> [ ... ]
>
>> +static const char **collect_decl_tags(struct btf *btf, int id, int *cnt)
>> +{
>> +	const char **tmp, **tags = NULL;
>> +	const struct btf_type *t;
>> +	int i;
>> +
>> +	*cnt = 0;
>> +	for (i = 1; i < btf__type_cnt(btf); i++) {
>> +		t = btf__type_by_id(btf, i);
>> +		if (!btf_is_decl_tag(t) || t->type != id || btf_decl_tag(t)->component_idx != -1)
>> +			continue;
>> +		tmp = realloc(tags, (*cnt + 1) * sizeof(*tags));
>> +		if (!tmp) {
>> +			free(tmp);
>> +			return ERR_PTR(-ENOMEM);
>> +		}
>
> Should free(tmp) be free(tags) here? When realloc fails, tmp is NULL,
> so free(tmp) is a no-op. The previously allocated tags array would be
> leaked.
>

This is correct, realloc() will return NULL on failure, we should do free(tags)
