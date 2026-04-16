Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931181E1DF0
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366525; cv=none; b=UGZYS2UUkfGWT19p3r0SVze5/jdvG0arG+mZFm5BV2TWk0XQJPfm51jtgbHe3oK3MBfkxlP+ruIJEC+CS0w4A5y7lPiVGZ8plbJ9mnX5/xA8Y1Eb8hmP98uvGV4DTjP4XA83XeqOoJZkDGvHObvg0Qitp8cbD72xlaEm9BIPVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366525; c=relaxed/simple;
	bh=skp8D+mRw7iVmt/tyPY3MBhHGJ8R1OmmR29mhRWbx0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gx6c8NDMjmURPEPHXcCw0Cx7gu3ewSoc2srRx+0f/eC79q0+bUUgiUUswaIrOKMdnb1zGlToVZAbodho9np726RWZHb6J5cfARn6Jq521zW9Yna6eBciEhrj+0UmlzLBQSjwUnLzybgyIUtdXE4g74Lf8h08vgcBPQcTZ9RVq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot4vByUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot4vByUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F970C2BCAF;
	Thu, 16 Apr 2026 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776366525;
	bh=skp8D+mRw7iVmt/tyPY3MBhHGJ8R1OmmR29mhRWbx0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ot4vByUodcr02fl9+NYR0bj2H3F874tZm6adFTS/4JIrqkR7n0+IvlPHzUZxEPvPy
	 g9lvhZqv4O3CBYx8ELAG1cI1gn3hTkzljZD530ueyOEIU/rJE3Xo+U9e1sVNT5FUZn
	 /L4gSfHfSV9TC9qbH7cFNgmKYFtHmzI/24J/QFGtkpkhBm9O54Q0aCqQpJZijsKE7B
	 GF02DP240Zf9Ana+OZVj5WzTi4eCqZ4A+flJjw8R+KqR8SC3tqYej000m8p81p2bS3
	 8Qd71UAglDR8ple7wjX6ymOrzupo3aNwX8pOw0/qAsOQOYVbHmEY/CfF3/0+4Vu2bg
	 KJ9iZzhfRhEZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/7] selftests/bpf: Fix reg_bounds to prune
 on range violations
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <91b8f1840277989ac65d05a9ad5e683a98d3d6ec.1776344897.git.paul.chaignon@gmail.com>
References: <91b8f1840277989ac65d05a9ad5e683a98d3d6ec.1776344897.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:08:44 +0000
Message-Id: <20260416190845.5F970C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The early return in `reg_state_cond` silently discards updates, =
incorrectly preventing mathematically impossible branches from being pruned.
--

commit 9c1398626b454db27a318d8fb3f946b257c46b99
Author: Paul Chaignon <paul.chaignon@gmail.com>

selftests/bpf: Fix reg_bounds to prune on range violations

This patch updates the reg_bounds selftest to correctly detect and prune
dead branches by checking for ill-formed ranges. It marks branches as
invalid if their ranges become ill-formed, matching the verifier logic.

> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 71f5240cc5b7e..c0b3a357a0f4c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
[ ... ]
> @@ -837,6 +850,8 @@ static void reg_state_cond(enum num_t t, struct reg_s=
tate *x, struct reg_state *
>  		z2 =3D y->r[t];
> =20
>  		range_cond(t, z1, z2, op, &z1, &z2);
> +		if (!is_valid_range(t, z1) || !is_valid_range(t, z2))
> +			return;

Does this early return prevent the invalid ranges from being written back
to newx and newy?

If range_cond() produces an invalid range, the function returns immediately
and bypasses the write-back of xx and yy at the end of the function:

	if (newx)
		*newx =3D xx;
	if (newy)
		*newy =3D yy;

This leaves the output registers with their previous valid state.

When sim_case() later checks if the branch is valid:

	reg_state_cond(cond_t, tr1, tr2, op, tr1, tr2, "TRUE");
	if (is_valid_reg(tr1) && is_valid_reg(tr2))
		tr1->valid =3D tr2->valid =3D true;

won't it incorrectly evaluate the old valid state and mark the impossible
branch as valid, defeating the pruning logic?

> =20
>  		if (newx) {
>  			snprintf(buf, sizeof(buf), "%s R1", ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1776344897.gi=
t.paul.chaignon@gmail.com?part=3D3
