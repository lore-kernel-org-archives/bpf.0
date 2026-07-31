Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA9223DE5
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537946; cv=none; b=fl2EDPZSQQr5shD2KlUM1AFa5loZSA6mWVFmrDljaU7VYlAFLubkhIycyvqa2gCHErZGC8fPHSNNtSS/EDhTXOJSTRmUvPVWHa/0ld+Ex1EXAadkuetLQvOTKYoLQZe0EmJTjqc4K7JqXygkR1/kUb66xV2mtyIuR1MmeLH/RIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537946; c=relaxed/simple;
	bh=h9Gx7FOJiO/f1k+SYvvOKCIIgfTzPzAEPJejmeM+Bak=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NCCB8CVbMsN8UQt6wxuc7BOQUhju0a+ToOO4eM35zWBx/bE729Wnoh1199XpwjOZGDy8VcRkxQ9ug5g5aOsmBzIiQqxlD/lbnt2MPfquxBTFw2EnzyJGBKzfHvVmlwruf+GC6d+nF+QVa1OPthndECY0XQH6uffr6kp/yHtRQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwVZy1Rd; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwVZy1Rd"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so766083f8f.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785537943; x=1786142743; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h9Gx7FOJiO/f1k+SYvvOKCIIgfTzPzAEPJejmeM+Bak=;
        b=HwVZy1RdJAnPTZ4wL8DdU9cd9TqQnEw4TRzVxac6peYQ+PDIfuaqbrprr7fw/h1y8F
         A/iGHY0kxK2K/h5cy3E2R1dq8IA3iPQow8q9TA3oq8bUgHasqKvVx511hR7jThcMsz0j
         qax51nlIO3U7YMYd0ZYABaUcZzu3Ew4fg8pC8y4v4KRdqW6lk4BU4VjDwrUW8CoZCqAb
         Zy06DH/HlWQ6mKKEuUyQEg1vSjDePy9/BhXvobQ+7TKgC1+UT/PPn1c8sCHiyCh6xYAU
         BAFjCyIP0IFglq3x1j3SY3zt7YJ4zuAQsFySCCXZV5DL+N6UhzP/fbZXPlQujoOrf5He
         WpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537943; x=1786142743;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9Gx7FOJiO/f1k+SYvvOKCIIgfTzPzAEPJejmeM+Bak=;
        b=buixMhMXAyXCnL5E5dLyStu0IN3m5pIp+kLe4UoipIIVigIUlwQS1zGBDDNl/F8frB
         7GpZUCK9ES70z9SXpA5p0Gd9yHGoyBL14E7O5z1bmA32Nr5O8ZVbzCdQNKG4ts6V6iVr
         b1W6uzRYW/bjEDJYKGUzR+v2WgrgU822Ir/H0Df7jF6FCiESd6G40ghZDN0fmryAnYBB
         4mR8bp/oZgHYrptipx2wQvvRdYSkw6a098urXagC+ijMHpAEcuE51N+g9RgUqpEdfmMP
         zGgPzhB+zMeF4Epz4xiH7vEcXzneV0ez4lbIzLyuacovld7hJ1JJi4dfGkBFA5p5lmhz
         KjRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtidQ7JRoUfI4P7KUy2GZM1Mxk+TRHXMpP1L02EytBB6eteh8FSFsNpoDonSbiQo5Nnww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6X5OSLp8ZaPWXqZVEJZlIY9E8nzpMTedaVOJ24S7t8DSXhSe
	u1+I5PlaC68HSJB0O0BmOj9MRVUQWADrXfxPMU9hNwY1nk3xEhd08BS+
