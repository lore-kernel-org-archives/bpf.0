Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2169396D11
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935610; cv=none; b=Qx5MnYVklG85WWIK5ZjpQ8RqGBGmEeHJii5ZmYgFG3w7UDzjhvERbNGT84y8PL3ghBjyVRsB2fkvhkH79NgDdHcYVM2dM/nQECvvjcfNMIaGtu5scMWT+grgcJ3/KQ1UcNTcSX+F5IorO2PeSSw3Ljr+h/2VSYJH+pLJvcGpNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935610; c=relaxed/simple;
	bh=+hLFf0KCRCFKf2SuBs0KcdlK2fgj1EK38H1bXwhSa0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVzgsESbRH4g6wlsRe0bJ8MFWf0LA8hv21izCoRWZrcrHk30hYZPFGoHohGb8YQhjiXLJgPTI7V+ti0/axo6mW6brPdPiin754NWcJrC+V2IuIGo68OAUaWWzE0Btoj/mHmvYBQr1SN3BA7Ur+MzsbQiJZF2Y7doNbv5Ztz3bJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUrhOT1a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUrhOT1a"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483703e4b08so43420115e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 04:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935607; x=1772540407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hLFf0KCRCFKf2SuBs0KcdlK2fgj1EK38H1bXwhSa0o=;
        b=HUrhOT1aNEesWXA9HaYW2AlrI1jzslO9dlJ0p/Lc/ofGD870lsdfQ0Fu32g1riVEid
         gek75LGMguu0reaBIUtl0mS8h2uyKSvj2lsjNDYkcWst4dLsKjv90JJAw+9cs8Tflo61
         d+5mVqcYPq/dQyKAe7eB9+gJbAdScfQbiaK48k6SF0JW1oycWhElG8YSoDVFwuuwMnTI
         BbVfXeQrN6pvHmEqVj3ecVsVtVKFgQGF/4znfUbetXinwXRq8CpjbpRog5rcUQ4NSBaL
         tAbQL6wyMsakpZvaCHiJVc7/GBiS+tkmFvckchseRtZdBqw4Rk565Blc4pOEgYUcmTh5
         g0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935607; x=1772540407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hLFf0KCRCFKf2SuBs0KcdlK2fgj1EK38H1bXwhSa0o=;
        b=qHzK0RK3S8HcGCaTG33IUyGuKnlRRHvZ6O0g2laYU/0OfIvK9/fFKmZbfGz6gpi+50
         fqlz8rrM884+0KjNZeY0kJPC3TaKWikjMv550KM28J9otv072wT9WJ81m7MCc+bZ4Xxt
         Qb899eZbDryVLy4c4k6EC8RIMWBHpA7viMu6O79b5EBfMnAz1S8z/ibzRdyL6IbWs9GA
         fpAA2M2H8i3oKmsq0aN6n8U14XfGVMuWOBeOrY8p4pFhXLpWlGb9Ey7zCRFgzedClXLz
         kELGLORtQq+iU7Vs+ciRRgqllz/mTttzM9hEAOSBSRZcs0G1hVCxr+QCVtVb4HRO67J8
         crIA==
X-Forwarded-Encrypted: i=1; AJvYcCU0zbR83x/PHyFkEZpfdCLq2bRATgN03xASiVX2Q3jy+aqGOS6IslDYsT2+ZDMVSjgmrbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf08Lg+ZrQV5N2qGDMYGuk3LeqD6L/T+yLuORvVK0+G2jn0Al
	psIxx0hSlfnEcVGUdG1UlL9r5US51jR+epk2NbJoM4NqAryBd6ZIiWlP
X-Gm-Gg: AZuq6aJ8CiFljGumzNj30ue6T2SCapLgNFtYWQeAJZa4a61jiqBLPPvzXfrmbnNZN5d
	oNc4YvW7Sx8U30Bbaq6XVxgyBRtPR3L7rxNW9oj67kyqNLo6Yst4jlf7PVN99LFYOvdVac8CvIu
	efez3nwOB6VMnIB601puABdujqNToXlu7fCegFAwU18mNsd3XtGdNFjG4dodoAoQKln7ks+eFlm
	ZFCbOf8iO5ko9VKbP+PYiFUelZhsSVVSpm8zqI01CCdxbdfBiof0mvaoIuwwORVYKbNRw3oXA9O
	n8YNfZZYRDA2eLsPUs7ub3Auk7C63/pWn7LrcQ8wh08U8sKipc7traFX3L/WOJ4nqe3QNV50Yti
	0PHupcVySkipLGA7p2jSf6qRkVUNmf+FaXbcl2H1hVHbN0XCcMF36nTmSuIm8fRrsyBINCJsZIs
	fvVOcHjNRgEvYWVgr55RECpUs6XjgFXh66UP0YYOU2urKhTMy1PqBTIcAxWa/1JWOqE2J8by0Hg
	g==
X-Received: by 2002:a05:600c:1d1c:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-483a94a99e4mr184560085e9.0.1771935606833;
        Tue, 24 Feb 2026 04:20:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:14a2:8a3a:807e:d6d? ([2620:10d:c092:500::6:ed07])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm360868775e9.0.2026.02.24.04.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:20:06 -0800 (PST)
Message-ID: <474b3520-f5cf-45b3-be01-d14708cc9a14@gmail.com>
Date: Tue, 24 Feb 2026 12:20:05 +0000
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <927e23c543aee236c8f9513930ba6f1791bc5933.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 02:03, Eduard Zingerman wrote:
> On Fri, 2026-02-20 at 11:18 -0800, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Replace veristat's per-program object re-opening with
>> bpf_program__clone().
>>
>> Previously, veristat opened a separate bpf_object for every program in a
>> multi-program object file, iterated all programs to enable only the
>> target one, and then loaded the entire object.
>>
>> Use bpf_object__prepare() once, then call bpf_program__clone() for each
>> program individually. This lets veristat load programs one at a time
>> from a single prepared object.
>>
>> The caller now owns the returned fd and closes it after collecting stats.
>> Remove the special single-program fast path and the per-file early exit
>> in handle_verif_mode() so all files are always processed.
>>
>> Split fixup_obj() into fixup_obj_maps() for object-wide map fixups that
>> must run before bpf_object__prepare(), and fixup_obj() for per-program
>> fixups (struct_ops masking, freplace type guessing) that run before each
>> bpf_program__clone() call.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> I run selftests binaries through old and new veristat versions and see
> some discrepancies. csv files attached.
> It looks like there are some failures that are now not logged.
> There is also at-least one success -> failure transition and
> a bunch of failure -> success transitions.
> I see no such differences for sched_ext programs.
> Is this an expected behavior?
yes, the regressions are explained in the cover letter:
"""
Known regression:
- Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track
owner program type. Programs with incompatible attributes
loaded against a shared map will be rejected. This is
expected kernel behavior.
"""
in the previous version of this series, there were no regressions,
but to achieve that we had to be a little bit creative with maps
loading, have a look:
https://lore.kernel.org/all/20260212-veristat_prepare-v1-1-c351023fb0db@meta.com/
clone_prog_maps()

The improvements are explained in the sibling thread with Alexei
(again because of PROG_ARRAY type of maps)
>
> [...]

