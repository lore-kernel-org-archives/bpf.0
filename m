Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134759;
	b=HWwIDTaMC5qrZ12AMAIXjJa8mr7yvcQW5lVsiD/21jwiCDS+CRn6Ajl03v+R4wr6YFtS
	 lDzJ9o7oHXl7s+6xCBst7vHedmYaRONkhWVHXwVSnRTwHNA2GbTDOAMznVfPLrFbDMtxI
	 VMpQKDAHeZ215u+yZSYeHX+ftELgnzjmg+n18MSeuxiW6j+kLja9c9AgAYOilVmI1eVlq
	 5J3eFrIe1jsiFjK5hTSgVkLmh6xHzXER0JkiIgWqG76ID82wQtHgSxFy2ZV4lklxkzMam
	 QFpoFsIBA2biVchBsKZq2Il3oNWNsxY0Ar4Y1bnOYD0bZjf4zW3uEBiwKz7pBqPyblQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d1o31nr9XTJNnB/We8kHs6iXyiw0t2yrcfMrBt5fxWc=;
	b=cdcQi7X+1IIIgyrev5sP2ATnEmFX8C/eDDtw69udlv1iXDPRfzbcrRvCozOLVpdPXQMs
	 DbIkBOcv4rxXVriNLOhJhgIATDv9mtD95BtHvH0gWtp4GfT3/ildKhhIO531/w6wTanE0
	 axMrkvmJe27F8bAUeSuABd/ALylC0WscO2MOxEm2y3LdSaRRDFpGNWwhCDXuAlPF7nGTl
	 mCAEe6KSvUL64vNWaXc3l9cdBXJ6qWT+7zQM1JUOJxsn46pi3K9sNGu+DLeKWHwRC09hp
	 cwVeuIEvXTm3SoMA9fgSVuRQYwGYN7dsJR/1BSkj868ZpJ5IXkpGsCkA+RMeHXGCATA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXDxsvc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F9606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXDxsvc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69FF1F01825;
	Tue, 27 Oct 2026 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134758;
	bh=d1o31nr9XTJNnB/We8kHs6iXyiw0t2yrcfMrBt5fxWc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AXDxsvc2/Hp7TXjds642Kw59/Rn+uulAxUhzKhR4IfC0mUJB6ogxJjYbUXbPtzRg1
	 SKDBuFrOpi/TnVSCzo1lZbw59mczfRPjHqKcQ0sqTw+X0L9QGLtx4fPhfYzKME+9ft
	 YDTTYW3D8awd7B1aKu5Ja141nVztMyOxN5vtqSSTRsjHMWpcAsUWQWitE3Qkf2pZF9
	 QoPVxOjGRezGguVnWSQMjwArZev2m5xZ0c867V8gCcyIm3NCxxmyigIyb4nPEj4zcq
	 M5X66xZq43NryonWzsczQLX9vJqV67RtFblsSSPTpu+7EyiVsU1fT4mxXye4KswpQu
	 9XRJdO4V0Ezuw==
Message-ID: <sashiko-outbox-187108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test the valid bytes of a packet
 pointer in a counted loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261027201436.3192716-3-alexei.starovoitov@gmail.com>
References: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
 <20261027201436.3192716-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 20:59:18 +0000
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
- [High] bpf: missing reg->range reset in bpf_clamp_scev_regs() on loop bac=
kedges
- [High] bpf: incorrect packet range in sync_widened_reg() via reg_umax() o=
n smin < 0
--

commit 1beef654c7066a8a9756b909f171d71afd35955c
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test the valid bytes of a packet pointer in a counted loop

This commit adds BPF verifier selftests covering packet pointer range
adjustments when scalar evolution widens or clamps registers in counted
loops.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/te=
sting/selftests/bpf/progs/verifier_scev.c
> index 37434efd14909..adaf926b80553 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
> @@ -3737,4 +3737,162 @@ __naked void post_cond_jlt32_copy(void)

[ ... ]

