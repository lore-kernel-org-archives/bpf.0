Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2239A04A
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457120; cv=none; b=hf+pEEbLcB8eqOv6bXFGdDl6FTvg8azKLKvsODBGu82ojUgu6zZIxMcy+n+eD5TnRUEtIs4BCZ6oZJrRI0DmkqIk0dMjskHnLj5mgPz+Y3A5WwTQVQk2cjlti87YVbrsfNa8UpDcTAEWBuEhrz+ws83QlecX8vcD+M0UmErddco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457120; c=relaxed/simple;
	bh=oXI0YQyA2nJ7Y+GZAAAMprR4ibZi9BU+5wK2KA2o0jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KTDVcB/8/FMU0kN5AVCAsoPwV32tRRpNHXj+nDY8xz0d3oDTGsmSnGGKobGpU9dMDhSNFBfP2jQqr9+LBcdGLVkN7SnKhuc6wHxEk1KakEBl/OwtZ98r+Lk9ZYWbrLfaEPnZpTstQ29rmBzLsv501ghjSaoOD2xMWGwOuESEEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPTBEleE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPTBEleE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20FA1F000E9;
	Sun, 14 Jun 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457119;
	bh=oXI0YQyA2nJ7Y+GZAAAMprR4ibZi9BU+5wK2KA2o0jQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPTBEleEL2HQlA1HCW8kcfy6K9JVTkm1nlKLQ1QBnPU6nDhk+CvTmQ0UUZfYdXSzA
	 D127hBcKO7fLrJOG06xD1mtb5QO002uaa5pcxl3HEQrz3UYM70OxJ78iJKwlkR0DNB
	 wj5pdJRR18IcafvT61I7TWHq+yLPXf7ErXeQWbcGNAZ30/7eyHtPnU8tdY7rNzxExk
	 74cb7hlIAIx+SZEftVo7awwl9TVn/0a1Ie2HyHGE1dYrYP6Vz9Y1x+RYH/kqz1vaEH
	 uqhfo8D0KdRh9abeQ0K+d6k0YQ9UH2CydsmFDCLvD/x8ppKXnX6JSHoBCGKovEo0rZ
	 3TLoO9NXygC/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v3 2/4] bpf: Remove
 mark_precise_scalar_ids()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <9c5d94f381d7d9ecd8d07c60e0e271117ce24482.1781194510.git.jt26wzz@gmail.com>
References: <9c5d94f381d7d9ecd8d07c60e0e271117ce24482.1781194510.git.jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 17:11:59 +0000
Message-Id: <20260614171159.A20FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Leftover unused struct bpf_idset and union member idset_scratch.
- [Low] Multi-line comments do not follow the BPF subsystem modern comment =
style.
--

Note: Due to recitation policy restrictions, this report does not quote the
original patch code inline. Instead, it provides a free-form summary of the
findings with references to the modified files and functions.

commit b92dc3ff591ac22c49e14f36339cfd789c618695
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: Remove mark_precise_scalar_ids()

This commit removes the mark_precise_scalar_ids() function, as it is
superseded by jump history tracking and bt_sync_linked_regs(). Test cases
in progs/verifier_scalar_ids are updated to reflect the new verifier
behavior requiring conditional jumps.

Link: https://lore.kernel.org/bpf/20240718202357.1746514-3-eddyz87@gmail.com

File: include/linux/bpf_verifier.h

[Severity: Low]
Since the patch completely removes mark_precise_scalar_ids(), does this lea=
ve
struct bpf_idset and the idset_scratch member in struct bpf_verifier_env as
unused dead code?

It appears mark_precise_scalar_ids() was the only consumer of these
definitions. Removing them from include/linux/bpf_verifier.h might help keep
the verifier environment structure clean.

File: tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

[Severity: Low]
This isn't a bug, but do the modified and newly added multi-line comments in
the file, including inside linked_regs_broken_link(), deviate from the
preferred BPF subsystem comment style?

The BPF guidelines request that multi-line comments have the opening
indicator on its own line, but several comments in this file keep the text
on the same line as the opening indicator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781194510.gi=
t.jt26wzz@gmail.com?part=3D2
