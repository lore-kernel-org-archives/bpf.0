Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91059748F;
	Thu, 12 Feb 2026 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770855590; cv=none; b=KKkm1OSTDp6Su1FUPhwAqM5d7iBUUjptD0BoJ8jKPHclOwLnK/SBhLrbYDr8M8rAny7gjuXDmBQPb5msboZtA3TlGeYJyrkwJmhXMaFEHDs9H5yUOEweJ9ZxIjGu1Rd3kCL/xL8jr7C0V6/0w2TX8Se7sCBYFWNYrtiCTg+LLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770855590; c=relaxed/simple;
	bh=XKUCm7J/vI2FP9uJfFaW/MYjOoq5/1tD6EWdHz1I4Us=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MSmajlAThCSCx9UNEOPp/ufttA8EUyY+jDc+oOMmjURyzNoMltAyEFRSPjHPX3LmLrzWtgwxgQsm66d8A4NKWfS6qs1NxywZqiFMRhIzs6LG5tsg+nCR3fnN6XNxr3tLM4FAbDhhjlbubB0W9ij3K/bXcHJ/VJT1gjl4D94lQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKOgbTi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKOgbTi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DFDC4CEF7;
	Thu, 12 Feb 2026 00:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770855590;
	bh=XKUCm7J/vI2FP9uJfFaW/MYjOoq5/1tD6EWdHz1I4Us=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GKOgbTi3OIf2VSOV29cdhw+tFEElj2saehJ0PJR0rMZmwFDVLBkM4/lGSc3UZgnlw
	 zc/yYCnzK66JN+kk3G6XkJvYg4JHyGyucvf5GFK8N9zUibzwocJju1OeNcl1bwlKlI
	 yX/iNh9Iy+EH9mawnvZF8JY3VSdQF6xZofs8vzBKqxilNpe41LeiFqsFAwAxdk52bs
	 ALTrteV6Hv0mMh4P7i0E/xw/b8Nh6Yw1g0jnMs3JVoTN1A72Ovq6mv4uwX3lQ6el9x
	 UVkbAg/ncQSgiXFbFgVidNLgz/b7uJc5kzg4ZgxYkGsUYk1jWRAH+qjGNcl7p0kxQo
	 V5L2DWLUIS3ew==
Content-Type: multipart/mixed; boundary="===============2832095047326356265=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <957536c0c710b7277d3fbc374ff4299bb38542e54de680aaa16d46e72c503e10@mail.kernel.org>
In-Reply-To: <20260211235055.239024-2-wusamuel@google.com>
References: <20260211235055.239024-2-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add wakeup_source iterator
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Feb 2026 00:19:49 +0000 (UTC)

--===============2832095047326356265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
> new file mode 100644
> index 000000000000..ab83d212a1f9
> --- /dev/null
> +++ b/kernel/bpf/wakeup_source_iter.c

[ ... ]

> +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	int *srcuidx = seq->private;
> +
> +	if (*srcuidx >= 0)
> +		wakeup_sources_read_unlock(*srcuidx);
> +	*srcuidx = -1;
> +}

Should seq_stop invoke the BPF program with a NULL wakeup_source when
iteration completes? Other BPF iterators follow this pattern:

kernel/bpf/map_iter.c:bpf_map_seq_stop():
    if (!v)
        (void)__bpf_map_seq_show(seq, v, true);

kernel/bpf/prog_iter.c:bpf_prog_seq_stop():
    if (!v)
        (void)__bpf_prog_seq_show(seq, v, true);

kernel/bpf/link_iter.c:bpf_link_seq_stop():
    if (!v)
        (void)__bpf_link_seq_show(seq, v, true);

The __wakeup_source_seq_show() function already accepts the in_stop
parameter but is never called with in_stop=true from seq_stop. This would
allow BPF programs to know when iteration is complete and perform any
finalization (e.g., outputting summary statistics).

> +static int __wakeup_source_seq_show(struct seq_file *seq, void *v, bool in_stop)
> +{
> +	struct bpf_iter_meta meta = {
> +		.seq = seq,
> +	};
> +	struct bpf_iter__wakeup_source ctx = {
> +		.meta = &meta,
> +		.wakeup_source = v,
> +	};
> +	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
> +
> +	if (prog)
> +		return bpf_iter_run_prog(prog, &ctx);
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21927983378

AI-authorship-score: low
AI-authorship-explanation: The code follows standard kernel BPF iterator patterns with no unusual characteristics suggesting AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing end-of-iteration callback is an API consistency issue, not a crash or security problem.

--===============2832095047326356265==--
