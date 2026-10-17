Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34C303A04;
	Sat, 17 Oct 2026 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201968; cv=none; b=HGX32hZyFF2tQk3YWC7+upvRYSj/JkIyClRJeoUIDIyCdO69nT46Cj/LvjGy4fRLDWCAF8KsT5rHlUXgLSoG8W9zBusQ/tIqDHJhtiQlTM4dSuksdMfolhMseUbhpqnVBnrhHldrBLW/EpO1OX07lJ75s2L9jtVbyxkPILfiYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201968; c=relaxed/simple;
	bh=+bZI8wly5eDGayryvsGqobJTAS+537SL6h1SyJlRTIE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LHg6uabnaKNsLmbp/wHQNyxgi3AFU6OVD0rLGSRxUY5vEna48dqVoMnEYCQZT+s+9n5y5JCXJMBG2hXqXYKstNUjipUpW7qqQfcXECGNYXF0r1sdumSepESZ88ZTqH+m4nYXntXLR9EnsQ3+W9dxw0JD30T/FfUT88C4jjZdDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4X/eiZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4X/eiZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5131F000C4;
	Sat, 17 Oct 2026 01:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201966;
	bh=NPwlg68vom/2k1L+SuKMG8v4a0E3d3PLIOOfY4gmI/c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e4X/eiZBdsTNlRz0aeltuH2MfViOeRX9D3vOX+4SFXm0C35Lu3T72YWtdl40wdlDu
	 aCR1WbOQh6H9PNgBjyhKCnBxb9x4jAox6FxuGuMsCcwsTAAWyNEEyZOp6AkGrBPErl
	 YtTwlr8zitHAbylSkjMYTXniJoXQZtPhPdSdVgqRjZTsglu1WYHM2ItQlXQns9MPn2
	 pqfSt5uNpozj98vkCvKZ3hOoCZ4TyqbQW5RTJSQgA1Uz2pLnUPQiUeQckHMPFeXxto
	 gfLawOwxoOTBrpgPiFeglpb7QsywHj8MmjYEuaLQrRAg0OkVrFj/k3AL5CpdiW+BYJ
	 2xu1x86RSYV8A==
Content-Type: multipart/mixed; boundary="===============0001666948501514510=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c6e3cf4c8e650803377f900f18c4ffc183e5883781dcd2015c0898d598928f53@mail.kernel.org>
In-Reply-To: <20261017012058.355787-5-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 04/38] bpf: don't hand out a linked element as extra element
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 01:52:45 +0000 (UTC)

--===============0001666948501514510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: don't hand out a linked element as extra element

TL;DR:
- htab_map_update_elem() fills the extra-elem slot before cancelling l_old's
  fields; a nested update may reuse it, so a live element's timer could be
  cancelled (not memory-unsafe)
- comment style nit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9d4791ee1741..923fec694747 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -1459,11 +1465,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	if (l_old) {
>  		hlist_nulls_del_rcu(&l_old->hash_node);
>  
> -		/* l_old has already been stashed in htab->extra_elems, cancel
> -		 * its reusable special fields before it is available for reuse.
> +		/* l_old replaces the extra element that alloc_htab_elem() took,
> +		 * cancel its reusable special fields before the next update on
> +		 * this cpu reuses it.
>  		 */

this isn't a bug, but this comment is rewritten completely and still keeps
its text on the opening line.  Could the opening /* go on its own line, as
is preferred in kernel/bpf/?

  /*
   * l_old replaces the extra element that alloc_htab_elem() took,
   * cancel its reusable special fields before the next update on
   * this cpu reuses it.
   */

> -		if (htab_is_prealloc(htab))
> +		if (htab_is_prealloc(htab)) {
> +			WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old);
>  			check_and_cancel_fields(htab, l_old);

The new comment says l_old's special fields are cancelled before the next
update on this cpu reuses it.  Is that what this code does?  The slot is
filled first and the fields are cancelled afterwards:

    WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old);
    check_and_cancel_fields(htab, l_old);

Can a nested update on this cpu run between these two calls?  That could be
an NMI (perf_event program), or an fentry program on bpf_obj_cancel_fields(),
which check_and_cancel_fields() calls after the slot is filled and which
tools/testing/selftests/bpf/progs/htab_update.c already attaches an updating
program to.

If that nested htab_map_update_elem() updates an existing key k2 in another
bucket, alloc_htab_elem() takes l_old from the slot.  copy_map_value() skips
the special fields, so the new element still carries the bpf_timer/bpf_wq/
task_work state of k1's replaced value.

The nested update then links l_old into k2's bucket.  When the outer update
resumes, check_and_cancel_fields(htab, l_old) runs:

    bpf_obj_free_timer() -> bpf_async_cancel_and_free()

on what is now k2's live element.

Timers are allowed in hash maps used by tracing/perf_event/fentry programs
(check_map_prog_compatibility() only restricts spin_lock and graph roots), so
this looks reachable.  In that window bpf_timer_init() on k2 returns -EBUSY
(__bpf_async_init() finds the stale async->cb), and any timer armed through
k2 is cancelled and freed right after.  This doesn't look memory-unsafe, and
it is narrower than before the patch, where the slot was filled in
alloc_htab_elem().

The order is also the reverse of free_htab_elem(), which cancels before
pcpu_freelist_push().  Would swapping the two statements (cancel first, then
WRITE_ONCE) make the comment true?  A nested update in that window would then
fail with -EBUSY, like the rest of the window this patch closes.

If the current order is intended, to keep the -EBUSY window short, should the
comment say that cancellation can happen after a nested reuse?

> +		}
>  	}
>  	htab_unlock_bucket(b, flags);
>  	if (l_old && !htab_is_prealloc(htab))


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38991548713
--===============0001666948501514510==--
