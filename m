Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC6451991
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123873; cv=none; b=l3ImGEzKYEMCDpkCWBMwoHTEspsiT8aEEAYx9ifg1quaOcbatVofYRL++pthnLkhLbVD1pWLnGIQtW3KsRs1iltj/BiGdFg2M4Twylsm0R73PuOz25klo9l8g+SbQPgc2dsF/2TMwFS0VygQH3b56vsDExWdQSCYw3E557QZlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123873; c=relaxed/simple;
	bh=r4bbBgNq/MxnXGJAvTerBmAxRUWRlSy1ULCPg4A/2sM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LK+sLliXQ9bSs3l8d/4d6az9/uUPa4RkXdu+TSM1vj1ZdOElJaaMnR9IUNgpkYA4nbI9yq/UvuI/Yw+s2KF5k7RT/MAIrFyiachStIpYqNnqdCsEeeVHKNE3oIBDbu100QHMfvHoA3fh2+ADwXEu4mo5rFVCRxyJU6J5m5Ub4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf4MPD3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf4MPD3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51141F000FF;
	Sun,  4 Oct 2026 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123871;
	bh=JFmip8lJzhxbJJ+j5peb7U5+orcjRSsF5O8uQO0QRrE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nf4MPD3AXqNJCSZBK/RCuLqPWP0ytxE2fgS3jdcwgWwVSz7+l4XNvTdTanFtru2bX
	 p4rqgQVI0l4T+xhze2+qtRd0U2elOkvvX7/QGCtNuVRu+fsOdf4KHouAv3FQNtYlPh
	 4S2lgwGnBMAoKAz1UxMY3cOkGK1Bii7GJ45rRThO30yGk9Qj1yd0xQ9ngMOuGZ1HKZ
	 H+5yrgOJEDCwhlKh5Fhk1I6e3OWV82cpMXwagn6ar9BrA8v5IackO6TjuEmHeIFF3+
	 a25f6/1DSzTu10WulUl9vajMy8HvnYQ5fMP9DgKz74aJHwijn1qzzH9JdDkriS7Ube
	 pqRddpTjZ09lg==
Content-Type: multipart/mixed; boundary="===============6928384519536254212=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1ebb373dd351915293e8d2de4d10256b7dda1f4fd1479473a746157ea7bb8b8@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-1-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-1-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/43] bpf: represent stack access effects with arg_access_info
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:30 +0000 (UTC)

--===============6928384519536254212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: represent stack access effects with arg_access_info

TL;DR: In record_stack_access(), the early return for multi-offset must_write
pointers may skip read marks when an access is also may_read. This only
matters in later intermediate commits, where stack slots could look dead to
pruning.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index cd9523f69298..7b317fb5ca82 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -1456,49 +1453,53 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,

[ ... ]

> +	if (info.may_read) {
>  		/* Mark any touched slot as use */
>  		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
> -		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
> -		return mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
> -	} else if (access_bytes < 0) {
> +		slot_lo = max_t(s32, (-fp_off - info.size) / STACK_SLOT_SZ, 0);
> +		err = mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
> +		if (err)
> +			return err;
> +	}
> +	if (info.must_write && info.size != U32_MAX) {

[ ... ]

> +/* Record access through a pointer with a known frame and possibly known offsets. */
> +static int record_stack_access(struct bpf_verifier_env *env,
> +			       struct func_instance *instance,
>  			       const struct arg_track *arg,
> -			       s64 access_bytes, u32 frame, u32 insn_idx)
> +			       struct arg_access_info info, u32 frame, u32 insn_idx)
>  {
>  	int i, err;
>  
> -	if (access_bytes == 0)
> +	if (!info.size)
>  		return 0;
>  	if (arg->off_cnt == 0) {
> -		if (access_bytes > 0 || access_bytes == S64_MIN)
> -			return mark_stack_read_all(env, instance, frame, insn_idx);
> +		if (info.may_read) {
> +			err = mark_stack_read_all(env, instance, frame, insn_idx);
> +			if (err)
> +				return err;
> +		}
>  		return 0;
>  	}
> -	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
> +	if (info.size != U32_MAX && info.must_write && arg->off_cnt != 1)
>  		/* multi-offset write cannot set stack_def */
>  		return 0;
                ^^^^

If an access has both may_read and must_write set, and the pointer has
multiple possible offsets, this early return fires before the loop that
calls record_stack_access_off().  Doesn't that mean no mark_stack_read()
happens for the slots the access reads?

record_stack_access_off() was written so that a read can be followed by a
write (the may_read branch now falls through to the must_write branch), but
this check only looks at must_write:

    if (info.size != U32_MAX && info.must_write && arg->off_cnt != 1)

At this commit every producer (record_load_store_access() and
stack_access_info()) sets may_read and must_write mutually exclusively, so
the condition behaves like the old 'access_bytes < 0 && off_cnt != 1' check.

It becomes reachable in a3aabad37761 ("bpf: describe helper stack accesses
with arg_access_info"), where func_arg_access_type() returns BPF_READ |
BPF_WRITE for MEM_WRITE without MEM_UNINIT, and
bpf_helper_stack_access_bytes() then sets both may_read = 1 and
must_write = 1.  Examples are dynptr args such as the newly MEM_WRITE
annotated ringbuf submit/discard dynptr args (even unprivileged), and
raw-mem args when allow_uninit_stack is set.  Before that commit those
accesses were plain positive-size reads, so for a multi-offset stack
pointer their read marks are lost in a3aabad37761 and ac317625edcb.  The
slots can then look dead to state pruning.

The later commit 92670b9a02df ("bpf: track may_write flags in liveness")
removes this early return and moves the off_cnt == 1 check into the
must_write branch of record_stack_access_off().

Could this patch drop the early return, or add '!info.may_read' to it, so
the intermediate commits a3aabad37761 and ac317625edcb do not lose read
marks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============6928384519536254212==--
