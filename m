Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53B309EE9
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440300; cv=none; b=R4A6g0faZQT5U3G5NqFJyILPqpFKbg6zVaNgf2e3UWMTlrVnrW9dhQJjqlK5S8hg/DgrW7Gx8I8cq7+//QvK+slNeUIUnWDD9jqdHQPHhDJ0UPgzbXxAgKiD/PEaWJ4GKbY43HESvDbIRlkOjv34fmPu7QpQTURmV0kewME4NEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440300; c=relaxed/simple;
	bh=ogfoW9MUXTSwe11BLGGgmfwEaAoPwtxM6by4xdaw7jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+81DyQX2+leNELT4bBFpTCsBqBz0usTsMIeBu+UcZjeDjgxXow27JUe0i4Ay0wkxS9CEqw04uVgb7ocdNbBLEvEzBDwu4IFGXVQOoB9cU68UJT9ejyEUwirq9D19EwsTcoFwKnozkCcfeGm2nM5pzNIM/cBIKLvMsBwTNQiVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He4AJ2x2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He4AJ2x2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436e8758b91so139511f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771440297; x=1772045097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3s3O3JA7uoRa09ryG1QganQd8+Dtdx7mw2xkEaGC04=;
        b=He4AJ2x2tkKWVlfo19JtcNKTH9+InLGQdxytDQwNtBYQeG2hRnkzeh0T9Vi9TOhdMP
         PEoeZRuzMtcdynPXfF6A2phtpnU22Z1afQPbxu8Mu+pOv8XBUM0BUyV85l6cU6lo0w++
         m3YtpWk/QGHmDXRZWWJoV6Ed+eeSFF7SgHCX41npKUvJip+g5Gg276ommbtVAGbOrv2a
         lWfjMCQKyaf5nouEn6Gh4Bj2gYczssa5Y629BlOVSsgAOTxu/z/SMqAvgsPjMmk1aNcQ
         D9d3J7vv9Nqw1SeAR9aEFE9iCMuJe6spcGvLqIOV12d544J6m9IBZkvlAgL9vJyGaaMc
         rC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440297; x=1772045097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3s3O3JA7uoRa09ryG1QganQd8+Dtdx7mw2xkEaGC04=;
        b=iKOQHmH4mkRHISk1AuZKKBQo7Q4yS3xBiWJuwUwj+azhZ0seHQPRJhakhS2pZdu71i
         Br5E1jtQPpU80Yvh8ZN5I5M+wBBxSSajcWVNnDa7uaXQasrNOqEPwLXdYl+lSO9k3SNH
         ++XvOQp26fqKiyG0aMvWLFs6zFsU38YUTlPa3tqZEpgYEDKzp5ILriSNdnUFXPkk5yiX
         Cp6PWvD1Z11wyCR/yoPk5VU2uUOxVEFy4gWtDFnn7Kni5FFP6NIfIkJRJbKeq/NVNjzU
         N3CKTHvZ/rhrhcDtknEmIAjmTCGHrpbmFAZ3M7ZMUj5HRF4ayMr3CAop0IipoMPM3SuX
         Zz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL4POvIYwZl2aAQz/bscjDNZa74iFBpli6HaG4uZqaIVRTseRwIfvzG5pQPlZiuOAJ+ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVrpzYWRzch1LPCs5NYBo/HWLW6hc0NlNffcDqgsh4LO+iATe
	iuzQ/IBvXQ+XYD5IV56/9QFEFTZeKsgtuTOQtqRyAjYsFF6Ft7VR1ldz
