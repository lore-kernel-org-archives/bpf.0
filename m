Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3073DAAB5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750454; cv=none; b=D+ztJW1FWSHao3KFBwWbH1a+aX1E9buglEiZo1Dm8f4Z/D7F99uQgZQfXSuykdmSWeTjqJrjQ6J5p9RzF+3c6X7YE9DEPVtJ8kOwoV+WNqt7JmIquxPiK1AiO1A4oUimNr+mBgd0L1jRwfmxayu3BQ85vHvVpU8m6rdTah/r0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750454; c=relaxed/simple;
	bh=jkzAgVVZ0fyGZwBy2caJ93xpB3p1PJXfyOLNuaN0EKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T+z3EhCNf5MQJbqIAO554gGUdL/m4gj9r3uTEm0zBrdlM51HE5X20N8yXiho2Fw2Wrejuoxe+NHrlaJLGb/+nZ3ETrMNlLB7zgq7M/IcOW4akfsiJtKr69HrgkWiXySo8co+nTStDInqXt2U/SndI78ENMYwm3E7kCWJxSUnyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWlqMje8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWlqMje8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FF61F000E9;
	Fri, 14 Aug 2026 23:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786750452;
	bh=hbniAEc2M0JnCmmP6csRwhTsULcvwLeFssgIJM3x4Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWlqMje86sC2U7EevtPZHgS5/0DhcENEd9hYm665rPCqwG+XGOCFRPj7lbhxTJkFq
	 nkjArUeyLcJC8kZnLIeI6aE1gjKvpc6BzMNvoFe1PpAnaJnphCCCBfeev8k03+Ab45
	 SSOfzQF+QO5yqNZr2aFJxL4fgWT87wf6WUnYL5VdHgTzmjuqbXR5FTwe/ASdZM0SKR
	 9y/tQyyIzTlbAKUDC1K6CcjOamW5TQDqkptgXFzjmWRnSDLD3q74kZlWfUOw0XnlVw
	 nEAmZNUymmSB4uMCmfV2WWPNRwbGC/yOYpmfRWsOnflij2j0jItYNNHs+zskuefYAk
	 HragDW9yi/koQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 2/6] bpf: move the linked-scalar flags into
 bpf_reg_state->flags [NFC]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814231945.3884596-3-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-3-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:34:11 +0000
Message-Id: <20260814233412.57FF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing BPF_FLAG_ADD_CONST check in the explore_alu_limits verific=
ation path allows incorrect pruning of incompatible linked scalars.
- [Medium] Narrowing spills of scalar registers fail to clear BPF_FLAG_ADD_=
CONST linkage flags, leading to stale flags on unlinked registers and subse=
quent pruning failures in regsafe().
--

--- Patch [2]: [RFC bpf-next 2/6] bpf: move the linked-scalar flags into bp=
f_reg_state->flags [NFC] ---
commit 19636caada7b86a42b8056f18241af3d2e662845
Author: Vineet Gupta <vineet.gupta@linux.dev>
Subject: bpf: move the linked-scalar flags into bpf_reg_state->flags [NFC]

This patch moves the linked-scalar flags from the bpf_reg_state->id field
into a dedicated bpf_reg_state->flags field. It also updates the verificati=
on
logic to explicitly check these new flags using the link_flags_match helper
where appropriate.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index f7a0314fa1064..d3105b9a9965f 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -488,11 +480,32 @@ static int clean_verifier_state(struct bpf_verifier=
_env *env,

[ ... ]

> +static bool link_flags_match(const struct bpf_reg_state *rold,
> +			     const struct bpf_reg_state *rcur)
> +{
> +	if (!rold->id)
> +		return true;
> +
> +	return (rold->flags & BPF_FLAG_ADD_CONST) =3D=3D (rcur->flags & BPF_FLA=
G_ADD_CONST);
> +}
> +
>  static bool regs_exact(const struct bpf_reg_state *rold,
>  		       const struct bpf_reg_state *rcur,
>  		       struct bpf_idmap *idmap)
>  {
>  	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 =
&&
> +	       link_flags_match(rold, rcur) &&
>  	       check_ids(rold->id, rcur->id, idmap) &&
>  	       check_ids(rold->parent_id, rcur->parent_id, idmap);
>  }

[Severity: High]
Does the explore_alu_limits verification path also need a similar update?

In regsafe(), when env->explore_alu_limits is true, the verifier uses a
strict comparison:

regsafe() {
        if (env->explore_alu_limits) {
                return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id=
)) =3D=3D 0 &&
                       check_scalar_ids(rold->id, rcur->id, idmap);
        }
}

Since memcmp() stops at the id field, it misses the newly added flags
field. Without calling link_flags_match(), states with the same base
scalar IDs but different linkage flags (such as BPF_FLAG_ADD_CONST32 vs
BPF_FLAG_ADD_CONST64) might be incorrectly deemed equivalent, bypassing
the strict bounds checking intended by this mode.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8925749d636e6..93e69116ca9ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3308,6 +3309,7 @@ static void clear_scalar_id(struct bpf_reg_state *r=
eg)
>  {
>  	reg->id =3D 0;
>  	reg->delta =3D 0;
> +	reg->flags &=3D ~BPF_FLAG_ADD_CONST;
>  }

[Severity: Medium]
Can narrowing spills leave stale flags on unlinked registers?

When a linked scalar register is spilled with a smaller size,
check_stack_write_fixed_off() copies the register and manually breaks
the relation by setting the id to 0:

check_stack_write_fixed_off() {
        save_register_state(env, state, spi, reg, size);
        if (!reg_value_fits)
                state->stack[spi].spilled_ptr.id =3D 0;
}

Since the linkage flags were moved out of the id field, setting id to 0
no longer clears the BPF_FLAG_ADD_CONST bits.

If this state is later compared in regsafe(), link_flags_match() will see
rold->id !=3D 0, but rcur->id =3D=3D 0 with a stale BPF_FLAG_ADD_CONST flag.
Because the rold->id check does not short-circuit for rcur, the helper
will evaluate to false, incorrectly rejecting a state that is safe to
prune.

Would it be safer to use clear_scalar_id() or otherwise clear the flags
when breaking the relation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814231945.3884=
596-1-vineet.gupta@linux.dev?part=3D2
