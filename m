Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FF396588
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399662; cv=none; b=LFR5t/LUmBzkLc3sARy1tDZLlcbu9Haed0EmWhl/1zL3WP4UFVYluwULjwTmTZTR6uG4sW5cq8FgJ13czFK81qT+OkiAn/Sm6Z28hBKAFPewPfSrR/DiHl5fuYXUbLCdELeN7054mDIt6hy7/p2QsgkZ5w+dsjycBHwaBssbBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399662; c=relaxed/simple;
	bh=Anrl3VE87OtP8/AVTMJxqnqWTxnsohuG6bYe/0Q1Pv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwCRI31NbJnm/wHlbVjVdBFpEsTFA7oN1uOAkqiIu149IRD3G9G1oYh9tyPuwrktXUtbwsXF+Y7IR3qx8lFbvpXyFArebb9gT34+NfbRsu2ied7ahQMhqxmruPjWvCzbmCsSyB4KhSuhVRlRibRFrC62VpGH3wLs68I3FRA8C/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWd0Pjqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWd0Pjqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A35D1F000FF;
	Sat, 26 Sep 2026 05:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790399661;
	bh=/jKkC7/rUwIpjyUgGrJeE7+xa634TxeLwM/ZYapw8Wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWd0PjqgIls6iWJsYpdn3+KCDyQLyuIilO7uge1fE1VOdsgDPWY1guKlIf3s0enLh
	 JKjCI7y2nDBEO8hoAWfasZOYh+GOdqtXMB339O0ePZcgob+b4AeZRzer5+4Z9k0Ipm
	 cYhyqHcTd3UO7gY7ZWNbpAzbDTzv1yFEm6kzH+PSpevHzzxTsaBHQdIo3S0Pkzrebz
	 QE5V/TkhB92CUotnJ/3s7Sr4KMSTmyZpmlYxMSrczALAfWqYr6X4L/HXxS5vR9k8pz
	 +SxD0IJCyqgAbBOCYIeu9Op6R5iNec5kO5LCaWW+FsIIs+PtHbXTQ0vNeM5EeQYoIa
	 n8C0yYTYfsv4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 12/21] bpf, arm64: Dispatch exception
 cleanup pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050107.2218786-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050107.2218786-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:14:20 +0000
Message-Id: <20260926051421.0A35D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf, arm64: flawed PAC detection heuristic in bpf_unwind_store_ra()
--

commit 8fd536108380da02aed3e75e4a2d05875d208201
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, arm64: Dispatch exception cleanup pads at run time

This commit implements the runtime dispatch of exception cleanup pads
for the ARM64 BPF JIT. It integrates with the stack unwinder to replace
and correctly sign return addresses using pointer authentication (PAC)
where necessary.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c53fb04..c750c520f24d9 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c

[ ... ]

> +static bool bpf_unwind_store_ra(unsigned long record, unsigned long call=
er_fp,
> +				u64 pc, u64 ra)
> +{
> +	struct frame_record *rec =3D (struct frame_record *)record;
> +	u64 stored =3D READ_ONCE(rec->lr);
> +
> +	if (system_supports_address_auth() && stored !=3D pc) {

[Severity: High]
Does this heuristic fail when the generated Pointer Authentication Code (PA=
C)
matches the sign-extension bits?

The hardware PAC algorithm uniformly generates pseudo-random hashes.
There is a non-zero probability (e.g., ~1/128 for a 7-bit PAC on a 48-bit V=
A)
that the generated PAC perfectly matches the sign-extension bits (all 1s).

When this collision occurs, the PAC-stripped pc equals the unstripped
stored value despite the pointer actually being signed. The unwinder
would then incorrectly assume the frame was unsigned and write the
replacement return address (ra) to the stack unsigned.

When the BPF epilogue subsequently executes AUTIASP, wouldn't the
authentication fail, corrupting the pointer and triggering a fatal trap
on RET?

> +		u64 modifier;
> +
> +		if (WARN_ON_ONCE(!bpf_unwind_ra_modifier(record, caller_fp,
> +							 stored, pc, &modifier)))
> +			return false;
> +		ra =3D bpf_unwind_sign_ra(ra, modifier);
> +	}
> +	WRITE_ONCE(rec->lr, ra);
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D12
