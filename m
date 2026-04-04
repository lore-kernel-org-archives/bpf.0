Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC733C198
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775329233; cv=none; b=uB6GW5YwO2n5J5cwf+gqbV5Vc4PjuzNzzR13qXull9E3ivNQvLjk//UWAFJv7mDZzc8DyOJmzXIUlxnS+JISv4fZ/vZPw3uJ0jg++1Zn58hDk0e3cIvJCamjaIsoL2bPUL6WZCKDM/+T3hP8j4au81XG6UxPJAyZFr4JZpgdUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775329233; c=relaxed/simple;
	bh=y/F9zJW116kqSCgX9tb7rttGKjeuesdxHbOUiOq9dkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=smV12cc2Luts2rq4CZxg36LKgGGmEHj6XtLOVBkg+jcpnDeamRif0TdPOA/qzhnIm20CJuM3m0w7zFnHXisA8H9w9FvAdzywCbIWeKqs8mYQraiSxN4yyZv2+C7FqLw74UuAHqtlCCKxRybl1U5loDQ9Rw7b8WCaO4+rm1hGXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=fQlEW8Il; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="fQlEW8Il"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab39b111b9so11905585ad.1
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775329225; x=1775934025; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Gdp6fln9VvllFuk7oFYv6Pa8/Q2Dlz68ibPkatf54=;
        b=fQlEW8IlNwqkGi1/0LAVE0c3P85Wsfybye96JNFbtVXZJ2pMUP/9zIzrhN5OixJmYP
         /FR2JrxVxgpL54cd+13BD7aMUKvezI4s5J/wDDI1Eon/CSoEKOOD2z8rqnuwgS8Ix3w/
         dbr3Dh1M029cGawyMWJK7nX/eaxw87HfyMjLfPK8pN9g29G7git2n1kwn3MXhkygjrnL
         Q91CiZqV0q7QJ2r9ov4s5bDzHrjiIQJQyNQzzp86SJ/wh0YqiK0tZwv7vLevVgGPDN6J
         cQfS0VjOK7dd7UgDOvI/dUby4h69rBxAwMU5TggTLCWCctRS4ZZtSEtthe2uc3kU1shM
         Mxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775329225; x=1775934025;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3Gdp6fln9VvllFuk7oFYv6Pa8/Q2Dlz68ibPkatf54=;
        b=XqDV+hGD3CrckXn8e9pCPYhz0lbkANZgNDTXxHWCsH0C6Gf1kCd1n0l1pwmh7pE/ou
         JwHZUrKqgVYGTdeDd78h3K1nwUTdnqhx/A/4IcqZK58MV/k6TuXBk/fAg3D995qmBqSr
         BTs/MaxfOvmPEN3kL0Chr3xRibBy0Wa5bzrGA3sbRSUS1HrYLToypIUx4H1JsDuaSigU
         5YD31/dH+CNVfWfzT7gOex0NoZmsUIv+4/uCM9Su8uXmhPS0EjdIEI60cEOnXPmHNPcl
         gwpBMQk5DGPc4quL4YPPdjYuhh/Fk2Gk9LeJLlqbSvDQRD01VuN4mhcUkxnbDVAhQQdx
         7aHw==
X-Gm-Message-State: AOJu0Yzb+qBvjQL1po1xr94X8OkiSVrGWIfKNvrv6e2j86HeWIciVpV2
	HtgXIym0C//IeMjz9BKpCd/Jk8k1eeSzaDQfvEFsa3ubG03Nvahm4spjCa/bqpHrSM4=
