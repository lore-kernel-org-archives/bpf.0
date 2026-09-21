Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7E330307
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962861; cv=none; b=FuYW3GNWPz5Ao1581v3WjKy1IDXDVNvBDGSnwDYaiuyMU4P1FBBItVEBeWqU5QNgLt6PJvKgFC3dEfeK2TbmI7zBPvkSdFda3/DmZPmR0np+w2MZgz7zPWR4CJ1cTaLDm1rULtwiuroo++4uBANrDBp2m7VaZSp5WMuIrXNtxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962861; c=relaxed/simple;
	bh=IBKbkueOY0r8qIBG3u+UdP1m1cMYd6gwHr65dXaPeNI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s6CRzne8L5gV7g7D4d/31+3GeF8ZMOpelkKhjI8v4qRmSNX2NjFcHl8lla6vWiRwwtzLxfHjjwIRh5NZhloznadn0RWKAWI6rijHloBiSSeehoQ5QxMzYrXk14s1KIqFv/FrVY5yW4g6k3j5NXC/aU4ZpT8tMpWIVxCfwGo5L4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ7Bon4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ7Bon4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1031F00898;
	Mon, 21 Sep 2026 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962859;
	bh=JaZvbO1SA1OayWo8H+P5WkMhglBO2yBN1LI3dbBC5gA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OZ7Bon4T2RjpQFAuS1/GlaxUGG5axIaElAXwc4BMy3Y8id06Tk7A/i5PGs2YLjFc2
	 jAVVzLlh/TXafArDFkmtzktO6sJFWT1XlXARPTCRjo9hgICno1X422wAB6RyuANjUb
	 BiTnnCeduxRbGS2rQqTGDTxFONx4Fp7899kv0789XjQWV2MgpJnW8ndxUE2XjY48BL
	 z4nwUG8F1coJB9Q+bWlceC7bqevFZjqsJieLdLq/tMJw7/GG/9pO4h+WeY706KGlYO
	 i9qAiXw9UEKVHQGhC4aT9Uu3YmSi/S/1xiKomP1Y3+0/hR2xDbFoQ0qnnFzOQALlls
	 blGtcCX+jMq9g==
Content-Type: multipart/mixed; boundary="===============1123503985674799330=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f65c593685efe62d763ad4b6f986806a449d4f1878e122ab51c6f7d6eb81d4a2@mail.kernel.org>
In-Reply-To: <20260921023843.411943-12-memxor@gmail.com>
References: <20260921023843.411943-12-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 11/11] selftests/bpf: Cover helper memory access permissions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 03:54:17 +0000 (UTC)

--===============1123503985674799330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Check that fixed-size and sized helper input/output buffers require both
> read and write permission. Cover the MTU and FIB helpers, including read-only
> and write-only rejection and read/write positive controls. Exercise the XDP
> prototypes and the sock_ops header-option input/output argument as well.
>
> Keep write-only maps usable as destinations for partial-output helpers
> bpf_snprintf() and bpf_sysctl_get_name(), while rejecting a read-only
> snprintf destination. Also retain a write-only-map destination for
> bpf_get_current_comm(), whose output is annotated MEM_UNINIT and fully
> initialized by the helper.

This isn't a bug, but could this sentence drop the "fully initialized by the
helper" part, since after the earlier patch in the series the write-only
destination follows from the MEM_UNINIT annotation rather than from full
initialization?

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
> index e87eb6f221e48..2782faf0a528b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>  /* Converted from tools/testing/selftests/bpf/verifier/helper_access_var_len.c */
>
>  #include <linux/bpf.h>
> @@ -822,6 +823,148 @@ __naked void bytes_no_leak_init_memory(void)
>  	: __clobber_all);
>  }
>
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(map_flags, BPF_F_WRONLY_PROG);
> +	__type(key, __u32);
> +	__type(value, struct bpf_fib_lookup);
> +} map_fib_wo SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, struct bpf_fib_lookup);
> +} map_fib_rw SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(map_flags, BPF_F_RDONLY_PROG);
> +	__type(key, __u32);
> +	__type(value, struct bpf_fib_lookup);
> +} map_fib_ro SEC(".maps");

