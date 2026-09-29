Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E99516173
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682053; cv=none; b=nXFrCd3stUhnVL5vpJzXTXUAN0TmsBx3MBrqWxK6w8jdFjAFKQFL25LxADTuL3RPKpSg6lXGHm6jhHkLIuNGh+f8tzapOI7mwKNvM1Qono8RUrij7+TgEt/J26p0dVZ0QPkRhJ4XGKfPJwvOfEw5spzo7L2YNiZQpQamLFiZYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682053; c=relaxed/simple;
	bh=7LIy6hD9BpFhT3KXvzrcevWLsRX8kqdT/AQ6osn1Adc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SCqAZXA65CkLIVrJGW8ZVmmrZCwS1VARPb91h8lt4g+YJqPfKy5PHl2OGPIj2rUimTfocDqY0Dk6aOFMSHL5xcm/VIJjElt/s+Xd7zohxe0i91QJsaO1RXRn1bkNeFlVObJKJkJV72bw3PvbicY0/fVxZGKcro3T4gNjTkeUXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdHjcqIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdHjcqIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1A21F00893;
	Tue, 29 Sep 2026 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682051;
	bh=jwZ9G/89d2VOgAUXM1Ewr6AOvVhZGmur5Gtb19J18Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MdHjcqIzAJ2AVe4SwS82aSsbju8uGvoHvFCQE/ayJy66iUP/fUWCNaLYqso2X3Fog
	 RLEzdyypsA57gjHtErIRlPIV3GmpkGdQDYLu/bQ+2Ox/5fFGfqeM8hUEOSoR6Jr8ii
	 tiLTYh4Or6nbqtg7GxkcU2TZVprqJxfmnpUDSFufCSsUZyMY++SpvDGrKuSTOK/X4B
	 JzpjoJ22BEBV6HtSV2UpmpR1oFKk5IpNuirHZhy3Ab+YfXrHek5OEmIG/x/14L9IZ3
	 HqrnApmKGBqWh+gE/FKax6Y88dHFpEpAsZX80eEn3D1pGUeJfotNiaY29A8qwkeOm7
	 A3fvxGSLLNOJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 07/15] selftests/bpf: Test metadata passing to
 cgroup_skb and sk_filter hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-7-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-7-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:50 +0000
Message-Id: <20260929114051.5E1A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: unconditional bpf_tc_hook_destroy on error path flushes hos=
t TC filters
--

commit b7bdaa1e031c5e65e9e6042ac51a026c08301467
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test metadata passing to cgroup_skb and sk_filter hooks

Extend metadata cross-hook coverage to UDP readers: attach a TC ingress
program on loopback that tags the skb, send a UDP datagram over loopback,
and read the stashed metadata back from a cgroup_skb/ingress program and
from a socket filter attached with SO_ATTACH_BPF.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 1155e868ffbd7..25a16daf5fdf3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> +static void test_skb_trace__udp(struct test_xdp_meta *skel, const char *=
name,
> +				enum udp_reader_type reader)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> +		    .ifindex =3D 1 /* IFINDEX_LO */,
> +		    .attach_point =3D BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle =3D 1, .priority =3D 1);
> +	struct bpf_link *reader_link =3D NULL;
> +	struct bpf_link *put_link =3D NULL;
> +	struct netns_obj *ns =3D NULL;
[ ... ]
> +	ns =3D netns_new(name, true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		goto cleanup;

[Severity: Medium]
If netns_new() fails here, the process remains in the original network
namespace and jumps to the cleanup label.

Could this lead to unintended side effects when bpf_tc_hook_destroy() is ca=
lled
below?

> +
> +	cgroup_fd =3D test__join_cgroup("/skb_ext_udp");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto cleanup;
[ ... ]
> +cleanup:
> +	bpf_link__destroy(reader_link);
> +	bpf_link__destroy(put_link);
> +	bpf_tc_hook_destroy(&tc_hook);

[Severity: Medium]
Since tc_hook is statically initialized with ifindex =3D 1 (loopback), and =
it
is destroyed unconditionally on the error path, could this unintentionally
delete the clsact qdiscs and TC filters on the original (host) namespace's
loopback interface if netns_new() fails?

Would it be safer to only destroy the hook if it was successfully created?

> +	if (server_fd >=3D 0)
> +		close(server_fd);
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +	netns_free(ns);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D7
