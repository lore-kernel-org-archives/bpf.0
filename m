Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56830C35F;
	Wed, 11 Mar 2026 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266752; cv=none; b=jpyhZNZBp0xs0oATa1b6Tu3P9ri+HyG1HOjuAUN/9l4Ljy7QKMDngLzCMc1PahmVqealmgJVXLF7gPA+6Y3ucaPrgin1KGf1H0h1ehgoLaTtmJWlU0mse3HKYHCM1z4T7rdP6RY/fIeh11GKxFxlB+ZePbcilpQaRpGOvjoVGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266752; c=relaxed/simple;
	bh=91FB1AHgMra9+09mR5vmCO8/+mAJlbaKOvMg7cw5oiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FbA/XTTMxMZkRzj/DKFYh6KPuUHgFjpgAe4aEJVBxseO/EKLo7L6kmN1XF+SYnMvtWDC3cA/2HkBGcGKCbA+t/X8HeFaHb0xNu5j6/EffPJpklHYPGLZuhB/K/oQU5G/wF0A9w6+1KcOsVc893tYCt151axksRE4tqPE9AgRx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=nJx57wff; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="nJx57wff"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1w0RgY-0003pd-Qm; Wed, 11 Mar 2026 18:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=91FB1AHgMra9+09mR5vmCO8/+mAJlbaKOvMg7cw5oiQ=; b=nJx57wffxM6REzmbNKnz
	7yXTcwapKnUKxuyJigAeg16q8y0vg1MUk7GbQSvOi1+9cvxb2X4eZNRHKihREJ4YMNAYrfw72ldIp
	BpOZ72y0g0/3E3cfqwKuIANgqsMae925KuP/PPMzSQVz+zn5xkDTW7uV+pSQ8QlQIvVDvZW4CqhFQ
	W/snMRlBkk7N45joxfIgHb9JNzfJViWT8qSkCU45VRuUuQOgLq53jAwGAOyVIQJcWDc/72rhi73oc
	xtU3HOicpOEjt6BL8FsZ6+xGNg475ZIHtlJBm/G1I5om8Wn4pQjs1Z0jn9CoIeTy3+5sEoqNxuB6I
	iQrlbt2b7yfnJA==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Hari Bathini <hbathini@linux.ibm.com>,  Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  Eduard <eddyz87@gmail.com>,  bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  Shuah Khan <shuah@kernel.org>,  "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
In-Reply-To: <bc410b38-f5ab-47cf-a434-fa4f43751921@linux.dev>
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
	<CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
	<bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com>
	<CAADnVQ+4N4WWLxan_qibZ7HmONJyMZaP=RF+a9tMSPoz=0LqkQ@mail.gmail.com>
	<09b101af-9722-4c45-bda0-c8a3dd417c03@linux.ibm.com>
	<bc410b38-f5ab-47cf-a434-fa4f43751921@linux.dev>
Date: Wed, 11 Mar 2026 23:05:37 +0100
Message-ID: <87pl5af2dq.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> On 3/11/26 11:03 AM, Hari Bathini wrote:
>>
>> On 11/03/26 9:32 pm, Alexei Starovoitov wrote:
>>> On Wed, Mar 11, 2026 at 8:10=E2=80=AFAM Hari Bathini
>>> <hbathini@linux.ibm.com> wrote:
>>>>
>>>>>
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check zero-extension */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val !=3D (unsigned long)a)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 1;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check no sign-extension */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val < 0)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 2;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D b;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val !=3D (unsigned long)b)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 3;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val < 0)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 4;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D c;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val !=3D (unsigned long)c)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 5;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val < 0)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 6;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> +}
>>>>>
>>>>> Overall this looks very useful.
>>>>> I would expand with another test where a,b,c are s8,s16,s32.
>>>>
>>>> Slightly different approach but kfunc_call_test4/bpf_kfunc_call_test4
>>>> cover signed arguments already?
>>>
>>> Ahh. Then may be tweak it to adopt similar fine grained
>>> error reporting as your bpf_kfunc_call_test5()
>>
>> I Prefer this.
>>
>> Does the below change to bpf_kfunc_call_test4 look fine:
>>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index 48dcaf93bb9f..6237c2222633 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -760,8 +760,30 @@ __bpf_kfunc struct sock
>> *bpf_kfunc_call_test3(struct sock *sk)
>>
>> =C2=A0__bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short
>> b, int c, long d)
>
> I might regret for bringing this up as it could be yet another ABI
> fiasco between gcc and llvm.

char is signed in BPF in both compilers, matching x86.

> As per C standard, sign of unadorned char (i.e. w/o explicit signed or
> unsigned prefix) is ABI defined.
> For gcc-bpf char is specified to be signed.
> So test4 has s8, while new test5 has u8. Would it make sense to have
> an additional test without signed/unsigned annotation for char ?
> This will flag any discrepancy between the two compilers.
>
> Thx,
> -Vineet
>
>> =C2=A0{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Make val as volatile to av=
oid compiler optimizations.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Verify that negative signe=
d values remain negative after
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sign-extension (JIT must s=
ign-extend, not zero-extend).
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 volatile long val;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* val will be positive, if JIT do=
es zero-extension instead
>> of sign-extension */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D a;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 1;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D b;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 2;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D c;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 3;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Provoke the compiler to as=
sume that the caller has
>> sign-extended a,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * b and c on platforms =
where this is required (e.g. s390x).
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Original behavior: return =
sum for backward compatibility
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (long)a + (long)b + (l=
ong)c + d;
>> =C2=A0}
>>
>>
>> - Hari
