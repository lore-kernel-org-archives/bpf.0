Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16509329C60
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973550; cv=none; b=eqIe+EOJKEADoZ4fjI9Wkvs7Aw719Ldp+hzRLiIhrsLRoABOo5n0aMofxhAN63Kk0hy5D+JgPju38os4ky4Tj0TbpZme9HZZpn+zWf82e3iazWWHlWl9ElmrMRorpJzjA0JMXqgNxBNpoORsQKC8Wt/7PTkQ299tohW8wmwVMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973550; c=relaxed/simple;
	bh=fPidDWPT7UIL3cJLVy0ZPgGbU37XqlxCxyTNZPM3fq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTokD3T+23Yj5olGeLiSJAEdrDg5zZLfLFXvsmhCVDo5aLH8dL3kno8nTuRUQeLeciMUDSHs3asSY1L2HxRkBW32E7RPUEnf2VkzbQX9FUL7ysp2E9r30w63rmU04pedMUQgWp2eO25k4Uwnh24abm1y4c4LvPmSD6ztn6mwdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFeJ6KBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFeJ6KBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CD2C2BCB4;
	Tue,  5 May 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777973550;
	bh=fPidDWPT7UIL3cJLVy0ZPgGbU37XqlxCxyTNZPM3fq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gFeJ6KBO15mgexyLKo0MsiHOmkjy+81W1Qfg2VGPLgtQytV52pEiz8GFHRN/k45VY
	 XePlLD4MLzkrWcjuPzbZxZbWZCJQKogOp44bbNwrCevNcJWpKFMgCawYsgnymJG26j
	 5xsdFvGMV2joNu/gW+olsEVVzyvdf/LjyS4h7fwkmnMyudekxna5VvhA7nLUD8H7Wc
	 AUQOPGCQzuZ0HrZksamulRyDyFrBKCxRQgAPAh1zsyvNGlW6jPuSk6UhmysT4M4vpy
	 OzOlpc2un9lWeWsVqaKETVEAbDSM/DGyLHYVIZnQSmbtY2b2J+p7eH2LDrYPKlYtAg
	 dJBizDYGfUd6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/14] lockdown: Make the relationship to MODULE_SIG
 a dependency
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505-module-hashes-v5-2-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-2-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 09:32:29 +0000
Message-Id: <20260505093229.D8CD2C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `select` with `depends on` silently disables Kernel Lock=
down (`CONFIG_SECURITY_LOCKDOWN_LSM`) in existing defconfigs.
--

commit fc97135b538c64bfcbf058cc70c9665d00e5bb18
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

lockdown: Make the relationship to MODULE_SIG a dependency

This commit changes the relationship between SECURITY_LOCKDOWN_LSM and
MODULE_SIG from a select to a depends on. This is intended to allow for
future hash-based module integrity checking alternatives.

> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> index e84ddf4840101..155959205b8ea 100644
> --- a/security/lockdown/Kconfig
> +++ b/security/lockdown/Kconfig
> @@ -1,7 +1,7 @@
>  config SECURITY_LOCKDOWN_LSM
>  	bool "Basic module for enforcing kernel lockdown"
>  	depends on SECURITY
> -	select MODULE_SIG if MODULES
> +	depends on !MODULES || MODULE_SIG

Will this change silently disable CONFIG_SECURITY_LOCKDOWN_LSM in existing
defconfigs?

Because Kconfig's savedefconfig strips out automatically selected symbols,
many in-tree defconfigs contain CONFIG_SECURITY_LOCKDOWN_LSM=3Dy but omit
CONFIG_MODULE_SIG=3Dy. Since CONFIG_MODULE_SIG has no default y, it will
initialize to n.

With CONFIG_MODULES=3Dy and CONFIG_MODULE_SIG=3Dn, this new dependency eval=
uates
to n. As a result, Kconfig will drop CONFIG_SECURITY_LOCKDOWN_LSM from the
final configuration without any warnings, leaving the kernel unprotected by
lockdown. This also degrades discoverability, hiding the Lockdown LSM in
menuconfig unless a user explicitly enables MODULE_SIG first.

Could this be handled with a conditional select instead to avoid breaking
existing configurations while still supporting the upcoming MODULE_HASHES
feature? For example:

select MODULE_SIG if MODULES && !MODULE_HASHES

>  	help
>  	  Build support for an LSM that enforces a coarse kernel lockdown
>  	  behaviour.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-module-has=
hes-v5-0-e174a5a49fce@weissschuh.net?part=3D2
