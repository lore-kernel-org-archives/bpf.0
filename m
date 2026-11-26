Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711294;
	b=NhNR4OTgeDn5s77EIr+tGRtuCpnI5jgMaufXPu1CAR4sfWcAH8o2wGU0IRBIHUAsLLdA
	 AL41hiH4UTnlrmicRTEuZiBQYtfxvt/+dzY5zYcZ/8Xtm8logwLmJIEyJ2MiVywEKg9wX
	 KjRtNNPXGGZoyXBZfqHQfYLoPZUWvlwJNgfaUXzTAUB1YXhBOfLPGJZCE13RjtASh0S3j
	 HeqRDP0wSri5asy9qv/SlppJ7OPRPS8RX76ipXCBNQhnN4bemfpKdlZQt3r4jT1kJ/z8D
	 Gi/Vtf/MLFZeEMGupqbw6pCde+xLFoARSoYSpMKDB5KiqW6zl79/ZUF6qzEVSFzbZaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711294;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5cocrlgU4+eKCfP5xzQkf2cbcPa/EQBSFXcnsJzpir4=;
	b=MOBOhgrYTPO6MwNLtigKaUKB7iCQtro59OwFYqOlZF03K08dsB1+4Z+Fd7F01l28e/ZU
	 9GJeFhUmreKPIhY3hTVftNBxkx50zMd+B1c0bUN0G2648NM6Fzn99ODYu6uXSwgUadQdB
	 FDHTEiQnqg+fxL5FDgBEuBccoc5iFkRYV8/cVlX1GbkifnKeqa2dVrqjwBt831CSRBMd5
	 ddQIQuvwGdjKWwrjTYwn78aS5kUiqa4IPGEr153M31sZV3cIJP4cVmXW4nzSqPalPUv4H
	 kj5eOKJyIXmlIB/+Hxb8SEMkSq/tbvka1d79scVia9ZAsb861jN8S2VqF24mytNhYGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c04eOExq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B48606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c04eOExq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD99C1F000C6;
	Thu, 26 Nov 2026 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711293;
	bh=5cocrlgU4+eKCfP5xzQkf2cbcPa/EQBSFXcnsJzpir4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c04eOExqUwOGPwgjKIrMKM85mE9LfCEJ8EYmQ5iLQvt8lkP8z+CS6swv2KO5tgB3z
	 KySjRtw5c6LyyjfNpSU+PTpghlDR4+ZLeYTcDNgehLstm3w3g32eCxdxZRDfIVWc1M
	 SZOUn1/L2ewKeN03qwUGT1mAgxYCLX8+ccw/Q8AihwjUsfScx7LhDf/wUtquhe/TCq
	 ig2UYZJrfvhVqcALN89cYGGhzOvAY3uJuhtqFSfcde+GLQZ1KawqYMjYnjL7iWdRwI
	 nAQSiZgGZYfNx4UyGWRsl18VkVPZ5X3iAaky2nST1e7AZD2cI8R5dc7XrPv2aS0C4Z
	 o7+MfbX7tSBzg==
Message-ID: <21d38d84-0520-4fd2-ad98-04253d0405f2@kernel.org>
Date: Thu, 26 Nov 2026 16:41:27 +0000
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
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf, bpf: Utilize CO-RE for BPF
 program parameter presence, ordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 andrey.grodzovsky@crowdstrike.com, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, mason@kernel.org, bpf@vger.kernel.org
References: <20261125165845.45806-1-almagui@kernel.org>
 <CAEf4BzbkrVyCSW1aRCo_s=2pxK7NRfUnznk21CY4-txqveRcnQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <CAEf4BzbkrVyCSW1aRCo_s=2pxK7NRfUnznk21CY4-txqveRcnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/26 10:49 PM, Andrii Nakryiko wrote:
