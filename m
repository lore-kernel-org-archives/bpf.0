Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60852FE2D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191771; cv=none; b=XhYupNzdKVuMYsfr2KTtcFWBSipuEvPVaS9sUgLezbG+MN2YFDcNXF2nmF6SuHeAU1f3mSLsEKoiNwbqBn1xXVNTDRUMXMA1Y0T1JIelZYGxXS3sxSEMmJq2T3aZSgIzicmbyGKEFhXOw2SYjx4YidZA4ARFWP7qifDmImjvN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191771; c=relaxed/simple;
	bh=54+iOccS4wvS3KEHskCddFEnm7kmenUIqpDRw31AZAc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=l1BfiUSyhfCjRa+26kHEIFJPdqsrLeyYtcfpqED8Z6PteviF8z8A4VO5AHRKVU0DaZpzBhpOIssbSi5fGDY4kiYi3vLiqsgt5GIojo+MO7UUwtxnHANIp4kuadaSRQnlFMiVuABPUN4uL4QEy15TzZ3lwevW4B998dSGXYb4yqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaNbQhq3; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaNbQhq3"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso5056285e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191768; x=1790796568; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4XqmhhXP0A/R76xAAP865zT+LyEnQax3kp6jk0z97rQ=;
        b=YaNbQhq37oKtQD7PlnNaPyW6R0b7wpGxCqsQRm7aVRhYBSoInInxouRvIdY102VK4h
         IsvsejOr53EIv1iRPOCznKatz0skC10Qjhp/qWQ3Fi8IsoccDRVKCvemDwfSK4c2qIOG
         NVlqiuSQ6pT/xIohWVC4lx27ufU/SXsyftEk3cMx5UM3NV14PK3H5557YEHDUQjWICe6
         MXk4jRnEwh5I1aGRP/5Ee8liZyetQ38swBdzLyv6nAfuCOdkzFLxrgqRRRVOTApZbx60
         F+nY6ChbBtD2hdo6fSKg6oBDmzC3b/XxL8V2LyaNDXV6hJdGiaTHGT5JMw7Jwb/VUuqJ
         YLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191768; x=1790796568;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4XqmhhXP0A/R76xAAP865zT+LyEnQax3kp6jk0z97rQ=;
        b=b0Z5mCBHX19asVwSJYTJdytcyugFiycjRoVyuCpzLP15Mddrytp4bu8Zsp00GVtPO7
         KD/b0MMqQyf1sxsfrL+jFzFpZnbWXXfU22/D5zBbcLGQOT6Vsdi+JjKZTbB1VVDyAxgn
         S2BBGaEZkfAXkKxvatTyLy/VetAS55M7NG4vjGhbRunLb2oSzNTxL6VspVevB1t7lLxt
         lmsUD9i7qHx51xTwoOWbrjjL7HlVtye6xH8MZQ6RBeob3V//8p3dsHvSfIw2cUkn1sj6
         7AERPp5LEPNrTOXgJ9Jg4av+y+aXIR4ccUocfZBzARwJBJMtXULuz71MM/PDy0BrATgx
         cF9w==
X-Gm-Message-State: AFuF++me65giU+EowuqaNIyostTf2gUngwXLjX6Shw/gSWVxSB1StSrN
	UJRZhWQPdVWcKb/Rd5/T3FL2jyrDNC4lp3bZmzdeUmzRkq6i+xkkOyAfaWENMCcU
X-Gm-Gg: AYBFou0Xa7qhHoKHxahKyzOYpwmp/+8rx8I1fLBBbGTwSLaXxX7YEJd07liWjr+2GC1
	mXy8SM7IPYxk8WZwt7UI+eVqud7BTJBC48xudguHJ1nL1c9Kdxy5XSKLCdBi/N+Q5V1nkQsf7+9
	iVlX1utAmc/rPp9+wSxEVVZo1LVT2ZhlFct9YJzq9iPuLRCmJxIdTLZ8YjI/xDSQBcx2srPI9vW
	K5iJKnlNODuwGqavh1HV1IHd93f4gDbf/Jmu7oQSZaMwcKET4xiiJw8TsQikV9SxkJbcNte1tpW
	tisOH5NxwPGaLhgoo9+JZqMVfj7XA/8XwwghziEkaKKe/Uz8Ema1Plz+5Ay+6zFP+uUk/zS6kbH
	27Qh9gKjcc9B/2wmFYr2qGadOacTPif9iqBbvn9z+uy8if8Y2oEJwWdByYR2ehXGwDMWpHl1Eyt
	GdRiMXmr7VZ4WbZvukNc/BbPNFvf7gtuCKl40+Fokke5GsNfQ3+FUvsgqWnIepK0LPMDmJU32Pv
	98s1vzXqqvNDzUf+atZuQcL4SYzYf2kglF+Q/RYgVieT/kKiXTFAb4MWvPTiplZDy9eIJbxa9jG
	KWcWqke5IYaGhA8TL3Knfr/msTGG6tQKCLvC4A==
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49fe6707bb7mr3307245e9.30.1790191768392;
        Wed, 23 Sep 2026 12:29:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688856f0sm8470163f8f.30.2026.09.23.12.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 12:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 21:29:27 +0200
Message-Id: <DLMY0OLDC2E9.20RXZ8ZAY73PG@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 08/18] bpf: Grow the verifier id scratch on
 demand
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-1-memxor@gmail.com>
 <20260923191139.2816206-9-memxor@gmail.com>
 <20260923192404.EE7E21F000FF@smtp.kernel.org>
In-Reply-To: <20260923192404.EE7E21F000FF@smtp.kernel.org>

On Wed Sep 23, 2026 at 9:24 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] bpf: OOM in release_reference() triggers WARN_ON_ONCE and is i=
mproperly ignored in unmark_stack_slots_iter()
> --
>
> commit bdefbd593b54c82f98de0288f1f6f5e793ee9fbb
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Grow the verifier id scratch on demand
>
> The id map used to compare the ids of two states, which also serves as
> the id stack of release_reference() and as the id set of
> bpf_clear_singular_ids(), is a fixed array embedded in struct
> bpf_verifier_env and sized for the most registers and stack slots a
> state can possibly hold. Turn the map and the set into arrays grown on
> demand, starting at 64 entries and doubling, and free them with the env.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d8f43f3a89912..8641f1a8d017d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10136,8 +10136,9 @@ static int idstack_push(struct bpf_idmap *idmap,=
 u32 id)
>>  		if (idmap->map[i].old =3D=3D id)
>>  			return 0;
>>
>> -	if (WARN_ON_ONCE(idmap->cnt >=3D BPF_ID_MAP_SIZE))
>> -		return -EFAULT;
>> +	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->=
cnt,
>> +				    sizeof(*idmap->map)))
>> +		return -ENOMEM;
>
> [Severity: Medium]
> With this change, idstack_push() can return -ENOMEM on a normal allocatio=
n
> failure, which propagates up through release_reference().
>
> However, in kernel/bpf/verifier.c:unmark_stack_slots_iter(), we have:
>
> 	for (i =3D 0; i < nr_slots; i++) {
> 		struct bpf_stack_state *slot =3D bpf_stack_slot(state, spi - i);
> 		struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
> 		if (i =3D=3D 0)
> 			WARN_ON_ONCE(release_reference(env, st->id));
>
> Does this mean a simple -ENOMEM during verification will trigger this
> WARN_ON_ONCE splat? Since release_reference() can now legitimately fail u=
nder
> memory pressure, should this warning be removed, and should the -ENOMEM e=
rror
> be properly propagated here instead of discarded?

This one is legit, probably needs more graceful handling.
