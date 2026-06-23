Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088D30DEA6
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232080; cv=none; b=Vx5dyoOjnaD4z3RGkdVJBIS7MTwtEsQ0nLDTeYQNJoERO0SpHi0ya8ZEQGeiGguXgsuqT8RUdH/PiXqPuhBIpqMeBjYx28U0iEebrFgZBSxvBjSBbux7i4xCVrZ+MXQu5z4vg6N8nlv/md1F2jnrzCXY87iQvTa3XpYOD9qzydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232080; c=relaxed/simple;
	bh=HImySYci4LoXjCJN51ZTCJneiw87q+49GPuwnPJ1kII=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/QkDofmN08cLg3UK3tMBzq/468ahbdYJzxFgFpPtSTTTxxwB39ZEEt5Yw0YlF3/8fh7s9gnP2KGK7ECwE+oqStCQrQv6J0eZB4li0wPk59QITTCRPV/Mt9s13ssdJm7jttfHVk08qkCZFi0HYu7NNPTnnCtZEzC8dP0N/wH6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PotaozQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PotaozQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BA51F000E9;
	Tue, 23 Jun 2026 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782232079;
	bh=HImySYci4LoXjCJN51ZTCJneiw87q+49GPuwnPJ1kII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PotaozQ1bIo5Dhl7i7oOui2rIs2BnhBwuecpD0fVIYk8XtM/REjgyUKYPf/PKANXc
	 Wx/QfCqkaWHALf6E5BgXMoRnV1c8ybEvypgtHEHILcVmCMSd+Ml8i9cTxdMmH4/Vc2
	 yP8JbXY5Lv3Oz66pdSmSMUx2eMcr4fK5/dr9DtXTiztj3MHvSzKHaMaxwvKeHcijCT
	 VZbzk5UXVabvGDCIMzl7I1cj3gk8n5vJmgWvJBY4DreKVp4yzscN2J5R9SE8eaJ+xZ
	 FJbigifDbw2VE5LemM4FBcfOchB0C5ZV8MSN/B8iJQoiSTdM/dLiRmQRYrHgPtvpmr
	 9tW8fLtWLkCvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] Documentation: bootconfig: document build-time
 cmdline rendering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623-bootconfig_using_tools-v6-6-640c2f587a3c@debian.org>
References: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
 <20260623-bootconfig_using_tools-v6-6-640c2f587a3c@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 16:27:58 +0000
Message-Id: <20260623162759.25BA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation for CONFIG_CMDLINE_FROM_BOOTCONFIG omits the Kcon=
fig requirement that CONFIG_CMDLINE must be empty.
--

commit 7ac5b833fb6889abf419a5e5890a63a00f59d74e
Author: Breno Leitao <leitao@debian.org>

Documentation: bootconfig: document build-time cmdline rendering

This commit adds documentation describing the CONFIG_CMDLINE_FROM_BOOTCONFIG
option, explaining its build-time rendering behavior, requirements, opt-in
semantics, and how it interacts with other command line sources.

> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/adm=
in-guide/bootconfig.rst
> index f712758472d5c..349cefbb2bbcd 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
[ ... ]
> +``CONFIG_CMDLINE_FROM_BOOTCONFIG`` resolves this by rendering the
> +``kernel`` subtree of ``CONFIG_BOOT_CONFIG_EMBED_FILE`` into a flat cmdl=
ine
> +string at kernel build time (via ``tools/bootconfig -C``) and prepending
> +it to ``boot_command_line`` during early architecture setup, so the keys
> +are visible to ``parse_early_param()``.
> +
> +The option requires ``CONFIG_BOOT_CONFIG_EMBED=3Dy``, a non-empty
> +``CONFIG_BOOT_CONFIG_EMBED_FILE``, and an architecture that selects
> +``CONFIG_ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG``. Currently only x86

[Severity: Low]
Should this also mention the requirement that CONFIG_CMDLINE must be empty?

Users might satisfy all the explicitly listed requirements but still find t=
he
option hidden in menuconfig if their kernel is configured with a non-empty
built-in command line, because the Kconfig rule uses depends on CMDLINE =3D=
 "".

> +selects it; on other architectures the embedded bootconfig still works,
> +but only through the late runtime parser.
> +
> +The same ``bootconfig`` opt-in applies as elsewhere: the rendered keys
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-bootconfig=
_using_tools-v6-0-640c2f587a3c@debian.org?part=3D6
