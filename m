Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C937F32C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682052; cv=none; b=shWUO3m7J9XMzQD77Bbn5UZzyC96YfaE6RtVRj9q8SBeboBOX6YGAUPlU4Y6UyHVP7vj2JJqOSTtbscL/Eemvc48DWC2Gpe+vlKitpiQrVzSdZwunV6t/FsT2TizcA82aGY3QVu96ocao1PwdZ+1Qv2bJ/Yk0kbaBL9b3sT+j7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682052; c=relaxed/simple;
	bh=KRyi1UFX694OqnC6MQU1BKfvWw7i0wR7lvRltdImtG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPB3Dv9DZJYjmVZ5I5wgCFSu8XYd4tRly/7IrWed+hNC8lgFRALqhyvgWnYjX52Kk2rwOChP7uD+JISz1cPucrkKEA9JFL5/OlxZfufMOIpj4Cbm9Tx01FhPSj8qNoUiwwcorGdD+ZZNKJbK4ivvWORqJyo7vc7vOWZRmx7FscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8aAJHBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8aAJHBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C551F000FF;
	Tue, 29 Sep 2026 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682050;
	bh=G6se5UkVjvdhAOtlq9VMZ6jehOY/5hfkooV9hrYAHNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8aAJHBQiFLDH5048s32pSM5WvKEIXnOZ54jzNAPp++lIbQ2xkQJ5byP9xPKandJc
	 o0CNh4jfdarq+AZ5SzjaPP6hcaFLXv+0o6IcjWxhEb2KELHl0VXz+oO7y1PliYtZU6
	 1FmWNXrPYUWCU3a3ypJlGR/gHzFfAqFdCgcKrBHFrkn+urJRxNmyLfnbgxLEnrkAMM
	 EeXUfoIihTjMlQ+RSaerzZQKJVjLf2ZOU3VJCVF7lLo+2O2LRbLawaNgur4GHX+4sD
	 rjk77zvFPTqeBmdzzUpp+tV/PPo4gbHnMz7DHu9sFASdl7Un5YLY1OCYHAMmezsvWW
	 IaETVgv3n2gZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 06/15] selftests/bpf: Test passing metadata
 across veth and GRE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-6-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-6-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:50 +0000
Message-Id: <20260929114050.A9C551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: test flakiness due to hardcoded netns/device name collision
--

commit 4f7f4b87639860030b5545295e6b1cde37989dbf
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test passing metadata across veth and GRE

This commit adds tests to stash metadata at TC egress and read it back at
TC ingress after the packet crosses veth and GRE device boundaries.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c

[ ... ]

> +/* Test if skb_ext survives veth cross-netns forward */
> +static void test_skb_trace__veth(struct test_xdp_meta *skel)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tx_hook, .attach_point =3D BPF_TC_EGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tx_opts, .handle =3D 1, .priority =3D 1);
> +	LIBBPF_OPTS(bpf_tc_hook, rx_hook, .attach_point =3D BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, rx_opts, .handle =3D 1, .priority =3D 1);
> +	struct netns_obj *rx_ns =3D NULL, *tx_ns =3D NULL;
> +	struct bpf_link *put_link =3D NULL;
> +	struct nstoken *nstoken =3D NULL;
> +	int rx_ifindex, tx_ifindex;
> +	int ret;
> +	int i;
> +
> +	put_link =3D bpf_program__attach(skel->progs.skb_free);
> +	if (!ASSERT_OK_PTR(put_link, "put_attach"))
> +		return;
> +
> +	tx_ns =3D netns_new(TX_NETNS, false);
> +	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
> +		goto close;
> +
> +	rx_ns =3D netns_new(RX_NETNS, false);
> +	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
> +		goto close;
> +
> +	SYS(close, "ip link add " RX_NAME " netns " RX_NETNS
> +	    " type veth peer name " TX_NAME " netns " TX_NETNS);

[Severity: Medium]
Does this cause test flakiness due to hardcoded netns/device name collision=
s?

When test_progs executes independent top-level tests in parallel using
multiple workers (-j), tests using identical globally-visible network
namespaces and device names can concurrently attempt to create the same
resources. This results in an "already exists" failure for the slower test.

Since TX_NETNS, RX_NETNS, TX_NAME, and RX_NAME are identical to those used
by test_xdp_context_veth in the same file, would it be better to use
dynamically generated or test-specific names here to avoid collisions when
these tests run concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D6
