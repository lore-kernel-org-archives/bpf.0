Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063C46D2B0
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710273; cv=none; b=cuzZNSEA6inztzEN/JdQoApL8xYWD9lmy1cBl2/FDoxHA+0B5gQ6igY5eSTow5L4d7UCLZF+vPMinz4Ek8g28zDfL0B1IhhpsvQxzt8UvQ257nzw7JDPfgWOOYgie8ujVmkecZ0t/qDgB6gvn9Pj9YTAkC9sEKCY2u8xMCIB5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710273; c=relaxed/simple;
	bh=+xeY2/1rCqqqetRsmij32e38Hb2iqGsGIPRUIelxw3w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rD/cNTfWbPS+5YDIhibbRXLYQomEnYj7XqarAjdu3/Dk0G0HG5mY/IzZA3tI1aiq88wk8heJXXbkSCIOvlyQkDtpaUpHkLCb5vpzn/h4fopQcKCnToRmh+YuMJdS4x01dNHVCc9QQRHKvDWq6FSBkNBjOd0bnjsCJB63RZURUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOvEy0Us; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOvEy0Us"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE451F00898;
	Fri, 18 Sep 2026 05:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710272;
	bh=6iSZOAaeGtySRxDndzB0Cdqv7g7Qo+rjarVQCNCow0s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hOvEy0UsupO4PWHyVP/u+1fzpJN8muKcOMmLheha4QnziIPOZ+i8Cphck5u0tGJeM
	 8tQNf9qH661XdN2pFdyOr0PugUbwRPhakZEmVyzZb7M6GnCmjJI1UM3T5RnUjxL8yY
	 wwLmie3EgRs6A6+oJTGC3OwsE5HVaJRK42O2A/ilpXTUrP/ezh7bwqCfrkV5fqJpjm
	 814FIDSKCkpU3FpBn5lIcDgWSrptKGaa7dMFqUvwvpBDdo6lqzzArWvKMZTZN+gx1/
	 pnKaGhXY9ZwdJG4B7KddxoleVqt6cTtCoU3qqb0cIpP2kO6pBgdW+7bHFDvQJbCxXO
	 Xk+f4mHSAFoyw==
Content-Type: multipart/mixed; boundary="===============0795771299242599892=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef212951f3582678f582cf9d5664dcbd95377640aaf27eebdc53c86df81a7176@mail.kernel.org>
In-Reply-To: <20260918044228.3287877-1-yonghong.song@linux.dev>
References: <20260918044228.3287877-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 06/20] bpf: Explore the landing pads no call site reaches
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:31 +0000 (UTC)

--===============0795771299242599892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c93117f24a1a9cc39bfeaef79c42dbff02d8c455
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>     bpf: Explore the landing pads no call site reaches
>
>     A cleanup record need not cover a call an exception can unwind out of: a
>     frontend is free to emit a region around a helper or an ordinary kfunc,
>     both nounwind here. Nothing marks a call site then, and that record's
>     landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
>     refuse the program over code its own frontend had no way not to emit:
>
>        0: call bpf_preempt_disable
>        1: call bpf_preempt_enable      record = { begin = 1, end = 2, pad = 4 }
>        2: r0 = 0
>        3: exit
>        4: r1 = pads_ran ll             landing pad
>        6: r2 = *(u64 *)(r1 + 0)
>        7: r2 |= RAN_NOUNWIND_REC
>        8: *(u64 *)(r1 + 0) = r2
>        9: call bpf_unwind_resume
>       10: exit
>
>     The range [1,2) holds one call, and it is a kfunc, so an exception cannot
>     come out of it. cleanup_mark_call_sites() marks nothing, nothing pushes an
>     edge to 4, and 4 through 10 are reachable from nothing: "unreachable insn
>     4". The pad is dead, which is correct -- no exception can ever arrive at it
>     -- but the program is fine and has to load.
>
>     Walk every pad the table names that the edges did not reach, the way the
>     walk is already re-seeded at an exception callback. From there the pad is
>     code like any other: do_check() never enters it, because no call site
>     dispatches to it, so the dead code sweep removes it along with everything
>     else that was not reached.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for the earlier commit that made exception landing
pads reachable in the CFG. Should this include:

  Fixes: a67011bbbca1ba95 ("bpf: Make exception landing pads reachable in the CFG")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============0795771299242599892==--
