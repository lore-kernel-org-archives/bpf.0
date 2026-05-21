Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0D2874E3
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336514; cv=none; b=sE3/oZQS8jP3HRN5ucCF+NfKVRGRZkmIp9KlKanGY82ByZJI+sNzh1OlYim3XAs0KAiPqUx80UXmOGfJtFExmyip6nK7oNUgSHAE1beKPjWEXYtrnMsNno6ypLvN+vrGZktqI46h20uOBmJadhmSxhqrUBFtlM97hM5iMFs6pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336514; c=relaxed/simple;
	bh=cXsEv7M8s8B+fW56IioKkoVTP6yPw0hwmUPpqeXjWu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=taeKNmFvOR1LumPAsSp2sD8JuL9WEJspMq16Zgg9szyLGEmOfti7K348YD0zUgKH8GixAdrDQyRz/9nHyfHShJNceLuvXUyMUIklA04cM1D2Y5WWNoMabnfLawM7XJSHYjovqbP6MICOaoSLVvLAUVNtshhcp697eZkGmrrGRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cY3UYIPG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cY3UYIPG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83ef1d17904so5612938b3a.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779336512; x=1779941312; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynBnbM/NLUcVxU1YYBO1La/PNj07zsMaWyq2DVRegqU=;
        b=cY3UYIPG2erHrgu9yemSWFmSt00sDwaerMFopcaBp/FJ1kD3ZN3mBZCI+Ht4wdlH2x
         meTJgDtkoK+cUjLvORxi6xwpgzokb945EFL2JjH+y96hLpMd/meb9Sv2zI6dgyU+qla9
         oExywKIB5g8HUXyGzUDeh9XRofd+LIC/aKCRruPs24eRKOVorIMy3Tm2NVVrvNN1guGx
         KfztrGd1w4DYiLXpv5yyIXMMgEr7dWsiQLleOpUKs31f/mOo0JUcw5sFbzVhft+K7eDS
         ng7NALqCPTlRv+qPfOJACUDMb3c78pxoQnum007hT8VZHHYwKjqjYR1qrZWNXyUtaRN7
         C3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779336512; x=1779941312;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynBnbM/NLUcVxU1YYBO1La/PNj07zsMaWyq2DVRegqU=;
        b=c8E1vR0IUF+R34o9ygWgfbtgqSq+AxyrrZAepLz/wvyoYkX6IXFWolokjMFSRjp83O
         U3iBrcq8HqZNInrZj0I7ePS5oiMZWon9pm/E/gcU6kPGON04/oUGucVQ0MfJ78qXVLBj
         6uUQIgcfrRzHcxbuSrxtablOaJtzgnVzC6cZde8Pux3sR/Or0UvOQJXcTbjtjM+y6i7g
         2v8UbyJgpopbvS/PYGNzD+bWZ+gNSRuFVyIt0RurPw8GneaIBX54Hp26vEm4cW6CV3CC
         6dPUY+34HZCqQ7c7tLOhqWVTKbgrsh26mq9cU8j/A2Aocd2CfexbH7URXmHqSSTf4fnt
         iqTg==
X-Forwarded-Encrypted: i=1; AFNElJ++ykKla1svSWFCA0L7daLZy6keHW1FN1iVuY4eFhCj4pQhn7xXolJl3Qpoj4vri8EfhzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIq1jWViwxiVO7nP9QOQIwpqu2zv+mqWdQhEiihuQU18mLTnI
	HnhUlkhhIllFNHBFxY0oP32wpoEMQcKXgrkJHPcgvfJN1nPaGDjhQO15ofEBuBCtJFU=
X-Gm-Gg: Acq92OFpEF/DZ9ZAdHFEXT1ftlUWdIITgnsQtNUPclGt1iqsC/x+4P2z2IuN8YyGLlA
	2+x6g8V1JIrCOek5SHtCJC734MgsuTd+qm7bKcW6yawiiMHwh7CkaC2q4Bfi8VkEKE9nsDfmh6i
	6VU+E/GJ60BA3xqwAon/s84ITlRSpxDvFHw7CfxxTpRkt2TsFdsEj8vpBAA9fjHFhzxdVP2uzrJ
	ba+1QUWaog6JhKY4/GPflXspvfT7dTbEbwsyV+LP7Zj1fDOG/oz52RoYHTMU54rMgyKyINRTFp4
	toUS7dOE+7vbDouxnujK0P9uR2AxqvHgd9DP5n9DPxd0OVqReXuenBlNmqxIXHdPrigogf63Evu
	NeU+PPJbDynTiLqHHUUpQbs/iLIS04K/KzwITjRduLhGk15CGN/URseO6vOL2ply7F2WptmJcgr
	+0BfV654IxD1RAj9y/vSYoG6zQ
X-Received: by 2002:aa7:88c1:0:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-8414adf532amr1336929b3a.31.1779336511925;
        Wed, 20 May 2026 21:08:31 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8413ac7b2b2sm3505781b3a.14.2026.05.20.21.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:08:30 -0400
Message-Id: <DIO25GJPKAS6.1MJRN7AI18G4P@etsalapatis.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] bpf/arena: Add bpf_arena_map_kern_vm_start() and
 bpf_prog_arena()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-6-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-6-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> struct bpf_arena is opaque to callers outside arena.c. Add two helpers
> for struct_ops subsystems that need to reach into an arena:
>
>   bpf_arena_map_kern_vm_start(struct bpf_map *map)
>     returns @map's kern_vm_start. A sched_ext follow-up needs this
>     to translate kern_va <-> uaddr.
>
>   bpf_prog_arena(struct bpf_prog *prog)
>     returns the bpf_map of the arena referenced by @prog (NULL if
>     @prog references no arena). The verifier enforces at most one
>     arena per program. Used by struct_ops callers that auto-discover
>     an arena from a member prog and need to take a map reference.
>
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/arena.c  | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b99d786e98c..e1ba57c10aaa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -618,6 +618,8 @@ void bpf_rb_root_free(const struct btf_field *field, =
void *rb_root,
>  		      struct bpf_spin_lock *spin_lock);
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
>  u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
> +u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
> +struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
>  int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
> =20
>  struct bpf_offload_dev;
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index a811cf6170fa..51b9ae36feb6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -84,6 +84,32 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *aren=
a)
>  	return arena ? arena->user_vm_start : 0;
>  }
> =20
> +/**
> + * bpf_arena_map_kern_vm_start - kern_vm_start lookup by struct bpf_map =
*
> + * @map: a BPF_MAP_TYPE_ARENA map
> + *
> + * Return @map's kern_vm_start.
> + */
> +u64 bpf_arena_map_kern_vm_start(struct bpf_map *map)
> +{
> +	return bpf_arena_get_kern_vm_start(container_of(map, struct bpf_arena, =
map));
> +}
> +
> +/**
> + * bpf_prog_arena - return the bpf_map of the arena referenced by @prog
> + * @prog: a loaded BPF program
> + *
> + * The verifier enforces at most one arena per program and stores it in
> + * prog->aux->arena. Return that arena's underlying bpf_map, or NULL if
> + * @prog does not reference an arena.
> + */
> +struct bpf_map *bpf_prog_arena(struct bpf_prog *prog)
> +{
> +	struct bpf_arena *arena =3D prog->aux->arena;
> +
> +	return arena ? &arena->map : NULL;
> +}
> +
>  static long arena_map_peek_elem(struct bpf_map *map, void *value)
>  {
>  	return -EOPNOTSUPP;

