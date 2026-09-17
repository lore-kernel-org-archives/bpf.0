Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197B49B444;
	Thu, 17 Sep 2026 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680849; cv=none; b=HuWI2ScwiMDhfMX4wnvwK1s3x/N6xNHOQ24rT/BIFO25wQFUJMj8Gzs6azeGRkBmxmwjn4WSRWpprgLzqYwT5GXuR10ffCRmhXBmCG7f7yfQ2Vam8iYe3kvmHVHyqbuonSXiTr79R1XeDIgG9fWNKSMBEfOFSsLbfzz4xT4qNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680849; c=relaxed/simple;
	bh=09m/Toc11vyxs5ALnjAgEKWFZiJzS6gA0G+8blTB4ZQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eimRbpRMtOV9C6JEYrbsKVTEE84vtClfvf6OoE1mJdWb5zEtppwQHBMA5XPwr9iGGUu29KtiHFVFuw4zcBYCCm8uFcoJ367WbWH9Ll3Fgw6v5o1YfhdxSo4U2XsqnhZQajVBVCvTwMF/xwdA3N9et1lfdU8fy6qhHZh0hvQec9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvQfSa/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvQfSa/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620361F00893;
	Thu, 17 Sep 2026 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680847;
	bh=/TMhPsNLOvVI9vJg103ng/uNUTbD4sOwpp2WwQIxmRI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gvQfSa/FMFJW8TarLqdz64uN0k6EIf7tOglAW26QeGlGrKN4auNXskeOTrEyse9wL
	 8HGBUkMICjA134kKq2Fz6LHU2YKrG+0CVW3+pIFRnwRMAEECrVzqDBhDqvS4Fzz/gX
	 QMcSR68AhnLsmvem8CF8MJSj76IpySJm03nXHo+TCiNqo67chuHuyzGXwI47FQBikE
	 LG2rF6NG0buAEF1Lf3Dc2CkFC7WxOb7eG2A1bNa5lqKik4FG3krox6cPecVssnamxT
	 EB+wcegsQYp8ikJZ16eLs2B6Bxg8fWUwL4VyVm5AkRBVLf1tuqXSn2eww0sQxb3s5Z
	 3pCDfi9EydNVg==
Content-Type: multipart/mixed; boundary="===============5066564868234564915=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95083a4ec369ed66a93091c93309a8289ce03e581edeef02cc10f8c1f0c27346@mail.kernel.org>
In-Reply-To: <20260917200542.3689605-15-ameryhung@gmail.com>
References: <20260917200542.3689605-15-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 14/15] selftests/bpf: Test attaching struct_ops to a cgroup
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:06 +0000 (UTC)

--===============5066564868234564915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
> new file mode 100644
> index 0000000000000..6435ed1c2cf6d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c

[ ... ]

> +/* Must match progs/bpf_tcp_ops.c */
> +#define OPS_RETVAL1	11
> +#define OPS_RETVAL2	22
> +
> +/*
> + * Attach three struct_ops implementing timeout_init to the same cgroup; they
> + * run in attach order [retval1, retval2, retval3]. timeout_init's return value
> + * is chained: the first prog reads the kernel seed via bpf_get_retval() (0,
> + * since no legacy sockops prog is attached) and returns OPS_RETVAL1; each
> + * subsequent prog must then observe the previous prog's return value. This
> + * proves the trampoline inherits the retval across an array of struct_ops.
> + */
> +static void test_retval(int cgroup_fd, struct bpf_tcp_ops *skel)
> +{
> +	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
> +
> +	skel->bss->retval_saw1 = -1;
> +	skel->bss->retval_saw2 = -1;
> +	skel->bss->retval_saw3 = -1;
> +
> +	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops_retval1, cgroup_fd, NULL);
> +	if (!ASSERT_OK_PTR(link1, "attach_retval1"))
> +		goto done;
> +
> +	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops_retval2, cgroup_fd, NULL);
> +	if (!ASSERT_OK_PTR(link2, "attach_retval2"))
> +		goto done;
> +
> +	link3 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops_retval3, cgroup_fd, NULL);
> +	if (!ASSERT_OK_PTR(link3, "attach_retval3"))
> +		goto done;
> +
> +	do_listen_connect(AF_INET6);
> +
> +	/* First prog inherits the kernel seed (no legacy sockops -> 0). */
> +	ASSERT_EQ(skel->bss->retval_saw1, 0, "retval_saw1");
> +	/* Each subsequent prog inherits the previous prog's return value. */
> +	ASSERT_EQ(skel->bss->retval_saw2, OPS_RETVAL1, "retval_saw2");
> +	ASSERT_EQ(skel->bss->retval_saw3, OPS_RETVAL2, "retval_saw3");

