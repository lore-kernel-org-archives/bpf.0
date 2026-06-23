Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3472571B8
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241219; cv=none; b=TydyGJ7xRXU5RmslBwOM1qGNZJC3/RtvnuDmJH/fqWx9Hivz8uJ7CNBnYgWwLa9otyvBjlzHxBB1/nVjg0FtruFXwh0W6xoo79DrPUypNS3MqNYWsFbqqpGZcbyTxwOG6T/aGAc4idqowpUAcJvYQ2P3+OMnrVlkHcx2Viuo+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241219; c=relaxed/simple;
	bh=+n2a8mgCQ37M9SN1miiVenUDaSME+3FUA9wHsWvwpNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZP78+Kx1wlkpj13wxWnUxTDD1mL6cF2hwRXdlGbjkUGamkBGmv5iDdnTQYQYdXcn9WoZ4K9mPIPSk3bDbXw76dxOThKj8oI1YJOMHu52pALkoPVrayOzVw0V/m+0vC1Ioc6vQAXxtfZZBpf6C41TSGnCP+rxdZ198JIDtwRe32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz3rJyfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz3rJyfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5A11F000E9;
	Tue, 23 Jun 2026 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782241218;
	bh=PVMcEdeTk4Kx+Yydq1W1OXIJHoF20+m1mYNIi3Cv0jI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uz3rJyfDir2S+fXbVrhxCirH/izIlEXELFIeoj8dgm8uuSH+iGQZzqeh5Iokha7r0
	 6sUBFz49g7LANrT8Q7lh73pw1uwdiWfyaLxH3LJ47C+93RXzp3Au8o/ht5s/ZseCiA
	 ufB/IPQm5O3Z7T6O1ncjxrvesY++dW+utsSRQ/77HcKnb7jCBvLB5+KowVuzSWpO0f
	 xC006kJ/cSuVIYllhIOuLJ+LSJ1RoNiO/MKPE8anru5nxqSIkKDqb/Cc3oiwQ4lpl3
	 5iKxS+GwcR71PBIdx7bVzidz1HOEU5FrVLGrsc6LQIuOdCXVvT6kDYd9p5HYDUfm0j
	 5JDIX3T7tgYqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on
 sockmap lookup-bind-release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 19:00:17 +0000
Message-Id: <20260623190018.2B5A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The cgroup file descriptor `cg` is leaked because it is never cl=
osed in `test_sockmap_lookup_bind_release()`.
- [Low] The `struct sockaddr_in sa` is passed to the kernel via `xconnect` =
with uninitialized bytes in its `sin_zero` padding.

Pre-existing issues:
- [High] Calling `bpf_bind()` between `bpf_map_lookup_elem()` and `bpf_sk_r=
elease()` on a UDP socket mutates the socket's `SOCK_RCU_FREE` state, causi=
ng `bpf_sk_release()` to silently skip decrementing the reference count.
--

commit f32ef88a53a5c519bf4b22a337fa782c27f0ecda
Author: Michal Luczaj <mhal@rbox.co>

selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release

This patch adds a selftest to reproduce a UDP socket leak. It sets up a cgr=
oup,
attaches a connect4 BPF program, and triggers a sequence of socket operatio=
ns
(lookup, bind, release) that leaks the socket on an unpatched kernel.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93a..11972ffdb16ed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c

[ ... ]

> @@ -1373,6 +1375,52 @@ static void test_sockmap_multi_channels(int sotype)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +#define LOOKUP_BIND_RELEASE_CG	"/sockmap_lookup-bind-release"
> +#define LOOKUP_BIND_RELEASE_REP	64
> +
> +static void test_sockmap_lookup_bind_release(void)
> +{
> +	struct test_sockmap_lookup_bind_release *skel;
> +	struct sockaddr_in sa;
> +	int cg, i;
> +
> +	cg =3D cgroup_setup_and_join(LOOKUP_BIND_RELEASE_CG);

[Severity: Medium]
Does this leak the cgroup file descriptor?=20

The fd is acquired here and stored in cg, but close(cg) doesn't appear to be
called on either the success or error paths before the function returns. The
cleanup_cgroup_environment() function cleans up directories but doesn't clo=
se
the test's held file descriptors.

> +	if (!ASSERT_OK_FD(cg, "cgroup_setup_and_join"))
> +		return;
> +
> +	skel =3D test_sockmap_lookup_bind_release__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto cleanup;
> +
> +	skel->links.connect =3D bpf_program__attach_cgroup(skel->progs.connect,=
 cg);
> +	if (!ASSERT_OK_PTR(skel->links.connect, "attach_cgroup"))
> +		goto destroy;
> +
> +	sa.sin_family =3D AF_INET;
> +	sa.sin_port =3D bpf_htons(1234);
> +	sa.sin_addr.s_addr =3D bpf_htonl(INADDR_LOOPBACK);

[Severity: Low]
Does this leave the sin_zero padding of the sa structure uninitialized?

It looks like this partially initializes the struct on the stack.

[ ... ]

> +		if (xbpf_map_update_elem(bpf_map__fd(skel->maps.sockmap), &u32(0),
> +					 &sk, BPF_ANY))
> +			break;
> +
> +		if (xconnect(sk, (struct sockaddr *)&sa, sizeof(sa)))

When sa is passed to xconnect() here, can it leak the uninitialized padding
bytes from the userspace stack to the kernel?=20

Would it be better to fully initialize it using "struct sockaddr_in sa =3D =
{};"
or explicitly zero it?

> +			break;
> +	}
> +
> +destroy:
> +	test_sockmap_lookup_bind_release__destroy(skel);
> +cleanup:
> +	cleanup_cgroup_environment();
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_r=
elease.c b/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_relea=
se.c
> new file mode 100644
> index 0000000000000..cc77b193893bd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_lookup_bind_release.c
> @@ -0,0 +1,37 @@

[ ... ]

> +SEC("cgroup/connect4")
> +int connect(struct bpf_sock_addr *ctx)
> +{
> +	struct bpf_sock *sk;
> +	int ret =3D SK_DROP;
> +
> +	sk =3D bpf_map_lookup_elem(&sockmap, &(int){0});
> +	if (sk) {
> +		if (sk =3D=3D ctx->sk) {
> +			struct sockaddr_in sa =3D {
> +				.sin_family =3D ctx->user_family,
> +				.sin_port =3D ctx->user_port,
> +				.sin_addr.s_addr =3D ctx->user_ip4
> +			};
> +
> +			ret =3D !bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
> +		}
> +
> +		bpf_sk_release(sk);

[Severity: High]
This is a pre-existing issue, but does calling bpf_bind() here mutate the
SOCK_RCU_FREE state and cause bpf_sk_release() to skip decrementing the
reference count?

If bpf_map_lookup_elem() looks up a newly created UDP socket, SOCK_RCU_FREE
is not yet set, so sk_is_refcounted() evaluates to true and the reference
count is incremented.

Then bpf_bind() resolves to udp_v4_get_port(), which dynamically sets the
SOCK_RCU_FREE flag on the socket.

When bpf_sk_release() is called, it evaluates sk_is_refcounted() again. Bec=
ause
SOCK_RCU_FREE is now set, it evaluates to false, causing bpf_sk_release() to
skip the sock_gen_put() call and permanently leak the socket reference.

> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-sockmap-lo=
okup-udp-leak-v1-0-05804f9308e4@rbox.co?part=3D2
