Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612219;
	b=OMFmteCtRyE/mhHN/VS6lOYj8y2opLau6uXh0d+qraAfV0KcUR9d/bueke94uWzHH0Bl
	 3m6Vb68SVhx4wOfYdFt6apc47a4R1qaT0OvcGxDQKFCFgrmlKDjAtkELj3UKwUxzhXXfJ
	 HpOExkcvg/M5aKhQtUW5AQDteEkGXtJVEcKlm5scXY62M8rRpTOUcCqqWMOOFoPU+gZ75
	 6ZpI0pcdAX/wkHY7tYa7ayP9CQfOr5BzdSEsFp/CWlUm03YKa4+tJx0WkZcvN+ifYUYIx
	 4JYStGH7B5eFZEAlVyUHE87yrZWaVZhIuCd2RJ/Rid+pa/Nl3EauImZsmOQZRdrUeXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=rfoJ05UONkmwL2VwlQYGmz6+VLrAyTICL7RfJCuaVwE=;
	b=j97ZbucQpBwmL0VoTKB+T7/JEUDqgoWwwKhFwgzFb+yEfPrBO6durEkAyOhRoiUC3yIj
	 +cyvGwQJGJk2fjvl4uf6/BQRsLunkjCTPTp4xZ2uKMYOSwBuzihWhVqocj6E1sxqB8byh
	 WK/Dq2th/oKaPlmqCBelghwHI8FoQxwrRJFVO4EqAp1t3JQia5aIg+1Sg6oBE2ABXtxwX
	 aPcNCz28Hj0oZFIFsOfpGhrUvXyDmPl0O8+1WXApB1hgdR3njiFfExBmQH6w6agaktZVR
	 LZL4//2EytcjudqvJtz+3uca9JnxNyvHouuMMlP+/+u1e9koL28I2+BGLyIHgttr7hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=goQQtm4q;
	arc=none smtp.remote-ip=74.125.224.136
Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE23606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 19:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE23606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=goQQtm4q
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8b0c81dcf98so3464297b3.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792612217; x=1793217017; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rfoJ05UONkmwL2VwlQYGmz6+VLrAyTICL7RfJCuaVwE=;
        b=goQQtm4qVsIdcw0groGw6hqMcB3SQa/Z4bQ20PwJKf8Rv6WFQJgPFRiA1hteBDZCeS
         gsWC5P20bRBiDI/gBfL6YqjJ+W8ofEetzDpyLAp/8t7wBZVwciOw9iCtdxjzD23LcWXp
         VvL1kZqz9a6DKpffHdurAZtrtCSuKKTOtZurqYALIR/kRh53Vdu8lntJsJHylM8X5eFW
         eqYjppKuKAREzt/DyG8uBijR2qYrTQ5UoJuETr6C/2HEiTgy5jPsylbYHftKp/i+T+7q
         s/JCJ0it/OyzfY3dD+cJbXriL69Tkeu9rjVzMiWXfwQp4kraYGIvaXL/fCVtTC+xyxQf
         gDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792612217; x=1793217017;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfoJ05UONkmwL2VwlQYGmz6+VLrAyTICL7RfJCuaVwE=;
        b=Jff/b4Ff2r/M6HMpsLL5SYSnXRVIfJmgbk+FIRi6uvJDv+K+d+inTpcAZWHmISa3zI
         YxeoCNw2+JdJE8R+Y31fIqbHhUPf3yyImvB6J963fPCPHPWe2ImKJk6jX+6U1VLI3b7P
         lp13+fGJAve4z0Xgh72Z5dKOrCFgSVOB9XUNmRDn/qVbOngIi6pEwBC9tttwxo8QQ60J
         bDoh+dewrn2wnrpqDboJ/5fDnHALpBtASVbNnm85gyCWV9L5k1xpdRTpoF4V1KbWozWz
         phKrYgZBRK1wOSmoeNksUCl3d/TWElmtdTtEYIGh23mgs22N8hSD3lxTF2Fdrd7wP580
         0qXQ==
X-Gm-Message-State: AFq9FYK88T7hekH550QwVo0u8fRtCfvPrNO/QgoqEI21J2oNM3jW0/li
	pDkozjp9C64Is9pA6550Fy+OCjEfwR3TUFLotBaBxnwz5EX3D42Hb2pY
X-Gm-Gg: AYBFou1RZ1juT3asqb/x5QvwuAtai77eCK2qFttg/F3nohN7JNkseETPZLebE57GICX
	xUfJg/xQEFO0xU5kEwuycHR/5wJE2Q25QuKhVWICQCUtsJIWbKJ/GlIPm3DxClEAM9lYzLMjEyx
	U+Yh4XoXjUBw0vA7sjm0O9pi77ajK/gxqoi/04/+fCp5MzIB+fMokBtOE5O+uSgBuAFu9MoYcBN
	XHQ3ziMaPIItU+cSDlNKripmVjHmQxiDTYneoOI9rrpQ5XMcIKNQayv27Cs3iqMNKVOmjWUdsRs
	kj5Ng7DdSRz0ZqykyUfH/cFwbNFlO4fnHf78Bt0+ymr6roouR7nH6/f0ThZ/A+sxxwTr8/gaPhl
	nxelJYe8om9J5mbkdfxSXzEOL1qQ8Hn89suRSkwReAn+KbXM3grbHtbF6v6xWOruvWyt5GtHzF5
	+5PIs2OXD49rMlxSzPpyum2Xoti6M89chfxltcZ0lf+VT3rtwAddhzoWL8n55GceSOYacMZblQI
	oRA51RVKpKGS69YHfzg7wTsmTTAJvs7s8jNp7cN5QNoADThgOfQ/+lvyLnU8FKTgFb0Du/lKW33
	0NpXy+HmE0CvxqTcOogGP/u6ZBaRugOSXm74iJqxxTvTtyGHdgEoM3eaKi9e5tQ=
