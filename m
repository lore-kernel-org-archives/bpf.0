Received: from mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923E3D45E7
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673011; cv=none; b=W2aUnZi1YQmjxlyk3gBNLayz0FXfcO8lRfkltfAsQHgTIwWIzsAV2KGjwJxW86dW86Lanlblj3MvrF3V1hz5Fw+EnUfEv4qjM6xs+3sKv/Ah54ZShToyemWE3qMZrBBvW/sodur8ieHINEKp0qlSkp2qd+MKmKfTF8XHL5k2yVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673011; c=relaxed/simple;
	bh=878j+ctgMEB86p2DNQyrmunkQkLnffVOtomiScksspo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjPRZ9fgMmVUYDMUTQVUIU6zSUsWT07kmUnTvFPmLtMBetWf/gyoAgbt0NBbdfHoIpb0ic7qnqjxAnU5LvxidLPo5EkL3LoCDdboMW9B4faYndtaGpb5MKticd3+m26CvY3MPgBkIQFWHfAlGdf2HOR7G1ePQZKtonkBN0dgPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N9cLR2Hj; arc=none smtp.client-ip=95.215.58.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N9cLR2Hj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=878j+ctgMEB86p2DNQyrmunkQkLnffVOtomiScksspo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786673007; v=1; x=1787277807;
 b=N9cLR2HjXolGrQY/mQABBFoGZlwrSkzn8AMDvqr9UxR5utCVUMqanc7O5jBzfF3MLFAnnaFm
 wneUr4row5RLj2GeqoIm8NfKFi6lRV9eTQVrmJ9BA2Nnz7KFtRVO0ZvXEcJapUEPHPAehXBLmdJ
 J9IJIhrAEd6GjGFW0zBKS7sk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 806a42f4d3b008ca;
	Fri, 14 Aug 2026 02:03:27 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <965e536c-bd5c-4f63-8021-8b07e0aee231@linux.dev>
Date: Fri, 14 Aug 2026 10:03:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 06/10] bpftool: Generate skeleton for global
 percpu data
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
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-7-leon.hwang@linux.dev>
 <CAEf4BzYRqZ--=5d2LBWA=mOL72CYe4y4iCGS3c5Dw8PEd9BOiA@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYRqZ--=5d2LBWA=mOL72CYe4y4iCGS3c5Dw8PEd9BOiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/8/26 01:56, Andrii Nakryiko wrote:
> On Thu, Aug 13, 2026 at 8:24 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> @@ -263,13 +269,24 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>                 return true;
>>         }
>>
>> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> +       if (!bpf_map__is_internal(map))
>>                 return false;
>>
>>         if (!get_map_ident(map, buf, sz))
>>                 return false;
>>
>> -       return true;
>> +       if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
>> +               return true;
>> +
>> +       if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>> +               return bpf_map__btf_value_type_id(map) != 0;
> 
> why do we need this btf_value_type_id() check? in what case it's
> expected that there will be no BTF info set?

Add this check by referencing btf_value_type_id check in libbpf's
map_is_mmapable(). That said, if btf_value_type_id is 0 for
global/percpu data, is_mmapable_map() should return false for them.

And, if the bpf obj is compiled without -g, this check helps to avoid
generating struct for percpu data explicitly.

Thanks,
Leon

> 
>> +
>> +       return false;
>> +}
>> +
>> +static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>> +{
>> +       return is_skel_data(map, buf, sz) && bpf_map__type(map) != BPF_MAP_TYPE_PERCPU_ARRAY;
>>  }
>>
> 
> [...]

