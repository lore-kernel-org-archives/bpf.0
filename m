Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471747;
	b=GVHjF3jlsNt5Uio18MXgWLK55Ccr8R96egP21rJtHYbqePIBzgAFOOWANe/Xpysuzl/c
	 FkwuS/JCAZBcaDPdzjIyVs9whMQ2coeZAG8QUljHlW2G77lTXfJgNPaIXcWZ6G/enO9Sj
	 qYX3X1EDO541i+QUwB6zAMBSij9jEayBsVMZfKUnEbyZ7hh0KY0fMIMQYhorBgNdSnjXb
	 9BDcOS9VO8KARCJZ8EHSMiesa1HC4JQRV+dutRSFPB+odOiQuGXXHBbzRzLsycDtEzC6h
	 HbtDWg25N+NZKlVNEO/KGCHSHYumyJ4oRB1jAsgGt+qL1+0DSev5TstKGy0mNNCTqLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471747;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=akDVLKNEH5roNSoTOQSgPtNTXnTOrr6QFFjX87kdXME=;
	b=nSShr8hLaRbo5UZ/sF+IF/8YYCop4qbQ4Sw8P5onGZduLBRfadeIsRR77dL15OQkXqD9
	 yyXG3Yo/UrvSvyqm9VFkrAYi0C8K9Xa4VpuStXkAOvFHUrJVkYUnx6iunu0V2IfpAhfzm
	 mih2xG4LEfNWbDG5PNOf86cAL3KKr6MdaMuIAgHm7VCIzrHM0LJF67953NsYV+nXs2R17
	 mCcmIPh5U3pc9wxEgw9VLprefmyLFciKXZRKFo3/Ezdct9CWRUDlwvNhCE1WXjSbKPCUd
	 sghVdIZtP3BhemKP87huqirCMt7NN5wV0sdOyFlctUSVA0H62sxcqEFPB7CZjq9/4Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DqLpADDe;
	arc=none smtp.remote-ip=95.215.58.99
Received: from mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B2606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3B2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DqLpADDe
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aVThDRCCqprqCUkmmvOsqth/G39nsyp+mIVjDwzH4L8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795471743; v=1; x=1796076543;
 b=DqLpADDe7BeDvtXGtvIQT3ltRHqXdMz32i3Ftbi0alpqG/ksxqUuTeMb2+gcAOTSmHtejAbZ
 O9IxHzb9cfEPqZVW8e1Kwu+jOeZESgd5Avt1k/BLGiml0Wnv9aKCpioIEAoFUjP+25Fq8UgQSwV
 onGjSoiEQKS/e3rbMo2riT7I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79eb02bd2ef7840f;
	Mon, 23 Nov 2026 22:09:02 +0000
X-Mizu-Trace-ID: 79eb02bd2ef7840f
X-Migadu-Flow: FLOW_OUT
Message-ID: <a189a17f-8544-43ed-8eff-116191c41a62@linux.dev>
Date: Mon, 23 Nov 2026 14:08:59 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 0/3] libbpf: Fix CO-RE relocations of unsigned
 32-bit enum values
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 vineet.gupta@linux.dev
References: <20261120214957.868409-1-yonghong.song@linux.dev>
 <fc517c55e7060cf7c0da6e797a602488cea403fd.camel@gmail.com>
 <8fdf1b51-7368-46e0-80f9-744b15845ad0@linux.dev>
 <d678f6992169065c5f1e67b89d39ad6a463923c8.camel@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d678f6992169065c5f1e67b89d39ad6a463923c8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/23/26 11:46 AM, Eduard Zingerman wrote:
