Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6B238150;
	Fri,  9 Oct 2026 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513375; cv=none; b=kDltW/ujQ5gQv60V2H5mTqUgNSrhDcc9Fur7Maw3YLkAL/xRaNZhtyyf397IqavNifok2rZPDjnPmkSkUr90ItJxhOKwk2l+kSPRU2P2vsOuQh8ZW5kc99Z2f1JdRi+TNWVPh6BJ3mQP8xwHpBISMLr69wZb3q8LiOHjC3POj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513375; c=relaxed/simple;
	bh=Z2xXPTqu76inL6Lg3k68Az0+WvnC1l6x4tPfTlt1F3A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aEgtBb2TM+TvKatY/mhVu0/pt+B3hx9MN2lXSsD2YIBTI/CDe9B8oO73v5DRzkSU2kgM41AZqKGIRn30xSAO1t3xn7KyvgG5C/gycWmhwOhDCQGbJ/OViwFHk6OkpUyYidDr/H5vDIPR4rm2YsZGJxnEOE3jE0Dw1EjeiDwjDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkf4vjfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkf4vjfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B921F000FF;
	Fri,  9 Oct 2026 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513374;
	bh=o/A6RhbPk8EIKZR44/To/ttprtzTOtFibr2umaOofWE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Zkf4vjfndZDA+26O/1oAL2TdtnuZih0MAWyK/HY7ngma1VwMFIJ2FTNI3OZYAWAft
	 lo3XOJaAR9tqQsB5Hl5Pcv6r2VzBbi2T4ISl+2/fonTttORiMX1HokleNPGk1YMd3O
	 aX0JBrVcDCRhcXNmS5x2gKpi/gk+rk5Nfnfc/RICDdBhYSbGRPejOLmHfKuWxtMh6a
	 voohFlmLIUW2yAtk0C5kkyIKX7SmGkbeXBkUVjnGqU2JTa5j1ujEjZfyaFCaamaJKd
	 scux9go5/JXAIVtaVJpFaKmmWt1o9k4RI+wf08vuOzIcVbPS/JteQtO9LAnLUgphMP
	 o5kpXb6w8Tl5g==
Content-Type: multipart/mixed; boundary="===============1478710983047679949=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7c1af496987bd30766e332358e26b3e1256fb0cdc72e2f0412ef0e116b0c5223@mail.kernel.org>
In-Reply-To: <20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com>
References: <20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ameryhung@gmail.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 02:36:12 +0000 (UTC)

--===============1478710983047679949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer

TL;DR: Pre-existing race in bpf_struct_ops_map_free(): a timer callback may
still use a freed struct_ops or trampoline, since dissociation happens late
with no grace period. The test only waits longer; should the kernel be fixed?
Fixes tag questioned.

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c

[ ... ]

> @@ -34,6 +35,12 @@ __noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
>  	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
>  	recur--;
>
> +	/* Try again later until the map is freed */
> +	if (wait_map_free && timer_test_1_ret != -1) {
> +		bpf_timer_start(timer, timer_ns, 0);
> +		return 0;
> +	}
> +
>  	timer_cb_run++;
>
>  	return 0;

This isn't introduced by this patch, but the commit message relies on it:

  The association goes away only when the map is freed, which happens in
  a work item after an RCU grace period.

A subsystem pattern flags this ordering as potentially concerning: the
removal happens inside the RCU callback path rather than before it.  Could
this leave a window where a timer callback like this one uses a struct_ops
that is being freed?

The kernel side ordering is:

bpf_map_put()
  map_free_pre_rcu()          /* only deletes ksyms */
  call_rcu(&map->rcu, bpf_map_free_rcu_gp)
  ... grace period ...
  bpf_map_free_deferred()
    bpf_struct_ops_map_free()
      bpf_struct_ops_map_dissoc_progs(st_map);
        /* RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL) */

      if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
              synchronize_rcu_tasks();

      __bpf_struct_ops_map_free(map);
        /* frees image pages and st_map (kdata) */

The reader is this callback:

bpf_timer_cb()                /* hrtimer softirq */
  timer_cb()
    bpf_kfunc_multi_st_ops_test_1_assoc()
      bpf_prog_get_assoc_struct_ops()
        /* rcu_dereference_check(aux->st_ops_assoc), returns
         * &st_map->kvalue.data */
      st_ops->test_1()        /* jumps into the trampoline image */

test_1 does not pin the map, and the timer keeps the prog alive through
cb->prog.  So a callback can start after the grace period has ended and
before the NULL store in bpf_struct_ops_map_dissoc_progs(), and call_rcu()
does not wait for that reader.

testmod_multi_st_ops does not set free_after_tasks_rcu_gp, so there is no
grace period between RCU_INIT_POINTER(NULL) and
bpf_struct_ops_map_free_image()/bpf_map_area_free(st_map).  The callback
can therefore still be reading kdata or running trampoline code that has
just been freed.

Before 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period
optional"), bpf_struct_ops_map_free() ran synchronize_rcu_mult(call_rcu,
call_rcu_tasks) after the dissociation and before freeing, which covered
this reader.  That commit moved the grace period in front of map_free but
left the dissociation inside it.  It is also why the association is now
cleared later, which is the delay this patch works around.

0e841d19263a added this subtest to make sure "the timer callback cannot get
a dangled pointer to the struct_ops when the map is freed".  The new loop
keeps calling through the association every 500ms until it is cleared and
then only checks for -1, so it cannot detect this window.

For balance, the race is in kernel/bpf/bpf_struct_ops.c rather than in the
files this patch changes, and it predates the series since 5db69b0fbdc8 is
in the base.  The window is narrow: the reader must load st_ops_assoc in the
gap between the end of the grace period and the dissociation in the work
item, and still be inside st_ops->test_1() when __bpf_struct_ops_map_free()
frees the image.  It is still structurally possible because nothing orders
the reader against the free.

Should the late dissociation be fixed in bpf_struct_ops_map_free() instead
of only making the test wait longer, for example with a grace period after
bpf_struct_ops_map_dissoc_progs() or by dissociating before the call_rcu()?

If the flakiness started with 5db69b0fbdc8, is the Fixes: tag pointing at
the right commit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37873469458
--===============1478710983047679949==--
