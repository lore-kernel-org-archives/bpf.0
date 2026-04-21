Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C535A938
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804149; cv=none; b=eYSq3eOLU6iJ4eVaxFCFQzYYu8oUQoFL4Hiiqi2HqPTtsZGrls7/4wT2IuzIsVqEDJozoun4HmlOOSNPwoYpv4KK7MYZZAPvpNe9Throji0SI8Ucps1qx09C2yT6JxPVHEfxaYHCOLtzYlyldAn67vRZndBawzyXum19+Q5Paow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804149; c=relaxed/simple;
	bh=vybiZxJk+oP5nbD6ltmZ6hboDgfCcd0bXMw8ZgSJgDA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CKtMix0IScQ3gKeYWwR+hjHgN/L/evMIRi/4u2IO6SF/xfCrIR6ar14MNsTjA9Irx9vcGmcuj2ST200vbvS+1GWH2ryIPO9F1MYWt6P/Zct/dEUIHW3yeRXaUD/AoXqF9x4DQNFU5h+t3/LlDbryrYSoURlsbPcsqnFjbWsC4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlqpwR5w; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlqpwR5w"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbff06e4a6so4602417a34.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776804147; x=1777408947; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBD1rQlkthjpn1RXngqbXhf9VhEXFX1MjL2x8CaLCtM=;
        b=jlqpwR5wBfxy6Cu7Fes9zEVyco2C6YLBdK56EgwNiiyCmfKhyQIip+J61kjPaAtA7Z
         uGewnJrYBRk3mYwoaRc6ofQxtGu075zYpuABWHieqpsZoZJxSWtlRCc7ksbdAurNRI70
         EnOSCj2kqhH6W1zUaYGhacVeW/oNNuW5j4un3kuNp0Kb4bSWI3a+XRM/kd8G1ChY9nYI
         rOD5WhJjsDllZOXw2L18bEe3gO+mEFIM+xw8LFsbBWW+WWXGC7BC0sg00n+dIJlU+gOC
         jyZtBDBhCufA0lSyKHE/G5czu3eti/Kw8asYrxCxmhNAGn8qmHZ2EyjxljU3qOAsolkk
         Uw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776804147; x=1777408947;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBD1rQlkthjpn1RXngqbXhf9VhEXFX1MjL2x8CaLCtM=;
        b=R4YkdOAsKrTiQl1WKx2C9QIQdHVqsb1xAZVxqpGS9pJbQzYj1+XwIORijjCZoi2AvX
         wQKOA+FAFlSs74BNXZYfkjuMv0CUA2lpwgNIrD+woPjrFlQYzoE9PZKD1T1Fz+1OZlon
         6EV8EVXRCcmFFsoB34bH6sM0osU6k5KL7FY2uZ/0+hTlMx3BT18vrZZXsrCG8DJARmf1
         r41wByC/v7XrrFjZiZT/15AlMEwtVKTX2YfCxir6k2eLF6bJIVt+4BunNvSIxJE2bgP2
         uA6qa4hPAhZ5drIu2+UO1JVGy4UOr7osh8Vz/IFMcSDm87RPr8HrLgEvhCy06TONQnyI
         KTQA==
X-Forwarded-Encrypted: i=1; AFNElJ83BowQnDfPI0YLUsyN7aXThGdiKqvGaBXyvQtPALM49UA2alho3STbVCaAc7CxFpWJEtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezAmAAedf/NIN+Fg7MGP8Xs3cjHg4KJ7qLaqexa20Q3TFSsmA
	nE+INCRFHqkExvphDUoBiJBCUod5d8WllQUJnhgHF31eHSBifjHBjXHS
