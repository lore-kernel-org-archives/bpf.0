Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5B3AEF3F
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643179; cv=none; b=EnoDYXJxhnsKotW0NofQYH47EvYK/R+5N5z0tqNy9dONfQiJYYXJrBwx9GD5S68wX+61bqZ3WxVP7jBAsLKzSXb0Xk8FM/5vdEifA6PJyNGOX1Jg5/4cAtpq5BYbu4S3wkmh5yK9Cq3jhi58yCrsi0Oyf8P0saXIr7KdL2uojEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643179; c=relaxed/simple;
	bh=HZSquLerUtcIUXUAJG65yiJPqyn5hK7VwY3cVrUuAgM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t7HqRewKAQDA5HdcGvu3a5Q59vjCezTZOY6DYuYJT/tPyIqoDcB1KlFbw1bDu+euKiRduaTgfcTpgnx4M1wFxnN6iYr3FIjr7ZGeUOaXBNKohyx9kpPTJJVBKoQ40vmD10m/kkKTHNRgtM0S4Gbvluf7B4+hqbQRt6U7CY1qiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtYYvf6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtYYvf6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389271F00898;
	Tue, 29 Sep 2026 00:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643176;
	bh=HZSquLerUtcIUXUAJG65yiJPqyn5hK7VwY3cVrUuAgM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BtYYvf6CHKyJRXccJPfc2SDgLGeNEg7pMdbVxvT1va6yAgFZh7lxsVw9Ht4dUK//d
	 9y69n6mtSpsC+WWEJ5Wt7zZIlN4+5K+UGg0z0Ac8CWq/cbgC/E/XtTKFaRIzE+Aq1F
	 QhNEv7uTRtYN+v/zFFxHnKRQYMl5QsCt71VeD3jhejd6qTuHkoqclIPn05nib3sd5K
	 0tu4ShGfsfeb1SuKihI5sdF96SroFlPafIC96nfh/e/N2lk1gO8ByPIOeiv4Lk2wzB
	 Rur/bqRxFJoRHBSDWfw6vXYaJwegUlPbyOjXis2d4FjcFP6Iv9loHf9nees1VqGpPv
	 CjQG5TcwUi6dA==
Content-Type: multipart/mixed; boundary="===============7009766640216881979=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d45bfa94899a2626f053f2c0fd517a074a422d796ed64389a9033c9512efd7b@mail.kernel.org>
In-Reply-To: <20260929001643.3249386-1-yonghong.song@linux.dev>
References: <20260929001643.3249386-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 08/22] bpf: Require an unwind to leave a frame holding what it entered with
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 00:52:56 +0000 (UTC)

--===============7009766640216881979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A landing pad's entry state is the state at the call it belongs to, taken
> before the callee ran -- push_cleanup_pad_branch() snapshots it there. That
> is right for the frame's own registers and stack, which the callee's
> epilogue puts back, and wrong for what the program shares: nothing restores
> the locks in bpf_verifier_state.

Is the claim about the callee's epilogue restoring the caller's stack
accurate?

Looking at the BPF calling convention, the callee's epilogue only restores
r6-r9 and the frame pointer. It does not restore the caller's BPF stack
slots. A callee that receives a PTR_TO_STACK into the caller's frame can
write that stack freely, and those writes are not restored on return.

For example, if the caller spills a map value pointer to fp-8 and calls
foo(fp-8) under a landing pad, foo can store an arbitrary scalar to
*(u64 *)(r1 + 0) and then call bpf_unwind(). The caller's pad would be
verified from the pre-call snapshot where fp-8 still holds the spilled
map value pointer, but at run time the pad would load the
attacker-controlled scalar.

The same issue applies to any stack slot type change that the callee makes
before unwinding, such as spilled pointers overwritten by stack writes, or
dynptr and iterator slots clobbered by the callee.

Should the commit message clarify what the epilogue actually restores?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904
--===============7009766640216881979==--
