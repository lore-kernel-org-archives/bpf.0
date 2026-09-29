Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077519A288
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640116; cv=none; b=nCL2ukMwi7ee/khdtuURVXTaw5aWMS0NqwHqhiLCA/Jq7PE3N35oaYjhC0Uwen2ereE867DuqcVbH4EjJ1z7L0our87E1E20c+JyJ91pVt78JHtQuzckHsLDgvXnVU7iVVWoMuzukV073W/w+cX/m0RNeVkvPauBK3qd8BXkfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640116; c=relaxed/simple;
	bh=i7u97BNWa16kChalD0osHt7wHhTPoszN25BT4oWJpgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZnNyNAOngQU3pTtveu3kY9mE2GxdIjfYi4CogVhIb7ALCPMxaH24TRLHI8sKpA+6HrxLAt6DI0JQzM6jNaeEFXzbkqbiljeHZ2o+csTiaHEcNO+s8afqg8UstKVdRnhopqIvBu+2jO6lmZDQ9oyLlz+IFZ9TbiTsEd0RJI/8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTaKOW/c; arc=none smtp.client-ip=91.218.175.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTaKOW/c"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i7u97BNWa16kChalD0osHt7wHhTPoszN25BT4oWJpgc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790640112; v=1; x=1791244912;
 b=jTaKOW/cgtvOeyPSkrlCF9GhbvMhXMnZnTDRnVPi0bnEWJyIod1auN5GwgnsMiCCyOgOt2t2
 B5hdpKrXz5YOOEHqKQgbyA2tUzmBNNksRc44ummAmLgTIXTqxKDFUHzWUEYnzI58fT2M6//Ft/K
 7Q34twsUlsaQ47iNr1Xp3vPM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cb42248dfc32517e;
	Tue, 29 Sep 2026 00:01:51 +0000
X-Mizu-Trace-ID: cb42248dfc32517e
X-Migadu-Flow: FLOW_OUT
Message-ID: <4e178583-b510-457f-94bc-e0e201698371@linux.dev>
Date: Mon, 28 Sep 2026 17:01:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix linked_externs with
 bpf-gcc
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org,
 andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, linux-kernel@vger.kernel.org
References: <20260928231441.4037097-1-vineet.gupta@linux.dev>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260928231441.4037097-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-28 4:14 p.m., Vineet Gupta wrote:
> test_progs-bpf_gcc fails to build:
> 
>    prog_tests/linked_externs.c:17:23: error: 'struct linked_arena' has no
>        member named 'arena'
> 
> Several problems, all from bpf-gcc not supporting address_space(1).
> 
> First, the arena variables are declared with __arena, but that macro is
> for pointers -- it marks the pointee address space. The one that carries
> placement is __arena_global:
> 
>    #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
>    #define __arena        __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
>    #define __arena_global __attribute__((address_space(1)))
>    #else
>    #define __arena        __attribute__((btf_type_tag("arena")))
>    #define __arena_global SEC(".addr_space.1")
>    #endif
> 
> __BPF_FEATURE_ADDR_SPACE_CAST is a clang predefine. Under clang the two
> are interchangeable here, since address_space(1) both places the
> variable and is what btf_type_tag would have described. Under bpf-gcc
> __arena is only a BTF type tag, so the definitions land in .data, the
> arena map gets no initial value, and is_skel_data() in bpftool does not
> emit the typed arena member -- hence the build error. Note this is
> distinct from skel->maps.arena, which comes from SEC(".maps") and is
> always present.
> 
> The extern declarations need __arena_global too. Without a section, gcc
> does not place an extern in any DATASEC, so it stays a free-floating
> extern VAR rather than an entry of .addr_space.1. test_relink() only
> walks that DATASEC:
> 
>      id = btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
>      ...
>          ASSERT_NEQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_EXTERN, "var_resolved");
> 
> so relink_arena would report OK under bpf-gcc whether or not the linker
> resolved anything -- it would not be testing the allocated-section path
> this test exists for.
> 
> Second, placement alone is not enough to run the test. Dereferencing an
> arena global needs an addr_space_cast, which only clang emits:
> 
>    clang:                                  bpf-gcc:
>      r1 = 0x0 ll                             r1 = 0x0 ll
>      r1 = addr_space_cast(r1, 0x0, 0x1)      r2 = *(u64 *)(r1 + 0x0)
>      r1 = *(u64 *)(r1 + 0x0)
> 
> so the verifier sees a scalar and rejects the program:
> 
>    4: (79) r2 = *(u64 *)(r1 +0)
>    R1 invalid mem access 'scalar'
> 
> Guard the program bodies and skip the skeleton subtest, as
> arena_atomics.c already does. The variables stay unconditional so the
> arena is still populated and the skeleton still has its member. The
> fallback bodies reference the externs without dereferencing them:
> 'used' is ignored on an extern, so an unreferenced one is dropped and
> .addr_space.1 loses it again.
> 
> With this, bpf-gcc reports:
> 
>    #217/1   linked_externs/skel_arena:SKIP
>    #217/2   linked_externs/relink_arena:OK
>    #217/3   linked_externs/relink_maps:OK
> 
> with b_val present in .addr_space.1 as linkage=extern, same as clang, so
> relink_arena covers the same path in both. clang still passes all three.
> 
> Fixes: 34354db1b148 ("selftests/bpf: Add linked_externs test for externs in allocated sections")
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This fixes the current GCC BPF selftests build failure on CI:
https://github.com/kernel-patches/vmtest/actions/runs/36498905340/job/109187331070

nit: The commit message is kinda too long. If you'd like it to be read
by a human, try making it shorter :)

Thanks!

> [...]
