Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F844F561
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243784; cv=none; b=rjXSgrIY3aluG139N5mpfUy5emjsvFT2JP5ELDKOAoZVp5EYn2ct3B9XauEih6oc6aihgwdO/vT4BlPYtlrGRJTOlnnxuIuMEeqZneNlswSPJjotSsP+lVzDzyCYcB2axFU1XeJIa/0SgUmo5HaMMb5e55ZVvoqw9bsbymNyxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243784; c=relaxed/simple;
	bh=pIk+jR30Onm5QcH0mKygT7waW2zVesO7QBFMwF/SwP8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=n9qkZ3ToL0qhUJvXAi8BzIyCNicu1igjY1UL/9kYSHvswApzKMRDUYrB4h5ViAxvIrHZNB7Ycfot7MIO6BPXBS+WuSKAavT9ED0iAR+MzBvDF0KYjJ6u6n0okjR9oMRBTO6Z46gZ6L9iKKjJtQIvf9wADHVtaPmmhEzUeI37uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9/HFoFw; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9/HFoFw"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48861ba835cso490840f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243747; x=1790848547; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m28l/QNvZiPjg9uPHhVPGv2lB/hFI5iwpIldJ84fSb8=;
        b=T9/HFoFwlkkq8ZR2wJq6kAKxFJ8oKNsnV3LB8PpM4zU9gKP5hTqHz6D2PpUreJ0+HN
         QvdBRipqkl/hY2ZKsL/nKqi8lENCi+i1fDrpMZflhpJFbTOq9M2i5o1SNkcGfUIXxtYj
         2CIdPqFhZyX0Og+rpnkIYru6HXO5visv57OvGyUdsy0j0xoHQz7QnSW2fs0hCutxKQMm
         VhGidIDfNrtcnr0TlrnyCcp1J/fujaC1/KyT77X0Kz7POZz5MyBX8SJ5rnhxN2WcUnm6
         XfPRxOyvSV9Wbdh8b3ZC6idN66OHXgnSnmd0NlOvfxJDoBMNNCnOLPQ0PVAg/HxfppWe
         BrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243747; x=1790848547;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m28l/QNvZiPjg9uPHhVPGv2lB/hFI5iwpIldJ84fSb8=;
        b=R54pZFoTjxVCwrrY6yeV5bjfHaeIDNFnj+hTs9V2T+iwkf5SpXIiyfA48UN/N3Z14V
         yRJ+W2CMr1BGyv04NdWtxTZom6lz5q+yZD040PDof8vlD2GZP5xAO1iQ7hlJYv9IdtCK
         Qhugk2h2VaZA4mgLaE4v1Mo5Sn2STyhFEZ4e0BqwW3rxRG1jRE4lameSen70CwWYpU/w
         WsEbL9NBixEx4LyvXnGJNh9okLg/SvYeJVocG8sAH1+eMAnEhjb/N77wokmylozekR8G
         HDicOJkGkGwP/Kjmd9KO59LjR4qtp4Zf6TicnZzE1Kt2A2RA4JvABpWBHYoEkaR4DmFU
         Tb3g==
X-Forwarded-Encrypted: i=1; AKwUvBwDlZzHGw80+gDdmEHLGN0FLSBv1S8bYBLhDpjBEJCItMyB/ZxfkvkAFa0SaEL8O+6g/8w=@vger.kernel.org
X-Gm-Message-State: AFuF++kewLM0JG0aJMYa1iHoyrJr9pp6jvRNnNoTuIJSnw8DAThAp8nE
	WzyeJPZMu5VgOUgEyXpfpH60nnn/plYja0VF4UjvZXBQI/wAvlb8g03yYGA6zM5A