X-Gm-Gg: AeBDieuF6lJKGEarqPcwhccKmEziPV8uDD4K9YJE+rWIPULzEYJigio03+Z+WWQZAhQ
	2pE51K9TOf/Xx99umRU9IHlrxxhLWB5/bk1mpzi67c7H/ueilOSliejYbK/L59udg2Fvo2SCQHg
	mbyKJAeVdmW/oIq+l927BloP3ueXIr1EnBUXRaZUk3ZLVL12kwSzj8YsUB7yoXjptcgvfIOhx7C
	+C9o4rJ09gdsedjuaZP/2hlKZH3Kg1Yn+2OQlf6XpJ7cNSzB4rvaJPzyJ5D88CbAedtu9YeWbQl
	tDj03lFhqEN4MDSbbvnWN+caGX2a6OoXSAexpoPmAlXSw0YXKjweGJf890/DH5t+M64FZmEIIk1
	HktP3jEcHGaNKu4gNfE6BK3hFLsbLZ0wnTDtQtjmnY86mMFCjKY3vxToToyD58ucbe10ABu9hTJ
	vZKRiypnM=
X-Received: by 2002:a17:903:1b2c:b0:2b2:5515:661c with SMTP id d9443c01a7336-2b28176a8a8mr75656905ad.31.1775329224119;
        Sat, 04 Apr 2026 12:00:24 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbce2sm91044345ad.79.2026.04.04.12.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 12:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 15:00:22 -0400
Message-Id: <DHKLOPTK8IW9.KVASSDNT9UQJ@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Emil Tsalapatis" <etsal@meta.com>
Subject: Re: [PATCH bpf-next v3 2/9] selftests/bpf: Add test for
 scalar/arena pointer addition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403042720.18862-1-emil@etsalapatis.com>
 <20260403042720.18862-3-emil@etsalapatis.com>
 <CAADnVQLGfsEsMp=yhn6wk03AwXkWgGf3KF9UL6U0-SbuhtbzJw@mail.gmail.com>
In-Reply-To: <CAADnVQLGfsEsMp=yhn6wk03AwXkWgGf3KF9UL6U0-SbuhtbzJw@mail.gmail.com>

On Fri Apr 3, 2026 at 4:25 PM EDT, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 9:27=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> From: Emil Tsalapatis <etsal@meta.com>
>>
>> Add a selftest that ensures scalar +=3D ptr_to_arena instructions
>> are accepted by the verifier.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../selftests/bpf/progs/verifier_arena.c      | 29 +++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/=
testing/selftests/bpf/progs/verifier_arena.c
>> index c4b8daac4388..450e8f1181cd 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
>> @@ -477,4 +477,33 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
>>
>>         return 0;
>>  }
>> +/*
>> + * Test that scalar +=3D PTR_TO_ARENA correctly upgrades the
>> + * destination register to a PTR_TO_ARENA.
>> + */
>> +SEC("syscall")
>> +__success __retval(0)
>> +int scalar_add_arena_ptr(void *ctx)
>> +{
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>
> I think the #if can be removed, since the whole test is in asm?

With Clang 18 the assembly fails to load for me with "Invalid operand for
instruction". AFAICT this is because addr_space_cast is only recognized as =
a
valid instruction from the BPF backend starting Clang >=3D 19, which is
also the first version that defines the feature flag.

>
>> +       int __arena *result, *arena_ptr;
>> +
>> +       /* Needed for the verifier to link the arena to the subprog. */
>> +       volatile char __arena *base =3D arena_base(&arena);
>> +
>> +       /* Passing base here to avoid optimizing it out during compilati=
on. */
>> +       asm volatile (
>> +               "%[arena_ptr] =3D 8192;"
>> +               "%[arena_ptr] =3D addr_space_cast(%[arena_ptr], 0x0, 0x1=
);"
>> +               "%[result] =3D 12;"
>> +               "%[result] +=3D %[arena_ptr];"
>> +               : [result] "=3Dr"(result),
>> +                 [arena_ptr] "=3D&r"(arena_ptr)
>> +               : "r"(base)
>> +               :
>> +       );
>> +#endif
>> +       return 0;
>> +}
>> +
>>  char _license[] SEC("license") =3D "GPL";
>> --
>> 2.53.0
>>

