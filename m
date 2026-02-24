Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3154758
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956618; cv=none; b=F2BQNUnUMYWst68gjZUrUG2iY3WYSuK9rHaV6lJ+UhN7wU35p+Fd2g6AokqPiXRKxtW0MKiaP/Uli8MjK2fpFb89LE0i/i0aXDcJuKAuYERIaKe8UsPLgI/37rjCy7aW2lFryaoQW/Jdr42FzVcqRacSmV+ykmpVyaakQN/lYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956618; c=relaxed/simple;
	bh=1JqF8CWl1GuqOVloR9pIo5fB9C/JF4LuF6pCdLVW0og=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dZu/G0VRYuYmavsxOpyJTZCJnzxPwWgGslvWBJhC7nPIjNJB3iK8c3NgM3lZdsBFO/xAIzGmR42EwuSXGYDHcgfQAu3qQQqCrGxIE8ahdvNJL4+Q8gGVqGnlQzGxOm2zsdBAHX0YqBADbziuIL/7ihbp1KoFdxZDNidBrTMt5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtproP7W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtproP7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58120C19423;
	Tue, 24 Feb 2026 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771956617;
	bh=1JqF8CWl1GuqOVloR9pIo5fB9C/JF4LuF6pCdLVW0og=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XtproP7W14I180eMA5U2jEHJtXltahwTolmHhzSeHcwuEwFHl0grZ4qg4RnCxYsfv
	 giDUihRkj4yyEyQ0J2DZRP+a/JIrqyW4OdyltlAFeAguvVR3F3TFZ/MOYBtlEswONP
	 matsvA8AhaCK3dmJ9FyAVRG9G8rIHN/C0o2YR0gLla+5v40qzHfzRs0t6khTpFfKiM
	 U7y0WTUg/zLPpCa3wWbwWvPv7Pf6/wM3Jba1bweTosXlbzpe5yCfpfbDwJz1pzz6oX
	 msUZJuyxIaYxt+5GSXCdmunWIGJzHdMfYZeIUURGRzJWshkNnNnkRx8oFP87s7+3dH
	 LHPOPu4EXoc/Q==
Content-Type: multipart/mixed; boundary="===============6065195620438455386=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5c3aaf71afec84f0bd071063099c1077ae7daf042014c904338cb222b66f149@mail.kernel.org>
In-Reply-To: <20260224172340.1704618-2-andrey.grodzovsky@crowdstrike.com>
References: <20260224172340.1704618-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Feb 2026 18:10:16 +0000 (UTC)

--===============6065195620438455386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..5907ab09c4dc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -11716,6 +11786,53 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,

[ ... ]

> +		/*
> +		 * Drop the function symbol and override the
> +		 * offset to be the desired function KADDR.
> +		 * This avoids kallsyms validation for duplicate
> +		 * symbols in the kernel. See attr.config2 in
> +		 * perf_event_open_probe and kernel code in
> +		 * perf_kprobe_init/create_local_trace_kprobe.
> +		 */
> +		optional_func_name = NULL;
> +
> +		err = libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx, true);
> +		if (err) {
> +			pr_warn("failed to get addr for %s\n",
> +				func_name);
> +			goto err_out;
> +		}
> +
> +		if (kaddr_ctx.kaddr) {
> +			pr_debug("retrying %s using kaddr 0x%llx\n",
> +				 func_name, kaddr_ctx.kaddr);
> +
> +			offset += kaddr_ctx.kaddr;

The comment says "override the offset to be the desired function
KADDR" but the code does offset += kaddr_ctx.kaddr rather than a
straight assignment.  When the caller passes a non-zero offset (e.g.
to probe inside a function), the result is kaddr + user_offset, which
is the right thing to do.

Should the comment say something like "add the resolved KADDR to the
offset" to match what the code actually does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22362538618

AI-authorship-score: medium
AI-authorship-explanation: Systematic comments and rapid comprehensive v1-to-v2 restructuring suggest possible AI assistance, but the fscanf format design and overall approach show genuine systems expertise.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor comment-code mismatch where comment says 'override the offset' but code does offset += kaddr (addition, not replacement); no runtime impact.

--===============6065195620438455386==--
