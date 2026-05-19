Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A03438B9
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217194; cv=none; b=hA5DXiobudHnvI3pRPrDZfdi+TVn5z+e+btMXvh177WmYyKGfOHjyhWUeWBTy5yCXO7DTGxyBTb2Ezp23vqcAMZ+2kHPY/6whvpxCzqolHKNqUFhvpk9IqUrLdIjh9k8ovjuarxOpv4+Neloz6cIl9XwOf7lp0Wd4C6mNZLUfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217194; c=relaxed/simple;
	bh=BrVt6wuFVxM36wdmxFG06fulHz1qh7nj20EKv/kk2EQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4dQZPbLGG9LCbbGzLoitbqrxw0/tz683Nc7MbtIXwVmi5QBdjgufVu8jHYfzZauiV2abBbev4hhS6KcHkIhr3uq3j6slc3y8ASjqPg0ccGodFWLkTd6YyNk87kM8kdu79TzEqNVkGgWyUlZ6FcBH+lu99dPxBih5kp9MTine94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4yp2GNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4yp2GNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0181F000E9;
	Tue, 19 May 2026 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217193;
	bh=JtgFW1rL63NwxVRRDeyxjniBbc+c9YeVEf3clbbffXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4yp2GNfHPnLVg6UWuKdLxsAgl3E2595P1/AJL2XTbjM31P+5O+c5AWI7Mg6kjyn2
	 QTXyMi2CpGCSO3mnppc1K1lcBaMIHJAtJ18nLbVCyUNQg2FsDWD+ZroCjCmFHXU+51
	 5h2WOoirQ21bd+LJmyhCgRoT4nijRzk0QgJmhj/r5+tSTG2LXaWE4K/Jis2Iqs459r
	 W/t3LMZv8e47Yx+nAnCEchHtI4pQoXdV2IKkqWPAC9QzULBvuduhbdsHLk+C1H4oOC
	 QZvZeLW/2DJgxT9QsPKfvERu8yXXmC+OQwVTur1g0tYtlKmD2ESVmh2wQMPXna467o
	 Glyw4/MOLQ/UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 09/14] bpf: Fold ref_obj_id into id and
 introduce virtual references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519181314.2731658-10-ameryhung@gmail.com>
References: <20260519181314.2731658-10-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 18:59:52 +0000
Message-Id: <20260519185952.DF0181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] check_reference_leak() incorrectly rejects valid struct_ops progra=
ms that return a pointer derived from a virtual reference (e.g., a casted p=
ointer).
--

commit 4171c91972499af3939593f911ee11b4fbbe778d
Author: Amery Hung <ameryhung@gmail.com>

bpf: Fold ref_obj_id into id and introduce virtual references

This commit unifies pointer identity and lifetime tracking by replacing
ref_obj_id with id. It introduces virtual references to serve as lifetime
anchors for objects that share the same lifetime but need distinct identiti=
es,
such as pointer casts and referenced dynptr clones.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9854,7 +9920,7 @@ static int check_reference_leak(struct bpf_verifier=
_env *env, bool exception_exi
>  		 * kernel. Type checks are performed later in check_return_code.
>  		 */
>  		if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
> -		    reg->ref_obj_id =3D=3D state->refs[i].id)
> +		    reg->id =3D=3D state->refs[i].id)
>  			continue;

[Severity: High]
Will this correctly handle struct_ops programs that return a pointer derived
from a virtual reference, such as a casted pointer?

Since a casted pointer in R0 receives a distinct non-reference id while the
virtual reference ID is stored in its parent_id, checking reg->id against
state->refs[i].id might fail here.=20

Could this cause the verifier to incorrectly flag an "Unreleased reference"
and reject valid struct_ops programs? Should this check also consider
reg->parent_id when the reference is virtual?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.2731=
658-1-ameryhung@gmail.com?part=3D9
