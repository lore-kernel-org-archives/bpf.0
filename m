Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323553921CC
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183681; cv=none; b=kGPakICFHE2dSYq611EpD1Yc78qshmEvseq6os7tW7DhCaLMjJC/LBxqzZ/k/WI6L8tf5xRivfsQKHutV0ROZkI34JwZvcwjCnCwB+llIVoUPyEM9XecYNhtIrRw+hlsIzL8EJBEhPKwI3V/R077hLezvTeYhaRn2utxngr+QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183681; c=relaxed/simple;
	bh=evOAXfBovvBe6YEwcJhGdatosPUGmIApLgiwGdgXRZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=I0HnoYMPk2WIeCd1G1IpsoeR+xc1T5bsZRZb4sn4eDCCwCR2FMJYhfJrBIwBctn/p8Zt+V5322ITLV1hNUm0vtRnDPqHHpNUTgLdtzrJRWbK5gWahh1T8M3dmHBhSikOtHfs+ikGOMiiGoMHU51g93uM881iuhyhOt9PmlVJt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbAxp6GY; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbAxp6GY"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f4e729368fso1719808a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789183679; x=1789788479; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ud1ZpqadGMe+QubhUEhtcVCLKFg2sCSQ6NPZYlf26Tg=;
        b=WbAxp6GYqCCXfFThYBrGdLtLLoMXTZMpTlNWKcBiUm/ojmzaQnTyDTmr7hDWQ1tdno
         9no58945yT19pjlKp9GDl76DZvF6LzrI3ezHbLg1qrhPacZA2VJHmrheC1CkQ8xBJh5U
         akA4C43cVuZSeuYRki3HangHKoSyaJwoQlQ8JOIhDz4ePUhk4OgMXh1b5GKWDp5aq3bR
         ym+yxeGoDTHX9RLUGApXQcvhZ1uEmjC7PZAs8q3GGC0H5i5wFlxSfL8ScuZ4i+vk+30H
         pKOcES1JikouMIn7XNGIWwm8PEWzDOks3dUfDdQCmzJEdwx7y9O2GZlmA8sRZIClTW7d
         Pjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789183679; x=1789788479;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ud1ZpqadGMe+QubhUEhtcVCLKFg2sCSQ6NPZYlf26Tg=;
        b=BZe8wepWLFNOfHaJ1WDxn7QA8xCc75g1cJP5KqgQiEr9bfiAlv22W+e8wS+CQ6fiIJ
         ak3JhZ+zZRB9QTxVG3BzQp9ciC7AOHUDeNbWR9A58yOdLlSy1EcLJl/HdGKDm/B9Ub8z
         2VtjN/n/lAWiLxLDX0YKEE/mEJhuGgNbtpRvjR9RE4hBN8pcuWx+mdsMFnjIrPDK85oS
         wVqQtkfRQlRrMwBiiZlHxRZs2I+fz7DA6+Zqgs85vxjgYIPAsra4qZNyE04nkMafxnd1
         2K8CUX577DB8SQgzK7JeHxX8IXusUDhomv2U5G3XQuzHss+qch4a9iiSYCkH37wSWbgP
         DOyA==
X-Forwarded-Encrypted: i=1; AKwUvBzUGPPxt5YpJxmnRWvGmg2Ng/XTIp+HRnbG9c/TghR0Igh93smu6k7uv655vOaBbcBLL4A=@vger.kernel.org
X-Gm-Message-State: AFuF++n9RMXA8DUzwqyxDB2Yr9i6gXfVyRaIXK0g9Hz5Mg2/wDRnGsQE
	6GW330YbKEOYatuYmx2mCko7H+FCHmr9oNYiByKXIttMR/v7flwuUqUO
