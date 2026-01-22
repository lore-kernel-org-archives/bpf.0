Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7C285061
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041225; cv=pass; b=P64dcHhk/tyD4/BuZZC62fQ6uXZ+BaphnebJk4hLv9BfEkkIdUzbRafM7YMjxpccLmJwr6IBseHeC/G8KQNs7Vo7jmTYmLEKMoplUOsMdnoNuU1D23o17LjUvuw1ABkQpyLd12+DiDJ3lmPBZNFw4Y+ih+vNFDpkv+6xfGBh8aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041225; c=relaxed/simple;
	bh=uDet0qkeSRR1s3nfeSTE4gpghrVQ6C4op726XCOFlug=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qooTqEnBEAE82ol1WoMA9EtX4ho7wHP879EzIEhqvG2oET2lT4/6hInB5uF4IIGmqHqLW1dXiBjotGbJHUm6heTlPq7ARv7G7DN4Q92ngWvWUeEWahHgb2NC6s6Hgt2ck3oKdx8xSMpmJ8S4ZFTAa/YiMaAxmqOges1CGzMMQm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+MucNcG; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+MucNcG"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f523bba52so206730241.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:20:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769041222; cv=none;
        d=google.com; s=arc-20240605;
        b=XpYU58lES0N2MUPvSeCASCp7rgwEBNG7DBdx0BOMPECBkjTSomjBKRWa+3NfejTdmH
         3/kFb3g8UBdtZB3snS4uV+W35QS3sS1I2TpjDpNGzdftkXmtNRytPvHniGu7TI8MVi46
         t79Bz1ioPGJRwdXStizWca4A/g9Hmk3NWZBE53PMSPWYa0s6TPdSdDIOzq6WdfJVF6AY
         ay4Byw/yPbk9l0iAVZD8/7zal1fUnuF0XEGh6YtitGwZcP3av5Mlu2Z8ZaQSx98NOQFl
         XOXH4Elzd24e3j1qpN3D3eyk2aNJvQ+y6ZqdBIXoxkXmBXv8qWqGMsrDUd2YpvwLl1ES
         sWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NgWkbldIsVdXmF1uopkpscBQ8hvxBRp9zzbekpxQ/oc=;
        fh=BEA6EOIFnFeZt784vogDv05qaY1rACEKVRvJ9kaHTIM=;
        b=d/KC4O1htn8/4AJehAlzaVwMgBdums0NLvslFlfmhm1LtjTTzF9cJAg5wk31AGoZ5B
         ilkOFlq99rU3j1XBW5o8+N5OKmnLB2Xqdz+E8mgb2a0fT1iui/PdViEP7RIeaD/od9rD
         H0YRL8/2N5SiqHTe4k+nR6SCW/Xl+Nty2puPZiM3P0yeahSr8/yFezKJl4oj6HI+pU7S
         XW6cMY1pMK4oGhHF0Eer7xzSUUTpuCi1PjS/bK5SHhG7YQ2xWMGuOfgMOw6cT+nyRoZi
         5bt+cHL5Q1Zf0ljGOVfqlzWdhlSM8nOeRys0jGhRPiDtCIAcgWVxTlIjU2hMLrs4YXdX
         emaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769041222; x=1769646022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgWkbldIsVdXmF1uopkpscBQ8hvxBRp9zzbekpxQ/oc=;
        b=k+MucNcGf9vjPx+WxCzfOyTjixKWfQbMvdVS25Sz5jdmgnni+owVrIgzdHLTLU+lv8
         CKE2ohJQIHogMlkaC/5v1GC/sf6G3Mq/Z/XaFjzxsBm3gSc8RxNXGQiGChS++TWKMNpl
         9DaBPvSVLrAsTl6O6vhBZpyE8pmXPRZVHig6fHmx8S+DCDKaqFdr385YP+8oIp4N3Zab
         vEE7QTwg4kX0lYy6jw0O+2X1yLBwL1jeMWAkjFLDaY3Zf2sBP4YNIadbK1GspITeGPwN
         t5F1k4v49zy3yDfm/GndsZaMHIpnRodYavj9D03SZYsFAvtmaThYzBxBo82ZulwPXnkl
         QFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041222; x=1769646022;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgWkbldIsVdXmF1uopkpscBQ8hvxBRp9zzbekpxQ/oc=;
        b=M4C8GPWYlgGXnXhf7mooIOyJEQYf/RyEfL1jWIhDwROmrOWYIQivKyjxH3n06xrvEz
         s4kH+ucwXncm1Z3YrEFpxWrLLsoNtmZfjHeb13elwtNSc0yCUBgXoZmsKNVG4L3QWyXn
         yQ268d+wPnaUP7xyZ6+I1qEcw1tEIS6bIjDRCYyWbHNsZtlIDaQHa23ru1Ee5FVbyB48
         yxkvlR/A62o2xMXiS/TsygK0q0BUjt+7LfMWI2AVAAFXedtGnBv/1nBbe0yf8xqKkd2z
         yuCTvJrndlu4x2mOrfOaz9/xvERTZ8ai9fh1xNuVp447fx+/YBLC52FoiBSTLMMd+ORr
         bxww==
X-Forwarded-Encrypted: i=1; AJvYcCXruzy1QJaFiMjjdS2qtfLbipBQweoScGDd7k8kykXZH6J1wn+/hqqeBmRinJ8RZLKS9I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmV/AfRH1jb2xdocShMXMhSmFnMs8VLF3smANqUCt3X7/93TF
	80hEZtJ/h6kMEjE6tzTnxBXdRroHYYspSUEgixJeQUCz+2lTFZdeDnP7N6PH/xgPzMwPwM31obH
	r6MJ+9+d351QDB4JQJy3wt4EJUvpUi64mea1WAjJs
