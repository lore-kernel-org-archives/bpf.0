Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AB311956
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532000; cv=none; b=Z3FLYoJ7jD7z9ndCojzzdEVK60By7MTvyMtyqqfHAw582GNbNtcOJlzVQYC3+1Gqi+qPJnH2t/OaUP1tYuH000iYMEZb1bEpVl+P4iVzKaFg77P48mNHb293cVfG6B3hD+HOwsliPtWV6hNrj9ZZ2T1kIG57/pmQWbGmS9yDgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532000; c=relaxed/simple;
	bh=1e5NP/9hnSW9lRhzRdd69jMk+QmFHuqNYaZDr+lXHS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XaPpp+Px2V7ZscjUsWnTNe85994VnFb4piNgGIsGkpkOR7B0aypzSmsoLl8VKax8LYkOlM3PK36C/c6arHK4D8Eb3tJdUdl/KkB9HnoZumsxFo/Wfq94wP1VlbnbrRc/Uu4Fcpx8raJ62S1TbprRvypHCDkeE+tsxEpkMf8Ap0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG25QHuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG25QHuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67303C19424;
	Sat, 18 Apr 2026 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776531999;
	bh=1e5NP/9hnSW9lRhzRdd69jMk+QmFHuqNYaZDr+lXHS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PG25QHuLK9zevxMZMyqTn9NVnQ+dRRiI+1g3urTvJZ7BY2AOSRCeMbpWXFoa110tE
	 zFLRqUpVTGDs64ZkYU/N8OLZJIeUXFLHMMHG9SbGj/ocK7be0thPf6fN8AZetd6W+z
	 OqBGKqw2+HnzfV7lN6XhG4J+zecf47AN4RFw6xC0HGyDQEYlova2CscTPU+xJBWlK3
	 VxUeG7lnVLVBmM50S4lh7QJxS46XoqV17urB+RVIi/msc8XoqrJMo9cQWV9kAWbRcv
	 DpZowd8FHk/3aDmff/2/QAkwb4W89Uj/8SaRSvsdNu/zD12G8SseSwS8sGw1Gs2f+I
	 kToVAFca9QblQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v5 00/16] bpf: Support stack arguments for BPF
 functions and kfuncs
In-Reply-To: <20260417034658.2625353-1-yonghong.song@linux.dev>
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
Date: Sat, 18 Apr 2026 18:06:25 +0100
Message-ID: <m2pl3w19m6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yonghong Song <yonghong.song@linux.dev> writes:

> Currently, bpf function calls and kfunc's are limited by 5 reg-level
> parameters. For function calls with more than 5 parameters,
> developers can use always inlining or pass a struct pointer
> after packing more parameters in that struct. But there is
> no workaround for kfunc if more than 5 parameters is needed.
>
> This patch set lifts the 5-argument limit by introducing stack-based
> argument passing for BPF functions and kfunc's, coordinated with
> compiler support in LLVM [1]. The compiler emits loads/stores through
> a new bpf register r11 (BPF_REG_PARAMS) to pass arguments beyond

As an overall design of BPF as an architecture, shouldn't it map 1-1
with atleast one real architecture like x86-64? So it runs as fast a
possible on that architecture?

x86 supports passing 6 arguments in registers, BPF currently supports
only 5 (I am not aware of why it was designed like this to start with)

Now, if we add  6+ arguments support by using the stack, the 6th
argument that could have been easily mapped to a caller saved register
(R9) will need special handling.

I know changing these fundamental things about the ISA is not possible
now, like making BPF R6 caller saved and passing the argument in that.
Or add more registers to BPF so it runs faster on RISC architectures.

At least we can make the compiler treat these r11 based stack slots as
caller saved, so they can be mapped to real registers by the JIT
efficiently.

I would say atleast make the first 3 slots (arg 6-8) caller saved
(reload them before every call), so they can be mapped to 3 arm64
registers. riscv64 also has the same layout and it will also map them to
3 registers directly.

Or to make it simpler, just make all the stack slots caller saved.

Thanks,
Puranjay