X-Gm-Gg: AeBDietrD2urXYZ3GrDUu88/V2FDQEHLnAfPfiz1gn0D7w40Iumv/0g94zAXCCRh2w3
	/vkJ2BYY40fc1BcQ50sBKm5GjCLSDv8KRPO3Ccj1g2tlT7+OqcgFgE4L/vUDu+gBUQB10UBKmMn
	xic7cRafkWqW1KfXuC3nmmeqYKMNMldwEuJ5ONmAL8NF2BcQE/mffBKUZpOHNyv49M9sPr2+I8c
	/JLZ8FH2J5M1zV/k4dAnrOBSsstYb/and0/vANSz/vewAyFx+C3ChGKioFcCQo79Vw6UOIva4Ed
	GcWZRqtD84jBiy2p29as7LYfIODTrX9T8jYJOTdV4+JONTnX9nz0+59F9gH91rV+X6t+5c4yO+e
	YypUURQ/PC56OpLamlm7oKDw6ieUJUgZmehZCXH9NMm3c++vCLOtHWEUy+1jYy3MW/x8NJwgXEB
	nCkSwQz9Fyv9ZJSpEHioSfVzovW3ENysQZ8tnJrT01QD0ecsKN92DLZV3tZt7ECd1IU/UIu4/hQ
	kUyRI52tLILBbtFje5f0C8cZkSodqXKyFaTSg==
X-Received: by 2002:a05:6830:4427:b0:7d9:b338:a695 with SMTP id 46e09a7af769-7dc94fca726mr11823474a34.5.1776804146968;
        Tue, 21 Apr 2026 13:42:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm3836108a34.24.2026.04.21.13.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 13:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 13:42:25 -0700
Message-Id: <DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v11 2/6] bpf: Add
 bpf_prog_run_array_sleepable()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <peterz@infradead.org>, <rostedt@goodmis.org>
X-Mailer: aerc
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>
In-Reply-To: <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>

On Tue Apr 21, 2026 at 10:14 AM PDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_prog_run_array_sleepable() for running BPF program arrays
> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
> includes per-program recursion checking for private stack safety
> and hardcodes is_uprobe to false.
>
> Skip dummy_bpf_prog at the top of the loop. When
> bpf_prog_array_delete_safe() replaces a detached program with
> dummy_bpf_prog on allocation failure, the dummy is statically
> allocated and has NULL active, stats, and aux fields. Identify
> it by prog->len =3D=3D 0, since every real program has at least one
> instruction.
>
> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3cb6b9e70080..b6e96c939846 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3079,6 +3079,61 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *p=
tr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip);
> =20
> +static __always_inline u32
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> +			     const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +	const struct bpf_prog_array_item *item;
> +	struct bpf_prog *prog;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;
> +	u32 ret =3D 1;
> +
> +	might_fault();
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");

The only caller of this function is in the next patch trace_call_bpf_faulta=
ble()
that does=20
+	might_fault();
+	guard(rcu_tasks_trace)();

imo above two lines are redunant.
We can defensive programming when another caller appears.

> +
> +	if (unlikely(!array))
> +		return ret;
> +
> +	migrate_disable();
> +
> +	run_ctx.is_uprobe =3D false;
> +
> +	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> +	item =3D &array->items[0];
> +	while ((prog =3D READ_ONCE(item->prog))) {
> +		/* Skip dummy_bpf_prog placeholder (len =3D=3D 0) */
> +		if (unlikely(!prog->len)) {
> +			item++;
> +			continue;
> +		}
> +
> +		if (!prog->sleepable)
> +			rcu_read_lock();
> +
> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);
> +			if (!prog->sleepable)
> +				rcu_read_unlock();

Why grab rcu_read_lock() and undo it?
imo it would be cleaner and faster to do=20
bpf_prog_get_recursion_context() here ...

> +			item++;
> +			continue;
> +		}
> +
> +		run_ctx.bpf_cookie =3D item->bpf_cookie;
> +		ret &=3D run_prog(prog, ctx);

... and then here:
if (!prog->sleepable) {
  guard(rcu)();
  ret &=3D run_prog(prog, ctx);
} else {
  ret &=3D run_prog(prog, ctx);
}

