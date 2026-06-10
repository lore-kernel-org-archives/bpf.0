Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561429D266;
	Wed, 10 Jun 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109034; cv=none; b=mH8GSZwH/EQzCvj4cO4w6DS0Lp/ij1Jy72Y3z35drsORpeE4m+ITHG/vdFD24DzXkhSvpKGanwkX5gmt1XFukFKaiPlSAX3zdkVHnorNNQm+FWHW5ZE2qLAxSQjbUIPg1T7im/JYpvI5Wu0te167HoNUFA39O09JuWhUovVkwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109034; c=relaxed/simple;
	bh=bzzN9LgGSFxt+HUM8qwxm6TDxioiNp05CKnhySDKqtQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bU0PTGkaeiPUCI8AzjXcORO6h+Kv47s+8rmo6snHRGapFiEbOswoQJVo6Gb7uNnJ/5sLe3B8Drwi/X1SwoVMvbMbwD1za3wuh8hQ7Fm7o1C8VKj4uIo3YzQTPnew1iOqAt54njqsiZB7GvFxjVw/0aF7hxHABe7KUCA8u+w5KTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs+u4Smd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs+u4Smd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E101F00898;
	Wed, 10 Jun 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109033;
	bh=OxMe21Cv5RjJwXpM95clCOD1WxBtVt9yPtHG1wNYPbc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gs+u4SmdfxjgLnOPOKwut0tP2v8M0BF8JBUYU8tX4j0Bz78x9IHj7Z4kEfA7j9bur
	 9wobO08K1W+g04WMm+6AWAa2ISI1u6ASNvM+til/kKjRfkZvLub4dWOMbRIla9yfA7
	 ZgOtEFMpreCH1vaYiVzw191JKjg26AzS7Fqyj8rZFarj9rnt9tKV8caq15R8XfToNH
	 j26YC6PlOH038quHuuXDLNFxpwCCsnZ5daRm12aL3il7hd3ArHIhf0hlHybnrOVM7d
	 NNFytuzgcnHBPhC6kz4bFJuTVIsGt0KYZTlbevfdzYXWHfnTmMR0Fe1loK566LSdND
	 GoofvDOrABCsw==
Content-Type: multipart/mixed; boundary="===============0413197802770624427=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b2a09e444a9b53441fb2d3b36f14528f9584723f0a03b5601119183e7a3f0910@mail.kernel.org>
In-Reply-To: <20260610145059.113412-3-chenyuan_fl@163.com>
References: <20260610145059.113412-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: fetch probeable prog type from token for feature probes
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,daniel@iogearbox.net,eddyz87@gmail.com,linux-kselftest@vger.kernel.org,shuah@kernel.org,mykyta.yatsenko5@gmail.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 16:30:32 +0000 (UTC)

--===============0413197802770624427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..f008ee50e246 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -19,6 +19,57 @@ int probe_fd(int fd)
>  	return fd >= 0;
>  }
>
> +/* Fetch the first program type from the token that can be used for
> + * feature probes.  Only a few common types are checked that are known
> + * to accept a trivial "return 0" program.  Returns the type on success,
> + * -EINVAL if the token has no probeable type.
> + */
> +static int token_probeable_prog_type(int token_fd)
> +{
> +	/* Types that accept a simple "return 0" probe program */
> +	/* Types that accept a trivial "return 0" program without
> +	 * specific expected_attach_type.  Types requiring expected_attach_type
> +	 * (CGROUP_SOCK, CGROUP_SOCK_ADDR, LWT_*, NETFILTER) are excluded.
> +	 */

There seem to be two comment blocks describing the probeable[] array
back-to-back here.  The first single-line comment looks like a leftover
from an earlier revision; should it be removed?

> +	static const int probeable[] = {
> +		BPF_PROG_TYPE_SOCKET_FILTER,
> +		BPF_PROG_TYPE_KPROBE,
> +		BPF_PROG_TYPE_SCHED_CLS,
> +		BPF_PROG_TYPE_SCHED_ACT,
> +		BPF_PROG_TYPE_TRACEPOINT,
> +		BPF_PROG_TYPE_XDP,
> +		BPF_PROG_TYPE_PERF_EVENT,
> +		BPF_PROG_TYPE_CGROUP_SKB,
> +		BPF_PROG_TYPE_SOCK_OPS,
> +		BPF_PROG_TYPE_SK_SKB,
> +		BPF_PROG_TYPE_CGROUP_DEVICE,
> +		BPF_PROG_TYPE_SK_MSG,
> +		BPF_PROG_TYPE_RAW_TRACEPOINT,
> +		BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
> +		BPF_PROG_TYPE_CGROUP_SOCKOPT,
> +		BPF_PROG_TYPE_CGROUP_SYSCTL,
> +		BPF_PROG_TYPE_FLOW_DISSECTOR,
> +		BPF_PROG_TYPE_SK_LOOKUP,
> +	};

The list places BPF_PROG_TYPE_SOCKET_FILTER first, and the no-token case
also returns SOCKET_FILTER.  This matters for the two probes below that
previously used TRACEPOINT.

> +	struct bpf_token_info info = {};
> +	__u32 info_len = sizeof(info);
> +	int i, err;
> +
> +	if (!token_fd)
> +		return BPF_PROG_TYPE_SOCKET_FILTER;
> +
> +	err = bpf_obj_get_info_by_fd(token_fd, &info, &info_len);
> +	if (err)
> +		return -errno;
> +
> +	for (i = 0; i < ARRAY_SIZE(probeable); i++) {
> +		if (info.allowed_progs & (1ULL << probeable[i]))
> +			return probeable[i];
> +	}
> +
> +	return -EINVAL;
> +}
> +

