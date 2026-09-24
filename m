Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D645517F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243824; cv=none; b=of367e+tWCfNpwzySu3uWRM5nwKK4tD5frK5kQQkLxLRHuptDt4DADSqzDB5IJCrqvnI2FEqCmwn5rVIft3L3Ko+ifYuba20RGRWMyjqgfKJHK/sSYvrYUYWaTERlQdCF1uEdmo3DDXfk2mZLILqi1SQKGrta/0Tw5g9gRlGdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243824; c=relaxed/simple;
	bh=Owbu+59iTry2YEZlQRoz+Eor72nCGDC101ywKxSYQwQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CZM54kwDESIGFQIZA6480iePLD72XtYjBNZd4fLYaJl39RaliX94Y+m8mE1DrKn3j5NoC9T9uC9UKxWjdusj70+Yky3i5PA5znrwQu7VzqDHZD3VkqAZvGKbUTnp8FR98p9JZ7c3dh27lih6UcOhiX1gyCsZADfbdmWu9DoIFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5e3aPPk; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5e3aPPk"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49fd76faff2so645355e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243818; x=1790848618; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=unMgVo+Xk/SrgqihvCluTSzZ7l8LbE/LQXb8te5c+ro=;
        b=I5e3aPPkaVm4DYzuAipE6AxWc6+1SWfeRuNwd9ZkpL9KQub1BTDy0luLLmKisA+rR3
         Z+hkG+8eviPloTZ8rd2uUB6PfSntd0hpMKwO89vmzv9am5O8RgxkJkmybsQzonMT6Yxn
         kEDsoTCDvVUNzwXW4kzT5HfGVewmOSKKrMjVtdbVoN2dKP8jul95L53LgkOYVpTDtgEB
         mbrVFYEDBomUMu1kIPmXsFEl6HJtxlxSKblkfKwXVXPbM7CXeyoemzwH8crx4cf57kis
         3dTBvKtU6q7B+gr2OzI0oct+UZRSnDtA5C+0o/01fTSZGPAa4tWoOCLT0Fwp9tMhKYpv
         aAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243818; x=1790848618;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unMgVo+Xk/SrgqihvCluTSzZ7l8LbE/LQXb8te5c+ro=;
        b=I5/GnG9HKtxnd4J7oH3hpx80I2k2pgNGsa3vgFiRE4nz1DeykJBRjpPqP2+j0M4d8+
         PlA4pD2GfVPISNfQy3R1RtXmcS/hHqORnQCdYG1mE6LFbj1eQSOzM0yJ8+VrEru29myv
         VMpJMIlKf+25pQSEmsEP9aHbAL0G6zP+fAC6MGHLAo6u5a9VkijAd4mNDupXgUP2pKWK
         TEBCVC7Pb1cXGLGfA29g5ZLjXXNLyJp6zl+nB4wwiCmuZs93ouzj7t6PGgJy54I27Sn4
         KPkgxbk4ZpH6OCdTaEqxb0+YStKyJx9mOFuodTqwdkXWlwQ+5pAzMLAOdDnfh6r8waLq
         qBxQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5JL725UdtREuvT5I+zVjk1O+7aWmCQkX/JDJiFt76NnbbYu6rYnIAQ7vd/d0PQJOhPdM=@vger.kernel.org
X-Gm-Message-State: AFuF++lbXMnuys+zOS0BlVtaJmeiD4XB1ghpf+D+rE3wxUAbgQgn1Dr0
	07rAmRBT/srCkCJqydPGV/1drytlJWj0ImkJt6v41K2fkXc8ZPvbvjp1
X-Gm-Gg: AYBFou017ITxEGwQ6E05zI0Gyj+4wAwCt9I44l45qNKaVAZM+oqWQFpSRHtYuikbQRI
	PCvkYp1kfY+bbd0DiSZBQUCNMpP+v2NxjocBiQbb/TlqAWKuq0n6hW8F+qH1gQJS2YB72vScG3u
	vcTa3pA4mlUZMXOw7Q1YsRN0SeoUlavo0C5Omn2T6WwJji0nj6T0uQpRG/nxgOqIOIvE0ZVmSUD
	ct7r4tu+1Xxk1OjzSW2m93PuUBnry3T6KHvEfvH9mpFZrCs/QgoV/+ie8YQrEkRZWvDZ1rXRDL8
	FWVH+ZTk993MeYie78RWM0p96rkBdNlT1BCMQrZRGmdP5N0IT996pU62ClJifrb2qD3DA7SCh1P
	47wR5hfSmwdy5/y06Llxq8MdzxwPZECm45Mtnl6PHEiFvGFaZYi2d5ILWzGEDHybeX3oZDpS/z6
	yG4jcb/f1jYJ/9wWm+ckJFTXLtMpRrvglICxOnOXbepwN47xnmANJt/8Lo/O2A6l5tJl1cQ4m6D
	53vDx6hy6/GkJz7cm9J8M+WJAzfBhFoqpKAcVhPuRunqCRidrKqZaqM9+R6Y9Y08YAw0EnHxKcY
	r8W9pALK+ghb/RRNcNazzmXHXrvddmEkOmtNdXE=
