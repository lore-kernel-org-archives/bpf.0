Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89C355F4E
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893671; cv=none; b=DrsZvqx2y6AaGNkjOhQeKIAJ0Z8DQ9LOhs8q0kj4fVO2UPc0hMlIZ9HmptPfyWW0qP661pTmY3qAlotK3U1p+aoRz3//++ag3+98+cu0BsNsIfNssJMp4oB9Zz7iYHeF0u2onJVpw1NTIlCI3ocSHSVWNBaaO6cNfF6uzMlL2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893671; c=relaxed/simple;
	bh=O5hfDWEYjLH0CSeM+ac1d1NiXle1droq+5IIRa0TGe8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fbg3/BuVsqIPcqyXKyPbrFPIoUZVj1hryTjmTThL4K5+usig2mXgIh2NQXEuJbXwKb6TZOgjwLzVCXDuHcWW4TsXBKkqQh4cc7UQ4oPtosyNp6djvCWE1PAY7GbQN8gFvnTE+thbblIdH3TBrlt2fjhPqEdSvfwOZXc75OOlJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zge3YBgv; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zge3YBgv"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499b5f5151fso948995e9.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787893668; x=1788498468; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c2K4cW1/zMK1wRWyQe+b7G68OUTbZrMyjy4im2Ss80E=;
        b=Zge3YBgvmOW1d1KHhrrAErD0mY0xR+fDPDibGvhSkYaCkI1cI1hEHkuNx7tLvJx1zP
         lMvQm0h6AFwwlXx1hg/L3EsB9YmCzINZYswmSSHH0hU8z7OWpcYkK2NeB+fkNobVfrtS
         aMxK35mXjK/qLt1RGJrGjZEpbYMpHXhURb7+yen3HvgVvIOxPuGWqpWZUNkSaVBgY61S
         SPhiJHvtleKBOiue8hvI1lci6RB0OnlLGfRIJj06wZ5RXhJiKI5N6/21evWeetlZBH6H
         P4boS2lUmkAjqRqZRDT+Z3v4Emv0Plgob9tFBBTgz3r5ERvrD7jcB5FJDMWeLavL43LG
         AWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787893668; x=1788498468;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2K4cW1/zMK1wRWyQe+b7G68OUTbZrMyjy4im2Ss80E=;
        b=YySFctY7y5dNsemAjSeXeYxSauljjTUTSp+b66XfIQTxqyUyNNSZNDgjmeXiW5qw7G
         wt/9YBV0Ob4ysvmNZ3alE0usd+3m1bZ+88y9BTZ1KuqXwPr2kT0rMvgjt4JMMX65i72Q
         /EieyMhl5f8vTLdhRVLXdEm1D4gkz46E9H6l1FaxRGwlv0sL6o0jbqu0RXsnnun47G5o
         hPl79ffgvCJcnkh8+EPqobG86gG92MyGmSIjLZzVGUswqwEA/oSNR0PqD3XpfR4AxeC8
         gMZ9L7E8JVNqAQ9sSZ9UodPEeh8E2xdku0UQgUP+HLiIII9qoinirv+0m+cKQ+ydhrEu
         FIXw==
X-Forwarded-Encrypted: i=1; AHgh+Rrh5PXfRtVXDMO40+auPxOCAWNwakQDsMXx6usgNyh32RqoWm7vYwNKiVsmjgI1x7d4Gfw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2GsC8fiFOUlXQHQnlQRHjl7uTxuCnxEvzzUkY6owvHHx4X+Dy
	FOdHxF3sS+kZCC++fxH++kPbVb2bT07+slSq2x/aq4CGX0/eq+k1swZn
