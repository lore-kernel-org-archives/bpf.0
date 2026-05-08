Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200E32B99E
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214102; cv=none; b=D77h0lEXvyWIuUfdXJjSQ5fL24SoqjRjsatBJ7yB9TS//sM4XED3hheG1jZS/wdsov7CWqr5wEQnGJEJxEhNhjvNfO1V/CrwURbtDgeTQ6gbHl7PlSvBc+532OJiYLFaa6KmdL6vwqnoOwy5/fMYgmonZTEFxOFzrQw9O1jDT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214102; c=relaxed/simple;
	bh=04sJDVLQUE3by5m8DmqTwW2GLxqvV+CjkXfEUpIwoIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hiMhn/7M3UEq9ibHt/LeE3xRpXRyV5aFvfZTPlvhAYYloVm5AWDRTIueJ0wnnx4ts/Y3YNg4T7ckoOrheI9JeIdbl2FT+zxqxhlSDpQhYO+Qwwruv3+6guy9vLKUZG/EGtymJMGcrbhH3GRINYDL/3D91v/a+B2QaPyoWA3pYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMAw4s7J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMAw4s7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC13C2BCC9;
	Fri,  8 May 2026 04:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214102;
	bh=04sJDVLQUE3by5m8DmqTwW2GLxqvV+CjkXfEUpIwoIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RMAw4s7JTQUGfJKND6EcvSPRr8E35eeX++5ycM63haiSKLU565FRmJL9lN11sztgc
	 Te3l5dOS1FG1WZRQcNe+wkLXGkEDBNUElRfVNEPG2YeenpFs6mQH5Qee6cvsq7EOnq
	 wCtG3HdsLMD139Xo03TC42EsnHUndKsJz2CQOCghecuCnZHIpDS3d/0RCJGlOj6J5f
	 Wq9X/ttHq7PM3380Xx8slo8v14fvh9AKTDRsCnSnO/vCi1NqhRcvNIJEMaYHrUgu3x
	 aJpt/XxU6ZPFfnKTkBCH7ylWpIM9EAbODYoUy7qefSl/ndwUuUBQl6wYRlst+oGV3e
	 FaMLNFa3GskWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] ipe: Add BPF program load policy enforcement
 via Hornet integration
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-11-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-11-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:21:41 +0000
Message-Id: <20260508042142.4AC13C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `IPE_PROP_BPF_KERNEL_FALSE` property evaluates to `true` when =
`CONFIG_IPE_PROP_BPF_SIGNATURE` is disabled, violating IPE's fail-closed de=
sign.
- [High] `ipe_bpf_prog_load_post_integrity()` completely ignores the `lsmid=
` parameter, allowing other LSMs to silently overwrite Hornet's integrity v=
erdict.
- [Medium] The documentation provides an insecure policy example that allow=
s unprivileged users to bypass the `bpf_signature=3DOK` check using their o=
wn keyrings.
--

commit 341207097f16b88e2b641d2d93566b204484bce3
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

ipe: Add BPF program load policy enforcement via Hornet integration

Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
to make policy decisions about BPF program loading based on integrity
verdicts provided by the Hornet LSM.

> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index a756d81585317..d68ba9d98859e 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
[ ... ]
> @@ -788,6 +896,58 @@ Allow execution of a specific fs-verity file
> =20
>     op=3DEXECUTE fsverity_digest=3Dsha256:fd88f2b8824e197f850bf4c5109bea5=
cf0ee38104f710843bb72da796ba5af9e action=3DALLOW
> =20
> +Allow only signed BPF programs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllow_Signed_BPF policy_version=3D0.0.0
> +   DEFAULT action=3DALLOW
> +
> +   DEFAULT op=3DBPF_PROG_LOAD action=3DDENY
> +   op=3DBPF_PROG_LOAD bpf_kernel=3DTRUE action=3DALLOW
> +   op=3DBPF_PROG_LOAD bpf_signature=3DOK action=3DALLOW

Since Hornet verifies the program signature against the user-provided
keyring ID, could an unprivileged user bypass this policy by creating a
personal user keyring, signing a malicious BPF program with their own key,
and passing their keyring ID?

Would it be better to recommend explicitly restricting the bpf_keyring
property in this example, perhaps to bpf_keyring=3DBUILTIN?

[ ... ]
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 21439c5be3364..705c4ecfda696 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
[ ... ]
> @@ -297,6 +362,32 @@ static bool evaluate_property(const struct ipe_eval_=
ctx *const ctx,
[ ... ]
> +	case IPE_PROP_BPF_KERNEL_FALSE:
> +		return !evaluate_bpf_kernel(ctx);

When CONFIG_IPE_PROP_BPF_SIGNATURE is disabled, the stub for
evaluate_bpf_kernel() unconditionally returns false:

    static bool evaluate_bpf_kernel(const struct ipe_eval_ctx *const ctx)
    {
        return false;
    }

This causes !evaluate_bpf_kernel(ctx) to return true.

Does this inadvertently cause any IPE policy rule using bpf_kernel=3DFALSE
to always match when the feature is disabled? Should this regression be
addressed with a dedicated stub that returns false when disabled to maintain
the fail-closed design?

[ ... ]
> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index 0ae54a880405a..9271e129a2cf2 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
[ ... ]
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +/**
> + * ipe_bpf_prog_load_post_integrity() - Store integrity verdict in per-p=
rog blob.
[ ... ]
> + */
> +int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
> +				     union bpf_attr *attr,
> +				     struct bpf_token *token,
> +				     bool kernel,
> +				     const struct lsm_id *lsmid,
> +				     enum lsm_integrity_verdict verdict)
> +{
> +	struct ipe_bpf_prog *blob =3D ipe_bpf_prog(prog);
> +
> +	blob->verdict =3D verdict;

Should this check the lsmid parameter before storing the verdict?

In a multi-LSM environment, it looks like any other integrity provider
calling this hook could silently overwrite the verdict previously set by
Hornet, potentially replacing an LSM_INT_VERDICT_BADSIG verdict with an
LSM_INT_VERDICT_OK or LSM_INT_VERDICT_NONE verdict.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D10
