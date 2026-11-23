Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456915;
	b=X2F8kVKiuXDQTqcub0S4E2m2KBG6ZLCRQblu1QLfhGs0f7kyP9mKnKPv6TnDsQQC0HL9
	 GAAiq867GFVTZVz/O5mcw7CLVu2UKXiccSHIdEuhnbioOpxP3il97+4sFmlMrPDunV81o
	 gF//7BT2H8c6pgdbtARcWt8GsXsBpNuhK+3lBKgiohZYj1Tf+lPaL1+krJRIu9ikQKzZf
	 hbsHXl0owQFMPTBxTGOjrTnH0sgzhtKw5aLcO9/LNcEJ2QP6xuaGXvwBVi70Wq25LZvww
	 QyuQCxz8Nidp94hNueFRAAT4Wgi7A/SvmfMsCZc+j/H8urqBj83ecb7b+soNSFHq5BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456915;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5hQK4v3JYVOzwBJHibs8IOh7EBwwjeK05Mi0rZB1ZbA=;
	b=rORYjuk5P2aVfd3mdFt99210x5XstyUbb8lJrudloX02LhXPcBmsrPQX97LYSzA+mRwB
	 t7bpzq59Rnky1iOaE7YcCyvkudCCT6sTfaOYq2a0zzI7XHPhTwXZPfwxATgqR5GeX0loc
	 WYEng+QGCIAGpce7Kr6/bjcVyUXg14ByT3HgIBH6N25jmBdAZ2TV5U0esQ25QzGxbs9Bk
	 KUMbowOlOj5uA62R/OYx/R7UFnb4BvAk4/wivkTdMah0CxrKzL7qlY8ywaQv1QC3r03tA
	 JtBqVph7lfivopmYIvjGTIBjc2M3JIXrDBZRsD18moMpVAJfjyUV+9Nzw22ocL56qLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bUeRIrdW;
	arc=none smtp.remote-ip=95.215.58.167
Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67F606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 18:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C67F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bUeRIrdW
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E82zzBnbkdOFkjoRB3wOLwDJ4egTqOgrSyNGszypfoU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795456912; v=1; x=1796061712;
 b=bUeRIrdWh6q+uRn87KUlACYQwhqAS2X8z3dffNistLAgV6kDAWxVuANJ/M+q8xfbquP0Suvg
 JjK0veOy+QyV1il+ojP44REz6sn8Woiqv5HttDH0nmRrc2wrmPxeWrtWDyzalY/BZDY2td8lDJF
 ExNQJP5vjar0q4WP0L6oJIWo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0da42e1bf3817b16;
	Mon, 23 Nov 2026 18:01:52 +0000
X-Mizu-Trace-ID: 0da42e1bf3817b16
X-Migadu-Flow: FLOW_OUT
Message-ID: <8fdf1b51-7368-46e0-80f9-744b15845ad0@linux.dev>
Date: Mon, 23 Nov 2026 10:01:47 -0800
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
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fc517c55e7060cf7c0da6e797a602488cea403fd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/23/26 9:45 AM, Eduard Zingerman wrote:
> On Fri, 2026-11-20 at 13:49 -0800, Yonghong Song wrote:
>> For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf sign-extends the value
>> of a 32-bit enumerator even if the enum is unsigned. A value in
>> [0x80000000, 0xffffffff], e.g., DCACHE_PRIVATE of enum dentry_flags,
>> then doesn't match the zero-extended value clang emits, and the whole
>> object is refused. And a target value in that range is patched
>> sign-extended.
>>
>> Patch 1 zero-extends the 32-bit values of unsigned enums, i.e., with
>> the kflag 0, which is the form clang emits. The kernel builds the same
>> relo_core.c, so it gets the fix too.
>>
>> GCC emits every 32-bit enum value sign-extended, since its
>> __builtin_preserve_enum_value() returns int. So with the change above
>> alone, GCC objects that load today would be refused. Patch 1 therefore
>> also accepts the sign-extended form of an unsigned value, and patches
>> the target value in the same form.
> Hi Yonghong,
>
> I checked LLVM and GCC definitions for __builtin_preserve_enum_value().
> LLVM:
>
>    clang/include/clang/Basic/BuiltinsBPF.td:
>
>    def PreserveEnumValue : TargetBuiltin {
>      let Spellings = ["__builtin_preserve_enum_value"];
>      let Attributes = [CustomTypeChecking];
>      let Prototype = "long int(...)";
>    }
>
>    ---
>
>    gcc/config/bpf/bpf.cc:
>
>      def_builtin ("__builtin_preserve_enum_value",
>                   BPF_BUILTIN_PRESERVE_ENUM_VALUE,
>                   build_function_type_list (integer_type_node, ptr_type_node,
>                                             integer_type_node, integer_type_node,
>                                             0));
>    gcc/tree.cc:
>
>      integer_type_node = make_signed_type (INT_TYPE_SIZE);
>
>
> Meaning that the two indeed disagree. Given that GCC version can't
> express 64-bit values, it appears that GCC side definition needs an
> update. Would this allow to avoid GCC-specific workaround in libbpf?

Yes, I am aware of this issue. See
    https://lore.kernel.org/bpf/a4aec2b1-f754-48ed-a7d7-ef07bed43eb8@linux.dev/

I even suggested a solution:

diff --git a/gcc/config/bpf/bpf.cc b/gcc/config/bpf/bpf.cc index 
3ef93938222..45d5337bab6 100644 --- a/gcc/config/bpf/bpf.cc +++ 
b/gcc/config/bpf/bpf.cc @@ -1048,7 +1048,7 @@ bpf_init_builtins (void)                                           integer_type_node, 0));
     def_builtin ("__builtin_preserve_enum_value",
                 BPF_BUILTIN_PRESERVE_ENUM_VALUE,
- build_function_type_list (integer_type_node, ptr_type_node, + 
build_function_type_list (ullt, ptr_type_node,                                           integer_type_node, integer_type_node,
                                           0));

diff --git a/gcc/config/bpf/core-builtins.cc 
b/gcc/config/bpf/core-builtins.cc index a5c973cd385..289d3e67d78 100644 
--- a/gcc/config/bpf/core-builtins.cc +++ 
b/gcc/config/bpf/core-builtins.cc @@ -877,8 +877,12 @@ 
pack_enum_value_fail:     else
       {
         ret.reloc_data.expr = tmp;
+ /* Extend the enumerator to 64 bits according to its own signedness, + 
as clang does, instead of expanding it as a sign-extended SImode + 
CONST_INT. */         if (kind == BPF_RELO_ENUMVAL_VALUE)
- ret.reloc_data.default_value = enum_value; + 
ret.reloc_data.default_value + = fold_convert 
(long_long_unsigned_type_node, enum_value);         else
          ret.reloc_data.default_value = integer_one_node;
       }

Vineet Gupta will take a look.

Discussed with Alexei earlier, the suggestion is to proceed as is for now.
It is not clear when gcc will implement this.


