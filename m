Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F04B1467
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688769; cv=none; b=WFTwaN4dyVWZhUSVj7/Ucm8xhijT4mwa1rlITd2qRsuPJnEmBxgMxqk9lvRwam7+cGbdZU/hTitnFkhr56YnZcPV8KxkTgkdi6RgOVj6Gi+7mslvPucyNddPanDMoekEP9iyLHI4CJmU9NEx4JQHJBG3ZAYDlasTo3wobomdDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688769; c=relaxed/simple;
	bh=V9pE7CghYu2+j2iYbTTWAQ86Mnbd++pLZSK2qp6st68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qrRs3JIXTIOGabEUUxv7itnhTSN5JS0dT5eC18HIcNMlgYgSkSnfuFOlNPG/ZIp3IPVNzkXazbT/1BX2Gy7o+BUav173YLSCUqhWKpAhHK72fBFXcyxhmNE+Z/MXy0kQn0clJ2s9xWAtHhqDid6c7t/4GNLASirSmxvmiidpE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6wwLvNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6wwLvNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81761F000FF;
	Thu, 17 Sep 2026 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688766;
	bh=fQYnPzt6+uuWThFuL5QneZff7Cl0iDiAQlmjl8PSioU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6wwLvNEb55j44TR06JATbXz++csyRJrUa1QWAMtCaQqjZ2n5GQ09EHpMogwG03a7
	 UGr+2cSPQ2oENRGPcbuOTyUAfb7+WUsYCYiUX76WVAQst7qzzflubrPh9MjU4BC855
	 URh5RH6IM7CF/FwrL7NntXwWee/nuPaoTGz3627p4/HKPXidGZduurOHInWk4xQSD1
	 UBd3CfUgjTx0VPjruNVNJWEVwcsu20PliOYRsskK7q3SMjobptLfG3g9GZ7EIibZDF
	 Q2Xicrqf7vWNw2DY7K3tZV/EHZAe2TrajBRl275Iyg9S+M19xrT0525phZge4RhytP
	 khCH/0TKHo+4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v7 09/10] selftests/bpf: Check callback map value
 lock identity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917233222.2542500-10-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
 <20260917233222.2542500-10-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:46:06 +0000
Message-Id: <20260917234606.B81761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bisectability breakage in cb_refs test
--

commit 03ec1406cdaeb656afadd3849c93ff403c3610cb
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Check callback map value lock identity

This commit adds a verifier test to ensure callback map value lock identiti=
es
are correctly verified, even across nested inner-map lookups. It also exten=
ds
the spin_lock failure tests and updates an existing cb_refs test expectatio=
n.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/tes=
ting/selftests/bpf/prog_tests/cb_refs.c
> index 78566b817fd70..490e15e7126d9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> @@ -13,7 +13,7 @@ struct {
>  } cb_refs_tests[] =3D {
>  	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects =
referenced PTR_TO_BTF_ID passed to R1" },
>  	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
> -	{ "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /* alloc=
_insn=3D2{4,5} */
> +	{ "nested_cb", "Unreleased reference id=3D5 alloc_insn=3D2" }, /* alloc=
_insn=3D2{4,5} */

[Severity: Medium]
Does this change introduce a bisectability breakage?

The test expectation for the nested_cb program is updated here to expect
id=3D5 instead of id=3D4. This appears to fix a test failure caused by the
previous commit in the series, which added the ID increment for callback
map values in the verifier.

If this test update is delayed to this subsequent commit, the cb_refs
selftests will fail when testing the tree at the intermediate state,
violating the rule that patches should be self-contained and not introduce
regressions.=20

Should this hunk be squashed into the prior commit that actually changed
the ID generation behavior to preserve git bisectability?

>  	{ "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1" }=
, /* alloc_insn=3D1{1,2} */
>  };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917233222.2542=
500-1-memxor@gmail.com?part=3D9
