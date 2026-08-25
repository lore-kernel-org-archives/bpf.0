Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE23F99E3
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658964; cv=none; b=tk5mzfhCLrgK68DqkIzdrNrQeETWYfNyMxT9YGvbndLO62W4Ios/Bdx67nKzWe8nImMUBGyQ/JtewNtRpf34ZrOBwU34/L59O+n1+2FM7m9EXNG3E8b8KVncn/CVQoKCPTG+7t1dftfF/GebyNd4p/ckF01/lr3lfuolDwONgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658964; c=relaxed/simple;
	bh=oIj5B3kzjM22m/bXOmlwJmDPA14ql9Jd0vB0Olc5xE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VPbNmtqgWM37V4cGSNDB5h9RYxRCzFuDjo3zuGn7IbrxySNvKHdhsRpm3YxtXMYndKD62KpndlBbqE9wWViQzzvUxH8z+R0H1nqgpgBRpJAKS1kiYmvG+7uISyUL+XVheGEGXDHxjAB78qdjyhyAkuMFHtrcHEhT7b2qeaTDveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/Luqbsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Luqbsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B538F1F000E9;
	Tue, 25 Aug 2026 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658962;
	bh=MHZ6Dgsqr/I/QkvVdpbSBe/uiFRkQBn40AvtCUt+W8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/Luqbsa8sXdqoMtfmDQuP9XWq4i90Uf1FUUYyS2pTH1dekW01obImn1GBC+qMJHb
	 0g4EozHE34iWEs453ZPwUjnwX3d59+SiNshBXACipm+LV9N8GkgefMalAQFuRRXill
	 9x+REtjOBN5+gfqeKAZrlTvZRctvNYJ/k7zm8giGKhk7ea6KgY5WEcX0KsY2BWW9zh
	 iZCfHDpie+lJDyynMFwWDJWKDgMNw1fpOHXSlwnF6UXNSFR485YTs2ZtJHdWyqD1b4
	 GsY1Bl/sEFt0Gr2WN64wrtCaksuNtk6Y/Zv/niifXhrT14OpUn0wZCCXugqercMDxV
	 Loyb6u2mvlaQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix stream capacity leak and spurious
 -ENOSPC in bpf_stream_stage_commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825113948.85020-1-ahemadkhawar123@gmail.com>
References: <20260825113948.85020-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 11:56:01 +0000
Message-Id: <20260825115602.B538F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Dead code and commit message mismatch regarding a structurally i=
mpossible capacity leak.
- [Low] The patch inconsistently drops 0-byte stream commits when `ss->len =
=3D=3D 0`.
--

--- Patch [1]: [PATCH bpf-next] bpf: Fix stream capacity leak and spurious =
-ENOSPC in bpf_stream_stage_commit ---
commit 55dd4746dd7b2e3d562a36b8b50cd0857f9d9bcc
Author: Khawar Ahemad <ahemadkhawar123@gmail.com>

bpf: Fix stream capacity leak and spurious -ENOSPC in bpf_stream_stage_comm=
it

This patch updates bpf_stream_stage_commit() to return early if the staged
length is 0, avoiding a spurious -ENOSPC. It also adds a rollback to release
consumed capacity if the staging list is empty when detached.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 7a5c3ac8676b9..3ad58c82846ba 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -350,15 +350,21 @@ int bpf_stream_stage_commit(struct bpf_stream_stage=
 *ss, struct bpf_prog *prog,
>  	if (!stream)
>  		return -EINVAL;
> =20
> +	if (!ss->len)
> +		return 0;

[Severity: Low]
Does this early return introduce an inconsistency with 0-byte elements?

If a BPF program stages only 0-byte elements, this early return discards th=
em
entirely without transferring them to the stream. However, if a 0-byte
element is staged alongside a >0-byte element, ss->len will be > 0, and the
0-byte element will be successfully pushed to the stream.

> +
>  	ret =3D bpf_stream_consume_capacity(stream, ss->len);
>  	if (ret)
>  		return ret;
> =20
>  	list =3D llist_del_all(&ss->log);
> -	head =3D tail =3D list;
> -
> -	if (!list)
> +	if (!list) {
> +		bpf_stream_release_capacity(stream, ss->len);
>  		return 0;
> +	}

[Severity: Medium]
Is this rollback path actually reachable?

The commit message states this fixes a capacity leak if llist_del_all()
returns NULL. But because of the new if (!ss->len) check above, execution
only reaches here when ss->len > 0. Since ss->len is the sum of the lengths
of elements successfully added to ss->log, having ss->len > 0 seems to
guarantee that ss->log is not empty, meaning list will never be NULL.

Additionally, in the unpatched code, if ss->len was 0,
bpf_stream_consume_capacity() consumed exactly 0 capacity. Returning early
without releasing 0 capacity wouldn't have actually leaked anything.

Could the commit message be clarified, or is this dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825113948.8502=
0-1-ahemadkhawar123@gmail.com?part=3D1