> +/* The pointer goes down. 8 bytes from the first r6 are in the packet, n=
ot 10. */
> +SEC("tc")
> +__failure __msg("invalid access to packet, off=3D120 size=3D2, R6(id=3D2=
,off=3D120,r=3D120)")
> +__naked void widen_pkt_pointer_step_lowers_umax_down(void)
> +{
> +	asm volatile (
> +	PKT_PLUS_R4(64, 8)
> +	"r9 =3D 0;"
> +"1:"
> +	"r0 =3D *(u16 *)(r6 + 8);"
> +	"r6 +=3D -8;"
> +	"r9 +=3D 1;"
> +	"if r9 < 2 goto 1b;"
> +"9:"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:: PKT_IMMS : __clobber_all);
> +}

[Severity: High]
In widen_pkt_pointer_step_lowers_umax_down(), starting at offset 64 keeps
bounds.r64 non-negative ([56, 114]), but what happens in
sync_widened_reg() when a downward-stepping packet pointer produces a
signed range with smin < 0 <=3D smax?

In kernel/bpf/scev.c:linear_bounds(), a negative slope subtracts from
min_val in signed arithmetic and constructs cnum64_from_srange(min_val,
max_val). Whenever min_val < 0 <=3D max_val, cnum64_urange_overflow() is
true and reg_umax(reg) in kernel/bpf/cnum_defs.h:cnum64_umax() returns
U64_MAX instead of max_val:

kernel/bpf/verifier.c:sync_widened_reg() {
	u64 umax =3D reg_umax(reg);

	reg_bounds_sync(reg);
	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
		reg->range =3D max_t(s64, reg->range - (s64)(umax - reg_umax(reg)), 0);
}

This causes two issues depending on whether reg_bounds_sync() eliminates
the negative portion of the range:

1. If smin < 0 before reg_bounds_sync() and smin >=3D 0 after
reg_bounds_sync() (for example, r4 in [6, 50] with var_off =3D (0x0; 0x38),
r6 =3D pkt + r4 with range =3D 58, stepping by -8 for 2 iterations gives
bounds.r64 =3D [-2, 50] with step =3D 8, base =3D 0, which
cnum64_intersect_linear() narrows to [0, 48]), then umax before
reg_bounds_sync() is U64_MAX and reg_umax(reg) after is 48. The delta
(s64)(U64_MAX - 48) is -49, so reg->range is inflated from 58 to 107 while
reg_umax(r6) is 48, allowing out-of-bounds packet access past pkt_end.

2. If smin < 0 both before and after reg_bounds_sync() (for example,
PKT_PLUS_R4(0, 8) stepping by -8 for 2 iterations gives bounds.r64 =3D
[-8, 50] with step =3D 8, which reg_bounds_sync() narrows to [-8, 48]),
reg_umax(reg) is U64_MAX both before and after reg_bounds_sync(). Then
umax - reg_umax(reg) is 0 and reg->range stays at 58 even though
reg_smax(reg) dropped from 50 to 48, allowing r5 =3D r6; r5 +=3D 8 (yielding
r64 =3D [0, 56], range =3D 58) to read 2 bytes past pkt_end.

Should sync_widened_reg() track the upper bound delta using reg_smax(reg)
instead of reg_umax(reg)?

> +
> +/* The access is in the second iteration only: the verifier gets to it a=
fter the clamp */
> +SEC("tc")
> +__failure __msg("invalid access to packet, off=3D56 size=3D2, R6(id=3D3,=
off=3D56,r=3D56)")
> +__naked void clamp_pkt_pointer_step_lowers_umax(void)
> +{
> +	asm volatile (
> +	PKT_PLUS_R4(0, 8)
> +	"r9 =3D 0;"
> +	"w1 =3D 0;"
> +	"*(u32 *)(r10 - 8) =3D r1;"
> +"1:"
> +	"w1 =3D *(u32 *)(r10 - 8);"
> +	"if w1 =3D=3D 0 goto 2f;"
> +	"r0 =3D *(u16 *)(r6 + 0);"
> +"2:"
> +	"w1 =3D 1;"
> +	"*(u32 *)(r10 - 8) =3D r1;"
> +	"r6 +=3D 8;"
> +	"r9 +=3D 1;"
> +	"if r9 < 2 goto 1b;"
> +"9:"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:: PKT_IMMS : __clobber_all);
> +}
> +
> +/* r6 is r6 or r5 =3D r6 + 8 at the head. Here var_off lowers umax. */
> +SEC("tc")
> +__failure __msg("invalid access to packet, off=3D56 size=3D2, R6(id=3D2,=
off=3D56,r=3D56)")
> +__naked void union_pkt_pointer_var_off_lowers_umax(void)
> +{
> +	asm volatile (
> +	PKT_PLUS_R4(0, 8)
> +	"r9 =3D 0;"
> +"1:"
> +	"r0 =3D *(u16 *)(r6 + 0);"
> +	"r6 =3D r5;"
> +	"r9 +=3D 1;"
> +	"if r9 < 2 goto 1b;"
> +"9:"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:: PKT_IMMS : __clobber_all);
> +}
> +
> +/* 16 bytes from r6 are in the packet: two iterations read 8 bytes each =
*/
> +SEC("tc")
> +__success __retval(0)
> +__naked void widen_pkt_pointer_keeps_valid_bytes(void)
> +{
> +	asm volatile (
> +	PKT_PLUS_R4(0, 16)
> +	"r9 =3D 0;"
> +"1:"
> +	"r0 =3D *(u64 *)(r6 + 0);"
> +	"r6 +=3D 8;"
> +	"r9 +=3D 1;"
> +	"if r9 < 2 goto 1b;"
> +"9:"
> +	"r0 =3D 0;"
> +	"exit;"
> +	:: PKT_IMMS : __clobber_all);
> +}

