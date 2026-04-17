Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015D33B6C4;
	Fri, 17 Apr 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456626; cv=none; b=Xz1qaUysk7pdm4rZEyYRg/A7o76PdCTBzbvYhxv3fiZ/rUyrBpm9v8sOlJcYtJqTgRN8+78Nbl8ue1m6kGTg3ylEOJ70s8pjbwyzCmZ66LFjui/8rlFAHv8O4v0PpcQtKcPkdMvK0Nf657l/3GzCjNLqdLLHx7pxvogGr50NZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456626; c=relaxed/simple;
	bh=ZhzFpUv/gf+VXFxycABliep6uXBkwaQaQ02QuHJ0RjI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=avzQLqSISLIfgzxx5eELswr3yFD9DD8BljHRltwRHutKNjsSY/mxVxXUjGLH3nOx4/J3wEKWIPP7LF2XUjKvdjVbdm0botSwF6wjCuneBN0IJXWcviLbaQa5SABRk0Z6B6gMRRMl75KQe8x+1swKn8Go7uXoNLscTxJIvvdNlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm4mCbbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm4mCbbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CA5C19425;
	Fri, 17 Apr 2026 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776456625;
	bh=ZhzFpUv/gf+VXFxycABliep6uXBkwaQaQ02QuHJ0RjI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gm4mCbbn9b8SjR2+OLJhW9tg+U0ccUeDQ5fnfJwlcHGj7580xxndi2lLZxd5JyQ+Z
	 WETg0COADFJhw4x+MrkQCzm+LYF5JhsUD1EQnrh+iYBmHbYv+xUkK+6OWW+XaaU0zS
	 SB+tYzgRv4Wad1fgJZqlMKoQrKcb1GBQGuwUdRcPwXowUKWWkx6EF2N6tB7vOkNe+x
	 rIkVv2F5ZYBVzcy7LhFAFqkj4y4/azI8zgjwKalRr1dgM323zTyoAdrIJOMLtUAhXY
	 o6Yv2eLDq1fLk70jTKY//ni/Mze5Q3HqFT2/Fnji3w2wglJ/5dHeBaOS6t5Es4vaMW
	 ij6olZRvAaRjg==
Content-Type: multipart/mixed; boundary="===============4352981071252508070=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org>
In-Reply-To: <20260417192502.194548-7-jolsa@kernel.org>
References: <20260417192502.194548-7-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 06/28] bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:10:25 +0000 (UTC)

--===============4352981071252508070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> There's slight functional change for the unregister path, where we
> currently free the image unconditionally even if the detach fails.
> The new code keeps the image in place, possibly preventing the crash.

This appears to be fixing a bug where the image was freed even when detach
failed. The bug was introduced in commit e21aa341785c ("bpf: Fix fexit
trampoline.") which unconditionally freed the trampoline image.

Should this commit include a Fixes tag? The suggested tag would be:

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
--===============4352981071252508070==--
