Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811202;
	b=5m4SQ9F7vz889cEx9io2mZPrcEKnoxseU7ZfZALV3JHj+2RqzG57kdzWbrHDqLCNDaQH
	 anTz7f26A6MwTgGF0sl+gutN3ejwJDNKJO5bEDv3QCHOPvErjy07sePgcg28YQgzli6Zk
	 +9XqHv57a44tnASU3xY1Cr+VaGIP4nfO76YZFXNQsPxPHSo/1a56C8Zz6CB01W6ronNW8
	 ZDGqCvZCoRu+Bv4Sx/2tbKkw1nEGxfIr/AqjPJNbNBJ/ynZfWvBoP12Ne6N8uV+NaK5Q8
	 vsrklixE7Sj+AV322YIusdFoIBOOFRUSb9lI8x34NWRjldce/mcXLH/ta4W39Mo6bqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vLJn22a+5nxC81Xu8wK4C9ET8ggPCq5uvqz3JmdzliY=;
	b=nwL8gS/4s5KA2jG8nFi1tWWgVryfQwBEFqrN5P8tUn3c81WwkM5+UuGZmfE8E9x9Regm
	 64aKI9SGQyZz6s/US6y+gSSV2xT2uDjHNtHrYc+rngN6aWSOiAg//0/iufloJDp7W76BK
	 iAK0Agt7v7jtvKqcS5em8INu3Jc6Ibz7sDR5izXFV5knOJWFqvtRIcwqLKvw0xXTOoljc
	 h4MYrgKTELmvnMmjVXAvXeiMg+F7IpoklGj3UTwll5upEyXvnbY/qSRnSfJkcfCIsOEXD
	 3DESaDLhpQxplQ+E8F29MEl8tJqKP5nJPHT3M+jwdlMy+XQopa1EWN3xMdmIYqTeThQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adtvC0FK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC7606A338
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adtvC0FK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7BE1F000C4;
	Mon, 16 Nov 2026 06:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811202;
	bh=vLJn22a+5nxC81Xu8wK4C9ET8ggPCq5uvqz3JmdzliY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=adtvC0FKWaxAOmhYsoJKvknreQTal3h1JsrElSp3+CeGOyfClkVCZMfpTL7jd3qym
	 vqgy1OUZUb1xpEznhR2FowcoaB9WqhP/tE+FO0wyEVeNeITgngCx2JWUPAQ1fSW9LI
	 UBgZzMKz+k1HY61r5P3wdSTP4EZ88H6jxNIokSe/YaLhS91Qh7lhWaF7OW+bi6IBpc
	 hL4sIBO5tnr6k90gSI626X/l7KiDgGTWmwo8Drw23uN+gOphEuh6pDoCqOv3U9e1UI
	 V+niZRhz6ztNEuSHMf9ytqwufJhOrIYy3IaUrd6LHkeRQlL8irwG+WOF8zVY5JUEIE
	 aOzBIFkLgM1AQ==
Message-ID: <sashiko-outbox-216293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 13/21] bpf: Keep the call graph in lists of
 edges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-14-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-14-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:39:59 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: stale recursive flag on dead subprogs in
  check_recursion()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] bpf: tail call kernel stack overflow in
  check_max_stack_depth_subprog() [1]
--

commit 05343e493dd94aadf6b39ccc572d2107a34ec086
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep the call graph in lists of edges

This commit replaces the bitmap-based call graph representation with edge
lists sorted via Tarjan's algorithm, and ignores unseen instructions in
dead code when building the post-verification call graph and subprogram
properties.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e29eb7d7162b6..35b94ab7ba97f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5611,8 +5498,8 @@ static int check_recursion(struct bpf_verifier_env =
*env, struct bpf_call_graph *
>  {
>  	int j, s;
> =20
> -	for_each_set_bit(s, cg->live, cg->cnt) {
> -		if (!test_bit(s, subprog_reach(cg, s))) {
> +	for_each_marked_subprog(cg, s, CG_LIVE) {
> +		if (!bpf_call_graph_recursive(cg, s)) {
>  			env->subprog_info[s].recursive =3D false;
>  			continue;
>  		}

[Severity: Medium]
Does check_recursion() leave env->subprog_info[s].recursive set on dead
subprograms?

Before the main pass, mark_recursive_subprogs() sets si[s].recursive =3D tr=
ue
using a conservative call graph built from all instructions, including dead
calls and every addr_taken subprogram when callx is present.  After this
change, build_call_graph() only adds seen call edges and recorded
callx_edges, so a subprogram that was conservatively marked recursive may
no longer be marked CG_LIVE.

Because check_recursion() only iterates over CG_LIVE subprograms,
si[s].recursive stays true on non-live subprograms.
bpf_insert_recursion_checks() runs before bpf_opt_remove_dead_code() and
scans all subprograms, so a stale recursive flag sets
env->prog->jit_required =3D 1 and causes bpf_do_misc_fixups() to reject val=
id
non-JITed programs with -EINVAL.

[ ... ]

> @@ -5924,7 +5809,7 @@ static int check_call_depth(struct bpf_verifier_env=
 *env, struct bpf_call_graph
>  		 */
>  		depth =3D dinfo[s].depth;
>  		/* nor of the frames of recursive subprogs, see bpf_insert_recursion_c=
hecks() */
> -		si[s].in_recursion =3D test_bit(s, cg->in_recursion);
> +		si[s].in_recursion =3D cg->marks[s] & CG_IN_RECURSION;
>  		if (si[s].in_recursion)
>  			depth +=3D THREAD_SIZE / 2;
>  		if (s && si[s].has_tail_call && depth >=3D 256) {

[Severity: Critical]
This problem wasn't introduced by this patch, but can the 256-byte caller
frame limit for tail calls in check_call_depth() overflow the x86-64
exception stack [1]?

Across a chain of 32 tail calls, allowing up to 256 bytes of caller frames
to remain on the stack per tail call accumulates up to 7936 bytes, and the
final program can still use a 512-byte frame (MAX_BPF_STACK) for a total of
8448 bytes.  Because tail calls disable the private stack, a perf_event
program running in NMI context on x86-64 without KASAN executes on the
8192-byte hardware exception stack (EXCEPTION_STKSZ) and overflows it.

[1] https://sashiko.dev/#/bug/linux-d03fddb6-2a86-4813-a8c6-9b07915dc3d1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D13
