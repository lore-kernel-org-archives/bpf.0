Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6EE2E2852
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847241; cv=none; b=EKrnU79rkPFx4AyGUoehj63veifd/ZHT9jbJXIBx8PPi5AQdnw8j7Ki5UWo9P9DvqiVf5kYeccXN6RE8JwG19IXReHV416jezuRivPOJ8tfgwOuSUBLcB2K97sOg58h18V3dylwZZFInIxf7u8uLoFRL9YR3DYjvECcz/YKkCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847241; c=relaxed/simple;
	bh=euZnU2uAyqr3i6yt5Vye0TONijkEj1TwPAHMjTJDlK8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RDkKDR9ScYp6qIvPUZ223RPOkV42wWghDmxTQ5MDYtYda3GLJHWb4BXddcjVVqhtpB1/fgvdwv9W2YNK87NoVGUvOMFV5lxE8vLSbHwGjkE/r0elFT/iTW6fLpxjtDzTEFCAFNpJAHOSG6gFVXv51+htdQfmvQOvB9nfiwugmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iViuP58B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iViuP58B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9559B1F000E9;
	Thu, 23 Jul 2026 22:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847239;
	bh=lKTlJqCk8zpsHE0f8004z2K8yojojKpT/NEfW0IGUkc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iViuP58B1A2cXghCLgAw0Y33p72kUCYQsLTUu0SUhfEhq15Jh48lKvZd8tyLjomPk
	 /R36BXbcW6fj1pcb79iA0PUxYrg9/m04BB2pMerv0WkEay5R9OIcFnax7grg5IM1CY
	 DNHlXIMF9Bci6gAvQXOTo6iY+B7SNNCVnLSIhoD68BwwgCDKa4+K3XNOdmpxKEXVek
	 BlxsJXGrC1rBY+SE4lE/Uw0djzk+iFMf80hKqqccgV21f/QPOAh2gXI41oARlG/rCx
	 yoK2sIvcx5ObbaV+pN0doIGxmGNabfXBPYYPtza3+tipErekBg2OTrNnf7tgZRTf8Y
	 vbpf7h2v/yD0A==
Content-Type: multipart/mixed; boundary="===============0771915449981994702=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f35ddbcb866c43c10359ea0797bd8f8e7ad2a667613bb1b2356b4dd07f26d3e@mail.kernel.org>
In-Reply-To: <20260723055508.1403247-1-tao1.yu@intel.com>
References: <20260723055508.1403247-1-tao1.yu@intel.com>
Subject: Re: [PATCH] bpf: normalize arg_track state construction
From: bot+bpf-ci@kernel.org
To: tao1.yu@intel.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,tao1.yu@intel.com,syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 22:53:58 +0000 (UTC)

--===============0771915449981994702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 0aadfbae0acc..58b979c17c3e 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

The commit message states:

>     The bug is caused by ad-hoc state downgrades and partial state
>     construction. Some paths only updated selected fields, such as switching
>     to offset-imprecise by writing off_cnt = 0, or building temporary
>     arg_track values by filling fields manually. Later joins then copied and
>     merged these values and KMSAN could observe uninitialized union content
>     when the state was interpreted through a different union member.

Can you clarify the root cause mechanism? While in-place off_cnt=0 downgrades
exist in the parent code at arg_track_alu64, arg_padd, arg_track_xfer, and
record_load_store_access, each operates on arg_track values whose union
already holds defined data:

- at_in[] and at_stack_in[] are fully initialized to 'unvisited' via compound
  literal { .frame = ARG_UNVISITED } which zero-initializes the union

- at_out[] is memcpy'd from at_in[i]

- Every explicit constructor ({ .frame = X }, arg_single with '= {}',
  arg_merge_offsets, arg_join_imprecise) zero-initializes or fully writes
  the union

A concrete code path where an in-place off_cnt=0 downgrade leaves the union
with undefined bytes that subsequently reach the crash site 'm |= a.mask' in
__arg_track_join could not be verified. The .mask is only read when
frame==ARG_IMPRECISE, and every producer of ARG_IMPRECISE explicitly sets
.mask.

So while the described in-place edit code paths exist, their causal link to
the reported crash remains unproven.


The commit message also states:

>     ...or building temporary arg_track values by filling fields manually.
>     Later joins then copied and merged these values and KMSAN could observe
>     uninitialized union content when the state was interpreted through a
>     different union member.

The clearest manually-filled temporary is 'resolved' in
record_load_store_access. The parent code sets resolved.off_cnt,
resolved.frame, and resolved.off[0..off_cnt-1], leaving
resolved.off[off_cnt..3] genuinely uninitialized. This is a real latent
uninit. However:

- 'resolved' is a function-local that is only passed to record_stack_access()
  and record_imprecise(), never to __arg_track_join()

- record_stack_access() reads only off[0..off_cnt-1]

- resolved.frame is always >= 0 in that block (guarded by ptr->off_cnt > 0),
  so the ARG_IMPRECISE/.mask branch is never taken for it

Therefore 'resolved' cannot be the value that reaches the reported crash
'm |= a.mask'. The causal story ('later joins then copied and merged these
values') is not demonstrated for any manually-built temporary reaching
__arg_track_join with an undefined .mask.

Could the commit message be more precise about the proven initialization
issue the patch addresses, rather than an unverified copy-of-uninitialized-
union narrative?

The exact mechanism producing the reported uninit read may be a clang-21
by-value struct-copy or union-shadow codegen detail rather than the described
field-update logic. The fix likely eliminates the KMSAN warning by zeroing
unions in the whole-object assignments (a defensive normalization that quiets
the tool), which is a valid improvement for code robustness.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29984640227
--===============0771915449981994702==--
