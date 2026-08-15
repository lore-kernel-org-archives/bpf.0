Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E939099E
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781697; cv=none; b=bith8SLCKVsO9ZhRXDwnCtYRJaPxJwMGI02vyxMcoASYmRirq9rWQLSh66m23dGuavJSvTrAtI+6wfA13tyTevXZ1Vj84+tA14aW33AfP6OUv6Yt1fL2BXF7A9+HUZimtd5/36QZdXwnsCe4bRl1pZmrrXQYpJL1Wjzj0bqHGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781697; c=relaxed/simple;
	bh=xpG3cDx1FeH4xneOWLsyu/3KiYaSpfiFphOz81T7N6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kzb0ZsezQ9gVHbdWI/AWeDM0+YboAd5kObUeF7+Sl/5ftkwbZFxSN9DrRX/m3Ee3HU1qqLyqu10cLaQ3iq92C/Zwvtr3p4amAH6yQ9Q4bHUIDcxOTsBBIqyDmQIwxTAGjYdEmAH00yMb5pDFG9EdM+4+Q2CcHQeLl+PK8QIuHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iukxzyHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iukxzyHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A461F000E9;
	Sat, 15 Aug 2026 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781696;
	bh=HN0a9RZGY475552iiqSl+Xdldyg0p/fMMffuPMhUj4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iukxzyHNQr2ZOhZ5m4IUUJNXG39n8qup3Qp6xj/tsk9PgvaJYZ+nthOqVaPrE5izQ
	 hBJqCRGJPfgf80QL0E2XUxkNUqCKJjiqUiUSoqAG+mLkqRU5c1DG5hj29j3ECXOANX
	 ea4/YXPLLua69klhHR1YUfQjx5/4q7a5mJcqhEWBns9vZAmN+S34vbzPx7sXRKK5G0
	 EXVZVr2xyJPd7U0Z91hOJy5U2Tenixd2nLMHwwNFvIaAuo4rHM97V6jHGiHZorRebV
	 gqxLUfQiD3AvQbThrlL/IA+dGJkeyye6p5uNnBZdIrXPqGfNPrAmEIw4o8DbRpfiwN
	 eMevnV4IAbVKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 11/14] selftests/bpf: Test skb_ext from LWT in,
 out, and xmit hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-11-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-11-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:55 +0000
Message-Id: <20260815081455.E7A461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The error check for `get_socket_local_port()` is rendered comple=
tely ineffective due to assigning the result to an unsigned 16-bit integer =
before comparison.
- [Medium] Unconditional execution of `bpf_tc_hook_destroy(&tc_hook)` on th=
e error path can delete the `clsact` qdisc from the base network namespace.
- [Low] The multi-line comment for `test_skb_ext_lwt` violates the BPF subs=
ystem comment style guidelines.
--

--- Patch [11]: [PATCH net-next 11/14] selftests/bpf: Test skb_ext from LWT=
 in, out, and xmit hooks ---
commit 7845f94d2569f8018cf274a4a851280db3c38a3a
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext from LWT in, out, and xmit hooks

Add cross-hook tests for bpf_dynptr_from_skb_ext() covering all generic
LWT program types. For lwt_in, a TC ingress program writes skb_ext on
loopback and the LWT program reads it back. For lwt_out and lwt_xmit,
the LWT programs write skb_ext on the output path and a TC ingress
program reads it back after loopback.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 82c57ea3957e3..7a7537ef80e75 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -1303,6 +1303,95 @@ static void test_skb_ext_nf(struct test_xdp_meta *=
skel, const char *name)
>  	netns_free(ns);
>  }
> =20
> +#define LWT_EXT_PIN_PATH "/sys/fs/bpf/skb_ext_lwt"
> +
> +/* Test skb_ext across LWT hooks on loopback.

[Severity: Low]
Does this violate the BPF subsystem multi-line comment style? The opening /*
usually needs to be on its own line before the text begins.

> + *
> + * @lwt_prog:  BPF program to pin and attach via ip route encap
> + * @encap_dir: "in", "out", or "xmit"
> + * @writer:    true if lwt_prog writes skb_ext (reader on TC ingress),
> + *             false if lwt_prog reads skb_ext (writer on TC ingress)
> + */
> +static void test_skb_ext_lwt(struct test_xdp_meta *skel, const char *nam=
e,
> +			     struct bpf_program *lwt_prog,
> +			     const char *encap_dir, bool writer)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> +		    .ifindex =3D 1 /* IFINDEX_LO */,
> +		    .attach_point =3D BPF_TC_INGRESS);

[ ... ]

> +	__be16 port;
> +	int ret;
> +
> +	unlink(LWT_EXT_PIN_PATH);

[ ... ]

> +	port =3D get_socket_local_port(server_fd);
> +	if (!ASSERT_GE(port, 0, "get_port"))
> +		goto cleanup;

[Severity: Medium]
Will this error check work as intended? The get_socket_local_port() function
returns an int, which is -1 on error. Since port is declared as an unsigned
16-bit integer (__be16), the -1 gets converted to 65535, causing the
ASSERT_GE(port, 0) check to always evaluate to true.

[ ... ]

> +cleanup:
> +	if (fd >=3D 0)
> +		close(fd);
> +	bpf_tc_hook_destroy(&tc_hook);

[Severity: Medium]
Could this unconditionally tear down the clsact qdisc on the base namespace=
's
loopback interface if an error occurs early?

If a failure happens before the network namespace is created or before
bpf_tc_hook_create() is called, the thread is still in the original
namespace. Since tc_hook is statically initialized with .ifindex =3D 1,
will this destroy the hook in the wrong namespace?

> +	if (server_fd >=3D 0)
> +		close(server_fd);
> +	netns_free(ns);
> +	if (pinned)
> +		unlink(LWT_EXT_PIN_PATH);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D11