X-Gm-Gg: AR+sD13z2tIzcXfHkp8IoViNrxmQeql9Rr9Aqb5AY9EUNXs7Y2uKfgFDxcftBckkg8c
	ZHljLRltge60hrnEG84HJaSW8nz8QVdEV2uD3HdDR5oCiUr2QZKaA1eCkJGS6k08Gui0mHuc64Y
	MdzAqU7ckQy1e4KiVaXbpVrNzjnRAwIadLtPPjVj1+5gM0hEz5pQfTFKtH73Y+uBLCMIIv5iAeq
	wW3AlfIRIHrv+R02WhhyHLYW2h1/Q0CSQjwgHjAR1Gwqezx3ehi3v+7zwqDLdMutSKtBxxfkRXH
	ZmNRQn3EdUJ97ozzfm8bFqT8NIfv5KrFhxjvlzuNC+rw8S5f/jLdTjj7xQQgeJirYdWN7s2QswU
	bQByH0tVxLX4dglLSADBW7tVe3Wk4ZQgff+3NGf3WHyln9mgYZbS1Ap88Z6J4me4Q1bIQzgGwzH
	If+UGVIYgNDks7u88Y20t6DT6LMgGHNbXPOPabKm9wyYJCTXInhtnabPaEGU/84OkWK/P1GrF6K
	zZVAtf/843COYRfEMxBtkI4jWLkfw9HbaI3LWthMjAm3/mpi9dXGQ3zjRjMZX+mRZpRwa7uS289
	LKM5q2LuPpQhs+o5bcW0q0/4W7g=
X-Received: by 2002:a05:600c:4e4c:b0:499:8174:9f39 with SMTP id 5b1f17b1804b1-49b91bd95b4mr57359595e9.0.1787893667679;
        Thu, 27 Aug 2026 22:07:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95018ee8sm20549335e9.15.2026.08.27.22.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 22:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 07:07:46 +0200
Message-Id: <DL0BERKE6VTQ.2QHCO1DI0MX90@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument
 flags with suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-12-memxor@gmail.com>
 <49226345-d2e4-4618-8c9d-9dd1d9b0ff4b@linux.dev>
In-Reply-To: <49226345-d2e4-4618-8c9d-9dd1d9b0ff4b@linux.dev>

On Wed Aug 26, 2026 at 10:42 PM CEST, Ihor Solodrai wrote:
> On 2026-08-21 4:35 p.m., Kumar Kartikeya Dwivedi wrote:
>> The arena allocation kfuncs still identify pointer arguments with
>> KF_ARENA_ARG2. These flags cover only the first two parameters and
>> duplicate the __arena suffix mechanism used by other kfuncs.
>
> This is a little petty, but the paragraph mischaracterizes what
> happened :) It's not like the flags duplicate an existing mechanism
> for an unknown/dumb reason. There was no __arena and it was the only
> mechanism until very recently.
>
> Rephrase please?
>

Sure, will reword.

>>
>> Annotate the optional allocation address with __arena__nullable. Mark th=
e
>> free and reserve addresses with __arena so a valid address whose low 32
>> bits are zero is rebased unconditionally instead of becoming NULL.
>>
>> The JIT now passes kernel arena addresses to these kfuncs. Translate the=
m
>> back to the lower-32-bit user addresses expected by the existing arena
>> helpers by subtracting kern_vm_start. This preserves allocation-anywhere=
,
>> freeing the first page of a 4 GiB arena, and reservation at address zero=
.
>>
>> Drop KF_ARENA_ARG1 and KF_ARENA_ARG2 from the kernel interface and remov=
e
>> the flags from the arena kfunc sets. KF_ARENA_RET remains responsible fo=
r
>> annotating the allocation return value.
>>
>> Keep the affected selftests synchronized with the conversion. Associate
>> an arena before the iterator map-pointer failures so they still reach th=
e
>> intended diagnostics, account for the extra nullable branch in JIT label=
s,
>> and treat 1ULL << 32 as the same allocation-anywhere request as NULL aft=
er
>> the required 32-bit truncation.
>
> It's been brought to my attention a few times [1], that we (the linux
> contributors) would strongly prefer the commit messages to explain
> *why* the change is being made, instead of *what*.
>
> And the llms tend to do the exact opposite.
>
> This applies to other patches in the series as well, particularly the
> cover letter.
>
> [1]
> https://lore.kernel.org/bpf/20260730212613.GJamvBdRJ5H98hTWS8@fat_crate.l=
ocal/
>

I'll rewrite the commit log. I mostly just sent this out more as an RFC (ex=
cept
we pw kicks RFCs out of CI queue), so it's rough in several places.

>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>   include/linux/btf.h                           |  2 -
>>   kernel/bpf/arena.c                            | 40 ++++++++++++++-----
>>   .../selftests/bpf/progs/arena_kfunc_jit.c     | 16 ++++----
>>   .../selftests/bpf/progs/verifier_arena.c      |  6 +++
>>   .../bpf/progs/verifier_arena_large.c          |  4 +-
>>   5 files changed, 46 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 89d5a5c4f117..65e5f11dc27e 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -76,8 +76,6 @@
>>   #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu=
 cs when they are invoked */
