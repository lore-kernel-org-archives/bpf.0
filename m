Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398809;
	b=hYGoKZfr+HxF/z8uwVB9Y6sygDP7lzADjMRIRJ9ecJeT0trbflm53FVxn2R7kJAiU54u
	 ILNFqYm2M51NhVuRW8trCez3JdI4nbzywWtx2tmFVr+9A9z2FOTEmPwlfG5CarmFV62xd
	 CvnsGTbsNzoym1q9MRmAO7zNmGm4f9C5i4d7caO+QUvsjF5ZmpmYGhDsj9XB0RcRapryp
	 DU2L2vtdv1Sab9r/Z9YvIAAyaCoh5xBY7DHwJVQFj2bqbc/fPGawDi90O27ri+OuKpk6n
	 yamuHVmG9+Ai6sJQI2zzEFetchYGIRN1t3Sh5dw9LMde8hZ9B4R1YfE/mGmueC6GGyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=R9WkDjxK7zVEzCY4SXeBmf8ikp33jo06C8ygkpysgmA=;
	b=JFtUVy7LVHxpHUIG7Vv+qYoO7pLr2oTEqSrdZG+8fHVjxOWLQsUySOOi2KMOweT2iiXf
	 m0a4ypHHuPvt5g0bgJydOtGAUeMK0uFM3BE7N58BH7vjP3DBwxNQuwRekBOJZlHlC6r8/
	 4xEAA6Bi5tqnYrruROaqHu1WjiWZriqn1qJdt3QEEN+ppnHVcsxagNcK0EEocrV6iA0+F
	 cQmEPrfKs2G7koz9UDhg2qpU/NXbNShMFXXsR2C78h4ka6Hqxp+U7iSkg/Ipfdcuxvw81
	 TGlFSxvY691hPi3wkv+s1K/3TVgRaxQMvrGlAkH4bdbfJVhUUmoxaGYZkxy6qkteWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C50Qkv9V;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADF606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37ADF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C50Qkv9V
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so13740435e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793398807; x=1794003607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9WkDjxK7zVEzCY4SXeBmf8ikp33jo06C8ygkpysgmA=;
        b=C50Qkv9Vb8l6DqAkl984FSwFKYrACvgv5PfdgrD1yW/pzhPfAdQ6LaidNqZE70nHFf
         E2fTOyI5V6fZflAz9gecmboy9DvVnCrsYUA8kq+5NygNv/uCcu6HKtexi7QhsMWjWYi5
         aGlAuNVeOAWAnsuWN4kCffwXBaeGOiiS66Z9k5wtLRLHHu3oXjrurtS7AZTt/UxoHU87
         FQRTSQ8A+EqvLpznXZGOIP0QSJb8VjY/BqXqd2H0KDPxMs/s9Ap37DSCrnkGonZIobe3
         mHiLq7SxkAxAXw8OAMcdJMAeTpIgj7hvhd0w91U00lwrIgc/I0+AWO+D0jUzFElTTohS
         rPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793398807; x=1794003607;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9WkDjxK7zVEzCY4SXeBmf8ikp33jo06C8ygkpysgmA=;
        b=FCvnYB7cESKvPe1PhSLizOhaD55ZUP4YOqT/ePrsSv0e9DXvQQyaVNT6tmScJUfRZR
         RZxmhHM9a1lKMzsHIfiNycUAHSzae2HJi2x2GDbSkz9AoCFXbIM2jfiQ5YOjIM0RS4rh
         sge+2CNeyVHxC5e3b97FaK4l+HAxIarV4G25iYeWMTU7Y9X1psRJ2F6UiFQgyeE4ySRt
         YOH3UdMW+iQWPqf5hSmWvZ9UiYTl9jBD2tWonHWtuKWvhYcNoa2MZ+KvWywOyPi5/hXY
         voOskmd//tKvPHa6UZh6ySgDFWdMEU3xNnvnjODQWhr3RgxpMXvQuZOij6sbCETdjnj+
         v8Bg==
X-Gm-Message-State: AFq9FYJFYBUr5evQ8m8uuMOstoFVUtxlEvghk8bzaUSH9C75CVpB6pP6
	NVKNqnwgivjxdCigKg26aKH7topKKmmc7K9FuVNt9gjuqKnHM0BM/i0g
