Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA780377AB6
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644781; cv=none; b=ShqiOGfG+jTqSk0521ONYUCT1gm5XjfjgyyecmRGmwDGVsNg6P580JOjrOxI6rwu7KK1BXP4Dm4Qa+p9U1Y/f61yzpSnx5UryQkX9Zhr0ULvY4+rppTlGTU/wQjW3fBrYhRZggsrBDNWGAMQZQDEpZk/raiGg2TG9nqYuMAuImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644781; c=relaxed/simple;
	bh=cDGJtRFHJ1jFm6QjzUPp9kMzKpecNkXdtHYjGuEpL04=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=evcJc+Y0ApAJIW9xg4tPnpreIxucKjjqNlJHX1BwaTIST6mbqeN+DRklEg18+bkaNFKag8WsVe9TE016+8tNWCRprolW/T4CFOrNsG9r4KI4gC6c9kM0ovr0TBrn/INK9OdVXnYUlIleBzTdU6nPjLv1hioQQe1fYvfY0iEtyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5nNhhJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5nNhhJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5521F000FF;
	Sat, 10 Oct 2026 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791644780;
	bh=F3WbufdAbiQ+ZLtpMfrEoszNBRG3wsqWtZ8uP0cEl50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5nNhhJfdv8BBt/M796VY/o89yPr+VrPll+CSDGxtopmXeAfSJ6hG0w6nl4uKxLub
	 h4+Fta2JTvq7oCRH8T5gaZxY2zALd9M1Dmcp8dTWya42ok18hQa+ckLJMo38BX5be0
	 ENsKulr+mFAYTxXSgh1/ebnAzM3fxPrIySzUHD6bITDJG9WfxwlHxxz/G0Vxtib+Fn
	 s1c0DAu57CKzjJ6rLBZ67uvShvYv7HqAxnZzVET18pynTR+JgE9qSST7cymiajKUfY
	 O5CEtXrKtPPnQA6hRDxWQSPFubxtIAe/LArENit4K7VyDdaBvOM2+BeyWxxN4qqHBU
	 04BFGqL+sK9fg==
Message-ID: <sashiko-outbox-166682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 4/7] libbpf: Support declarative manual load
 via SEC("!...") prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010143156.379864-5-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-5-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 15:06:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in bpf_object__init_prog()
--

commit b80dd28fdb1bbcbf64f3eb8617664b84a1b0b738
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

libbpf: Support declarative manual load via SEC("!...") prefix

This commit adds a SEC("!...") section-name prefix, allowing a program to
declare itself manually loaded. It builds upon the existing SEC("?...")
convention and skips the bulk auto-load pass.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 42fb687a97954..043f220ebb136 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -968,11 +968,19 @@ bpf_object__init_prog(struct bpf_object *obj, struc=
t bpf_program *prog,
>  	/* libbpf's convention for SEC("?abc...") is that it's just like
>  	 * SEC("abc...") but the corresponding bpf_program starts out with
>  	 * autoload set to false.
> +	 *
> +	 * Similarly, SEC("!abc...") marks the program for manual loading:
> +	 * it is skipped by the bulk auto-load pass and must be explicitly
> +	 * loaded via bpf_program__load().
>  	 */

[Severity: Low]
This isn't a bug, but the BPF subsystem multi-line comment style guidelines
require the opening /* to be on its own line.

Since this patch extends the multi-line comment in bpf_object__init_prog()
in tools/lib/bpf/libbpf.c, could the opening of the comment be updated to
match the preferred style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010143156.3798=
64-1-andrey.grodzovsky@crowdstrike.com?part=3D4