> On Wed, Nov 25, 2026 at 8:58 AM Alan Maguire <almagui@kernel.org> wrote:
>>
>> Currently the BPF_PROG() family of macros greatly facilitates
>> BPF tracing/LSM program writing by allowing specification
>> of function, tracepoint or LSM hook arguments directly by
>> name and type.  These are then mapped to a context struct
>> consisting of a u64 array, with one value for each argument,
>> with by-value structs larger than 8 bytes taking more than
>> one slot.
>>
>> When an attach target gains, loses or reorders parameters
>> across kernels, programs silently read the wrong argument
>> or fail verification, and they have no way to check if an
>> argument actually exists.
>>
>> To bring a Compile Once - Run Everywhere (CO-RE) experience
>> to parameters for programs, this series lets programs describe
>> the parameters they need and any variants via a
>> struct bpf_func_args___<flavor> which can contain
>>
>> - parameters in any order, to support cases where a user might
>>   only use a subset of parameters in the associated program
>> - parameters that may exist for some kernels, where use is
>>   guarded by bpf_core_field_exists(ctx->field)
>> - renamed parameters, allowing the old and new names both to
>>   be present
>> - parameters whose type varies across kernels: a pointer can be read
>>   through the same struct either way, and bpf_core_type_matches() on
>>   a flavor with just that parameter tells which type it is
>> - __ret for the return value, for fexit, fmod_ret, fsession and
>>   LSM programs
>>
>> For example, a program tracing a function foo() can declare just the
>> parameters it needs, a, b and c, in any order, irrespective of their
>> position in foo()'s signature. It can also declare a parameter "notsure"
>> that only some kernels have, and check whether it exists, and both names
>> of a parameter renamed from "old" to "new". Parameter "d" is a struct
>> file * on some kernels and a void * on others: as any two pointers are
>> compatible, it can be read through the same struct either way, and a
>> flavor with just that parameter tells which it is. __ret is the return
>> value.
>>
>>         struct bpf_func_args___foo {
>>                 __u64 c;
>>                 int b;
>>                 char a;
>>                 long notsure;
>>                 int old;
>>                 int new;
>>                 void *d;
>>                 int __ret;
>>         } __attribute__((preserve_access_index));
>>
>>         struct bpf_func_args___foo_d_file {
>>                 struct file *d;
>>         } __attribute__((preserve_access_index));
>>
> 
> to make this work reliably and not get screwed over by compiler
> generating context access like this:
> 
> r2 = <offset> ; CO-RE relocated
> r1 += r2      ; verifier doesn't like this
> r3 = *(u64 *)(r1 + 0); /* ctx access */
> 
> we need to make sure that we can use
> __attribute__((preserve_static_offset)) together with
> __attribute__((preserve_access_index))
> 
> This was pointed out in [0] (which, coincidentally perhaps, also
> mentioned explicit bpf_func_args___xxx struct idea), we might not need
> to block on that support given user defines this struct and bears
> responsibility for this to work, but still, should be addressed
> soon-ish in Clang/GCC.
> 
>

Thanks for the pointer to the thread, I didn't see that message though
Alexei mentioned it (and the name). Ihor, I'll add a Suggested-by 
for you in the next round if that works?

I guess the challenge will be detecting cases where both
preserve_static_offset and preserve_access_index _do_ work together
(once they do)? If we had a __BPF_FEATURE as Alexei suggested I guess
we could do something like this:


#if defined(__BPF_FEATURE_PSO_CORE)
#define __bpf_func_args_attrs __attribute__((preserve_access_index, preserve_static_offset))
#else
#define __bpf_func_args_attrs __attribute__((preserve_access_index))
#endif

?

I couldn't find an LLVM issue for this problem specifically, but
looks like [1] describes things from the gcc side.

> And I'm actually wondering if the better name for this would be
> "bpf_ctx___<flavor>" or "bpf_ctx_args___<flavor>", because it's not
> always *function* arguments (tracepoint, BPF program, etc). Keeping it
> more generic as "context arguments" or just "context" seems more
> future-proof.
> 
> 
> Also (I only skimmed patches, haven't gone through them completely,
> will get back to this next week after holidays, sorry), I saw you
> mentioned the limitation that this context access can be only done
> from entry program code, right?  I think this can be lifted if we
> apply these relocations after subprogs are appended to their
> respective main programs. Not sure how ugly that will be, but you can
> try that and see how it works (please do it as a separate patch to
> distract less from the main logic change).
> 

Thanks for the suggestion, I'll see if I can get this working.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117068

