Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A5370D5D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782880103; cv=none; b=TljNadSd9KdNsmkChp7hLdpv8PUpzfYby7uT/+g6fAOJfSNAspNWJhmAgj8Ge4bQU0mXeh8+gE0pgQvzJsPCVZop3vrGsdt87dNwMgCuUfk5eWsceWc2EHnUXGDsV094aV7iodfnNJk09UInrykmZSuQnS4ouVvxz96hXfea+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782880103; c=relaxed/simple;
	bh=6YFPtnSHkCCRVomlxqSApR2eFhCiAQNrvwHqxNExTDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U2NK1Kfyor3+n6EXJMMRiV9q0ptzSwUxblH5QBApbV6yAPUYzZMDbuDb6Fmn8/5BlckozUU37LqhZ7aFYMrAaks5uiicCq2SLqxAu0Frc14t4KEFgJVAPjDHi5AHVz7u4xuZKbRzGdbah05qMFTU4fhwd5OCRR71WibS4QzQhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=lC8qHfk0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="lC8qHfk0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e65e18969so13110585a.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782880099; x=1783484899; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XBbwkda6FSgQGJQszB99GbbZmnFZCo6wk+mm8mEasY=;
        b=lC8qHfk06dRwqeLI3PabPp6vnZGvA+XStz3xCpw9qftcHFZUnnny41ugjRxbMHuWyn
         vYGXBO2nwkOn3iBisQ0kLU1XQhxmNfIvNYBys6EqU+ygFc6zLaklLxsy/io8JKniqjqv
         FFzP8JGtY73VAVRSY63QX9rtfZzA3wGbFmnTqBSW6c6hIFr09qoX9qPeVQ0jK3xmmwpX
         NUTUiLQHQia5az3pYkTupGfSJ1qJV0dnk+y/jhXH+18gghHkC3I2+3oR87CjcNUSzbqu
         QjIyalE0Wtm+6wqoEnpZDtHAhzSaEyKKGFj72Q/iGUwAL54HqWvB3AZpOl7Kqr1A+BgI
         O4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782880099; x=1783484899;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XBbwkda6FSgQGJQszB99GbbZmnFZCo6wk+mm8mEasY=;
        b=IfU8gEqWmFp0RlCNonmLDVlwL3kGNCWhtwXrznOInrUMNJ7voc41Q8LfKKSHl+Zeoc
         xPPc27DPHxvPe42bY59tylk/d5ecof8v+gnSXn+xu2mREX7woyGlGtDM53S4SnKEBDH+
         9h9fqPrNUFoO5Qu1qGINwFMR5XykZSRvWZB83z605UzdUVKPpjXAsPryitB8aFk/C8rQ
         PA7Z2GHqQo2D1HKNqS8BYjUnbJik8Zxxrkgdj9lY/E/gPxIgD30QRWLZOmaWbZdH0bu4
         wWapKUxNDzEnoAcrRARrvjE3xi3tOVaozHx1wLqxabU3rIqKzryz4PPzmdMKnProc8+o
         xg3w==
X-Forwarded-Encrypted: i=1; AFNElJ+NziV4SbWwllrx8/xUTEaDysopGU5U77c3WlK1zA2t96NQ+2DiyxBTAmdcsh2UbYzNruw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bkxsYb8ZTfdg2lTdxZfxuDhRXBhtERkaKsYhMWn3gN24fI7w
	qIbqqbDjz/Eu+9DCAYqaBU5IF6naZ6ad1Sm/VsPkc2nkd3JCkatZIDpHcvvQJILhH1A=
X-Gm-Gg: AfdE7cmDKapkjBlf+tRkyglXnmYyBaMMh8YzyxqUNRBDW07rqtcOEjfojI/9ocK8DZm
	J8fLE0BsSXfpxhPLjtiLkN75gomczoDLOg63WpWTEpC6P4BozMZgSbHy69Ul4tsGBfEHK2DfnJr
	vMH4DGSbNCm/fhCjM9tu82zBFECmNyX0NQeuXGaq3OccHpd3Pg2c5hGrx4INk2XI55/+J8Oidng
	KHVvn9eenBnrkqW0WvHMKJ89nXtHjvGhK6fR+v4jcL11cfBSGw/p6jSBVZPY2lP2AnPuYzv26HI
	v4tXf7clccYD1DkxAQZrUFHVN2hpI2wE4Hi/NX4PoYWMGXITHpK/YG/DU9/bC3LPnX+e3Upswls
	BdVOKvwrvgWMc+vwhJgsho1T3orjqpmE3T8azLzNLpBaGNPn0DV2ExeZE4GGRNTd0RfhgZ1nbwd
	GthWMmxlORQTs=