X-Gm-Gg: AZuq6aIvxtGhNil3TwjFRs0Jox2BBh1cQjtBC3fAnsMNUaRJRjq4KI8jjPp9Y7LTYf4
	X/qrrI1z1+k1vgXt/sRVqABXTV+Eo6WGTN7GIgjYX0k9JeARlE6spjBrkmyXvSnNBmlFW63NMyv
	LhK+13472YPhSi2egN5ajGmUhTjkinjilf+Cj6G3D7p2so40fIz5D7/zoFNiDCMJdk5jEvDzWEM
	RrqGUtQ7EfGFyJuxWqEKADRZ+0lg0uzXPMPVEfj0NuBct88ilhfHVDtgkx92On3WrFvfFMWR0sM
	2XzTRbXyMe8xce+VGNOPBtOqEg==
X-Received: by 2002:a05:6102:370f:b0:5ef:b32c:dff8 with SMTP id
 ada2fe7eead31-5f532daa025mr403198137.5.1769041220288; Wed, 21 Jan 2026
 16:20:20 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jan 2026 16:20:19 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jan 2026 16:20:19 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <6b50a83e-acd7-4db3-ae9b-015ffad4f615@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-3-kalyazin@amazon.com>
 <CAEvNRgGrpv5h04s+btubhUFHo=d6mBFbr2BVrMt=bWuWOztdJQ@mail.gmail.com> <6b50a83e-acd7-4db3-ae9b-015ffad4f615@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Jan 2026 16:20:19 -0800
X-Gm-Features: AZwV_Qi8Ad3srMrd8WYJ_YHR6Nmvzc-hfHPfYm40mDZ1I3o7aAQCl-nKoDyQfts
Message-ID: <CAEvNRgHMdnALNfT0SuEb-gqM1Aq1c6U_nRB2GzC0jYqrDRJTOw@mail.gmail.com>
Subject: Re: [PATCH v9 02/13] mm/gup: drop secretmem optimization from gup_fast_folio_allowed
To: kalyazin@amazon.com, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Nikita Kalyazin <kalyazin@amazon.com> writes:

> On 15/01/2026 21:40, Ackerley Tng wrote:
>> "Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:
>>
>>> From: Patrick Roy <patrick.roy@linux.dev>
>>>
>>> This drops an optimization in gup_fast_folio_allowed() where
>>> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
>>> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
>>> by default"), so the secretmem check did not actually end up elided in
>>> most cases anymore anyway.
>>>
>>> This is in preparation of the generalization of handling mappings where
>>> direct map entries of folios are set to not present.  Currently,
>>> mappings that match this description are secretmem mappings
>>> (memfd_secret()).  Later, some guest_memfd configurations will also fall
>>> into this category.
>>>
>>> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>>> ---
>>>   mm/gup.c | 11 +----------
>>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 95d948c8e86c..9cad53acbc99 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2739,7 +2739,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>>   {
>>>        bool reject_file_backed = false;
>>>        struct address_space *mapping;
>>> -     bool check_secretmem = false;
>>>        unsigned long mapping_flags;
>>>
>>>        /*
>>> @@ -2751,14 +2750,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>
>> Copying some lines the diff didn't contain:
>>
>>          /*
>>           * If we aren't pinning then no problematic write can occur. A long term
>>           * pin is the most egregious case so this is the one we disallow.
>>           */
>>          if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
>>              (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>>
>> If we're pinning, can we already return true here? IIUC this function
>> is passed a folio that is file-backed, and the check if (!mapping) is
>> just there to catch the case where the mapping got truncated.
>
> I have to admit that I am not comfortable with removing this check,
> unless someone says it's certainly alright.
>

Perhaps David can help here, David last changed this in
f002882ca369aba3eece5006f3346ccf75ede7c5 (mm: merge folio_is_secretmem()
and folio_fast_pin_allowed() into gup_fast_folio_allowed()) from return
true to check_secretmem = true :)

>>
>> Or should we wait for the check where the mapping got truncated? If so,
>> then maybe we can move this "are we pinning" check to after this check
>> and remove the reject_file_backed variable?
>
> I can indeed move the pinning check to the end to remove the variable.
> I'd do it in a separate patch.
>
>>
>>          /*
>>           * The mapping may have been truncated, in any case we cannot determine
>>           * if this mapping is safe - fall back to slow path to determine how to
>>           * proceed.
>>           */
>>          if (!mapping)
>>                  return false;
>>
>>
>>>                reject_file_backed = true;
>>>
>>>        /* We hold a folio reference, so we can safely access folio fields. */
>>> -
>>> -     /* secretmem folios are always order-0 folios. */
>>> -     if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
>>> -             check_secretmem = true;
>>> -
>>> -     if (!reject_file_backed && !check_secretmem)
>>> -             return true;
>>> -
>>>        if (WARN_ON_ONCE(folio_test_slab(folio)))
>>>                return false;
>>>
>>> @@ -2800,7 +2791,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>>         * At this point, we know the mapping is non-null and points to an
>>>         * address_space object.
>>>         */
>>> -     if (check_secretmem && secretmem_mapping(mapping))
>>> +     if (secretmem_mapping(mapping))
>>>                return false;
>>>        /* The only remaining allowed file system is shmem. */
>>>        return !reject_file_backed || shmem_mapping(mapping);
>>> --
>>> 2.50.1
