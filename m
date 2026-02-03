Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE62241665;
	Tue,  3 Feb 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113642; cv=none; b=nEEExEnFAoEZ5/doEZ8+sk/Zmt+B9x4ZBR+kbKfwlawl/5DjnW8IAqAi6guUaEjfsyF54f6HwwUvy1C9OBQLTzO1DU7QopBRXKbSIn7zD6r0BUt4Ei21Lu14yBWB8K/DxmpLzxZ31FkpPd/kXoIsDm44FLq0CtPfb2X+tc7yjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113642; c=relaxed/simple;
	bh=VJJMRkWoWoL7Ro/Kf17YFzFQkJCZWE1L9qPTVrp7re8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BH9m3TlaM8+gWY61uH54NWt54OD+VT8CoK/jjE9Eh2+yFllwzL8MiE9LgVhgGVnM2cf9Mq5lBFvtElOEgi6wl0SreIuzy+pwsTNUEd1td/NYlP3TA3uC288311VDQt+VoiDQ1KeHdjlunHDQdBP4X0PpSZYby8YaWnzdA/D+x4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEg0BBn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEg0BBn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0FDC116D0;
	Tue,  3 Feb 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113642;
	bh=VJJMRkWoWoL7Ro/Kf17YFzFQkJCZWE1L9qPTVrp7re8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TEg0BBn4xKunqt6ZJm0kVRCaYmKToe1FsC9I0tcpIW4YuzY1FWJIgcTwNOYIgU77B
	 W+sLul5EseXOmgALh/MQZbtCa+aGQWWAHGgec+p7Mgk1sVHNs9DYABbgW/SRmayaxl
	 oM7RbYSs6AnukIzMVCUv5bcWPq90qHmxLYUYUER0lycs8MjvCHEucfETh7BQ5Iv4+F
	 1K1b1o9szh2CsVxihJ56K6Qxw2nu6UTf1a2uOHjkm1fNpsKSGs1o24kGprImevHNsQ
	 eR0Xu9dod26PY2wfvJsb3YUy8q3cvA8zCUkZE+Etp+1+7jxbrSWyLPSt02tH5UtmuZ
	 dMZvCcAVGe9lQ==
Content-Type: multipart/mixed; boundary="===============0485402734697111409=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bfbbb9ef3aa022d56e5777597b48b596c4a959e606fcbc9d63f4ee1e6c07941f@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-7-jolsa@kernel.org>
References: <20260203093819.2105105-7-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:14:02 +0000 (UTC)

--===============0485402734697111409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 2be2f1d0b..b76bb5450 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
> +				struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_attach_target_info tgt_info = {};
> +	struct bpf_tracing_multi_node *mnode;
> +	int j, i, err, cnt = link->nodes_cnt;
> +	struct fentry_multi_data data = {};
> +	struct bpf_trampoline *tr;
> +	u64 key;
> +
> +	data.reg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	if (!data.reg)
> +		return -ENOMEM;
> +
> +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	if (!data.modify) {
> +		free_ftrace_hash(data.reg);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		mnode = &link->nodes[i];
> +		err = bpf_check_attach_target(NULL, prog, NULL, ids[i], &tgt_info);
> +		if (err)
> +			goto rollback_put;
> +
> +		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, ids[i]);
> +
> +		tr = bpf_trampoline_get(key, &tgt_info);
> +		if (!tr)
> +			goto rollback_put;

When bpf_trampoline_get() returns NULL here, the code jumps to
rollback_put without setting err. If bpf_check_attach_target() succeeded
on this iteration (setting err to 0), the function will return 0 instead
of an error code.

Should this be something like:

    tr = bpf_trampoline_get(key, &tgt_info);
    if (!tr) {
        err = -ENOMEM;
        goto rollback_put;
    }

> +
> +		mnode->trampoline = tr;
> +		mnode->node.prog = prog;
> +	}

[ ... ]

> +rollback_put:
> +	for (j = 0; j < i; j++) {
> +		mnode = &link->nodes[j];
> +		bpf_trampoline_put(mnode->trampoline);
> +	}
> +
> +	free_fentry_multi_data(&data);
> +	return err;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: The code follows established kernel patterns and contains a human-typical oversight error (missing error assignment); the commit message has a minor copy-paste error typical of human editing.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing error code when bpf_trampoline_get fails causes silent failure under memory pressure, but does not cause crashes or data corruption.

--===============0485402734697111409==--