X-Gm-Gg: AZuq6aLiroYTKVQvL/qKEIhP8Qlb3PFQoI5YJaey2QwHPlN2jbjMXZeiwqS6WbQElpe
	aRZSxzhmvhoBNPV5ofKYVn/iRyXdtrMTGsPh9VA4pslhZIwBd5/tChamrT5lS7yrXujHYtJnrdY
	zL3pXcBhhwOwelXFHRENZPcp1gG1c05q4aw6i9JNyy79jnKeZfSNWIiT6gDBE7M5LBMWu9nVSXk
	biR+9n+/To6bBPuVOEcLnFPVgW4SQnCd+e+ptnBuXBdATzLeyPESkiF+XwMWzztBitKOhtY4zgi
	0HX7VEhbQhxdY8IzJblPaZdExy6wZt9C0DyNBPgA2b5SxHuk3aZjD8aJ/16qKjA8oMG/ThdQAAz
	kGJqtRr9pKfGEQD81Vsr5+r0tqWSg5YBCWuEsIXQeP1/hylx4AyCOjZtV3b9Pna3b/ROwMBLFVZ
	2Nasm+KmGhGvooidtZvmenb/jFrxCtqKtNgxKe9Sd84U/PDYb3hcnlxalOJ8ZDOKs=
X-Received: by 2002:a5d:5f47:0:b0:436:3475:473f with SMTP id ffacd0b85a97d-4379db8cd9cmr27366698f8f.36.1771440296775;
        Wed, 18 Feb 2026 10:44:56 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:93ab:614:2c34:ab35? ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a74918sm43650762f8f.17.2026.02.18.10.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 10:44:56 -0800 (PST)
Message-ID: <7990bafe-d72c-47de-a711-0c8a888d4ed9@gmail.com>
Date: Wed, 18 Feb 2026 18:44:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Use bpf_prog_clone() in
 veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
 <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com>
 <CAADnVQJqBqBaUZjQAGdchePKZMT5BMop8Sn1W5jmVOKUUdv0OA@mail.gmail.com>
 <02973092-a718-4374-a6ee-e31e8c046ade@gmail.com>
 <CAEf4BzYFGdpdPP+HV085mhPmujW7kcE4TBxLtwu1PegOz_QAZw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYFGdpdPP+HV085mhPmujW7kcE4TBxLtwu1PegOz_QAZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/18/26 18:33, Andrii Nakryiko wrote:
> On Thu, Feb 12, 2026 at 8:22 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 2/12/26 02:45, Alexei Starovoitov wrote:
>>> On Wed, Feb 11, 2026 at 4:45 PM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Replace veristat's per-program object re-opening with bpf_prog_clone().
>>>>
>>>> Previously, veristat opened a separate bpf_object for every program in a
>>>> multi-program object file, iterated all programs to enable only the
>>>> target one, and then loaded the entire object.
>>>>
>>>> Use bpf_object__prepare() once, then call bpf_prog_clone() for each
>>>> program individually. This lets veristat load programs one at a time from
>>>> a single prepared object.
>>> Any performance numbers that prove that it makes a difference?
>> it's neutral, I did not manage to record any difference.
>>
> How did you measure? I just ran
>
> time sudo ./veristat *.bpf.o
>
> across BPF selftests object files:
>
> WITHOUT bpf_prog_clone()
> ========================
>
> Done. Processed 905 files, 4327 programs. Skipped 11 files, 0 programs.
> sudo ./veristat *.bpf.o  0.01s user 0.08s system 0% cpu 54.512 total
>
> WITH bpf_prog_clone()
> =====================
>
> Done. Processed 905 files, 4045 programs. Skipped 11 files, 0 programs.
> sudo ./veristat *.bpf.o  0.01s user 0.11s system 0% cpu 17.883 total
>
>
> 54 vs 17 seconds. Though it's curious we have much less programs
> loaded (according to veristat reporting). Still, those 300 programs
> (if the difference is real and we should check why we have the
> difference in the first place) should account for 37 second
> difference.
Thanks for remeasuring, I might have made mistake, will retry.
Regarding the smaller number of programs with bpf_prog_clone(), that is 
by design(ish),
now if bpf_object__prepare() fails, we just fail entire file and do not 
print a separate
failure for each program, while base version of the veristat prints a 
message per
program, because it tries bpf_object__prepare() for each program in the 
object.
If we really need to be on par, I can iterate over progs if 
bpf_object__prepare()
fails, it just looks a bit awkward.

