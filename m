Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579687;
	b=EhJSsELmQdUSWn4XCZPDFCNE0UwsjGSdVNhep270D2iiEmoqLhy7Nuh5rccd/r3w5BpH
	 BlXgYgY8QLPyjUgWpNhTloLap1vbBFKaxin7BsdNeesqnYi1Q9cBEmQIWeEV+CPRRUkvc
	 5a8pUBIdXwWDSrdHe+rdXhcEsBIi7HP4DTDsrnb05JMNW25NOiBVV+7Q24WQQrnU1XwSn
	 m42AuAY2lwkA5W8v9hkMWAL4Qr+Ohv30J962Qwiv9SljlEsMIcwissPQATdI5We20C0pn
	 Wgp+HC1GVmSNugasJWRMl9CNccx4ruV9T+rSpqZBZXcLyHu1aaz8aIvWVaqJsIrrbOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579687;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=VSoN/6FWmXs2wegalsxskBd39dveSW4FGvwKyb22jXQ=;
	b=30I2eKiCea60yTEBgKuDekg2yXmuL48xIGJyDMEND9Xjsp8/hPpVmBbiADsAPGo5VJDo
	 yCOAHfeK05ik/S+Fl/p3wYnVY4B3xy7VmuhixKiVsoqlesTiX5zuSLVx7dSvcAvMNrUNp
	 Jj3l5QVuf7C/q8aMpcosK6wsDkHRCSTXF7DxPOH3fjVcVRAlymeHLW+AD+HaEdKJQwXEc
	 ePpdMuTIXwAH7VQFeV1VhH3v8dlLiiDGf7F1ffScjgDH/VqoiRb/EjStvIzaxYYAcV5wH
	 RnwOeNKKj76W+VmjDcCXcN/SMLdh5zFS0cs7t7welUzvJNlhJZASfBu+vmmfO9nuHLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLCKBbGF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D7606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLCKBbGF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF501F000C0;
	Wed, 25 Nov 2026 04:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579686;
	bh=VSoN/6FWmXs2wegalsxskBd39dveSW4FGvwKyb22jXQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OLCKBbGF8/bprLaI3+FBbsXsatLq0TT/E6qj8k0nSnq3qxaYUcphweQkyypNiuZYZ
	 4sYmHJaVjeUkGRX+0S4JRiJt8w1qJtyGZhKRmJmHGkRlorEvEyyIdaceJyhRKI/c3F
	 68tZs+yU7BkYePnSaGUG7+h+pxezu/0XtnwnepZIggaOV22sho2nZQYUXrcasCMDIx
	 9MKEw6LnqMz5LcjLbJobJb5/55Pvc5XzWsckxA6b0tevCFrBhaKQhb7eo614PlTa0I
	 UBj5Vf1kFeYbGKNbD4QcnfwYKJ/H2iCvu0b+7uIz7XhCL2sRNNNf7oFrBubQKalUL9
	 RHn7C+tYeGdoA==
Content-Type: multipart/mixed; boundary="===============1085203253568791609=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5885837a30c297a0dcc866c86ab011b9d5d1efcbfce1e87f521aecaf158f7dab@mail.kernel.org>
In-Reply-To: <20261125032938.670542-20-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-20-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 19/47] bpf: Take bpf_lock with interrupts disabled
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:08:04 +0000 (UTC)

--===============1085203253568791609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Take bpf_lock with interrupts disabled

TL;DR: Not a regression from this patch: on PREEMPT_RT, bpf_ksym_del() may
still take a sleeping bpf_lock with interrupts disabled, via
bpf_local_irq_save(). The fix works only on non-RT kernels.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -666,9 +665,8 @@ static void __bpf_ksym_del(struct bpf_ksym *ksym)
>
>  void bpf_ksym_del(struct bpf_ksym *ksym)
>  {
> -	spin_lock_bh(&bpf_lock);
> +	guard(spinlock_irqsave)(&bpf_lock);
>  	__bpf_ksym_del(ksym);
> -	spin_unlock_bh(&bpf_lock);
>  }

This isn't a bug introduced here, but on PREEMPT_RT can this still take a
sleeping lock with interrupts disabled?

bpf_lock is a spinlock_t, so on RT guard(spinlock_irqsave) becomes
rt_spin_lock() and disables nothing.  The path from the commit message is:

bpf_local_irq_save()
  local_irq_save()
bpf_setsockopt(TCP_CONGESTION)
  do_tcp_setsockopt()
    tcp_set_congestion_control()
      tcp_reinit_congestion_control()
        tcp_cleanup_congestion_control()
          bpf_module_put()
            bpf_struct_ops_put()
              bpf_map_put()
                map->ops->map_free_pre_rcu()
                  bpf_struct_ops_map_del_ksyms()
                    bpf_image_ksym_del()
                      bpf_ksym_del()

If another CPU holds bpf_lock, for example in bpf_prog_load() ->
bpf_prog_kallsyms_add() -> bpf_ksym_add(), rtlock_slowlock_locked() calls
schedule_rtlock() with interrupts disabled.

The commit message acknowledges this ("PREEMPT_RT is as before, both locks
sleep there"), and bpf_map_free_id() earlier in bpf_map_put() takes
map_idr_lock, also a spinlock_t, in the same way, so this is not worse than
before.  The change fixes the path on non-RT kernels only.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============1085203253568791609==--
