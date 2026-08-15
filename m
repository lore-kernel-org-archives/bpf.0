Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BF381EBB
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781695; cv=none; b=MwpjNSOVvIlVZotIFDXSLhWqk/ukc9cCv7Up+OMB4NXglrToL1l09AdQGcIB6HeGYAUVV3f8jbt+7NpjQjl1n1FJcv0AhM4NCwyvqngXMueRRrbvoKXYz+sf0PeGoQ6cWlI4l1H/piH5F5EIM3dkFgJAkqOnM9yIx2A2Y0gwdY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781695; c=relaxed/simple;
	bh=vM2BMpRbefa/QX2JHJKQL35oyNlQ62y8R+Ld4qUl8p0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WrJKLguRx6DPaSEr629YzSAgFT0BxInaBf+rs0uXbzKaDtJUfhki2rTZCYq/tgtlwG+L8YRWtff1Ur7tF5gGYZPOJcYBUOZGMrAAGXlO1knpEbZbV+0E+1aUkSNDIzshK38NFlUB2gyaHZesc6twxFOVEbQViIr25gypAaPPuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTqQz9IZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTqQz9IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC501F000E9;
	Sat, 15 Aug 2026 08:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781694;
	bh=3+6XwdSoNXPp1FOdj1AWcc7fgw7i04YZPGN7ghJUpOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cTqQz9IZDcGNIqh7E9n033oDMu+P9DkaSjKrhDEx5RkcPvz9iE/4ALO30lnWezXkA
	 arZru3Ab34jaxMhHF9xEPREjROPypK3SgeazermkbAWEQrvQWR8FO+Kb4w/G+op13Q
	 7z4tVry4zmRpTmDbm29an6CtPdbMrFgLltFd7BaZa3pl+dEvkMeIjMMQ+lJTojz5hV
	 Fub3Zh6QI532JU+7kxEdZ7EPl90UAg8RTf4o72gsJ791GsW8e1gxos5XnPEPE+nhKN
	 /EZmDQ+9uugpVZbAHlGRqwetjn/lwx6/p8MlPL8hpQ0jtW2MNJJ6I08q61CRCYPJgs
	 m32v0BYurtnfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 08/14] selftests/bpf: Test skb_ext read from
 sock_ops and LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-8-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-8-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:53 +0000
Message-Id: <20260815081454.4BC501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Invalid error check for `get_socket_local_port()` due to assignm=
ent to an unsigned `__be16` type.
--

--- Patch [8]: [PATCH net-next 08/14] selftests/bpf: Test skb_ext read from=
 sock_ops and LSM hooks ---
commit e995e7626c7fc8d98cbc259f8c506f6ec68e6a00
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext read from sock_ops and LSM hooks

This commit extends skb_ext test coverage to the TCP ingress path. It adds
a new test that attaches a TC ingress program to write metadata to packets
and reads it back using sock_ops and LSM hooks.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 808eb158fe0f1..e0ab0fccf9d7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> +/* Test skb_ext survival across TC ingress -> TCP reader hook */
> +static void test_skb_ext_tcp(struct test_xdp_meta *skel, const char *nam=
e,
> +			     enum tcp_reader_type reader)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> +		    .ifindex =3D 1 /* IFINDEX_LO */,
> +		    .attach_point =3D BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle =3D 1, .priority =3D 1);
> +	struct bpf_link *reader_link =3D NULL;
> +	struct netns_obj *ns =3D NULL;
> +	int server_fd =3D -1;
> +	int cgroup_fd =3D -1;
> +	int client_fd =3D -1;
> +	int conn_fd =3D -1;
> +	__be16 port;
> +	int ret;
> +
> +	ns =3D netns_new(name, true);
[ ... ]
> +	server_fd =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server"))
> +		goto cleanup;
> +
> +	port =3D get_socket_local_port(server_fd);
> +	if (!ASSERT_GE(port, 0, "get_port"))

[Severity: Medium]
Does assigning the result of get_socket_local_port() to the unsigned __be16
port variable defeat this error check?

get_socket_local_port() returns an int, which can be a negative error code.
If the function fails and returns a negative value, storing it in an
unsigned __be16 will result in a positive value. This would cause the
ASSERT_GE(port, 0, "get_port") condition to always pass, ignoring the
failure and potentially leading to unexpected test behavior.

> +		goto cleanup;
> +
> +	skel->bss->target_port =3D port;
> +	skel->bss->test_pass =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D8
