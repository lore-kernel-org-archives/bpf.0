Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451C1A304A
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785717633; cv=none; b=IaR6L5pWBGH6h6K01IIVTjATg9ewTEgqHHYY/cay08oHhs66mUdwv6gyYygibaYfBUk/A3+52i0BooeIm/0aB61CAB0Fzw2oh9M4zzJ2zAVhM2+s16f1tjqIRofC0PP2TqWmJDAs+1QET7oEoWhFhfHAdqvasQHaIh/lXv95h6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785717633; c=relaxed/simple;
	bh=/mACxZZwEKJ5gpt07hvtk/cbTmXUD15e6iSgcnOknOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=NmAZS4ZXnmB1yclc6caLjm2UyTu7LvSChBaLb3HGj3OmdMep8g1RA883QiEwRt9C3xfAfKV4H9Hr2msiROZegxDcUJ+Vsxi05xNVaaLN6OXd02e/JGCqQOR2fpOsqZM13iL3i853UJl2RkI0mn4qMe0FRT/s8FsMVTVQs8/Aphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjjH7QHb; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjjH7QHb"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so1266403f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 17:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785717630; x=1786322430; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KAVJwf6OZRJ9HJCTTVbmQgyajaZ1dQtBfrxUO9czUd0=;
        b=IjjH7QHbQJIqq3hzzvTO4TsQ49aGxq0yJOJeMv4KZ0aPyrRXb6R4DsNJHUYM6xiIyp
         lzbbHUG4ALIvkU3cpou61mH6iR4K0XIxXfUMajdy571cHbVFSJiJI9UdRvgBaLvA2Abd
         03ZpZf1LmGWGAlDyXoNrqjE+MTNfbwXdIHIMFJs7HcUlXemvuIjyC1Uwd7bxgB7y5Rae
         R9VullZZQGBf6PrDRf2UEPXFRcuoTkTaSDRoqcZUxau228H3Wgmo5qL9r+z+3eYlGYv8
         8oMsyOtPz/X0d9AX4xhNk2CzEk2ekofdLr8nn/spuIyn3cPzli/21dPKUhcqOIJoJzhP
         zDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785717630; x=1786322430;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAVJwf6OZRJ9HJCTTVbmQgyajaZ1dQtBfrxUO9czUd0=;
        b=AQy6Xc67mkVtWWG5wfQuB7O6xuBlgLb5Yt51Iv7tV6qt/jt1pX0dY5ZXAXSjmjsLMa
         QvZLEFmxndxl7GR6YPJJe4b5svPubv41erRtE4165MVrztmljx/XkdhEhVl2FLuDA3et
         7EH1l7G0gFU24qGqfG5+Woz35wby6iwc3TRsZKonoRPoBld4eKhKu6HdmxlaCPlhELFS
         eTgy6Y5+Zq95egmN9B0lOQ2Zr93jADe30GuRZ9Cj1EMZdMpyhP9yg9NyiteKCA6+8vfP
         1UAvtTUEJWn7MS36yj8XfJB/FaHtSouSBYjeXCnT2w9LbC0JoXryFE5EvZwN9S8lCDsv
         AV3A==
X-Forwarded-Encrypted: i=1; AHgh+RqcnuK6DwHnMO/jecynYJz//KfCkoN2PgwIS9PObwT51KkMm7vIgGow7QvUYnJYxI7VvGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMg+9RQpjmph/I6WtuUepTXP/6lPhRKeIz5fP2c6NZxNa01EX
	4UpYycERdfN5IVEbAwLBm+q5dBMGjGC0ssewe2XHzs1LfbFe7GhY9MUR
