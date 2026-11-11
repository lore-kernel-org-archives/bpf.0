Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405891;
	b=XSyprWcCmgThRMp0mBM70p+CBuIhzTPE5hADGOJXjP5aPppIFrwuy2Fue2f5oI01R2rp
	 dcx8Fi0ikRQSRUeHortSMM4xjAdtfispSg11RdEv/LlfU4ai+Wl+c4LAdUGpgAySYa2aH
	 IUZyTwm20UWztIeiu2QFg+UjzRnpVC12EaNG1hjp0aMGztdFP27FagKlzE8ek+HiX5diN
	 yd6Nguo/id9+HyVxJiaxC1ze0jOLWt/dQHwq9vyfYDAFE0HBDzncr/K+/BgGhpmML/gNp
	 eN44pI/At2qCX8c7q2R+aezSEyfKmHr3rg3sJP4CQJbfhBTo2qVXaKMhHK+/dZyvCGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405891;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NBpx48/ofTLln6Bio9+r/GKZh+XxioF8/IMWZARj2mY=;
	b=lXqR27mUZiy4u9uZSNcOZRNo3LW/8e8/xjZSjRU7YtD5w/H4OA8EO4wLZpzntYEcqbqb
	 yv8C6g18UyPQhCmBKEZQjaUyd1IoKR7u0yaTBsHvHllqa8BHuCPQ5APg0BAZk6NQGwrmi
	 cCCmLshFunnnMgGs9A/zviOCTlEFgoclVQTzGIeptKgCZNOTTdiL3Vp1Ha63/Y6EZ2hh8
	 /H0CHdjuS9VUTuE4Jc1ZNkFAK/HUE0TjF+tNOc1nOYZmPZT9UeyIateTKc4K19ZR0Eymq
	 0lch7DxeVODc+J5fleAuTIgIWE3vd2cMZQljSl4cZ67mJOlmPDJNZCLyb7rLYu54H1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGBfMVyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA78606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGBfMVyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA841F00A07;
	Wed, 11 Nov 2026 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405891;
	bh=NBpx48/ofTLln6Bio9+r/GKZh+XxioF8/IMWZARj2mY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DGBfMVyknzyT6L4VfmVU9CtBYQP3WjwTN+pNNycuFsEhkEnMrwKXvzLniJzRYNonR
	 gdKZPV4R8tm029L98KuglPSoJ/eiF1jElbxJ1FHIIMWSRCrtZJgW6ageemt4uAyMoM
	 YBhLptUFgCVfUQagmCMAGTgqOiaO8XXJv4UiAWU8xpQaZUDqgRiBDhzMbueb4KNhHz
	 1v84ixu4K/n3q5bSe+SnZHYcZ7OYwWnEPpt8iy1tJw4fbULg/t3KT24FtLKpAU8CaW
	 kfOsdioU9jkWzKS0fcLiQdUMoiGVJ3yh3+lAPYJu0+NLrKwjzr66As6nGH4zwElH7r
	 4nVPgDZdlsCGw==
Content-Type: multipart/mixed; boundary="===============2514789805718188415=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <37568838812d9e2fd082f45454744ae493d4d97e83b9c55533e187ab4a6784d5@mail.kernel.org>
In-Reply-To: <579fd63756665e448169cef577835f8dbef30329.1794399387.git.memxor@gmail.com>
References: <579fd63756665e448169cef577835f8dbef30329.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 14/29] bpf: Describe held resources at throw sites
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:50 +0000 (UTC)

--===============2514789805718188415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Describe held resources at throw sites

TL;DR:
- s16 section counts may truncate with deep RCU nesting, so unwinding at
  bpf_throw() could skip bpf_rcu_read_unlock()
- Two acquisitions of one pointer may leak a reference at throw
- Per-subprog site tables sized for the whole program
- Commit message omits a relaxed rejection

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> +struct bpf_res_site {
> +	u32 insn;		/* the call, as the main pass named it */
> +	u32 visits;
> +	s16 sections[2];	/* the sections the frame is in, RCU and preemption */
> +	bool sections_vary[2];	/* the visits differ: the frame counts them in a slot */

Can the section count overflow sections[] here?  frame_sections() returns an
int derived from the u32 active_rcu_locks / active_preempt_locks, and
nothing bounds the nesting depth.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +	site = &env->res_sites[s];
> +	for (k = 0; k < ARRAY_SIZE(site->sections); k++) {
> +		int cnt = frame_sections(st, f, k);
> +
> +		if (!site->visits)
> +			site->sections[k] = cnt;
> +		else if (site->sections[k] != cnt)
> +			site->sections_vary[k] = true;
> +	}

Here the int is stored into an s16 on the first visit, and later visits are
compared against the truncated value.  Consider:

	for (i = 0; i < 40000; i++)
		bpf_rcu_read_lock();
	bpf_throw(0);

The throw site is visited once, so sections[0] becomes -25536 and
sections_vary stays false.  bpf_frame_desc_resolve() then reserves no
counter slot.

[ ... ]

> +		d->ent[d->nent++] = (struct bpf_frame_desc_entry) {
> +			.res = res, .count = site->sections[k], .flags = BPF_FRAME_ENT_COUNT,
> +		};

build_site() emits the truncated value in the s16 bpf_frame_desc_entry.count.
At run time bpf_unwind_release_desc() adds it to ctx->nr_sections[], so the
unwinder either hits WARN_ONCE for a negative count or, when the depth is
exactly 65536 (count truncates to 0 and build_site() skips the entry), calls
no bpf_rcu_read_unlock() at all.  The task then leaves the program with
rcu_read_lock_nesting still raised.

Before this patch the count lived in a 64-bit hidden slot read as
(s64)*loc, so the same program was unwound correctly.  The s16 fields are
unchanged at the end of the series.

Could site_visit() set sections_vary[k] when cnt does not fit in an s16, so
the counter slot is used, or should such a program be rejected?  Widening
sections[] and count would also work.

[ ... ]

> @@ -1030,13 +1245,19 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)

