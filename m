Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05C36A367
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274515; cv=none; b=oa0DFCq5gaqeTQFUM0Mpd5LKstp7//gS4XrEHoo5UhjWx47xBWTkJnmRQ7LLmytl2HR3IpFPrEqavFZAYtDRXWzH2gNQZU1q7i/lIVASsTmQz1nDsDBVnBxZ970dOGdTvLkM8VZeTo0bu1cwhrTiOXTYABg7RxrhPmbKYKeyFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274515; c=relaxed/simple;
	bh=IDxkR+vaILTYtVqrPKu0ZrhyDH18UialZZyeTBRzYbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+/rvb7rAi51kTJE3A2VLvpKsDphOBk5yjBDdJEyAkboMLdi1HbKETNVw6iUuVGEZz04xYDqf/7eTUHwSConOw0WRAKqjLHfU13RY6WAxR6avwC1X5s2wRjMw2Gty2xHeSjKsobDUp9Sr8bDJFT3kf2Be2ToiUvi1iEjN7g1hnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ecTCSrIA; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ecTCSrIA"
Message-ID: <2330e6a8-c7eb-4296-8aa0-feaafd6b09cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782274512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0x6L2Zo6DktqwkKOdSMACPg1g238LwJEMYtkjVesL0=;
	b=ecTCSrIAJ5xutT2UoXrwCSWuJthMrRYZ7FlV0+7Ed8gFZFxNQ4wb/Rtqcc+qGVj4iovDPD
	DCPeHuwco1LYSXFMgl5Cp5yFMJGxG/+eocbMSaa1QTV2FR2kWYM01iyUzrx5nuVFQXpEjX
	6lGXRD9C+A1mLHF/VVlaJcWoRdfSCEs=
Date: Wed, 24 Jun 2026 12:15:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 07/11] bpftool: Generate skeleton for global
 percpu data
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
 <20260622143557.22955-8-leon.hwang@linux.dev>
 <CAEf4Bzay2Wssj1J4fEq3T7iTOBDswEZunm1OQNDJvPr2Cz2Usg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzay2Wssj1J4fEq3T7iTOBDswEZunm1OQNDJvPr2Cz2Usg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/6/26 06:46, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2026 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> @@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>                 return true;
>>         }
>>
>> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> -               return false;
>> -
>> -       if (!get_map_ident(map, buf, sz))
>> -               return false;
>> +       if (bpf_map__is_internal(map) &&
>> +           ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)) &&
>> +           get_map_ident(map, buf, sz))
>> +               return true;
>>
> 
> just add `if (bpf_map_is_percpu_data(map) return true;`? maybe also
> move get_map_ident check a bit earlier. I think that will be a bit
> cleaner, this condition is quite hard to follow
> 

Makes sense.

With adding the helper bpf_map_is_skel_data(), will this change looks
more readable?


+static bool bpf_map_is_skel_data(const struct bpf_map *map)
+{
+       return bpf_map__is_internal(map) &&
+               ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
+                bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY);
+}
+
 static bool is_mmapable_map(const struct bpf_map *map, char *buf,
size_t sz)
 {
        size_t tmp_sz;
@@ -263,7 +274,7 @@ static bool is_mmapable_map(const struct bpf_map
*map, char *buf, size_t sz)
                return true;
        }

-       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) &
BPF_F_MMAPABLE))
+       if (!bpf_map_is_skel_data(map))
                return false;

        if (!get_map_ident(map, buf, sz))


>> -       return true;
>> +       return false;
>>  }
>>
>>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>> @@ -343,6 +347,9 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
>>                 if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>>                         continue;
>>
>> +               if (bpf_map_is_percpu_data(map))
>> +                       continue;
>> +
>>                 sec = find_type_for_map(btf, map_ident);
>>                 if (!sec)
>>                         continue;
>> @@ -669,7 +676,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>>                 if (!get_map_ident(map, ident, sizeof(ident)))
>>                         continue;
>>                 if (bpf_map__is_internal(map) &&
>> -                   (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> +                   ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)))
> 
> also we can add a helper to check if it's an internal map with a
> dedicated data section in the skeleton (too lazy to think of a good
> name right now.. ;)
> 

How about bpf_map_is_skel_data()?

Then, this 'if' will be updated as 'if (bpf_map_is_skel_data(map))'.

Thanks,
Leon

>>                         printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
>>                                ident, bpf_map_mmap_sz(map));
>>                 codegen("\
> 
> [...]