X-Received: by 2002:a05:620a:4413:b0:92d:69cf:6d2f with SMTP id af79cd13be357-92e6980e560mr584379085a.34.1782880098653;
        Tue, 30 Jun 2026 21:28:18 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213b95esm449760285a.5.2026.06.30.21.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 21:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 00:28:17 -0400
Message-Id: <DJMY8XUE7ACK.2AFH8H5HUB4C9@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: libarena: Fix can-loop zero
 variable definition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-3-emil@etsalapatis.com>
 <216b5567-a3f6-4720-8528-9868afe2012a@linux.dev>
In-Reply-To: <216b5567-a3f6-4720-8528-9868afe2012a@linux.dev>

On Tue Jun 30, 2026 at 3:28 PM EDT, Ihor Solodrai wrote:
> On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
>> BPF can_loop based loops require the index variable to stay imprecise.
>> This means we must initialize them from a currently imprecise variable
>> instead of directly assigning 0 to them, like so:
>>=20
>> static volatile u32 zero =3D 0;
>>=20
>> for (i =3D zero; i < NUM_LOOPS; i++) {
>> 	/* loop body */
>> }
>>=20
>> The libarena implementation of this technique is currently faulty. For
>> the technique to work, the variable must not be in a map. This includes
>> the .rodata DATASEC map used for const variables. However, libarena
>> still defines the zero variable as constant.
>>=20
>> Modify the zero variable definition into a volatile variable. This
>> change adds a complication caused by the compiler optimizing array
>> derefences from
>>=20
>> for (i =3D zero; i < NUM_LOOPS; i++) {
>> 	val =3D *(ptr + i);
>> }
>>=20
>> into
>>=20
>> for (i =3D zero; i < NUM_LOOPS; i++) {
>> 	val =3D *ptr++;
>> }
>>=20
>> and causing verification failures. Use the barrier_var() clobber macro
>> to prevent this optimization from taking place. After that, remove the
>> bpf_for() invocations introduced in libarena for parallel spmc testing.
>>=20
>> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../selftests/bpf/libarena/include/libarena/common.h     | 2 +-
>>  .../bpf/libarena/selftests/test_asan_buddy.bpf.c         | 8 ++++++--
>>  .../selftests/bpf/libarena/selftests/test_buddy.bpf.c    | 8 ++++++--
>>  .../bpf/libarena/selftests/test_parallel_spmc.bpf.c      | 9 ++++-----
>>  tools/testing/selftests/bpf/libarena/src/common.bpf.c    | 3 +--
>>  5 files changed, 18 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/commo=
n.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
>> index a3eb1641ac36..931ace9a49e2 100644
>> --- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
>> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
>> @@ -43,7 +43,7 @@ struct {
>>   * imprecise. To force the variable to be imprecise, initialize it with
>>   * the opaque volatile variable 0 instead of the constant 0.
>>   */
>> -extern const volatile u32 zero;
>> +volatile u32 zero __weak;
>>  extern volatile u64 asan_violated;
>> =20
>>  int arena_fls(__u64 word);
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_bu=
ddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.=
bpf.c
>> index 256d62a03ce7..3266a28f53d7 100644
>> --- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf=
.c
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf=
.c
>> @@ -154,7 +154,8 @@ __weak int asan_test_buddy_oob(void)
>>  	size_t sizes[] =3D {
>>  		7, 8, 17, 18, 64, 256, 317, 512, 1024,
>>  	};
>> -	int ret, i;
>> +	int ret;
>> +	u32 i;
>> =20
>>  	ret =3D buddy_init(&buddy);
>>  	if (ret) {
>> @@ -163,6 +164,7 @@ __weak int asan_test_buddy_oob(void)
>>  	}
>> =20
>>  	for (i =3D zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++=
) {
>> +		barrier_var(i);
>
> Looks like we are using two different idioms for keeping indices
> imprecise and blocking the compiler optimization: the `barrier_var(i)`
> like here, and `volatile u32 i` declaration in patches #4 and #5.
>
> My understanding is the barrier is generally better performance-wise,
> since volatile var would be re-loaded every time.
>
> Does it make sense to converge on a single pattern (at least in the
> context of libarena)?
>

I'm not sure we need to completely standardize because each idiom has its
uses, but I do like the idea of mostly using one of the two patterns. I
will try using volatile here to see if it prevents the loop optimizations
and will update it next version if it works.

>
>> [...]

