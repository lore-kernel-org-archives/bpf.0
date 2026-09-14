Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F474052A9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427730; cv=none; b=qN28zJwEf69sGNmijAR1GIsRukDM9t+GRdzYBGrKUIfI1Zv77ndmAR2TNCRJDEQLVckgEb0KWHmsSas7gI8bukSsDL5uGTD9VuCq2AkyvJBQ2gWrw3KdGqDhwWx6wtGEgvZ6UFX2+QXGsR+8YRDbSsz9BACIu1pIDafN+D6vLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427730; c=relaxed/simple;
	bh=M46B9J+RzQUsksCrGF89Ei7Z2S/w+deh6Q5tuiJp7+E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Tar9UD07A+MihTFlKSxLJJfOceZk30j1tKyvy/rk6raoZufkbMuZZZEB/g/y9DX5CRGO6u29lUkAqz22og8LJAKJpMcpwIS2BRLCFLs8o6tgUSY81+cPI2QutFQactk3rvIB0LnrVKbDRio+nXfZpanal0eqWVFX63oeZscReeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxMh3wrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxMh3wrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB11F000FF;
	Mon, 14 Sep 2026 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427728;
	bh=YXd0yKzMaQFlU4bh+EeoxGICvXL2aN5Z4q7e/SM/uds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GxMh3wrW49BqaQZEc9etTMF5Tn5xCMBwzlyxa9v4CxkZJNw8loqSaZ5jRFQsr8AhO
	 vs1fHg3ZqAtfgUBF/R4PLCDYjQC8LntMYOOy5YuAMmj61D9N+cmAJNqVWI/Z1D7WP7
	 huKOyyNnSgMYnOT1V9rGvO9SBhAz+n1zQ/9eaLb8RZHk1sNudGVdhIa67Wvi7faPjS
	 UAa2ICbNp999kSkFXeCX+F39wLpFXC1tkL2hTamk+KcMp8F+Z+nsnbZ3pagpig8NVe
	 KAHJEW0cxuRV5741ctNSUPH+35rcM0uHZw10cGPb0Lgp/Ilg01rrHsQEUIcL7Wbhpb
	 dCDJcmsBKBhxA==
Content-Type: multipart/mixed; boundary="===============8112887068178944291=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <065f20ddc6058fdd974878917d9ecbc2cc2f2066852e8bfce0d19de7e66d5ef7@mail.kernel.org>
In-Reply-To: <20260914222514.1635018-5-memxor@gmail.com>
References: <20260914222514.1635018-5-memxor@gmail.com>
Subject: Re: [PATCH bpf v4 04/11] bpf: Apply CO-RE relocations before subprogram validation
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 23:15:27 +0000 (UTC)

--===============8112887068178944291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> check_subprogs() verifies that each subprogram ends in an exit or an
> unconditional jump before in-kernel CO-RE relocations are applied. An
> unresolved relocation can then replace that terminal instruction with an
> invalid helper call. The resulting fall-through into another subprogram
> breaks the CFG invariant used by postorder and stack liveness analysis,
> which can write past their per-subprogram arrays.
>
> Apply CO-RE relocations immediately after preparing the program BTF, before
> subprogram discovery and validation. Keep func_info and line_info validation
> after subprogram discovery because those records depend on the complete
> subprogram layout.
>
> Include core_relo_cnt when deciding whether to prepare program BTF. A load
> that supplied only CO-RE relocation metadata previously skipped both BTF
> setup and relocation processing.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for CO-RE relocation ordering. Should this
include:

  Fixes: fbd94c7afcf9 ("bpf: Pass a set of bpf_core_relo-s to prog_load command.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34904671165
--===============8112887068178944291==--
