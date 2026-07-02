Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD96353A96
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003659; cv=none; b=uo4P0Om2RsJO9d8u2Q1JCRiM4yulctADke1swwnq9O88sjAQXQItxMOmYPZ1ah0/n3U+UzrDoHXTsAVGMy71IYdsyeU7YxXisW37KDUP0rEy+tqwI82jZEMNtlJKrT5pggZnJHBi1F60NZsR3oj7DqBq6uPf9JRqn3KDkoWpKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003659; c=relaxed/simple;
	bh=qSoRJ+ny6mwEKR7wyqw9/Ie8ciB2/XLnhVkOOj3TvhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f53G+oZJBRv/IN1FBsohfDdM0SuqQqZztVMoFBRav0KTEAuHFVmw0+zYOINLpbYJkXG7LAYmSoYMhVBZzT4fJw5mq/EdoM2m0XHvEoeqdVbkaMPxKGJY2MH6GAxc6qTQ3VdC3eQkr52TB1JusAblWpZf7b1kL7RKlc9dp8lkE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OI6ZfXdf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dc9qcubB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI6ZfXdf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc9qcubB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783003657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKNYo7arqO2T3O8Laac+0jwpzsq2e8teEx8RAzi/7U=;
	b=OI6ZfXdfIH803YH8WnUn+hGo6xZC+oQw8A0KwUHMVd52+9boI33jf/s3bYQgnRSU+X7OFH
	xWU8/Bz56TDC/g/vwdfn3z0ngNsGdCoRxNTA6JgT5I+ZLzQWooBJ95NoGHtQtzuUV2OUH9
	ekqJ3comR01rT7BqZRqOelP6EBG1z5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-mr7jDL_EOXKRbZpwekcgMw-1; Thu, 02 Jul 2026 10:47:36 -0400
X-MC-Unique: mr7jDL_EOXKRbZpwekcgMw-1
X-Mimecast-MFC-AGG-ID: mr7jDL_EOXKRbZpwekcgMw_1783003655
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c125ef89f4eso166311866b.2
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783003655; x=1783608455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJKNYo7arqO2T3O8Laac+0jwpzsq2e8teEx8RAzi/7U=;
        b=dc9qcubBzeEvOYmZS9pj4eiws7WPPAmfRCgjF/FokfGuQVOE3YvkYFQIQr+dadonfM
         VjiUW1k91zi+XuHNh9FIf1zHZeilfBSYsEbp+kiyTSjqPu5++VlUsniyPgQOlLZAOAM1
         YPBElXSmJcEb495Sr7mbw82Gm4ar28GKGxlbNb7uSA7MInaUnX2HlUK6OXaNIQd+aKm/
         66ADkXlFVgy0Fp5a5LjqezABS5C3lb3eWPntaD5oH91TfJP/BI+oesHV879BOJbFgyrB
         7seE8C33UgtmZEg1SGImxpgHO0Eu492MU+stOoEoXSXRRUtjAiWNQApdpweKPD7beixz
         xckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003655; x=1783608455;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJKNYo7arqO2T3O8Laac+0jwpzsq2e8teEx8RAzi/7U=;
        b=Zy/snWhLlVKx/RpO3IMKQLJ8wsP1TZMASSFDQ+otou3zDKEQ6O58kUpGwTo3Fc3/1Z
         M5qdfsBtcbTUUo/EYBW/SgSXL/TggU5rVgZl32I4qiziovCnh2o9087GYZifEcBzs5FJ
         XfsN3DZfg8Uer+vnD6uQVxh/euuH6hN+LvJTaiIVXUUgUxJy1ujAxuFM3mRVBR9bMtYb
         yhVEVM7UoEW2jEeMumZswoJQ+HBUSz+Ojx9znw3sQq5UdSwRHtLJ/exXb9HEetVG3MW0
         0owrO9IC1PJqr/YJGAo45K0z1sozYEEWFZOMNFnXzzqa7y7owMbVrJu/jwT71KAt6MAh
         tZpA==
X-Forwarded-Encrypted: i=1; AHgh+RoMIdiAd2Fl+5Myj+cz3dWEh2IENZKtFoYnH+cp881edjE/b6INo5XRC1azSPi10Qs7L9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqzbi3BvwBL/f1Ke0f6yNYl0yqJYbHclJB11STVSp06j+IEv8X
	xDZsbtlCFr5dC/P+Xk/PZsoXBvzG7A81RlQ4rmk5nJ1OVdZ4V2gsg+2zkoTLWtCG4LgVGuWJ6Tm
	4umyrCJJrZZw/bgmtOijqp63kNaJVhODs+kiRRjo3LOUQGVedE/TafQ==
