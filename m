Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F127702D;
	Fri, 17 Apr 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456624; cv=none; b=EyFizY+0XM9tLm3NhGU2lf3jOax8SqUU9fsKgs9n0ZE+H+FNhpkFma3/cOwA9QhLYdHYYTaP/3Cnlp/8YzqjYWqZvaAW56Yjq7p8Ybp0wZdzzkq72+MKjon/TlL1tntvBsf5LTkpDXcY4z1nCn16YlQD4jM5yNiahP/8QGib51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456624; c=relaxed/simple;
	bh=9+0lraSQDYvs065kGteiMg1cSZDQQU7zuIomhGXKprQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EU5Z75niwN2kFtxLQ59MmiZHU5KvoB1XMCsWBhHo8Ss+EewkN/ZqMmlG2Bn+a911NT7OL6XARTDG3QPN0DwQ+Uu24gwBI/B97vnaMpmiEh+pvUyFc1i67xNo6SQOJLSWpgNq2mbpEnCI+qzzC0hzLR71I838npPefdHkfJ5pZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbRB6av9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbRB6av9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E956C19425;
	Fri, 17 Apr 2026 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776456624;
	bh=9+0lraSQDYvs065kGteiMg1cSZDQQU7zuIomhGXKprQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TbRB6av90S93J3/CM5Dzukiw+xANe0qYzEgxJWSSBil5WM4ILFiYf75ivPdJUAZb1
	 7I5yAmPpp+PVtqBHCa6HTScj99vYxTTNCd9F0uq7FeMg/ghqfNiGHq1fXc8YWgO7iD
	 IyfIXobhh1maVXczjhIVyBhT5oix6FX0FVwXPPqF6yW3DPUOcg77AwA+rOnmomUk6U
	 o+Sz3+UVxytEs2DaOMxfFbAjlUOvadSFQVgB1wqjh63mwT2UbQwJDTpevzwHUkZOoB
	 SN/eSKTmUnQE1TqfMIaSJATeiYtap4LExk/XJIo/5P1M8cZQRAjkma64dH3XfIkR8r
	 LZZoc6nGKbFYw==
Content-Type: multipart/mixed; boundary="===============6371279297218343423=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53b3e6cb10e12555d3b1b321eeb4e04a447c707c387568d1e9ef759fb6459ef4@mail.kernel.org>
In-Reply-To: <20260417192502.194548-5-jolsa@kernel.org>
References: <20260417192502.194548-5-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Use mutex lock pool for bpf trampolines
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:10:24 +0000 (UTC)

--===============6371279297218343423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -30,6 +30,34 @@ #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
>  /* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
> +/*
> + * We keep 32 trampoline locks (5 bits) in the pool, because there is
> + * 48 (MAX_LOCK_DEPTH) locks limit allowed to be simultaneously held
> + * by task. Each lock has its own lockdep key to keep it simple.
> + */

The comment explains the 32 count (MAX_LOCK_DEPTH limit), but should it
also explain why each lock has its own lock_class_key?

Without that explanation, it is not obvious that distinct keys are required
to avoid lockdep "recursive locking" warnings when trampoline_lock_all()
acquires all 32 pool mutexes simultaneously.

This was raised by bot+bpf-ci@kernel.org in v3 review:
https://lore.kernel.org/bpf/31ae46274a3157f2b9840e1a09b2698d1ec0cfd461737ff460c2d3349a9f0054@mail.kernel.org/

The author acknowledged it with "will add", but the current comment only
says "to keep it simple" without addressing the recursive locking concern.

> +#define TRAMPOLINE_LOCKS_BITS 5
> +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> +
> +static struct {
> +	struct mutex mutex;
> +	struct lock_class_key key;
> +} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
--===============6371279297218343423==--