X-Gm-Gg: AYBFou2dbxtEhM7otImBPndZZgT3Q7NZ5/5SAu0Bn+CaFahYArK+yNwwfkf+HxzOY34
	h6yaSYfMcBUQs95i7UAGCfONnjr3l19yue5vHJ/p+31Omc962g6ZiknjjalzJ6fqkuBn98lWwe7
	cXQn/qdbD247WNMTWVule5a7viVfL+u7MhgSgn+scIIUjFTz77EdC3tY7BytUftZor54+quKCrq
	OcVHIPYNtWOcysPLZRnpWV1lQ2A1DzEaWC+vo0eBdt982dQzbdmbofG8rxPPZXjx7PUTjdC1F4q
	UOmFmZzAKL8XQuttv/9FSCgP5RMtRiyvKUx3GisdvFEJ7V+3Yq2srEsoGnRj/LVVBIfedGeWKcU
	ZGKzpvm0+BiU9aE3B3heBukkCyN3j0ZCi/2r0hq4Zy3zYlbp1lYGXN3eXsHgwAmbC/ZfGwhIURN
	r8oxsJojgQdirHb9tWo6sQll+WI1HgDuALdIqkgW5hCnqf0NukKDGxx8+tdMh5LAjB79/rtKOrW
	jnGYDByeXPJpnc5p0LNpJspc1Dn3My3OMkg4C8+Ow5as18uHSV3Z4eZcfJ+ytetLg==
X-Received: by 2002:a05:6830:2786:b0:7fa:ac4f:785 with SMTP id 46e09a7af769-80400b2042dmr6714669a34.17.1789183678934;
        Fri, 11 Sep 2026 20:27:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:15::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d208f5sm4822052a34.25.2026.09.11.20.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:27:56 -0700
Message-Id: <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross"
 <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
X-Mailer: aerc
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com> <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>

On Fri Sep 11, 2026 at 7:08 AM PDT, Josef Bacik wrote:
> Emit an increment of current->rcu_tramp_nesting once the trampoline's
> frame is set up and a decrement before the final register restore, so
> that a task preempted while running fentry/fexit/fmod_ret/LSM programs
> or the __bpf_tramp_enter()/__bpf_tramp_exit() glue is not treated as
> Tasks-RCU quiescent.  Drop the count around the call to the original
> function: that may run arbitrarily long without sleeping and must not pin
> a Tasks RCU grace period, and the trampoline frame above it is held by
> im->pcref rather than by Tasks RCU (see bpf_tramp_image_put()).  The
> fmod_ret early-exit branch and the ip_after_call -> ip_epilogue poke both
> skip the decrement/increment pair around the original call, so the count
> stays balanced on every path.
>
> The sequence is "mov r11, gs:[current_task]; inc/dec dword [r11 + off]";
> r11 is scratch at every emission point and (u32)&current_task is a valid
> sign-extended %gs-absolute with the current per-CPU layout, the same form
> the JIT already uses for this_cpu_off.  The image is dynamically
> allocated text, so the instructions outside the bracketed region are
> covered by the irq-exit IP check.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 43 +++++++++++++++++++++++++++++++++++++++=
++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2853e87797a7..a375c1b7bd50 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -722,6 +722,31 @@ static void emit_indirect_jump(u8 **pprog, int bpf_r=
eg, u8 *ip)
>  	*pprog =3D prog;
>  }
> =20
> +/*
> + * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().
> + *
> + *   mov r11, QWORD PTR gs:[current_task]
> + *   inc/dec DWORD PTR [r11 + offsetof(struct task_struct, rcu_tramp_nes=
ting)]
> + *
> + * r11 (AUX_REG) is scratch in the trampoline at every point this is emi=
tted.
> + */
> +static void emit_rcu_tasks_tramp_nesting(u8 **pprog, bool enter)
> +{
> +#ifdef CONFIG_TASKS_RCU
> +	u8 *prog =3D *pprog;
> +
> +	/* mov r11, gs:[abs32] */
> +	EMIT2(0x65, 0x4C);
> +	EMIT3(0x8B, 0x1C, 0x25);
> +	EMIT((u32)(unsigned long)&current_task, 4);
> +	/* inc/dec dword ptr [r11 + disp32] */
> +	EMIT3(0x41, 0xFF, enter ? 0x83 : 0x8B);
> +	EMIT(offsetof(struct task_struct, rcu_tramp_nesting), 4);
> +
> +	*pprog =3D prog;
> +#endif

It's not a lot of overhead, but I feel it will be the death by thousand cut=
s.
rcu_read_lock_trace() in bpf_prog_enter_sleepable is doing the same thing..=
.
increamenting a variable inside current.
Can they be combined? Like treat current->trc_reader_nesting > 0 as
 current->rcu_tramp_nesting > 0 ?
Or replace one with the other?
Two current->foo++ operations look redundant.

bpf trampoline is already quite heavy. I'd like to find ways to reduce
its overhead instead of adding more.