>>   #define KF_FASTCALL     (1 << 12) /* kfunc supports bpf_fastcall proto=
col */
>>   #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>> -#define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as it=
s first argument */
>> -#define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as it=
s second argument */
>>   #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments sup=
plied by the verifier */
>>   #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin=
_lock-ed region */
>>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 7b6847200b43..6c34a0d34b3f 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -1044,18 +1044,28 @@ static void arena_free_irq(struct irq_work *iw)
>>   	schedule_work(&arena->free_work);
>>   }
>>
>> +static long arena_kaddr_to_uaddr(struct bpf_arena *arena, const void *a=
ddr)
>> +{
>> +	if (!addr)
>> +		return 0;
>> +
>> +	return (long)addr - bpf_arena_get_kern_vm_start(arena);
>> +}
>> +
>>   __bpf_kfunc_start_defs();
>>
>> -__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, =
u32 page_cnt,
>> -					int node_id, u64 flags)
>> +__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__arena=
__nullable,
>> +					u32 page_cnt, int node_id, u64 flags)
>>   {
>>   	struct bpf_map *map =3D p__map;
>>   	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>> +	long addr;
>>
>>   	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || flags || !page_cnt)
>>   		return NULL;
>>
>> -	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, nod=
e_id, true);
>> +	addr =3D arena_kaddr_to_uaddr(arena, addr__arena__nullable);
>> +	return (void *)arena_alloc_pages(arena, addr, page_cnt, node_id, true)=
;
>>   }
>>
>>   void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ig=
n, u32 page_cnt,
>> @@ -1082,14 +1092,20 @@ void *bpf_arena_alloc_pages_sleepable(void *p__m=
ap, void *addr__ign, u32 page_cn
>>   	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, no=
de_id, true);
>>   }
>>
>> -__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32=
 page_cnt)
>> +/*
>> + * A valid arena address can have zero low 32 bits, so ptr must be reba=
sed
>> + * unconditionally instead of being treated as nullable.
>> + */
>> +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__arena, u=
32 page_cnt)
>>   {
>>   	struct bpf_map *map =3D p__map;
>>   	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>> +	long ptr;
>>
>> -	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
>> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt)
>>   		return;
>> -	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
>> +	ptr =3D arena_kaddr_to_uaddr(arena, ptr__arena);
>> +	arena_free_pages(arena, ptr, page_cnt, true);
>>   }
>>
>>   void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, =
u32 page_cnt)
>> @@ -1102,10 +1118,11 @@ void bpf_arena_free_pages_non_sleepable(void *p_=
_map, void *ptr__ign, u32 page_c
>>   	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
>>   }
>>
>> -__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u=
32 page_cnt)
>> +__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__arena,=
 u32 page_cnt)
