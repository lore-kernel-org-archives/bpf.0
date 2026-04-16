Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863430B50F
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352244; cv=none; b=SspST9t3nEq0eLVW4ivu+TzJHkpu/XvenP4qam/mB1dk0mCzjqpJSjPMZVuuVH6Pe4hLl07oFiTRTYOH0DFvda5B90AJHaQgQSxUxzQwag3supFt4v9EUIZhX6ILPjRNPBEDUxsCPnxLUzZZwY0eWrtHsRidAjsQ8oNIgG0fnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352244; c=relaxed/simple;
	bh=FabwtCfkDtED6szuMI628+wsjKHDyuxoB7aLvTS8BJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS15FNv3YqPaN+qJBLEXpH37/a3oEyzw3A3BvmO+aMkOCFjvunM2JovPduF7w1qBBPopP4c1t9COri5vk62T/l8KUCg6EsZncq6oNcscZe7ZGi51t6CKBBXDtHGTNmShraxlQoY8CGCUt6yGhxE7yrlqLVrXxWlj5FDuW6MzaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF+GTLj7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF+GTLj7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so97379415e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352241; x=1776957041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+yFelEhnCKgW95BCsCvZrDElWlGNwzHzfghcF73FkQ=;
        b=DF+GTLj7CfBxXvQmadU0Nx9J1MpEShnDUik+Y2mFmTyjQUv/ToZUz9qtxOqPoQVCMY
         ouXe1nCP9TmaZSyR7pQ01FqkcPcIqPkOCMS3/Q8tiWNI6XKxNZzpUsDsfiQAhD1UVRjw
         SPyyA1KMgJAGFoAVadvULR0wIxlMpmVmLIiQjDuFivSNpVa0Elo0+ZamvPx2+LDNP6hS
         pG0khQ8U04NZRNQlAXoLiSpuwKOAUXSOX5iVoQQD6fvaWpwO6DMdHIzdN9Uq12FG1CdN
         3HVZmC+UCVGdTQuzkcDU8dgD9C4v1WuWn5RcWFoyj3ePidGO3PI80WYOHgINLo0sU/Ng
         a6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352241; x=1776957041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+yFelEhnCKgW95BCsCvZrDElWlGNwzHzfghcF73FkQ=;
        b=YQzgiALC8Ook26BrD4+s9xQ+ySQdBU4j2/XUCExWhHcosA7Vam8EEDzbE8Zz/hoO12
         OmOXbdRM/A/jW0wF79ZiL0Sm/mUpUZRdrSXVV+TSnjoZcpkzO6eiV0b4wMBkpR096ZTf
         GT7IesSQy0w8IWHahN4s6GOwdoXvALMjgyYflKai0Mo21K0/k85Xv94D5QitfgpelE2+
         2ArQ/9Y1pfMAOZ42DcBSrT9PnolIxMWXce4yaRAqD+f6mxX82bDEMpR4+Z329rxX/Xi8
         ei+GPBDzgH69IWVJFOh5OjR++DtAJqnXYEXzZZP7GcEcTRi913jczfFNU/sU/4nofaCn
         4riQ==
X-Gm-Message-State: AOJu0YwRioYgYw/YWUZzfMT7wmLpVsOyxpKXBxRpEu7lBtYNmSwUm3EW
	gXLduLRH+Mvcso2Tj3oHpN+OMw0TY7hRdch8octe/VZYnSFFi0oDkKrg
X-Gm-Gg: AeBDieuaYlLZamf0lrWf5oWWY3ZMwtktleegGJiYlP86sH1+ANFoBJYwRNysaawM24q
	gfAYZv0UPVmzVci89MEzOCBZqH83+oLSVKOMf09e6ODxxDecDepjZW03Y9zUC7h803NY7EkTRFA
	Iz99qy9yQAV5H/dS88rmPvxqOyKyuiu57NPAHkexNLhOGfM/OBqNxzZojCiBQ5FEfAqk+lKuGOD
	MV8Y+6Ht/gTVxDIwPJ+NH3yP7ZqasQp+LS2MZDKuZ+zhX4F1jytutrjbXVrBQjpsoyFmUJJhwNC
	9irby0/g9gLzf0l7DVEj7B1wwZcp6C16j/r1uWIisQZ4kgxuLtK9cBPPEcsCOclJgD2UVg6KtF2
	QJkjJ8Gm5wlcuONPx2eevCJlD2d3KUFP46NnG3m7gpHvfRZ5vDp31ao4m/FDbVKK8NIXfqaxh5+
	5LEJwSHasukLolhgeifXmK5i0qKfsTTn8DthYW2tzo4zKbAUCtxblJFO4GNojndGCGpCF+SA==
X-Received: by 2002:a5d:64e6:0:b0:43d:7b7b:ab79 with SMTP id ffacd0b85a97d-43d7b7bae01mr23572589f8f.5.1776352239719;
        Thu, 16 Apr 2026 08:10:39 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5895:d15:8047:4abc? ([2620:10d:c092:500::4:7fe8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm14195834f8f.37.2026.04.16.08.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 08:10:39 -0700 (PDT)
Message-ID: <96b6f76e-1dc9-4d54-9f92-8586796ef607@gmail.com>
Date: Thu, 16 Apr 2026 16:10:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au> <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/26 3:11 PM, Alexei Starovoitov wrote:
> On Wed Apr 15, 2026 at 10:18 PM PDT, Herbert Xu wrote:
>> On Tue, Apr 14, 2026 at 10:13:21PM -0700, Alexei Starovoitov wrote:
>>>
>>> No need for such guarantees. It's best-effort only.
>>> If the walk skips entries it's fine.
>>> As long as it terminates eventually it's good.
>>
>> There is no guarantee that this walk will terminate (unless you
>> finish it in one go).  In a pathological scenario, after each
>> walk attempt, the hash table could be rehashed such that the
>> entry that you're resuming from gets moved back to bucket 0.
>>
>> More practically, the walk is essentially useless if you encounter
>> a rehash/resize event before calling rhashtable_walk_enter_from,
>> because half of the hash table could be missed because the entry
>> got moved near the end.
>>
>> I think a better interface is to detect such a rehash/resize event
>> and then fail the rhashtable_walk_enter_from call.
> 
> that's certainly a cleaner interface. the user can retry
> if resize occurs.
> 
There is a problem though is the get_next_key interface:

int get_next_key(struct bpf_map *map, void *key, void *next_key)

we cant store any metadata (table address) to check if rehash took 
place. Am I missing any way out of it?
