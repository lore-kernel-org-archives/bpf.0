Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051864;
	b=mWomuwSKlAqWkc9kU+bc8IS1ucn5O5zxeDDUdJZ/lkZmkZvtuxoy9zKpNyKxcAlzT8Oa
	 T+yRijpXPbSM+tH3epi0c+WeMq157w8DbcuMgSsOaxoieiECauDfI+9e+sU2vYyMaJGD4
	 hyEwHFT9wRGwjKUa9IetojoGcpn76xwN9h8l0h1VzXhPPhTsyPB/fslg1MtrHlTf1QKvh
	 Ge3pVpSS/lM1VUO5hU7wX5nBJTQ1DV6zjEHCdbDuqVXN9yAf3rVhYwFNe4FonOg3r4kKL
	 PQ5/dmUm5CLR81MFz9Q32h1LIsVI6hbGnoGPDZYG2Tw5EE8Eve4ScZP68l9J/ofmjNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051864;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZE8zT41OM52EuLgbIV90BOILi9QAjfjy/FaOtaKoxuE=;
	b=IbsJvm+oGT9+eQGcPC56FvULECxaAncp8sRxDiLgg5M1jNruAQXxItn5rYSCnPuc0L/k
	 yo+M74dK0ouWEnyzpe2MsMTt1yzYFyrRYP4DVwJzPFxUlbesgjMj3uqcJvcGv/JakCGM1
	 1Ph9tDbzuJBVBbo+mFYqZT/tPgzRNxnXRudVoaxc3fStQsqmr+2NWfDRgs5GeLQz0nx+W
	 mo1sqZ6gguLip5fcn1Tcr4rvIDgqOcmSsgkxd9sBfIyVQGHdS4YEmJ4cNNrJRjL0yRw1O
	 LN3IDI2k0dKOgMqno4/Zltq8oOyX02nHWdi4t8HEiyNn9CGufo/sF1mZUCVn28aMlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jtYmCKx6;
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E8606A331
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986E8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jtYmCKx6
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NrBdkyoq0DhGpCoZ8hbg4dZ9sA3541AGv5URjWK3edE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795051860; v=1; x=1795656660;
 b=jtYmCKx6+MUCAsYFQLeyTfP3ATFRg9l7UM1V1Vp6WLVaC0ChP0wdoFAGy7dC8Y1LLxoCP/lM
 twlw6IeXlaQzCuPMOuSW2vkQlPmT1u3Bw1dqjeS0el2LgRGQ/weG1L4ZwkXQRlEg8PtXZR4PKTw
 x3eIHjf5qptdySLV/yMLXALo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9f0a132baf2fe905;
	Thu, 19 Nov 2026 01:31:00 +0000
X-Mizu-Trace-ID: 9f0a132baf2fe905
X-Migadu-Flow: FLOW_OUT
Message-ID: <a4aec2b1-f754-48ed-a7d7-ef07bed43eb8@linux.dev>
Date: Wed, 18 Nov 2026 17:30:54 -0800
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
Subject: Re: [PATCH bpf-next 1/2] libbpf: Zero-extend unsigned 32-bit enum
 values in CO-RE relocations
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261118161053.1768878-1-yonghong.song@linux.dev>
 <e5fd05a670861cd47cf6112096c1904ea418ef9335cbeb9badd54ed87c24e1f0@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e5fd05a670861cd47cf6112096c1904ea418ef9335cbeb9badd54ed87c24e1f0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/18/26 8:59 AM, bot+bpf-ci@kernel.org wrote:
>> libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
> TL;DR: Zero-extending unsigned 32-bit enum values in CO-RE relocations may
> make GCC-built objects, which appear to emit sign-extended values
> (unverified), fail to load with -EINVAL, in libbpf and kernel
> bpf_core_apply().
>
>> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
>> --- a/tools/lib/bpf/relo_core.c
>> +++ b/tools/lib/bpf/relo_core.c
> [ ... ]
>
>> @@ -875,10 +882,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>   		if (!spec)
>>   			return -EUCLEAN; /* request instruction poisoning */
>>   		t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
>> -		if (btf_is_enum(t))
>> -			*val = btf_enum(t)[spec->spec[0].idx].val;
>> -		else
>> -			*val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
>> +		*val = bpf_core_enumval(t, spec->spec[0].idx);
>>   		break;
> Can this break objects built by GCC?
>
> bpf_core_patch_insn() compares the local (orig) value against the
> instruction immediate using a full 64-bit compare.  In the ALU path that is
> insn->imm != orig_val, where the int imm is sign-extended, and in the
> LDIMM64 path it is:
>
>      (__u32)insn[0].imm | ((__u64)insn[1].imm << 32)
>
> Clang emits unsigned enumerators zero-extended, which is the case this
> patch fixes.  From reading the GCC source (not verified by compiling), GCC
> appears to emit every 32-bit enumerator sign-extended:
>
> gcc/config/bpf/core-builtins.cc:pack_enum_value() {
>      ret.reloc_data.default_value = enum_value;
> }
>
> bpf_expand_core_builtin() then does expand_normal(data->default_value) and
> wraps it in an UNSPEC.  An SImode CONST_INT is stored sign-extended in RTL,
> so 0x80000000 would be printed as 0xffffffff80000000.  GCC's btfout.cc also
> sets btf_kflag to BTF_KF_ENUM_UNSIGNED, which is 0, for unsigned enums.
>
> For a GCC-built object calling bpf_core_enum_value() on an enumerator of
> 0x80000000 in an unsigned enum:
>
> Before this patch, *val was the sign-extended 0xffffffff80000000, which
> matched the instruction.
>
> After this patch, btf_enum_value() returns 0x80000000 for kflag == 0, so
> bpf_core_patch_insn() would report "unexpected insn #N (ALU/ALU64|LDIMM64)
> value: got ..., exp 2147483648" and return -EINVAL.  The same code is built
> into the kernel through kernel/bpf/relo_core.c, so bpf_core_apply() is
> affected as well.
>
> Would objects built by Clang now load while GCC-built objects that loaded
> before are refused?  The core_reloc/enumval tests are not in
> ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc, and the test added by
> 0aff1079d5e1 ("selftests/bpf: Test CO-RE relocations of unsigned 32-bit
> enum values") uses UINT_ENUM_VAL1 = 0x80000000, so it may show this in the
> test_progs-bpf_gcc lane.

Yes, this is indeed an issue for GCC. Specifically because:
   - BTF type is unsigned. This actually correct for the following:
        enum dentry_flags { DCACHE_PRIVATE = 0x80000000 };
   - Without this patch, both clang and gcc will have enum val with sign extension.
     gcc enum return value has type int so naturally it will do sign extension,
     but clang return value is unsigned, but it use signed type, so this is wrong.

This patch fixed clang to use unsigned type based on BTF and this is correct.

For gcc, BTF type is unsigned (based on language), but the enum return value is signed.
This caused a problem. gcc already generates code assuming signed type and we cannot
change already generated code, so the only thing is to change gcc BTF type from
'unsigned' to 'signed'. This is doable though.


>
> Could the validation for 32-bit enums compare only the low 32 bits and
> accept upper bits that are either zero or a sign extension?  Alternatively,
> the GCC encoding could be determined before changing orig_val.

So yes, we can change orig_val to be signed (instead of original unsigned type)
to fix the issue. Then enum value will be different, for clang, the value is
32bit unsigned. For gcc, the value will be 32bit sign-extension.

The divergence between clang and gcc is in return type, clang (u64, unsigned)
and gcc(int, signed). If gcc can have return value the same as clang, things
can be simplified.

The following gcc diff might be useful for gcc folks:

diff --git a/gcc/config/bpf/bpf.cc b/gcc/config/bpf/bpf.cc
index 3ef93938222..45d5337bab6 100644
--- a/gcc/config/bpf/bpf.cc
+++ b/gcc/config/bpf/bpf.cc
@@ -1048,7 +1048,7 @@ bpf_init_builtins (void)
                                          integer_type_node, 0));
    def_builtin ("__builtin_preserve_enum_value",
                BPF_BUILTIN_PRESERVE_ENUM_VALUE,
-              build_function_type_list (integer_type_node, ptr_type_node,
+              build_function_type_list (ullt, ptr_type_node,
                                          integer_type_node, integer_type_node,
                                          0));

diff --git a/gcc/config/bpf/core-builtins.cc b/gcc/config/bpf/core-builtins.cc
index a5c973cd385..289d3e67d78 100644
--- a/gcc/config/bpf/core-builtins.cc
+++ b/gcc/config/bpf/core-builtins.cc
@@ -877,8 +877,12 @@ pack_enum_value_fail:
    else
      {
        ret.reloc_data.expr = tmp;
+      /* Extend the enumerator to 64 bits according to its own signedness,
+        as clang does, instead of expanding it as a sign-extended SImode
+        CONST_INT.  */
        if (kind == BPF_RELO_ENUMVAL_VALUE)
-       ret.reloc_data.default_value = enum_value;
+       ret.reloc_data.default_value
+         = fold_convert (long_long_unsigned_type_node, enum_value);
        else
         ret.reloc_data.default_value = integer_one_node;
      }


>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44347609693

