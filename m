Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC03D9DC8
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583186; cv=none; b=dQs59deFFdJqbauO8B4kErG1W7ENTXT1obtdaru41Rq83Rmu8Vpu3dRuoqHs+sQdzDAGZ0SK3xpz4RgKf1dk53w0tpZryUigO5oh+g215JgRaDYxN2JxyTCh/4kW31APNfkLLK8LoYQoTZELjDddxfwty6I9MFx4do6QhXgHI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583186; c=relaxed/simple;
	bh=MZwi6OWa3e7mjtLPc/pgZ9x+HnB6R2gjZMigHAhvZ2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RtgZVkrx/UudR1togiieWQGV2mtiU1Z9FvAyb/AaRwicCGUJc7RoS/mwe9XLRHhpiY8rgssjsoWEURgj9RGiMfG0wzEGmFH5lJn8JMHGA4dqDfWqkwe0RcIHD2C+ai6KTeXAsnyA230kuo0KaWGMVj8NycR+qiQvko+PbO7zDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9MAUVQR; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9MAUVQR"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so81335e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583171; x=1790187971; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=US1CF1Tj6vGR4r7dJJGYQ4QXZD1gPMumLpxGyVWdnrc=;
        b=o9MAUVQRuFol0crJf6Q/Qu5DHS+LWNzfMRYuj0J1dsl7Z2GjxqKCK0AD/GuJgVj680
         DN9/XjsMAOOloKKYwQCDOa7uusNQXao62b4QStXmkKrGb/kyA1SAxNC8TzOgwLx2Ox8+
         D+vQaVrLWBpH5n2lS8B5ja+J29vm6Hz9UJn8EJ+qDB98VdLZyp/w80M+4P5OwFKT6glE
         JzkSdvPeVBnsPYsrgcDuMQAqTtZew+cZCNRW00hLmILpYLu7jJgKXIcJPgRcUmauCKpQ
         zy0JgvFUeraDV0T2VV9yZcT3JLCrom/5ufEoIDNCM30j96inXUEjInf7hCyPta3LE5KC
         wCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583171; x=1790187971;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=US1CF1Tj6vGR4r7dJJGYQ4QXZD1gPMumLpxGyVWdnrc=;
        b=RNIfGUCkioDR3eAewyUt3uiF96xUurg4yEATooHeuzwTtNKrCzVi6UE9tMAlmXVNO7
         Pcnx7C4kg2h9YhT0rlnJ0j5H/2o2arm9E70EAKtR2Jg3XgMhfK0xfm4gBG5fweV2MphU
         KNIjncjONw/BiGiiA6F0XB6iDej30AirQTj3zKnqOfKZIzPwnEvZjmig47BJijNCKBes
         iOUHrauRfulauc8oW5CGSt8xUBM5TJ2f8gkf+0Xb1YGYGH/BCo5w1NfYlZN21D5KSQJP
         Ci1EQHbZvgTqQP9dph1ELoRU0jDxr9vcjraKU8Ukl7avznIFQ5v2zF6+pryg27UTkJiL
         tSdA==
X-Forwarded-Encrypted: i=1; AKwUvBzDgeHiLjArjsH9VQJOd+zO2ezfdFRkX5nNJR3dnt6fixsB0+owOIqr+2WD8a310TJF6Xw=@vger.kernel.org
X-Gm-Message-State: AFuF++kH92s+yyBIHw8kHSwgnBDOXHUbpmkTtdV1bu0bnkGpS+1P/LGm
	W6sLphsLr3hYcfAsNvVO40Zg8a13o+JAduJT83HZ0DEW4WrMWXhdXI7GkxWP5+s8
X-Gm-Gg: AYBFou0ntnJNl0ifxasEzATk2zFiF0OdzkDLoIGCVGMtpAJP7Xw1dZ8r+aoe0swPmxy
	ZoRLdoibRwXlf4+4A3f+y2/Uszf8x8Iwxlz1jAFMd1jLQbSTC9/NGNf9Jjzb6SWnhgHwJq7fxOE
	iFa/+2tOdsxZHZ8wLxppklKXeUEq+zajdsaonsLHLqzTWhsdY2TFSkjdAxp3iPAU1mDS7x/jaAy
	eJPvkdzILJMvOATLpqJiRhsI2YzXkVgsC/QtrMeu/1bH2xEJtMFB/vRJfRGWK9JEF1W//4itcIE
	c3a5btPwDUCjNT9UGdKHwVa7nYCe8uNIhsBl5iQpNvCXHaTzK39ye+3R7BbVNr8Oi6xgSBQh2S0
	QXmqzg9cF/qNs/YUxYEaG+ArSAW74Hk1+aEDK2+UET0kGXq8rNYTymsFZsHWJhfj8cj/2LO9VRl
	kSbOoflcw72FmpgoKGQvFx2G8pVe0sJtS4STcil3pzsgxVP1IMCW2735vXlWQGhdgYzSnxeD7w5
	EUeBaA/ZIRWBa6V4PMoYR1IW3XEV6CQeUN2EGD4CM9bgdkZGH3sW5bzTUD4IzUa9s1bs71CcYV+
	vv1AOuuK6S6QCRo7t5vqxNIJbdxGPymh4pGL7UzhgSUviHok