> On Mon, 2026-11-23 at 10:01 -0800, Yonghong Song wrote:
>> On 11/23/26 9:45 AM, Eduard Zingerman wrote:
>>> On Fri, 2026-11-20 at 13:49 -0800, Yonghong Song wrote:
>>>> For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf sign-extends the value
>>>> of a 32-bit enumerator even if the enum is unsigned. A value in
>>>> [0x80000000, 0xffffffff], e.g., DCACHE_PRIVATE of enum dentry_flags,
>>>> then doesn't match the zero-extended value clang emits, and the whole
>>>> object is refused. And a target value in that range is patched
>>>> sign-extended.
>>>>
>>>> Patch 1 zero-extends the 32-bit values of unsigned enums, i.e., with
>>>> the kflag 0, which is the form clang emits. The kernel builds the same
>>>> relo_core.c, so it gets the fix too.
>>>>
>>>> GCC emits every 32-bit enum value sign-extended, since its
>>>> __builtin_preserve_enum_value() returns int. So with the change above
>>>> alone, GCC objects that load today would be refused. Patch 1 therefore
>>>> also accepts the sign-extended form of an unsigned value, and patches
>>>> the target value in the same form.
>>> Hi Yonghong,
>>>
>>> I checked LLVM and GCC definitions for __builtin_preserve_enum_value().
>>> LLVM:
>>>
>>>     clang/include/clang/Basic/BuiltinsBPF.td:
>>>
>>>     def PreserveEnumValue : TargetBuiltin {
>>>       let Spellings = ["__builtin_preserve_enum_value"];
>>>       let Attributes = [CustomTypeChecking];
>>>       let Prototype = "long int(...)";
>>>     }
>>>
>>>     ---
>>>
>>>     gcc/config/bpf/bpf.cc:
>>>
>>>       def_builtin ("__builtin_preserve_enum_value",
>>>                    BPF_BUILTIN_PRESERVE_ENUM_VALUE,
>>>                    build_function_type_list (integer_type_node, ptr_type_node,
>>>                                              integer_type_node, integer_type_node,
>>>                                              0));
>>>     gcc/tree.cc:
>>>
>>>       integer_type_node = make_signed_type (INT_TYPE_SIZE);
>>>
>>>
>>> Meaning that the two indeed disagree. Given that GCC version can't
>>> express 64-bit values, it appears that GCC side definition needs an
>>> update. Would this allow to avoid GCC-specific workaround in libbpf?
>> Yes, I am aware of this issue. See
>>      https://lore.kernel.org/bpf/a4aec2b1-f754-48ed-a7d7-ef07bed43eb8@linux.dev/
>>
>> I even suggested a solution:
>>
>> diff --git a/gcc/config/bpf/bpf.cc b/gcc/config/bpf/bpf.cc index
>> 3ef93938222..45d5337bab6 100644 --- a/gcc/config/bpf/bpf.cc +++
>> b/gcc/config/bpf/bpf.cc @@ -1048,7 +1048,7 @@ bpf_init_builtins (void)                                           integer_type_node, 0));
>>       def_builtin ("__builtin_preserve_enum_value",
>>                   BPF_BUILTIN_PRESERVE_ENUM_VALUE,
>> - build_function_type_list (integer_type_node, ptr_type_node, +
>> build_function_type_list (ullt, ptr_type_node,                                           integer_type_node, integer_type_node,
>>                                             0));
>>
>> diff --git a/gcc/config/bpf/core-builtins.cc
>> b/gcc/config/bpf/core-builtins.cc index a5c973cd385..289d3e67d78 100644
>> --- a/gcc/config/bpf/core-builtins.cc +++
>> b/gcc/config/bpf/core-builtins.cc @@ -877,8 +877,12 @@
>> pack_enum_value_fail:     else
>>         {
>>           ret.reloc_data.expr = tmp;
>> + /* Extend the enumerator to 64 bits according to its own signedness, +
>> as clang does, instead of expanding it as a sign-extended SImode +
>> CONST_INT. */         if (kind == BPF_RELO_ENUMVAL_VALUE)
>> - ret.reloc_data.default_value = enum_value; +
>> ret.reloc_data.default_value + = fold_convert
>> (long_long_unsigned_type_node, enum_value);         else
>>            ret.reloc_data.default_value = integer_one_node;
>>         }
>>
>> Vineet Gupta will take a look.
>>
>> Discussed with Alexei earlier, the suggestion is to proceed as is for now.
>> It is not clear when gcc will implement this.
>>
> Had a discussion with Andrii on this topic with the following conclusions:
> - pahole 1.24 is 4 years old, it should be acceptable to bump minimal
>    pahole version to get reliable signed/unsigned enum information.
> - such a bump simplifies the fix, effectively moving it to:
>
>    static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
> 				      const struct bpf_core_spec *spec,
> 				      __u64 *val)
>    {
> 	const struct btf_type *t;
>
> 	switch (relo->kind) {
> 	case BPF_CORE_ENUMVAL_EXISTS:
> 		*val = spec ? 1 : 0;
> 		break;
> 	case BPF_CORE_ENUMVAL_VALUE:
> 		if (!spec)
> 			return -EUCLEAN; /* request instruction poisoning */
> 		t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> 		if (btf_is_enum(t))
> 			*val = btf_enum(t)[spec->spec[0].idx].val; // <------- take care of a sign flag here.
> 		else
> 			*val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
> 		break;
> 	default:
> 		return -EOPNOTSUPP;
> 	}
>
> 	return 0;
>    }
>
> - we don't want to workaround GCC bug on the libbpf side, let's assume
>    that __builtin_preserve_enum_value() always return long.
>
> Wdyt?

Sounds good. I will have two patch set then. One is to bump kernel pahole version,
and another is to fix libbpf.


