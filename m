Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38740A929
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989928; cv=none; b=acdbzCD3iusYJtI9/16x85M2duCezU3hnsuH9lXC5zOZlIpC+zzHDY4IhxO/22TFI/TcNKezJNw2WxQ1ANWFbnfjIhcjIsq2ICB4bqfvI2i61FIySr3L5vn/h2K83P0AlriSSmQVUKKHpUbduQF13bVrwqZ3xp6rgTiYRjPrEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989928; c=relaxed/simple;
	bh=puxzEXMJ5f+iK1f5IpCcEBy0jnFex294QxePdLIuumU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=un4ONj23y02CecNS5K5bP05tnAcQ7b3VBy9IXdWH9uPssQW4WmndMw+SpAxWKhrzQHV9qSm6lIkZMjJVXM3ql3YuEeTrP2HCl83k2CpHSARqyYwRwcS1Px6o/jBc4uOHbOcVWSR8POTrDrn2hB39PIOuBEliudfo2iZkWpLSGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBIkbfdw; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBIkbfdw"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-6a1f7770a3aso816664a12.1
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989925; x=1787594725; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KYXKYw3ZJODb57Rt3eF8E0ND+mpiXq6EWIJdfMIbgcI=;
        b=EBIkbfdwJBEFjyCFQO7Lq31lAYvDYdI/b8R+q/5YDBoDF1eWHN1rTZaqWWRdNQ/mbj
         ZLTmt3HFWw38SgIpXpb9utrD2cV2A4HuciIjXQnH/4FhQEnE+8adoSyUshF/d1UdNpGs
         QN4kZDZL5h5RAZpr82knu7dV1lx7Ero3385AkirS/yi0IvKPF9tXExcIkachu3bIDyRo
         gx5pVA1aSczB0NmjQl/qzffoUibv2imLiB+nd2YQlXyQfOtDnnoUYC2cjAw9IvbML6pj
         PBdbPlR51GqWWfGhISa8KnLPt9lMFYAQNgexX3RF/UKatjWw00Dc10VDZSAXbTnx26e5
         3rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989925; x=1787594725;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYXKYw3ZJODb57Rt3eF8E0ND+mpiXq6EWIJdfMIbgcI=;
        b=sly4YKPXqixhEv1RlBKav+5cvT+dupk11Rkts0LDc/F7XEglk6GMGJsdo46AaiAKx4
         t3rGsHnGt1J9mQmjO+jd17LScCXB5CJr9iCCd1sswJ0/F9HEbQnZdO39/rGt5nQuIOFT
         HvjajWVXtl29I9P71m6IumQK9z3qiYha4xB07yBfNVBvuivgZU02SHenLnMaf5YMZaKN
         abN/+ZdYFwROwxgRjAi4282xhCtbGWxurqPM9RCCR1P0xMuqEM88se8aOqo8ykFPVdIK
         bZx1KgMMBTmFqxPBKhxg1Hg4BI52379XeH4pf41sVgX42/IKFKcWdlqIYgjcEktwoXsD
         Zrzg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8AzOf0mFqXHSOkaWDEvmrBoAe7L6hm7XP1SZvS8+mIUIAODD2rF1/EGsRJycHd7vKG2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EGLIi8hPj6O50fs0bZeUloZvaUJZSD1uOgj5tdC50hVW34/3
	Z/ZWZEfUin4nWHV1bUXyxf1HoFi4UJpl0QN4fvX5v0xxmZ/TOkZEhTkv
