Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335572E62E
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121864; cv=none; b=dC55ZbeYWMF16yc2dq7wEk5ZaIRO1ozmQpathF+qg2f0eTYcVcnGWuJvTQAKQckfDeGEaeGLvwEVxe0vR3FriXp+VPSwmID6Wt+XPbKICogluu7tPpCi4UYzP6fvS89LYBAl3bMBAYdyh5V/Uo/afHNOISLJJ8Nu6ReAbOZ02ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121864; c=relaxed/simple;
	bh=SUz8sW5c7pzloRLYqyE4Zb9yx+BR3waGVMCjQH/EivU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYSA8aFY1yEtbFG45429zZaDa0CwtBQQy19zajngGFAM7IU2+x1CP7bjXJHCkuitwsbd2Slc26bZN0yiiscZdh93HU42bq5ZGAk7FagRW/sSpwd+sh0GbfG9L7me42sPC2XxznKlrSKXEp12bKHy4UIPV0afrT0tEQDJFSmRhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jv1QyO80; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jv1QyO80"
Message-ID: <68857a01-aa20-42e9-8150-752bd0efca14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711121859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95q5T/1FHf6LfY/5dkLxD/MMtuDqoQ2lr2ywL+2ghmU=;
	b=jv1QyO80PIlKtNPMdt9zE2C7zYYDMQB88mtA/LgpgfOuFoQHi/LesizljcIfIjyiAjvZNe
	ZsCn8ohTBP4x1KjJ1ispNT++/F3jOziPM5dHVquqh+oyMEgN+/utq9T0iIHI4Od9kw8jGG
	6veTLKQm3PVxIPQEtwqbg5hFEzSITh4=
Date: Fri, 22 Mar 2024 08:37:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: Mark libbpf_kallsyms_parse static
 function
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200108.2219280-1-yonghong.song@linux.dev> <Zf17mB9SYKiXDneG@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zf17mB9SYKiXDneG@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 5:37 AM, Jiri Olsa wrote:
> On Thu, Mar 21, 2024 at 01:01:08PM -0700, Yonghong Song wrote:
>> Currently libbpf_kallsyms_parse() function is declared as a global
>> function but actually it is not a API and there is no external
>> users in bpftool/bpf-selftests. So let us mark the function as
>> static.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c          | 2 +-
>>   tools/lib/bpf/libbpf_internal.h | 2 --
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 86df0d50cba7..a7a89269148c 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -7982,7 +7982,7 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
>>   	return 0;
>>   }
>>   
>> -int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
>> +static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
>>   {
>>   	char sym_type, sym_name[500];
>>   	unsigned long long sym_addr;
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index 864b36177424..b1bbbdcb7792 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -521,8 +521,6 @@ __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
>>   typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
>>   			     const char *sym_name, void *ctx);
>>   
> there's also kallsyms_cb_t which should be moved to libbpf.c,
> or perhaps removed and unwinded in libbpf_kallsyms_parse

Thanks for suggestion, will make the change in the next revision.

>
> jirka
>
>> -int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *arg);
>> -
>>   /* handle direct returned errors */
>>   static inline int libbpf_err(int ret)
>>   {
>> -- 
>> 2.43.0
>>
>>