X-Gm-Gg: AfdE7ck6XkLudwolYlyScVTD7JQsPu2sUasLq2AYuJycx2fq/zncK+9J3ShFXXHx4ub
	8apel994fykY4ezoz1ZrHUEJ6HCg0zFaBdNIszTVRgcWd933nhU7RtFvUg2I5AzqyY9Ypl26IQy
	tUuzl6FMt+x7cnzMF0RCQlwAVc1+luz8fbrY31KH4O1ueUWFTXepsCUxAOPrx9MNkkEzFjb0FPM
	bTPM/cxtjEfE4Hdwg1tlQGUE8Xshy5z0dWYaLDbmwlv7rp9gOGUTy75+FPz+Im67sO+C8QZ4Msq
	79UQ/hgSI54djUxQKgr0JPe9ZnBbMzpdNk0dEA2nei7oYJlS1MIdz43YoyU+K7hADkUKWCyH+0N
	Hw5T9B0bQxCOFGlbhbeK7ty1hF07ejayZWq4=
X-Received: by 2002:a17:906:890e:b0:bee:6806:d69a with SMTP id a640c23a62f3a-c12aa1c038fmr242107766b.38.1783003654806;
        Thu, 02 Jul 2026 07:47:34 -0700 (PDT)
X-Received: by 2002:a17:906:890e:b0:bee:6806:d69a with SMTP id a640c23a62f3a-c12aa1c038fmr242105266b.38.1783003654407;
        Thu, 02 Jul 2026 07:47:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628efefsm140821766b.32.2026.07.02.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:47:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2D65E80AC62; Thu, 02 Jul 2026 16:47:33 +0200 (CEST)
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
In-Reply-To: <9d14ff4b-eadd-4ae2-ab68-5927d4f19eeb@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org> <874iik2ew4.fsf@toke.dk>
 <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org> <87y0fv0y79.fsf@toke.dk>
 <9d14ff4b-eadd-4ae2-ab68-5927d4f19eeb@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 02 Jul 2026 16:47:32 +0200
Message-ID: <87ik6x1m9n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@kernel.org> writes:

> On 7/1/26 5:02 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> David Ahern <dsahern@kernel.org> writes:
>>> Seems to me the fib_lookup for xdp needs to return the bottom device,
>>> not the vlan device, for forwarding to work. That's why I added the
>>> fields to the struct. That allows the program to push the vlan header if
>>> required. My preference (dream?) was that Tx path had support to tell
>>> the redirect the vlan and h/w added it on send.
>>=20
>> Sure, returning the bottom device index with the VLAN tag makes sense,
>> and that's basically what this series does (but bails out on stacked
>> VLANs). However, that's not what the helper does today, which is why the
>> flag is there, to opt-in to the new behaviour. I don't think we can just
>> change the ifindex without breaking existing applications (as noted
>> up-thread).
>
> I do not see it as breaking existing programs which is why I chimed in
> on the thread.
>
>>=20
>>> But really, once stacked devices come into play, I just wanted to make
>>> sure thought is given to different use cases. As you know the lookup
>>> struct if hard bound to 64B and it is trying to cover a lot of use case=
s.
>>=20
>> Agreed, I don't think we can handle stacked devices in this helper. But
>> we could split it out into a new one. Something like:
>>=20
>> struct lower_device_info {
>> 	enum device_type type;
>> 	struct {
>> 		__be16	h_vlan_proto;
>> 		__be16	h_vlan_TCI;
>> 	} vlan;
>>         /* add other types here */
>> };
>>=20
>> int xdp_get_lower_device(int ifindex, struct lower_device_info *info);
>>=20
>> called like:
>>=20
>> int xdp_program(struct xdp_md *ctx)
>> {
>>         struct lower_device_info dev_info =3D {};
>> 	int ifindex, ret;
>>=20
>>         ifindex =3D find_destination(ctx); /* does fib lookup, or someth=
ing else */
>>=20
>>         while ((ret =3D xdp_get_lower_device_info(ifindex, &dev_info)) >=
 0) {
>>         	if (dev_info.type =3D=3D VLAN) {
>>                       	push_vlan_tag(ctx, &dev_info.vlan);
>>                         ifindex =3D ret;
>>                 } else {
>>                 	return XDP_PASS; /* we only handle VLAN devices */
>>                 }
>>         }
>>=20
>>         return bpf_redirect(ifindex, 0);
>> }
>>=20
>>=20
>> With a helper like this, we obviously don't strictly speaking need to
>> change the fib lookup helper at all. However, for the single-tagged VLAN
>> case, I think supporting it directly in the fib lookup could still have
>> value, as an optimisation: it saves an extra call for resolving the
>> ifindex, and the fields are already there. So I think my preference
>> would be to merge this series as-is, and then follow up with a new kfunc
>> to handle the stacked case. But we could also just drop this series and
>> go straight to the new kfunc.
>>=20
>> WDYT?
>
> no preference. I only chimed in because of the added flag to the uapi
> which I do not see as needed. If the consensus is that it is in fact
> needed, all good then.

Alright, cool - care to provide an ACK, then? :)

-Toke

