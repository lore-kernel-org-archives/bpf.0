Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CF331230
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280263; cv=none; b=fa0rgixp9s6Msxp1Ab21tfvqiEQSY803cQQqp85zr0HBY5xF1E+EEmmdxl277W3WUk3CRHKQwujVD0MMZk2fdpuJyBzgPhvOgJIxg1kipf50oWklmnig2lKY2C5UvCeq8WHFoS91rjNZL5qTyp/Ze12smy4lmrymhnkxpg754lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280263; c=relaxed/simple;
	bh=WBICROsVJjdfEYN+o8+n4hxG77bO3Y1xRI4/Xzv216I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=uAPAeU1hRmoM7/NMIdhm4MHlQtevycl2Ofu7lqr7PnJucvHcIV8s8E+YlL+chhWP2gs1umeH/Vy9MpLA2ZKvU7MkuMeY3nFSsl2Ng4JtRqVvAZPRaNEvqKDGQcqycRYlTco57lWgd5K37kmXEN4j9TsJJEMQpr3nMoJovGnUfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptadXsVl; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptadXsVl"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so42095805e9.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784280260; x=1784885060; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kOnetI83VqKtCeBIPBoMPtcrX0EGAdXcepViLnk5ugQ=;
        b=ptadXsVlFSIxzv9SHflaw9rifkSBRY+E8oVHOn/96GgGBSkKjrumqYKT9qOTRETtd4
         S6sZ+d+wsHMHGGLfQ45K/+lPVi9MIr3MBb6+7yFfNqrk7xeABejNEsM5HjB8OdXbEKvd
         6rhizHl9mWPfsJXz8DkW76WEQWersWQWhLQCHu7/29+27CdlxroJyfX9czAgEJ+BknqN
         ezRQeP1xczOUU4gXO4PC4hmbsWk562916afHmogphUZn7uQT7ZCaXajVD4ECt5BcoW6P
         HC8hsCnm2X1Qb36pcdW4Ye6Py6ENxWz0Eaxmt0NzHcg1PjK5N9G/cNYxdXlObVdq5yRC
         T4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784280260; x=1784885060;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOnetI83VqKtCeBIPBoMPtcrX0EGAdXcepViLnk5ugQ=;
        b=djfmLrr1wZNWIKe+d5qCzvqFhqiKxYX94eIfNh3f0e/7x+VMQTFbQ6NvERBgXXd82d
         Uiwx2+GyS7O7smIC1DBmt8onTBADcgjI4o963RvdWdgP4YACoCO5BwXxDgipEa6d+EES
         9IC/8T4dloh7wyVT9VBaSASjsmA9CzbIhI5/0ZJ4IjUnaLP0dJX+4Lo6s8UkLjVJS/DN
         gCRrfFq90EOJURrh5ht9JI5LqSGe7mFPrQR5mOHDnGPEcJc5k7SKmWkW7/PtZMlVPRmM
         +LDEfXcJctWQ6Iir6f3JSKh8AhztJdrrGXeKwP3Dr8yEmTVB6zasjzB3nmxN2/IDp0em
         EQ5g==
X-Gm-Message-State: AOJu0YzxSED4bBS9WMxZjkx99Avx33KBMXxsWXeT+PtqSDI0pojyiyJC
	7hq5OhNc99tY505pF4fpOz1Sze/spHhC6DwcOOkAm51myPMIv7jt/BlTc4COmJjJ
X-Gm-Gg: AfdE7cmaAC+FeAgPKTZaL8VGriywAypi4SfjcD45D0ABGco6zG6YC/XvDjvaDncpSQx
	oKI4C1nMVeXtc42y9jUezHgE6AcMEYUFpXIrRQyvZNi1dtCnakUAiIDWuVqkXtmXF2LIsCmwLV1
	696UebrFdCVEewhuXWbhIrYZbq7scuPQwKqJKPkGZad5XKqoztLgB9ehWemani44Q7MPsOAznVD
	SDwRLJkd0VQ3e9+9OoG/I2jNxJw6wJIuV/PsFrh3uxyrBTbn2pGZs83PHjfwLN5PA6LzHMGp8hK
	Aa7yzqo8Qr7IRLcmO+EYItc4MKPY6CEi/Zn0oaltv6zk/Cy2OZHcPDi/3QK2k9KR0yf4/ltlJi/
	qUZy54iHiXK/5cKljaGaKS8hplctc72T5mn9bhJnDfFb+JUJWp0/Q5jSY5Vz/+QljX8tFGiUqmM
	b/UM4Yo3cxf5irTs/SL8/npIkGk1oYyEemA1sEhAgsfZNt8SV6tAwXsKXW4e5J39H7OjhT9GPYJ
	Peb4gnXZUK1xYXw+D+/M2sT3xNkUAOyzDfy0LYnzLYK
X-Received: by 2002:a05:600c:1989:b0:495:699:84ca with SMTP id 5b1f17b1804b1-4954a798f17mr17575285e9.28.1784280259238;
        Fri, 17 Jul 2026 02:24:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96fecsm40676555e9.11.2026.07.17.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 11:24:17 +0200
Message-Id: <DK0QKAJXN3KI.2KJ3LLPYKTXGE@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add memory usage for arena
X-Mailer: aerc 0.21.0
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
 <20260716144840.3DE1F1F00A3A@smtp.kernel.org>
 <50c2d308-cfed-41bb-9084-54e380463ad2@linux.dev>
In-Reply-To: <50c2d308-cfed-41bb-9084-54e380463ad2@linux.dev>

On Fri Jul 17, 2026 at 4:08 AM CEST, Jiayuan Chen wrote:
>
> On 7/16/26 10:48 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential iss=
ue(s) to consider:
>>
>> New issues:
>> - [Medium] The `nr_pages` counter is modified using plain writes while b=
eing read concurrently locklessly, constituting a data race.
>>
>> Pre-existing issues:
>> - [High] Functions that can sleep and acquire sleepable locks are called=
 while holding a raw spinlock with interrupts disabled.
>> --
>>
>> --- Patch [1]: [PATCH bpf-next 1/3] bpf: Add memory usage for arena ---
>> commit 68cbc4739a7a9be56d49db779d319ec002523097
>> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Subject: bpf: Add memory usage for arena
>>
>> This patch adds memory usage tracking for the arena map type by counting
>> the pages mapped into the arena. It bumps a counter in apply_range_set_c=
b()
>> when a page is added, drops it in apply_range_clear_cb() when removed, a=
nd
>> returns the calculated usage in map_mem_usage().
>>
>>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>>> index 80b7b8a694464..bc34602116040 100644
>>> --- a/kernel/bpf/arena.c
>>> +++ b/kernel/bpf/arena.c
>> [ ... ]
>>
>>> @@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned =
long addr, void *data)
>>>   	set_pte_at(&init_mm, addr, pte, pteval);
>>>   #endif
>>>   	d->i++;
>>> +	d->arena->nr_pages++;
>>>   	return 0;
>>>   }
>> [Severity: Medium]
>> Is it safe to use a plain increment here since nr_pages is read concurre=
ntly?
>>
>> In arena_map_mem_usage(), arena->nr_pages is read locklessly via
>> READ_ONCE(arena->nr_pages). The Linux Kernel Memory Model requires that =
writes
>> pairing with a lockless READ_ONCE must be marked with WRITE_ONCE to prev=
ent
>> the compiler from splitting the writes or assuming no concurrent access.
>>
>> Could this lead to incorrect statistics or torn writes?
>>
>> [ ... ]
>>
>>> @@ -227,10 +230,11 @@ static int apply_range_clear_cb(pte_t *pte, unsig=
ned long addr, void *data)
>>>   	 * scratches its PTE. A later bpf_arena_free_pages() over that range=
 walks
>>>   	 * here. Without the skip, scratch_page would be freed.
>>>   	 */
>>> -	if (page =3D=3D d->scratch_page)
>>> +	if (page =3D=3D d->arena->scratch_page)
>>>   		return 0;
>>>
>>>   	__llist_add(&page->pcp_llist, d->free_pages);
>>> +	d->arena->nr_pages--;
>> [Severity: Medium]
>> Similar to the increment above, does this plain decrement need WRITE_ONC=
E() to
>> safely pair with the READ_ONCE() in arena_map_mem_usage()?
>
> It's true.
>
>

Overall seems ok to me, since you are going to resend, could you also split=
 the
changes to move remove scratch page field into a prep patch before adding
nr_pages?

Thanks!
