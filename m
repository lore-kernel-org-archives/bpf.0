Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CD63CB;
	Sat, 18 Apr 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776494948; cv=none; b=XaEUHA1ksevO7EcOLdvRXLnOz9nPk5f/FxMKL5SdyXJ3cWkSda1OzBBLPEVIlhvSQ8FGGLBX9zqFN1W27otn18aIx1JJ5Ldq8ZTxvm9VJ6BWSWUQJe98nqrMx8s0XekSeqRQ6Dh6fcD49mPIrQPvLkg/d7xfS4pU+PXCWRKlcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776494948; c=relaxed/simple;
	bh=Qb5KnFoWNhvnpwaTuLqY330TsgW7PuvbcSsdoMTFJ1M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O4RWxiO0jE5wCnpSWGb3VchrhX4C3qjUNPc4ihFWbwSlla9JdyiYRlK4Loj1H6pwZr5ihTrigtL+8O7fbjEHlIX2H36p5cjW7RP737Nf/Z/3gSPMOfqOr21ktKgNwOrWMmK+8BbreuaYOrRURQBPrxwB6yQRNH71OKR3QfHdcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5Lfu7qb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5Lfu7qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA45C19424;
	Sat, 18 Apr 2026 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776494947;
	bh=Qb5KnFoWNhvnpwaTuLqY330TsgW7PuvbcSsdoMTFJ1M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W5Lfu7qbxosv9FU/9SMQqrHJcfOelzKuNbRpkaanggUsGJjqs/brCIglwNPpfgSul
	 xqCBnCBZMijI0dZzEaI/FV/tTnd3tBTC0ehfWzNqwgZc8xggl7iSoK+9pu1SoY8miX
	 p9oT1UIJ6NiDiehvNhlirEkA/5s3TFxWYDIJnDJtfQCtED+IR1Ebb4/qMzVuYuLGpv
	 F/z74aay5QHlfK8gMc5ITlN8kONRU2BNaqL1DJeTpDy8H0gRMeLt0vq6C5ZH2d4Wn4
	 eb4Pd0Y8N5kYL7f/sixtxyudt75pQi44b3Dl8rtG37tncNhVCuYT0cYpyByEEnmSkm
	 m8TD93/a+6e0g==
Content-Type: multipart/mixed; boundary="===============3971620619811084894=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d84b09fcfb7447af18053f292d72811ede3eb4a0970df530d76cd2fa4956cea9@mail.kernel.org>
In-Reply-To: <20260417192502.194548-5-jolsa@kernel.org>
References: <20260417192502.194548-5-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Use mutex lock pool for bpf trampolines
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:49:07 +0000 (UTC)

--===============3971620619811084894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f02254a21585..eb4ea78ff77f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -30,6 +30,34 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
>  /* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
> +/*
> + * We keep 32 trampoline locks (5 bits) in the pool, because there is
> + * 48 (MAX_LOCK_DEPTH) locks limit allowed to be simultaneously held
> + * by task. Each lock has its own lockdep key to keep it simple.
> + */

The comment explains why the pool has 32 locks (MAX_LOCK_DEPTH limit), but
could it clarify why each lock needs its own lock_class_key?

Without this detail, it's not obvious that distinct keys are needed to avoid
lockdep "recursive locking" warnings when trampoline_lock_all() acquires all
32 pool mutexes simultaneously (presumably in following changes).

This was raised by bot+bpf-ci@kernel.org in v3 review:

  "Comment explains 32 count but not why per-lock class keys needed; should
   mention avoiding lockdep recursive locking warnings"
  https://lore.kernel.org/bpf/31ae46274a3157f2b9840e1a09b2698d1ec0cfd461737ff460c2d3349a9f0054@mail.kernel.org/

The concern was acknowledged with "will add", but the v5 comment still says
only "to keep it simple" without addressing the lockdep recursive locking
concern.

The same issue was raised again in v5:

  https://lore.kernel.org/bpf/53b3e6cb10e12555d3b1b321eeb4e04a447c707c387568d1e9ef759fb6459ef4@mail.kernel.org/

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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============3971620619811084894==--
