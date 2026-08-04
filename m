Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCB441041
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832840; cv=none; b=p/zPttuhXUf8xQMrpgKk/TwePP7SpIBYBLTuQw66nbKw7JVOa3JGovksgq0ZoIp3ZPf4zsQcXePA69dZUNU34hN1roHk/6pE9JBtjToFyFPNly22jjDy1vXS/ieQpgxTN8Eecfi94yj6zI30CD81Ry/PcACsIWf/w4334DCmt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832840; c=relaxed/simple;
	bh=lUmRcKbwiL68tST9eIRY4IRwFDYQz0zVb7Gebl7IbsQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b3d7ym0KcHteUN+bHdsIZ6AJx3RiAwsloPQDAXi8wQRjZg9K1cfdgl//qxQjG9qSZQRUtCdK9mBxJyWVL+vydCaZYYWQMfKZdqYUd7rt9T/zrZWBOFL0Je9P3V4ckqlaDXTAcvujYzXy6KXQcly6mBrJB+BZAn1m0Gr/XlPDCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFHMhA+t; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFHMhA+t"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so387911f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832837; x=1786437637; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4y0dIqSdwJVySpRGuatuWHSEv+RXGkSanEMCC/wozOE=;
        b=sFHMhA+taoT0wJDr2RqHUdUQRfc9jAGHp97WBPeKEyjBFgh36RCdG2a8wFI6AXmxeD
         MSce/MqV3LRGT/HuWlokRmTUfa43A/XrQmY5NfnOIqJt9LFjwIq4BsMvI9yuktdVaUQq
         GRFjEmRaI2fRnTmaNYaCCAkMiGDDazGuukAxjKIZ3mU3PbS24gGJGQekVrfxJBCO8mKI
         4dv7OHu+TdaNWnbm8ZYA+pQCJXQWz6g78qrY574GIzDFeaj8GZT5A/ZJGHvHyFGPTnyA
         HbV6t3d7ujnDVxPNBUqAvFkbTSIC4Hpr9gUqmLLUpBqZO308B0GHsd4hjLUbeXpjVbqV
         UrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832837; x=1786437637;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4y0dIqSdwJVySpRGuatuWHSEv+RXGkSanEMCC/wozOE=;
        b=MLdWAGPQm6ildzrxhbj+BjuMO81wymiasf0yCq2cXZNNr08QQROLKtwNNg9I6UEhV1
         1mhnBwaljkHUL4icD5aGHAkjpPgsMkVAMd0uTBATWmA4vR/qyGNXKHZJr3H8jGEfiD37
         TB0O64BMjrjqjF9gTJ80A/sDhLvmwnUjzFSQX9P7gyN4/QCKcGWtpbfJdeUOJ2DSH+8W
         FmSxzxKpsbL+Xp++Txg5py1+GkBzLdiNBKUgWsD07cjRjIqCJI8QaRZ59I+FFwg9svzH
         Y/bnWEq6nIMMOmE4YSthMXk5HyAgwIaLKq4AjktV+iwBympQSj1RmQJuF7bM4zOXzuuO
         Ei2g==
X-Gm-Message-State: AOJu0YxX6ZAP8hOeDwG61u/LWSkl5qs6CyhqpnKkcRQEk3i2oevgvWfK
	nCqfJodl9S5D5fTB769CZg0035fdfS5rql1sV/XmHQt0WkcHejfQ75iZDgr29fHM
X-Gm-Gg: AR+sD12dzoxAZzKAeHFkJ4ozf94+5MX9Km+HvlQzNI673T031LnJSUqtLKk7cR25zJ0
	DictHngMSw1KXBQ8agy0+jriHWBx7+pbY6AkmVGhLkFZ2Y2vCYrXQ1MizdrOQnXIcw6Ue2Vw0DR
	Ahp/LEFYYbENN/uo43YXD6HcQ4CNXj4Z2vygCJtwG1Fb3IOgczHgKIOHvvSpT9J7q+koqMDYzYi
	tkqHwE6y0ywgZPTJ6oC0z98NA4wEh7eYZ5A0bKlYb20LEsiDXHS8XLowmqq1K9B0BfkCi2mV8Ne
	QhVKBZpu9X88vUKEmUU6LulyeHJAPaP0coz3yHpfLLwpiugG2jRKJqpTkCJ7ovsqoibHDm6U+iD
	OFWjcRKFPReB0uwEATGromBA+XdV89vu+h/aFYfrlLcJLq4SCbi73W1j6t3DR93fhBdvUel17sB
	hhmVgi/wPmvC0eAa1b5PnT8xdJNyY+uN3zvaImW44PL+qdGhMngjCaCb9pBBZSOHvxQgo8N2de0
	U8QFyoIKEP57vHDgxdUwr53IiVS9S6i6AAcM3vxfJ2zVwlAKrqUdeBmtWUyCGn0RxcMqOdZZll8
	ccRQgkoHM9WXQv5ihWQAdmVhvwc=
