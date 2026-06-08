Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4F318EC4
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924067; cv=none; b=tQ2n58S9IcQbvawG4rQlFuMvNEiEZhpIHpP+lCEY5bNDZ84pPimDkkHuDoGKQpGq1prdibrn3Z16+qR05po5RsBA4+rCFr4vTyFDrY9B8iPFnrYcJgzeE1R+JunJkNx7ZizZhBEXf2dFIIqgoTVBpmOETBiYs+gVDO3EwIvbisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924067; c=relaxed/simple;
	bh=k3FaDv+dQ91HYeP/i60rAJUIrZIYTuKcRZvWW4igSxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QPmDq4F0ohuNyrl+ffwZJqDrze671DTFoCWjvw2hjP18tQP8gdLAdwkr5+69MSLPnJ0xTFgzwKacPwhEyFIYnomruH7yAkhB6MlWfymoLuQnwwLIpO3gmq2XNFGGkDvqvoIQbzWUbFaRcXDVlXnQNTus9D0KqpmSxQ7BGNN30BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn+1M/ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn+1M/ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218891F00898;
	Mon,  8 Jun 2026 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924066;
	bh=6T52wI1R5y0HNvQJWKu3IcIHHqBfBFRspHIoyse9f7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jn+1M/ro5VNSTVD6s/UE3rXlQi+0IF+30jDvG9Li0fQGqDYs8D+0ioilMbqO4CNF2
	 UJ092Gsp+CaKYKyAhmmOe/OuHQkUf6OUO0Pc6nEHRSJyNESLsz2hB3yWyWR33FhQ/5
	 2PpE5TI8W7KAtyRVJoOnQGSveQLUwXxDrjcumRss7e8zb+qGuk25cmhQ5rwSE/aZhk
	 wzIkdecdirRP7LIYcHk9pT6sGMXvA0L3z6L5Qh30lpAQsNSUjjMxGLTzNnCx5cLBXQ
	 4SmrHlV4gGw9l9ke5qMjWUu5kHMV/0Q7ftXRriWcvUINKTTTMhnFxFdjkiBdi7/JtQ
	 YJtnzblktSXVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v8 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608125846.157004-3-jiayuan.chen@linux.dev>
References: <20260608125846.157004-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:07:45 +0000
Message-Id: <20260608130746.218891F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment opening `/*` is not on its own line, violating B=
PF subsystem style.
--

commit f9aa00c40e1871ad0a9a7344e06b70dd2c1b3f81
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()

This commit adds a new BPF selftest test_tcp_custom_syncookie_protocol_check
to verify that bpf_sk_assign_tcp_reqsk() correctly handles assigning a TCP
socket to a UDP skb. It ensures the network stack doesn't crash when passing
the skb through the UDP receive path.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c

[ ... ]

> +/* TCP and UDP servers share the same port. The BPF program intercepts
> + * the UDP packet, looks up the TCP listener via the dest port, and
> + * attempts to assign a TCP reqsk to the UDP skb.
> + * Although bpf_sk_assign_tcp_reqsk() assign udp skb to tcp reqsk, the
> + * network stack should not crash.
> + */
> +static void run_protocol_check(struct test_tcp_custom_syncookie *skel,
> +			       int family, const char *addr)

[Severity: Low]
This isn't a bug, but does this multi-line comment format match the
preferred BPF subsystem style? The guidelines require the opening /* to be
on its own line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608125846.1570=
04-1-jiayuan.chen@linux.dev?part=3D2
