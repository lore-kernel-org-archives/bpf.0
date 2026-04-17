Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E83101C0
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442072; cv=none; b=p3vUzU9DvIKsa/oxvTkvZr29V2Uap+DLtl8FM/Ceh4LXEKV1CQtIkJYQWQP0k98LT2d8x0v0UFmH04SUBhsLeL/NKp0/Zxd8h5SGNykL8vCXK9RiwPhMIughy28vB0y2RVJPF36kttrxRBbewFwUj5IShE8V5+d1hIOX5ArbTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442072; c=relaxed/simple;
	bh=opigBZBRqB0aL406pyipEFNwsfbbb3bcFx/Zmeh0VIE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QDamZNVlTNCIxpw+0Km+MwiosQmbzCQZZvvtAhKobr8/Oq6u+s+AWXr37vkRClvVcCTkyZwQp3KxhrEc3a3lZCP73Fd6YteRin3eNjOUribFiOTChcN2v+KHupw8MgYmywIwuFQtSIGfK1B5aMfvbAD5bcMLnYbPUxwcvkjqphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=r6KEcAD3; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="r6KEcAD3"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12c7212836bso1548014c88.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776442070; x=1777046870; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CItbSBANkqGwGgclCHY8cS/h9tRrPXe0wuFz1XeZXG0=;
        b=r6KEcAD3LUQWwM7RO0QL8c9JF2s1JlemTQ0GcRHIBJuXVhtp8sjr4GcvCZYGT4huM1
         /5ON7QNwXJ2cth9Oi0hz9PB8MaqJ6Cufev6RO3M4H31fHAM8oTvY3rTlnROWl2nXo39+
         3OyCH8JAlCEQklvfWKV42s1atJFt1eyWZjQ97h/adxfa5cuxeZtJmtf57axjcLUq9Tpf
         f1fUS8tzvqMYyLEnA/lIRjg8DKlJwannKqK+MYJrqTiW990frwdphCV1Zjvci9nEtizc
         N/F9VtR344hIH6nlrsSwgDwPmfWLdLxUF6aq74jj2njLYfxLPbHZnT4625zFnsBu4gDO
         3T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442070; x=1777046870;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CItbSBANkqGwGgclCHY8cS/h9tRrPXe0wuFz1XeZXG0=;
        b=K4fAdmBzdesezSe1qRMKXEcfovoYvWNEvOjkUAk2incLRQDvol/P7RkSu3O4s+uXDG
         fqh3yJn1G9SBefpfN6sOOfUv1QFtRbprXJ8CKRaPkG4430cwTw8xNmMbiYePlTvfj/UV
         JwtNQXKIusm6CWB9t43b/XoIG4LNAaNqUruNfufj4+6aG5qdn0bhT3tSypWh02fJTV5l
         J1jK3ioIhroPqXh51leVQ8d+M8srtCuV9jUW/oplSbJtPby3AvC05YGzaxyj7LBtdGY/
         yeHxfe9Ez+IUvRMtAiFw3euKHsJ4eCYS4UCaDkZVDmHVH06FC/Ie8Ijf/pehSizuXpFz
         OBsA==
X-Gm-Message-State: AOJu0YyQzs67XcPCtIoMHDC6qVBf3tW7Y+4es708I/8lxZ1pWFZDGhqM
	jUXsHGRdgEdeeEuHTs2vZ+ISTOqLg+a2MMIzo1+2a/WaZKD4dbV2u6KnW0EiHNnj14I=
X-Gm-Gg: AeBDietV15V5yEdTl/cGu3amW8XC/e/GwoJQjiWBNiVMDbZDpi3jwPVd13kYu1eQBy4
	QQ/AQ75AfviK6vnSxvgmMVIdP/+EUNvEaqun44b+7j1NJmmC1uUHyWqSnnf2duoWy6+wBfpl/ha
	KCw4P9i7rHKd5hZqnUEAqUg7oy2K55qAztXTMjumz+hpWrB2E9CW9PFcCTy0HKRAK+xHyGIsR1t
	ieLb1OPWxIn3yrOTc5vT/bZFtQyNmGKpbUdOSHroLi9ASW/PyWUf+PRMPTNJ9kVYC7FXLqOeRw4
	OXAH97pw6iUWtpZA0qdpiFOP1cLMsndlmdZMUFOHpqlIubEDKTA+wRnzxVKwvA60r3nZ9rHQazt
	rZu7UcHhXdYqtRMJbKFpfzkW3RUzexppWWgQIntaER6BsoaTGK6B13guKNL3deNdUaKxKeK4Mnz
	U+lmuDLitJhw3XScY=