This isn't a bug, but would a neutral name and value type (for example a
plain char[64] scratch buffer named map_wo/map_rw/map_ro) read better, given
these maps are also used for bpf_load_hdr_opt(), bpf_snprintf() and
bpf_sysctl_get_name()?

> +
> +SEC("tc")
> +__failure __msg("read from map forbidden")
> +int writeonly_sized_input(struct __sk_buff *ctx)
> +{
> +	struct bpf_fib_lookup *params;
> +	__u32 key = 0;
> +
> +	params = bpf_map_lookup_elem(&map_fib_wo, &key);
> +	if (params)
> +		bpf_fib_lookup(ctx, params, sizeof(*params), 0);
> +	return 0;
> +}

[ ... ]

> +SEC("sockops")
> +__failure __msg("read from map forbidden")
> +int writeonly_header_option(struct bpf_sock_ops *ctx)
> +{
> +	struct bpf_fib_lookup *buf;
> +	__u32 key = 0;
> +
> +	buf = bpf_map_lookup_elem(&map_fib_wo, &key);
> +	if (buf)
> +		bpf_load_hdr_opt(ctx, buf, sizeof(*buf), 0);
> +	return 0;
> +}
> +
> +SEC("sockops")
> +__success
> +int readwrite_header_option(struct bpf_sock_ops *ctx)
> +{
> +	struct bpf_fib_lookup *buf;
> +	__u32 key = 0;
> +
> +	buf = bpf_map_lookup_elem(&map_fib_rw, &key);
> +	if (buf)
> +		bpf_load_hdr_opt(ctx, buf, sizeof(*buf), 0);
> +	return 0;
> +}
> +
> +SEC("tc")
> +__success
> +int snprintf_writeonly_output(struct __sk_buff *ctx)
> +{
> +	void *buf;
> +	__u32 key = 0;
> +
> +	buf = bpf_map_lookup_elem(&map_fib_wo, &key);
> +	if (buf)
> +		bpf_snprintf(buf, 16, "ok", NULL, 0);
> +	return 0;
> +}
> +
> +SEC("tc")
> +__failure __msg("write into map forbidden")
> +int snprintf_readonly_output(struct __sk_buff *ctx)
> +{
> +	void *buf;
> +	__u32 key = 0;
> +
> +	buf = bpf_map_lookup_elem(&map_fib_ro, &key);
> +	if (buf)
> +		bpf_snprintf(buf, 16, "ok", NULL, 0);
> +	return 0;
> +}
> +
> +SEC("cgroup/sysctl")
> +__success
> +__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
> +__success_unpriv
> +int sysctl_writeonly_output(struct bpf_sysctl *ctx)
> +{
> +	void *buf;
> +	__u32 key = 0;
> +
> +	buf = bpf_map_lookup_elem(&map_fib_wo, &key);
> +	if (buf)
> +		bpf_sysctl_get_name(ctx, buf, 16, 0);
> +	return 0;
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
> index 256956ea1ac51..2f71f70302e48 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c

[ ... ]

> +SEC("tc/ingress")
> +__success
> +int tc_writeonly_output(struct __sk_buff *ctx)
> +{
> +	__u32 key = 0;
> +	__u32 *out;
> +
> +	out = bpf_map_lookup_elem(&map_mtu_wo, &key);
> +	if (out)
> +		bpf_get_current_comm(out, sizeof(*out));
> +	return TCX_PASS;
> +}

This isn't a bug, but would this bpf_get_current_comm() case be easier to
find next to the snprintf/sysctl output tests in
verifier_helper_access_var_len.c, or at least under a name that mentions the
helper?

> +
>  char LICENSE[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35555832550
--===============1123503985674799330==--
