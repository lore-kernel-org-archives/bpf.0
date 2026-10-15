Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5E4D2EC4
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086117; cv=pass; b=CGAf+uCxu2Scto1xBAF8zEgZFIn33+Hlr3Our52jkVHqupdYlUPZjyeVOOz/E16DkTEDfzjSU04Qxk6yII9IU+fYadqfDDOzhI23NP8cbi8LX7wZ5R15aU1xnhuewPwsb0KgibA5fdJXuhXSETOB4XEL6cIgYIShjcEzmr6AHz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086117; c=relaxed/simple;
	bh=pWvyalycBKMpW/SeEYWiupuyITbO41ulxAjlLOu97oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWrY/husebfBoSZmWaRBfa6i0zch0sk/amuxriAHmgQ1t6T3pzXUZZRaxF+shk/yBXh9cRdfS3IM3kYspMYhc36q2S0G+fn4BQSfXgRAl3tsTQ550Dk8ep3ib1xSBzhuMyPfWNUbE91efKTdFup5tX4LRuDB/PfLpOjOj+d/4VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCqEcuHJ; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCqEcuHJ"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4f48d91ba7dso4046011b6e.2
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 10:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792086109; cv=none;
        d=google.com; s=arc-20260327;
        b=N6WyhLNAvyn+9RMSh4cjYVoRapq+RpODiPzO56qFeuE1Jhr2Y/pB5SCP9WreCJOWKn
         unNBZMK2z8vWJ8OYeI6dW2c0y/kiUJoMLwKsn/u2AmApMEjafTE3XwlJXZIYsSiB0YeT
         o7TVTN17+uwbyG2qHMF3AByegs288NoNF+pgXXgc7QxMtwGDWs1xbwd/KP8H4H3nywyR
         r4ugJcuJh0injrvNFSoRDQt41XVoDwvQ+nHf2MDgGYgojwStM9FX+QkJFW/KRZ6KfxmL
         KHWKT/A3pEZ67BbagczWsBKTLlaypUePXGJ80dez7YZw2IGvnCMA+yfeL+ejAqfJKarj
         d9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lj1DQBWy3OXBOduX0L3oQHUHpN/MbkDFzxGdaly9HNg=;
        fh=TqLO7lkCNvjsaxo+A/iVpy1/zie06haD9+WLDarq2A4=;
        b=H9p9D7VF5p0SAirVZygHfYpMKRtZUiqmd9zMBHt6CcjxrJyxHfHCs89UboqkeY7i/A
         vaxFHLHNZxbP8dTAcqt+yUOu6q60V2YEpu4tBVUJNlFhPja5KVQa4qsQ+JdoNQEDk3BO
         d2F1B2kMlqNjZH1/3VXhbvKe4+v8qQjq1sKf5VI8ueKqHwTPw5LHJX8Iekc2GKErZzyh
         YjcPqANkIMOynktj85c1xhlPF7AEENI4CRpwptVWeJXAdIcksJP1COTrOee9THaTyiDh
         b1HVXBrzrsvGf1pzKC+/mcRDvBUVi9eo0bOHjXJpnB/3dzqqHJIYD8rkmzLbDfvasrYy
         f8xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792086109; x=1792690909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lj1DQBWy3OXBOduX0L3oQHUHpN/MbkDFzxGdaly9HNg=;
        b=OCqEcuHJFXqRxFp5k9C3qFUlNuwbBbYwckBT8lwwZ1F5c3frwSvwc6BYnzGKdHVJnw
         Z0Rgs29m5+A0cgLqHwlWCemkPV6hw6sibiojH676LAWoigpqY9v3p2fEy+eLTnlepSf/
         Zu07kP4pmk4iOqpcHuHtiuiyjznwhAFg7m69TUZpvw+HDQpVeBE5OobSxP57ysFwVp31
         YtSfmuCVobaRqK58dvreDN/vvF/mxReZrm+RQmgsvTkPsM/+gTUhHzQxIpdlzh8X+/Il
         QZPwWw3zTFm3eV0X/sDBbsYL//Orvdyts/9U0kcRhWxtMLURxmBWGUearXK3wccgbaVT
         f4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086109; x=1792690909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lj1DQBWy3OXBOduX0L3oQHUHpN/MbkDFzxGdaly9HNg=;
        b=0EYgRmSjcc7aWU0wYM5cWYiIqDIy5Og+W1eYtA1O9nuDp0NB7Tgs98M0wcvSyl3r1t
         R6exo5YdfDETg3qgpnZqDPIZVCFRJp90QrHx/JX1ogO+DPgPaixTowfqNlf7Vu0PNLqu
         RV+9JRF53LHgAb1ZZfag/NS8+fz+CK0BoKx0LT6kvn/uLodEcEMUn/cp1OmSSyEBxCCY
         hK/Yl0ex8BMPmT4/PjQdDpFUdsMMe2hJqclSHIP2ZjE5HOgLa3rg1Z/UdiKMvUYAAvXP
         5GS/vnRK9ct8yNcMcmQGP64wzS+X+jl5Eq4W/YQDyuIam5nQbTk1ydGj6NsQq/4ZV8qY
         4/mQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVb166b2JRirYSxux7+qhe50VUcFK34AI5dnAIx8r8fHeRA3OIldjJ0n5ApUMwXoxqzWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfwyrk1ZN8KoGEY6KGy71rpqT3JrwtzaF0lYlIoRip5km7uCE9
	V5aRMwzHovlKi/2TEIOJgdmdLoSVAbG2++oj5ItDgw0lgDgT2TKx4hZFpJwfV0440F+7PB193c3
	+WYHYcDoo8EZuo/ycrAnIYOIRZ0PKueo=
