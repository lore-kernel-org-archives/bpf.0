Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE634404F
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780584; cv=none; b=Y6s0J7YFILcy66XRE3w3K2UVaDq0OWNeHaaWK4tW8yhUlGO0dwlFoKFzz3l7MnYfMv569XbvF0FOUp3D0FvaeAvwA7vHsFf/u35zXHliplOZlqRResTUppWfOXXKMsAeLtokBWKqGPx4mkNKd0TA4ET42q6EEbq8CfrzdjyBtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780584; c=relaxed/simple;
	bh=eTi4JROsHDj0/pfq10QKnfiv1HKb2l/10UvJcOFjImM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRxwYQwOV2DP5yk3esQhdEe0o0Y7Z+l8CWKYezgPtUMqyrbFDIsiItmrtiE3JJx+S8rGYfgZXB+Wmr1CgdWIA8ctJcuahpCa5U1lzuKRNEccW2ikgMoWWm6fymiQH446f9JoEL9vYrC2pwexySI6yBLGkZv29+rU1NTbsUNKq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyrjSTqG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyrjSTqG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aaecf9c325so3035275ad.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780582; x=1771385382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90vK4hRsQbOEWhjyWZWh7PNBRWM1stlexJ0eSfCPejs=;
        b=WyrjSTqGxTqTa1PITpf1lHqWyyXku+pwur0waEOC3F61l0bcFMokwdioJqCNTfrMhn
         15rRYoRXgh3kHEGGTBvKgB1z3Y2eGvuf1EzKvR4f4ZbPkDee+cBzhMiij/uf1yDuGFD4
         Az3PShYKsagFnvRIzhS1+1mI2Ba5PYUczHdfZmsL6VUibW6XeEBwwH7pFKmd3IfdibSN
         28aUhd1kh/13qgsWn6Q6dQ4VWAGlwiFhpbipFm/HonBFu2wpoZY5qHQWeXsk414GyA9H
         42bUvk1YX8Rr7ezuVsWwLkZo82ZHpV3CDpHyMa8eWyBvbHwXDDNWsUpYd9s+ofXUACgj
         YWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780582; x=1771385382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90vK4hRsQbOEWhjyWZWh7PNBRWM1stlexJ0eSfCPejs=;
        b=PM56u7AcXK+202OfnsnnzTN7+jpItXpWchSchGIta0jWipy192BQ6Kcr7Gjln5wTE4
         DutP2IEgj1MBkt3ps8KpyqpdfoZospyaKtsj7/NhrwP4hU4igdRWN8VOLXiXd5pd/xST
         NBdzqNbscRVKpUI2bdhUKsjAVLJoaYAMrQpqe8SszTLgRBVlqiZy1xwrL+HFds6T7dDd
         UQk84+lGLC3fsmhodD19cWtBF1BBDG9pvXbTsud73OxxfXfVbZDdF4I9ePs+QkpmEPGc
         cbjOQdy4ygs3986sjRyYzZC9sX0as20ckaCrBXoVYe+NCrRM0muPNrIyd6Nohk4yRf7M
         wJmw==
X-Gm-Message-State: AOJu0YzjgNJUgBhn2pEngnrgEq52GJDjuOfjTpCakzHAOUvCl6NR5Blg
	IrM7crBlrQiTqA/GlPLQFqjwPGunKnZ2lRV0FzlX2Fk2tByVyV30tlIu
X-Gm-Gg: AZuq6aI4MW3+m55Xybz5N443rxXXV0z93Iv+yHm3G0TyHTYd4H8opHShE2UcrlWjHyc
	VuHZ5KRrKoHL35fk8zoTkSrQ+ZUQ2Lon7Z+n4UKaWsX5ZRr40q87oZCJmNRT9c4W5Yi6RR4lZEm
	QEGWDsZpjdjzf6ktzEuAO780VuLUoIgswFhodaR/ziHcVDjzeUO4m6M7kbbrV0utDpRYil/TKem
	FkPOrM9hOuefN/h28ZdLTMWCldn7eBSf8VFm60wN1ZeaMf9NXnzgwKxYV6ik5ene8SHqX/Flywb
	A9epd/wk9zzlnuKj7u9NyLjxl0TQyaqf7//GFFlrv8YAs0hJTqyISKcEj0sLaOMVZEsCqtsmpSy
	zjKeV6NLSxYqJkEUSWyvfs6LmLFTbfDFNlf5hERK8H94/dabrhsBXuxhcmjftiJtksh1SPvOhtF
	61CwRyoVaqI7K2AA5/5C6qotwsIJ2Z2VpdNQ==