[ ... ]

>  	for (i = 0; i < env->res_rel_cnt; i++)
> -		items[n++] = (struct res_item) { new_of[env->res_rels[i].insn], i, ITEM_RELEASE,
> -						 env->res_rels[i].reg };
> +		if (env->res_acqs[env->res_rels[i].acq].slot)
> +			items[n++] = (struct res_item) { new_of[env->res_rels[i].insn], i, ITEM_RELEASE,
> +							 env->res_rels[i].reg };

Can this leak a reference when two acquisitions return the same pointer?
emit_release() clears the first slot whose value equals the released
handle, and relies on every acquisition released at the insn having a slot.
Now the release item is dropped for acquisitions without a slot, while
bpf_frame_desc_resolve() sets slot per acquisition.

	t1 = bpf_task_acquire(task);	/* A1 */
	t2 = bpf_task_acquire(task);	/* A2, same pointer as t1 */
	p = cond ? t1 : t2;		/* path 1: A1, path 2: A2 */
	bpf_task_release(p);		/* insn X */
	if (cond) { bpf_task_release(t2); return 0; }
	bpf_throw(0);			/* path 2: t1 held, only in a register */

A1 is held at the bpf_throw() site with no stack location, so A1.slot is
true.  A2 is never held at a site, so A2.slot is false.  At X only A1's
slot is checked.  On path 2 the verifier released A2, but at run time
R1 == t1 == A1's slot, so A1's slot is cleared.  bpf_unwind_release_desc()
skips an empty slot, and t1 is never dropped at bpf_throw().

Before the patch A2 had a slot too, so whichever equal slot was cleared, the
other still held the pointer.  The same can happen for any pair of
acquisitions that can return the same pointer, such as bpf_obj_new() and
bpf_refcount_acquire(), or two lookups of the same socket, and in the
opposite direction (A1 without a slot, A2 with one).

Should bpf_frame_desc_resolve() give a slot to every acquisition that shares
a release insn with an acquisition that has one, iterating to a fixpoint, or
should such programs be rejected?  The final version of the series still
filters release items by slot.

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2047,9 +2047,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)

[ ... ]

> +		func[i]->aux->frame_desc_sites = bpf_frame_desc_sites(env, i);

Is it intended that every subprog keeps a table sized for the whole
program?  bpf_frame_desc_sites() counts every site with a descriptor:

	for (i = 0; i < env->res_site_cnt; i++)
		n += !!env->res_sites[i].desc;
	...
	new_of = insns_of_pass(env, &orig_len);
	tab = kvzalloc(struct_size(tab, site, n), GFP_KERNEL_ACCOUNT);

but fills only the entries whose idx lies inside the subprog.  The table is
freed only when tab->cnt is 0, so each subprog with at least one site keeps
8 + 12 * n bytes, where n is the site count of the whole program.  That is
up to BPF_MAX_SUBPROGS times the memory the sites need, charged to the
loader's memcg for the life of the program.

insns_of_pass() also runs once per subprog, each time doing a kvcalloc() of
orig_len u32 and a pass over insn_aux_data, so load time grows as
O(subprog_cnt * prog_len).

The commit message says "each JITed function has a table of its sites".
Could the sites in [sub->start, (sub + 1)->start) be counted before the
allocation, and new_of built once in jit_subprogs()?  The function is
unchanged at the end of the series.

> bpf: Describe held resources at throw sites
>
>     [ ... ]
>     The rejections for a program that throws do not change, with one
>     exception: an instruction that acquires a resource only on some paths is
>     rejected only if the resource needs a hidden slot.

Is this statement complete?  bpf_frame_desc_emit() rejects a call that
acquires a resource and is followed by an unwind_goto only when 'after' is
non-zero:

	if (after && idx + 1 < len && bpf_is_unwind_goto(&env->prog->insnsi[idx + 1])) {
		verbose(env, "frame_desc: the call at insn %d acquires a resource and may unwind, ...

'after' now counts only ITEM_ACQUIRE items of acquisitions with a slot.
Before this patch, a call to a static subprog that returns a reference and
is followed by an unwind_goto was always rejected.  Now it is accepted when
the acquisition needs no hidden slot.  The relaxation looks consistent with
the comment in the code, but the commit message names only the
acquires_sometimes() rejection as changed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============2514789805718188415==--