[ ... ]

> @@ -257,8 +318,13 @@ static int probe_kern_probe_read_kernel(int token_fd)
>  		BPF_EXIT_INSN(),
>  	};
>  	int fd, insn_cnt = ARRAY_SIZE(insns);
> +	int prog_type;
>
> -	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
> +	prog_type = token_probeable_prog_type(token_fd);
> +	if (prog_type < 0)
> +		return 1;
> +
> +	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);

This probe tests for BPF_FUNC_probe_read_kernel and previously hardcoded
BPF_PROG_TYPE_TRACEPOINT.  In the no-token case token_probeable_prog_type()
now returns BPF_PROG_TYPE_SOCKET_FILTER instead.

For a TRACEPOINT program, probe_read_kernel is reachable through:

    tp_prog_func_proto() -> bpf_tracing_func_proto()

For a SOCKET_FILTER program the helper is only reachable through
bpf_base_func_proto(), where it is gated behind
bpf_token_capable(CAP_PERFMON) and
security_locked_down(LOCKDOWN_BPF_READ_KERNEL), and is not exposed via
sk_filter_func_proto().

Does this narrow the conditions under which the probe succeeds, so that
FEAT_PROBE_READ_KERNEL can be misreported in the no-token case that
previously used TRACEPOINT?

> +	return probe_fd(fd);
>  }
>

[ ... ]

> @@ -277,6 +343,7 @@ static int probe_prog_bind_map(int token_fd)
>  		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
>  	);
>  	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
> +	int prog_type;
>
>  	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, &map_opts);
>  	if (map < 0) {
> @@ -286,7 +353,12 @@ static int probe_prog_bind_map(int token_fd)
>  		return ret;
>  	}
>
> -	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
> +	prog = prog_type = token_probeable_prog_type(token_fd);

This assigns the result to both prog and prog_type, but prog is
unconditionally overwritten by the bpf_prog_load() call just below before
it is ever read.  The assignment to prog looks like dead code; should this
just be:

	prog_type = token_probeable_prog_type(token_fd);

> +	if (prog_type < 0) {
> +		close(map);
> +		return 1;
> +	}
> +	prog = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &prog_opts);
>  	if (prog < 0) {
>  		close(map);
>  		return 0;

[ ... ]

> @@ -435,8 +507,13 @@ static int probe_kern_bpf_cookie(int token_fd)
>  		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
>  	);
>  	int ret, insn_cnt = ARRAY_SIZE(insns);
> +	int prog_type;
>
> -	ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
> +	prog_type = token_probeable_prog_type(token_fd);
> +	if (prog_type < 0)
> +		return 1;
> +
> +	ret = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);

This probe tests for BPF_FUNC_get_attach_cookie and previously hardcoded
BPF_PROG_TYPE_TRACEPOINT.  In the no-token case token_probeable_prog_type()
now returns BPF_PROG_TYPE_SOCKET_FILTER.

The get_attach_cookie func_proto is only returned for tracing program
types (kprobe via kprobe_prog_func_proto, tracepoint via tp_prog_func_proto,
perf_event via pe_prog_func_proto, raw_tp/tracing).

For a SOCKET_FILTER program, helper resolution goes:

    sk_filter_func_proto() -> bpf_sk_base_func_proto() -> bpf_base_func_proto()

none of which expose BPF_FUNC_get_attach_cookie.

Does this mean the verifier rejects the trivial program, bpf_prog_load()
fails, probe_fd() returns 0, and feat_supported() caches FEAT_MISSING, so
FEAT_BPF_COOKIE is reported as unsupported on kernels that do support it,
even with no token in use?

> +	return probe_fd(ret);
>  }
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27285576775
--===============0413197802770624427==--
