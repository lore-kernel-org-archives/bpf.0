Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133895172E8
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682055; cv=none; b=nwTZ3iN9+WAJ2ywVo3eHfGLzre1NH8mwhEpBZxtd8MjKAp3xGqJ2im6AwKUHwMgHoOrYokBXES1p+deqWwBEu0gNk0BrwUYLoPURYvYEwWiwvyAddPsvzGFzLxAkyQkWbuRd8w2VsyIJ001zcdRzazGq5DtnSZyPUnsUJhD8h9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682055; c=relaxed/simple;
	bh=r/hU7k2cGOn9cVcEebFaFDxlp6sNYWZV8aFaT5rQZj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HpNUZ452rlNboNa/XG42AN4B6TNH3xim+zA7/Gjnql/2SyaVdEyuv7ZOoc4SC6DStm636WyiEQ0Qcnot7gF13gQ7857QlsJ/v+mQMdB4Sz6uHD1hLfxV/aOZ9EoAcP4Hl5moaK5wLskzpbiRhJdtCBUY29Bmo5jkLc+Ag2eMyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSOvAVcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSOvAVcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01D71F00899;
	Tue, 29 Sep 2026 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682052;
	bh=03AtBL57GYrYXISf0KKuq+4v6nMLUupYIMGRoVF9Blw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSOvAVcApe72w5S+Z0x+gKtljORQpw3VSsxYgdNC77r6IMrO/1ueLqay4soKWN8OU
	 498tbW/LxD/iGxdbpBbpkjM1owY8tl4lpkxeTJ7zeRGpHq1RKd8VBQDnh99AiFdYNn
	 yexr9rms9xS/0NbZDlqC9Uhs7RKzoxqtfzsc8GK9wF8hprGYwdjHJ/9COHpITc2x2L
	 80JJdUmqDYy86Arah9te2u80Xht+EZCjNMRlJ+whGa3Ognmxdz3UeJkNCbZ08aO13v
	 KucATEiLohRyLyfqBBfW1Vg9oW6JV/owfx8eoQAB0R/3wpsgyqj8uw6EIT0lrBuocR
	 1hmzOkB+X6amw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 10/15] selftests/bpf: Test passing metadata to
 TCP egress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-10-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-10-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:52 +0000
Message-Id: <20260929114052.A01D71F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: test_skb_trace__tcp_retrans flakiness due to premature map =
assertion
--

commit 2cb521395baafb017de2859f1a86b8fa86c112a8
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test passing metadata to TCP egress
   =20
Tag the skb at cgroup/skb egress and read the stashed metadata back at TC
egress: for a regular TCP transmission, and for a retransmission, where
the first transmission is dropped at TC and the write-queue original,
tagged via bpf_skb_fclone_orig, passes the metadata to the retransmitted
fast clone via the copy tracepoint.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 890a881a6a1f8..ac5c0f067b3f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> +static void test_skb_trace__tcp_retrans(struct test_xdp_meta *skel)
> +{
[ ... ]
> +	/* First transmission is dropped at TC; recv unblocks on retransmit */
> +	ret =3D recv(conn_fd, buf, sizeof(buf), 0);
> +	ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "recv");
> +
> +	/* Poll every 10 msec up to 1 sec */
> +	for (i =3D 0; i < 100 && !skel->bss->test_pass; i++)
> +		usleep(10000);
> +	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
> +
> +	/* Skb is freed after RX delivery; wait for free tp */
> +	for (i =3D 0; i < 100 && !skel->bss->free_count; i++)
> +		usleep(10000);
> +	ASSERT_GE(skel->bss->free_count, 1, "free_count");
> +
> +	assert_meta_stash_empty(skel->maps.meta_map);

[Severity: Medium]
Will this polling loop terminate prematurely?

Since the first transmission is dropped at TC egress, it gets freed and
increments free_count to 1 early. This causes the loop to exit immediately
because !skel->bss->free_count is already false.

Could this cause assert_meta_stash_empty() to fail intermittently because t=
he
retransmitted clone and original write-queue SKB haven't been asynchronously
freed yet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D10
