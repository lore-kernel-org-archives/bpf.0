Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99D539A
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289374; cv=none; b=t/Vl37bJnXrs/RQLiw8NyEuh4rmhY7JjvUZReNGR44/Y28Lboga/xm25V02tbKb9aWCcAK3imFKgqbTFOiHuiEn6un+q1pE3bkqRpR5rWTzzPDrG/hTbf3Hin7oBEv5Qzu03WMk/JPsZT2iLrxbd6HhgL7UNeP98aMBB/OwZMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289374; c=relaxed/simple;
	bh=a08+2oK0pIyjea5MKzti64/XMbKVsSIzXKAfBYQfgms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cltJ7uMbbCgjzDcwwaEaXCl1XWCXZfOQz9ddVecqxuJmiofa61lewlU139nCvF2VP5+hJm/xH48KJ7UqT4hjrHmRu6EN7uaedAFvZRgYmNAWwLdgGoQGYG6/7HYQsvtYVtDe18gLcxxMx40HotezlHiGAI25kClXG/6Sv+oHUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUU2/EDs; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUU2/EDs"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4610702276.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710289371; x=1710894171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1ZApm5nPUPnbw+6WJcZXfj3XBeUCMhW3uLof9a8L7M=;
        b=bUU2/EDsGHXpXgsg6OfJDcvby0KwUjFy/htUxyb0Od5iima8R/XuZ5wi0jufT8Mf1r
         MTyFjvD9BoIndDLZXVwlvWZx3GhKLCwF6Be1GMdFuwTDE8c8V0U+TTTXPQ2QXl39dic9
         3bC4VzQEXLVTpHvDp0NIlVKzoqXA15ab7sD462bTRliWoNbLX4TaFX1jUAMMk5JNuf7n
         X3L+qtoO6HGYwtYkkR/B2In+Kx5dsHxVOwSgt0WxtMKKhkNHrXVPmIZSUWBgWAEA+QqF
         dr3aYb5XjE1rfLtzSKwpSva2lrth9Yx+64xZ2DjihWT7XLBmqvdsflqdPqms429pzmSg
         Yojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710289371; x=1710894171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ZApm5nPUPnbw+6WJcZXfj3XBeUCMhW3uLof9a8L7M=;
        b=uB7qu/OD8G81S/+mLNcr29QyfwcUTuSlhkxKHea8/Q/5C64baenCWP09OygJiKbmw/
         dTJAl6shtmPZqHJdkFQYHBVsorqeuC54pkQj7E1w7BZWnqWFEMuEj1xuVU9N3dkPMX6C
         HBR/zzT1yAG6cHEqjnEXnxghFfHAj7JZQ2PqeOT1LXUR8eQpxZYB7Sb5h5rlOgILBfSH
         MGO34kJWn3h837HIzVFypxemv3gnYKMczuDvU5qqC8TvE6Kefsx5DkbAFjwAIigtQSqv
         nCY2ru6Gmm5HnXXBm5rrv/M0I4KS/DRYh9ky6yOQrAHZkCPm5Hf1te5q0S7/y5FGOzzu
         ztKg==
X-Gm-Message-State: AOJu0YzQSZwaZ+JKvXWRJjwzoRqK7X7LPq+SF2XayQMrO4eT+oNmTTB+
	mET7dh8IbCi9YjWrR4MTc/6Fwmg7FhZHygbhHCx9iqtCdJovXZRHKif8+9gD
X-Google-Smtp-Source: AGHT+IFZuM9lt4rRxsIbVRpapQibjI4m+vUeYhsVsacmEaO6RRqfjpV/KyAngiH+67E5Jbf7oRYNQA==
X-Received: by 2002:a25:ace0:0:b0:dc7:45f4:44f7 with SMTP id x32-20020a25ace0000000b00dc745f444f7mr956628ybd.14.1710289371308;
        Tue, 12 Mar 2024 17:22:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a9ce:8a39:867c:8f30? ([2600:1700:6cf8:1240:a9ce:8a39:867c:8f30])
        by smtp.gmail.com with ESMTPSA id s15-20020a25aa0f000000b00dcda3959006sm2014037ybi.33.2024.03.12.17.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 17:22:50 -0700 (PDT)
