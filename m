Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE02356C6;
	Wed,  3 Jun 2026 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487535; cv=none; b=Jj7GGl6CXnpsUC5KdOagpd7/De2vSPu4tc1Uc6+TC1RKfp9TSwcbs4f62mer8E7xmI4ksY7db2leJVPcKPiIhSOGcHsJcWnJuxWBGGT6IHXjz6ghr1V2Mn6UEc+B1voV2RUOW960BOjUkV7iQJMlFD/c1Hyj5pBJHY+rxl25eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487535; c=relaxed/simple;
	bh=qB79LF8EgaQtgQWuY6+2O2OnNWB5nfN+02Y8dmSveGQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jAEMZzT0w1UDG6mLXcl5v1WDDrAI06RmS7OG4cvNPikhANI9UULVQWJsZCIQTV31zI8WGFfqezdCJWjQ/UqoFBdpblgQD8VG1ZZ+EL7ZxDAkJq8jzWvvaKAiH2UrDl0usd+DLhkGM6OujYHEjwZWu89zlvOnoz+gw9cUDDGzajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAcODcVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAcODcVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A69E1F00898;
	Wed,  3 Jun 2026 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780487533;
	bh=YgieuE6OWcS7sgGGatJznOSL+O+Vt9rt5Y5HF7KiwZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gAcODcVrrS9vG99Gl99Qt7ymrA2K5O9OZy0evWBC8ui5/krxGFgWaPIen9/tsRlzT
	 ycf5dZzXCquR36WVvRXMGTy8MKGxPps/F+xAM9gRt0dqfyz6EqD42CT6SbizI7fw/k
	 q9HqTendnY737fsqQuvbGJgmATqKRjBZGZVgtz0u4wIqCgVnIfbHlejO+mt3UoCO3l
	 lu6fUN+YgzpjRdQ8d8QktAQzp8sJWeW4waZh0v2ERj++k3HDc7GSMyPba9egyQfKfy
	 aIY0Y8r/d/yytn8Iv8Ys5Ki+Ekc2KX/pktyHhrHWwbCIg8hOGlEcfjIUZThSDYgSdO
	 rf5sTKLD/U+0A==
Content-Type: multipart/mixed; boundary="===============3026700072728036413=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e738b0697b9ee06e9cbaa325a3330f0447f4cd12ae54d6b2c82365d58c4c525@mail.kernel.org>
In-Reply-To: <20260603110554.29590-14-jolsa@kernel.org>
References: <20260603110554.29590-14-jolsa@kernel.org>
Subject: Re: [PATCHv7 bpf-next 13/29] bpf: Add support for tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 11:52:13 +0000 (UTC)

--===============3026700072728036413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d853f97bd154..9e3cb547651e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -42,6 +42,7 @@
>
>  #define MAX_UPROBE_MULTI_CNT (1U << 20)
>  #define MAX_KPROBE_MULTI_CNT (1U << 20)
> +#define MAX_TRACING_MULTI_CNT (1U << 20)

[ ... ]

> @@ -3641,3 +3642,132 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr

[ ... ]

> +static int check_dup_ids(u32 *ids, u32 cnt)
> +{
> +	int err = 0;
> +
> +	/*
> +	 * Sort ids array (together with cookies array if defined)
> +	 * and check it for duplicates. The ids and cookies arrays
> +	 * are left sorted.
> +	 */
> +	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, NULL);

The sort here can run over up to MAX_TRACING_MULTI_CNT (1 << 20) elements
without ever yielding the CPU. Can this hold the CPU long enough to trip
RCU stalls or the soft lockup watchdog when cnt is large?

This was raised on an earlier posting of the series, with the suggestion
to add a cond_resched() somewhere in the path. The reply noted that in
practice the count is expected to be closer to 100k rather than the full
1M limit, and that it was unclear where the cond_resched() should go, so
the code was left as is. Since MAX_TRACING_MULTI_CNT is still 1 << 20,
would it be worth revisiting whether a reschedule point is needed here?

> +
> +	for (int i = 1; i < cnt; i++) {
> +		if (ids[i] == ids[i - 1]) {
> +			err = -EINVAL;
> +			break;
> +		}
> +	}
> +	return err;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881310426
--===============3026700072728036413==--