>>   {
>>   	struct bpf_map *map =3D p__map;
>>   	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>> +	long ptr;
>>
>>   	if (map->map_type !=3D BPF_MAP_TYPE_ARENA)
>>   		return -EINVAL;
>> @@ -1113,14 +1130,15 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p_=
_map, void *ptr__ign, u32 page_c
>>   	if (!page_cnt)
>>   		return 0;
>>
>> -	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
>> +	ptr =3D arena_kaddr_to_uaddr(arena, ptr__arena);
>> +	return arena_reserve_pages(arena, ptr, page_cnt);
>
> This patch does a couple unrelated things clumped together.
>
> There is a kfunc arena arg identification mechanism change: flag to
> suffix. And there is behavioral change: rebasing the pointer etc.
>
> I think it'd be easier to review and would lead to a cleaner git
> history if these were separated. In particular, I'd expect the flag
> deprecation itself to not require any changes in the jit tests.
>

Yep, makes sense. Will split into separate commits.

>>   }
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(arena_kfuncs)
>> -BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 =
| KF_SPINLOCK_SAFE)
>> -BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SA=
FE)
>> -BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK=
_SAFE)
>> +BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_SPINLOCK_SA=
FE)
>> +BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_SPINLOCK_SAFE)
>> +BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_SPINLOCK_SAFE)
>>   BTF_KFUNCS_END(arena_kfuncs)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set =3D {
>> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools=
/testing/selftests/bpf/progs/arena_kfunc_jit.c
>> index b5a01cbc33a7..c9af35c683b3 100644
>> --- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
>> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
>> @@ -49,15 +49,15 @@ __arch_x86_64
>>   __jited("...")
>>   __jited("	movl	%edi, %edi")
>>   __jited("	testl	%edi, %edi")
>> -__jited("	je	L0")
>> +__jited("	je	L1")
>>   __jited("	addq	%r12, %rdi")
>> -__jited("L0:	callq	{{.*}}")
>> +__jited("L1:	callq	{{.*}}")
>>   __arch_arm64
>>   __jited("...")
>>   __jited("	mov	w0, w0")
>> -__jited("	cbz	w0, L0")
>> +__jited("	cbz	w0, L1")
>>   __jited("	add	x0, x28, w0, uxtw")
>> -__jited("L0:	{{.*}}")
>> +__jited("L1:	{{.*}}")
>>   __success
>>   int arena_arg_jit_nullable(void *ctx)
>>   {
>> @@ -79,9 +79,9 @@ __jited("	movl	%ecx, %ecx")
>>   __jited("	addq	%r12, %rcx")
>>   __jited("	movl	%r8d, %r8d")
>>   __jited("	testl	%r8d, %r8d")
>> -__jited("	je	L0")
>> +__jited("	je	L1")
>>   __jited("	addq	%r12, %r8")
>> -__jited("L0:	callq	{{.*}}")
>> +__jited("L1:	callq	{{.*}}")
>>   __arch_arm64
>>   __jited("...")
>>   __jited("	add	x0, x28, w0, uxtw")
>> @@ -89,9 +89,9 @@ __jited("	add	x1, x28, w1, uxtw")
>>   __jited("	add	x2, x28, w2, uxtw")
>>   __jited("	add	x3, x28, w3, uxtw")
>>   __jited("	mov	w4, w4")
>> -__jited("	cbz	w4, L0")
>> +__jited("	cbz	w4, L1")
>>   __jited("	add	x4, x28, w4, uxtw")
>> -__jited("L0:	{{.*}}")
>> +__jited("L1:	{{.*}}")
>>   __success
>>   int arena_arg_jit_args5(void *ctx)
>>   {
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/=
testing/selftests/bpf/progs/verifier_arena.c
>> index 815f342eb4b0..d76490e059f9 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
>> @@ -445,6 +445,8 @@ int iter_maps1(struct bpf_iter__bpf_map *ctx)
>>
>>   	if (!map)
>>   		return 0;
>> +	/* Associate an arena before testing the generic map-pointer path. */
>> +	bpf_arena_reserve_pages(&arena, NULL, 0);
>>   	bpf_arena_alloc_pages(map, NULL, map->max_entries, 0, 0);
>>   	return 0;
>>   }
>> @@ -455,6 +457,8 @@ int iter_maps2(struct bpf_iter__bpf_map *ctx)
>>   {
>>   	struct seq_file *seq =3D ctx->meta->seq;
>>
>> +	/* Associate an arena before testing the generic map-pointer path. */
>> +	bpf_arena_reserve_pages(&arena, NULL, 0);
>>   	bpf_arena_alloc_pages((void *)seq, NULL, 1, 0, 0);
>>   	return 0;
>>   }
>> @@ -467,6 +471,8 @@ int iter_maps3(struct bpf_iter__bpf_map *ctx)
>>
>>   	if (!map)
>>   		return 0;
>> +	/* Associate an arena before testing the generic map-pointer path. */
>> +	bpf_arena_reserve_pages(&arena, NULL, 0);
>>   	bpf_arena_alloc_pages(map->inner_map_meta, NULL, map->max_entries, 0,=
 0);
>>   	return 0;
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/=
tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> index 6ab8730d4878..f6515e0e9b17 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
>> @@ -49,8 +49,10 @@ int big_alloc1(void *ctx)
>>
>>   	no_page =3D bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE,
>>   					1, NUMA_NO_NODE, 0);
>> -	if (no_page)
>> +	/* Only the low 32 bits contribute, so this is equivalent to NULL. */
>> +	if (!no_page)
>>   		return 3;
>> +	bpf_arena_free_pages(&arena, (void __arena *)no_page, 1);
>>   	if (*page1 !=3D 1)
>>   		return 4;
>>   	if (*page2 !=3D 2)

