Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F40223DC6;
	Wed, 26 Aug 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757585; cv=none; b=Po7CBxrpay7AQyryGw7aQE3bKRDVqaJFRA//mkwEUoMFuOGw9ETTkV08CRk4oUL54n+BAR5YvMi8KaRSzBtR3DKMCxXsrD31KSf/YUOQCZNV9LqwefO6CIHC8w7bLeRZjiOiJSNacTAWo5R9fjnKjPvfMkRigz0pJoywfXA+y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757585; c=relaxed/simple;
	bh=ebsJXJehWq8vQ2+yk0Ww03KoJu5igP9PLWsd/FlrZiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=G5YZlAizTpcl18TUW1RbyWzkmWT5bHtowVXwd+0jg1kvmWzEuNNZkozk73OWqYvMD7iebNcjbM2Aos2JLj9+b4u1bDoF+XXWfpX12bOICgyjTU7mPxMFaPZwKVLFi0QQSuHMzzYDYw/l++iEcP/oWkVxe0/nM+CNMcXCDYotQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HjpO8jxg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HjpO8jxg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C248A1A1842;
	Wed, 26 Aug 2026 15:19:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90193604EC;
	Wed, 26 Aug 2026 15:19:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6759111C783C1;
	Wed, 26 Aug 2026 17:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787757573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dcHHWyRJIterVIg89zHGHjBsGnWPtPc3BMd4jHQ4tok=;
	b=HjpO8jxgTnzphcnBhRkTuVBnoROWiD8ubMM1sxHlKesRQbfnHEQ7GBcYy6SH1Hy9r14VPR
	s0OeD/uZAPPWDN+FdAqVsdEEQrjb2Jmb1oEkEOwN9jBl1Da3/MmjY1qwz56A7I0Rn7VEg1
	T+4ZkXQr+RHeewEMt/BL6sZj0re/LM68MpNLNnkFw88bSakavz1jwNgGpXdJXMg65p9jfv
	VZ5V00qUyWZoyIsw/yozVWe9iQgxFbmQ51Fbqlttk9coWzl1De01/TetpG5C8W5CqpgD4N
	cnA5K4PgCJ0e2sraXUT7bJOF45weSFkaUVmWS57sLEBErb4wJ3cBrgYx2CYdtA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 17:19:25 +0200
Message-Id: <DKYZ5ZH2J5A4.2E44FZDA68OKK@bootlin.com>
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bot+bpf-ci@kernel.org>,
 <alexis.lothore@bootlin.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <tglx@kernel.org>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
 <shuah@kernel.org>, <mingo@redhat.com>, <andreyknvl@gmail.com>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next v7 1/9] bpf: mark instructions accessing
 program stack
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260822-kasan-v7-1-99afee6ef7fd@bootlin.com>
 <f6a88fe55d543f5fe2a6d9e856acb4cf1b87b8210de58459df1272c8a456d926@mail.kernel.org> <DKWOIW8NUFZA.1QPBXZJY5YYOL@gmail.com>
In-Reply-To: <DKWOIW8NUFZA.1QPBXZJY5YYOL@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Aug 24, 2026 at 12:33 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 22, 2026 at 1:24 AM CEST, bot+bpf-ci wrote:
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
>>> index 004b06785521..412a13a664fa 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -725,6 +725,8 @@ struct bpf_insn_aux_data {
>>>  	u16 const_reg_map_mask;
>>>  	u16 const_reg_subprog_mask;
>>>  	u32 const_reg_vals[10];
>>> +	/* instruction can access non-stack memory */
>>> +	bool non_stack_access;
>>>  };
>>
>> [ ... ]
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index e036ae20bf6b..040af75d9550 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -3272,6 +3272,11 @@ static void mark_indirect_target(struct bpf_veri=
fier_env *env, int idx)
>>>  	env->insn_aux_data[idx].indirect_target =3D true;
>>>  }
>>>
>>> +static void mark_non_stack_access(struct bpf_verifier_env *env, int id=
x)
>>> +{
>>> +	env->insn_aux_data[idx].non_stack_access =3D true;
>>> +}
>>> +
>>
>> [ ... ]
>>
>>> @@ -6654,6 +6659,10 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, struct b
>>>  				clear_scalar_id(&regs[value_regno]);
>>>  		}
>>>  	}
>>> +
>>> +	if (!err && reg->type !=3D PTR_TO_STACK)
>>> +		mark_non_stack_access(env, insn_idx);
>>> +
>>>  	return err;
>>>  }
>>
>> Does this test read the correct register type? For a load instruction wh=
ere
>> dst_reg =3D=3D src_reg (e.g., rX =3D *(u64 *)(rX + off)), check_mem_acce=
ss()
>> receives reg =3D &regs[src_reg] and value_regno =3D dst_reg, so reg poin=
ts to
>> the same slot that gets overwritten by the load.
>>
>> When the pointer is PTR_TO_STACK, check_stack_read() runs:
>>
>> check_stack_read_fixed_off() {
>>     state->regs[dst_regno] =3D *reg;  /* or mark_reg_stack_read() */
>> }
>>
>> By the time execution reaches the new test, reg->type is the loaded valu=
e's
>> type (typically SCALAR_VALUE), not PTR_TO_STACK. The condition evaluates=
 to
>> true and marks a stack-only access as non-stack.
>>
>> Both check_load_mem() and check_store_reg() snapshot the pointer type be=
fore
>> calling check_mem_access():
>>
>>     /* verifier.c check_load_mem */
>>     src_reg_type =3D regs[insn->src_reg].type;
>>     err =3D check_mem_access(env, env->insn_idx, ...);
>>
>>     /* verifier.c check_store_reg */
>>     dst_reg_type =3D regs[insn->dst_reg].type;
>>     err =3D check_mem_access(env, env->insn_idx, ...);
>>
>> Could check_mem_access() snapshot reg->type at entry and test that snaps=
hot
>> instead?
>
> This one also looks like a real bug, we should probably save the type bef=
ore the
> call as suggested and done elsewhere.

It took me a bit of time to fully grasp it, but indeed, that's an actual
issue, possibly over-instrumenting programs. I failed to reproduce it
with any existing selftest, and also failed to make clang output a
faulty program just from C, but playing with a bit of BPF assembly, I
managed to observe it:

  SEC("tcx/ingress")
  int ldx_self_alias_on_stack(struct __sk_buff *skb)
  {
  	struct kasan_test_val val;
  	__u64 addr;
 =20
  	addr =3D (__u64)&val;
  	asm volatile(
  	        "r1 =3D %0\n"
  	        "r1 =3D *(u64 *)(r1 + 0)\n"
  	        :
  	        : "r"(addr)
  	        : "r1", "memory");
 =20
  	return 0;
  }

This r1 =3D *(u64 *)(r1) ends up being wrongly instrumented, despite
accessing only stack. I'll then add this reg->type saving to preserve
and pass the initial state to the check.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