X-Received: by 2002:a05:600c:6215:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-49eb72f16c5mr44350435e9.11.1789583170889;
        Wed, 16 Sep 2026 11:26:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fa7dsm9080089f8f.8.2026.09.16.11.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 20:26:09 +0200
Message-Id: <DLGYAEPM4TBY.332NDL5NSA5C8@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf v4 05/11] selftests/bpf: Test early in-kernel CO-RE
 relocation
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260914222514.1635018-1-memxor@gmail.com>
 <20260914222514.1635018-6-memxor@gmail.com>
 <91d077abd444c0941bc93260c7bc75b09fce7263.camel@gmail.com>
In-Reply-To: <91d077abd444c0941bc93260c7bc75b09fce7263.camel@gmail.com>

On Wed Sep 16, 2026 at 8:23 PM CEST, Eduard Zingerman wrote:
> On Tue, 2026-09-15 at 00:25 +0200, Kumar Kartikeya Dwivedi wrote:
>> Add a raw program load with CO-RE relocation metadata but no func_info o=
r
>> line_info. Place the relocation in dead code and require the poisoning l=
og,
>> proving that the kernel processes standalone CO-RE metadata instead of
>> silently skipping it.
>>
>> Also poison a subprogram's terminal exit and require check_subprogs() to
>> reject the resulting fall-through. This confirms that in-kernel CO-RE ru=
ns
>> before the verifier validates the subprogram layout and before later CFG
>> consumers rely on it.
>>
>> Load both instruction streams without relocation metadata first to ensur=
e
>> that CO-RE processing causes the rejection and diagnostic.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>> +static void test_early_core_relo(void)
>> +{
>> +	struct bpf_insn core_only[] =3D {
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	struct bpf_insn subprog[] =3D {
>> +		BPF_CALL_REL(2),
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	struct bpf_func_info funcs[2];
>> +	const void *raw_btf;
>> +	struct btf *btf;
>> +	__u32 raw_btf_size;
>> +	int access_str_off, btf_fd =3D -1, enum_id;
>> +	int int_id, main_id, prog_fd =3D -1, proto_id, sub_id;
>> +
>> +	btf =3D btf__new_empty();
>> +	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
>> +		return;
>> +	int_id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>> +	if (!ASSERT_GT(int_id, 0, "add_int"))
>> +		goto cleanup;
>> +	proto_id =3D btf__add_func_proto(btf, int_id);
>> +	if (!ASSERT_GT(proto_id, 0, "add_func_proto"))
>> +		goto cleanup;
>> +	main_id =3D btf__add_func(btf, "main_fn", BTF_FUNC_STATIC, proto_id);
>> +	if (!ASSERT_GT(main_id, 0, "add_main_func"))
>> +		goto cleanup;
>> +	sub_id =3D btf__add_func(btf, "sub_fn", BTF_FUNC_STATIC, proto_id);
>> +	if (!ASSERT_GT(sub_id, 0, "add_sub_func"))
>> +		goto cleanup;
>> +	enum_id =3D btf__add_enum(btf, "core_relo_poison_missing", 4);
>> +	if (!ASSERT_GT(enum_id, 0, "add_enum") ||
>> +	=C2=A0=C2=A0=C2=A0 !ASSERT_OK(btf__add_enum_value(btf, "value", 0), "a=
dd_enum_value"))
>> +		goto cleanup;
>> +	access_str_off =3D btf__add_str(btf, "0");
>> +	if (!ASSERT_GT(access_str_off, 0, "add_access_str"))
>> +		goto cleanup;
>
> I asked to update this to use utility macro, but if there are no other
> nits let's land as-is.
>
> ...

I have a local follow up, will send once this lands.
Thanks
