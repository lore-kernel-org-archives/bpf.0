Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45912FD69D
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960367; cv=none; b=s9+ne3NC7HPJ9rDuvQqNfiXv5x5vfuiII9z1F6j8hZ5bEgDS1tnRzJ05PKJgOe5iOf3YSVx4Dv857uZ9HpkUf5jnks7cCY0MyogiIyKU9EpUiRIeSqrFDrR7JHcjFi1sH5E2Vhvq6p/H8gl3djE8vHn+N5Pj+qxB/Qx7hqsU57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960367; c=relaxed/simple;
	bh=fVT116QekZNXq8A4MfrugPQ5rvvamyjbYyb9czqnfVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ci4j/j6RrGjYOoWILBuLUiGE44NNbbgPqs/VEOrmvZAeiMnuBkLdXO1LiE0AzAJOqOEITvxxF3uSnDevqoIXboCLjrRFmNHBJ99anYVYCr3ut2o2W8Fgy9QIVqxyEjFnmaCGxw4eMcQpF0T/mnnWqmMFNXQLKj1kRIZoZDThqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfsKgcbu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfsKgcbu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483a233819aso57568625e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960364; x=1772565164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVT116QekZNXq8A4MfrugPQ5rvvamyjbYyb9czqnfVE=;
        b=hfsKgcbuIPvYk7Uq9IKXIJcGQYVJEBBQx01YNo4knCk7EV91RIqrUYYDTqJNJb/09f
         30vI1aERnmY1s0bDykQ4ewKINpxOlO3hStTyO1IorDBZ2itJWfEdFn3Selk5loP/Bmd8
         EB221tD6aKDAyDGNF4wC2EBJBI2dRR0uGlDXkacE5wLBoDx/vnQAi3eF9EZhaJ0+C52s
         kDQsMAcQRqjorq3bnfqYcEHJskxpDWFqd1iGRIQNB5IViulIwBTFIwd/eZDgVaRyZN76
         wXPxioZUysRzcst/LyqVtDq0uKC4PfxfwY/BBvmHTCZptrRjWrOjPK8hSR+PjVuaC6GK
         eW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960364; x=1772565164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVT116QekZNXq8A4MfrugPQ5rvvamyjbYyb9czqnfVE=;
        b=NBNl8vghoo3jC2tSQBwSk8juwCfLWafJFJCxUUzR2J6K7pqF6oCyOP0sAmtxTPtB97
         OyvRFfSh6xbDMtaCc1Lx+XtT354Vdia9Ic9yIL1bbZ2cGKaq3vShMw0a1nLM/kKSSwlQ
         5Wsuzskh8ZLlNeJ5K9m9hYbY5kYiInCJXAOX2iLdtUEQw7J6iZ9lrZVvlKDLUdlwHfFe
         o6stKnWiaMZcLznwv3rPyJNZ5HQS9tvnnwyes4Lm5eZ2KJrEs014uQtWtjtkN46DAJ53
         U2oWMg3s3XA/mK9OYEuzZo+aHDiBZmj0DGQSp+s7Bc/Vims7fKF0IZ0et4HXjWuyeMpa
         FGVg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Pw2eSSJrX/VbNVMPsXDfIIdM9V+ESRLFWsrXJ1FXm4d2DJnDsJX9F7cmG3O8kKTh0kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/Uj1sUqpIQJT1gUz3T0q1gvGglSrX56tpwIwdK6zD6nWYpuc
	IWpD9rjYJHpuavoKqzMfevGRGhErypGi8Z62LGgMGojHaFyg3Msf39UY
X-Gm-Gg: AZuq6aLI2qoAbhuvfs7dBTKF64ax9j7xL3hXJfMJrsC6yDZgr+gDy+GObSnJzl7nA1b
	azIAk79N+3sG3ldyYWEYDng/kt+q94daJ3sbPAPCrRDi7MQ/rjIHil6d7f5wnidyxs6M9z7WBYm
	yVrEuNzjQfuirzPdG7fPtpwox0oyrBmr9SZ1KTySCTlUAvSkTOB3ANP4iFPS1csVcLsRkLHMHpB
	5hmD3Gc/caVplIxrLrtVcI2ndH4Ki7XwnBqcJF47vKuNipFFut2jpVwPiXx5hUR7OmAc5qH7xdg
	/PvS2uLzxzwqVDRH/OBDtBP4FSOcZz1JmqtWY2V7gVSKBGvJBAYKBl5HpoQX5Cqh6F+/LNh9Kub
	bTLsZHjI37P9twvsM8ANpgJOm4JA+8PF28H9I08zldN50oC9XDiyJ1HSRqYsp/7orwN+lKUS4A/
	diHCmvW+TjFWb+NYl0zCM5fXWY7hX3YxXnD0vdX5lz4tkYfH4T+StYIJPuZw5z/N37CuDKr2kLu
	A==
X-Received: by 2002:a05:600c:19c9:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-483a963d2d9mr189878365e9.30.1771960363771;
        Tue, 24 Feb 2026 11:12:43 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:14a2:8a3a:807e:d6d? ([2620:10d:c092:500::6:ed07])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750607sm21099755e9.10.2026.02.24.11.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 11:12:43 -0800 (PST)
Message-ID: <057a7b17-6ecb-4c0f-b176-1e6349b641db@gmail.com>
Date: Tue, 24 Feb 2026 19:12:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone()
 in veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
 <927e23c543aee236c8f9513930ba6f1791bc5933.camel@gmail.com>
 <474b3520-f5cf-45b3-be01-d14708cc9a14@gmail.com>
 <37d63e5e33cc9ba0b7e042b982207de2146d07ad.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <37d63e5e33cc9ba0b7e042b982207de2146d07ad.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 19:08, Eduard Zingerman wrote:
> On Tue, 2026-02-24 at 12:20 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>>> I run selftests binaries through old and new veristat versions and see
>>> some discrepancies. csv files attached.
>>> It looks like there are some failures that are now not logged.
>>> There is also at-least one success -> failure transition and
>>> a bunch of failure -> success transitions.
>>> I see no such differences for sched_ext programs.
>>> Is this an expected behavior?
>> yes, the regressions are explained in the cover letter:
>> """
>> Known regression:
>> - Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track
>> owner program type. Programs with incompatible attributes
>> loaded against a shared map will be rejected. This is
>> expected kernel behavior.
>> """
>> in the previous version of this series, there were no regressions,
>> but to achieve that we had to be a little bit creative with maps
>> loading, have a look:
>> https://lore.kernel.org/all/20260212-veristat_prepare-v1-1-c351023fb0db@meta.com/
>> clone_prog_maps()
>>
>> The improvements are explained in the sibling thread with Alexei
>> (again because of PROG_ARRAY type of maps)
> Are you sure that's what happens?
> Looking at 'failure -> N/A' transitions, it appears that this is
> caused by the early exit from process_obj() if bpf_object__prepare() fails.
> Previously each program in the object failing the __prepare() was
> reported as 'failed', now these are skipped entirely.
> I think it would be nice to have an additional logic in process_obj()
> marking programs as failed if __prepare() fails.
Ah, you mean those ones, I don't consider these regressions,
because they failed in the base version anyways. I discussed this case
with Andrii:
https://lore.kernel.org/all/7990bafe-d72c-47de-a711-0c8a888d4ed9@gmail.com/

What I was talking is the case where it goes from
success to failure with these changes.

