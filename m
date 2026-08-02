Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A826B2DA
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707963; cv=none; b=MD9WkG/zN4Vpj2ZDL0VtA3OFkDZrm/bFYQGwX6w+YbOJAC6WqcG+9KgrcHGPPqfaq9Vk41DJvQhXNyxM1qAqtN/b8BYYUp67bEYHYxlyG1xUlHM5TzErw2IccjZqDBeCrj9EvYySfFmiOExcPvOrjLGqOfULuv1+t4ZfZMxWDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707963; c=relaxed/simple;
	bh=z9y8I75bKVcpQSE0wiIGFAhmPVjrjplTWqOOMZ0H+pY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ge3K9PRrSYuab/R8u0yZACsM7P3YyN++kuKCDLjUTw78X3cR2erwD/EdiNoSHAOulQyb3yiH+y3kfJAvmULGeNWNKkDow+QMXcwUnJ49RRgvBT8SOoTBkjigc3Og8qlMOFR9pll4BTqPffZIOxacnwOQaqzXI4d3iDmU9VGXQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeL1M/vy; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeL1M/vy"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so5298745e9.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785707960; x=1786312760; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gCM0EDq28AfDVhRWJE7hyK6ntCTBWjbvr8/d0GERaa4=;
        b=aeL1M/vyMb6qY8ooDWDvi/Ax/dH0+gU+Y3oqpFZNLBzSucfbbx5EDESxhO4bunri4X
         JCebAS0pQf4Ev1SvBE/6g02z2fQhVCr2l652Z+pqeIVoEC7tl2VkOdNrxFJ37t9pa9bR
         oRc4rsgm+1DmSR06Ts5/YlV/Cx/V+D8UXCA9u1sEaM3MW2nPmACt2tbYsL32GkIL1t86
         dDTUzBWB+u/PJkzJDUxAec/oHyNZX4xrG7JTPoJA93j7nNphoyP7+5Z1sBqow95Rivrm
         7GVXLIBXoLyzMSnfBTShH3AKV3yBiEumy81Em5NvsFK+D50OERXjozLc2LRh/gfSlg//
         4D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707960; x=1786312760;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCM0EDq28AfDVhRWJE7hyK6ntCTBWjbvr8/d0GERaa4=;
        b=akvtGLhD7Xl5uO+Cah/cWNQCW3HmNQQ5FCNtzwF8+09G6icCGaq0YKRf6JjdQTVbzF
         /aReWqG1x3/fH4fkqjlWpJiwawcxK3r5zNU8x8qeWgaIt6RYEhEUeQZXrPpRq8X4bkSZ
         MZ5L0KaxxMrxe6pQkVsebrL6OkI10BIz8aCCTBPd3upjt6hQeDfcproGf0zEEHtnD+wG
         5B41IyM2z72WR5A87gRt+TXUZl4vqQfPEcXwROM4E3ntl+aT2GHB6vQf8hmBfyLs0qgc
         Wh4khOvDBY6fFi7C21iYnBJqEqzjhiRMFP6idVYF87ybMBfOxn57Uj4r0x+Ze76aElmV
         f01A==
X-Forwarded-Encrypted: i=1; AHgh+RoQkRp7wnh6ipBI2UAz5dSt1UwflxGFeTpVHIky8AlSpAt7gmoDbuvlxdFI/wc5+sa5HK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFlZAfXMICzqWl0VRJwOI0D036n7wzKkYPefX3UFRcd1BW6co
	yvh0/9LDBfX4XUjqS4EmE+fM0+VKXD6y6Ec8IbJP+D6fRyZrHXeAnx3gURB7zyyw
