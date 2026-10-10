Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869E386552
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645718; cv=none; b=kY67mcwdds8BpDMBByHagu1rOm/ZMWV6FHsSQIZbItKTBgeD1P6sSpg3+nYcqs4B2sWDjlKgj0NWx5ejhBU6sl31Ni3y4JjiWxVRGbC+9R9/IOky/IH2Un7jNEXWASw8BsuIhz2ik6URq9BUpufltW8yUYq6t8gGKyms64ibpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645718; c=relaxed/simple;
	bh=r6HVocPWHCBOkuUcDvVY/5gSnlL0V60eoh86qJkXWo4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z+6U21Noubq+bmlITnS90L4E3NR6frvvWSBnrpmEQ3ESbHDReNtpDv5HsSDM4ARIJPw048tUjxTA1GNQWddMLng0OfNzqxYrcS2N4vIrRQd5gWL+aYg1Q6okh1etiSsVXq4dwf2IUeHyK/3mfDxnSU0pBsJsY95lCMBZS/z9BSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm3dtjvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm3dtjvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE61F000FF;
	Sat, 10 Oct 2026 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645717;
	bh=5cvI4RBOU5VRljwtOWEqGsHUPpgzoJomYd/gf1FO0tI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Cm3dtjvKwhxfGIkus91XEp5eZp++Ps5xl504m+Hv99EN4r6tNdtyxSFpfdmbLv3B4
	 lAsXyaw8vgHPmcl/GMtCHmzZM18BQRjtdgQxNS/Pzk5a3kM9brSBskgVAIPusgc4/5
	 i0GXdhW1EXj72hYE9N/i158YwHbNHNRIIgQ68Wu1y5o6FpnlfKM786CfqndjA/4UES
	 D19ZLda3V8FjUj87mjFS4g0Im9gogaBlJYZwK0WvWDhfXh2QXCeACQW3vBnggHU9+0
	 hy0pRjyMmYao6vZMHcRSUcHBSYbtsUMYm5eW8nijgRsSyXbCu+pFoNE/+G7EN85MAW
	 8Wl6g4Ta7HKCg==
Content-Type: multipart/mixed; boundary="===============4987142490103924903=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac05874f317b38b72dc1378b1c27a14669a75cf05b19fb7a3cdce307c954d637@mail.kernel.org>
In-Reply-To: <20261010143156.379864-2-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v6 1/7] libbpf: Reject gen_loader set after PREPARE step.
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 15:21:56 +0000 (UTC)

--===============4987142490103924903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Reject gen_loader set after PREPARE step.

TL;DR: Commit message only, not a bug: the changelog could say what breaks
when gen_loader is enabled after bpf_object__prepare() (earlier steps go
unrecorded), and "running the loader" wording is unclear.

> libbpf: Reject gen_loader set after PREPARE step.
>
> It's wrong running the loader post prepare
> as most of the recording happens there.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

This isn't a bug, but could the changelog say what actually breaks when
gen_loader is enabled after bpf_object__prepare()?

For example, bpf_object_load() calls bpf_gen__init() and then only records
the program loads, so the BTF load, map creation, and extern and CO-RE
relocation recording done inside bpf_object_prepare() never make it into the
generated loader.

Also, the wording "running the loader" reads as executing the generated
loader, while the code change is about enabling gen_loader recording.  Could
that be tightened to describe the recording?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38061962076
--===============4987142490103924903==--