X-Gm-Gg: AR+sD13o2QgMVKejMOMpxRdNX/YDHhPfRI2XbOvvs0rjxSV5+drIpcr6kMdJBIJU+rx
	1aYMet5pq6BMSK2RL4R0YCr1ji8g5nMSbVD/CKuyuTYHUGHN20RHteDqe5xhQ+0RdHRVC5wUulO
	kTuKMYdcwd3ZKrW9KeQJsO+UDlyrlRtWDK4ZcMdxmuDuNt9u2+QnL0LCSZ0WAC1rTzIhEwLNqBL
	V8Y64obpJR9yMumLNacRXZ4ppDX2HzSgXLNEtG+VB+sS6oAvwTUENbPJF1mvWD/WYXk6143tlet
	HA2s5KtfPEH1KZGjHG0G/gtLh/tyxYLK/tpF8m7Aq4bIx1LPtlmTPNsCThhtUEgfCKu4KmMsSIH
	K4knOdTx2qYepAKr3O4fJhiwNRhddvZ781w9uk1MXdfz/5cl+Bn7d3qYWrFaI40eznBwKMCS+vq
	JA08i0SYgViW81ptXXEglpJWo4PnnOg0fNiG27S22t4vWtxezuGEXmMINDRgmh9IDW+8OgZ+S5V
	ExqmaC2EI4iZZi31qIYbTu/cRav1XnZdJ2kuMksgqfiT0494QCWyg4Vv8tLKajAVoZiYkaiaf4e
	tAIOTHORF5uabHwYlZgZkrNLEzQ=
X-Received: by 2002:a05:6000:186f:b0:47f:93fc:2d32 with SMTP id ffacd0b85a97d-47fd7317951mr2820819f8f.40.1785537943005;
        Fri, 31 Jul 2026 15:45:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm10773482f8f.33.2026.07.31.15.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 15:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 00:45:42 +0200
Message-Id: <DKD4DITNPLI4.3FIHRN0PC58RW@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek"
 <omosnace@redhat.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Casey Schaufler" <casey@schaufler-ca.com>, "Paul Moore"
 <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
 <45d2738f-de04-43cb-b37f-4370e6232678@schaufler-ca.com>
In-Reply-To: <45d2738f-de04-43cb-b37f-4370e6232678@schaufler-ca.com>

On Sat Aug 1, 2026 at 12:27 AM CEST, Casey Schaufler wrote:
> On 7/31/2026 3:04 PM, Kumar Kartikeya Dwivedi wrote:
>> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
>>> On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
>>> <memxor@gmail.com> wrote:
>>>> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>>>>> On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>> <memxor@gmail.com> wrote:
>>>>>> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>>>>>>> On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>>>>>>>>> On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>>>>>>>>>>> On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwiv=
edi
>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dw=
ivedi
>>>>>>>>>>>>>>> <memxor@gmail.com> wrote:
>>>>>>>>>>>>>>>> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>>>>>>>>>>>>>>>>> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul=
@paul-moore.com> wrote:
>>> ...
>>>
>>>> I think you keep forgetting that you cannot unilaterally decide this. =
Both VFS
>>>> and BPF people have told you that it does not make sense. What was cle=
arly LSM
>>>> specific code has been moved under security/ already.
>>> I'm charged with doing the Right Thing for the LSM framework, and in
>>> my opinion it is in the best interest of the LSM framework that the
>>> kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
>>> VFS kfuncs live in fs/bpf_fs_kfuncs.c.
>>>
>> I think the "Right Thing" would be caring about your users and the proje=
ct
>> moving forward, who want this functionality, and figuring out the best w=
ay to
>> make it happen while working collaboratively with others. Life is full o=
f
>> tradeoffs.
>
> It certainly is. Paul has taken a stance that supports the ongoing mainte=
nance
> of the LSM subsystem. It does not have a stable API in support of the rap=
id
> development of Linux kernel features *outside of* the LSM infrastructure.=
 That is,
> people like you. If LSM hook implementations were spread throughout the k=
ernel
> code it would be much more difficult for poor hobbyist LSM developers lik=
e me
> to track them down when making changes. Changes like the ones you require=
.

I would recommend reading the patches before commenting. All LSM code is un=
der
security/ (patch 2), as it should be.

> This is about being able to continue supporting the latest and greatest a=
dditions
> to the system. Like yours, io_uring and the network protocol d'jour.
>

I don't know what you're on about.

> Please don't lecture us on collaboration and trade-offs. We live and brea=
th that.
>

Paul is free to take a stance for LSM code, just like the BPF maintainers g=
et to
decide on where BPF related code should live. I'm sure you know that.

Thus, please avoid justifying his overreach on where others maintainers sho=
uld
keep their code.
