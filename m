Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972508;
	b=bC0JhFal/xMyvvRFeKK5P5EHb/NOt58EihfD++pLLTKkNytxUbj4WnDsk767fqA9NBOl
	 SUbY2aO4TBaWjkbxQlMhsTMZmkgvy98RYMyUhG24NXpqaayvr290gsv5ynXJhroQImoKm
	 SkN8RgqlANlBuqagqbdoPsRZzqzZ8e6jBByGPquvywk/q1aBmwCbpfYl58S5pKyoWfYPX
	 /jF2UJslQEdhaXwxWsSFEhbmxKl0Lo2vlw9Hou8Y5pnyVFthe0V1Ropf2vvx3QYBDjlKT
	 xWLU8bBSu458Ql7klxH3erbxxsUTgX4QFRYc/sjwZFJhICVI0N15mLDeU522wGtoi5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q1vUfcXJI1VypNhYKESLwEYuPg93SNadlbkZtQM09tg=;
	b=zIwvi11C1jyAt18QAByS3WfmHy2mFXVwG6dRZUz21mDcHZbtGEfX/2EUggApSZEXjzkW
	 cxzBEF41eORyCV3sY3t2rUT3IfvE0dlKGGMS7I8W+ifqsb+T5ZlfomH/2V8J8uz/J0fSu
	 05NQKls+sbq8fcMDkHrbqgA+8Xlm+OfkpEB0OWwI2YnZLmlKNRttFh7ipylC9SkOaoRx5
	 1bqx9nYuV5hsQ6NGCnNoiVwpaRvonI1fjSlbgq/40IIsKLJZis+0ldCLrhK50OOxDntm4
	 32Qh+Ra9Wj/GW62cVqQMEAoYmKLKf6FNtD4Fkvu0rkc1xBENtWEJhXk41E9Va76yDpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAmOjFRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B19606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAmOjFRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BAF1F01825;
	Sun, 25 Oct 2026 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792972508;
	bh=q1vUfcXJI1VypNhYKESLwEYuPg93SNadlbkZtQM09tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAmOjFRJjHEBG2XE7nMY8pf4PhtOlwMjlrpEUc6JnGvAU1vFrdXUwDOI/j4qv6HXX
	 yE6eCEufC34JqFdoW9vb8j2dZPZwIo7/P0mcp/uNZkOHvLYxWOMVeFKySbM9DK05G/
	 ReZ5o/XJ/4cxO7cgSFiUhPR3Bb4Yoimqq2O14g6oe2V2FnntC7trOyPjcIeAR7gFrf
	 V6Hulivz7rZRMZAm6sGa1ti/x7Jsf6BukxlTciHQ7v3nOfvYEennGrvP0MVSDoyhBC
	 1dAtZjZiNXBRk6LDcu+P4mMf3HLzEYeecZRuRFj56oS4oIZWcsajzYhUzmfSUbm208
	 NGuvkE2szmHlg==
Message-ID: <sashiko-outbox-184525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Redirect a bare FIN to another
 socket's egress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eli Skeggs" <kernel@eliskeggs.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261025-sockmap-bare-fin-v1-2-bb8feae7c4a7@eliskeggs.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
 <20261025-sockmap-bare-fin-v1-2-bb8feae7c4a7@eliskeggs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 23:55:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: non-standard multi-line comment style in sockmap_bas=
ic.c
--

commit 75aa8de4d43476db90b5d4bdecc71a03ce93e92c
Author: Eli Skeggs <kernel@eliskeggs.com>

selftests/bpf: Redirect a bare FIN to another socket's egress

This commit adds a sockmap selftest that redirects a bare FIN from a
half-closed socket to another socket's egress and verifies that data
subsequently redirected from a third socket still transmits without
setting an error on the destination socket.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1fef6ec2ba7ae..e1e477ce72b32 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1325,6 +1325,78 @@ static void test_sockmap_multi_channels(int sotype)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +/* A bare FIN turns into an empty skb. When redirected to another socket,
> + * verify that it does not break the destination socket's psock. Data
> + * later redirected to the destination socket must still transmit.
> + */
> +static void test_sockmap_skb_verdict_redir_fin(void)

[Severity: Low]
This isn't a bug, but in tools/testing/selftests/bpf/prog_tests/sockmap_bas=
ic.c
above test_sockmap_skb_verdict_redir_fin(), the new multi-line comment plac=
es
text on the opening /* line. Could this follow the BPF subsystem multi-line
comment style by placing the opening /* on its own line:

/*
 * A bare FIN turns into an empty skb. When redirected to another socket,
 * verify that it does not break the destination socket's psock. Data
 * later redirected to the destination socket must still transmit.
 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-sockmap-ba=
re-fin-v1-0-bb8feae7c4a7@eliskeggs.com?part=3D2
