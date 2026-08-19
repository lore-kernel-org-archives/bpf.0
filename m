Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7325D53B
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121131; cv=none; b=sgFuPQ9mANmQ419c39pZnEYKbZTJQJBxk0RzLlfbc7cbL/lWK0g8y7QicNn62hk1mR7A1Mpu2glRTQvMFHWJ0mFTFA21VM1eUkfhV1GfzwhQ/IGM9tulsCc+XSLBzaXwURoQ0USR7ROb2sNYXX8hCpxFjto7jRRj5GLTz8i0pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121131; c=relaxed/simple;
	bh=o4sOGGSDXH+IAU3D5xRWAC4i9j+nbS4tiu1fU0JQhkc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d2fffo9TKZjcUYDd9AwGePtFra1jjDMKgAQ/j10ETsq8NBxzr9C6t4DnWYgTPfksdEW5C8dskF5aCDuVadhSk4FMM2rSXhNOnYmTVfcWtobPz0YEHEx9k7uR4GcTVO1w51sbiHrZ31eQlyQodiKIE+EmvffBGrRF5C6ZsDFoFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMG77wdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMG77wdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D761F000E9;
	Wed, 19 Aug 2026 06:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787121128;
	bh=5iurHarzhtiiQCLZ4Vjk7TVF+KaO7TbuC3JsNhX+N2Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CMG77wdERxC6123p/I0K45Wnsuv3pk4Vcpum/5cvZbjqjMYt/mVsU3UeqTlgQrm26
	 PV3ZLVQ25rh2+0m4GALA7E3wZ5rCQSxcTBSSQgd/C+SHnFWqstQWE1OSKa4QDG7HLV
	 +8sHEr6KTvkDETV+JuEnTVcADRQOGOr3e7zQLdJ0LNKE4+br6Azy8ycIQNaeqdw272
	 wwJn0DFi6W9gIf5xnC8OU9UoTPR4M6GiOQW5BwuzzbXYtFPP+tAzICvE7iDkJnWYLI
	 Lrcw/hphbr6fhI7eBe0aijBqXi4sB8RiNkFimH1JOmtVKYxf+pSIslh6QGa5YhyV+q
	 hEoi5kNmkRF1Q==
Content-Type: multipart/mixed; boundary="===============3835973985239891252=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c980dd5e462778928bef54067202b7861ff06e0e6abf6667d7cd8ee79f2431d8@mail.kernel.org>
In-Reply-To: <20260819055304.3296353-1-yonghong.song@linux.dev>
References: <20260819055304.3296353-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair returns in live register analysis
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 06:32:08 +0000 (UTC)

--===============3835973985239891252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Account R2 of register-pair returns in live register analysis
>
>     A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
>     struct/union or an __int128) reads R2 as well as R0, since the second half
>     of the return value is passed back in R2. compute_insn_live_regs() only
>     marked R0 used at exit, so a callee's R2 could be considered dead and
>     cleaned from checkpointed states, which would allow unsound state pruning.
>
>     Mark R2 as read at the BPF_EXIT of a subprogram that does return a register
>     pair. bpf_compute_live_registers() now loops over the subprograms and, for
>     each, over the [start, end) instruction range from env->subprog_info[], so
>     the return convention is queried once per subprogram through
>     bpf_ret_reg_pair() rather than once per instruction.
>
>     Marking R2 at every exit instead would be simpler, but R2 would then stay
>     live backwards across any call that is not followed by a write to R2, which
>     is nearly every program, and would needlessly hurt state pruning.
>
>     Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This commit fixes a bug where R2 was not marked as live at BPF_EXIT for
subprograms returning register pairs, which could allow unsound state
pruning. The bug was introduced when register-pair return support was
added. Should this include:

  Fixes: b176d222c14a ("bpf: Add helpers to describe the R0:R2 return register pair")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339
--===============3835973985239891252==--
