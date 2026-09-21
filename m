Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E90201278
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033834; cv=none; b=MC9SVMbx1ImG0AxO72N0WbHRUCYZuFDm+b4nR081WX67x48MvtoJrgQC5s3S8xioJOvMENJPKhCtESjvunHu3woI/2gA6koQl/mFMqPixUQCsYTCMZ64TVHdOf8xEzLHmERwbwY67R1vgPXg/KYNZtSpLIaYmfy+EdQ+3ZgkQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033834; c=relaxed/simple;
	bh=DPEnjMpMBGzjTIXUDqsI1hqSmmqjmhNXmXYsQ5eWAk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n20ZnPhrXL1NcG441UZHP67ZcZbjjCPEvUTQwnlWJLtrYo3xWOLjLtMTsBrx5+akpp6Q3y/3/eAkXighg84rh1OfYerY7pZLdv90cXKYbXVf/veqnM33SICljhV5Bpzmfp9bwLSqWnBfzb2QE8RZkkHb3wLV7t+eRdzJkjH/czY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNAK65rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNAK65rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F791F000FF;
	Mon, 21 Sep 2026 23:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033833;
	bh=yRpdVW7fpYzvAJKDHzaqOtz8IyYoYlMK0+nbU5xw/W8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fNAK65rzJngPjOj1zQDbzGZOwGYBgKW1HbY4a9N19X6qvTBsEyGVZsWV66NI8LQSp
	 GoTcGYq7g+OJz6Gg963YaNyxSLiAibQcN9gvvcDqcUUt6p2Na3BNEqYYKDTkmOL72u
	 DtOdxlU4NFyMqddP3BhG9u7oSnGr4HKShCXiCvPIlheKdkDLD3U8xbqh3989uqyC55
	 h9SFRhxURGeP+5JPAEAw7+FIlGx0qjyFDXChxb90eNe/8wuUvORAo4LDi6jPAHDfRh
	 gMPEp76YnGqW+N5SGDCRwRvad8kuq6hvj8b3KFo4PaVYLNpdc4Jo8Hc/ZUsG3JLrB0
	 SIzduv2dhHKNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/7] selftests/bpf: Cover BPF program load
 strategy transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921223937.3203093-7-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
 <20260921223937.3203093-7-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:37:12 +0000
Message-Id: <20260921233713.18F791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: ignored bpf_program__set_load_strategy() return value in se=
lftest
--

commit 9bfec64bd482deb3a43ba282aed9959f4435d987
Author: Slava Imameev <slava.imameev@crowdstrike.com>

selftests/bpf: Cover BPF program load strategy transitions

Adds a load_type test to cover load strategy transitions
(DISABLED/AUTO/MANUAL) and compatibility with boolean auto-attach states.
Also tests the manual load/attach cycle after loading an object.

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/t=
esting/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..ab42c3e887fce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
> @@ -0,0 +1,186 @@
[ ... ]
> +void test_load_type(void)
> +{
> +	struct bpf_link *link =3D NULL;
> +	struct test_load_type *skel;
> +	int err;
> +
> +	skel =3D test_load_type__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	/* don't load prog1 */
> +	bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEG=
Y_DISABLED);
> +
> +	/* load and attach prog2 */
> +	bpf_program__set_load_strategy(skel->progs.prog2, BPF_PROG_LOAD_STRATEG=
Y_AUTO);

[Severity: Medium]
Is it intentional that test_load_type() ignores the return value of
bpf_program__set_load_strategy() for prog1 and prog2?

Since this selftest is designed to verify load strategy transitions, failing
to check the return value might silently mask regressions. If the API
introduces a bug where transitioning to AUTO fails (e.g., returning -EINVAL=
),
the API call would return an error but the program's strategy would remain
its default (which is already AUTO for prog2).

Because prog2 remains AUTO, the subsequent test assertions expecting AUTO
behavior would still pass, completely missing the API failure it was design=
ed
to catch. Should these calls use ASSERT_OK() similar to how prog3 is checked
below?

> +	if (!ASSERT_TRUE(bpf_program__autoload(skel->progs.prog2), "prog2_autol=
oad"))
> +		goto cleanup;
> +
> +	err =3D bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD=
_STRATEGY_MANUAL);
> +	if (!ASSERT_OK(err, "set_load_strategy_manual"))
> +		goto cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921223937.3203=
093-1-andrey.grodzovsky@crowdstrike.com?part=3D6
