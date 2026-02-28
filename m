Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31120C463
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247859; cv=none; b=J1ayzkUcqgRwEfeZ2UXzf1hpPlzFqYyjcSIbr96nsRMGRmUs/8s3Obai5wbx54PkTY+CIOitPttqn0rxO30PQhxbKl0cmYE5VsPHU84UO+faFTXdnUOFajyqr24LWJvCJ7izBufGu6dedyGGKbdQI6/9OvQBEfpU1PbQKuokCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247859; c=relaxed/simple;
	bh=mgmRwwNpWXhgkOoz4NtVpsYVPE+VpdILYY4lLthMG3c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eanFLTQaYtTnL8jOY5kLAGn+FzUXi+i/ELBffJLtRfPBC+3v3tcmSfouHlGU6+Y7QfAG1oJnN3rfyATkoFP3C5/SGunyrJ9ct/arnqanhum8jZd6yKJYzET4cQSu5ZhCfC1ppwfjBIeozP4Iiq1oIdVo8jdNISuYpaDEXEuR9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbCYzAWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbCYzAWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1481C116C6;
	Sat, 28 Feb 2026 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247859;
	bh=mgmRwwNpWXhgkOoz4NtVpsYVPE+VpdILYY4lLthMG3c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DbCYzAWHzIUGl6xwLIvzbq5k+9t+aab4zx7505na58fROR+tGyWE9O19FD7e+D+7L
	 lqAiRObmHfTfFQ6mjY3KFMoEGIJv7pWggo7QM4xBmH/sw9rLUd2HCjGYhYR/CGzpY7
	 fHOK1jrSJIbZ9ksq5WOkfp4R4EPJjkjRgz7stvI/FTl4SfHMtmPIOeH8d5auFSOZnJ
	 QJpvWFK82QvJE3empXDFQs4cmhf68UkgIjSTZr5l4Mf0hqRDS3vxJpFmKSJZPfCHHA
	 jtnx+2kR6dCuJVtLqC1C8quScXC9jx7Lo/j1sJpYMTAd+85NZuO2Y0Ld5Dq+2aM3EU
	 ts3b02vJZnJRA==
Content-Type: multipart/mixed; boundary="===============4168895131959537881=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a89fd3edd5e90ed47ff1189efdfa626f9b4610daa02da46a3a8fe4d5762796c@mail.kernel.org>
In-Reply-To: <FFFA8066FE63B894+20260228022403.99235-1-xulang@uniontech.com>
References: <FFFA8066FE63B894+20260228022403.99235-1-xulang@uniontech.com>
Subject: Re: [PATCH bpf v3] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
From: bot+bpf-ci@kernel.org
To: xulang@uniontech.com,martin.lau@linux.dev
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,clm@meta.com,daniel@iogearbox.net,dddddd@hust.edu.cn,dzm91@hust.edu.cn,eddyz87@gmail.com,hust-os-kernel-patches@googlegroups.com,ihor.solodrai@linux.dev,kaiyanm@hust.edu.cn,martin.lau@kernel.org,sdf@fomichev.me,xulang@uniontech.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 28 Feb 2026 03:04:17 +0000 (UTC)

--===============4168895131959537881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1003,12 +1004,13 @@ struct bpf_attach_target_info tgt_info = {};
>
>  	shim_link = cgroup_shim_find(tr, bpf_func);
>  	if (shim_link) {
> -		/* Reusing existing shim attached by the other program. */
> -		bpf_link_inc(&shim_link->link.link);
> -
> -		mutex_unlock(&tr->mutex);
> -		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
> -		return 0;
> +		link = &shim_link->link.link;
> +		if (link == bpf_link_inc_not_zero(link)) {

The other callers of bpf_link_inc_not_zero() check the return value
using IS_ERR(), for example bpf_link_by_id():

    link = bpf_link_inc_not_zero(link);

and bpf_link_get_curr_or_next():

    link = bpf_link_inc_not_zero(link);
    if (IS_ERR(link)) {

Should this use the same IS_ERR() pattern for consistency? Something
like:

    if (!IS_ERR(bpf_link_inc_not_zero(link))) {

> +			/* Reusing existing shim attached by the other program. */
> +			mutex_unlock(&tr->mutex);
> +			bpf_trampoline_put(tr); /* bpf_trampoline_get above */
> +			return 0;
> +		}
>  	}

This commit fixes a use-after-free introduced by commit 69fd337a975c
("bpf: per-cgroup lsm flavor"), which added the bpf_link_inc() call
that could resurrect a zero-refcount link. It appears to be missing
a Fixes: tag. Martin KaFai Lau's review of v2 also expected this tag
to be present.

Suggested:

    Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")

https://lore.kernel.org/bpf/cd99eba7-ac03-4b53-a79c-a6206abbddb6@linux.dev/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22511586078

AI-authorship-score: low
AI-authorship-explanation: Human authorship patterns: references maintainer suggestion, informal testing description, iterative v1/v2/v3 development with reviewer feedback, addresses a bug reported by a different researcher.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Missing Fixes: tag (requested by BPF maintainer) and non-standard bpf_link_inc_not_zero() return value comparison pattern; neither causes runtime problems.

--===============4168895131959537881==--
