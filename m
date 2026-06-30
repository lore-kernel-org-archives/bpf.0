Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24E39D6DD
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813650; cv=none; b=NR2MFdqb67P5S1U9cIq5SZfW1I2CgWDztp9P6a6jM8aITJH7w3F7j8yqB6rn7L3WQpDLDf4P2BVw79T+HBKDTv+tRe9JtVezGUCPQzBEvzWT/UmGKUkV4ZiNHDa9awZLiQ/+DxD1yOtkO3WGK+YxePbGs4tvDJEGs8xtId0O6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813650; c=relaxed/simple;
	bh=ekEo5LipZXYEpZ0QMIrZZq+nxmDsIJiQlfi8Av3DFSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5yDFQCXdc/U4QvtA45m+BD8/fi2+4OH+FN4aC+9Zi04+FoZJyk/s0sXo2MdDm0NrkcQYGTOMhVhhq/u1mGf2Zk1rsGfxrr8M7W29Ueles4DCIk3GuJ6sOfnQrBP8R5tEEZ2BfJTWr7IvknLQ3Gim/5xc/UwgD+M0g/pHyfbQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdCd1Fdl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kE1Rvch5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdCd1Fdl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kE1Rvch5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782813648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tefDvr2JHzbWEvM4BvoT6FRVVef0ZkWyx7gPNMbvFYo=;
	b=ZdCd1FdlAjTk8bXIc+wNVmHyXhgwiMivUfLIlHIIH0k3wQk9ZDV5I76VKk+7T0/izXCxIc
	3TQWugd7RiEE5Re2Vk+nFhe5nZrr6MfSzbaOHs8NJK3hxs4WrNhEKy2cuw5XpMDei71HYg
	giF0D9cEXd9SEESc9Y5PYqUOpRuPpVM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-DgEJK_QeMFmsWWUB1JihFQ-1; Tue, 30 Jun 2026 06:00:46 -0400
X-MC-Unique: DgEJK_QeMFmsWWUB1JihFQ-1
X-Mimecast-MFC-AGG-ID: DgEJK_QeMFmsWWUB1JihFQ_1782813645
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c125bdd01cbso242410566b.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782813644; x=1783418444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tefDvr2JHzbWEvM4BvoT6FRVVef0ZkWyx7gPNMbvFYo=;
        b=kE1Rvch52EVBY4dbjZYMY+EUPzYq50u6lmbYdMynrToqkH2Jl2L5a/hLeHOBX/3gzl
         sPqMrD8TL6eZi6E7RukGDqygTnUnUTTaj0Va1lD2r0c+s2bbwZAD/VS22m5YLDQaBrTs
         Fzgi23oChv/Lz54Aw/oTLf4bvvJyqQl5Hj3hqrHsWgDJqflGJkNq+CCMT7yN/jITsYGK
         4nAJVDvjzM3IEG/AS8Lm+K2bSspklj/b0xWJ/+yYHvh2pbnBY6gFWsbkg8OflmUZD0K1
         FTpVUhdCBlau4EnpXYY+dmcM0BPGRFITOK1V4uD+R8YceJZBjG8ds4N3RtrS2GPOrSWr
         zAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813644; x=1783418444;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tefDvr2JHzbWEvM4BvoT6FRVVef0ZkWyx7gPNMbvFYo=;
        b=MIIjGT9bayyd2FnVHEEps04udDQ/L5HfPWZv6zZhxhT35GJJz4MvCDZDMWGxCGSK99
         rg/DlLWRdDzjFhEZvDbvNQAOgth9L2yns/H/lmtTqmx2dAoUS2FOKvLxGWDwMGgU/Psp
         +1EwazsdOh7LTFk7/zfgMfdIqcbVchN999qqbKF4R9W9JCbCx17W/vpTpXEQfw2R3cE1
         zY1bzFECnl1vd9VmEdR7VswRS1NAbCZCs39BzmaYIlEUQMP1AMNh39kU+J9dTsFO4Hnx
         URPLeASB4bOJp4vAT2BuNnDwW3H8W4kvA9K7x271ZM0b1m3r/eUDzjzN+byJCh5iubID
         EXlA==
