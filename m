Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA3376A03
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879843; cv=none; b=A7vO5UPfcr/4SIQ5QWRAuy/1lE/Vg0nuptJjKJyyaEOvyGz2Ssu4JMWXtoy1gZ9mqIh2MkCdWWiOXixddKd9uCO6zdDuxH2jAfTTpaqJk8S0pa1W/D9Vm853dI73mW7kpXGfqEv4+HC9/dAfdEPQ+J4/9QZW/Ras/EQwG4qJiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879843; c=relaxed/simple;
	bh=8cAwaxgvQZGGKIVdECuXydpF29wlVKN1vRQ7HH5wCs4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ABDMIjAYUwaitqSEHCb1tS82EG7OgaTR4TKaoK4iXwzIuFK2CPKPLnqVxnUnW9JJP14lfZm0iTaRK3IA+pd/9mnqa5hfwPvyx9cMo8kjbYrkDPhIHb4clAghIXUaJpTjLs8O/2y4n067Cp1OYACSGJTupb8PeeL0q/sOguK8zCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZhOnbQAX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZhOnbQAX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9204711e831so16634685a.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782879838; x=1783484638; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei/A7ajtriKCNWucbKkIvBbQpwSzKQDL9w7xUWHjUJU=;
        b=ZhOnbQAXXw5b5TAzy1GCAO9eVtc169XnWJSKD6r7taOH+KQb3IBhk7nGeKPdgdTVvy
         G8cwMERHiOSGnT9yo1mvrpPks20onsxuCPiIF2silW4GkflwTs+nrMjbRpn2sehgoUNQ
         cvGTqZ4dCiL0EXd+TfP+xNEyYA0Un+5J38haGNhdm6CQhP/fc6OYx3JHQtNdm4QFoIUl
         AYV9NwlYexDO/fGoyrFYahDO9V/5H7Z4Zf9Am07oz84JlI+MsM1gVsnsMyv40mIqmema
         IQSU5YrbiGVMte2J8lQYaMUXu5xPscZd0eMvNAQAxwCgGYmkzcuW+pQyXP4jhumpRNzR
         6Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879838; x=1783484638;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ei/A7ajtriKCNWucbKkIvBbQpwSzKQDL9w7xUWHjUJU=;
        b=Ec4MtTc18rQAmIzGmw/j7M54ajeHt2lJBtwltbqhJaAmx76R+EQye/KWboQzmCoL5u
         NR2NGGICM2XzPVgyGsN22ZbAL1E/unQWIKUMof5pcXDoSz48lQqBzJxZqkY5w+PGdaUM
         kq3e0Jb5XWVik/CpxrAMDdBmPG3Dl7OOcJW5R/K8kmrBW8zvPCPssepthPdio29GU+PN
         U5YC+X5wWHo7l7JTPR1dH5ndZ+g4pCitnGy54o65pFS30O9HVU9G+rNnoLrllOocWkEv
         6hl2xPNysG6pbML+ymFeBAyNKyMgniL5ToMbrlBd6sy8a9PAWwi7fLs5VpG1iSauWvUX
         xYVA==
X-Forwarded-Encrypted: i=1; AFNElJ+Zbo6rXcpZIIRiT5lBky+20JfwSIs2p+t2CuT1/sxG7LkgVloUcY/Sc0N7cBzQCov7SEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/B4dBJBrWxjCYYyAB2nDOD8K2WrqQrtPdTjtc7SLnbVAjyKg
	myTGEDztAKHcwTOxQsnhd3fL4+cmOI0LbYp3mBoNyu/nvuR22mWGLl1j6EzYRCuYcL0=
X-Gm-Gg: AfdE7cmFvRXBSK45PKwCTg8wmOsUlbNguy1pLrgywz9JB6DhWATp3nonuhbgxjtxV2m
	9w1wIlH6VX3FHi7tCFLpJV+Gu5DGvJBIHRoPHnbMfJweVsa7BjYlIzLsLBeWUWvJFN72ROgpkdh
	n1Bhi7s5iv8cEKzKjLn6IiA4X+2w0nRRetCcZoYhersqvici1GDLQ/CGb2a7wNyveDdYuMSjJbh
	ZcjVYH/dRhcyhdFFFszO4zZUrufXU524MZxa4FR+/7YFCfY6bPt/nGZvqZM1wYgfINahr/ivVgN
	dAnpZYY2SrChK8vFPwnEqs18M9FB0BWVxhthwJEmXFQSCewi+CuFN/Qc7mPVOPmWEs3wvwQCvvc
	uq9e5YirlBPJquhnNXVJbkYRHJpVruAg/2ww44rruOkIv20uYo1W4wXZEfeLM3UiowE67JALigK
	K8ZgbHdCVq2tnbFDc9AIk0Jg==
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr9711885a.70.1782879837638;
        Tue, 30 Jun 2026 21:23:57 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e84e5sm467895685a.24.2026.06.30.21.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 21:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 00:23:56 -0400
Message-Id: <DJMY5LS95UXJ.2WGIAIR37QEX3@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next 1/5] libarena/selftests: Replace leftover st_
 prefix with test_
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-2-emil@etsalapatis.com>
 <9fc9896b-cd48-4df8-a311-b2d4d266fcdd@linux.dev>
In-Reply-To: <9fc9896b-cd48-4df8-a311-b2d4d266fcdd@linux.dev>

On Tue Jun 30, 2026 at 3:21 PM EDT, Ihor Solodrai wrote:
> On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
>> ---
>>  .../selftests/{st_asan_buddy.bpf.c =3D> test_asan_buddy.bpf.c}    | 2 +=
-
>>  .../libarena/selftests/{st_asan_common.h =3D> test_asan_common.h} | 0
>>  .../bpf/libarena/selftests/{st_buddy.bpf.c =3D> test_buddy.bpf.c} | 0
>>  3 files changed, 1 insertion(+), 1 deletion(-)
>>  rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_buddy.bp=
f.c =3D> test_asan_buddy.bpf.c} (99%)
>>  rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_common.h=
 =3D> test_asan_common.h} (100%)
>>  rename tools/testing/selftests/bpf/libarena/selftests/{st_buddy.bpf.c =
=3D> test_buddy.bpf.c} (100%)
>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> nit: An empty commit message is weird.
> The short message is self-explanatory here, but still...
> Maybe a brief comment on *why* this is done?

Ack, I must have a forgotten it... It's a cosmetic change to make it
more obvious what the test is.

>
>>=20
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_budd=
y.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bp=
f.c
>> similarity index 99%
>> rename from tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy=
.bpf.c
>> rename to tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy=
.bpf.c
>> index 686caba2c643..256d62a03ce7 100644
>> --- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf=
.c
>> @@ -12,7 +12,7 @@ extern struct buddy __arena buddy;
>> =20
>>  #ifdef BPF_ARENA_ASAN
>> =20
>> -#include "st_asan_common.h"
>> +#include "test_asan_common.h"
>> =20
>>  static __always_inline int asan_test_buddy_oob_single(size_t alloc_size=
)
>>  {
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_comm=
on.h b/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
>> similarity index 100%
>> rename from tools/testing/selftests/bpf/libarena/selftests/st_asan_commo=
n.h
>> rename to tools/testing/selftests/bpf/libarena/selftests/test_asan_commo=
n.h
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf=
.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
>> similarity index 100%
>> rename from tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.=
c
>> rename to tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.=
c

