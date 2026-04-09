Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7082D5C7A
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697758; cv=none; b=n6+4rxx2wCNmkf2dhZ56Ew0/Q682ZbyayD6tbi/SJUYdsjPR2DJQuLPZ9GezMEyGDrHhAurQT9tLiaQjWeIF98ZHdEw0v4w3nwy2jFEONljq9Ybvaiad1WCZ17DTQK2BHW7PNKcJXVGnkBXSg1mGc3nN2tx5owrtdcn41wZyX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697758; c=relaxed/simple;
	bh=+Mw3mjiS7RrzjMMRo/QPrOVOlHCRjwuLqSv+tnIdrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtIqXZPiFJrEhv9xKQXwp68Wc9POcdn0MCYYH/9xRxrLK10nQEBfwQ89/4emVoLLuoWtyEUeBIrpymVqnIEyzEREMJCruWHVUfphOBzVf4KPn8xjNqkj/Ny0I9chAnqerYL+qeNcg9ITT5aN3C0c7/lZueEPskG30HuIBUV7q/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3YXz83z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3YXz83z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC83EC19424
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697757;
	bh=+Mw3mjiS7RrzjMMRo/QPrOVOlHCRjwuLqSv+tnIdrH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r3YXz83z8mdXp1ZArKqlfQQ+1/wpB8DRMyzK9LsrMnkzRihr7w7cG7qF7th3h+SQv
	 PRmqEdynCAdB0BHBCGsg8Ay+TKkNouhFYsQwDTRpkzPgIDpf4dj9R5dEzsDN3b1/DA
	 OCKj40beOPQmDm8c0euFbp9eQx6P1kv/t9p0Lqub40Mdo1ZCSZehrCvL2xIcTv3yT/
	 ia0la6kJuI0Ltc55Ey1AQUG9WtxraAN7fWfOdy6Jox5y+uDuD3giYnCmi68vqQ3GUw
	 LxtE+p6las6wLi4a3n978UtWsmxV3AHBHVqDtzlvGz0eP/gDyg4TKQZHXCD7HaerPr
	 tpcv0V2aGqVXg==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a5db525cso3113686d6.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:22:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0q+HfmJM2QpjOLTfpJAS9AvocY9oxNHitTWVszsKEEzvspQ0J
	2r1OHOCMhHp84tddxg4t4hRVFJZYSMYQxmPAZCeFh/OnnAOgy9dcXGYIK3zg+3306GlfC2OpZtP
	KFJvr+3B7H9U6DG7q8x5hTLt0a1MM56Y=
X-Received: by 2002:a05:6214:5a03:b0:89c:4b50:510f with SMTP id
 6a1803df08f44-8a7024baf4emr341965226d6.8.1775697757106; Wed, 08 Apr 2026
 18:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-4-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-4-emil@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Wed, 8 Apr 2026 18:22:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6_jb-BdH-B9JHmPRoq7bTGvuMZWi+RLWVfo2atS1u=XQ@mail.gmail.com>
X-Gm-Features: AQROBzBTHI6ENaiH0yArzkKrhWcnEkl-J0_14JZ3Mn29JLlgZ84mkYwIdeSUdkM
Message-ID: <CAPhsuW6_jb-BdH-B9JHmPRoq7bTGvuMZWi+RLWVfo2atS1u=XQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/9] selftests/bpf: Move bpf_arena_spin_lock.h
 to the top level
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> The bpf_arena_spin_lock.h header is useful for all programs and not
> just the selftests. Move it to the top level of the BPF selftests
> to make it more readily accessible.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h | 4 ++--
>  tools/testing/selftests/bpf/progs/arena_spin_lock.c           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename tools/testing/selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h (=
99%)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/to=
ols/testing/selftests/bpf/bpf_arena_spin_lock.h
> similarity index 99%
> rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> rename to tools/testing/selftests/bpf/bpf_arena_spin_lock.h
> index f90531cf3ee5..680c9e6cb35d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
> @@ -107,7 +107,7 @@ struct arena_qnode {
>  #define _Q_LOCKED_VAL          (1U << _Q_LOCKED_OFFSET)
>  #define _Q_PENDING_VAL         (1U << _Q_PENDING_OFFSET)
>
> -struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
> +struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NO=
DES];

After adding __hidden, we no longer need the struct arena_qnode
definition in prog_tests/arena_spin_lock.c. Let's remove that.

There is a typedef in prog_tests/arena_spin_lock.c, which is not
needed before this change. Since we are on this, let's remove it
together. IOW, we need the following:

diff --git i/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
w/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index 693fd86fbde6..acb9d53b5973 100644
--- i/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ w/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -5,13 +5,6 @@
 #include <sys/sysinfo.h>

 struct __qspinlock { int val; };
-typedef struct __qspinlock arena_spinlock_t;
-
-struct arena_qnode {
-       unsigned long next;
-       int count;
-       int locked;
-};

 #include "arena_spin_lock.skel.h"


Thanks,
Song

[...]