X-Received: by 2002:a05:7022:69a:b0:12c:4928:e57f with SMTP id a92af1059eb24-12c73fa3e3cmr1554706c88.25.1776442070145;
        Fri, 17 Apr 2026 09:07:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::5d38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm2690775c88.3.2026.04.17.09.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 09:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 12:07:47 -0400
Message-Id: <DHVK5NSN5J8Y.3C7JM4JRTAPND@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 3/9] selftests/bpf: Move
 bpf_arena_spin_lock.h to the top level
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <20260412174546.18684-4-emil@etsalapatis.com>
 <CAP01T77VRccr1feG4uiyWu0zAPf4oDFMJTVBdyBLfpKTf87GZQ@mail.gmail.com>
In-Reply-To: <CAP01T77VRccr1feG4uiyWu0zAPf4oDFMJTVBdyBLfpKTf87GZQ@mail.gmail.com>

On Sun Apr 12, 2026 at 3:31 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
>>
>> The bpf_arena_spin_lock.h header is useful for all programs and not
>> just the selftests. Move it to the top level of the BPF selftests
>> to make it more readily accessible.
>>
>
> Please add something to the log to explain why __weak is needed, as
> indicated in https://lore.kernel.org/bpf/CAP01T77GwHgS04TM8yTODyiXh2VJq-=
=3DL0FPoRvjpfF4dc6T9zw@mail.gmail.com.

Will do.

>
> Also, since we discussed already, why not move this to libarena?
>

I left it as (imminent) followup work to make libarena completely=20
self-contained but it makes sense to add it from the very beginning.
I'll add move the headers in these patches.

>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Acked-by: Song Liu <song@kernel.org>
>> ---
>>  .../selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h        | 4 ++--
>>  tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c   | 7 -------
>>  tools/testing/selftests/bpf/progs/arena_spin_lock.c        | 2 +-
>>  3 files changed, 3 insertions(+), 10 deletions(-)
>>  rename tools/testing/selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h =
(99%)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/t=
ools/testing/selftests/bpf/bpf_arena_spin_lock.h
>> similarity index 99%
>> rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
>> rename to tools/testing/selftests/bpf/bpf_arena_spin_lock.h
>> index f90531cf3ee5..680c9e6cb35d 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
>> +++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
>> @@ -107,7 +107,7 @@ struct arena_qnode {
>>  #define _Q_LOCKED_VAL          (1U << _Q_LOCKED_OFFSET)
>>  #define _Q_PENDING_VAL         (1U << _Q_PENDING_OFFSET)
>>
>> -struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
>> +struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_N=
ODES];
>>
>>  static inline u32 encode_tail(int cpu, int idx)
>>  {
>> @@ -240,7 +240,7 @@ static __always_inline int arena_spin_trylock(arena_=
spinlock_t __arena *lock)
>>         return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LO=
CKED_VAL));
>>  }
>>
>> -__noinline
>> +__noinline __weak
>>  int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock=
, u32 val)
>>  {
>>         struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/=
tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
>> index 693fd86fbde6..acb9d53b5973 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
>> @@ -5,13 +5,6 @@
>>  #include <sys/sysinfo.h>
>>
>>  struct __qspinlock { int val; };
>> -typedef struct __qspinlock arena_spinlock_t;
>> -
>> -struct arena_qnode {
>> -       unsigned long next;
>> -       int count;
>> -       int locked;
>> -};
>>
>>  #include "arena_spin_lock.skel.h"
>>
>> diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools=
/testing/selftests/bpf/progs/arena_spin_lock.c
>> index 086b57a426cf..6c04e7707644 100644
>> --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
>> +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
>> @@ -4,7 +4,7 @@
>>  #include <bpf/bpf_tracing.h>
>>  #include <bpf/bpf_helpers.h>
>>  #include "bpf_misc.h"
>> -#include "bpf_arena_spin_lock.h"
>> +#include "../bpf_arena_spin_lock.h"
>>
>>  struct {
>>         __uint(type, BPF_MAP_TYPE_ARENA);
>> --
>> 2.53.0
>>

