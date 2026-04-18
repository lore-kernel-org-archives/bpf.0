Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485863CB;
	Sat, 18 Apr 2026 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776494949; cv=none; b=H51eTfLCyK3naOJ45JapQb5c3xFdwra4shICmqP5rw+a1+KIXXYHO2QQ329mCqiHmzk9XErYRIVSPmYhrJq+U9NGPkNm9AsS3DdSweUc/MePw/JV3s6BKyU8YijR9MZKtsJ7w0x2qSnZqNlo27SuSOnzKYcpMGBbpMZRw4lT7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776494949; c=relaxed/simple;
	bh=A7en+rpIR/n2DzewMhzuYhRlnzhXfrjxt7hUyNvnytE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bNisnrEauSQt0F4Ap/42dY1vZntDJUhf82k4BpBlQAahpunz6IJveKZ/N3dtean8eUITI7XFIGIJpKr1nMcjllVO3yJl6CynRdcUU4BnrMALYOmTcsdpbYi5JiawtEp4dVkBYdTY/n/UaKs8ewnAUti8wU3ORvSONLPjQAil4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+L2dGZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+L2dGZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E2FC19424;
	Sat, 18 Apr 2026 06:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776494949;
	bh=A7en+rpIR/n2DzewMhzuYhRlnzhXfrjxt7hUyNvnytE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Z+L2dGZgWMRI5Dvr+ENPHIEUBK5Lez9WEPT/bfXKA4rWjYjzaUDTtjV+F8joWyaGA
	 2d41K8c+Pr/dG8RKQFHyHDjVmkHOK8DQPbBQ2VxJaRp7Y8roOx49/92yGY9eJMllZS
	 bbUi31Qn2RJkY/7ScNe0nGO/yczGZUgMO8verP392GoOZYRwG5+ZGSEdoTQmJqzyva
	 94D5S5o/JDlsixIvXkarfAC+5w/iUOGxW6L8OOLQLdg3SBjIKeaj9hrb3UJ5yrOn5p
	 i+MoiXqRjM2NK17ZfaJme1i4TIMGoFxoxJzzbmCgltgkslKJs90DuUtQruadX6tZ1L
	 llsJiKpB5qLbQ==
Content-Type: multipart/mixed; boundary="===============6383107194481219733=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23dc9c8f0305da291027f64f583beda22a65d77849bc00c08eb88f32e4651d95@mail.kernel.org>
In-Reply-To: <20260417192502.194548-11-jolsa@kernel.org>
References: <20260417192502.194548-11-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:49:09 +0000 (UTC)

--===============6383107194481219733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1154,6 +1154,8 @@ enum bpf_attach_type {
>  	BPF_TRACE_KPROBE_SESSION,
>  	BPF_TRACE_UPROBE_SESSION,
>  	BPF_TRACE_FSESSION,
> +	BPF_TRACE_FENTRY_MULTI,
> +	BPF_TRACE_FEXIT_MULTI,
>  	__MAX_BPF_ATTACH_TYPE
>  };

In RFC v2 (Feb 4, 2026), Leon Hwang asked whether BPF_TRACE_FSESSION_MULTI
should be added alongside BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI
for API consistency, since BPF_TRACE_FSESSION exists and is handled
similarly to FENTRY/FEXIT. You acknowledged this with 'good catch, will add
it' but BPF_TRACE_FSESSION_MULTI was never added in any subsequent version
(v1, v2, v3, v4, or v5).

Is this attach type intentionally omitted, or should it be included to
complete the multi tracing API?

Reference: https://lore.kernel.org/bpf/3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev/

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19368,7 +19379,17 @@
>  		if (ret < 0)
>  			return ret;
>
> -		if (tgt_prog) {
> +		/* *.multi programs don't need an address during program
> +		 * verification, we just take the module ref if needed.
> +		 */
> +		if (is_tracing_multi_id(prog, btf_id)) {
> +			if (btf_is_module(btf)) {
> +				mod = btf_try_get_module(btf);
> +				if (!mod)
> +					return -ENOENT;
> +			}
> +			addr = 0;
> +		} else if (tgt_prog) {

This isn't a bug, but the new multi-line comment here uses the old kernel
comment style with text on the same line as the opening '/*'. The BPF
subsystem guide mandates the modern multi-line style with '/*' on its own
line for new code under kernel/bpf/, even if surrounding code still uses
the old style.

Should the comment be reformatted as:

	/*
	 * *.multi programs don't need an address during program
	 * verification, we just take the module ref if needed.
	 */

> @@ -19396,6 +19417,12 @@
>  			ret = -EINVAL;
>  			switch (prog->type) {
>  			case BPF_PROG_TYPE_TRACING:
> +				/* *.multi sleepable programs will pass initial sleepable check,
> +				 * the actual attached btf ids are checked later during the link
> +				 * attachment.
> +				 */
> +				if (is_tracing_multi_id(prog, btf_id))
> +					ret = 0;

The same comment style issue appears here. Should this also use the modern
style with '/*' on its own line?

Note that another comment you added in check_attach_btf_id uses the correct
modern style, making this inconsistency clearly fixable.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============6383107194481219733==--
