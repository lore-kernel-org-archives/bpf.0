Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129447;
	b=DkWE7xjxyJV6QA+4R7bGLhPzCPVd7Z9PDrozF+ePDv897SBPvR8BrnsVSifpBrNMDMZW
	 0NgzjwWgKsHM+jdBRv3hfXcyuuk83PSf6kMJfEfH/8WsnH8/q9RVY4EiBbQnIr59y4uEv
	 PSENW3CjUu3LNR2FYJgQ7at8Q1kQDFp8CAgkVX3qwdFLvsz5uzeZqS58ZHCGf9uww8u1K
	 SDZYt93D9FwjO9Rk94qSK3aNuXcgJuWbBu/w4F5sDFfqjJplqQPLAQgvuuG1EYdnM/TIz
	 BWXYFQyJPack6LXGdAnon1rD8XnL+eehxFbVpDafzeXpldMth/CWTuJWw6oPV+KGBaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=//kkAIRvIOwma0JUUomd5dTWJMUKweItzFG0pjpcdAs=;
	b=ZiNKXIisRLmmMn68jxYbsyJlqSSK2fjfaBaYpSAqvuZylmgi1rhQ+RrUfYL3dU6lRZSa
	 15IQpnZgLMGe2RpwxTYUSAxJhyLNgxz0pt5jFVcOwXDJPQDzvb07PdoDH5n091yY3+5xx
	 L/odBRFFTiFNsfs+gql1hZP+QLxFDYEEY1xlEruGyMObA1jcMIngP7iVye0MeI2DeSRyv
	 WC3Jw2Kb515ehLk0RWPKEdu3ExvEaVVetP0rZO37tL1ycuF6kYyqtrfBBXHBFrM5lLr1U
	 puAvihFRO1qcx42j06U9P79RqqDeQAg+1yTF3rdy7bxrizJYrM42Au/tUDUOoZj6k1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i6TWhCl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C9606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6TWhCl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FDF1F01825;
	Tue, 27 Oct 2026 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793129446;
	bh=//kkAIRvIOwma0JUUomd5dTWJMUKweItzFG0pjpcdAs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=i6TWhCl/TBd1i6ijQdOtAaK76eOH4m76aHgfqJ8oYeY+3AXeLQynBOmIy2Mm2F+ws
	 vmJR5fc3dLojfHfPZ8Bx9hUSqNDtAalmnO969xG4rasUEafdhdMWnp7hN/ipY/frVg
	 0RKwLAXogid5FcbrmSAhkqxkT/a0MY9fRGuX71WWsSRAi7DWd4+VjZzKvBE+OmNCb3
	 uZwEbdtl4Nfrs68/3gtBeohazgS7EjL1H7cr/wTVP5UAZJ0/VFOQNonXfSp40lYBhW
	 iWND63bVk2kTzoe5n6KPhhG6uG1gvp3wuMuP1IHsMPC/knVLXzDWHTn+DVCAI7GMrA
	 FSzdxjb6xSDSw==
Message-ID: <sashiko-outbox-187068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 14/19] bpf: Reset the range of a packet pointer
 that scalar evolution clamps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261027190314.1440199-15-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
 <20261027190314.1440199-15-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 19:30:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: out-of-bounds packet access via step tightening in bpf_cl=
amp_scev_regs()
- [Medium] bpf: bpf_widen_scev_regs() does not reset negative packet pointe=
r range
--

commit a6747880bf7fa92bdac4e2fa9d3223b8203c86f7
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Reset the range of a packet pointer that scalar evolution clamps

This patch resets a clamped packet pointer's range to max(entry_reg->range,=
 0)
in bpf_clamp_scev_regs() so that packet bounds gained from pkt_end comparis=
ons
inside a counted loop do not remain attached to the widened offset range ac=
ross
all iterations.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 89f96682af3ff..7b82fd79f9cc9 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2914,6 +2914,13 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *e=
nv, struct bpf_func_state *cur
>  			bpf_log(log, "\n");
>  		}
>  		scratch_widened_reg_id(env, reg);
> +		/*
> +		 * The range of a packet pointer goes together with its id and with th=
e offsets
> +		 * that it had in the compare with pkt_end. Both are replaced here. Wh=
at holds for
> +		 * the new offsets is the range at the entry.
> +		 */
> +		if (type_is_pkt_pointer(reg->type))
> +			reg->range =3D max(entry_reg->range, 0);

