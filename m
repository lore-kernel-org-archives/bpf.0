Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F83C4B93
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201782; cv=none; b=kvdL9gUAgX9kaUIcXv2PDPD1mlS9MYVRAO+YBF1bvJ/YOHd5rlhH33kYVCninGiGv5si8sqU1CzQ5dfOAFTawincf+toJMMTj11BvKPa8xp7b0atzJi/l502jC0Z/o2WXCFbkmPu6SkkBvpTz50tcr1m75mccKtbAeoVvt5/Hos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201782; c=relaxed/simple;
	bh=IbZnz/sAbGOahsL/ZV3OPTBrm6X4EBZdUCGEX4wIa9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=norknSnXbNs63EWNkG99VhUVBzfbI21sanOoBWDEfKd1wKBIOJ/d2Sg5FUsbEIJ1BraTnMr7sD2XJ+M2d5GhhC2NiuKxh2jmgEwHJ9xtqUjgDP6ASAG+R7+qCw/JDH3A7pKK3jmhJH/yR/LYalTrQbqV9fK44ykpiE2fse0U0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZApq34O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZApq34O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE491F00A3A;
	Tue, 23 Jun 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782201781;
	bh=5r8JbHcNCIKEagM0LpASy2VLMcunC5nCbbm+gq3RRNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZApq34O063Ztq8P1ZnqH0uqCRqQxDXfeFczesi3cS6KegUDwmbJvXBlbmsb0zuU1
	 YMqypx6OlyB/Ms4ZJikvcvUcCzvS5ojQwUH9QLAOIKpATFLdtTJueWOYjrql4/r1Yk
	 dlitfmXN1ns9qG3iEBMKMEz2g/sx+0Q9tFmR+bI9S7X/yLIQ/9YAHdjRI2G45DDfXr
	 /C7koaZPIicBw2UKeGxlbX6Un1PIWnaDYoqss2ASnBbf8FrnIYs3ay3qOlTsf5Oa1a
	 AP3FDAElb8WctLi2rtk/9a9YTn26u6YcHNEQKnHijsfVdq06Im/oKytas++YpIvulv
	 qEI6slJGchoOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: bounds-check float size in
 btf_dump_float_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <178220124597.31744.3595561672327420327@digiscrypt.com>
References: <178220124597.31744.3595561672327420327@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:03:01 +0000
Message-Id: <20260623080301.8DE491F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Architecture-dependent bounds check breaks dumping of 16-byte fl=
oats on 32-bit architectures
--

commit 31fd1a7664b926003f6e360a24ed9cc2bcd8b9c5
Author: Naveed Khan <naveed@digiscrypt.com>

libbpf: bounds-check float size in btf_dump_float_data()

This commit adds a bounds check to btf_dump_float_data() in libbpf to
prevent a stack buffer overflow. It ensures the size of the float type from
the BTF data doesn't exceed the size of the local union used for unaligned
copies.

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6c5a..922c8ce32c2ff 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1983,6 +1983,11 @@ static int btf_dump_float_data(struct btf_dump *d,
>  	union float_data fl;
>  	int sz =3D t->size;
> =20
> +	if (sz < 0 || sz > sizeof(fl)) {
> +		pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
> +		return -EINVAL;
> +	}
> +

[Severity: Medium]
Does this bounds check prevent dumping 16-byte floats when running on 32-bit
architectures?

On 32-bit architectures, sizeof(union float_data) may be 8 or 12 depending =
on
the size of long double. If we process a valid float type with sz =3D 16, t=
his
check will evaluate to true and return -EINVAL.

Looking further down in btf_dump_float_data(), the function has a handler f=
or
16-byte floats:

	switch (sz) {
	case 16:
		btf_dump_type_values(d, "%Lf", flp->ld);
		break;

Because sz =3D=3D 16 is expected, this check makes the case 16: statement
unreachable on those platforms.

Should this code allocate a fixed 16-byte stack buffer to receive the
memcpy() instead of relying on the architecture-dependent size of
union float_data?

>  	/* handle unaligned data; copy to local union */
>  	if (!ptr_is_aligned(d->btf, type_id, data)) {
>  		memcpy(&fl, data, sz);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178220124597.31744.=
3595561672327420327@digiscrypt.com?part=3D1
