Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C8188596;
	Wed, 24 Jun 2026 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274447; cv=none; b=MYIBILAYbC+0NJIBcDaAEl2OLya/cf+zgP+PsMKyBO/fHNm0r6yiuWqUy7K8pQ2KBjMQfFJJ2Q3wrNuFyLg/MD9h+/hAnEB6kwEMWCc7eaTS8elfit7zVomr87hF7oeln1hlp9R18pwEx3OmI6AAMUuac7x8yCGxxHUiWF5bJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274447; c=relaxed/simple;
	bh=shI45U5k8DJpYOiGtmgRaEjIeiPoC8jMTIMA+AF/vuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dI6ROpPphObLO8G8WEcjQiEJdVEd7BTKhc8bHccGeLOOPK3EYsby8KYI2hsQxHUb1foEkpw0tbcITweYh7s5HXZVseBeMZNFz61ifqblfb0fTDpY0KgZSGr/lzcBeuhTqfSn95edz7AExxyFPrhGqQ88nSgqHklNmfz1cr2x/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mqMKAvpK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mqMKAvpK"
Message-ID: <8f06ad4d-d003-4671-9dd4-24b5c7e4b806@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782274443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riE5H+St0lTuu2AM3VT264JvjK1KA8Ui+h2F+7yMouw=;
	b=mqMKAvpK8w6gHfHMAdS+/SiOcaCmZF2oB9uzC2z3SwzZoX4fTIm29e9K50r9W6u7T+5eBX
	MlCPLAzM+O9Y66R8CMqcAxypoJpCvhCeHoCWxCMKLvi8A0WpvtVSgrPyjtO69Hj//v5ehP
	dPLPBFkXWL1MFJWsQDOu9esVm1dOfNE=
Date: Wed, 24 Jun 2026 12:13:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 06/11] libbpf: Add support for global percpu
 data
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
 <20260622143557.22955-7-leon.hwang@linux.dev>
 <CAEf4BzZSeMSMnuYdLvEfb7-pmbthjU3J7W3QB4q9-WN_4+QrbA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZSeMSMnuYdLvEfb7-pmbthjU3J7W3QB4q9-WN_4+QrbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/6/26 06:45, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2026 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> @@ -5353,6 +5387,13 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>>                         return err;
>>                 }
>>                 map->mmaped = mmaped;
>> +       } else if (is_percpu) {
>> +               if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
>> +                       err = -errno;
>> +                       pr_warn("map '%s': failed to mprotect() contents: %s\n",
>> +                               bpf_map__name(map), errstr(err));
>> +                       return err;
>> +               }
> 
> hm... do we need to do this? what happens for LIBBPF_MAP_KCONFIG, do
> we just null out the initial image? should we just do that here?
> Basically what I am asking is how important it is to access initial
> per-CPU image after load? What's the realistic use case for that?
> 

This was suggested by you in v3:
https://lore.kernel.org/bpf/CAEf4BzY9KeVeo2+6Ht1v3rL6UdwNxABZCSK1OZ_sD8qhpYZaeQ@mail.gmail.com/

>>         } else if (map->mmaped) {
>>                 munmap(map->mmaped, mmap_sz);
>>                 map->mmaped = NULL;
>> @@ -10806,16 +10847,19 @@ int bpf_map__fd(const struct bpf_map *map)
>>
>>  static bool map_uses_real_name(const struct bpf_map *map)
>>  {
>> -       /* Since libbpf started to support custom .data.* and .rodata.* maps,
>> -        * their user-visible name differs from kernel-visible name. Users see
>> -        * such map's corresponding ELF section name as a map name.
>> -        * This check distinguishes .data/.rodata from .data.* and .rodata.*
>> -        * maps to know which name has to be returned to the user.
>> +       /*
>> +        * Since libbpf started to support custom .data.*, .rodata.* and
>> +        * .percpu.* maps, their user-visible name differs from
>> +        * kernel-visible name. Users see such map's corresponding ELF section
>> +        * name as a map name. This check distinguishes plain .data/.rodata/.percpu
>> +        * from .data.*, .rodata.* and .percpu.* to choose which name to return.
>>          */
>>         if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
>>                 return true;
>>         if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
>>                 return true;
>> +       if (map->libbpf_type == LIBBPF_MAP_PERCPU && strcmp(map->real_name, PERCPU_SEC) != 0)
>> +               return true;
> 
> um... this is extra logic for DATA/RODATA is supposed to be backwards
> compatible legacy stuff. We shouldn't need this for PERCPU_SEC. It
> should actually be called just ".percpu", not "<object_name>.percpu".
> 
Understand the backwards compatibility after reading the comment in
internal_map_name().

Will drop this hunk, and set "map->name" as ".percpu" in
bpf_object__init_internal_map().

Thanks,
Leon

