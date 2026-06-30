Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A73375C5
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861171; cv=none; b=uLvTsRC74FXLXvxXA4UB/AJJQd3KG0Q2ADjQtfyQtDbbLTKVA8gKnRunOJ/6PNnUax1CeF39arvcagH+EabLCKQRjMhLKmJseyP0E/yE3xeIbJSrBQLdLwIWOkekQEEkLaBeHzVqjBEcDqOi45FsmquD3OfvsmHj3M58JKk08dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861171; c=relaxed/simple;
	bh=Doir8toan0ZC13VFs7SHG/5xZmfMtSJDpCfUZam2sWo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eG3ukeHpE9GcCeT2sajXY4G/YJI4GBWc8TCXnEjNVu2gN5MNLwdmeFQgBP5/J/Kt/Q1aFjMV0gwIAD+nw7NjlL85VFfCsIknEZjq5OaJVW9vI4pz+iUuedrzxr1DlS1TQONDD13HF+lOUCPC9JxMFkijAA2JkHj78XprMh7Un/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyGW+oDn; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyGW+oDn"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso22951eaf.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782861169; x=1783465969; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNs/ZbTedK/pUx9Y12R+Bjea+lbh0cPXPw8B4Fh6zfM=;
        b=DyGW+oDn2PdaEtBGoK7BgtbzcqZj4x5crp7issyc7x3QFE+mpHKaXvW2nKg+QtwryG
         FK0MTG7/g6YgmavR/Kv/d4293rDSY2L6r/NixV97Phfe4jOqhDm8X4uRwZj3SYV9pnJt
         Bz9hVnsUlQOr6jPpQAjFvhhu1WgA+3NIE9VQ7QHVTK7OLOkLClw+z1FyYqlao9ZRkYg0
         B/5PcawFHrFIJKLFKLE+3uARaWkbxFM0N9gnwWYC11q4kNRDdcnnL0e4/fR/Of+QR6id
         avt3StMDr0gHDLWME9H7m3KkhPbIccIJkNc3CTMGixDX8AQDPEjHdYOusgCUJ/dTy5P0
         C77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782861169; x=1783465969;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNs/ZbTedK/pUx9Y12R+Bjea+lbh0cPXPw8B4Fh6zfM=;
        b=a8FmTCspD4nwjFz/+7tqTsJRsfJsCscGKKtk2livdtOuWDLvWfFdnGv7A3UdOyw8qo
         EoiH9tLWziBrRc0P3M8MYuqBg3S285XW0U8k5r3ZNEXk1XsoS9Kvuv8yhJgViba50B8W
         vyVV11Y6uW1p6CpSfIUZW5lcitEquiybFNqx/rgqxoxkrq2IZS7cCzJaLGJeVPys7jbN
         Je7skMnt8dOS2jNYkGoHwq9pzm0rUKJJSOmIQ4grf6e+zHr3ZfoZmgIuFqgwwbKOvdxE
         rlNoJnBSo0vXjZBhMgM79RvEmk+cOArWV8pNQtAd7nW/Ux5e4b+aCM/JF32PESZh5A+0
         sKlg==
X-Forwarded-Encrypted: i=1; AFNElJ/H9JQEKeIug4rglhJzB6GFK9p5Val/LdYqDXG8gVhWlt8bSJm82B5vo3VBB8RqlNaaSJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkpf/oqoSm5+/SSOTZLQlWYAjhqYshoVw28VSw91Y2YOXxZJTE
	y9rcA7/e9VlGCaqEFlIzHy0GYssfHqjuZUVxCPw68Ln7SWPQnLMV2UVQ
X-Gm-Gg: AfdE7cnGBEBkqZYvvdXbSw6qcmJePxYtkVVOn2v/CAd3nvC1Tz4DEZwyUBFFXnawHiz
	2Hq6PTBX8edTRJ7GnHNuN4VoHEx4IP9bBMV9TkoVHS5zyPVORktjnsDdHcNP7tDVPskRlHttjjf
	7AMPspD8+NPEQ2fBq4AJoIxwmjP/zNkoXjrMjV8J1kGO6us021WI9/2D4RhsrBTyM64BDTlwhhp
	2sMq59odOLx+jOu0d4C7VfsweUuQkCw9fq3nBR06nykBn5qmvrOmT2PbTeMiO3FzsbF7Xwoixwm
	RBnj5Myx7aVb/35QZvbtYYNFwxsG7AxjK7IPSFtadPoTu4mh94lM8LhhSBAZox/u4974ZLAPuCn
	pb7VHz4fcSUD69EBV3TpK/LT4G98pwCCXa/J03Ik3zHElUaVxV+b/7yTSECMX3SlqiolMGB7+ed
	jXhBgcppAJ6Td6GII2OttC3RrRe2YQksj5UnPAJO/4MqnjP3BqbF53VLjLql+EuxWFSGPCIlrRH
	Fx7OCM=
X-Received: by 2002:a05:6820:6aea:b0:69e:3c9e:5e82 with SMTP id 006d021491bc7-6a196c2f6fcmr1648095eaf.42.1782861168855;
        Tue, 30 Jun 2026 16:12:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a189493f93sm2787431eaf.14.2026.06.30.16.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 16:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:12:47 -0700