X-Gm-Gg: AYBFou0fgPrDG6s5ozUZ2PGUxyhY6MleqkG9tJNuc8xXOZ8TvCK6K4FcTUgPJn0wZ63
	SNOAH9KGLVGNkvezTj2HnGZNTcs+rTT0PodEooSKRtSWT4yFpJc/VzEksA9V0HxWFYHAkx7SjBy
	8RVvf8MRIOWFexqMyatfIlZOy8G7AaEi1qqNo2MbJJDhO4qsmWaVE6PvdN3fmcsTFVvyc0rvNgG
	2XWyly737azodz0M6uyTWbzLUretlXqsZmCSwJfaXNOb8s0v4jaEF89rxR4LvIhFTvvsQQVZ1UM
	6K/Kt1YFZjK5wQKMN47HhsA5sobQBeHIHFnwVQrP97CDE+jObRaAEDI=
X-Received: by 2002:a05:6808:23ca:b0:4d6:92b3:5c88 with SMTP id
 5614622812f47-50c5b27c212mr21580284b6e.64.1792086109195; Thu, 15 Oct 2026
 10:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com>
In-Reply-To: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 15 Oct 2026 10:41:38 -0700
X-Gm-Features: AclHuK98TOBFifxyiHAjpf6qUBttGLdv2xnCl-ElpsA6_pdX4NyYfKL1VgU_hh8
Message-ID: <CAMB2axPRjfe=ROzA0rMR1_FPyv1mA-jaH3bHQHZje=Q1PjoEVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix a struct_ops use-after-free
 behind a flaky assoc_in_timer test
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:35=E2=80=AFPM Qiliang Yuan <odys.yuan@gmail.com> =
wrote:
>
> st_ops_assoc_in_timer_no_uref drops every reference to a struct_ops map
> and expects a timer callback of its prog, 500ms later, to find no
> struct_ops associated anymore. It fails now and then while test_progs
> runs other tests in parallel, and v1 [1] made the test wait until the
> association goes away.
>
> As the BPF CI bot pointed out on v1, the association goes away late
> since commit 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period
> optional"), which moved the RCU grace period of a struct_ops map in
> front of clearing the association, so nothing waits for a prog that
> reads the association in between. With that window widened, a timer
> callback returns into a freed trampoline and the kernel hits an int3
> Oops.
>
> Patch 1 frees the map only after a grace period that follows clearing
> the association, and patch 2 adds a test that catches a map freed under
> a running .test_1. Patch 3 is v1 of the test fix, which can keep calling
> through the association until it is cleared now that this is safe.

I think this fix is heading in the wrong direction. The struct_ops map
association was designed as an RCU-protected pointer: asynchronous
users may outlive the map and observe a NULL association. The existing
selftest explicitly verifies this behavior.

The problem is that the disassociation now happens after the grace
period initiated by bpf_map_put(). Could we instead make
disassociation safe in map_free_pre_rcu(), before that existing grace
period, rather than adding another deferred-free path?

>
> [1] https://lore.kernel.org/r/20261009-selftests-bpf-struct-ops-assoc-tim=
er-v1-1-9a97a9b3d1db@gmail.com
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> V2 -> V3:
> - Wait for an RCU tasks trace grace period in patch 1 for every map, so
>   that progs reading the association under RCU tasks trace, e.g. from a
>   bpf_wq callback, are waited for too (CI bot)
>
> V1 -> V2:
> - Add patch 1, fixing the use-after-free behind the flaky test (CI bot)
> - Add patch 2, a test for the use-after-free
> - Point Fixes of patch 3 at 5db69b0fbdc8 (CI bot)
> - Move the restarting of the timer into patch 2, which needs it too,
>   so patch 3 only turns it on for st_ops_assoc_in_timer_no_uref
> - Rebase onto current bpf-next
>
> v2: https://lore.kernel.org/r/20261010-selftests-bpf-struct-ops-assoc-tim=
er-v2-0-d7a43896dbf1@gmail.com
> v1: https://lore.kernel.org/r/20261009-selftests-bpf-struct-ops-assoc-tim=
er-v1-1-9a97a9b3d1db@gmail.com
>
> ---
> Qiliang Yuan (3):
>       bpf: Defer freeing a struct_ops map until its progs are done
>       selftests/bpf: Test freeing a struct_ops map under a running prog
>       selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_=
timer
>
>  kernel/bpf/bpf_struct_ops.c                        | 28 ++++++++++++++++=
++++-
>  .../bpf/prog_tests/test_struct_ops_assoc.c         | 29 ++++++++++++++++=
+++---
>  .../bpf/progs/struct_ops_assoc_in_timer.c          | 16 ++++++++++++
>  3 files changed, 68 insertions(+), 5 deletions(-)
> ---
> base-commit: 15b578b1715d9a318c804350d98af87c203672bc
> change-id: 20261009-selftests-bpf-struct-ops-assoc-timer-5eb0295ec300
>
> Best regards,
> --
> Qiliang Yuan <odys.yuan@gmail.com>
>