[Severity: High]
Do clamp_pkt_pointer_step_lowers_umax() and
widen_pkt_pointer_keeps_valid_bytes() pass as written when
bpf_clamp_scev_regs() runs at the loop backedge?

In handle_loop_entry_exit(), bpf_split_cur_state() snapshots the
pre-widened state into entry->entry_state before calling
bpf_widen_scev_regs(), so entry_reg retains the unwidened r64 =3D [0, 50]
and range (58 in clamp_pkt_pointer_step_lowers_umax, 66 in
widen_pkt_pointer_keeps_valid_bytes).

At loop entry, bpf_widen_scev_regs() calls bpf_set_reg_range() ->
sync_widened_reg(), which lowers umax from 58 to 56 and subtracts 2 from
reg->range (producing 56 and 64, respectively).

At the backedge after the first iteration, handle_loop_entry_exit() ->
maybe_clamp_scev_regs() -> bpf_clamp_scev_regs() recomputes
linear_bounds() from the unwidened entry_reg (again giving bounds.r64 =3D
[0, 58], step =3D 8) and calls bpf_set_reg_range() on cur_func_state's reg
without resetting reg->range to max(entry_reg->range, 0):

kernel/bpf/scev.c:bpf_clamp_scev_regs() {
	...
	linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
	...
	scratch_widened_reg_id(env, reg);
	err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
				bounds.base, bounds.step);
}

Inside bpf_set_reg_range(), reg->r64 is set to [0, 58] while reg->range is
still 56 (or 64) from iteration 1, so sync_widened_reg() sees umax drop
from 58 to 56 a second time and subtracts another 2 from reg->range:

1. In clamp_pkt_pointer_step_lowers_umax(), reg->range becomes 54 at the
backedge instead of 56, so the second iteration fails with R6(id=3D3,off=3D=
56,
r=3D54), mismatching the expected R6(id=3D3,off=3D56,r=3D56).

2. In widen_pkt_pointer_keeps_valid_bytes(), reg->range becomes 62 at the
backedge while the loop header checkpoint has rold->range =3D 64. In
bpf_is_state_visited() -> regsafe(), rold->range (64) > rcur->range (62)
prevents state pruning at label 1, and the second pass rejects the 8-byte
read at r6 + 0 because umax (56) + 8 > 62.

3. Conversely, if entry_reg->range is 0 at loop entry and the loop body
performs a pkt_end check in iteration 1 (setting reg->range =3D
reg_umax(r6) + N) before advancing r6 by a positive step,
bpf_clamp_scev_regs() at the backedge clamps reg->r64 back down to
bounds.r64 while keeping the loop body's reg->range, inflating the valid
bytes (reg->range - reg_umax(reg)) in iteration 2 and permitting
out-of-bounds packet accesses (and similarly leaving negative AT_PKT_END
or BEYOND_PKT_END marks from the loop body intact).

Should bpf_clamp_scev_regs() reset reg->range to max(entry_reg->range, 0)
before calling bpf_set_reg_range()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027201436.3192=
716-1-alexei.starovoitov@gmail.com?part=3D2
