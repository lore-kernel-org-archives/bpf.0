Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276A32FA14
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776377838; cv=none; b=Ypw4KK2DfbrD2q8XUnOlmrShDXtddBU7PJodNiJ2b7tcpQ8kk5yk4kwN8Zd25HW5RMYhrFrF22vq3TwcCRx6O0ucw/BGjitee3tC4TCMI1xNzbWrui4WVrjnTCcAls/dN63ig2EgnZYJ9GtFKPEOcMXIkg+0B4pcX6VFS5uQc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776377838; c=relaxed/simple;
	bh=Ed3ZpPCN1qwX2Y9+xn3FctY5fvt35o+FfZD2fHDwYCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4D7iLAf6PjgneUb8buOzQWGdn5FhpHNs6FBTwZWVJEKA8SpmhxhaicyXfznCKZV58Q28He6MDjENiI17cFE74wRpmW4gZwdmWiOltp9sIJ/ObmlAQYTRHOQjry1oR8gI32Ihk5ZKZdyjbRmhzCSAOKE5+JIOr/apLKvSpFh0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV7ZbU+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV7ZbU+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840A3C2BCAF;
	Thu, 16 Apr 2026 22:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776377837;
	bh=Ed3ZpPCN1qwX2Y9+xn3FctY5fvt35o+FfZD2fHDwYCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pV7ZbU+TTS++VRBxZT9mjKSMDYuGDzXJRWfj4u72dJhqTd/5A0wsLuT36FvRySQxt
	 m7ylsy4Rk7H6q0qnDtXtTA7m8+kGp18DHPqoajbdqr+vFJsS7ykXUOEeb787kPCtcq
	 gt2U+wRm2lpi0bilXn0IJR7jkzI0sOz8MfGsaOHyvX12gjMyJt2QWeNau12NSqXb3t
	 5g4tEJRNC36q+wvXE7MB8jmkMaxrcZNKWnrTMokEmeYPbGCLW+X9FKfoYkLgduNEXO
	 7Q5vb42/6D/7APXqZESCyPQ4QuW5Sgmh7nnEWWMWPSNEGeHc2Xp4AJGWJM3i3XKDb+
	 vBgzo9prJ1hSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] ipe: Add BPF program load policy enforcement
 via Hornet integration
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-11-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-11-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 22:17:16 +0000
Message-Id: <20260416221717.840A3C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Low] Build failure when CONFIG_IPE_PROP_BPF_SIGNATURE is disabled due to=
 unconditional access to a conditionally compiled field.
- [Low] The commit message provides an incorrect property name in the examp=
le policy.
- [Low] The example policy in the commit message may be insecure depending =
on the integrity provider's keyring semantics.
--

commit 81e945a1fa4e8ba5734149eaa67ab6ab459e3ad6
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

ipe: Add BPF program load policy enforcement via Hornet integration

This commit adds support for the bpf_prog_load_post_integrity LSM hook,
enabling IPE to make policy decisions about BPF program loading based on
integrity verdicts provided by the Hornet LSM.

>     Example policy for bpf signature enforcement:
>      DEFAULT op=3DBPF_PROG_LOAD action=3DDENY
>      op=3DBPF_PROG_LOAD is_kernel=3DTRUE action=3DALLOW

This isn't a bug in the code, but there appears to be a typo in the example
policy. Should is_kernel=3DTRUE be bpf_kernel=3DTRUE to match the property =
defined
in the property_tokens array?

>      op=3DBPF_PROG_LOAD bpf_signature=3DOK action=3DALLOW

Also in the example policy, is it safe to use bpf_signature=3DOK without a
keyring restriction like bpf_keyring=3DBUILTIN?

If the underlying LSM validates signatures against user-provided keyrings,
could an attacker bypass the policy by signing a malicious BPF program with
their own key?

> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 21439c5be3364..9a6d583fea125 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c

[ ... ]

> @@ -297,6 +342,32 @@ static bool evaluate_property(const struct ipe_eval_=
ctx *const ctx,

[ ... ]

> +	case IPE_PROP_BPF_KERNEL_FALSE:
> +		return !ctx->bpf_kernel;
> +	case IPE_PROP_BPF_KERNEL_TRUE:
> +		return ctx->bpf_kernel;
>  	default:

If CONFIG_IPE_PROP_BPF_SIGNATURE is disabled, will this cause a build failu=
re?

The bpf_kernel field in struct ipe_eval_ctx is only defined within an
ifdef CONFIG_IPE_PROP_BPF_SIGNATURE block.

Could this access be abstracted through a helper function with a fallback
stub like evaluate_bpf_sig()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D10
