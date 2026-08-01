Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281B3F9FB
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626120; cv=none; b=MZQiwD3Y/YPFv790O8gRkp540g1GgvrMbKKHZDHVTDulmA+2L/dpJYGYv0mXJ/dYHwkIjZRyxiLEyzOkGpCjtnBEbZF4S6UlV0A2LhPWHDkUc1qY3tiWsDA7bWGpUxhuk1kieNwuaE+oXPl0pgCyOu9StXkqPIbJSVe8CMe4IbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626120; c=relaxed/simple;
	bh=uYWMWTB2xfhuBvHHIxzDNU0Hyt+RGxbNFHvWkvXIEGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=V270VybSOED+DupH+wjF0yQY63MAkbeQwdK58kfn3v4ygHN0ht8BzCEW062da4Buccog6wD/Y3ev/aFbjz6G7eHlDwgCk1dHJiVwLzrTAQ3q5xglCzR3fgtYYu0/BUuTdbkyODet+TmRmPJc/qhI8cwkXFJ+4fNffEDjhPcQLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVMbcZjW; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVMbcZjW"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so624874f8f.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785626117; x=1786230917; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UDVgfDsUWPp4vaDuL46w9X9y1PG9/aWOLcGBDuH/lFk=;
        b=UVMbcZjW4WbeHzCMLRhu40BXj0YZY+TMyvjV9zQc+aT3XVW8A40A7rb9gDdusLFKL7
         vrRzzrsNR3lb00H6VWr5+/dwAJIr5uyP162Ocy1TB8mYd+QLWsnOXXot3h75+mFmUBSr
         rToa7S0qacNITz6NN5CiQIXu4Mpn5mewNT2Q4s4v2g3BYJONDBniNjBWvGffidh025bC
         FE3Q9EOnANJItJsKUdry4udk4LV1y5EWLxiu0ZyQYk49lCHip90LL/F3i9WylUkMrpXr
         4uYzXcSBP22v+BjXnPGRlMEZDCEZq/gfKPDWcU2cQp5WNduSHSl7kiPodlO+V9Cw7Uxd
         U3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785626117; x=1786230917;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDVgfDsUWPp4vaDuL46w9X9y1PG9/aWOLcGBDuH/lFk=;
        b=caJpvjPRJMcydkjdKSNXIyMxGKIGFji1rQsGd80ww8ZrVY6gAfi9kIZuCzpU8aU6+K
         TroKQVLy3et6+GNDyhPWkDOVd7e7mYtKnhHOlQ67xqq3nkSA3H55FdM3qs8JMm8ynxOJ
         OYyub54ZtRmN5c0/XVkBDD7WV5W9O0Ug6DeavvXjy57wtzkUhGtEay6UrdI4OcbwGGh4
         YfvlMYvHkMuHk9c1ekN2BsqeOTZU6TGMVvZpotzpr9QDykNdF/mINutdwNXkxFYBZ0PZ
         dGUMVbA1cM1VtZY2AVrcv5vhukfa1BqSPlCC9J8lISRnNQw6e7pHnyJmD0QQdjKUmViU
         S0Zw==
X-Gm-Message-State: AOJu0Yy9gvqd2RKn8mK0eKQltrqrSyxbLkfcTd5M1S00WqS970dYhqlm
	qKQg9JHMWGYADU3h1Ff8fnTc7k2D9mJ6GEtB5A0pnK5mQDjDXawhM3rm7ZfAQ+8b
