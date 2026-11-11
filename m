Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413511;
	b=L9SC1petBXz3U02PwLcrybDrAAQQSJQWzGVIJd/x4jBCwZwwCmxQ8KfUCCuAH9XQfwH3
	 YtlYtEfbmTMVkzrnh3I9DNgxknQ+pM7Pc5bMEszcNSe4fq/E6sBp4gumU/kCSgEKHLfTR
	 4n5zFxXvylXCRY7NFqz1IKHieEaPbgQgkAvSRFr1n685DUpRP9yrdjE4nPkANsaeyrJrv
	 YM3/svDBNgTKMT4lw4Ms/23rqXnBQNK3RO3JTCIKitWdTyQMQZywH+HhbsN+QdICERDb/
	 TtUlb7IvcojGOVzC1+sKZnsVCshjZr8E4ddM1DYFDOllodFBOshC6A7lDaZj+h188VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iLnCXId9UIYEK3kuXj8OGYMQeJ0Ndjd4k4dSDe5R2ZU=;
	b=3OjDrozmyBDw5NpcuG9kjdjEhcee2jn4MRVgMHWg/QvYsP1z4LcfwZor0uHbwtswfntL
	 gX8AY9s+Oxhp1Eds4urpsdP/e61a46/TSeazsEV2qiuU1IAKuMq6mb3ZcXGmUUQWABmXk
	 BAaQjexQotpv8NiHs2ixjB2y3jXKa2x5nZBJcHCbbu/06zm99uw1JG6ijmqWpxWMVbnAF
	 KAT6gMh+Vq2PzCY05XL0vySCzrqXZShvrTSAIYQ4Xc3YzbZjgu+ZqSzRdPG9FrkclndSQ
	 JFY2I12lER/ft3PdoyW3yLHFILb8S6e4l9CQKGlV4itjy8tpSUA3JcM/g4fQnTY/6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=de6w7gLt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29979606A331
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=de6w7gLt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3581F00A0A;
	Wed, 11 Nov 2026 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413510;
	bh=iLnCXId9UIYEK3kuXj8OGYMQeJ0Ndjd4k4dSDe5R2ZU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=de6w7gLtE2Qi5VBFqDRNOkbp7zbAj7sBBXXejdvP5l4fKJkhPxZhnMGpqSl1Gf4HM
	 Al99Swk7v+69xR6VYCQ4/0UsOMZuU6qfJ3n2i/eh13EUacAKpsvuO33IoVkbCYWkm+
	 kbbkicUOxRuZkPj3jaesBlpHpWmt7mWzOOca+ZlI02Q4JkZe9CJ4a6yH2VP0gdYNWM
	 fHteOn5VJfX3hNSrRH/fDHaH2DWqR40geJxXQO43wn0mMMBqHQhA2l5CEYE2P+xcpF
	 PTnnkQqSpt8muICTPSTuZwrP4c5I7nyaE+Immav5W4QRhrzF4hI62vsQkRSCf8FuO2
	 ATjCxNUN3X4hw==
Message-ID: <sashiko-outbox-209260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 15/29] bpf: Describe handles in registers at
 throw sites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <cd23f7c9bbe266852c979693ad25d72fdfc95616.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <cd23f7c9bbe266852c979693ad25d72fdfc95616.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:11:50 +0000
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
- [Medium] bpf: failed state joins on dead registers in
  bpf_states_join()
--

commit 76f36da94410f1998945cf52f9a2b12ce1afb269
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Describe handles in registers at throw sites

This commit records resource handles held in registers in site descriptors
and recovers callee-saved registers across frames during exception unwinding
so that references held in registers at throw sites do not require hidden
stack slots.

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> index 4ec834e31dff5..180b0a96029cf 100644
> --- a/kernel/bpf/join.c
> +++ b/kernel/bpf/join.c
> @@ -663,6 +663,9 @@ int bpf_states_join(struct bpf_verifier_env *env, str=
uct bpf_verifier_state *dst
>  			u16 live_regs =3D env->insn_aux_data[insn_idx].live_regs_before;
>  			u32 cnt;
> =20
> +			/* the registers both keep for a throw are joined, see bpf_frame_desc=
_keeps() */
> +			live_regs |=3D bpf_frame_desc_kept_regs(env, a, fr) &
> +				     bpf_frame_desc_kept_regs(env, b, fr);

[Severity: Medium]
Can adding bpf_frame_desc_kept_regs() to live_regs cause bpf_states_join()
to fail when a dead register holds resource pointers with different offsets
or IDs in states a and b?

bpf_frame_desc_kept_regs() sets BIT(reg) whenever reg points to any held
resource at any constant s16 offset.  If a dead register holds p + 0 on one
iteration of a loop and p + 1 on the next, BIT(reg) is set in both masks, so
join_func() runs join_reg() on the dead register.  join_reg() rejects the
mismatched pointer offsets and aborts the entire state join instead of
clearing the dead register to NOT_INIT in dst, preventing loop widening and
causing verification to fail with -E2BIG once flow_merge() reaches
BPF_FLOW_MAX_STATES.  Similarly, if the dead register holds two different
held resources in a and b, join_reg() in pass 1 calls jid_note() on their
distinct IDs, poisoning js->pairs and failing join_refs_check() in pass 2.

In addition, flow_unset_differs() assumes that only live_regs_before
registers remain initialized after bpf_clean_verifier_state():

kernel/bpf/flow.c:flow_unset_differs() {
	for (fr =3D 0; fr <=3D a->curframe; fr++)
		for (i =3D BPF_REG_0; i < BPF_REG_FP; i++)
			if ((a->frame[fr]->regs[i].type =3D=3D NOT_INIT) !=3D
			    (b->frame[fr]->regs[i].type =3D=3D NOT_INIT))
				return true;
	return false;
}

When a dead register is kept by bpf_frame_desc_kept_regs() in only one of
the two states, flow_unset_differs() returns true and prevents flow_merge()
and flow_end_walk() from joining them while flow_has_room() is true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D15
