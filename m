Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A633B9DB3
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651491; cv=none; b=hEr/B8PkPydo6w+T0UEjYHr3jD2O2eMpCVL8Fo6BGSii39t9f2klF08f7CY5OhLefl/mWj7/BPAO+BQDMlFxRs7CNEWP6E61Jo46vW3K5UhPdz3S9aImUvXzp0oWYcZ+bQv3suzQO2KQDtItOBRNV7iFPeXSdMs4VkyQZkBezpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651491; c=relaxed/simple;
	bh=hNqD4szK4/709Q7dYrvV3LVqlIFgYfwDJ0bDK3V8J8M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=je+DCbPkpe84YZqCrahQ+1JFjosy6vx9IidJJT4Q/4S1cf1rRwgPemw1oJbNrd4DHQZu5Tl7FBTnA83ouqfNK5g7azM5rZrqZmMxMRPLcnSFT4M2gNx/QABGe/1sFeyf8LH5UG1qWWc3wyIyDz1TQQk7R/FpWF7sLCSmpWtuXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ+J6WBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ+J6WBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A7F1F000E9;
	Thu, 13 Aug 2026 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786651489;
	bh=hNqD4szK4/709Q7dYrvV3LVqlIFgYfwDJ0bDK3V8J8M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NQ+J6WBkOUzXB/3McLBO6Hg7YMsCbKxBuRS16AE90siyZ4hI8aGOKnJN9aCN0SH/s
	 GGhq3NqP5PmbHVRfYUA4yBcjRvs0uZju/CANxnqZEYGEsALRCAQY13iQlrtZ9iw8g+
	 H7Ury5qoQYF9LhAfq761+IeXhWQRmrrBYE56XzibHwxYcc1HxEtomTVkrXVI65CJ7y
	 ZJO9c11wIgCfalW8RUmnOiVdbLVifaGVMqJfGaikrlG2hJnTEKy6Grew+juM+PsNR8
	 IIv6nvhY52u/O6W/CKevoCbb8jgtuNsoHLHLvUzE0NMM3nO0o8PuLKck79pF1PnylS
	 gr5EXwmj7xBdg==
Content-Type: multipart/mixed; boundary="===============8125350571433241624=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7eb669da98fa166c2e6ae76c1fe7c830168cb30c858d8c7aabe02ddab532f231@mail.kernel.org>
In-Reply-To: <20260813190356.335181-2-puranjay@kernel.org>
References: <20260813190356.335181-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/7] bpf, arm64: Fix stack-passed arguments for indirect trampolines
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,xukuohai@huaweicloud.com,mark.rutland@arm.com,will@kernel.org,catalin.marinas@arm.com,xukuohai@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 20:04:48 +0000 (UTC)

--===============8125350571433241624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Fix stack-passed arguments for indirect trampolines
>
> save_args() reads stack-passed arguments relative to FP assuming the
> trampoline is entered through the fentry call from a traced function, in
> which case both the parent frame (FP/x9) and the traced function frame
> (FP/LR) are saved before FP is set, so the arguments start at FP + 32.
>
> An indirect trampoline for a struct_ops callback is entered through a
> function pointer (blr), so only the FP/LR frame is pushed and the
> arguments start at FP + 16, not FP + 32. Every stack-passed argument of
> a struct_ops callback with more than eight argument slots is read two
> slots off.
>
> This went unnoticed because no struct_ops member passed arguments on the
> stack until bpf_testmod_ops3::test_arena_stack, added by
> commit 2d4de9a493a0 ("selftests/bpf: Test stack-passed struct_ops arena arguments").
> That member covers this on arm64 once the JIT gains arena argument
> support later in this series. Pass is_struct_ops into save_args() and
> pick the offset accordingly, mirroring the x86 fix.

Which x86 fix does this mirror? The commit message would be clearer with
a reference to the specific commit. For example, if this mirrors commit
473e3150e30a ("bpf, x86: Fix stack-passed arguments for indirect
trampolines"), citing it would help reviewers understand the cross-arch
consistency.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31735324691
--===============8125350571433241624==--