X-Gm-Gg: AR+sD10zk/s1Ry4gZDue3GYQmHW6IFm4nOsIdQW3hjTAKIfbhTNzNCtCMWKfAUrTX+f
	8Ao4yytTdNVjk98qzdTjqYh6j0sLEsLV4UTnpPxtrxwT/nSkMzJnQAMLOJzLhjKGOcmhpNYz/kz
	oxJbi6q8ZGjnkSfRcfx/k2/svOy2TyQ/9rELgMPOskxYREWejNBZs7kOAWtVCkuq0q3PEFG8IT2
	iS2KIchhuhrXOz3JUZES4tVKoY9OFiC7OKgUinnGiAL/DkVLEzHBurLdeUOeKBvVgJA8faXxrZX
	SWrcfs/26LSobceKv4/GGa/fuyvnp/CWVFh+LpyECTMEENpvqXH4LYLW857CSuo+gmNubxUKsXc
	TYJXBK0PcRUwmw1D3ev1FbQsHYoj9ZSDFEIgnCXiqFuSz2NKxu/NdHu+eouQU2GPCW5AbtfYYI6
	DpH8oYJq5qUobhlgg45b9MO0HI8aoBAxlKcOMfAMww5EWu5pn8Uj00c+48Vb4LNYb6fI36nSgIn
	UUfp5pIuu2Jnk2RKw/uzJRtxMJxyeciaU1+QiJ9yddDwIqLcgm4BVW28SO4Yc5JlvZrtFUyU8Kl
	2muk/Xj2es+ZZqKn2WapPg4bCRM=
X-Received: by 2002:a17:907:3cd4:b0:c20:a243:9a52 with SMTP id a640c23a62f3a-c218ab5bfe4mr63468966b.0.1786989924403;
        Mon, 17 Aug 2026 11:05:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2187c83829sm34392966b.41.2026.08.17.11.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 11:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 20:05:23 +0200
Message-Id: <DKRF25OV39DP.2WZYYSKICG68H@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <etsal@meta.com>, "Changwoo Min" <changwoo@igalia.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
X-Mailer: aerc 0.21.0
References: <20260803001807.646357-1-changwoo@igalia.com>
 <c9f8616b-15df-4c5a-8184-bf4d63813afb@iogearbox.net>
 <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
 <CAMe2y=Gm9K3cwsM7Sff3ZaKani3z4tVUQv9u1KzbetJF8OrW=g@mail.gmail.com>
In-Reply-To: <CAMe2y=Gm9K3cwsM7Sff3ZaKani3z4tVUQv9u1KzbetJF8OrW=g@mail.gmail.com>

On Mon Aug 17, 2026 at 7:14 PM CEST, Emil Tsalapatis wrote:
> On Mon, Aug 17, 2026 at 9:02=E2=80=AFAM Changwoo Min <changwoo@igalia.com=
> wrote:
>>
>> >
>> Hi Daniel,
>>
>> On 8/17/26 6:05 PM, Daniel Borkmann wrote:
>> > On 8/3/26 2:18 AM, Changwoo Min wrote:
>> >> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
>> >> every translation unit including it emits a copy. __weak makes them a=
ll
>> >> resolve to one instance, but bpftool gen object merges only the symbo=
ls
>> >> and concatenates each input's .addr_space.1 bytes, leaving the surplu=
s
>> >> copies unreferenced in the linked object.
>> >>
>> >> libarena links ten such units, so nine copies were dead weight (bytes=
):
>> >>
>> >>    object                             before       after
>> >>    -----------------------------------------------------
>> >>    .addr_space.1 in libarena.bpf.o    676200       86376
>> >>    libarena.skel.h                   2100123      892371
>> >>    libarena_asan.skel.h              2641124     1466477
>> >>
>> >> Declare qnodes in the header and let each program define it once:
>> >> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
>> >> lock it guards.
>> >>
>> >> Tested with test_progs -t arena_spin_lock and -t libarena.
>> >>
>> >> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>
> Hi Changwoo,
>
> Sorry for the late reply, for the next version feel free to add:
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>

Added the tag to v2 and applied, thanks.

>> > This doesn't apply cleanly, could you respin against latest bpf-next?
>>
>> Sure. I will send the v2 rebased on the HEAD of the the bpf-next tree so=
on.
>>
>> Regards.
>> Changwoo Min
>>
>> >
>> > Thanks,
>> > Daniel
>> >
>>
>>

