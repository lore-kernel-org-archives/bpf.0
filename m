Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A97241665;
	Tue,  3 Feb 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113639; cv=none; b=E1aHAyjvpvC/7qJFZ30L9BQl90SBXLtYSeBdWUS+vBJDPdMGz7W7G9uzvfwEdkBI4HzbuI15HQk+NbAiFr9iKVNHm8fw6dHUsJHzVI3uVH32lO7fohTPSlZsCyHBHHd1heAp5qInkjf/kNpy7KE3bVQ3iOcBbPTtp2BmWdr1YqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113639; c=relaxed/simple;
	bh=jqrpfb7Cew7RzvH2zeKKywnlXky+sfamAD+RUrAHp1o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EY7LbmPTm262J00ukWABX95LvPQ90TVsGtY+N4tNlkgMPoOYtP4DDTE7D240D5JQe9Zu2g/gENZPiHumtYKmxrnr5UyfnrtQeqdApUtfInCyiBlS+kNFHsySVJUPqmNaHyoS5fP6Ck7OcWuQ3+dKkfblzhcSONn264UWVW32p7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZm7F0b2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZm7F0b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C292DC116D0;
	Tue,  3 Feb 2026 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113639;
	bh=jqrpfb7Cew7RzvH2zeKKywnlXky+sfamAD+RUrAHp1o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AZm7F0b2C0+otdmoXVL32wTgiHc2EfM2A5BQNfOMU4rVJPmyIp8s7HiRxBYH4SRTI
	 yK/N4NOvicy8e/8gv7wBmQ0gtX88iT3bfM7+QOM3okcRQD8W9bZ3rZC5wwl1J0t1sY
	 p3z8Lp1QwP0dGdGlhxmqgdjK3CU3hW1A3OnZwbYgmzUaC1OGlPF6hv6jvDFa7Th2fG
	 o7SN/w0AnibXvNKjZ+3uRM0qiK7vpG82veA8NUMku0/QSmNKtUI6Afz6gXBOXjs07S
	 vcRWCiyPMslOIDI7rpdsXViZA88hTLl0q2TkyljTP2kUnfYqK9f+7jfMqCOZAmgLER
	 pnqQ+hHOGzp6A==
Content-Type: multipart/mixed; boundary="===============8692400028787280868=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1aa999b2eb50ae6a0a80a5ef21c5f8c22bcb2605e971652c6f202a292b996032@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-8-jolsa@kernel.org>
References: <20260203093819.2105105-8-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 07/12] bpf: Add support to create tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:13:58 +0000 (UTC)

--===============8692400028787280868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 68600972a..010785246 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -1863,6 +1864,10 @@ union bpf_attr {
> 				};
> 				__u64		expected_revision;
> 			} cgroup;
> +			struct {
> +				__aligned_u64	btf_ids;	/* addresses to attach */
> +				__u32		btf_ids_cnt;	/* addresses count */
> +			} tracing_multi;

The comments say "addresses to attach" and "addresses count", but the field is
named btf_ids and contains BTF type IDs, not addresses. Should these comments
say "BTF IDs to attach" and "BTF IDs count" instead?

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f7baeb827..82e625aa0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
> +					       struct seq_file *seq)
> +{
> +	struct bpf_tracing_multi_link *tr_link =
> +		container_of(link, struct bpf_tracing_multi_link, link);
> +
> +	seq_printf(seq, "attach_type:\t%d\n", tr_link->attach_type);
> +}
> +
> +static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
> +						 struct bpf_link_info *info)
> +{
> +	struct bpf_tracing_multi_link *tr_link =
> +		container_of(link, struct bpf_tracing_multi_link, link);
> +
> +	info->tracing.attach_type = tr_link->attach_type;
> +	return 0;
> +}

Both functions above use tr_link->attach_type, but looking at
bpf_tracing_multi_attach() below, this field is never initialized:

> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> +{

[ ... ]

> +	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto error;
> +	}
> +
> +	link->nodes_cnt = cnt;
> +
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
> +		      &bpf_tracing_multi_link_lops, prog, prog->expected_attach_type);

bpf_link_init() sets link->link.attach_type (inside the embedded struct bpf_link),
but struct bpf_tracing_multi_link has a separate attach_type field that remains
zero-initialized from kzalloc.

The show_fdinfo and fill_link_info callbacks read tr_link->attach_type which
will always be 0 (BPF_CGROUP_INET_INGRESS) instead of the actual attach type
(BPF_TRACE_FENTRY_MULTI or BPF_TRACE_FEXIT_MULTI).

Looking at the existing bpf_tracing_link_show_fdinfo() and
bpf_tracing_link_fill_link_info() in kernel/bpf/syscall.c, they use
link->attach_type (the inner struct's field). Should tr_link->attach_type
either be removed and link->attach_type used instead, or should it be
explicitly initialized to prog->expected_attach_type?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: Code style and structure are consistent with established kernel BPF patterns, with typical kernel author conventions in commit message and implementation.
issues-found: 2
issue-severity-score: medium
issue-severity-explanation: Uninitialized attach_type field causes wrong data to be returned to userspace via fdinfo and bpf_link_info, affecting observability but not causing crashes.

--===============8692400028787280868==--
