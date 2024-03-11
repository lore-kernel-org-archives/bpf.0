Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18F36B1B
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154699; cv=none; b=ElKu4BiXA8h//re6uengloXlxQoBgdJtJyA32O/UbI5mIG2f1/7oOv3DD7F6KrBaRmu201yzBrVWtfxgxWJgcINrRbKYZnIw0uA9aXnMB5Xd6YLQEWeN/qOPgpj4fXDNYve/1TjmmaMG6TmxWriTUPoIi90P72xW86L6um0Wi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154699; c=relaxed/simple;
	bh=ueYvYRRt8uZiMakPsZEiFU9N73WoMsnYXzeDfT3cV9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cp1DaKAKiR4zffu2HylqvpvgHbimJxJl1uWNX4My035n8w0EB7I90R9r88fRLPD39JKJ1ejc1Km+VmGEZt+X6Js+cyVdGsmgtEkYUW0aTnni4bT+y7FGmZjvuSZ6olsg4q/h1SA/HPKGsRssQ3d566BgggjyGNrFy3I6FXBDAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCDYowv2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCDYowv2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710154697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LujXe2chMJShFPP0kGmuZtZqiL6qoec92g+O9DJTPjA=;
	b=JCDYowv2i6c95eExdD2ihYhaz5MudCUocaAHAybLeMFppPOfUwuVLxyjDTr4+6cbNbQo/k
	xsax2+1zPwAUewTmE7DNPlrSbgnH6N4dIfoe0hZQSsHoqpskizKlDkM4+1T6jpWh1rYEj4
	dPPqdP4Pgu8yCAbGxWNnk/C3PvmrMhc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ac7vpp4JNseCxJH6mB2n5A-1; Mon, 11 Mar 2024 06:58:15 -0400
X-MC-Unique: ac7vpp4JNseCxJH6mB2n5A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a46376dcdcbso17561566b.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 03:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154694; x=1710759494;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LujXe2chMJShFPP0kGmuZtZqiL6qoec92g+O9DJTPjA=;
        b=b6pRxl5niumlCFBZ4/t1zxWLAMzu0kVnyErTsurBzIUVr6/u/C2h+XGY884e0/KcWW
         Ejosv4mGJVg+zEdJx757a/zHASLRZmxUd32cPZSvz9OgdggTNk0DxCR0/a8XRcis4eyA
         7Koh1HlGVmNjjfKBB+rPfSu5ZNXOz+JHlkhjExlrSwsAR0wCCP0BGkdMULu+mxFd2yhc
         TKj0r9Y3Z3NyLakzWMU5HMC9mIKhpXv3zQxph6dGzG+mddx+ck5Aw6fYE4qF28OHrTvd
         T2H6WxbmPZkltP0JuHmap7LIh52VSI3m391TItjZNtLBxcdOKgLl14qpRojME6RsjsLV
         RVEg==
X-Forwarded-Encrypted: i=1; AJvYcCWm7dwgReC5AW/tq5658LZ+8HKmrzqWJL9T3GVeAbbrFOs3KYkhC8/amHRgT7TgthPDAzoE3dwR7dPMSq2zOZ727V6I
X-Gm-Message-State: AOJu0YxzcJLlGg9QmBc8Y2bq+FgNx+iP1NKfb7G0pb27sCO46pTHHHet
	7GojqhbzI7btGOpdX3sa4k279lhlYukXTDMxiIDbaRlbAH4dUjJdGucVhiA0RXkvtoKthB/ebDY
	ihqMmaxJvCQ81eVYjgDmpeHYK18PqpesvFIcY/YNeaHYrU3X2wg==
X-Received: by 2002:a50:955e:0:b0:565:4b37:4578 with SMTP id v30-20020a50955e000000b005654b374578mr6169951eda.14.1710154693980;
        Mon, 11 Mar 2024 03:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG7tMk4I8lmmNgh1KxCP0Ul+ru81bqi16+u2IL0KL6cxR/4BiIDmWqGLNRolkKjO4jg1dNDA==
X-Received: by 2002:a50:955e:0:b0:565:4b37:4578 with SMTP id v30-20020a50955e000000b005654b374578mr6169931eda.14.1710154693662;
        Mon, 11 Mar 2024 03:58:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7d158000000b00568525ab2e8sm1428927edo.55.2024.03.11.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:58:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BF761112F9DB; Mon, 11 Mar 2024 11:58:12 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v3 2/3] bpf: Fix hashtab overflow check on 32-bit
 arches
In-Reply-To: <CAADnVQLjEeDTmyn2+EsgSy_vkUcOGyUeSPpsLg0ytNnDW+YczQ@mail.gmail.com>
References: <20240307120340.99577-1-toke@redhat.com>
 <20240307120340.99577-3-toke@redhat.com>
 <CAADnVQLjEeDTmyn2+EsgSy_vkUcOGyUeSPpsLg0ytNnDW+YczQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Mar 2024 11:58:12 +0100
Message-ID: <87msr5qbln.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Mar 7, 2024 at 4:03=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> -       err =3D -E2BIG;
>> -       /* prevent zero size kmalloc and check for u32 overflow */
>> -       if (htab->n_buckets =3D=3D 0 ||
>> -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
>> +       /* prevent zero size kmalloc */
>> +       if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
>
> The comment carried over the wrong half of the comment.
> I fixed it up while applying... to bpf-next.
> There probably will be no bpf pr,
> since the merge window is about to start.

Oops, yeah, completely misread that comment; thanks for fixing! :)

-Toke

