Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662613BBFC1
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611785; cv=none; b=VOVCHjiM7n5YuacCnH1szRHdAk5r+LF6sDuvEQQbB4sKCCmkNLCNt71sqqMZ1UO6G4mjuXgt+Mo8q5lpSCiUVZLsTI+V3lcKRYgct8QG1QcBSR7ldaTKo6B++IIl4AU68LOT9MSH9Tn6cAXOssA1+T8hhKu2KfVdgTm0Fbl0w88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611785; c=relaxed/simple;
	bh=6hx4DPiXn+spZ//lo8PiUXH18Xf/TY21t9uTOUwz8Ls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfkW4iicRBUxSheWMemqPYP2rM7/U2DzJG981/0jz0qnOO0jqijQsqVW1h5Z6bQ8UjCHpC/Wrx4wZZ+dV/uyykkx2b/CYy1Cvy48ble255URjEreZn55j99Lhu02oFYaPns5zXn6a7uMk2S5Ztg4TX+Z3KD1X4FaouGD6f4dN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAWBLpsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAWBLpsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4421F00893;
	Thu,  4 Jun 2026 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780611784;
	bh=ImTwkn+Q3KO1Y1VcL/a7rWixmv23OLDNFn4kEb6B3/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAWBLpsSruiP4Rnmf5ICexo4xA/ulnfBnHQCRDgbGeYy2Gfc5/b8DLpV+1WrRQFrj
	 R+HzPsAybZAXPMvth4jrug5t9/G2bxE0GR/6kpsjw3+VYU7ohbf0vivRtYDXJJNb+i
	 spVJoG//mdzbBShNNfDosphIcecgCttWlBM6xqmCOhkkI9vGU8WxPdClHFPJO9MT4L
	 dXvw2dN+o7u3mqDNaXw18s1yuvGtz/aDvxLyUkFoAJ28MiiSFocMMYdIp+Iyko3E57
	 2WPwumVgSnHaDLmW5VG96C48ewYc4vMY7zZlS85QHQbzZNAdh+5rt+fea/gNTRoDrP
	 RZoU5MChqu8hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for
 REF_TYPE_PTR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604220904.1032145-3-ameryhung@gmail.com>
References: <20260604220904.1032145-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 22:23:03 +0000
Message-Id: <20260604222303.DE4421F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Triggering WARN_ON_ONCE(1) in check_ids() via BPF_ID_MAP_SIZE exha=
ustion with leaked references.
--

commit 22d2263c4d3e606f05ac37e06afa0b46878b3f51
Author: Amery Hung <ameryhung@gmail.com>

bpf: Compare parent_id in refsafe() for REF_TYPE_PTR

This patch updates refsafe() to compare the parent_id of each reference
for REF_TYPE_PTR, fixing an issue where two states could be wrongly
treated as equivalent if their PTR references only differed in the parent
object they were derived from.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, s=
truct bpf_verifier_state *c
>  			return false;
>  		switch (old->refs[i].type) {
>  		case REF_TYPE_PTR:
> +			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
> +				return false;

[Severity: High]
This is a pre-existing issue, but does adding this extra check_ids() call
make it easier to trigger the WARN_ON_ONCE() in check_ids() via idmap
exhaustion?

Because acquired_refs does not have an explicit limit, a BPF program
could acquire many references (for example, via bpf_sk_lookup_tcp) and
leak them before a branch merge point. When states_equal() invokes
refsafe(), it calls check_ids() for each acquired reference.

The idmap has a fixed size based only on registers and stack slots:

include/linux/bpf_verifier.h:
#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE + \
			  MAX_STACK_ARG_SLOTS) * MAX_CALL_FRAMES)

If a program accumulates enough leaked references, checking them all
will run out of idmap slots and trigger the warning:

kernel/bpf/states.c:check_ids() {
	...
	/* Reached the end of known mappings; haven't seen this id before */
	if (idmap->cnt < BPF_ID_MAP_SIZE) {
		...
		return true;
	}

	/* We ran out of idmap slots, which should be impossible */
	WARN_ON_ONCE(1);
	return false;
}

Since this patch maps up to two IDs per reference (the reference id and
now the parent_id), does this allow exhausting the BPF_ID_MAP_SIZE much
faster? Could a user intentionally leak enough references to trigger this
warning and potentially panic the kernel if panic_on_warn is set?

> +			break;
>  		case REF_TYPE_IRQ:
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604220904.1032=
145-1-ameryhung@gmail.com?part=3D2