X-Gm-Gg: AR+sD112vAbk8Rk25mOdaj+4fTP94gd0nXMKDeSlCkd2PC9vnF3E/xOaXr9+4rxgeGA
	zI6nQJ5m694G/0chrGAurYRskyWVpLdcad+azcRLfQFEFbgSOFRA3XgzKlAtVf2j0gIsjCE/hjL
	gVCjOunzpUMZB5WOeSRvKg562ZTtLGyJmeuTlkZZYwd0JkGgQlkGf+qhRAhMtMvoVZMWd3JWdKJ
	7XQrHuKv7Kxx/Bq0mudjU1A+kw7f/ZZxn2P41e7F8g93BNCPkhMEOXhxJc+TMYVG5l/1OftYaut
	YNQ/p95YNj7AJ3Mo2TQ3A5vHhJ4USRPEPmww8xAbVXq4oVotJB5CQI6hfVaU05Lqy/9l08IPeae
	B+BsqxInxEJQtOwddhz+WaV4w3W22hoepo7NExvph8PraMMGxzCK/9+A3bqacNcM/lgttn2nzUk
	Yag7NfS4cp2bmmdPAowrJl+mx6cuuYmurGcLKCB2GTUM/Rx8rnL2Z3LLJwWDe8douzFlXNZDSir
	C8BGR7u+VaYtfBnt5AkZmKta9pw51DChKKS05orMff4Tg27XoBLbHg9ZCVJaADNIDmlZW0Qr0Zo
	rgCF1WFlm+WqWfOoQO1YLpgzU5A=
X-Received: by 2002:a05:600c:34d1:b0:495:7561:a9ed with SMTP id 5b1f17b1804b1-4980c679d9dmr179925395e9.17.1785707960230;
        Sun, 02 Aug 2026 14:59:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808690ffbsm185355055e9.10.2026.08.02.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 23:59:19 +0200
Message-Id: <DKESN3I6A9IA.270SX0UXGSEJ3@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack
 depth stats
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260801230400.850271-1-memxor@gmail.com>
 <20260801230400.850271-2-memxor@gmail.com>
 <ae774dbff74cb78cff1fe27915a9bd8fc4bd990f.camel@gmail.com>
In-Reply-To: <ae774dbff74cb78cff1fe27915a9bd8fc4bd990f.camel@gmail.com>

On Sun Aug 2, 2026 at 11:02 PM CEST, Eduard Zingerman wrote:
> On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:
>> Currently, the output of stack depth statistics is two crude, with a
>> list of captured stack depths ordered by the subprog numbers. The actual
>> subprog numbers are determined by libbpf, hence it is hard to associate
>> the stack depth statistic back to the subprog by name.
>>
>> Change the format to:
>> stack depth <subprog>=3D<depth> ... max=3D<depth>
>>
>> In case the subprog name is not specified, use subprog[N] as the string.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++----
>> =C2=A0.../bpf/progs/verifier_basic_stack.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>> =C2=A0.../bpf/progs/verifier_bpf_fastcall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++++--------
>> =C2=A0.../bpf/progs/verifier_private_stack.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++---
>> =C2=A0.../selftests/bpf/progs/verifier_var_off.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++--
>> =C2=A05 files changed, 33 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8d0635ee48c7..51ac0a9ae339 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18703,10 +18703,18 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
>> =C2=A0	if (env->log.level & BPF_LOG_STATS) {
>> =C2=A0		verbose(env, "verification time %lld usec\n",
>> =C2=A0			div_u64(env->verification_time, 1000));
>> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>> -		for (i =3D 1; i < subprog_cnt; i++)
>> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
>> -		verbose(env, " max %d\n", env->max_stack_depth);
>> +		verbose(env, "stack depth");
>> +		for (i =3D 0; i < subprog_cnt; i++) {
>> +			const char *name =3D env->subprog_info[i].name;
>> +
>> +			if (name && name[0])
>> +				verbose(env, " %s=3D%d", name,
>> +					env->subprog_info[i].stack_depth);
>> +			else
>> +				verbose(env, " subprog[%d]=3D%d", i,
>> +					env->subprog_info[i].stack_depth);
>
> That would be not very convenient to parse by veristat,
> but I'd print every subprogram on it's own line.
>

I can do that, but let's agree on the format before I get to it.
How should it look like? Prefix with stack depth every line, and print stac=
k
depth max ... as the very first line? Like so:

stack depth max N
stack depth subprog 0 <name> N
...
stack depth subprog N <name> N

?

>> +		}
>> +		verbose(env, " max=3D%d\n", env->max_stack_depth);
>
> I think check_max_stack_depth_subprog() needs a similar update,
> at the moment it reports a not very helpful error like this:
>
>   combined stack size of 34 calls is 528. Too large
>
> Printing the offending spine would be helpful.
>

I'll do that in verifier errors patch set. This is just for the verificatio=
n
stats, that are outside its scope.

> ...

