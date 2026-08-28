Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C313C1D44
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893241; cv=none; b=q/xtwM87v5RIeO6UsepC3EEAbKtsrvFFh9YcN+nCXO4EAePiRGZucc28FGN4+V2cqmUIp0Qoic9ISBTkkm0ipORxm1WgpRBMhnThtcKAPH8yvNVKNAkz0Kz9RF265L9GMjWx3zLZPuR+T0E2nTtEwIWtSmmDXHK0RafU+xVkWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893241; c=relaxed/simple;
	bh=U3kNOmerV7kQsw2eW10dXOXL3pbIYgXimWm5yOquJUc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gBqPKhfLTk7OChgYD5fvnDhjthJdxwZRLmkz4nbh+mT18SL0VyjbYKWNAp2diGvS8PtpDdGWh6HxrcAxrAeZDWNUESpw5SXXCeIXzH2YszSmC5/LA3T3fT8rVRQEDwV+hT2nYu/yZ5TRXoTXjaoYNAmMz0LxPA+MOCYqhFgBN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc/Mq9P+; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc/Mq9P+"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso2075365e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787893238; x=1788498038; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kn5dPq8dVOKB8bYFWwsnANE+oSo3rQXQIc0hw4byA74=;
        b=Yc/Mq9P+Kymc2I/CHBwlFhkx/0tFY+urWck3rgZBkT5i5q5EOaoxcCgwQbyNff6hA3
         VoTtZlm5nNkRQaFnl8SEA4FvdIwYg2hQ28fj8HnKcYMU1tWDMbdTOH/dJWAQYD+zG0sT
         4ebFIxR8dm3BkOm2qI2Q2x0FMb0gUfpAZr2aIeBNt0wrHkNdrF7QTvlN66VuC/oz/F0E
         UpWgotF6s4XyuvX6ikCOAaGH2JotZI5HVZTQRASBCBM2xQH1/9HzB6tKgw4w69laE7rY
         VBWcU0zqsQoYHEv1Rqno6eOjuHGJQ/0jldVyDFjiR8uG+D4h50uOqqSWVN5aA0f9qMLG
         bUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787893238; x=1788498038;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kn5dPq8dVOKB8bYFWwsnANE+oSo3rQXQIc0hw4byA74=;
        b=adL5vVtGuDbt2drJKwHYNqHjyZEONdB2+eU+hDOipkRGXHjn/Ayg43XY9QqWCGzeAO
         iOhK6gbtV2gOpIt/HkzztvUXAh8JddLB7VPVW8AJt3SyKM1EA/F2k9JFDrogSjAVgo/a
         Evni4WSGzf8x7e2E35FAUAk3REv7k6j0VQ3UwKXzLCqLIGggyLPFsa3ghPckzzVFsu8H
         mXnZGqmsRl7XGhxANFeN1E8tWgRitFMpyRejcSxAXiMWLEHxD/2P8xt7GhuGvExFrNga
         Kjbdf2Pqs0DsR9hZQc93rMNHqk7Jzy5FcEzEeIKYdMC5kCpmgCyF27HBHXwi5VxqC5kv
         CMRg==
X-Forwarded-Encrypted: i=1; AHgh+RpOEhVvb/THyxBiRtG80mIyNVcTYNxBofErqlbvtuEYV/PYBuxjBGcJTjtVTJmDPwY66mA=@vger.kernel.org
X-Gm-Message-State: AFuF++mBLLD/T/fJ/iESsANRteVQQabHT7yzpyrl84GOa8cj5Lcmifmg
	fn8nXLTO7KypHk5N3FKhkxxafyhjHkVAeO9SKHvO/juw3OBVuP5sHoC5
X-Gm-Gg: AR+sD135vTuWEvsYf2rsB/qo+ZLKjl2zrYe3UueWDtY1wAeErAS2xgLsGk5PakHOQG3
	jvmVZI3ZBVtzs0v//R+72wmnNtb1gAP+tRVeVecqX6K0vTkp5omDcwdHJ6ZTgkS3hLbBCS2a+3N
	yRY/RSUXsHK4SwSUB+iqch8cwP2o6As9D8T7Fj+mY5f9iNrQGszY0UtStE0sZsNaD/ZpH/9dhor
	1ufE/TdXgvqaMEFgMhBbQ7oabJLSg7MtiT7baWjujsXVStBpc25/TeNdv74644l1kBBKVNP9aJo
	BSrEEdLiCPyKsuLEMKmbUO3z4lx4svHXxrDdlChjXTX8IHCFqnNICV8GBNH15bFjwqxvzdztY2i
	hEUIu6tDs4pWpucNwsADC/WrQ0KsO0rWzMueODZ5+fERDeuf2RGdgkg8DjDHHZuG1OaV8L3jPq3
	iOCtD7snZrZrASsO3laFQpHaw05Bn4R8ub85j+B80Mr59ZcoA6RafwLOtHpDvozMs2hypI+4Ew5
	2h/bcILIzrKG+n5q5fAWhWPYHOl8LTmX/bjAVJl1wxejdhEsin4p2JJl171O1Yyul/FEB/dDZjn
	MMgikppK54oTKR4DagacKefyDD6x
X-Received: by 2002:a05:600c:3e1b:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-49b91c4cb6dmr55694405e9.12.1787893237919;
        Thu, 27 Aug 2026 22:00:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm100960435e9.15.2026.08.27.22.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 22:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 07:00:36 +0200
Message-Id: <DL0B9A7YL3IU.3ENX4JBZEH9RE@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 13/14] selftests/bpf: Exercise arena
 arguments on every capable JIT
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-14-memxor@gmail.com>
 <d293e07d-4039-4c25-8dec-6da22906a6df@linux.dev>
In-Reply-To: <d293e07d-4039-4c25-8dec-6da22906a6df@linux.dev>

On Wed Aug 26, 2026 at 10:50 PM CEST, Ihor Solodrai wrote:
> On 2026-08-21 4:35 p.m., Kumar Kartikeya Dwivedi wrote:
>> The arena kfunc runtime tests are restricted to x86-64 and arm64, so new
>> JIT implementations can compile without exercising rebasing, nullable
>> arguments, five-register calls, or the verifier capability gate.
>>
>> Run those tests on RISC-V, s390, LoongArch, and PowerPC64 as well. Teach
>> test_loader about PowerPC64 so it can select the newly annotated program=
s.
>>
>> Enable the struct_ops arena tests on RISC-V, s390, and LoongArch, whose
>> indirect trampolines now implement the separate reverse-conversion path.
>> PowerPC64 remains covered only for kfunc arguments because it does not
>> advertise the struct_ops capability.
>
> I'd avoid adding these unless you actually ran it.
>
> Have you tried non-x86 / arm64 arches at least in emulation?
>

No, I'm relying on individual JIT maintainers to green flag this set from t=
heir
side. I think that should suffice. It would be best to do the conversion al=
l at
once, and we don't really have a time constraint, so can wait for all JIT f=
olks
to chip in with their reviews and tags before we land this.

>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>   .../bpf/prog_tests/test_struct_ops_arena.c    | 16 ++++++---
>>   .../testing/selftests/bpf/progs/arena_kfunc.c | 36 +++++++++++++++++++
>>   tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
>>   tools/testing/selftests/bpf/test_loader.c     |  5 +++
>>   4 files changed, 53 insertions(+), 5 deletions(-)
>>
>> [...]