X-Received: by 2002:a17:902:d58d:b0:2a3:e7d3:810b with SMTP id d9443c01a7336-2ab0fc9ff95mr52923055ad.12.1770780582358;
        Tue, 10 Feb 2026 19:29:42 -0800 (PST)
Received: from [10.22.64.186] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2997b3cdsm5968295ad.70.2026.02.10.19.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 19:29:41 -0800 (PST)
Message-ID: <2a241e1b-fa8a-430c-80a1-6c8d12d7b92c@gmail.com>
Date: Wed, 11 Feb 2026 11:29:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Introduce 64bit bitops kfuncs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20260209155919.19015-1-leon.hwang@linux.dev>
 <20260209155919.19015-2-leon.hwang@linux.dev>
 <CAADnVQKvoLtURPXWg=CyycE=TcuZggcpMhP=Lcc0wGsj2_tZuw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQKvoLtURPXWg=CyycE=TcuZggcpMhP=Lcc0wGsj2_tZuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/2/26 11:05, Alexei Starovoitov wrote:
> On Mon, Feb 9, 2026 at 7:59 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 48108471c5b1..8ac1dc59ca85 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -79,6 +79,7 @@
>>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
>>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
>> +#define KF_MUST_INLINE  (1 << 17) /* kfunc must be inlined by JIT backend */
> 
> UX is not great.
> Just keep kfuncs in C as fallback when JIT cannot inline them
> and don't remove spill/fills that llvm leaves for fastcall.
> 

Ack.

I’ll drop KF_MUST_INLINE in the next revision and keep the C kfunc
implementation as the fallback when the JIT cannot inline it.

>>
>>  /*
>>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 4e1cb4f91f49..ff6c0cf68dd3 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -514,6 +514,25 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
>>                 .off   = 0,                                     \
>>                 .imm   = 0 })
>>
>> +/* bitops */
>> +#define BPF_BITOPS     0xe0    /* opcode for alu64 */
>> +#define BPF_CLZ64      0x00    /* imm for clz64 */
>> +#define BPF_CTZ64      0x01    /* imm for ctz64 */
>> +#define BPF_FFS64      0x02    /* imm for ffs64 */
>> +#define BPF_FLS64      0x03    /* imm for fls64 */
>> +#define BPF_BITREV64   0x04    /* imm for bitrev64 */
>> +#define BPF_POPCNT64   0x05    /* imm for popcnt64 */
>> +#define BPF_ROL64      0x06    /* imm for rol64 */
>> +#define BPF_ROR64      0x07    /* imm for ror64 */
>> +
>> +#define BPF_BITOPS_INSN(IMM)                                   \
>> +       ((struct bpf_insn) {                                    \
>> +               .code  = BPF_ALU64 | BPF_BITOPS,                \
>> +               .dst_reg = 0,                                   \
>> +               .src_reg = 0,                                   \
>> +               .off   = 0,                                     \
>> +               .imm   = IMM })
>> +
> 
> why introduce pseudo instructions and this encoding?
> Just let JIT identify kfunc calls by address.
> bpf_jit_get_func_addr()
> if (addr == bpf_clz64) ...
> 

Thanks for pointing me to bpf_jit_get_func_addr().

I’ll drop the BPF_BITOPS encoding and BPF_BITOPS_INSN, and instead
let the JIT identify the bitops kfuncs by their resolved function
address via bpf_jit_get_func_addr().

That should keep things simpler and avoid introducing a new internal
opcode.

>>  /* Internal classic blocks for direct assignment */
>>
>>  #define __BPF_STMT(CODE, K)                                    \

[...]

>> @@ -4578,6 +4620,14 @@ BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
>>  BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
>>  #endif
>>  #endif
>> +BTF_ID_FLAGS(func, bpf_clz64, KF_FASTCALL | KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_ctz64, KF_FASTCALL | KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_ffs64, KF_FASTCALL | KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_fls64, KF_FASTCALL | KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_popcnt64, KF_FASTCALL | KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_bitrev64, KF_FASTCALL | KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_rol64, KF_MUST_INLINE)
>> +BTF_ID_FLAGS(func, bpf_ror64, KF_MUST_INLINE)
> 
> Mark all of them as fastcall and do push/pop in JIT when necessary.
> 

Good idea.

I’ll mark all bitops kfuncs as KF_FASTCALL and handle any required
save/restore in the JIT.

In particular, for bpf_rol64() and bpf_ror64() on x86_64, we do need
to use rcx (CL) for variable rotates, so pushing/popping rcx in the
JIT when needed makes sense.

Thanks,
Leon

