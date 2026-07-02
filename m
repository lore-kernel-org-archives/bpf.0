Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DDD431E47;
	Thu,  2 Jul 2026 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987251; cv=none; b=hanOyj2s49WG4VMyWh3p7Tx418gp5MtNOhtlzMtasKnVkcgbS3Wis+6Yr8ZzKuhch6amLhzvMKPGhjOB9uyoDyt6D0yxTKCJxzflJaCqZYddhJrLU+v2jzQZYQgMiQPr/fP6L36qjsz1Da+JrktP8KmiLCKnBP9yzoAusgQPem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987251; c=relaxed/simple;
	bh=tOMmQUenCG1jMgN7FzjDP94hTwGMiM5uWixk6zfaXN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFu2pScNO4DNSdTcmWuRr6rt5Fe9ADjTl3VT68EkRh0sQTJXsWvdHGla72D/2hi+E/pGWSt5LXvTHAnyvjiOVxGiYt//q3sTYnW9LYhijUwIoMdptqx9eJYnlcFQI5Mk3rbjA4mV48rJiNa/siqTZfEwjgyt6++AtUD5+n5bvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC+FBSYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC+FBSYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE99A1F000E9;
	Thu,  2 Jul 2026 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987250;
	bh=0KD4IxePiaRKiDUnsWDd7ZzKC/uuEISEEwFi3ALOjG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nC+FBSYplUxRkTcDA28Uihm2bb0QiWxV6MKbGDNC2p8EaFdzDDKXcx/WjB54/PouI
	 GmfOQFEXDexXOHToPjplEC/5XhrM4B51o5tunEHF6yY5kw0cJnm8noVKI/GaUf7izo
	 O9p4ZSBSYk/iOV6xJl48gcPJ9ZR4hYpqRwpkY7viZS346SnAIrmBHvqWi1g9iBMtcO
	 skGWM7S8Slo0omYWjyLEV3xJmzJbvFHXHKusV8rPuG0APvSTaSPRxkdhlA4PP/b/0e
	 j48nMGXjDMdufA2vA4J09h9/c3JATnx0ztPQaNI81DGzMDka5MF9vnOQDuTtVPoZM+
	 wQB0L+wI1SWeA==
Message-ID: <80fd18b5-dc4d-4078-a236-80b8be531e22@kernel.org>
Date: Thu, 2 Jul 2026 11:14:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 5/9] bpftool: Generate skeleton for global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-6-leon.hwang@linux.dev>
 <a4e4adfe-4b2e-49c4-a708-89276514f930@kernel.org>
 <CAEf4BzbfA2nySpf3Oh6KVBRjDKMOOYN-NC279Sj73KwH32cGGg@mail.gmail.com>
 <ad19d283-aaab-41f1-b1a5-73de551b03a9@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <ad19d283-aaab-41f1-b1a5-73de551b03a9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-07-02 14:24 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
> On 2/7/26 03:32, Andrii Nakryiko wrote:
>> On Wed, Jul 1, 2026 at 9:49 AM Quentin Monnet <qmo@kernel.org> wrote:
>>>
>>> 2026-06-29 23:24 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
> [...]
>>>> @@ -254,6 +254,20 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>>>>       return NULL;
>>>>  }
>>>>
>>>> +static bool bpf_map_is_skel_data(const struct bpf_map *map)
>>>> +{
>>>> +     if (!bpf_map__is_internal(map))
>>>> +             return false;
>>>> +
>>>> +     if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
>>>> +             return true;
>>>> +
>>>> +     if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>>>> +             return true;
>>>> +
>>>> +     return false;
>>>> +}
>>>> +
>>>>  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>>>  {
>>>>       size_t tmp_sz;
>>>> @@ -263,7 +277,7 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>>>               return true;
>>>>       }
>>>>
>>>> -     if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>>>> +     if (!bpf_map_is_skel_data(map))
>>>>               return false;
>>>>
>>>>       if (!get_map_ident(map, buf, sz))
>>>
>>>
>>> Thanks! The bpftool patch looks good, with one reservation: after this
>>> patch, I believe "is_mmapable_map(map, ...)" will return true if map is
>>> a percpu map, although percpu maps aren't mmap-able, so we should
>>> probably update the name of that function to avoid any confusion?
>>>
>>
>> Great observation, Quentin!
>>
>> bpf_map_is_skel_data() I think was supposed to be exactly that generic
>> name. But it seems like Leon went half-way through with unification.
>> Unless there are some subtle situations where per-cpu array shouldn't
>> be handled where is_mmapable_map() is handled, we should rename
>> is_mmapable_map() and add BPF_MAP_TYPE_PERCPU_ARRAY check (assuming
>> it's internal map, of course) there.
>>
>> Leon, can you please check?
>>
> Aha, my bad.
> 
> Try to rename is_mmapable_map() to bpf_map_is_skel_data(). See below patch.
> 
> Thanks,
> Leon
> 
> ---
> 
> From 654306cd9091a175883dd61c7b251996c42e7cae Mon Sep 17 00:00:00 2001
> From: Leon Hwang <leon.hwang@linux.dev>
> Date: Mon, 29 Jun 2026 23:24:02 +0800
> Subject: [PATCH bpf-next v9 5/9] bpftool: Generate skeleton for global
> percpu
>  data
> 

[...]

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 6ae7262ebe0c..798a34366e08 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[...]

> @@ -254,7 +254,7 @@ static const struct btf_type
> *find_type_for_map(struct btf *btf, const char *map
>  	return NULL;
>  }
> 
> -static bool is_mmapable_map(const struct bpf_map *map, char *buf,
> size_t sz)
> +static bool bpf_map_is_skel_data(const struct bpf_map *map, char *buf,
> size_t sz)
>  {


Yes, I think it addresses the issue, thanks! I'd maybe drop the
"bpf_map_" prefix in the function name ("is_skel_data_map()" instead?)
to remain closer to is_mmapable_map(), and to avoid creating confusion
with libbpf functions names, although I don't feel strongly about it.
You can add my ACK to this v9 for the bpftool patch when you repost the
series.

Thanks,
Quentin