X-Gm-Gg: AYBFou3vxHX7WKvnQw376Mg2s7X6k9SOXieLReG8NzBUgitGtofU/TmsceiGFww0VyU
	Mk8epwn0MQiAz5h3uiH/sTb1Fci3LXwCSNFFWKCRr3J95NrAATHUL8gAYp7tSpkDl5C1/MGXVUv
	0Ey0CIDv7Rfa3L/gPXi2UYokq8aBOOx7dgdW81bD3DGJdEyCHJVPdA6bv49l4AI0xWVj7LpQ2jj
	bK/X5J8BjcZI2sBN8Y/6A7OSX5QU0XdS0/ov01C6FvU8BYboAiM37413Q5Gta/T0ku+s11CGCOs
	Wf0gVQuk6wp0kzgJAlDrmHhYOC58DV7jxJWW3ZP4fiAFEEPIOZ5Swzy1vLyG8pg9is69PtLp/8E
	AjEi1Y2jPxa0Hd7yRAthomH0shpfuD/VK0cF8hkiPwJw9bnnPeg1F2nnLQYvCmbZAU6vOhZm++S
	p39wGE4Hy+IzAyOcdp8w7X1FVhHEGoVjJHqKtRcKg/naRCcW7+q12aIGlAonJWSBDFrAXjoVfqU
	javcVHSl5CqBxWKo0sRbVApVs5Aakw3zyTZfvWs9QW0YN7gIzYaXFmVc9ttMJ2p5KYv4JORieUk
	zZSi+PbjbjYLF4gQad6RimNhoOg/aAo4s+oyoA==
X-Received: by 2002:a05:6000:310e:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-4887170cfc5mr3786531f8f.7.1790243746820;
        Thu, 24 Sep 2026 02:55:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c119sm14764465f8f.15.2026.09.24.02.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:55:45 +0200
Message-Id: <DLNGFZ3CTNOY.VXQBGFNVON3D@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 08/18] bpf: Grow the verifier id scratch on
 demand
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-9-memxor@gmail.com>
 <137d352e6b635833e3e69d9ef6215e7674b239c05ae0a7a0efb0e6b492669696@mail.kernel.org>
In-Reply-To: <137d352e6b635833e3e69d9ef6215e7674b239c05ae0a7a0efb0e6b492669696@mail.kernel.org>

On Thu Sep 24, 2026 at 11:13 AM CEST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index b314b9425b86..3ff1d4f753d3 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8b7f2c283e5a..aebe2e6b2a3d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -18898,12 +18903,13 @@ static void idset_cnt_inc(struct bpf_idset *id=
set, u32 id)
>>  			return;
>>  		}
>>  	}
>> -	/* New id */
>> -	if (idset->num_ids < BPF_ID_MAP_SIZE) {
>> -		idset->entries[idset->num_ids].id =3D id;
>> -		idset->entries[idset->num_ids].cnt =3D 1;
>> -		idset->num_ids++;
>> -	}
>> +	/* New id; one that cannot be recorded counts as shared and is kept */
>> +	if (!bpf_id_scratch_reserve((void **)&idset->entries, &idset->cap, ids=
et->num_ids,
>> +				    sizeof(*idset->entries)))
>> +		return;
>> +	idset->entries[idset->num_ids].id =3D id;
>> +	idset->entries[idset->num_ids].cnt =3D 1;
>> +	idset->num_ids++;
>>  }
>
> The comment says "one that cannot be recorded counts as shared and is kep=
t".
> With the old fixed array, once num_ids reached BPF_ID_MAP_SIZE, that was
> permanent -- every subsequent new id failed to be recorded. But
> krealloc_array() failure is transient, and bpf_id_scratch_reserve() leave=
s
> cap unchanged after a failure, so the next call retries the same allocati=
on
> and can succeed.
>
> Consider a scalar id X held by exactly two registers, with num_ids =3D=3D=
 cap
> when X first appears in the idset_cnt_inc() pass of bpf_clear_singular_id=
s():
>
>   1st occurrence of X: reserve fails -> X not recorded
>   (a later new id Y: reserve succeeds -> cap doubles)
>   2nd occurrence of X: not found -> reserve succeeds -> entries[] =3D {X,=
 cnt =3D 1}
>
> X now has cnt =3D=3D 1 even though two registers share it. The second pas=
s then
> runs clear_scalar_id() on both registers. This is sound, because the clea=
red
> state is cur, which keeps being explored, and forgetting a relation only
> widens the abstraction.
>
> It does silently drop a real scalar link, though: sync_linked_regs() no
> longer refines the second register, so a valid program can be rejected wi=
th
> an ordinary verifier error instead of failing with -ENOMEM. The outcome a=
lso
> depends on allocation timing.
>
> Would it be better to remember that a reservation failed during this pass
> (for example a flag in struct bpf_idset) and then skip the clearing pass
> entirely? That would make "is kept" true in every case.
>

Fixed for v3: when the id set cannot record an id its counts are incomplete=
, so
bpf_clear_singular_ids() now keeps every id instead of clearing any.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