X-Received: by 2002:a05:690c:6d83:b0:8ac:6e11:3dee with SMTP id 00721157ae682-8b133c990ffmr18942997b3.10.1792612217411;
        Wed, 21 Oct 2026 12:50:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b130074aa6sm16117427b3.10.2026.10.21.12.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 12:50:16 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 21:50:15 +0200
Message-Id: <DMARZV0CMCU6.B7GRUVI8S0WT@gmail.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <willemb@google.com>,
 <eddyz87@gmail.com>, <edumazet@google.com>, <john.fastabend@gmail.com>,
 <kuba@kernel.org>, <horms@kernel.org>, <liamwisehart@meta.com>,
 <martin.lau@linux.dev>, <pabeni@redhat.com>, <song@kernel.org>,
 <netdev@vger.kernel.org>, <sdf.kernel@gmail.com>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kuniyu@google.com>,
 <emil@etsalapatis.com>, <almagui@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Mahe Tardy"
 <mahe.tardy@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
 <20261020155848.75711-2-mahe.tardy@gmail.com>
 <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>
 <atkG-5eqB8LfVxSa@gmail.com>
 <CAEf4BzYA79tg5C+uzo3S5=MRgM_O7VMYtOwW59QMieJoFNOpVg@mail.gmail.com>
In-Reply-To: <CAEf4BzYA79tg5C+uzo3S5=MRgM_O7VMYtOwW59QMieJoFNOpVg@mail.gmail.com>

On Wed Oct 21, 2026 at 8:57 PM CEST, Andrii Nakryiko wrote:
> On Wed, Oct 21, 2026 at 11:39=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com=
> wrote:
>>
>> On Wed, Oct 21, 2026 at 10:56:23AM -0700, Andrii Nakryiko wrote:
>> > On Tue, Oct 20, 2026 at 8:59=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.c=
om> wrote:
>> > >
>> > > The motivation is to plumb more of the socket API into ksock, thus
>> > > supporting sendto() in addition to send() which makes a lot of sense=
 in
>> > > the context of UDP sockets which are the only type currently support=
ed.
>> > > This is useful when ksock is used to reply to specific addresses or =
send
>> > > to multiple addresses.
>> > >
>> > > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
>> > > ---
>> > >  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++----------=
---
>> > >  1 file changed, 69 insertions(+), 27 deletions(-)
>> > >
>>
>> [...]
>>
>> > >
>> > > -       return ret;
>> > > +/**
>> > > + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a =
remote address.
>> > > + * @ks:                The BPF kernel socket context. Must be an ac=
quired reference.
>> > > + * @data:      Pointer to the data to send.
>> > > + * @data__sz:  Size of the data to send.
>> > > + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or N=
ULL to use
>> > > + *                the connected destination.
>> > > + * @addr__sz:  Size of the address union, ignored when the address =
is NULL.
>> > > + *
>> > > + * Sends data to the specified address, or to the connected destina=
tion when
>> > > + * the address is NULL, best-effort and nonblocking. This may sleep
>> > > + * (kernel_sendmsg), so it can only be called from sleepable BPF pr=
ograms.
>> > > + *
>> > > + * Return: Number of bytes sent on success, negative errno on error=
.
>> > > + */
>> > > +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *=
data, u32 data__sz,
>> >
>> > This would limit API to fixed-sized data only. Have you considered
>> > passing dynptr as a source of data, so you can send a wider variety of
>> > data? I don't have a strong opinion whether we should add a separate
>> > API or convert this one into dynptr, but I do think that having
>> > ability to work with variable-sized data is super useful and should be
>> > added early on.
>>
>> Oh wow this is really cool that you send this now. I was working this
>> afternoon on trying to see if a ksock sendmsg() would make sense, but
>> with these static buffer limitations as arguments, it actually didn't.
>> I'm not familiar with dynptr so I didn't think about it, but after a
>> quick check it looks like it would be a good match with the ksock API!
>>
>> As I understand, since bpf_ksock_send() is already part of 7.3, it's
>> best to not touch it, and having a simple send() available with a
>> fixed-size data might make sense.
>
> agreed
>
>>
>> But since bpf_ksock_sendto() was just merged, we could make it evolve to
>> use dynptr perhaps? How much time do we have for something which was
>> merged yesterday to be part of a release? Is it going to be send with
>> the 7.4 pull soon?
>>
>
> I'd send a follow up in the next few days, it can go in as a fix for
> kfunc in rc1 or something, unless others have differing opinions on
> this
>

Another option is to add dynptr variants of both, a pattern we have in othe=
r
APIs as well, so there would be no rush. We just have two more kfuncs:
bpf_ksock_send_dynptr() and bpf_ksock_sendto_dynptr().

>> >
>> > > +                                const union bpf_ksock_addr *addr__n=
ullable,
>> > > +                                u32 addr__sz)
>> > > +{
>> > > +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr=
__sz);
>> > >  }
>> > >
>> > >  __bpf_kfunc_end_defs();
>> > > @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
>> > >  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
>> > >  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_=
NULL)
>> > >  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
>> > > +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
>> > >  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
>> > >
>> > >  #ifdef CONFIG_BPF_LSM
>> > > --
>> > > 2.43.0
>> > >