X-Gm-Gg: AR+sD139S6hpcQOLMbNdocNbksJtPWQWKTEIiun0Q1a8dhXNArpxYz2QUh4iEEmjVfs
	LjSrnHYLM/4IM7oYquzDgtzXhocymh0AVJhSURYCusUOXfpPpYLU05z6lLIk1H3kkQE+qNYxwq/
	Kp6/bnuWIJ6hqDWPpSFmbZlkcpV/NoTPdnPYYUWn5A6OH7Zg0m0Pu15X/Yc2O5/9+BetiwmvAMi
	DkanfrIq7GWBC0BK7vjCbP1PJ2/ugBs/U5N5ujMrACI9K0dVTVWct9/i3WTaYNxSrOAtPkO96Pb
	G4oXfBK79mVpv6ROkxx782zXfrRbhye0Y56RuDn2KnXBhDqHC6LGjulPIABpSxC0XOU069a0VhO
	RD+4xChwGIpoNBW07saOSwwVrHt0+w+qRda7vTfPUGBkMGLXiTzwA0u2lXmDryltI6QLXXqIFYb
	E40Fq6aQPBcjONUdV/z/A7mEfCi87HNXKF651pOf3JUCIUBAConolmxVBvw6ESwOR6JnOGqcxS+
	Tu6DOjCug2QT76rtDKAd9E/vICZg9Yc7ZRYmbfaABzd7LLwi54P8mwYVh8AHp3nuJeE4PPxqUH4
	EXPusYIC70xi6pcjUtg/vBC7YRwl1bRLs+EJya4=
X-Received: by 2002:a05:6000:43d4:10b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-47fd72a00bemr16278055f8f.6.1785717629792;
        Sun, 02 Aug 2026 17:40:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm29222772f8f.27.2026.08.02.17.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 02:40:26 +0200
Message-Id: <DKEW2GPED8SX.1WM65Z05MZN7G@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <kkd@meta.com>,
 <kernel-team@meta.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Show more useful info in stack
 depth stats
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260802225209.2511758-2-memxor@gmail.com>
 <02a0523b31767a3994eb6a379dfdc83217749f99f89ebc71a4aaa0d6940f45c5@mail.kernel.org>
In-Reply-To: <02a0523b31767a3994eb6a379dfdc83217749f99f89ebc71a4aaa0d6940f45c5@mail.kernel.org>

On Mon Aug 3, 2026 at 2:21 AM CEST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b274004fccfd9..3b61897ed0d2a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18777,10 +18777,15 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
>>  	if (env->log.level & BPF_LOG_STATS) {
>>  		verbose(env, "verification time %lld usec\n",
>>  			div_u64(env->verification_time, 1000));
>> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>> -		for (i =3D 1; i < subprog_cnt; i++)
>> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
>> -		verbose(env, " max %d\n", env->max_stack_depth);
>> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
>> +		for (i =3D 0; i < subprog_cnt; i++) {
>> +			const char *name =3D env->subprog_info[i].name;
>> +
>> +			if (!name || !name[0])
>> +				name =3D "<unknown>";
>> +			verbose(env, "stack depth subprog %d %s %d\n", i, name,
>> +				env->subprog_info[i].stack_depth);
>> +		}
>
> This isn't a bug, but could the name lookup here reuse subprog_name()?
> It is already in this file and several other verbose() sites use it,
> for example in do_check_common()'s caller:
>
> kernel/bpf/verifier.c
> 	...
> 		} else if (env->log.level & BPF_LOG_LEVEL) {
> 			verbose(env, "Func#%d ('%s') is safe for any args that match its proto=
type\n",
> 				i, subprog_name(env, i));
> 		}
> 	...
>
> subprog_name() returns "" when there is no func_info, so the
> !name[0] fallback would still catch it:
>

This nit is fine.

> kernel/bpf/verifier.c:subprog_name() {
> 	if (!env->prog->aux->func_info)
> 		return "";
>
> 	info =3D &env->prog->aux->func_info[subprog];
> 	return btf_type_name(env->prog->aux->btf, info->type_id);
> }
>
> There is also fmt_subprog() in kernel/bpf/liveness.c doing the same
> name-or-fallback formatting, so this is a third variant of the same
> lookup.
>

That's too far fetched, and changes the format, I'll go with using subprog_=
name().

>>  		verbose(env, "insns processed %d", env->subprog_info[0].insn_processe=
d);
>>  		for (i =3D 1; i < subprog_cnt; i++)
>>  			if (bpf_subprog_is_global(env, i))
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/307718=
45943

