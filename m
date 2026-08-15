Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2C37D130
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781694; cv=none; b=WXdvgMcayxjllIre+iSvlueotp9rPjydVFEJgTFehWVzqouAzAD6XZKudBG4zsq5fECx48RMPm7CV0zgad+WVWLwuH9T/9xIOVOWh3yqEiwuvtlT+bAX3Ozh3xWGK5pmX48OC+vNkhoY9bxvX+3NAFrCofNgOoufhriryim9jN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781694; c=relaxed/simple;
	bh=+c3Sp5DbVYoWP9nGHQktzzwL5GbRJlXf+mjDW1sqw8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBbTJezxrFbPtnBFvrxOxI6vR1Rel7ri6eIpAepscHK6UzIU/hEN1peNgHx8zpgTs5oWk7F58q5NlSEtSf/XKOImUwnUlCqb39WapW/cc1hM8/qzvXQvf5aaj00qjoHyad3U3qsUuYjySFLCDFuqIx7BSPIJpXgFPXZcTb7zLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luSLlOkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luSLlOkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC451F00A3A;
	Sat, 15 Aug 2026 08:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781693;
	bh=vM+EPw17zfvPbLVg6KxKe9frqLQATy/JiGadRB2X7iI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luSLlOkGjcqgkcvWCtFKzu5IsgPCzdXfe33a8pQkWc3A8nCpCYSYXQ9omaqq8d5QA
	 5Y4mg8HG43DDscnEhlGNwYkiU6zlxfFxBOrOAYOMyNd3jdf7tirRGwfUN9ngrXHaqn
	 84w7GjDH+3MyVu+TymU1jo632AT9LIjwuxc0zS8SLTV44YgROIrR545v5ZOB+BNCpk
	 4LWkgzlRUgmhmrCYO+5L1T3RiwyPS48jFGDKsKbaByG77Gq1lq0lgX5uOFRYLoT4El
	 YLe6XQEWp3xZJTXoGcXE6piBwxUl7r8McY0+Pq1vl2tBS4Bm+IV2XnM1sNtSJvQkez
	 Z3QyzxCsbdf2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 06/14] selftests/bpf: Test skb_ext survival
 across veth and GRE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-6-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-6-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:52 +0000
Message-Id: <20260815081453.5BC451F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect assertions for if_nametoindex() return values allow error=
s to pass silently.
--

--- Patch [6]: [PATCH net-next 06/14] selftests/bpf: Test skb_ext survival =
across veth and GRE ---
commit 9eef2d71b261cfaa465a5233213fb272dc34f416
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext survival across veth and GRE
   =20
This commit tests if skb_ext survives veth cross-netns forwarding and GRE
encap/decap. It writes skb_ext at TC egress and reads it back at TC ingress
after the packet crosses device boundaries.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 58b793cf14e59..de60303025361 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c

[ ... ]

> @@ -783,6 +783,156 @@ static void test_mirred_clone_ext_cow(struct test_x=
dp_meta *skel)
> +/* Test if skb_ext survives veth cross-netns forward */
> +static void test_skb_ext_scrub_veth(struct test_xdp_meta *skel)
> +{

[ ... ]

> +	SYS(close, "ip link set dev " RX_NAME " up");
> +
> +	rx_ifindex =3D if_nametoindex(RX_NAME);
> +	if (!ASSERT_GE(rx_ifindex, 0, "if_nametoindex rx"))
> +		goto close;

[Severity: Low]
Does this code correctly catch interface lookup failures?

Since if_nametoindex() returns 0 on failure, the ASSERT_GE(rx_ifindex, 0, .=
..)
check will evaluate 0 >=3D 0 as true, failing to catch the error. The test =
will
instead fail slightly later with a less descriptive error.=20

Should this be using ASSERT_GT() or ASSERT_NEQ() instead?

[ ... ]

> +	SYS(close, "ip link set dev " TX_NAME " up");
> +
> +	tx_ifindex =3D if_nametoindex(TX_NAME);
> +	if (!ASSERT_GE(tx_ifindex, 0, "if_nametoindex tx"))
> +		goto close;

[Severity: Low]
Is this the same issue here? if_nametoindex() returning 0 would bypass this
ASSERT_GE check.

[ ... ]

> +/* Test if skb_ext survives GRE tunnel encap+decap */
> +static void test_skb_ext_scrub_gre(struct test_xdp_meta *skel)
> +{

[ ... ]

> +	/* Write skb_ext on TC egress on GRE tx */
> +	tx_ifindex =3D if_nametoindex("gre_tx");
> +	if (!ASSERT_GE(tx_ifindex, 0, "tx_ifindex"))
> +		goto close;

[Severity: Low]
Is this the same issue here as well?

[ ... ]

> +	/* Read skb_ext on TC ingress on GRE rx */
> +	rx_ifindex =3D if_nametoindex("gre_rx");
> +	if (!ASSERT_GE(rx_ifindex, 0, "rx_ifindex"))
> +		goto close;

[Severity: Low]
And one more instance here where ASSERT_GE allows if_nametoindex() failure
to pass silently.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D6
