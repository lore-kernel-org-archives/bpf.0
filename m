Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174E30DECC
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607170; cv=none; b=GQFqcSH0kSohU4qXPVjoGTBkWIMn4DVBkP5Q6ohDSjd1qTul0qAegG88nbHdcM3uggZAfA7HaFex3kwHEH/5IigV/LKw6xrcFr+rv/dNBdRZA5+yTkO+ZFZrWqck6dXC5dFGRVbbxSauIW44ivVBJ/dmXlP9EyKqI3SPX40wyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607170; c=relaxed/simple;
	bh=nEDeg8RQOkm2Gaqk/WuwGAfuC1yRAKD18FQaLBZLh70=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ccjZc98eGWp/b8bAfPx+/f/lwxbrC1HYxlC7z7M/OFagER2UmsoxOovfhTZZU8eyM3/ZjTwq0FJ8aaxMcr6ufW8aEnPJnbJ/As0KfNGuuyBcCfKdShEyDhd3EG6wV7d1XF+qVFqsVDkiJ2n5ooQI3QCZq3D5faTxeQnmOZh1KIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sO9Dq2S5; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO9Dq2S5"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so365015e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789607167; x=1790211967; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cHLQj9XhR1dDka08qYnD5LGPdHB/UWEa9ar7XHmyFEQ=;
        b=sO9Dq2S5p37bna0drncct28GW3pO470ya/Bzynpmo0j3XETnXoMt7Rkg2BVNJ0EgKP
         RFJTE245yXP74NKb7tiKKpVyMYIbhifGBCLgZ0xAuY7P9sTBtG9O0Yg4BoRrkMfJ5PPG
         CjlgzwCAtiKm0YjXnckgeAgtlGCGGmpAvEC38ZvLoxv0PO4cH0NXn7140TGG+4Sby225
         UYlm3uiBOPGStR4cSY6VEW9LbKMYkX1JvZ+swqFbD/GpNZeupRXAkHMNk8YU6s8Nrhvq
         mf7R8QUCTM4hQiHHuVGhPYYe6vmYKjeMN2GrqbNKFahh3SMelpw6qkGQ8HqlxvNeZND9
         qUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607167; x=1790211967;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHLQj9XhR1dDka08qYnD5LGPdHB/UWEa9ar7XHmyFEQ=;
        b=zxgBJVIA9TQm0iyK5YxiKbwh0DYuCgkNRruc/IZHXTEz3Tq8Xh42IETY7ktIXbdBu7
         kqPyBsonleYoPiF9SDrDpd++lM+4pvDZHycAUF25UDCB98s/OzfdPwp+IhJs9bKpEemq
         i4EfN/vEkWeJPZXGK2MXW4cpgIgEf4xJ4+37lxrPys1XFH+gl2U9//w4kTTP1kp0LZe6
         DWFLnn6QhlHL5cLbWjBXGlIki1itVkDQhZdugFWmwvvhoVo7a/b2e8BihdoFDyaMIsdV
         XuXxh2aMrRplPGMKdNJZj8LF1Ma8YT/7hJ5CFIZDaLm3/2Rm6ELNSPNahbvve+xPZYDA
         hjSg==
X-Forwarded-Encrypted: i=1; AKwUvBw6hy6oDlRdf3yZ/xK3SEm+7rbKaJj3YASEtxtkQiaAelwyhzeAd/47L3Gtne1znmX9SbE=@vger.kernel.org
X-Gm-Message-State: AFuF++nYjo3Po66nJOb3bqXkyVYkWKXnr2XL0xLIF0P0oBiwWW48+exT
	0YH1TM/78IzjkzOjFW3phV/F/RSgd1jDBsCSQkV0tBYIdkbcf5HDI04t