X-Gm-Gg: AYBFou2yMk9U/1Wf6Q94NUPP8/B9nDjWtyOVkzZ9GJiIH+qZx2OkZR/SsPFl3uQYy3t
	1i/a9Q3mGQ2DR0rwwyMdMhxoVlMSUWgWTFoL0ckaNin4fOp7V6LE6S1RIZAqQ/PzdzagE3cfNfl
	GU0ip/v7xyjgiV5NZ3RVX2sjMCDkrhl4Uikq2q1WJKlURtoDGtWL59DAe61JMsIJ30T1rasz16W
	QAAGzmyLryOwhRiQBSKMIvXjJ9tW8b10CnoxoybZNsIg8fvE0+7XWUxHlJJ7tzGkAGUAJQr/c9W
	mGmXnpl7/ByqvRkyne5pffMJDdk30PeVsMfnbnYrZREVyIdFSIASePD1bo6AT0hRqr+Ky9Gl+u6
	+P+4B4mxcKIbEIMIBxmtONXOUPz2SKWjnjjCpRY5I9Ck8RZCXxrNR22VDQ+kViJiIOf4xnGu/Gk
	TTRDvnsGhVTV9zPrSs5S8NOSXRU4TL/8AoN4E/0orY0J3EnoAEi0jCrp6aJDH+osjuhFeB/lvRX
	YnaDHy7GTG4NImjAG8YzewARD5BffQzyoZEiFUYuQMbyjXEsOakUhFqHsuSJyc8Rg7wCTYdk3K9
	XDwzhtihW0IZQz02PSZ3MoUeaCFXQKPwMRtQjpbNHIg47VeX0nRM2OI+6aCKZgNt2buG3Petk10
	bAOZvZgy7XA0aKA==
X-Received: by 2002:a05:600c:698d:b0:4a2:994:575c with SMTP id 5b1f17b1804b1-4ac185bcc4emr81753345e9.34.1793398807279;
        Fri, 30 Oct 2026 15:20:07 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm79094145e9.0.2026.10.30.15.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:20:06 -0700 (PDT)
Message-ID: <6cc98d17-f595-474d-af75-2162b4882fe8@gmail.com>
Date: Fri, 30 Oct 2026 22:20:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Check the strobemeta variable
 read instead of its location
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 vineet.gupta@linux.dev, Mykyta Yatsenko <yatsenko@meta.com>
References: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
 <20261029-bpf-selftests-branch-order-v1-1-425cc1ef8581@meta.com>
 <CAEf4Bzb-pLa8KSfc5VQJ3LnHvksTzwOgn6PY-xNq5k=zUPJyuw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bzb-pLa8KSfc5VQJ3LnHvksTzwOgn6PY-xNq5k=zUPJyuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/26 6:17 PM, Andrii Nakryiko wrote:
