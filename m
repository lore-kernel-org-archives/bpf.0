Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6883ACF0A
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540830; cv=none; b=kZbqfnoVCYgeSMqDjLwTHLmJGa6uDT1HYfaQ3DK5O8XChjSXLGBAsFWlZ2TBqrNPJH8kWeywZ+yTIrJr2RcmJhLSQzZVe10Ys7o5BfGVTLEjwbqELRQB80fknpZNqp6bC5aq896t2ciIS2uslwGbHNWNQ5IxWIKXGICpHPtfRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540830; c=relaxed/simple;
	bh=8qlS1Y4+H3ID1hGARo20RjDMtjKK2JmxhfSeTxP2KR4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YoLgANPvLb4u9r7pBKLD8ptwnrEDlTrCc4bfQy5dNx5Rsh16bGiYWv1hKo034FXrw24hMVa+2QEr3sQ0R5K/ODxff8tk5AJfU5erhrgJEtRqW8taBPG4rpMEipkWNBl6VOHOPKgw4WJRcilB51CoVwQWa4i52gikGCIGXQRu9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK4Hm911; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK4Hm911"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0AF1F000FF;
	Sun, 27 Sep 2026 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540828;
	bh=kaxOoFLVDKSGLNbtvZW9DTg/h6o19S/covvTq1O+230=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NK4Hm911lzHJEotpIXPQB4eNU2tAeZUVdEYZgxJbjUNGiiPZ8bx+x8aS5+1GUCpFR
	 RmMnp1YWBBM8PZrZwW9gZfmiks1eHnUM2pPrkjg2CPFiQE7fG+/ZU5YSwOqKkomDpm
	 EIwe87optlnBd45h2+uTAfOwBlbt5iP5r1L8/FGnYWxm7FXZjnVa7NTNvAGlxQSFvQ
	 5Wsx3DNqR4iBv6n93ScYIV+j00ghD50lV0xAxDT7CwEJlUcH2bJ0GE3bMFSTio8hi2
	 zz77XmUMdhOL59WH6gQLTPAKUXrC87y9DbJv8RQlwQRxrtmfs6Ii8wgsOMgL61uqP+
	 M9OJtZMnj31jA==
Content-Type: multipart/mixed; boundary="===============7238571734903595315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2dd22c28c9377610b3471eba2f88253146a2af847c30aeee6f5f86f5f2183f64@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-5-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-5-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 05/36] bpf: record write effects for atomic operations in liveness.c
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:27:08 +0000 (UTC)

--===============7238571734903595315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: record write effects for atomic operations in liveness.c
>
> Atomic read-modify-write instructions are recorded as reads only,
> omitting their stack write effects from the may_write masks needed
> by SCEV.
>
> Record both read and write accesses for atomic RMW operations. Keep
> LOAD_ACQ read-only and STORE_REL write-only. Share the precise/imprecise
> stack-access dispatch so both accesses use the same address handling.
>
> Fixes: fed53dbcdb61 ("bpf: record arg tracking results in bpf_liveness masks")

Does the Fixes: tag point at the right commit?

The commit message says the bug is that atomic RMW write effects are
missing from "the may_write masks needed by SCEV". Those masks
(FM_MAY_WRITE, mark_stack_may_write(), mark_stack_may_write_all()) do not
exist in fed53dbcdb61:

    $ git show fed53dbcdb61:kernel/bpf/liveness.c | grep -c may_write
    0

They were added by 2d21f2c85cb4 ("bpf: track may_write flags in
liveness"), which is four commits earlier in this same series.

In fed53dbcdb61 and in the pre-series base, the only write effect was
must_write. Liveness uses it only as:

    live_before = (live_after & ~must_write) | may_read

in update_insn(), and the must_write_acc transfer in fed53dbcdb61.

For an RMW recorded as a read, the half-slots a write would fully cover
are a subset of the half-slots the read touches at the same instruction:

    [ceil((F-n)/4), F/4-1] is contained in [floor((F-n)/4), (F-1)/4]

So leaving out the def never changed live_before; it was only more
conservative. fed53dbcdb61 therefore has no observable bug that this patch
fixes.

The actual omission was introduced by 2d21f2c85cb4. As written, the tag
would steer stable/AUTOSEL tooling to trees that contain fed53dbcdb61 but
not the may_write infrastructure. The patch would not apply there
(record_imprecise() has a different signature and mark_stack_may_write()
is missing), and it would change nothing there anyway.

Since the culprit is part of the same unmerged series, the usual fix is to
fold this change into 2d21f2c85cb4, or to drop the tag or point it at
2d21f2c85cb4 if the two land separately.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============7238571734903595315==--
