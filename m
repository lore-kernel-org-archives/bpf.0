Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705C4AF175
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271537; cv=none; b=Xu7Gr5i0zH1aali3zTkDo6+5JAO6FdYmhfnqEFSvRUNEJVj6+FR0Y8J8Sn6ihoZvVnV3wYGxK5AqXn+yf4fr+bonJqmOk6Sxa5xtc84aato2AoENc2YjiuA6fMrfM/Rqcj7LQyOYfSQYwgkVFYWUs1kB3nJ4IvvcMGOkkJpP8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271537; c=relaxed/simple;
	bh=jL1Zn7oGmT9UIX9HvAjLpRNAlqN3FzC+52/25OUT5w4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hJU5wex3zKxYEafE78KxGyTh+39hK8f/WxTIZ9TySwzFpO9L+MQJamIdlTZjsknlDWXyyWmaFnsJoE2dwy1GQFsrwWzvAZHVD30A9E9HROwTTeP8pOmNuJVikhwZuYft1lTIBlm+PSKews8Ar2S6jSNNsQINWqx7NUw7MO/+d9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+kp+bpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+kp+bpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A031F00893;
	Thu, 24 Sep 2026 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271535;
	bh=aUpJzZXRsyh8X7iMWt+oY5+bsWj+o/aejCJ19jQuMhA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=h+kp+bpRxpTWYPdLKUB8pZhfop9sYMhqk3Ybgk33z6QvjbF36ruw5RyFEMwMti901
	 x7Tk+nqVI8pe5dkXGakNsXY+JJb83Y5SxCY2K5weM/2+twWO8BLHJIRpNw3K0rIA6M
	 4NzE5KDVwkjCvQxyAk73kV/MVrah0nuUGRTtZZTA4fN05V8wO5DYf3yYuEbGaAfBfh
	 fTAnSjF0G2HJeiMNzJekKppq5zzQH+xu0aGsZDXs5L/TLFzxm7qpNjFKlq+Tw9Nb7T
	 B/dbMM8tKT6SqXi3Ef1EBzJ5mJ/iafQhtJpcfLIyaEDtbUTG7KicMdZH8/wQwNsydN
	 R6V4uhj/ighUQ==
Content-Type: multipart/mixed; boundary="===============1142546263766202448=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8db5bd81a1abb7cedd563257f5431fc2e90762ea213978ac846d1574672c24b7@mail.kernel.org>
In-Reply-To: <20260924165740.2146806-9-memxor@gmail.com>
References: <20260924165740.2146806-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/18] bpf: Grow the verifier id scratch on demand
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 17:38:54 +0000 (UTC)

--===============1142546263766202448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The id map used to compare the ids of two states, which also serves as
> the id stack of release_reference() and as the id set of
> bpf_clear_singular_ids(), is a fixed array embedded in struct
> bpf_verifier_env and sized for the most registers and stack slots a
> state can possibly hold: 1312 entries, 10 KiB, for 512-byte frames, and
> four times that once frames may reach 2 KiB, which pushes the env
> allocation from 64 KiB to 128 KiB for every program verified. States
> compare a few dozen ids in practice.
>
> Turn the map and the set into arrays grown on demand, starting at 64
> entries and doubling, and free them with the env. A map that cannot
> grow treats the states as different, an id set that cannot grow keeps
> every id of the state, since its counts are then incomplete, and the id
> stack reports -ENOMEM, which release_reference()
> hands to its callers. The iterator destroy path used to warn on any
> failure of release_reference(), which could only come from a bug while
> the id stack could not run out of room; it now returns -ENOMEM and
> keeps warning about anything else. An allocation failure thus fails
> the load and is never unsafe. This removes the last structure whose
> size scaled with the stack bound and shrinks the env by 10 KiB.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The commit message says this patch "removes the last structure whose
size scaled with the stack bound", but struct bpf_verifier_env still
contains stack-bound-sized members in the same header file:

include/linux/bpf_verifier.h (struct backtrack_state, embedded as env->bt):

    unsigned long stack_masks[MAX_CALL_FRAMES][BITS_TO_LONGS(MAX_BPF_STACK_SLOTS)];

include/linux/bpf_verifier.h:

    DECLARE_BITMAP(scratched_stack_slots, MAX_BPF_STACK_SLOTS);

tmp_str_buf[TMP_STR_BUF_LEN] is also sized for the full stack mask
string representation.

The next patch in the series, fd50b14aca8a ("bpf: Size the per-frame
verifier structures for a 2 KiB stack"), says the same thing in its
commit message: "The verifier keeps a few structures whose size
follows the deepest frame a program may have: the backtracking and
scratched-slot bitmaps, the jump history slot index and the clamp of
the liveness masks". It then grows those bitmaps from one to four
words per frame and tmp_str_buf from 320 to 1408 bytes.

Should the sentence say this removes the last *large* structure that
scales with the stack bound, or say it is the last one sized by frames
times slots, to match what the next patch describes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36032786938
--===============1142546263766202448==--
