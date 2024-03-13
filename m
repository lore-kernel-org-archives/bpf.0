Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46936383
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710288482; cv=none; b=KRVqJuaxef5pxRw2HoYuEUCPoeocehgQJIX2CCGUA9q4C5KqVIqlBcpteCENq0jzIogSjec0tHKu4WqIRIvO9Fd2iWe/18LYoSLggMydtUPz6q9E1MOYPKx6jfQh4LEXiwIsLmXM2ssz5yTUbA3/Lw7zs6kbXP0Sfe6SKA6beiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710288482; c=relaxed/simple;
	bh=BwZK3826nB0YiPkdOeaJmW9msF+g0Qq6mhi/x9l3hqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLwWbV/O9jhR8eM+i74SHQC4M39dxFja3cdCTujvVnQ5axhdGKqQZw4PLJEAuS0qGIQSA0kJOzTA04Ej1bNgM1sN1tt+Kvha2va4ZLuaMzT7A/FObVPSOi0WfgBghJgsUkzkomLfLJ6zD5L6R0ThE1+l5UlYLDGbOx7q/0kS2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzkNpD/Q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzkNpD/Q"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a0579a931so43754047b3.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710288480; x=1710893280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfIojvYss+Rm+8LApXTk+do/kr/ffLe1MyG/ZYjA2XQ=;
        b=VzkNpD/QAxXh4K8EkCpl8Fx1hvv2kE8wtyauJVP2HIIVH+Qnt0bdac0/Bp98uBceN3
         uRPkIn+LBGSWHXAiZMyiUd1LoDO7Irqyg9Id63NVib5ims2moXxwMEhZhJ+/3q7wlRAU
         FMMp8Gg7vGwnJZkzqJumePGoJzqavsIGqALG++O7txj3vDwa3johyRyWGSW6zoXtaBaC
         BpYIk3kvjnFZUJZKpSZW0Zbw7jyplX8Gf35CPXXiJFQ2eLTmQ3r5cl++1RFoJBNMYXn0
         dHxGnAIs5VgFjnfU3wLIOIu6mJLQw43B3feZbTozneen+Y0bS9FsfmRpCUfaqUgi6wSl
         oWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710288480; x=1710893280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfIojvYss+Rm+8LApXTk+do/kr/ffLe1MyG/ZYjA2XQ=;
        b=pZqxfFN+I3U5Om46ON7y76BrsF5ZNVY+TcBbWWPmso3EPJBRfI7hwBN/YcY/PsUqlG
         +Yfyrlz5ImBKygPVRheKp3ysXkpQ2uDLdJeQCl5hpDovWZhW7jW+Jr2paiuGqGv+neUn
         bv+KonVgLCeXXAM0agNO0tFfMpNnP3ohBNBpMoEkXN1UWL/yyyj4yvZoEeX3niddnEZV
         NdQVo2S2uJ1uwBtkrYBVYvZX0zUWNb0b1AVMiy+pktD08woD230GxvcD6kVC3PGsTZ4t
         12djYnSMmkLs3sBU2l7x8zg7geohI/P8R2MeYtcw4aubqhqDPxxqgCfKswvsCdOQEMtQ
         jRgg==
X-Gm-Message-State: AOJu0YxJdm2d+InyMehIO2NgE0Umy4e4OBqe3+rjw/XT90OAndfE+4CS
	+GEIGiBOK/Xxh1FwstZpBfFDwbrizTSYlgT4lLc0okcnTLqNQVjZ
X-Google-Smtp-Source: AGHT+IFfWRiTcQ3OEuy06FwHIG7QfIMvT/qUJ7X+EAjWT18/sdpc1HQFkbcjGHsrjBqY5avH93l4Aw==
X-Received: by 2002:a0d:dbc3:0:b0:609:f87b:aad3 with SMTP id d186-20020a0ddbc3000000b00609f87baad3mr1027621ywe.31.1710288480132;
        Tue, 12 Mar 2024 17:08:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a9ce:8a39:867c:8f30? ([2600:1700:6cf8:1240:a9ce:8a39:867c:8f30])
        by smtp.gmail.com with ESMTPSA id l31-20020a81ad1f000000b0060a3ac68cfasm1415771ywh.61.2024.03.12.17.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 17:07:59 -0700 (PDT)
Message-ID: <c1781093-69fe-4760-9df5-8ae71a3ecd05@gmail.com>
Date: Tue, 12 Mar 2024 17:07:58 -0700
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com,
 yhs@meta.com
References: <20240312013726.1780720-1-thinker.li@gmail.com>
 <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZafCA3gQVgmL1-OnpcWPXNJZ8iXgdaH82gAvu5TEOVEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/12/24 15:47, Andrii Nakryiko wrote:
> On Mon, Mar 11, 2024 at 6:38 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> According to a report, skeletons fail to assign shadow pointers when being
>> compiled with C++ programs. Unlike C doing implicit casting for void
>> pointers, C++ requires an explicit casting.
>>
>> To support C++, we do explicit casting for each shadow pointer.
>>
>> Cc: yhs@meta.com
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/bpf/bpftool/gen.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 4fa4ade1ce74..dedafea0c127 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
>>                          continue;
>>                  codegen("\
>>                          \n\
>> -                               obj->struct_ops.%1$s = bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
>> +                               obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
> 
> Given we have a named struct type for this and we use explicit type
> names in other parts of generated skeleton code, let's maybe use
> "struct %s__%s__%s" explicitly here (passing in obj_name, ident,
> type_name)?

I have considered about this solution. But, C++ works differently. It
has nested namespaces. That means it should be referred as
"XXX_skeleton::OOO_st_ops_map" in C++. Then, we need #if #else #endif
directives to provide two separated casting.

> 
> No strong preferences, but feels like a consistent approach here would be nice.
> 
>>                          \n\
>>                          ", ident);
>>          }
>> --
>> 2.34.1
>>
