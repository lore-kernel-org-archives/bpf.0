Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179182BB13
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567719; cv=pass; b=U2NsRSJeNSP8SaWbsOkRkE8cn7DGoSAQcarBN2TARl//2dg0ZVNxvvh36yb1ev9oEweH6OnNBTPiQDeeM8iG6nB+uuSLas+FQ2DzbQv+QApnKQ6t6TfH05k8TNwme0JGvpvHzzCuaRIHWaY46V2yjm2MyGfEmmlLIwvCbIO6lkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567719; c=relaxed/simple;
	bh=uQfFX2WgXngo34tR0wcAgYlOAZ6WxU69A6EJT+fTGKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLcv8am4wPvdEkJVtJnKL63rTKvj6nwQA0rwyEmGRMbuO+AVKFKNpLXXZSsXIqFxqk3Becv/sKD3Ka3k7p44b3AwJ8aXNqfKXBHM2zzEBOxgW4jATiutKXY3wnP4h5vRyR8sZRXbyNoftISSK2qRGhDMrA9y1Q4eRLRFYvfFJVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0BzCqKT; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0BzCqKT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305552so5678444f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:35:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567716; cv=none;
        d=google.com; s=arc-20240605;
        b=jiZbFALfyu0TaKdA2f5QgE32gAvx717xpYNBmmluqjHc9lVD4C3TbNbG3esogt/VmE
         FqRYIQkEkhKFKM8dH6tWUuUQIBJOSu9FlFW3PG/cQbdtSeRoCHR2NWNDYW9gOQPGWNZX
         uMC/mW/mn7jCt2anbBTPi4+E4Rv0k6So1OvbCdh4VVd+XpLjS/SHEVeo8kLTUVTmboN4
         rr8wiUQgvhbQJtM8VY98yFDtIacXInTam5K11tRS+JAuPRQy+kiEQWtrRxqC3P6XVLjB
         NP6BSg8jKfDjdOecTvVt79kEeMwlne56Z2ItAezVsLhzVlQOkT3MBPUxzVKtPJg/5urf
         jOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VxijQVuetwZXKnziNFUfprZSmHJi9803to6KY+wGTEA=;
        fh=07919j3mEGtUJ+mScCnPzO16vurW6cKq9ZaYr312Wzs=;
        b=N2J1+gVFlUp5nPOHxCRQgKJvsbiO4YKluQEmcW8SzosvC/8Xr/htf5Uwdd5of2bjF/
         RwKfMHZZ3L/PytnIYqUn/j/XxmImGbQqFtR5eLty+or6n3VBlJQ4Juk60BrK6FEncNA+
         XUtkhoqD1K8I+kOZwtwdIv8LZPwsoYUAgumGhUTyGjcwGmxSQcspiTTDw824fmqEo5RT
         1XyoO5JzIZ3SulZg/8xqklQhQuEZjE4jBx/rDAAu7nIGzVFc04qpePTiCsg+dcjRMSO/
         3r8++nwnqj0ZrGjNul38Hp4LEMmfgLJAUVsH82Dntom8b5LsknmmrzGlj6UT//bUGlB0
         UheA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567716; x=1770172516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxijQVuetwZXKnziNFUfprZSmHJi9803to6KY+wGTEA=;
        b=L0BzCqKTy6YlAHU6X+2D7QHcck2LyiW2aqOowoJvnj8LwDhcZoBcN3X10CbAbygh44
         pFuWgA5/9gpMJqJEDZ4LLW7ODk1ov6R3FQmwavR9hNI3PugDtA0nfjE9MYV3IVWKyl8c
         Mb3Fb5qJTKcwzcuFYUqGzf3QmAcXXMyOE7SXOX84J8mylwTcMCveUW/DebNd+RISf2B9
         cJwVL07kDbEgeqt7yj5s4k8OvnZUmJC1FyLiwjFMWxsELXekaRO/4yUflCDwle8maXWj
         dOaT90Qom1EciAErCNvnzw/xAiwxq9hY0Ev3OEFXkXbcOyLeQA7b4fotJJTaf0mqBy0n
         U+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567716; x=1770172516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxijQVuetwZXKnziNFUfprZSmHJi9803to6KY+wGTEA=;
        b=nsh4vrKPpuJs4JEH91PKJQa4uNQTvcSTWWeWORvujAaHiSIxHX/G/B8zXhnv/bWRfV
         6G77yA1BynvE071l7lSnakbElIxhSECC/A6RcE1XBRV+ozqu4irWY12WRN+uG42RJh5p
         7T4UrtoCzvwVigM2DFwAXCBFlF3Fa02vNw62SQHUyAr7H3fYRz1j11i6HEd4iA8H4qT1
         +zQibRWg7z7ZEi941TFYemQyNqLeBGoU6qmQfbCVM93NPqnW5gPJmhAbHyWZXz8MB6HT
         6ykizb8iH9vfx77v1TYZ609WW9Va34+irIEmWd3kb0h/YB13C+l4TBjhw1tvsejgg36Q
         Gk3w==
X-Gm-Message-State: AOJu0YyenaX0QW/aSPsArQT1V7lwenmnxX+JOWydPjTQatqjmf6xwr3n
	tllddKSwmksYQc92YYchSpnwYckLW7rI3g3DRQ7t74Eb/ZnoH1eRpHI5zvUX6e3zBmP5schK7B3
	4BLSE9M9qdcgt3WFCVCb99GW86r3xMJA=
