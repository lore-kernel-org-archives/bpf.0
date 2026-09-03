Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAB4A4848
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450763; cv=none; b=jqcinqFKjLQ3tnuMR1qGikf1WFvyab0MWfN2AneHb7OqUQzc6esW1TwbehtvDW0plXD6Va8dBv/Vh/qNDWXYjf3RYDmux6tJ54MNhgurbgyeR0HLvf7Zv7dyINObfiCLwXijXbVvJaKxON9+VK3wUuU3GS5CbwZ66VumQ3nYxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450763; c=relaxed/simple;
	bh=e9TTKRZwlzc/fySHJdrFL3Naj7m7Vmg/0InSIDMQ5CI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VLXUWnYIrK1lW2nBGNTQw0fZdXy0P2XvZOvNUV36cvyNQCuSUQlglx8jG40288NYfDP9N15EcJEmWeIbo69yHNu4+sB8YcUTHmTS7Y6p6+RK34ZxJgZXC/G0Q3u+1EwFCMiabR92I+6WCjfcnoQm5Rml+usREASUsioPo1G+3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLPnFH4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLPnFH4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85041F000E9;
	Thu,  3 Sep 2026 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450761;
	bh=TPa/OsQbvP3FGWi0uzqnZR7JiupPTbR+IVIJHNA++98=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RLPnFH4uSPy0cHLjJuwqkcnetvqAc/M3/cjb+gSscGE0kFJqLXfRB/ErGx/5jAzFX
	 /EDUk7BzrxV5WdcL+IlzFKzZBLutQn3mJSUEH4w8dkATUh4CZbqimkiKZrKwLDVWAW
	 0Kh2WtD8zAiI0NgHFdbr4C5Yg9ieepBb9avixmeDtdj/5hObulPC51Zhe3F7ZeGW0+
	 FeZsfHduvGYbBBy+rgCPwIKbPOGGalQJEIozgRwBiPfMh4CDwC0OpSzVDYkqW/Y7tw
	 Szv//dgvQxKoEH4jNJZtVmJQHKoDF0UoCkxwo61VRFr+veQ8GpdjCbXah60hrVCUA5
	 jFT5ikhZYkZpw==
Content-Type: multipart/mixed; boundary="===============3150414496337214713=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f3183a6e8aef584269fbfbd9d784b629bc2ac82e0a87f5b88a6653a21e4e123b@mail.kernel.org>
In-Reply-To: <20260903144433.1716731-8-memxor@gmail.com>
References: <20260903144433.1716731-8-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 07/10] bpf: Mark sched_process_wait argument as nullable
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:52:40 +0000 (UTC)

--===============3150414496337214713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d6d243c262ea5..41764356d2d30 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6657,6 +6657,10 @@ struct bpf_raw_tp_null_args {
>  static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
>  	/* sched */
>  	{ "sched_pi_setprio", 0x10 },
> +	/*
> +	 * do_wait() passes NULL for wait4(-1) and waitid(P_ALL).
> +	 */
> +	{ "sched_process_wait", 0x1 },
>  	/* ... from sched_numa_pair_template event class */

This isn't a bug, but would the comment read better as a single-line
/* do_wait() passes NULL for wait4(-1) and waitid(P_ALL). */ to match
the other comments in this table?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33770534313
--===============3150414496337214713==--
