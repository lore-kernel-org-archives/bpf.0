Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F940801D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243864; cv=none; b=aX8Sxi4kM24kozgDhM91W1RGIYZ6FTgjmqYzb88BmMCm75kuNJ6YDlDuuSIfO3jTjXS2hqPA5q47H2scd2hCBGYy7PdZ1RACAvRpSbCFZPjp028oLr34kiOyy1nq53/vbQbP4gr2KEXneu6XdHnFQ7PySqiGd71nzu2+ZjT3Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243864; c=relaxed/simple;
	bh=2rz/17vZuOHmiKXaBqpqzYOGMtn+Xb2Zo1vU+QoMqnw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WfmHY6U3GBiIqM+3PNrtVyUcJjuqrCUNdiAZzqFwu2c1l4UisYI4yfHTIaG61UkoNEGOl27NiYYtm3wwAIgWaw1myhDp5gScglxv2draen41v6RyqpdogrgTTJCgBg3GWeeF4z3T2wl4Jo7prQ6YWbxImjqcI8boHFFFfa2cHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXcm9m8o; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXcm9m8o"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so3621925e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243850; x=1790848650; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vGnipRVR7Y0TJOKbZVhzmzpn/FDe89AQsrMT71eL7Hs=;
        b=DXcm9m8oua++Dw2spMeL3VGIYx2vKdhajhjgtMK9xmIQ4RqZ8sCWLXANpZoYq4742K
         z2JlxovNYTcA7iPlOG8rUO4FAV3Vg+1sVBpw7fBGEJKwhuRKeVXUuN2Gwtx5Wa6vTAaS
         BnRMdiD/vAWD3r7fwuIGmryaoBKl0kyvN3n3s3ujbliMXpt2SsQ7aWLda0zx3rAP0u6M
         lhPDePzlcE9Z+usXE4P/mQVgtdfI8wLlEjgE/zfWVyGVCryPMjQ/GTRrzFbgmsJmAHhU
         lmQSfDYI+UqMU4+CvFj8tSVXI4EAhi0QGd3ubk5Hbv1kkDRNPYhhFfeiEi6DXEUKJYVD
         rOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243850; x=1790848650;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGnipRVR7Y0TJOKbZVhzmzpn/FDe89AQsrMT71eL7Hs=;
        b=m6M8daFW2RUhlvK59Zf+TNIKOyz70SFWUCJuvfcZQsCbtsZ53LE8OwFVem5x15uobQ
         q8lND8EWQc1GiQynJTcjLvCx4qaanbXEjcIaVZo4o7fG9b+kzpga3UoozVPWkIy517mK
         OSaczI8FmMoYXN8OC8XmCVq422dH/v3jebdk5xvX/5rtfLwbb9b/aZW5HHZwRiXOC6vf
         vYECPB3GWVgzqmrwVMnRJyhcNc/hjOLHmgb4KmMZmrum12mQC0AMpVe+BUjN32AHERni
         kLOoqjZVmXNT58iBQMmAsZ7dbc1zhSdCIOAgoBLsTbUWalk+vXiihWq4AUJJBJdGxR+I
         cpVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNE/Ce+2D2Um3xuRstOBUZRcACgm0hTOedM8rmDGQ7UzoG6i1kRrHztj/kV2UBLBcJyS0=@vger.kernel.org
X-Gm-Message-State: AFuF++nKSygo4RKjG6hHXAXXKi2IEuQGXUkEjTbQwEwCPMF77Hnx15ZX
	Wvm6/4dSoGIQuEhxR2IT/NzEM3VbJPQ71/uc+xCk5TxnEulLjBDi5ISb
X-Gm-Gg: AYBFou1zWDFEGc6mW+/bvwyWKpYPJDH+Cu8zPQMrhZSHkfL+35VQy6heWCc1xSdk+ay
	pzldHDh2Kq48N0R9aXmLyTxnSNIdunwMLmXV7lZBnBjNXS/SZAynKZNA7XgqNr5o6NmeInF5xii
	EtkirKbpTQg8ojCl4F+XlbflF8QHDt4lbJnfFAVB/RP1/g+j2vstqdgZWrb04MxBHhGsZTCXX+x
	k0WziWu6muri3JRkRFF9QFnnOkwEZck7zLTQSf8SlOfhO17yGe5r4U5PDa8EXVofeQcA2iTCS4O
	CihOpRu3siYTil5kzr98VOubdegs0nChYTTfluKYJLbHVGInPHtrE0eiFJuPwk5NGlgENaoz0uo
	oXABdRwVECHfaKMyqBWl1h8Vh0YRwhrBzcD6XGD9my68H3fKRL8RBb4ZtUvJvs5HNBqSPkkaSeI
	XQmEFREYeOX/LYPWLLowDQAqM7JYmbLyWfcGOMaokEmx4czMxi3hcELAmw83/V76V4iSb5h9ZUK
	bRjo1NeJwhhHx8vHlB832//QEkyiyNf83uaKyXDLylaJ24O5sUnhh5Cx1PcBFyVcgCtZij0eSLV
	9irh/OeL7NcZNfTtumO22NZN86pGXPzqKVQ1iQ==