X-Gm-Gg: AZuq6aK4NrxQCEb/18Cl94Iq1XDDjuJmFnpoRN6KXiQcVntFFY1B6baabFoeiygt7wR
	NvGJosCNN4b3QLYOV9ZZ7iwyHm+43QVa7HKoqyepcDaXmcF9gOQ6ae48CHcmsciHKsDCyfTKQ4E
	kxI9m9tgw3ZiBt8bY0xCLXT5c9Mc5WGgJGgpf00/Rhph2ulQPlSbof8uFLEwa4gkggmgWHf4V9S
	Rj2Xa9li844oqUmbtw+mb3tSA9eAs6t67B1sNvlS+9VaY4XF71ORoG6nYGS07OBpBhBiLAWD+ed
	QC1gNtSDmn4rbihUw3VDfc4Gc4btIl7toOH//4DLiCjlqEL8wEkP6W2R+V/HbVQsYddJSF5XlZs
	hXSJmpQpJO8uzRg==
X-Received: by 2002:a5d:5d0a:0:b0:431:369:e7b with SMTP id ffacd0b85a97d-435dd032bc5mr4639515f8f.18.1769567716055;
 Tue, 27 Jan 2026 18:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-12-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-12-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 18:35:05 -0800
X-Gm-Features: AZwV_QhgnKcyD7tBl2oRCVgQe6-CPjuREzJAVHZnFHF4s8tebnASRJVaM2vryBw
Message-ID: <CAADnVQJ8WPQg5+GBj-+1E+YdPQkv2A=XeeryqgQE8th5qf7+=Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] selftests: bpf: Add selftests for the libarena
 stack allocator
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	etsal@meta.com, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:16=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add ASAN selftests for the stack allocators to ensure proper
> ASAN integration.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  .../bpf/libarena/selftests/selftest.c         |   2 +
>  .../libarena/selftests/st_asan_stack.bpf.c    | 253 ++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_stack.bpf.c
>
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
> index a0fd7a2e6c46..3e4b8754889f 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> @@ -269,6 +269,7 @@ TEST(bump_selftest);
>
>  #ifdef BPF_ARENA_ASAN
>  TEST(asan_test_bump);
> +TEST(asan_test_stack);
>  #endif
>
>  static void
> @@ -316,6 +317,7 @@ int main(int argc, char *argv[])
>
>  #ifdef BPF_ARENA_ASAN
>         run_asan_test_bump();
> +       run_asan_test_stack();
>  #endif
>
>         return 0;
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack=
.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c
> new file mode 100644
> index 000000000000..a4c1780e4247
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c
> @@ -0,0 +1,253 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
> + */
> +
> +#include <common.h>
> +
> +#include <asan.h>
> +#include <stack.h>
> +
> +#include "selftest.h"
> +
> +#ifdef BPF_ARENA_ASAN
> +
> +#include "st_asan_common.h"
> +
> +#define STACK_PAGES_PER_ALLOC (4)
> +#define STACK_ALLOCS (4)
> +
> +/*
> + * Keep this test-related array in BSS to avoid
> + * overly burdening the function stack.
> + */
> +u64 __arena stk_blks[STACK_ALLOCS];
> +
> +/*
> + * Spinlock used by the stack allocator.
> + */
> +private(ST_STACK) struct stk st_stack;
> +u64 __arena st_asan_stack_lock;
> +
> +static __maybe_unused void stk_blks_dump(void)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < STACK_ALLOCS && can_loop; i++)
> +               bpf_printk("[%d] 0x%lx", i, stk_blks[i]);
> +}
> +
> +struct qsort_limits {
> +       int lo;
> +       int hi;
> +};
> +
> +__always_inline void swap(unsigned int i, unsigned int j)
> +{
> +       u64 tmp;
> +
> +       tmp =3D stk_blks[i];
> +       stk_blks[i] =3D stk_blks[j];
> +       stk_blks[j] =3D tmp;
> +}
> +
> +static __always_inline int qsort_partition(unsigned int lo, unsigned hi)
> +{
> +       unsigned int i;
> +       u64 pivotval;
> +       int pivot;
> +
> +       if (lo >=3D STACK_ALLOCS || hi >=3D STACK_ALLOCS) {
> +               bpf_printk("%s:%d invalid lo/hi indices %d/%d", __func__,
> +                          __LINE__, lo, hi);
> +               return 0;
> +       }
> +
> +       pivotval =3D stk_blks[hi];
> +       pivot =3D lo;
> +
> +       for (i =3D lo; i < hi && can_loop; i++) {
> +               if (stk_blks[i] > pivotval)
> +                       continue;
> +
> +               swap(i, pivot);
> +               pivot +=3D 1;
> +       }
> +
> +       swap(pivot, hi);
> +
> +       return pivot;
> +}
> +
> +static __always_inline int qsort_stack_blocks(void)

Amount of always_inline here and throughout looks excessive.
Especially for a heavy function like qsort.

Try removing all of them and add only where it's absolutely
necessary and add a comment why.
Like in core asan_loadN() functions it's clear why you want
full inline there, but in selftest... ?