X-Gm-Gg: AR+sD117QR/vRp5YTeMqp9bO9XNycWlm+SbVc9gXz22UMQ8yU5Y9IGjl7X9PNP91WSu
	WnPsR4WvV4/SHAUxu8yzXd0C/7odJoWAT6zH3uG49nnbUWVr4pXyO26JsvJEnVWvQYKfH+MtTjS
	mZy3B1ovwNRbA9oux+wTqAVjzRzjoJHG3hV+gCYFZSUQHsltic2XITtUJ4ZYSAkX5rGQkCyEtTM
	l7jI82ShjqiKje4o76Q6G7AwRyKqrH9Zq/4AHJBiemr74EKlEYXPmiC33NbCIZccYODhcvY/P2E
	yunkI6PGomkLzdclogKOdEwR3oEEd1BfjnL0SCievuBBR3fD7PoZ55Mzdqdm5XGyKNFR1FNhL5Z
	q+ESVoeWPm26m8UyfIiAOafsfW93XjutXpzX2nAvmWS4HS6c7MdZdOY3x/uuiCh89egSSVYitTr
	IQHLSJqXudjxQq+6a3BqENVKnvWgkEOD8RI++ymI1SawUdEfwwQsDIYYG856B4bV3OM9aeUWRdn
	Wqe5naX6EAz3tS5mVPbK+gaL4xScPIz0vtXNK1+Q7XBjjcWQBtycM2u73ObNt6nUBjH3sxxjPeH
	T0nOJTp3KJC8pTNYbMz59mW3s3k=
X-Received: by 2002:a05:600c:6989:b0:495:6338:1453 with SMTP id 5b1f17b1804b1-4980c680bd5mr94148515e9.16.1785626116985;
        Sat, 01 Aug 2026 16:15:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b6093fsm53217885e9.1.2026.08.01.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 16:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 01:15:16 +0200
Message-Id: <DKDZMPBQ6PXU.GQXFOI3BXGJY@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack
 depth stats
X-Mailer: aerc 0.21.0
References: <20260801230400.850271-1-memxor@gmail.com>
 <20260801230400.850271-2-memxor@gmail.com>
 <20260801231113.D0B711F00AC4@smtp.kernel.org>
In-Reply-To: <20260801231113.D0B711F00AC4@smtp.kernel.org>

On Sun Aug 2, 2026 at 1:11 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The new stack depth verifier log format breaks stack metrics p=
arsing in the `veristat` tool.
> --
>
> --- Patch [1]: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stac=
k depth stats ---
> commit f7cb915ff02de7a02fe7b2353a1f2d77e1852496
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Show more useful info in stack depth stats
>
> This commit changes the output format of stack depth statistics in the BP=
F
> verifier log. It replaces the old subprogram index-based format with a cl=
earer
> name and depth format, avoiding hard-to-read sequences.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8d0635ee48c7e..51ac0a9ae3394 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18703,10 +18703,18 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
>>  	if (env->log.level & BPF_LOG_STATS) {
>>  		verbose(env, "verification time %lld usec\n",
>>  			div_u64(env->verification_time, 1000));
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
>> +		}
>> +		verbose(env, " max=3D%d\n", env->max_stack_depth);
>
> [Severity: Medium]
> Does this change break the veristat tool's parsing of stack depths?
>
> Looking at tools/testing/selftests/bpf/veristat.c in parse_verif_log(), i=
t
> appears to rely on the old format using a hardcoded string and splitting =
by
> the plus sign:
>
> tools/testing/selftests/bpf/veristat.c:parse_verif_log() {
>     ...
>     if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stat=
s[MAX_STACK]))
>     ...
>     while ((token =3D strtok_r(cnt++ ? NULL : stack, "+", &state))) {
>         if (sscanf(token, "%d", &sub_stack) =3D=3D 0)
>             break;
>     ...
> }
>
> Since the verifier now outputs max=3D%ld instead of max %ld, and the indi=
vidual
> depths are formatted as name=3Ddepth rather than numbers separated by a p=
lus
> sign, will veristat silently fail to parse STACK and MAX_STACK metrics wh=
en
> processing BPF objects?
>

Fixed in patch 2. It is an open question whether we care about format
compatibility, in that case we will need further adjustments to parse both =
kinds
of output (for older and newer kernels).

> [ ... ]