X-Forwarded-Encrypted: i=1; AHgh+RqRSxzpUHj8Q0746z5+xG9aKvfPxjEFk9ZlJ18dcQVzcpu7XHBpOWe3+A5YFJtrzaRYdv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaR6lQssTyp6Yb5LIdfpc8A+fRwKHwH2wW69pGNa7zdz1AQeD
	UaiZLHyJMaY6QQTRFHLEqvZvLEQuosuh2wCmH+/GzrGNsOW53W70HZiKAPDqiVh+NLXPY+eNw5N
	R6k90G8XmW6b+7UgwJowP7vymu1SnxPjGkXrIsy5KTEqboxZxwMlyMw==
X-Gm-Gg: AfdE7clCKH0VOn+bnzuIkVn82csRG9Ta40W9msIm5o4JZ3kTNXgWsZvF3uQzMa5V7YG
	/mw3k+u0p4pQme+/SeCHRer9DaMn4pipoOkzaZ74zIqMmvf2GanDKKgl4bgq89x0G2xe5dnsi18
	8nd52Zu/qbhd8LlICvTUL5RgeBey7IdHrGZcYakUbAJBEQf7xM9BOvYWxFZQSD+m00V33rsRGnd
	RZbPwkktn9NzWVB2sZuxeUTqK8ObUUuoGqcsna4eZpKW/a9wc6Kvje+dvDuEY2fSGUgvRGyw7cs
	Td7cSTB+wAk+gnbmD+FfW9oIgskqlKqKcqJGtPhOjI7aQYHlO7TTuelssYj9IrGwBL9ayZkRBaL
	nVcGGnWm3JNmiLfDht5fAyNWtR0pahHgUNTM=
X-Received: by 2002:a17:907:97d2:b0:c07:fcdd:7043 with SMTP id a640c23a62f3a-c1287168408mr137278366b.16.1782813644568;
        Tue, 30 Jun 2026 03:00:44 -0700 (PDT)
X-Received: by 2002:a17:907:97d2:b0:c07:fcdd:7043 with SMTP id a640c23a62f3a-c1287168408mr137275166b.16.1782813644021;
        Tue, 30 Jun 2026 03:00:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d1abbdsm98502166b.9.2026.06.30.03.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:00:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A672D80A53A; Tue, 30 Jun 2026 12:00:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Jun 2026 12:00:42 +0200
Message-ID: <87echobb5h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@kernel.org> writes:

> On 6/29/26 9:08 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> David Ahern <dsahern@kernel.org> writes:
>>=20
>>> On 6/23/26 9:05 PM, Avinash Duduskar wrote:
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 89b36de5fdbb..e00f0392e728 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -3532,6 +3532,29 @@ union bpf_attr {
>>>>   *			Use the mark present in *params*->mark for the fib lookup.
>>>>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>>>>   *			as it only has meaning for full lookups.
>>>> + *		**BPF_FIB_LOOKUP_VLAN**
>>>
>>> This flag should not be needed. Patches for vlan support were never
>>> submitted (I have them in some old branch). Since the vlan params are
>>> initialized to 0, no new flag should be needed. Besides, these are
>>> output parameters.
>>=20
>> There's no enforcement from the kernel side of the parameters being
>> zero, though? So we do need the flag for feature detection; unless we
>> expect applications to do that out of band? But then we'd need a
>> mechanism to do that which could be... the presence of the flag in the
>> ENUM (and thus in BTF)? :)
>>=20
>
> This is output direction - return from the fib lookup.

Ah, right, silly me.

> It does not make sense to require a flag to get lookup output. vlan
> proto of 0 is not valid, so it is a clear indication that the vlan
> output parameters were not set during the lookup.

Okay, so we could just unconditionally set the VLAN fields, but if we
start rewriting the ifindex that would be a change of the existing
behaviour that could break existing applications, no?

Specifically, if an XDP application has a table of the interfaces it
forwards between, today they'd get a VLAN interface ifindex, which would
not be in that table, and the application would return XDP_PASS. Whereas
if we change the ifindex and populate the VLAN tag, suddenly the
interface would be in the table, but because the application doesn't
read the returned VLAN tag, it will end up sending packets out without
tagging them, leading to broken forwarding.

So if we don't want the flag, we'd need some other mechanism to resolve
the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, say?
That could also be made generic for other stacked interface types, I
suppose.

WDYT?

-Toke

