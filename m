Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001651616B
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682054; cv=none; b=qYb4PL7DzMCqSVFpGPX30NPEdhC9RpoWDClmBgR7ZtIOYIfyhYqwsC7wYLjps5gQXJ8uL2g6kmmjAISCazDk6K8uhOtp8JVA5gXbCOEdaKot89qLjNN79dsA/JLGXCkKK0VFHsQ8w2ZnuxAP2ImLL3Z0qOk7+Mba2WbU4E3jkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682054; c=relaxed/simple;
	bh=Vn8awTpgCUgEaEOLHX4w9aimI1gdGAI6OScdBrcMqFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DUy2lt6jWP+eYVvaR99TVDbUH4qX+ce5MV5WJSXgSO2e63VdDQDycQJmVbzVhxKYmEz41vXsl9AOJG5iE7EF+rvPZsA4y2Ta9ZBLrbzS1gyR5sr5sfjv8CrknCKntbxkoAyQc96tQ/7qBL4ga5AQM8NN0yq8DKEe9YpRpp4OCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNS+Vl5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNS+Vl5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD491F0089A;
	Tue, 29 Sep 2026 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682052;
	bh=YAPua7xqopnnzEc3Fl9FD2hLxIqz+YvHoA6gydP+UiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNS+Vl5GHuhTn4o3PqZlhQ9upBRh/ndlJ2Q9fyiPUt/KufUKYQCV0J65gpDHR8Udz
	 VVuR9mSg7gYxLtKFCCyOsDSQLetnISLX/HLn7C6iGPpPyjK0JLpiPq9cGB3hiO8As4
	 bfVwVUc+oKmk7VcAkhZSKeziaFnyaPg8GfXqQwbg3QEUw6Yolyoi4XQ5cPZtigY4QI
	 aPfw9a7ayWq78hdgUVQd/tg/z7Y5SBy7yrUH6LJWbKIUI/jV9FQsLOg3uf2mt9UdmB
	 GhoOAWzBOVYhgvUOKqzTh9obhupVyW3iRmCLKT+tqFM3/vBDFnZWWgUK1xzzol2VI0
	 gPAPqs482JJ2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 08/15] selftests/bpf: Test passing metadata to
 sock_ops and LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-8-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-8-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:51 +0000
Message-Id: <20260929114052.0FD491F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: flawed TCP free_count wait logic causes test race
- [Medium] bpf: unconditional bpf_tc_hook_destroy deletes root qdisc on err=
or
--

commit b0a956d5cfe493a1e0f2beca58e7a9622aea9f34
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test passing metadata to sock_ops and LSM hooks

This commit extends metadata cross-hook coverage to the TCP ingress path by
attaching a TC ingress program on loopback that tags the skb and reading the
stashed metadata back from a sock_ops program and an LSM hook.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -1162,6 +1162,112 @@ static void test_skb_trace__udp(struct test_xdp_m=
eta *skel, const char *name,

[ ... ]

> +static void test_skb_trace__tcp_ingress(struct test_xdp_meta *skel, cons=
t char *name,
> +					enum tcp_reader_type reader)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> +		    .ifindex =3D 1 /* IFINDEX_LO */,
> +		    .attach_point =3D BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle =3D 1, .priority =3D 1);

[ ... ]

> +	ns =3D netns_new(name, true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		goto cleanup;
> +
> +	cgroup_fd =3D test__join_cgroup("/skb_ext_tcp");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto cleanup;

[ ... ]

> +	/* Poll every 10 msec up to 1 sec */
> +	for (i =3D 0; i < 100 && !skel->bss->test_pass; i++)
> +		usleep(10000);
> +	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
> +
> +	/* Skb is freed after RX delivery; wait for free tp */
> +	for (i =3D 0; i < 100 && !skel->bss->free_count; i++)
> +		usleep(10000);
> +	ASSERT_GE(skel->bss->free_count, 1, "free_count");

[Severity: Medium]
Can this wait loop exit too early and cause a test flake?=20

Since tc_meta_write_port() unconditionally tags all TCP packets matching the
target port, the SYN and SYN-ACK handshake packets will also increment
free_count when they are freed.=20

The wait loop here will see a non-zero free_count from the handshake and
terminate immediately, bypassing the wait for the final ACK packet.=20

Does this leave a window where the test proceeds to check the map state
while the final ACK packet might still be held by SoftIRQ?

> +
> +	assert_meta_stash_empty(skel->maps.meta_map);
> +
> +cleanup:
> +	if (conn_fd >=3D 0)
> +		close(conn_fd);
> +	if (client_fd >=3D 0)
> +		close(client_fd);
> +	bpf_link__destroy(reader_link);
> +	bpf_link__destroy(put_link);
> +	bpf_tc_hook_destroy(&tc_hook);

[Severity: Medium]
If netns_new() or test__join_cgroup() fails earlier in the function, the
execution jumps to the cleanup label while still in the original root netwo=
rk
namespace.

Since bpf_tc_hook_destroy(&tc_hook) is called unconditionally and tc_hook
defaults to ifindex =3D 1, will this blindly issue a netlink command to del=
ete
the clsact qdisc on the root namespace's loopback interface?=20

Could this destroy shared test state and cause cascading failures in other
concurrently running tests?

> +	if (server_fd >=3D 0)
> +		close(server_fd);
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +	netns_free(ns);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D8