X-Received: by 2002:a05:600c:4f86:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-4994a0fc5f1mr51199905e9.6.1785832836912;
        Tue, 04 Aug 2026 01:40:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc6d82sm70065755e9.1.2026.08.04.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 10:40:36 +0200
Message-Id: <DKG0WN6Q1SLC.7TTOWOG4C59J@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stack
 depth stats
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Andrii Nakryiko" <andrii@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260804081114.3871564-1-memxor@gmail.com>
 <20260804081114.3871564-2-memxor@gmail.com>
 <20260804082241.8951C1F000E9@smtp.kernel.org>
In-Reply-To: <20260804082241.8951C1F000E9@smtp.kernel.org>

On Tue Aug 4, 2026 at 10:22 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditionally printing the instruction count for all subprog=
rams outputs `insns 0` for all static (non-global) subprograms, defeating t=
he stated goal of showing "where verifier work is spent".
> - [Medium] The new verifier stack depth log format silently breaks the `v=
eristat` tool, causing it to fail to parse both `MAX_STACK` and `STACK` sta=
tistics.
> --
>
> --- Patch [1]: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stac=
k depth stats ---
> commit a5f11407b8ca52d1698171e4ae37a0d5f859eb2f
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Show more useful info in stack depth stats
>
> This commit updates the verifier log to print stack depth statistics
> in a new format, listing the main program and each subprogram on
> separate lines with their name, instruction count, and stack depth.
> It also updates the BPF selftests to match the new output format.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18777,15 +18777,21 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
>>  	if (env->log.level & BPF_LOG_STATS) {
>>  		verbose(env, "verification time %lld usec\n",
>>  			div_u64(env->verification_time, 1000));
>> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>> -		for (i =3D 1; i < subprog_cnt; i++)
>> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
>> -		verbose(env, " max %d\n", env->max_stack_depth);
>> -		verbose(env, "insns processed %d", env->subprog_info[0].insn_processe=
d);
>> -		for (i =3D 1; i < subprog_cnt; i++)
>> -			if (bpf_subprog_is_global(env, i))
>> -				verbose(env, "+%d", env->subprog_info[i].insn_processed);
>> -		verbose(env, "\n");
>> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
>
> [Severity: Medium]
> Does this new output format break the veristat tool?
>
> In tools/testing/selftests/bpf/veristat.c:parse_verif_log(), the tool use=
s
> sscanf to parse the legacy format:
>
>     if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack,
>                     &s->stats[MAX_STACK]))
>
> When presented with the new format "stack depth max %d", the %511s token
> greedily matches the string "max", causing the literal " max " check to f=
ail.
> This would cause sscanf to return 1, silently leaving the MAX_STACK and S=
TACK
> counters unpopulated (reporting 0) for all analyzed programs.
>
>> +		for (i =3D 0; i < subprog_cnt; i++) {
>> +			const char *name =3D env->subprog_info[i].name;
>> +
>> +			if (!name || !name[0])
>> +				name =3D "<unknown>";
>> +			if (i =3D=3D 0)
>> +				verbose(env, "prog (%s) insns %d stack %d\n", name,
>> +					env->subprog_info[i].insn_processed,
>> +					env->subprog_info[i].stack_depth);
>> +			else
>> +				verbose(env, "subprog %d (%s) insns %d stack %d\n", i, name,
>> +					env->subprog_info[i].insn_processed,
>> +					env->subprog_info[i].stack_depth);
>
> [Severity: Medium]
> Since the bpf_subprog_is_global(env, i) check was removed here, does this
> print misleading instruction counts for static subprograms?
>
> The verifier only calculates insn_processed for global subprograms and th=
e
> main program, as static subprograms are verified inline and their cost is
> attributed to their callers. By removing the bpf_subprog_is_global() chec=
k,
> are we now unconditionally outputting "insns 0" for all static (non-globa=
l)
> subprograms?
>

This is legit, but it is based on how we account insns processed. It is don=
e for
main subprogs and global subprogs. It might not even make sense to do per s=
tatic
subprog accounting, given it can be called in various ways that affect the =
insns
processed of the CFG rooted at it throughout the program.

So we can leave it as insns 0, or do something different, but I don't have
better ideas on what that would be.

>> +		}
>>  	}
>>  	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "

