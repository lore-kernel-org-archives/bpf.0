Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BF12FB0D
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830363; cv=none; b=Xk3MFRgBEAvLZDlIFV+NTNJO8a3/5gqeX5haMffCeAvNvCVOcWbk4Q7VJ1+Q0aUY1uQkjNBd1Hc+yQZp3CqpKMsIhiD6om3j3bMqPYInNzmHk4VfNd3SXIAUzSuydnGX6ZejZE4nUyGkYMFXLPuR7zBpE84Xi/wsvzoVLMGM2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830363; c=relaxed/simple;
	bh=5MaPnCgbvziQLQI6ZFwiRO9uMq2nmv6SQ8WFv2ZHA4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKuAjTTlPAzOikgO9X094gGSncxRPhLKuZBEsEhlmBe6ZQkqVMp0WETyPV7Uz2h0Olcbiy4XX/TzM/374nb/OuoF3dHWHjvPl7M3loEb8qVmZlUgfGRXRDPbJ2hef4oZVGLVF1YIuv4Ucb6FmXVraRHHjGFWPe7ldvpGDw5qgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgAvWh4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgAvWh4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709830360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whGVs82XXa9QzJHzJW0FkxvrD6T0b+AbKtmPoy5f9ys=;
	b=EgAvWh4j55MIPjx5SyZSG3yI2mwkcDf0dCBMb0CeU3npYhknl2ORE+PLC2ni1Z8pytC9JA
	XGxmItowxV8APfl2XS55fG15DMgg/EB5SvrLUjNMQCHn8eEcqpoc5thsfz/QTTpEHs+CDy
	xN1RZI4Kvv3ZRrq7uQ9kK3R6Ud+Dvwk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-bBoLCt4VOm-S6wYKcEWWoQ-1; Thu, 07 Mar 2024 11:52:38 -0500
X-MC-Unique: bBoLCt4VOm-S6wYKcEWWoQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5673426400fso523149a12.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 08:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830357; x=1710435157;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whGVs82XXa9QzJHzJW0FkxvrD6T0b+AbKtmPoy5f9ys=;
        b=ZAsgVe+Ggcchvu95sz/pdAbfNAIVhD1oYmdYHVrW90DaPun0adPMapycbjFAEQp7RO
         Bi4UL5wLqCFDfu4lbOv49zZ1kIAqEYNNELqFQBR31TiKxK+By34d7hPqxMImpRTQWtSk
         epupQuf/uMY8oQ9cSxG+uktEH5XXgwdPVSW0EBpBrJTJN0Mlzkug6iCdQ0Y5dM2hvwwr
         1uQ9iaVFmktdm5L4+NkdMWNKt7HfJ3JYeqZzl2u5so6Kmd0eQAkTlr3ZWi978AcJO87D
         hYrh6pvpQzu/xSIsooGZYhxFyv8fc3Eea99eYaXTkwvtNj1whuP9GJmkCwcOaoZphPlI
         Bb/A==
X-Gm-Message-State: AOJu0YzGtHy1WseIO/P5SRjBw+xQhg1QMFwVsdb2LwQArOr+dX5skHJz
	+SHh6r5AcIsvLDMuUpEXRODrm4nyCz0C6LNSEpDS/ytrDyxbRgnbfd329mpcA8Z6Y9mV3uI0YV+
	JOfFuI0IN7yTh+Ei4qBaDG457J2r7PyCRElgupGptxhUnk2KEow==
X-Received: by 2002:a17:906:558:b0:a45:ae87:ec09 with SMTP id k24-20020a170906055800b00a45ae87ec09mr4865035eja.60.1709830357267;
        Thu, 07 Mar 2024 08:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJuwDEmjitjVeEH8Q4lSg8YGu6nL4jSf2LgBNlkkHlgNCGd/EJzY9XXW3tnhx33fNmMUKFpw==
X-Received: by 2002:a17:906:558:b0:a45:ae87:ec09 with SMTP id k24-20020a170906055800b00a45ae87ec09mr4865023eja.60.1709830356914;
        Thu, 07 Mar 2024 08:52:36 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lo2-20020a170906fa0200b00a45a687b52asm3145246ejb.213.2024.03.07.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 08:52:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 216B0112F3DB; Thu,  7 Mar 2024 17:52:36 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3 3/3] bpf: Fix stackmap overflow check on 32-bit
 arches
In-Reply-To: <549972cd-15e6-4520-a99b-c70c1ed455e5@gmail.com>
References: <20240307120340.99577-1-toke@redhat.com>
 <20240307120340.99577-4-toke@redhat.com>
 <549972cd-15e6-4520-a99b-c70c1ed455e5@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Mar 2024 17:52:36 +0100
Message-ID: <87edcmrnl7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bui Quang Minh <minhquangbui99@gmail.com> writes:

> On 3/7/24 19:03, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The stackmap code relies on roundup_pow_of_two() to compute the number
>> of hash buckets, and contains an overflow check by checking if the
>> resulting value is 0. However, on 32-bit arches, the roundup code itself
>> can overflow by doing a 32-bit left-shift of an unsigned long value,
>> which is undefined behaviour, so it is not guaranteed to truncate
>> neatly. This was triggered by syzbot on the DEVMAP_HASH type, which
>> contains the same check, copied from the hashtab code.
>>=20
>> The commit in the fixes tag actually attempted to fix this, but the fix
>> did not account for the UB, so the fix only works on CPUs where an
>> overflow does result in a neat truncation to zero, which is not
>> guaranteed. Checking the value before rounding does not have this
>> problem.
>>=20
>> Fixes: 6183f4d3a0a2 ("bpf: Check for integer overflow when using roundup=
_pow_of_two()")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>   kernel/bpf/stackmap.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index dff7ba539701..c99f8e5234ac 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -91,11 +91,14 @@ static struct bpf_map *stack_map_alloc(union bpf_att=
r *attr)
>>   	} else if (value_size / 8 > sysctl_perf_event_max_stack)
>>   		return ERR_PTR(-EINVAL);
>>=20=20=20
>> -	/* hash table size must be power of 2 */
>> -	n_buckets =3D roundup_pow_of_two(attr->max_entries);
>> -	if (!n_buckets)
>> +	/* hash table size must be power of 2; roundup_pow_of_two() can overfl=
ow
>> +	 * into UB on 32-bit arches, so check that first
>> +	 */
>> +	if (attr->max_entries > 1UL << 31)
>>   		return ERR_PTR(-E2BIG);
>>=20=20=20
>> +	n_buckets =3D roundup_pow_of_two(attr->max_entries);
>> +
>>   	cost =3D n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap=
);
>>   	smap =3D bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
>>   	if (!smap)
>
> Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>
>
> Today I learned to be more careful with UB in C.

Haha, yeah, I was surprised about this one as well; UB is nasty! :)

-Toke

