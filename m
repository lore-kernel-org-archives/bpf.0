Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB852372684;
	Mon, 16 Mar 2026 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650115; cv=none; b=Mri+OM6ZcDwrEhavar0PwGTTNdqPrhnx5z1gltyVXeT/Vt4nypfFF3pSMshfhkq1r+BdqFfhempgGD1WXS1NmvC1DKltoqdPvIbSsvbTtfTvnwwTWnVcp8m1yg9JmA01a+nphqSSRtavzZ8PI69waJpmJAknQO02nbYwCE6jabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650115; c=relaxed/simple;
	bh=B8dSP+XjwaqoCFAXHq57Cq3UhdwJNv1bxczoifrx8a0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aWejuY1e9FGVeOg98b2xTT8HPYtpmfQwDh3DwCCd8QieDXD2qEa9HzNoUCxwHCfhOAgH42MAtmDldawn4vlDFGXGjUIsdZqPDXwdW23cAosDWm+/8Ise1XkuEEi3RsgIEYWmJra6iVLv1x3dSuoei7EtwoURkWRmMzWkgFjn5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9RRVORT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9RRVORT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2391AC19421;
	Mon, 16 Mar 2026 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650114;
	bh=B8dSP+XjwaqoCFAXHq57Cq3UhdwJNv1bxczoifrx8a0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Q9RRVORTJ5hzICwY+/37MI+ONP2ai2qNMNaZoy7EHhO6RwpDXmzVSRqp6d2fuNlhS
	 esQUXsy22/hz5WCLl7/16/pDhkKhQ45Wm9u4XIyUkOdQfexMZZb/BBCblSiC6tW4xY
	 YgFPDA7YkYKGJ6bOO0OnHwvJte/jQU1ENAvnHU/rXaGffBetBKnuns8ua9MpzlaGVk
	 IthC1ixSXHX8VrRUhH4IkwOnIWerLAIKshW/SkFRPI4xiYH6H3cWnEcln5W2aM8TQM
	 eY8097zeDlLcfNxxkZjbL0+2JHxEF3cn5xaHEBlZrUYQV6eGUzpYXk0cGWd9BBAeSo
	 96JviOy+CPetw==
Content-Type: multipart/mixed; boundary="===============5112763136537684029=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <31ae46274a3157f2b9840e1a09b2698d1ec0cfd461737ff460c2d3349a9f0054@mail.kernel.org>
In-Reply-To: <20260316075138.465430-3-jolsa@kernel.org>
References: <20260316075138.465430-3-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 02/24] bpf: Use mutex lock pool for bpf trampolines
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 08:35:14 +0000 (UTC)

--===============5112763136537684029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f02254a21585..9923703a1544 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +/*
> + * We keep 32 trampoline locks (5 bits) in the pool, because there
> + * is 48 (MAX_LOCK_DEPTH) locks limit allowed to be simultaneously
> + * held by task.
> + */
> +#define TRAMPOLINE_LOCKS_BITS 5
> +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> +
> +static struct {
> +	struct mutex mutex;
> +	struct lock_class_key key;
> +} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];

During v1 review, Alexei asked to add a comment explaining both the
pool size of 32 and why per-lock class keys are needed:

https://lore.kernel.org/bpf/CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com/

The comment explains the 32 count (MAX_LOCK_DEPTH limit), but does
it also need to mention why each lock has its own lock_class_key?
Without that, it is not obvious that distinct keys are required to
avoid lockdep "recursive locking" warnings when
trampoline_lock_all() acquires all 32 pool mutexes simultaneously.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558
--===============5112763136537684029==--
