Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756332;
	b=j8wClQkxNz3x4b6jCfzf6bxIGl05h9ClZOHCXu5xnoYoX485zLoYYkGmzvymR/rfhlw0
	 8VeXYy7+78y6oKGekngNkLXf1qDbQVwPfyu7XR8KZpF6q0s+0ti29G30CMPjZccHrvmls
	 4yosWNFhy8SwESUAwv50cr36mOLYsESKmqWzr3UrBvn3yQ2imlShlkPBDBg3W/WgfsBpZ
	 wTFdLCEj6pH4uz5ue4dSAcFn9l3Vg/pIINoCy38cYUnqL8XOOApBdtuVbIno3lcS05sSp
	 kYTskIJnE8iIef7Oi20KW0FREG6dWqzgwPMTpO9awzy4KQUzJxP0TSkrs5G/Al4c0NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756332;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1ji34McIdPkUDSNFBA559P3vVFsjSQYecigeqVmnwN4=;
	b=yfr3Zh7r74bSAB0SUNIdm06JoDCisQKmvOjHL4kXcF6MGlgagZ5+4vNi87qcmFGnlGm8
	 UcmOJ1bsHgqcSAsCRiFBUgRhS6LiTawLEhN3c2qBLAmrHV5yCQonbUAcj+rfJ4+ZVAD1A
	 W86Ke+J03U4hXEhi7vn9IOkNnkfJktRP3IZVoF6CjwBr3vE+LJPUqbEiXY9PrV4ue7XIC
	 AB8P1LLFum8SjBE4JaqLBo9luouQdNNp99ykABP8Yu6CmfIqonWGwacrFO4XeNVm1fe/g
	 P3D7KSzBI5PRVvpYw5Mal5snVEqtzsW0mgx1gx/LRTmS/lb10UcYaTpOINtWNsXmzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUCbiK+m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5595606A31A;
	Sun, 15 Nov 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUCbiK+m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242F51F000C4;
	Sun, 15 Nov 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756331;
	bh=1ji34McIdPkUDSNFBA559P3vVFsjSQYecigeqVmnwN4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aUCbiK+mi6ztqqpoxzxpeakgQTdBujT6mE/f9A13TWdPQoAnQKIcXpLI6t8bAEawx
	 6nRG1U6wuunI7tHx8BGRoPbMOrJm8mQcqNYreT+N5eybHPgM99WUqR/Iz9jH96V5kw
	 DehUlj5r7YJTWMqnjTLB3feUnjeckzVjbVFgn/t3YDchuk3aWKLA4sDTvk4gKOZkkw
	 tYHGOpameQCkihz3AlHmw0n2Lv+JA8YZdExOT71/xPgXWWMGGrquBqPM3A6tzi1B9O
	 uVgmoARfH2XTj82/COO63Hy6Hb/dcIK//fZJKtdy/HSU3oNgkCqBkJNWrccdN6s13U
	 pn1MYQFzLsAXA==
Content-Type: multipart/mixed; boundary="===============1426439364760055920=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2e6fd613596d335e06d0f884805fc44489147147fcfc946780eb460db26fec58@mail.kernel.org>
In-Reply-To: <20261115144556.41927-1-shijing.wuqi@linux.alibaba.com>
References: <20261115144556.41927-1-shijing.wuqi@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v2] bpf, mprog: Defer RCU synchronization until peer reuse
From: bot+bpf-ci@kernel.org
To: shijing.wuqi@linux.alibaba.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,razor@blackwall.org,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: martin.lau@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,kuba@kernel.org,pabeni@redhat.com,edumazet@kernel.org,davem@davemloft.net,andrew+netdev@lunn.ch,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 15 Nov 2026 15:25:29 +0000 (UTC)

--===============1426439364760055920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, mprog: Defer RCU synchronization until peer reuse

TL;DR:
- Recording an RCU cookie on every commit may add an extra grace period to
  back-to-back detaches (N becomes 2N-1), a possible performance regression
- Nit: example comment in bpf_mprog.h is ambiguous without braces

> diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
> --- a/include/linux/bpf_mprog.h
> +++ b/include/linux/bpf_mprog.h
> @@ -28,11 +28,8 @@
>   *   [...]
>   *   ret = bpf_mprog_attach(entry, &entry_new, [...]);
>   *   if (!ret) {
> - *       if (entry != entry_new) {
> + *       if (entry != entry_new)
>   *           // swap @entry to @entry_new at attach location
> - *           // ensure there are no inflight users of @entry:
> - *           synchronize_rcu();
> - *       }
>   *       bpf_mprog_commit(entry);
>   *   } else {
>   *       // error path, bail out, propagate @ret

This isn't a bug, but with the braces removed, the only body of the if is a
comment line.  Read as C, the next statement becomes the body:

    if (entry != entry_new)
        bpf_mprog_commit(entry);

In the real callers (tcx_prog_attach(), netkit_prog_attach(),
tcx_link_update(), ...) bpf_mprog_commit() is unconditional, and it must
also run when entry == entry_new so that bpf_mprog_revision_new() bumps the
revision.  Could the braces be kept, or a placeholder statement used for
the swap, so the example is unambiguous?

[ ... ]

> @@ -243,6 +251,7 @@ static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
>  {
>  	bpf_mprog_complete_release(entry);
>  	bpf_mprog_revision_new(entry);
> +	entry->parent->rcu_state = start_poll_synchronize_rcu();
>  }

Does recording a new cookie on every commit add a grace period to detach
sequences that previously paid only one?

The detach paths (tcx_prog_detach(), tcx_link_release(),
netkit_prog_detach(), netkit_link_release()) already wait before calling
commit:

    tcx_entry_update(dev, entry_new, ingress);
    tcx_entry_sync();
    tcx_skeys_dec(ingress);
    bpf_mprog_commit(entry);

Once tcx_entry_sync() returns, the old entry has no readers left, but
commit stores a cookie that only completes after another full grace
period.

With two programs on one tcx hook detached back to back, the second detach
goes bpf_mprog_delete() -> bpf_mprog_peer() -> cond_synchronize_rcu(),
which has to run synchronize_rcu(), and then tcx_entry_sync() waits again.
That is two grace periods where there used to be one, so N back-to-back
detaches go from N to 2N-1.

A similar thing happens for replace followed by detach.  tcx_link_update(),
netkit_link_update() and BPF_F_REPLACE prog attach do not swap entries
(WARN_ON_ONCE(entry != entry_new)), so the peer is unchanged, yet commit
still overwrites rcu_state with a fresh cookie.  A detach shortly after
then pays cond_synchronize_rcu() plus tcx_entry_sync().

The commit message says "peer reuse can add a conditional wait before a
detach", but in these cases the extra wait does not protect anything.
mini_qdisc_pair_swap(), which this patch copies, only records state for the
miniq that was actually swapped out.  Should the cookie be recorded only
when a swap happened without a following synchronize_rcu(), or should the
detach paths store get_completed_synchronize_rcu() after their sync?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43727865402
--===============1426439364760055920==--
