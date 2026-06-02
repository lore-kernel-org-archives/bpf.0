Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FE3161A4
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362354; cv=none; b=qYcyDJxOdkDCdvGm4j5o/f5SVXK3bb7iZWc60zRIna8zdXUkDISbbIrTZ+/QE3EMSxTIQIXV7wOaG5MtgPS1w9JYEGw1q4FWExYiEORXyiCkIYL5RMl95maaU2vrIzvVAJDtlIyp/NglyYoDzWjLHKO+IL1482CBMKPXPoBM0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362354; c=relaxed/simple;
	bh=59TfrDg3AN365Ujwbp2F9cMhnyY6ii7H2FTMzyuOqto=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JXN8+VZfxjWZBeWKBcSqmfjMv9rqi8Ymix6ITRT0Ue+rDKQ0JsgYOnP2BbN2d/MlDGbU9Sbq2yjO2Ux6id0bv/qZGNUuyObRcIp+Hay6vmXA3gjMRaU8c6Ty1mDRXpFHTL8AzamRo3ryNAZ61qWIYR+SGszCHNHRB/3ETA0ENik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UQvv6pSP; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UQvv6pSP"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304ddfcf72cso4746513eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780362353; x=1780967153; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD1cZTsu+RVWHSjlzzbSvu5XwRwT1lM8xmnMKme2HqY=;
        b=UQvv6pSPUU2qZ3LPjpYT07ZAv11Hl+D0/ij2EX95/Y30LeS564PgoXiKrhqTbporyw
         Osl8VeAo/QZYZQ1ZdcIDYGa1kUKh9b1fK7RVWZ/mLugqI1BIafOsyglB5Zzi61YUha3w
         DgymhK1qYdqD1jbU+3+JqNpBNkfmCMNqPX6BbfOn+N9/nNEq6L5PYKwSzCPDWNaH1C44
         SNKiUg71Wlac66qp5uVV4iA2U23trnVvcDmrCQ2Uh4dcutdzAYMfZ6gIcR/7vZhkUOiP
         hoIxGhMzuYSDrzqz29v/AgPwR9ENFQu3FYn2thmMDM2SzBupQpkpuXeQldO8Mrsedt+U
         Yx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780362353; x=1780967153;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LD1cZTsu+RVWHSjlzzbSvu5XwRwT1lM8xmnMKme2HqY=;
        b=WKwQXrYtRoohlVDUqT6jHOovuCx/3pjaWQ5PojPBjyOh7mLVTDbcVYucRUZubHyZCP
         7OzpoiWlo2Pzy16i4e3DMWsvIWkwBqym/BTA9uVezolh2PK6yzYvqVw5ajdF113JkPEl
         EkPsshzPbUEskHM8SITHpFAXkd4yMf+gVEcZzCYpm7n6u7gC6cPQowhWbhJmoU3JKrmK
         Qzll+dGJ/QYRTtjKBhlHnrJdda+UflLUY/HMRiWdEiZmHDdH+7tmBE8hMEBfW/QvRifb
         L1Mo0ItDlhbmTa6HWKt+L9CxSa7uAi2kYmpOysAXEwjKbnfPQ0MzJUm+h75RNC/FDJyp
         +Q3g==
X-Gm-Message-State: AOJu0YySDGMP5nfIKwrF9oP+CGMTJP7K+6UlqvXGTdVgTbLykAXikita
	Mvzn9gvVrLyqW5a6D/SuPmQY7NBzgImvSnn7HDBuqBmcAyUuFwVs+qG1ykHwLYLVhwWUoXzGAPG
	lWTGQ4IekaEXX
X-Gm-Gg: Acq92OH0rc/sKfz7Nty8/teeBl4j1VEsvO88o+ijxPUOWEC586/PQ8CEUdSGvF9hZDn
	epth+j/G7B0En489Ioq6m8TBE39Rmlm6lwus+KqbR7IrljElbmjxo2THwmTwOaQP7q4bIDPZlEC
	l+Q8Eoftwa7F9MzsJkLBWIY6pffkpUnV737RBAQJRjrPIgkMM0wzNVle9+F+lp1ayOhegERmlLJ
	9y6WGotQYupnugLBxecGBZwW2kM3IIV3P0Zbx4z0TUm/xO9VaGNBo8MikpUEG95a5j3GWjnmWfS
	EOWpa8ucmMtT3dNXYEgIOjkBefBuRZyuZdjWJiiksma9LXe9n2OXuLclzALzKIRVgx6wx6UxUN7
	utyH5IKdesend2vUbKy+ZTod0uwx+HkGODHTxJb8B+S5ACasKmhQhG49AumfTYb8MWEmD3JEuc0
	0VkXGfpcXY6UpWDP4=
X-Received: by 2002:a05:7300:6427:b0:2ed:e12:376d with SMTP id 5a478bee46e88-304fa6dcc72mr6499745eec.35.1780362352751;
        Mon, 01 Jun 2026 18:05:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd6fdsm9635690eec.23.2026.06.01.18.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 18:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 21:05:50 -0400
Message-Id: <DIY5S4WHJ4ED.12QHS2OXCURJE@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/6] verifier: parse BTF type tags for
 function arguments
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602004120.17087-3-emil@etsalapatis.com>
 <20260602010506.F2F3B1F00893@smtp.kernel.org>
In-Reply-To: <20260602010506.F2F3B1F00893@smtp.kernel.org>

On Mon Jun 1, 2026 at 9:05 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The `btf_scan_type_tags` function unconditionally rejects an=
y `type_tag` other than "arena", breaking previously valid BPF programs.
> --
>
> commit 1b7f5032b014c339265f4b7f34961a16eb4c5894
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> verifier: parse BTF type tags for function arguments
>
> The BTF parsing logic for function arguments goes through
> the arguments' decl tags, but does not go into their type
> tags. Add type tag parsing for function arguments.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 17d4ab0a82068..c6a930aca67ec 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>
> [ ... ]
>
>> +static int btf_scan_type_tags(struct bpf_verifier_env *env,
>> +			      const struct btf *btf, u32 type_id,
>> +			      u32 *tags)
>> +{
>> +	const struct btf_type *t;
>> +
>> +	/* Find the first pointer type in the chain. */
>> +	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
>> +	if (!t || !btf_type_is_ptr(t))
>> +		return 0;
>> +
>> +	/* We got a pointer, get all associated type tags. */
>> +	t =3D btf_type_by_id(btf, t->type);
>> +	while (t && btf_type_is_type_tag(t)) {
>> +		const char *tag =3D __btf_name_by_offset(btf, t->name_off);
>> +
>> +		if (strcmp(tag, "arena") =3D=3D 0) {
>> +			*tags |=3D ARG_TAG_ARENA;
>> +		} else {
>> +			bpf_log(&env->log, "function signature member has unsupported type t=
ag '%s'\n",
>> +				tag);
>> +			return -EOPNOTSUPP;
>> +		}
>
> [Severity: Critical]
> Will this unconditionally reject any type tags other than "arena", causin=
g
> previously valid BPF programs to fail verification?
>
> Since tags like "user", "rcu", or "percpu" are commonly used in kernel
> headers, and were previously skipped by btf_type_skip_modifiers(), return=
ing
> -EOPNOTSUPP here will propagate through btf_prepare_func_args() and abort
> loading global subprograms that use these type tags.
>
> Could this break backward compatibility for existing userspace programs?


Already addressed in previous round.
>
>> +
>> +		t =3D btf_type_by_id(btf, t->type);
>> +	}
>> +
>> +	return 0;
>> +}

