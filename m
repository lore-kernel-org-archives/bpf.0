Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7CAD56
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710290265; cv=none; b=PVr8RzdH3CnZVJSgx34ion9m0cD6TV3X7PkvYmT9fMZwmDr6YeN+g0Tv+VT1eHgdO9nl3HXlW4kdWJ6+MDY6QlCAIsZXkJK3aQZBDbBID8SdLecCoANacxrSADGKP2jHblMFOYOLiHqEoUSQJRPlTdSvkkM9D7uECrNcXnrBIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710290265; c=relaxed/simple;
	bh=jQbSC2to3OpEzuIQCBXW+fHsipl42EXhqgxTFUv4Qsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKyAuQC3IY1y5WCymPdT93mLcWeSKvu2CzclTKvsju6h/uxQoiBVUnU5BtoKKBL6UoIl0BX2I/G1S1AVGGRvHyckI17gAbkwTxHfYi64nQy0+Wd5H1fECIV/k/6ksb/BWRMrZ44808RQWnA/3WpyX0SxHNQ6CI9oL2XWYF1K29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrO5XJHG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrO5XJHG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a046c5262so43801347b3.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710290262; x=1710895062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izmjylfwlXFVHsgqz3D2FGXONCl81RbwzBZ4OzLO3hE=;
        b=SrO5XJHGgIEWeR7g2pjXa8agp735+KvMmTwqIBILj8HQ0+wqeMrq4YSUy0JX1dLwcN
         yNFiuHFxGmvt1xIcML/MsrsGdlbrdZtpNIcxCfY89wSJb5z2VQS7ejZ8s7rEu8viVrcq
         WozZrWTsRatCLMvlkzhBbPZyF8LW/+bKLAU0bdMl9vbpr5Dfsx1XhmwqjirNRWvTl1m6
         LM1x/KmV5mauQ70RKlC40ow0jWufJDx83alFijUuazaIQ0E8Ol2VwGkfS3sSYgHH9W32
         EEmFCfskuTfxjeQoT/lEyIXhormjXCv7EYy0qYJs/KyZwKIqPRSWrdBKg5zUlx7c+rz9
         CoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710290262; x=1710895062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izmjylfwlXFVHsgqz3D2FGXONCl81RbwzBZ4OzLO3hE=;
        b=H6nprZdNv5DxDwrVpPkvD9UzqCfjJ097yBxIp2vw6pXRG3FTeoX/QbelY9LMdQYYv2
         qW2B6qmTQSdqOs6eSYZ2PNSlWmjmb/CCovkMBiwUiozFYTbWD+XrqMJRK4I3chPpJOcy
         VU28nLiyozDRXzKn4E1Jhzs6/tLxW9Z0mVbxJWWuoMVXUCktzNrpygmDKu3cJ7CG/clA
         MaRVtw0QB1wGFbs3zdP88iMEcFSFD+pNkj9WfK7DZA1qMXiWdayO3JN6OuiDG21pJVLl
         OYO3FK/f+P3TSnKtGJKbSJel+w1PbRByn2zRSBDVUfoKKiWajScJynI1QzYYbPjCil9J
         2SuA==
X-Forwarded-Encrypted: i=1; AJvYcCUro8P9WEa6YFWgI+qH9m9txa7aH7n8dlb73XxgmVE5mR4x4YdYOTRu3Ork/n+25T3EHQChbmsfjFwYS9IKFcibZRKD
X-Gm-Message-State: AOJu0YzP9iJd6P3VJMfOG40pot3a4ap6GQUNtCCa01siA3KfaI5fZmvr
	hhdyR4W76WuRz3cgR9r5YBf4nklWDM9LmDJnA+cfOkMtQtNG1Yfmiru9wqCU
X-Google-Smtp-Source: AGHT+IHscejJHDo+JIWxg2SoiQiJtHJeKhVX2Ru28fN0mXvKSTk745efqJV08JkAt8gWHMGW/ZA09A==
X-Received: by 2002:a0d:e9c6:0:b0:609:8ed6:c491 with SMTP id s189-20020a0de9c6000000b006098ed6c491mr1061416ywe.26.1710290262201;
        Tue, 12 Mar 2024 17:37:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a9ce:8a39:867c:8f30? ([2600:1700:6cf8:1240:a9ce:8a39:867c:8f30])
        by smtp.gmail.com with ESMTPSA id r187-20020a0de8c4000000b0060a304ca3f4sm1601526ywe.19.2024.03.12.17.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 17:37:41 -0700 (PDT)
Message-ID: <b81c0d46-d817-4a7d-a1c4-c6de707fbe7b@gmail.com>
Date: Tue, 12 Mar 2024 17:37:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types
 explicitly.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, kuifeng@meta.com, yhs@meta.com
References: <20240312013726.1780720-1-thinker.li@gmail.com>
 <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com>
 <c1781093-69fe-4760-9df5-8ae71a3ecd05@gmail.com>
 <CAEf4Bzb8ft68Ue-=2pQBGySbjpE2cgPvtDJaec3F-NyE_tTB5Q@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4Bzb8ft68Ue-=2pQBGySbjpE2cgPvtDJaec3F-NyE_tTB5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/12/24 17:27, Andrii Nakryiko wrote:
> On Tue, Mar 12, 2024 at 5:08 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 3/12/24 15:47, Andrii Nakryiko wrote:
>>> On Mon, Mar 11, 2024 at 6:38 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>
>>>> According to a report, skeletons fail to assign shadow pointers when being
>>>> compiled with C++ programs. Unlike C doing implicit casting for void
>>>> pointers, C++ requires an explicit casting.
>>>>
>>>> To support C++, we do explicit casting for each shadow pointer.
>>>>
>>>> Cc: yhs@meta.com
>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>>> ---
>>>>    tools/bpf/bpftool/gen.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>>>> index 4fa4ade1ce74..dedafea0c127 100644
>>>> --- a/tools/bpf/bpftool/gen.c
>>>> +++ b/tools/bpf/bpftool/gen.c
>>>> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
>>>>                           continue;
>>>>                   codegen("\
>>>>                           \n\
>>>> -                               obj->struct_ops.%1$s = bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
>>>> +                               obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
>>>
>>> Given we have a named struct type for this and we use explicit type
>>> names in other parts of generated skeleton code, let's maybe use
>>> "struct %s__%s__%s" explicitly here (passing in obj_name, ident,
>>> type_name)?
>>
>> I have considered about this solution. But, C++ works differently. It
>> has nested namespaces. That means it should be referred as
>> "XXX_skeleton::OOO_st_ops_map" in C++. Then, we need #if #else #endif
>> directives to provide two separated casting.
>>
> 
> we cast to (struct <skeleton> *) by name of the skeleton, so it should
> be fine, I don't see why we'd need to do something C++ specific here

The skeleton looks like

struct struct_ops_module {
     ......
     struct {
         struct 
struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed {
             ....
         } testmod_zeroed;
     } struct_ops;
};

struct struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed is
inside of struct struct_ops_module. In C++, it should be referred as
"struct_ops_module::struct_ops_module__testmod_zeroed__bpf_testmod_ops___zeroed".

The other option is moving definitions of these types to the top scope.

> 
>>>
>>> No strong preferences, but feels like a consistent approach here would be nice.
>>>
>>>>                           \n\
>>>>                           ", ident);
>>>>           }
>>>> --
>>>> 2.34.1
>>>>
