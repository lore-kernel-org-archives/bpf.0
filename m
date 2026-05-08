Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD2156CA
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276217; cv=none; b=X1wdntt0tHVUOVRCLcyNr4QPaLrRQwpy/7Wqyx5DzJm1gn0BjorAdIfk3pnVg7wka5toFGWjeN9C35igrEezzBJMt8YoQIQ6W8UHLly+fpEPpd0zx4BW1Is4tN0bAWDp/tGyT9ihJiaxtvxqRgsCp1u+jRLFEzafbQE2ITyBBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276217; c=relaxed/simple;
	bh=Vz2c9cUPMNISv2uKSq5VHNyBE2lBuMJREbXGpJjBm1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B6Y402FJMO6W99lnGf4nRTztAHI3pNRrNr9l8BlbIpmeZUrROg+rEQxow6PsyUsUbjnFYMAXcI49yf5XSzWsx0NvlkYs58fIh9819oSsAMMqCrV1PFEVWPK2FMrnlKaS8CWmqI/dlMTOSwXGHghbY1fB80z814NAQ26nO2+Palg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv13pKEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv13pKEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F6CC2BCB0;
	Fri,  8 May 2026 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778276217;
	bh=Vz2c9cUPMNISv2uKSq5VHNyBE2lBuMJREbXGpJjBm1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uv13pKEdimIe7jBAfBQMQdT6yQYbq6FatcIakdFE3K49J2uz5eJ7C/Xpv/YIqi3Na
	 ac2Rpz87ZDZbbCssmEIurs5zenhfVeQn4cTtgcDvat8QINFUh2xtVTjAEqFucmO9yZ
	 JU/a4W3zkZo0OheEwBp5SLMaxsaNsvP6BeK35GEbE8RF3/nJFRm35z8Po6qp2j5Div
	 GoZbpkA50vNKXKMt1LFC1wkDD0pAWu31E3j+Tut1xHm8PrzCXuJhJxQoGcD3M0dudK
	 y94/cUdwkq4IZHXtQHbvhtaHK1prO0JuaYVAU+dx6MmgaEDskOHCkJjIGKCROrLf22
	 EMf4HzirV80Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] psi: add psi_group_flush_stats() function
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508150055.680136-2-vernon2gm@gmail.com>
References: <20260508150055.680136-2-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:36:57 +0000
Message-Id: <20260508213657.94F6CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure when CONFIG_CGROUPS is enabled but CONFIG_PSI is disa=
bled.
--

commit 3c39f362bc58a25b857026542cbe7d4bb70721fd
Author: Vernon Yang <yanglincheng@kylinos.cn>

psi: add psi_group_flush_stats() function

This commit adds the psi_group_flush_stats() function to prepare for
the subsequent mthp_ext ebpf program.

> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index e0745873e3f26..7b4fd8190810f 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -22,6 +22,7 @@ void psi_init(void);
>  void psi_memstall_enter(unsigned long *flags);
>  void psi_memstall_leave(unsigned long *flags);
> =20
> +void psi_group_flush_stats(struct psi_group *group);

Will this cause a build failure if the kernel is configured with
CONFIG_CGROUPS=3Dy but CONFIG_PSI=3Dn?

Because there is no fallback stub or empty definition for
psi_group_flush_stats() when CONFIG_PSI is disabled, callers added in
subsequent patches under CONFIG_CGROUPS might face undefined references.

Would it make sense to add an empty inline stub in the #else branch
for CONFIG_PSI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508150055.6801=
36-1-vernon2gm@gmail.com?part=3D1
