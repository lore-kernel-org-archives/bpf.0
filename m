Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5DB3B42E4
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772359; cv=none; b=Bj7QUIydAwwXL1TOKIKzd9r3H1MDEZOWcpj+xgDNG+wQlud7T65NNZPO5PGEy/ByU9vuUWyo5GaR5j+lBwrr6BrC3vjjXtjIpLf9ZygXIdVcrRFaqXCVbwUE/qHJi4phGxwBnLx5H99Dt3G7W/v4W/DI+ydTI28ja4GQ4ouA8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772359; c=relaxed/simple;
	bh=wQXN72M2T8vNM2OudJsqNhpdBRKnw/wNLVS++gCI1Jc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=of5NpnwpUQxDo69pHc0CuNKB5A3qA5BRb9hErY+LBcqIsX2rgOh7Qdoq2T1PJKE/1FXd53OEvIX7rw7Al6XT2vLgtI5QUQX3mzCLNju+99L0TMPzS6G7FMggSOLyefbcMcPAiBR1RH/f5BDgfEI8NBLr5bWVhTAFkbaXEenJ9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c88TsM+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c88TsM+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9165F1F000E9;
	Wed, 26 Aug 2026 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787772346;
	bh=SLyWBEiviXxEKn8frpX2lNnvlXoFQEoxxUE7J6x2dtY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c88TsM+uOMkgiOvBSzBOfaDIgHPPBSJL/lelnRnEbs4reEtpYnkNx8B7B971picbJ
	 0Ft6kYaBW5y7sh8ijN4FbiedHQo6nCVlEclbTSnojaTzFODrNYA5tEZ+uyss6sIJcc
	 lG3d0hrdVGgdWG/CSUhZ3WOmsrRDNn4tZ5p1fisrGPv1oZB5v+1O0kadfnnD8NhanQ
	 WllyQ/tnZFXJbZezJgnyGJZxHugX49kB0bTtkT8IeZUmzvoHh4m67pRl7Z+Tf/T4Wb
	 7yn50bQ9tDROLrKsytIQ4X0ZDfhBx4ag7G90ifCSpmMYanzHWzkS4tS51jlJqVQUQ5
	 Kn8zi/f+3+odg==
Content-Type: multipart/mixed; boundary="===============4676569019610338583=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b27c0abc1b21aba5d4238fd099ab998d673648786aab59b63c65aa7436bb6e1@mail.kernel.org>
In-Reply-To: <20260826-bug-029-bad-non-null-inference-v2-2-136789ace9e9@localhost>
References: <20260826-bug-029-bad-non-null-inference-v2-2-136789ace9e9@localhost>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,npc@anthropic.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:25:46 +0000 (UTC)

--===============4676569019610338583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
>
> A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
> PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
> A bug in check_cond_jmp_op() made such inference possible.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This looks like a test for a major verifier bug. Should this include:

  Fixes: befae75856ab ("bpf: propagate nullness information for reg to reg comparisons")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000653934
--===============4676569019610338583==--
