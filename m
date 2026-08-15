Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363E366806
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781692; cv=none; b=trELWU3YujRmB8wfzaWdys5cdNuwYXBGETfnZuFc5zPZao0YVIrHA64GfdLhABkctWmWRZri/YAjO2P/fC1KpIm801W9+E5xvCCund1M8v/AAxuZgwdndlQ8oi0MhdpjWuSMbExVZuAP6phbXiLzX69RF4VfDYD0jzqgKSfAdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781692; c=relaxed/simple;
	bh=h3sjvFkk00O0WPBdKJ2zCE2hT9aXm32WOq4PoINgQHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSEhkbZAwfdJd+5e5IUogFii0DcMHjggj+0O0m3ZbOYc5RutWVgcNFLngv3e3OYYAu2g3r3avHlUunNOmE28ldgLlT6HXJlsrkZBoqfpbDfwBKMoVRyfLBAfY5uW177yweLzLJ5+xRDpIJkHQ/Nn3ohEXIfP2u9jo97hUwlO7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw7zsvMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw7zsvMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84391F00A3A;
	Sat, 15 Aug 2026 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781691;
	bh=6pOKHIyc5Bi5MRSPsCRgYDmlSwhDkZS7Qs6HRT+XWsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tw7zsvMmqH80NXX4axQBlJushDOUIyV9QeQXI8RGaEPgRGdkTCmu5rNgQEid35xtZ
	 HxNuVrCkWFddYeS+kPgjpflMNvrrpkb2KVlcbMhVtJQN1RtYFv6brhuJVQW3ocanW9
	 vpDHbdODtt62iSHzj6DSJORxDw/n7Y7SwQJXTsUk7xBc2SM4MSt5JeTMJNRGeAwrCa
	 Duz998gvVjH3oV7Wj7lrHnsmPMopZMFoDY/6KJapt3r695paUqr1d4GjwrYM/qhApR
	 f2GTcHCzTCHlhFVPOTU23wI/hRsNQVa5CDMFh2Rvytwfejj2XIPanOVrax8CIMaDnQ
	 lrTHGdxGLTGpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 05/14] selftests/bpf: Test skb_ext on cloned
 skbs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-5-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-5-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:50 +0000
Message-Id: <20260815081450.E84391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flawed assertion for `if_nametoindex` return value silently igno=
res errors.
- [Low] Multi-line comments do not follow the BPF subsystem comment style g=
uidelines.
--

--- Patch [5]: [PATCH net-next 05/14] selftests/bpf: Test skb_ext on cloned=
 skbs ---
commit 52378eb340683567339caa62c46774dede8267b1
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext on cloned skbs

This patch covers skb_ext behavior when an skb is cloned by TC mirred. It a=
dds
tests to verify that the extension written at tap ingress is readable from =
the
mirred clone and that COW works when the extension is modified.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index fd340e5538a34..58b793cf14e59 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -694,6 +694,95 @@ void test_xdp_context_lwt_encap(void)
>  	test_xdp_meta__destroy(skel);
>  }
> =20
> +/* Test if skb_ext survives skb clone (via tc mirred).
> + * dummy_prog runs on the clone (dummy ingress).
> + */

[Severity: Low]
This isn't a bug, but the multi-line comment does not follow the BPF subsys=
tem
style guidelines. Should the opening /* be placed on its own line?

> +static void test_mirred_clone_ext(struct test_xdp_meta *skel,
> +				  struct bpf_program *dummy_prog)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point =3D BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle =3D 1, .priority =3D 1);
> +	struct netns_obj *ns =3D NULL;
> +	int dummy_ifindex;
> +	int tap_ifindex;
> +	int tap_fd =3D -1;
> +	int ret;
> +
> +	skel->bss->test_pass =3D false;
> +
> +	ns =3D netns_new("mirred_clone", true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		return;
> +
> +	/* Dummy dev: attach reader */
> +	SYS(close, "ip link add name " DUMMY_NAME " type dummy");
> +	SYS(close, "ip link set dev " DUMMY_NAME " up");
> +
> +	dummy_ifindex =3D if_nametoindex(DUMMY_NAME);
> +	if (!ASSERT_GE(dummy_ifindex, 0, "dummy_ifindex"))

[Severity: Medium]
Since if_nametoindex() returns 0 on failure, will ASSERT_GE(..., 0) incorre=
ctly
evaluate 0 as a success? If the interface lookup fails, won't the test proc=
eed
with an invalid interface index (0) instead of catching the failure here?

> +		goto close;
> +
> +	tc_hook.ifindex =3D dummy_ifindex;
> +	ret =3D bpf_tc_hook_create(&tc_hook);
> +	if (!ASSERT_OK(ret, "dummy_hook_create"))
> +		goto close;
> +
> +	tc_opts.prog_fd =3D bpf_program__fd(dummy_prog);
> +	ret =3D bpf_tc_attach(&tc_hook, &tc_opts);
> +	if (!ASSERT_OK(ret, "dummy_attach"))
> +		goto close;
> +
> +	/* TAP dev: attach writer + mirred to dummy */
> +	tap_fd =3D open_tuntap(TAP_NAME, true);
> +	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
> +		goto close;
> +
> +	SYS(close, "ip link set dev " TAP_NAME " up");
> +
> +	tap_ifindex =3D if_nametoindex(TAP_NAME);
> +	if (!ASSERT_GE(tap_ifindex, 0, "tap_ifindex"))

[Severity: Medium]
Similarly, will this assertion accept 0 as a valid interface index on failu=
re
and result in confusing downstream errors during bpf_tc_hook_create()?

> +		goto close;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/te=
sting/selftests/bpf/progs/test_xdp_meta.c
> index 43840ee32d359..1b6bb20ee7e85 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> @@ -874,4 +875,49 @@ int tc_skb_ext_double_alloc(struct __sk_buff *ctx)
>  	return TC_ACT_UNSPEC;
>  }
> =20
> +static const __u8 meta_zero[META_SIZE] =3D {};
> +
> +volatile bool clone_cow_done;
> +
> +/* Overwrite skb_ext on the clone via F_CREATE (COW) -- must not affect =
original.
> + * Runs on the dummy ingress (clone side), synchronously during tc mirre=
d.
> + */

[Severity: Low]
This isn't a bug, but could the opening /* be placed on its own line to adh=
ere
to the preferred kernel multi-line comment style used in the BPF subsystem?

> +SEC("tc")
> +int tc_skb_ext_clone_redir_cow(struct __sk_buff *ctx)
> +{
> +	struct bpf_dynptr meta;
> +
> +	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
> +		return TC_ACT_SHOT;
> +
> +	/* Zero out the clone's ext -- must not affect original */
> +	bpf_dynptr_write(&meta, 0, (void *)meta_zero, META_SIZE, 0);
> +
> +	clone_cow_done =3D true;
> +	return TC_ACT_SHOT;
> +}
> +
> +/* Verify COW isolation at kfree_skb time: once clone_cow_done is set,
> + * check that the original skb still has meta_want.
> + */

[Severity: Low]
This isn't a bug, but could the opening /* be placed on its own line to adh=
ere
to the preferred kernel multi-line comment style used in the BPF subsystem?

> +SEC("tp_btf/kfree_skb")
> +int BPF_PROG(tp_kfree_skb_cow_check, struct sk_buff *skb)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D5
