Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AFC3BFAD3;
	Mon, 15 Jun 2026 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513335; cv=none; b=JVWwvzxQA0Qsnbc5jXGdUg16al2PMw3kxh5B01jVgos/d1IkReneS3/pv8sE16MdyYzPoBgRiA6bKuFZQUXWOEXYU+3i+R7FxqWPpuMPRLUdvsWkY4ghzOKqvW3VTzh7Rsd6Kbi4tAQrd/oEUrpzqfURJV+zZf0g8ZwoRICwDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513335; c=relaxed/simple;
	bh=/j3NBrlTLaudkDSka2M6EE293V8ehR6UrpETXseRjuE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W3PJbqkxViwqwXtbnJv0XotZzhuivyC2D3aZH0SGCHcGBzAQi1HE17u4+hyW6Q2bCh9zDnlpQGbAqCUf2lskzzj3DEeXLvrgJ7StLe3a0BAZpasatc4kdgl6k+gMF+WbtXb3N2KiO38AFPGqSHiUFZJf9XtFsFpt9SwoAt/N/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJhripag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJhripag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3521F00A3A;
	Mon, 15 Jun 2026 08:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513329;
	bh=aKn5TMpsqQkbVXFHdW1ResVJ/Nc5/kBI3zl/0q/Cats=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DJhripag3BhQHwhamRVbVYmW1D2agvg3BNkocUj80oXa3b9OsOAjhNNm9WsmWKF7W
	 biTYVf3joD+3GR2QV5Uq+SeSDMA58B72ktdPgHnW1OVPPswRBln+rXHqq1rXHqN+BX
	 7p9dooKtGilKboynbHVWVd2aZKQhJ5t01c/2CicjR3r4PpkrlmOegpQtroexeHtMWp
	 99GJI7q0RPks17VzSH63w8ncAwKvaNfTJ6t9QPPZx605mjCcYB2j2ANNvsHaJ30ODO
	 ZUJkIC0OjV2jfaB4kkdHGX9yCPa6OfQTEhi/iYHoD/bNqCr1dvKGFfFs8gIJnrO3O2
	 1NGPwdQhIZEjQ==
Content-Type: multipart/mixed; boundary="===============5023186984400448720=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba187060a5a8232b69cbd080223bd36f806556fc877c07f470b938870b9e4a05@mail.kernel.org>
In-Reply-To: <20260615-f01-06-half-slot-pointer-spill-v1-1-47f1c18a8965@mails.tsinghua.edu.cn>
References: <20260615-f01-06-half-slot-pointer-spill-v1-1-47f1c18a8965@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve pointer spill metadata during half-slot cleanup
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Jun 2026 08:48:49 +0000 (UTC)

--===============5023186984400448720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Preserve pointer spill metadata during half-slot cleanup
>
>     __clean_func_state() cleans dead stack slots in 4-byte halves. When the
>     high half of a STACK_SPILL slot is dead and the low half remains live,
>     cleanup converts the live low half to STACK_MISC or STACK_ZERO and clears
>     the saved spilled_ptr metadata.
>
>     That conversion is safe only for scalar spills. For a pointer spill, this
>     metadata clear lets a later 32-bit fill from the still-live half avoid the
>     normal non-scalar register-fill check and be treated as an ordinary scalar
>     stack read.
>
>     Leave non-scalar spill slots intact in this half-live shape. This is
>     conservative for pruning and preserves the existing
>     check_stack_read_fixed_off() rejection path for partial fills from pointer
>     spills.
>
>     Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
>     Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Is the Fixes: tag pointing at the right commit?

The commit referenced, 2cb27158adb3 ("bpf: poison dead stack slots"), adds
STACK_POISON handling in kernel/bpf/verifier.c and does not contain the
half-slot cleanup logic being corrected here.

The 4-byte half-slot cleanup in __clean_func_state() that downgrades a
still-live STACK_SPILL low half to STACK_MISC/STACK_ZERO and clears the
saved spilled_ptr metadata without checking for SCALAR_VALUE was introduced
by be23266b4a08 ("bpf: 4-byte precise clean_verifier_state"). That commit
added the lo_live/hi_live model and the exact block this patch corrects:

	if (lo_live && stype == STACK_SPILL) {

be23266b4a08 predates both 2cb27158adb3 and this fix. Should the tag be:

  Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27533304560
--===============5023186984400448720==--
