Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671623;
	b=OlARkLPZkP3NZktKuFTv9wzzjzJGGj1Vd3rcx1zvPoRJq+Bm35KwqrUIS3wwWiR4qCBf
	 6OcgNdaqqyubAMzTSEiKO3HguJG47QZHNvtHKPVnGjHSEoXe4brPK2f9uAS507Q/GpK0b
	 rP2o9i6Hnhx1XRoZDRrp++KHsPy+shU14M1mLhTV9sCP+iuwHB+lgO0pJcFTV8KQhKETw
	 WOYYc055Y9p+nfh1kaNv7QkpKF7tn26fIDIUIpqFgJ7mFmGkVc0+5OSecKljZSuikmUZG
	 6WCS4E7YN6RcCqTiWgdKCuPATkGoqWeucddKFaTqjK60BHJISXrviLbHtsOfl2vWORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mC/fwoEV1c+9TiOg3u4cfPhuGpDGzfZ18g8zO+WtbZE=;
	b=zExXWKgcd4vMTmoYzStQz/qCVckQjROzK7b2lmMRQ0awDI5fdkrmMGT7SGsZ4Ycz0WnL
	 i/iYB7d37pSYGb+OGNSNbrt64arL7DKDPK5bcrQuxOhm7m4+MlocysNptNBF+NMUl9x8w
	 fG14Xh7ewTgNhhsMDDQ8Wivo17ml70HLTurKr76NrfwiyIIWExnLXp2QBH2/XYmOq06AX
	 7QmLwcVKAndMzqNWyxNfDLohfhKV6Qn+rVe3yeuyHllH+ejvM551cXwJDm/0WzEROuiBM
	 N73WGU8RyusxgMn2dWZSiqwefmb6pMrInDT7h0tELyTC0m2L88PzO0mdV0De646KrIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldf1FwqI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905B606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldf1FwqI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F211F000C0;
	Thu, 26 Nov 2026 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795671623;
	bh=mC/fwoEV1c+9TiOg3u4cfPhuGpDGzfZ18g8zO+WtbZE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ldf1FwqI4uSH3ewzw6O/Mr+JdNDdlfLXtQ06EqE413Dk8yAR/t14RjmSkR/Nu+xdW
	 ecO1H80L0j5tj4gs63KlKK1ZSa5Ca9nYN04o2HSsb3s4++uPHCJcMOY9PxurYTZslV
	 K4krSqoIwMtaA3e1k8L+p5Qvhp0wZjpJZ4XlKKxQVK3nwqPTaF/wIr06p9yQ1nWcmm
	 fLaH7qmMQCHUrcHVS9Ps4h9TwFWxb0c+biIyUozoSN5q3Xxnog14OItEuWN/5VkV30
	 ZxTZMcnf8KzQetIxaMIPcrOzrOaa5iJVSirukcjJNBKGzVkoOzJpM5GTxU7D/qoUhX
	 JEVIEnAemRQxw==
Message-ID: <sashiko-outbox-234800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Reject kernel threads in
 bpf_task_work_schedule()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261126053016.1145482-1-rhkrqnwk98@gmail.com>
References: <20261126053016.1145482-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:40:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: irq_work data race in bpf_task_work_cancel_and_free()
  [1]
--

commit 582f8b25ac8ecb8f5cc73a481c3b1dcd182a967f
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf: Reject kernel threads in bpf_task_work_schedule()

This commit rejects kernel threads (PF_KTHREAD) with -EPERM in
bpf_task_work_schedule() so that TIF_NOTIFY_SIGNAL is not left set on
threads that never return to user space.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1b95fe795b4d9..784674c5fddf9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4804,6 +4804,9 @@ static int bpf_task_work_schedule(struct task_struc=
t *task, struct bpf_task_work
> =20
>  	BTF_TYPE_EMIT(struct bpf_task_work);
> =20
> +	if (task->flags & PF_KTHREAD)
> +		return -EPERM;
> +
>  	prog =3D bpf_prog_inc_not_zero(aux->prog);
>  	if (IS_ERR(prog))
>  		return -EBADF;

[Severity: Critical]
This problem wasn't introduced by this patch [1], but can
bpf_task_work_cancel_and_free() race with irq_work_single() and corrupt
ctx->irq_work?

When bpf_task_work_irq() finishes task_work_add(), it switches ctx->state
from BPF_TW_SCHEDULING to BPF_TW_SCHEDULED before returning to
irq_work_single().  If map deletion calls bpf_task_work_cancel_and_free()
right after that cmpxchg(), it sees BPF_TW_SCHEDULED and calls
init_irq_work() and irq_work_queue() on ctx->irq_work while
irq_work_single() is still clearing IRQ_WORK_BUSY in work->node.a_flags:

CPU0                              CPU1
irq_work_single()
  bpf_task_work_irq()
    cmpxchg(&ctx->state,
            BPF_TW_SCHEDULING,
            BPF_TW_SCHEDULED)
                                  bpf_task_work_cancel_and_free()
                                    state =3D xchg(&ctx->state, BPF_TW_FREE=
D)
                                    if (state =3D=3D BPF_TW_SCHEDULED)
                                      init_irq_work(&ctx->irq_work, ...)
                                      irq_work_queue(&ctx->irq_work)
  atomic_cmpxchg(&work->node.a_flags, ...)  <-- data race / flag corruption

kernel/bpf/helpers.c:bpf_task_work_cancel_and_free() {
	...
	state =3D xchg(&ctx->state, BPF_TW_FREED);
	if (state =3D=3D BPF_TW_SCHEDULED) {
		/* run in irq_work to avoid locks in NMI */
		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
		irq_work_queue(&ctx->irq_work);
		return;
	}
	...
}

Because init_irq_work() overwrites ctx->irq_work non-atomically and
bpf_task_work_cancel_and_free() can run in NMI context where
irq_work_sync() cannot be used, this corrupts the irq_work flags and can
cause lost cancellation or warnings and panics in the irq_work subsystem.

[1] https://sashiko.dev/#/bug/linux-a7b739e8-61a5-48f3-9ad1-75d3c31446fa

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126053016.1145=
482-1-rhkrqnwk98@gmail.com?part=3D1
