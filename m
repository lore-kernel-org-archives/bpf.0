Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183C6138
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067571; cv=none; b=TLOeuERZgZhJTD//LZqA7KBu0+OqTlxL3ZLx6SwcsDmsvE9CkcTlUossemUtmo8EeXUSOZ2ZJXBK2f81mPMbrDJzhUXMY4hmT83UcMeFk5uy0JeWi2QQQ0xxl9HfK3M1S9tnpvtHmBbChfxVW0VCa7GSD6z9g/7KpmxRjSVA6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067571; c=relaxed/simple;
	bh=XttD8eFC9MceTw5FKJ95nput9Ge2ZybcVfa5rkkKU5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrommMLYS7mMaLyuI555+XtfC+Ybk6RPV8yiL3nkwEbTydMWOY+bp5wHAOsUV3HkbJ3SdiPNBLmXzLEbks/02hgcFldtbMZ2FvXlwiAlZUXCC81BLrNpV93gnEDa59Veu1vX7mb/p3+s+2RrFwyyrPVZ9WFXs1YPB/OyC0O5KO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itm63sOu; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="itm63sOu"
Message-ID: <cdbf9343-b539-4ba2-952c-b40612b72e2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711067567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgbAnwUg7M5LohxUxx6+b0XdT2wLVJo5E4Ld5aj7hxo=;
	b=itm63sOuWrj79Dpi+hm8WbprrdPIP8W7q8nHIe+Svh6n+h9Okewa6PSiuMfZ542FiWqZaf
	fvVKOUIMiqIKJyRH2C7oO/xBkukgiluNrlH7ciog1uQjIzHQwEeuocK6+ruxUtvT6tnXki
	7FbSlszcf3BiPMQlAJQ82079AnWsJLU=
Date: Thu, 21 Mar 2024 17:32:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Handle <orig_name>.llvm.<hash>
 symbol properly
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200114.2219721-1-yonghong.song@linux.dev>
 <CAADnVQL3yAnS4+A59OBmpbhEhQx7Was-EnTcLW9k4ddnXQi31w@mail.gmail.com>
 <559d9eb6-9832-4947-8d32-9be84c217659@linux.dev>
 <CAADnVQJ2vEebnbJ4t-zArLgLxdYtHUoPhvo0FsHYRWG48yqpLg@mail.gmail.com>
 <CAEf4BzaUMb9+qiFkMNj4G+M1hE=Zb-zrR8K2T+cjXfASTnFkcg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaUMb9+qiFkMNj4G+M1hE=Zb-zrR8K2T+cjXfASTnFkcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/21/24 5:17 PM, Andrii Nakryiko wrote:
> On Thu, Mar 21, 2024 at 5:02 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Thu, Mar 21, 2024 at 4:55 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>>    static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
>>>>>                          const char *sym_name, void *ctx)
>>>>>    {
>>>>> +       int lto_enabled = check_lto_kernel();
>>>>> +       char orig_name[PATH_MAX], *res;
>>>>>           struct bpf_object *obj = ctx;
>>>>>           const struct btf_type *t;
>>>>>           struct extern_desc *ext;
>>>>>
>>>>> -       ext = find_extern_by_name(obj, sym_name);
>>>>> +       /* Only check static variables in data sections */
>>>>> +       if (sym_type == 'd' && obj->need_kallsyms && lto_enabled == 1) {
>>>> why bother grepping config.gz ?
>>>> I see no harm in doing below strstr unconditionally.
>>> Do you mean we skip condition
>>>          sym_type == 'd' && obj->need_kallsyms && lto_enabled == 1
>>> all together?
>>>
>>> For condition sym_type == 'd', Andrii suggested (in private discussion)
>>> to focus on data first since that is the issue we hitted. Of course
>>> we could do all symbols here too.
>>>
>>> For condition obj->need_kallsyms, I can remove this one.
>>>
>>> For lto_enabled == 1, the main goal is to avoid extra overhead for
>>> not-lto kernels.
>>>
>>> I guess that the overhead is not that bad since typically symbol name
>>> is not long. So removing all conditions seems indeed a viable solution.
>> I was suggesting to remove the last lto_enabled == 1 check and
>> check_lto_kernel() since it will simplify the patch significantly and
>> won't cause any slowdown.
> +1, grepping Kconfig seems like an overkill
>
>> The first two checks... I'm not sure.
> I'd say we shouldn't do this for functions, because if LLVM rewrites
> them, then usually that means that function signature is changed,
> which seems dangerous to just silently resolve. I'd start with data
> symbols for now.

For this particular suffix '.llvm.<hash>', function signature will
not change. But considering all funcitons annotated with __ksym are
kfunc's and I cannot see currently how kfunc's could be cross-file
inlined.

It might be possible a kernel function is attached with __ksym as
bpf program wants to know the address of that kernel function.
But this should be a really corner case.

So agree and let me keep sym_type == 'd' condition only.

>
>> The less corner cases the better. strstr is fast enough.
> yep, I doubt it would be noticeable if we do strstr()
>> Ok to remove them all.