X-Gm-Gg: AYBFou1hT0eTOZQLYvdV8b9w8nvvc2k1BFV8EsPfZJ4Jw4JhK1qH2cqEZXUjN8mLmJK
	XapdmqBI3fyba6L1vsIuj2k8rqx3EQUPw9LJQtJfkPlEnM718bn1FmXYiOBmCm8Evn4i0e1PqyG
	OF81xxSevC/L3/7d+3eI7zAeG2nv7lXgM9IN3jyL5dkDAhAsrC6A3045M9NR2hBzjCa+jmqgVAu
	972Y3tBj46+dnwpPSvUhK87CNFI/ugv+z/dGGoo0/xqRSBtKIPZPRFSO5V4P8l4DtYJ41AUUhoA
	eJLapiSCCwsG4ZiPScMUO6d2gCL4ChFOmRIBa5Kib2AqnWXp7u2Ks2VKHW5r84myQpVnh3ZGjgs
	Zo4ZLpWLHX/ZV3ESGPlgHo+s5rmhTEYOMYQ34v9TD+Y+/12jpp1YUky3iNOhk0GYk1Y42doKzDD
	N4gp7sVwln7fwr4agTJII4sNrZP6Cfftxxhgu+FOqrEmHc/QCno911Ej2UGHn1YhAKVnJf3CvAM
	O9c/7ELjy4UIo7aB9/DPcOPRvnbSciiDnCLed+PahaTe546F6kA7VFjR3pjLjt20NPRNZe7yHKO
	QZ5zE1U/N6tWXXWBvRR+3VHtikvRu/I9aIIU1A==
X-Received: by 2002:a05:600c:3b0c:b0:49f:bc28:e8b1 with SMTP id 5b1f17b1804b1-49fbc28e978mr63418035e9.14.1789607166433;
        Wed, 16 Sep 2026 18:06:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd227141sm37169175e9.2.2026.09.16.18.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 18:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 03:06:05 +0200
Message-Id: <DLH6SM4M6XL2.1OB88H6MWSRR0@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v5 09/10] selftests/bpf: Check callback map
 value lock identity
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260916212102.597335-1-memxor@gmail.com>
 <20260916212102.597335-10-memxor@gmail.com>
 <DLH6GI0M7GQH.3MTAVNEGD97AV@gmail.com>
In-Reply-To: <DLH6GI0M7GQH.3MTAVNEGD97AV@gmail.com>

On Thu Sep 17, 2026 at 2:50 AM CEST, Alexei Starovoitov wrote:
> On Wed, Sep 16, 2026 at 11:20 PM Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/te=
sting/selftests/bpf/prog_tests/cb_refs.c
>> index 78566b817fd7..490e15e7126d 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
>> @@ -13,7 +13,7 @@ struct {
>>  } cb_refs_tests[] =3D {
>>  	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects=
 referenced PTR_TO_BTF_ID passed to R1" },
>>  	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
>> -	{ "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /* allo=
c_insn=3D2{4,5} */
>> +	{ "nested_cb", "Unreleased reference id=3D5 alloc_insn=3D2" }, /* allo=
c_insn=3D2{4,5} */
>>  	{ "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1" =
}, /* alloc_insn=3D1{1,2} */
>>  };
>
> \robot voice
>
> This is the hunk that doesn't apply. The two context lines above are
> not what bpf-next has, and on b
> pf-next leak_prog still expects
> "Unreleased reference id=3D4 alloc_insn=3D3" for an acquire done inside a
> for_each callback, so it will need the same +1 after patch 8 hands out
> an id to R3 at callback push time.
>
> Chasing verifier-internal id numbers in expected strings is fragile.
> While rebasing, either drop the id from these patterns (match on
> "Unreleased reference" and alloc_insn) or at least fold the expectation
> update into patch 8, so test_progs is green at every step of the
> series.
>
> pw-bot: cr

It got mistagged by me, should have been targeting bpf tree. I did a CI run=
 in
https://github.com/kernel-patches/bpf/pull/13872, which is green for bpf tr=
ee,
so if there are no other objections it can be applied there. Otherwise, I w=
ill
respin tomorrow.