X-Received: by 2002:a05:600c:3b01:b0:49f:ce79:7a8d with SMTP id 5b1f17b1804b1-49fe670b3e3mr31861305e9.17.1790243817984;
        Thu, 24 Sep 2026 02:56:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bb9891sm49224735e9.6.2026.09.24.02.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:56:56 +0200
Message-Id: <DLNGGVPEO7RM.P2G3TKXBCGCT@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 15/18] selftests/bpf: Give the 512-byte
 stack boundary tests a 2 KiB twin
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-16-memxor@gmail.com>
 <24dfe7fd22d578517f54fb854f4d76ebfa4414ec48b2fcc751b2045f88a624ae@mail.kernel.org>
In-Reply-To: <24dfe7fd22d578517f54fb854f4d76ebfa4414ec48b2fcc751b2045f88a624ae@mail.kernel.org>

On Thu Sep 24, 2026 at 11:13 AM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b=
/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
>> index af1f9305da37..e39202902be4 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
>
> [ ... ]
>
>> @@ -589,13 +589,58 @@ static unsigned long use_stack_304(void)
>>  	);
>>  }
>>
>> +
>> +/* Four 480-byte frames, deeper than any budget together with their cal=
ler */
>> +__naked __noinline __used
>> +static unsigned long use_stack_480_0(void)
>> +{
>> +	asm volatile (
>> +		"r0 =3D 0;"
>> +		"*(u64 *)(r10 - 480) =3D r0;"
>> +		"exit;"
>> +	);
>> +}
>> +
>> +__naked __noinline __used
>> +static unsigned long use_stack_480_1(void)
>> +{
>> +	asm volatile (
>> +		"r0 =3D 0;"
>> +		"*(u64 *)(r10 - 480) =3D r0;"
>> +		"call use_stack_480_0;"
>> +		"exit;"
>> +	);
>> +}
>> +
>> +__naked __noinline __used
>> +static unsigned long use_stack_480_2(void)
>> +{
>> +	asm volatile (
>> +		"r0 =3D 0;"
>> +		"*(u64 *)(r10 - 480) =3D r0;"
>> +		"call use_stack_480_1;"
>> +		"exit;"
>> +	);
>> +}
>> +
>> +__naked __noinline __used
>> +static unsigned long use_stack_480_3(void)
>> +{
>> +	asm volatile (
>> +		"r0 =3D 0;"
>> +		"*(u64 *)(r10 - 480) =3D r0;"
>> +		"call use_stack_480_2;"
>> +		"exit;"
>> +	);
>> +}
>> +
>>  /* stack of all possible callees is accounted */
>>  SEC("socket")
>> -__failure __msg("combined stack size of 2 calls is")
>> +__failure __msg("combined stack size of {{[0-9]+}} calls is")
>>  __naked void callx_rodata_stack_depth(void)
>>  {
>>  	asm volatile (
>> -		FUNC_TABLE2(tbl, ret0, use_stack_304)
>> +		FUNC_TABLE2(tbl, ret0, use_stack_480_3)
>>  		"r0 =3D 0;"
>>  		"*(u64 *)(r10 - 304) =3D r0;"
>>  		"call %[bpf_get_prandom_u32];"
>> @@ -613,11 +658,11 @@ __naked void callx_rodata_stack_depth(void)
>>
>>  /* stack of a callback that is read from the data is accounted too */
>>  SEC("socket")
>> -__failure __msg("combined stack size of 2 calls is")
>> +__failure __msg("combined stack size of {{[0-9]+}} calls is")
>>  __naked void callx_rodata_callback_stack_depth(void)
>>  {
>>  	asm volatile (
>> -		FUNC_TABLE2(tbl, use_stack_304, ret0)
>> +		FUNC_TABLE2(tbl, use_stack_480_3, ret0)
>>  		"r0 =3D 0;"
>>  		"*(u64 *)(r10 - 304) =3D r0;"
>>  		"r6 =3D tbl_%=3D ll;"
>
> This isn't a bug, but now that callx_rodata_stack_depth() and
> callx_rodata_callback_stack_depth() both use the use_stack_480_*
> chain, is use_stack_304() still needed in this file?
>
> In verifier_callx.c the function is still used by callx_stack_depth_ok(),
> but in verifier_callx_rodata.c nothing references it anymore. Could it be
> removed along with the extra blank line after it?
>

Dropped the unused use_stack_304() from verifier_callx_rodata.c for v3.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