The test expects retval_saw2 to be 11 and retval_saw3 to be 22, both
outside the range the verifier believes bpf_get_retval() can return.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
> new file mode 100644
> index 0000000000000..94a7f52573d51
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c

[ ... ]

> +#define OPS_RETVAL1	11
> +#define OPS_RETVAL2	22
> +#define OPS_RETVAL3	33
> +
> +int retval_saw1;
> +int retval_saw2;
> +int retval_saw3;
> +
> +SEC("struct_ops")
> +int BPF_PROG(tcp_ops_retval1_timeout_init, struct sock *sk, struct request_sock *req)
> +{
> +	retval_saw1 = bpf_get_retval();
> +	return OPS_RETVAL1;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_tcp_ops tcp_ops_retval1 = {
> +	.timeout_init = (void *)tcp_ops_retval1_timeout_init,
> +};
> +
> +SEC("struct_ops")
> +int BPF_PROG(tcp_ops_retval2_timeout_init, struct sock *sk, struct request_sock *req)
> +{
> +	retval_saw2 = bpf_get_retval();
> +	return OPS_RETVAL2;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_tcp_ops tcp_ops_retval2 = {
> +	.timeout_init = (void *)tcp_ops_retval2_timeout_init,
> +};
> +
> +SEC("struct_ops")
> +int BPF_PROG(tcp_ops_retval3_timeout_init, struct sock *sk, struct request_sock *req)
> +{
> +	retval_saw3 = bpf_get_retval();
> +	return OPS_RETVAL3;
> +}

Does bpf_get_retval() have the correct verifier range for struct_ops
programs?

This test is the first user of bpf_get_retval() from a struct_ops
program. The verifier refines the helper's return value in
do_refine_retval_range() (kernel/bpf/verifier.c):

  case BPF_FUNC_get_retval:
      if (prog_type == BPF_PROG_TYPE_CGROUP_SOCKOPT && ...) break;
      if (prog_type == BPF_PROG_TYPE_LSM && ...) { ... } else {
          range.minval = -MAX_ERRNO;
          range.maxval = 0;
      }
      reg_set_srange64(ret_reg, range.minval, range.maxval);

BPF_PROG_TYPE_STRUCT_OPS takes the else branch, so after calling
bpf_get_retval() the verifier believes the value is in [-MAX_ERRNO, 0].
reg_set_srange64() unconditionally assigns that range rather than
intersecting with the actual possible values.

But that claim does not hold for bpf_tcp_ops. bpf_tcp_ops_get_retval()
(net/ipv4/bpf_tcp_ops.c) returns the chained value from the previous
struct_ops program's return, which is unconstrained: check_return_code()
bails out early for struct_ops members whose return type is not a
pointer, and .timeout_init returns plain int with no range check.

The test's own assertions prove the divergence: the code above expects
retval_saw2 == 11 and retval_saw3 == 22, both outside [-MAX_ERRNO, 0].

The test itself is harmless because it only stores the value to a .bss
int. But the incorrect range could allow unsafe code elsewhere:

  int v = bpf_get_retval();   /* verifier: [-4095, 0] */
  arr[-v] = 1;                /* verifier: index in [0, 4095], accepts */

A preceding bpf_tcp_ops in the same cgroup could return an arbitrary int
(say -1000000), producing an out-of-bounds access the verifier accepted.
The incorrect range also lets the verifier prune 'if (bpf_get_retval() >
0)' as dead code, so a program could silently behave differently from
what it says.

This gap was introduced in commit 5c9c5dca9cbb1 ("bpf: tcp: Support
selected sock_ops callbacks as struct_ops"), which added
bpf_tcp_ops_get_retval_proto with .ret_type = RET_INTEGER without
teaching do_refine_retval_range() that struct_ops/bpf_tcp_ops has no
-MAX_ERRNO..0 restriction. A forward search over the provided range
bf0fde93fa8f6..d499152306e78 found only one later commit
d499152306e78, which does not address this; the gap is unfixed at the
end of the series.

Either do_refine_retval_range() needs a struct_ops case that leaves the
range unrefined (as CGROUP_GETSOCKOPT does), or the chained struct_ops
return value has to be clamped to [-MAX_ERRNO, 0] where
bpf_tcp_ops_call_int() stores it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35271288839
--===============5066564868234564915==--