> On Thu, Oct 29, 2026 at 5:49 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> With an LLVM change that lets the BPF backend reorder conditional
>> branches [1], strobemeta and strobemeta_nounroll{1,2} hit the 1M
>> instruction limit. calc_location() is inlined, and the compiler copies
>> the "if (!location)" check after it into each of its return paths. When
>> a copy makes "variable missing" the fall-through, the verifier first
>> explores all later variables with an unchanged payload offset, and the
>> paths that read the variable, with wider offsets, can't be pruned.
>>
>> Check the bpf_probe_read_user() result instead. It fails for a NULL
>> location, so missing variables are still skipped, but the compiler
>> can't push the check into calc_location()'s paths. Mark the read
>> failures in read_map_var() unlikely so that the fully unrolled program
>> also keeps them off the fall-through.
>>
>> Verified insns/states, before -> after (fail: 1M insn limit):
>>
>>   current LLVM:
>>     strobemeta           v3   163591/4755 -> 170708/4780
>>     strobemeta           v4   157733/4779 -> 167288/4896
>>     strobemeta_nounroll1 v3    55975/1708 -> 50165/1617
>>     strobemeta_nounroll1 v4    50745/1728 -> 49286/1656
>>     strobemeta_nounroll2 v3   115445/4341 -> 116942/4267
>>     strobemeta_nounroll2 v4   108121/4306 -> 109775/4210
>>     strobemeta_subprogs  v3    53647/1611 -> 52413/1771
>>     strobemeta_subprogs  v4    51204/1573 -> 50749/1795
>>     strobemeta_bpf_loop  v3      2624/217 -> 2695/214
>>     strobemeta_bpf_loop  v4      2632/213 -> 2668/210
>>   patched LLVM [1]:
>>     strobemeta           v3   163591/4755 -> 170708/4780
>>     strobemeta           v4          fail -> 167813/4892
>>     strobemeta_nounroll1 v3          fail -> 51250/1755
>>     strobemeta_nounroll1 v4          fail -> 47480/1796
>>     strobemeta_nounroll2 v3          fail -> 121092/3969
>>     strobemeta_nounroll2 v4          fail -> 117302/3708
>>     strobemeta_subprogs  v3    49653/1693 -> 51831/1548
>>     strobemeta_subprogs  v4    48305/1649 -> 44104/1577
>>     strobemeta_bpf_loop  v3      5017/398 -> 2815/225
>>     strobemeta_bpf_loop  v4      5053/394 -> 2792/221
>>
>> [1] https://github.com/llvm/llvm-project/pull/236189
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/testing/selftests/bpf/progs/strobemeta.h | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
>> index 6e1918deaf26..584a68248764 100644
>> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
>> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
>> @@ -366,10 +366,9 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
>>
>>         data->str_lens[idx] = 0;
>>         location = calc_location(&cfg->str_locs[idx], tls_base);
>> -       if (!location)
>> +       if (bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location))
>>                 return 0;
>>
>> -       bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
>>         len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
>>         /*
>>          * if bpf_probe_read_user_str returns error (<0), due to casting to
>> @@ -400,11 +399,10 @@ static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
>>         descr->cnt = -1; /* presume no value is set */
>>
>>         location = calc_location(&cfg->map_locs[idx], tls_base);
>> -       if (!location)
>> +       if (unlikely(bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location)))
>>                 return off;
>>
>> -       bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
>> -       if (bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr))
>> +       if (unlikely(bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr)))
> 
> just off-topic, but it would be interesting to experiment with just
> marking all/most error-returning BPF helpers (or at least all the
> unsafe memory read ones) as unlikely-to-err-by-default, because that's
> really what is expected. Not sure if we have clean way (though we can
> do that in bpf_helper_defs.h for sure at codegen time). Can you run
> your comparison scripts with such change before/after?
> 
Clean bpf-next (without this patch), verifier insns without → with hints:
┌──────────────────────┬─────────────────┬─────────────────┬───────────────────┬───────────────────┐
│       Program        │   Old LLVM v3   │   Old LLVM v4   │    New LLVM v3    │    New LLVM v4    │
├──────────────────────┼─────────────────┼─────────────────┼───────────────────┼───────────────────┤
│ strobemeta           │ 163.6K → 172.5K │ 157.7K → 156.7K │ 163.6K → 172.5K   │ 1M fail → 1M fail │
├──────────────────────┼─────────────────┼─────────────────┼───────────────────┼───────────────────┤
│ strobemeta_nounroll1 │ 56.0K → 41.6K   │ 50.7K → 43.5K   │ 1M fail → 1M fail │ 1M fail → 1M fail │
├──────────────────────┼─────────────────┼─────────────────┼───────────────────┼───────────────────┤
│ strobemeta_nounroll2 │ 115.4K → 115.2K │ 108.1K → 102.0K │ 1M fail → 1M fail │ 1M fail → 1M fail │
├──────────────────────┼─────────────────┼─────────────────┼───────────────────┼───────────────────┤
│ strobemeta_subprogs  │ 53.6K → 58.1K   │ 51.2K → 52.1K   │ 49.7K → 53.3K     │ 48.3K → 48.8K     │
├──────────────────────┼─────────────────┼─────────────────┼───────────────────┼───────────────────┤
│ strobemeta_bpf_loop  │ 2.6K → 2.7K     │ 2.6K → 2.7K     │ 5.0K → 4.1K       │ 5.1K → 4.1K       │
└──────────────────────┴─────────────────┴─────────────────┴───────────────────┴───────────────────┘

With this patch:
┌──────────────────────┬─────────────────┬─────────────────┬─────────────────┬─────────────────┐
│       Program        │   Old LLVM v3   │   Old LLVM v4   │   New LLVM v3   │   New LLVM v4   │
├──────────────────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┤
│ strobemeta           │ 169.1K → 168.7K │ 167.3K → 173.3K │ 169.1K → 168.7K │ 167.8K → 173.5K │
├──────────────────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┤
│ strobemeta_nounroll1 │ 49.7K → 46.6K   │ 48.8K → 45.1K   │ 50.3K → 56.3K   │ 47.0K → 51.1K   │
├──────────────────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┤
│ strobemeta_nounroll2 │ 116.5K → 117.5K │ 109.3K → 104.4K │ 120.2K → 119.2K │ 116.9K → 107.5K │
├──────────────────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┤
│ strobemeta_subprogs  │ 52.0K → 49.4K   │ 50.3K → 45.3K   │ 51.5K → 55.0K   │ 43.8K → 49.0K   │
├──────────────────────┼─────────────────┼─────────────────┼─────────────────┼─────────────────┤
│ strobemeta_bpf_loop  │ 2.7K → 2.7K     │ 2.7K → 2.8K     │ 2.8K → 2.8K     │ 2.8K → 2.9K     │
└──────────────────────┴─────────────────┴─────────────────┴─────────────────┴─────────────────┘
>>                 return off;
>>
>>         descr->id = map.id;
>>
>> --
>> 2.53.0-Meta
>>