Message-Id: <DJMRJDHUOXMJ.2NOKJLI4RA1ZU@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, <loongarch@lists.linux.dev>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4] bpf: Fix unaligned interpreter panic on JIT
 fallback path
X-Mailer: aerc
References: <20260615025316.24429-1-yangtiezhu@loongson.cn>
 <ed0326b4-2953-16a6-0472-5fa96df1d63e@loongson.cn>
In-Reply-To: <ed0326b4-2953-16a6-0472-5fa96df1d63e@loongson.cn>

On Mon Jun 29, 2026 at 6:13 PM PDT, Tiezhu Yang wrote:
> On 2026/6/15 =E4=B8=8A=E5=8D=8810:53, Tiezhu Yang wrote:
>> When an architecture implements bpf_jit_inlines_helper_call(), such
>> as LoongArch, ARM64, and RISC-V, the BPF verifier skips rewriting
>> the helper call offset (insn->imm) during the bpf_do_misc_fixups()
>> phase if the helper is expected to be inlined by the JIT compiler.
>> As a result, insn->imm remains as the raw helper enum ID.
>>=20
>> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=3D0)
>> or if the JIT compilation later dynamically fails (e.g., due to OOM
>> during bpf_jit_alloc_exec()), the core BPF subsystem falls back to
>> the BPF interpreter.
>>=20
>> When the fallback interpreter executes (__bpf_call_base + insn->imm)
>> with the unpatched raw helper ID, it jumps into an unaligned invalid
>> address space, triggering a fatal instruction alignment fault (ADEF)
>> or illegal memory access kernel panic.
>>=20
>> This issue impacts all architectures that support helper inlining,
>> so introduce a late fixup pass via bpf_fixup_fallback_helpers() in
>> __bpf_prog_select_runtime() to fix this panic.
>>=20
>> When JIT compilation fails or is disabled, the helper call offsets
>> originally skipped for inlining are rewritten to relative memory
>> offsets right before transferring control to the interpreter.
>>=20
>> 1. Test case (test_panic.c):
>>=20
>>    #include <linux/bpf.h>
>>    #include <bpf/bpf_helpers.h>
>>=20
>>    SEC("kprobe/sys_getpid")
>>    int test_panic(void *ctx)
>>    {
>>    	struct task_struct *task;
>>=20
>>    	task =3D (struct task_struct *)bpf_get_current_task();
>>    	if (task)
>>    		bpf_printk("Task address: %p\n", task);
>>=20
>>    	return 0;
>>    }
>>=20
>>    char LICENSE[] SEC("license") =3D "GPL";
>>=20
>> 2. Reproduction steps:
>>=20
>>    $ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
>>    $ sudo sysctl -w net.core.bpf_jit_enable=3D0
>>    $ sudo bpftool prog load test_panic.o /sys/fs/bpf/test_panic autoatta=
ch
>>    $ sudo cat /sys/kernel/debug/tracing/trace_pipe
>>=20
>> 3. Panic information on LoongArch:
>>=20
>>    Kernel ade access[#1]:
>>    ...
>>        ra: 9000000000486e50 ___bpf_prog_run+0x1370/0x36b0
>>       ERA: 9000000000485383 __bpf_prog_ret0_warn+0x13/0x20
>>    ...
>>     ESTAT: 00080000 [ADEF] (IS=3D ECode=3D8 EsubCode=3D0)
>>=20
>> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> Acked-by: Leon Hwang <leon.hwang@linux.dev>
>> Tested-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>> v4:
>>    - Rename the static function to bpf_fixup_fallback_helpers() to
>>      be more accurate and concise, following the file's naming style.
>>    - Remove redundant helper ID bounds check since invalid helper
>>      IDs are already filtered out in bpf_jit_inlines_helper_call().
>>    - Simplify code by merging nested if statements for helper checks.
>>=20
>>   kernel/bpf/core.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>=20
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 649cce41e13f..0db6e55bad52 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2608,6 +2608,25 @@ static struct bpf_prog *bpf_prog_jit_compile(stru=
ct bpf_verifier_env *env, struc
>>   	return prog;
>>   }
>>  =20
>> +/* Fix up helper call offsets on JIT fallback path. */
>> +static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, st=
ruct bpf_prog *fp)
>> +{
>> +	struct bpf_insn *insn =3D fp->insnsi;
>> +	const struct bpf_func_proto *fn;
>> +	int i;
>> +
>> +	if (!env || !env->ops->get_func_proto)
>> +		return;
>> +
>> +	for (i =3D 0; i < fp->len; i++, insn++) {
>> +		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) =
{
>> +			fn =3D env->ops->get_func_proto(insn->imm, env->prog);
>> +			if (fn && fn->func)
>> +				insn->imm =3D fn->func - __bpf_call_base;
>> +		}
>> +	}
>> +}
>> +
>>   struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *en=
v, struct bpf_prog *fp,
>>   					   int *err)
>>   {
>> @@ -2643,6 +2662,9 @@ struct bpf_prog *__bpf_prog_select_runtime(struct =
bpf_verifier_env *env, struct
>>   			*err =3D -ENOTSUPP;
>>   			return fp;
>>   		}
>> +
>> +		if (!fp->jited)
>> +			bpf_fixup_fallback_helpers(env, fp);
>>   	} else {
>>   		*err =3D bpf_prog_offload_compile(fp);
>>   		if (*err)
>>=20
>
> Ping? Any more comments?

See my reply to Leon.
