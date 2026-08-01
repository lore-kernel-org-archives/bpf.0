Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2823E325
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548552; cv=none; b=mwljoyAOYqHEN6VwdJfxfE2jvkvZTwiy1VKhhTT6TPjpjTpew/bpMwKm/erVQj7NDYrJiu3T2gYJsfdEWef22w1y5ErBTmNiym3E5YBxhraezpDKQoxdfSdtG18+R7E8iEqd9zLXVDgBp25AvsvRswz3onGXoKAMTgdIiLEKY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548552; c=relaxed/simple;
	bh=BWF4pMHyg+slNtWZdrVpRlKKRUBVMvsAXuhtL6ihX9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C2zcMsZcQ7A0jR+13fqGpDwGqFqlZQrhia+DljlDJ3+3BfuUCYAbTxsT46JT/M3rrW2sjXIgVTk5tcEnyZlHN7bqP1nm97qAl1oc+BZux23yKEYODYpwtVDMTw73ZhEBDXU078szuUYO9BE7BxG1W/CZ88lMGqbjG4dLDJnOtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAtvM8+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAtvM8+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9891F00AC4;
	Sat,  1 Aug 2026 01:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548551;
	bh=7rwgNc+F9WFGIm6PJodLyoFeu+RlPM4cjTDHALkCzA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAtvM8+Cy7xKD0AOqnpx84cJcNJ6t/iD4t/hfxAaMAFjLQqRZL0DmZQUihdDke+kG
	 zzxKCTAvSg9BBA2x5eHpIe6JjAESzOOtSIxRYpBMHxQ8/P96efU2ZzqV2zRhCgwezt
	 oNOQi8wFRMDLDGP8fdCm7YyBmA2x3qMunWmbZeTWoC0YKCy+3k+yMLaOdG7BusnvTz
	 MNFcP6cWhF/OL0uPVNdUjUATG/F3pAizTS2XW3+vOuAQTn3jP60Jqe1EQVnoOgjMsT
	 ey+hV87KcOaTzRu6adk3HcwZ5PbgKAxwNVjhYIQXZp22zOAFPSvVVKPe6uM26pcVW1
	 8g8PX+QfKli4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/5] bpf: infer zext_dst based on static
 register liveness analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v2-3-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
 <20260731-static-zext-v2-3-da4aa161e8c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 01:42:30 +0000
Message-Id: <20260801014230.CF9891F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dynamically downgraded 64-bit arena operations and pointer casts a=
re missing explicit zero-extension on architectures requiring it.

Pre-existing issues:
- [High] Kfuncs bpf_mem_cgroup_memory_events and bpf_mem_cgroup_vm_events d=
o not properly validate negative enum values, leading to out-of-bounds arra=
y reads.
--

--- Patch [3]: [PATCH bpf-next v2 3/5] bpf: infer zext_dst based on static =
register liveness analysis ---
commit 625c020066cfbb5a384d20ff5e1ad79faa898949
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: infer zext_dst based on static register liveness analysis

This commit replaces the verifier's subreg_def based logic with computing
zext_dst statically as part of bpf_compute_live_registers(). It tracks the
liveness of the upper and lower halves of registers separately to emit expl=
icit
zero extensions on architectures that need them.

Link: https://lore.kernel.org/bpf/CAGKGUv=3DsOuqQtA1Ub-5JXfA4FPosJFYKAQE4B7=
9cK+P1erxqtg@mail.gmail.com/

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index d0bd94c60fee2..77b84b367be74 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -2316,9 +2317,18 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
>  	}
> =20
>  	for (i =3D 0; i < insn_cnt; ++i) {
> +		int def32 =3D bpf_insn_def32(&insns[i]);
> +		u32 out =3D state[i].out;
>  		u32 in =3D state[i].in;
> =20
>  		insn_aux[i].live_regs_before =3D mask_lo(in) | mask_hi(in);
> +		/*
> +		 * On architectures where 32-bit operations do not reset upper halves
> +		 * of the registers, the verifier needs to zero extend a destination
> +		 * register if an instruction defines a 32-bit subregister and the
> +		 * upper half of that register is alive after the instruction.
> +		 */
> +		insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(out) & BIT(def32));
>  	}

[Severity: High]
Does this statically evaluate zext_dst before some instructions are dynamic=
ally
downgraded?

If an ALU64 operation with a PTR_TO_ARENA operand is statically evaluated
here, zext_dst evaluates to false because it is still a 64-bit instruction.

Later during verification, adjust_reg_min_max_vals() sets needs_zext =3D tr=
ue.
Then bpf_do_misc_fixups() downgrades the instruction in-place to a 32-bit A=
LU
operation:

kernel/bpf/fixups.c:bpf_do_misc_fixups() {
    ...
    if (env->insn_aux_data[i + delta].needs_zext)
        /* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU64 to 32-bit ALU */
        insn->code =3D BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
    ...
}

Since this bypasses bpf_patch_insn_data(), zext_dst remains false. Could th=
is
cause bpf_opt_subreg_zext_lo32_rnd_hi32() to skip injecting the required ze=
ro
extension, leaving garbage in the upper 32 bits on architectures like s390x
and potentially leading to out-of-bounds accesses?

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds array
read in some memcg kfuncs due to missing negative value checks on enums.

In mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():

    if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
        return (unsigned long)-1;

    return atomic_long_read(&memcg->memory_events[event]);

Because the BPF verifier treats the event enum as a signed integer and does=
n't
check enum ranges, can a BPF program pass a negative value to bypass this
check (e.g., -1 >=3D MEMCG_NR_MEMORY_EVENTS evaluates to false) and cause an
out-of-bounds read?

Similarly in mm/memcontrol.c:memcg_vm_event_item_valid():

    if (idx >=3D NR_VM_EVENT_ITEMS)
        return false;

    return !BAD_STAT_IDX(memcg_events_index(idx));

Could a negative idx bypass this bounds check and cause an out-of-bounds
access inside memcg_events_index()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v2-0-da4aa161e8c5@gmail.com?part=3D3