[Severity: Medium]
Should bpf_widen_scev_regs() also clamp reg->range with max(reg->range, 0)
when widening a packet pointer at loop entry?

When a packet pointer fails a pkt_end comparison before a counted loop,
mark_pkt_end() sets entry_reg->range to AT_PKT_END (-1) or BEYOND_PKT_END (=
-2).
At loop entry, bpf_widen_scev_regs() replaces the packet pointer's id and
offsets across all iterations without clearing a negative reg->range:

kernel/bpf/scev.c:bpf_widen_scev_regs() {
	...
	scratch_widened_reg_id(env, reg);
	err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
				bounds.base, bounds.step);
	...
}

If the loop has a negative slope that moves the pointer backwards into the
packet on subsequent iterations, is_pkt_ptr_branch_taken() in
kernel/bpf/verifier.c will still fold pkt_end comparisons on the widened
register using the stale negative range marker.

In addition, when the backedge reaches the loop header, bpf_clamp_scev_regs=
()
sets rcur->range to 0 via max(entry_reg->range, 0) while the widened header
state still has rold->range < 0, causing regsafe() in kernel/bpf/states.c to
reject state pruning at the loop header:

kernel/bpf/states.c:regsafe() {
	...
	if (rold->range < 0 || rcur->range < 0) {
		/* special case for [BEYOND|AT]_PKT_END */
		if (rold->range !=3D rcur->range)
			return false;
	}
	...
}

>  		err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
>  					bounds.base, bounds.step);

[Severity: Critical]
Can preserving entry_reg->range across bpf_set_reg_range() here (and in
bpf_widen_scev_regs()) allow out-of-bounds packet reads and writes past
pkt_end when bounds.step tightens reg_umax(reg)?

In find_good_pkt_pointers(), comparing a derived packet pointer against
pkt_end sets reg->range =3D reg_umax(dst_reg), and check_packet_access() ->
check_mem_region_access() allows accesses of size bytes when
reg_umax(reg) + off + size <=3D reg->range. As seen in commit b88822d2584f
("bpf: Fix packet range of pointers sharing an id"), tightening the umax of=
 a
packet pointer via var_off alignment while keeping its range is unsafe.

Before a counted loop, a packet pointer can have an unaligned umax paired w=
ith
an aligned var_off and step =3D=3D 1:

  r4 &=3D 0x38
  if r4 > 50 goto exit      ; r4: r64=3D[0, 50], var_off=3D(0x0; 0x38), ste=
p=3D1
  r6 =3D pkt_data
  r6 +=3D r4                  ; r6: pkt(id=3D1, r=3D0, r64=3D[0, 50], var_o=
ff=3D(0x0; 0x38), step=3D1)
  r5 =3D r6
  r5 +=3D 8                   ; r5: pkt(id=3D1, r=3D0, r64=3D[8, 58], var_o=
ff=3D(0x0; 0x78), step=3D1)
  if r5 > pkt_end goto exit ; r6: pkt(id=3D1, r=3D58, r64=3D[0, 50], var_of=
f=3D(0x0; 0x38), step=3D1)

When entering or clamping a 2-iteration loop (max_header_count =3D 2) that
increments r6 by 8 (slope =3D 8), linear_bounds() in kernel/bpf/scev.c comp=
utes
bounds.r64 =3D [0, 58] and promotes tnum_alignment(entry_reg->var_off) into
bounds.step:

kernel/bpf/scev.c:linear_bounds() {
	...
	if (cnum64_is_const(reg->r64) && !overflow) {
		out->step =3D slope_abs;
		out->base =3D imod(reg_smin(reg), out->step);
	} else {
		out->step =3D 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_=
abs));
		out->base =3D 0;
	}
}

Here bounds.step becomes 8. Calling bpf_set_reg_range() -> reg_bounds_sync()
-> __update_bounds_from_step() -> cnum64_intersect_linear() then rounds
reg_umax(reg) down from 58 to 56 while reg->range remains 58 (and similarly
rounds [0, 50] down to [0, 48] with range =3D 50 for a negative slope r6 -=
=3D 8).

At runtime, if r4 =3D=3D 48 and pkt_len =3D=3D 56, on the second iteration =
r6 reaches
pkt_data + 56 =3D=3D pkt_end, but check_packet_access() will permit a 2-byte
access at r6 + 0 because reg_umax(reg) + 2 <=3D 58.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027190314.1440=
199-1-alexei.starovoitov@gmail.com?part=3D14