X-Received: by 2002:a05:600c:6098:b0:49e:7cc2:e6c2 with SMTP id 5b1f17b1804b1-49fe66fd482mr37541735e9.27.1790243849642;
        Thu, 24 Sep 2026 02:57:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bb9891sm49258605e9.6.2026.09.24.02.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:57:28 +0200
Message-Id: <DLNGHABXA6V3.2MT1ETDTEP36D@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 16/18] bpf, x86: Allow programs 2 KiB of
 stack
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-17-memxor@gmail.com>
 <61fbaeed4b3968122da9da2b7ac83e193a0058de88466d6f79fe0a446853d500@mail.kernel.org>
In-Reply-To: <61fbaeed4b3968122da9da2b7ac83e193a0058de88466d6f79fe0a446853d500@mail.kernel.org>

On Thu Sep 24, 2026 at 11:13 AM CEST, bot+bpf-ci wrote:
>> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf=
_design_QA.rst
>> index eb19c945f4d5..be5fc4ac00d6 100644
>> --- a/Documentation/bpf/bpf_design_QA.rst
>> +++ b/Documentation/bpf/bpf_design_QA.rst
>
> [ ... ]
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 9fbef7504e51..e2e531dd1e0b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -4520,6 +4520,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>>  	return true;
>>  }
>>
>> +/*
>> + * Frame sizes are 32-bit immediates in the prologue, epilogue and tail=
 call
>> + * sequences, a tail call pops the caller's frame and lands in the targ=
et's
>> + * prologue before the target allocates its own, and private stacks are
>> + * allocated from the program's own depth, so MAX_BPF_STACK_JIT frames =
need
>> + * nothing special.
>> + */
>> +bool bpf_jit_supports_large_stack(void)
>> +{
>> +	return true;
>> +}
>> +
>
> Can a sched_cls or lwt_xmit program overflow the kernel stack through
> bpf_clone_redirect() recursion?
>
> A TC egress program on device X that calls bpf_clone_redirect(skb,
> X_ifindex, 0) redirects the packet back to itself. The redirect happens
> while the calling program's frame is on the stack:
>
>   bpf_clone_redirect()
>     __bpf_redirect()
>       __bpf_redirect_common()
>         __bpf_tx_skb()
>           dev_queue_xmit()
>             __dev_queue_xmit()
>               sch_handle_egress()
>                 tcx_run()
>                   bpf_prog_run() -> (same or another tc egress program)
>
> The guard in __bpf_tx_skb() (net/core/filter.c) only fails when the
> counter exceeds XMIT_RECURSION_LIMIT (8):
>
>   if (dev_xmit_recursion()) {
>       net_crit_ratelimited("bpf: recursion limit reached on datapath, bug=
gy bpf program?\n");
>       kfree_skb(skb);
>       return -ENETDOWN;
>   }
>
> So dev_xmit_recursion() allows values 0 through 8 before it fails, which
> means the program runs at nesting levels 0 through 9. That puts ten of
> its frames on the stack at once.
>
> sched_cls programs never get a private stack:
>
>   kernel/bpf/verifier.c:bpf_enable_priv_stack() returns NO_PRIV_STACK
>   for them
>
> so their frames live on the task or IRQ stack. On x86-64 without KASAN
> that stack is 16 KiB (THREAD_SIZE_ORDER =3D IRQ_STACK_ORDER =3D 2).
>
> With this patch, a single 2048-byte frame is accepted. The BPF frames
> alone then take 10 x 2048 =3D 20 KiB, before any kernel frames in each
> round. That exceeds 16 KiB, so the stack overflows.
>
> Before this patch the same program was capped at 10 x 512 =3D 5 KiB of BP=
F
> frames, which fit. The recursion limit was meant to stop a buggy program
> from crashing the kernel.
>
> The commit message says nested programs "are not accounted against each
> other before or after this change; each level of nesting may now add up
> to 1.5 KiB more." It does not bound how many levels there can be. Here
> the kernel allows up to 10, which adds about 15 KiB compared to before.
>
> The same construction works through lwt_xmit programs, which also get
> bpf_clone_redirect(). Triggering the overflow needs CAP_BPF and
> CAP_NET_ADMIN to attach.
>
>

 Right, thanks; for v3 a program that calls bpf_clone_redirect() keeps the
 512-byte budget, since it can run ten frames deep through the datapath's
 recursion limit, and tests cover both bpf_clone_redirect() and bpf_redirec=
t().

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