Message-ID: <2741a905-8cdf-413b-a4ed-74b6e206c96f@gmail.com>
Date: Tue, 12 Mar 2024 17:22:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: Skip zeroed or null fields if not
 found in the kernel type.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240312183245.341141-1-thinker.li@gmail.com>
 <20240312183245.341141-2-thinker.li@gmail.com>
 <CAEf4BzZMt+7AhY9aC7aTC=Fd_=10kFxNmRXuQMn_Lp2VNFRhBw@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZMt+7AhY9aC7aTC=Fd_=10kFxNmRXuQMn_Lp2VNFRhBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/12/24 16:01, Andrii Nakryiko wrote:
> On Tue, Mar 12, 2024 at 11:32 AM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Accept additional fields of a struct_ops type with all zero values even if
>> these fields are not in the corresponding type in the kernel. This provides
>> a way to be backward compatible. User space programs can use the same map
>> on a machine running an old kernel by clearing fields that do not exist in
>> the kernel.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 30 +++++++++++++++++++++++-------
>>   1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index efab29b8935b..715879796046 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1131,11 +1131,33 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>>                  __u32 kern_member_idx;
>>                  const char *mname;
>>
>> +               mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
> 
> you don't need to move this up here, btf__resolve_size() can skip
> modifiers and typedefs just fine, so let's keep this one below and
> just pass member->type to btf__resolve_size()

Ok!

> 
>>                  mname = btf__name_by_offset(btf, member->name_off);
>> +               moff = member->offset / 8;
>> +               mdata = data + moff;
>> +               msize = btf__resolve_size(btf, mtype_id);
>> +               if (msize < 0) {
>> +                       pr_warn("struct_ops init_kern %s: fails to resolve the size of member %s\n",
> 
> s/fails/failed/
> 
>> +                               map->name, mname);
>> +                       return msize;
>> +               }
>> +
>>                  kern_member = find_member_by_name(kern_btf, kern_type, mname);
>>                  if (!kern_member) {
>>                          pr_warn("struct_ops init_kern %s: Cannot find member %s in kernel BTF\n",
>>                                  map->name, mname);
>> +
>> +                       /* Skip all zeros or null fields if they are not
>> +                        * presented in the kernel BTF.
>> +                        */
>> +                       if (btf_is_ptr(mtype)) {
>> +                               if (!st_ops->progs[i])
>> +                                       continue;
> 
> so, this is both unnecessary to check for NULL (libbpf_is_mem_zeroed
> will do it just fine for pointers as well), but it's also wrong
> because user could have set this program pointer through skeleton's
> shadow type, while here you won't yet see. So let's drop this
> btf_is_ptr() special case, and just do generic libbpf_is_mem_zeroed()
> check

You are right! I will fix it.

> 
>> +                       } else {
>> +                               if (libbpf_is_mem_zeroed(mdata, msize))
>> +                                       continue;
> 
> I think it's worth emitting informational message here, something like
> 
> pr_info("struct_ops %s: member %s not found in kernel, skipping it as
> it's set to zero\n", ...")
> 
> ?
> 
> and move that pr_warn("Cannot find member %s in kernel BTF") after
> this check, so we don't have scary-looking error-level message

Sure!

> 
>> +                       }
>> +
>>                          return -ENOTSUP;
>>                  }
>>
>> @@ -1147,13 +1169,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>>                          return -ENOTSUP;
>>                  }
>>
>> -               moff = member->offset / 8;
>>                  kern_moff = kern_member->offset / 8;
>> -
>> -               mdata = data + moff;
>>                  kern_mdata = kern_data + kern_moff;
>> -
>> -               mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
>>                  kern_mtype = skip_mods_and_typedefs(kern_btf, kern_member->type,
>>                                                      &kern_mtype_id);
>>                  if (BTF_INFO_KIND(mtype->info) !=
>> @@ -1230,9 +1247,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>>                          continue;
>>                  }
>>
>> -               msize = btf__resolve_size(btf, mtype_id);
>>                  kern_msize = btf__resolve_size(kern_btf, kern_mtype_id);
>> -               if (msize < 0 || kern_msize < 0 || msize != kern_msize) {
>> +               if (kern_msize < 0 || msize != kern_msize) {
>>                          pr_warn("struct_ops init_kern %s: Error in size of member %s: %zd != %zd(kernel)\n",
>>                                  map->name, mname, (ssize_t)msize,
>>                                  (ssize_t)kern_msize);
>> --
>> 2.34.1
>>
