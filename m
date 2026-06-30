Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F6226D05
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861450; cv=none; b=iHvCN0nYAEHySOa1y9FwJNbnJwrhtHg4ta+1sgtZ65v9uacntT8G4fo/XMIFEy/QOmDoUGWTNrrJkwBtKLv3SA2x4ULUdc03Bz9h2eMVaEiZL1itk1jzbMvjvaJbBk+0ylGqCfEm8MrwOuEHoLbizVZd7RkzfNT8VxTMNfqkXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861450; c=relaxed/simple;
	bh=grQNBSOOrrvp6LYiktIUzOeC/U4NKJ8O9LNU8RX4CE8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UzTI32MUrWwNKrcv65QndWUgkGhU92JKAcyG+gt0Nd9HUK8t5QsP7FiFWNfnjZ8DeBw36kiv92OaXolFesQupozcc2jwoc339XLyDoHuaCIk/6LkVzD2HBlrS+ZmigL56HZRQ+2fDNFr9UyuQWGy24NzOkO6EkucIc2G2DNy5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMJihUGB; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMJihUGB"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69eb8b6bea8so15379eaf.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782861448; x=1783466248; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLQmE8n/uF1NhvarCMC8vD9mc3DyBSsAZJ3F/E0uH6s=;
        b=NMJihUGBfuUDmhUbQoVZJ8XZvq5QsmYn1Ih8oke2z6zWD4jE913rumuzduiREdnIGf
         aDEfNG9vienExNx5Mew+KGHwJAdMNhL+0I5gmKbb/eV2LwfYuZyFZH6opqeNWQLmBP9h
         lzmaTVECNWivtPu9fAjZCrsEZtslqoKtCQ/vL/mlljwKCMUiJbBoSMW+wVtpB4MaAhcM
         BltjQ27zCeOK+XUaXirknRxXN3QS+bLbyT8Bd/x27QQwbeZdsOYVGakm272FiTrfmGNE
         PBtvRd0UxKVOWOaIiTbVkLmmm9w+l8Sr2Sew+ekim21X77JQeoWU3/do58+lMpgwGIZJ
         YEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782861448; x=1783466248;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLQmE8n/uF1NhvarCMC8vD9mc3DyBSsAZJ3F/E0uH6s=;
        b=oY7sB04aR3sX1IDNyWovfLJNIl8ET7QWlmfnQTvfx8u3wDuj39LpHCpaqkGAiXaIsq
         aPQF+hrC5DRZyEPkLJHeDLp7zjgv9oQMFelOoyMeO1dCcnSD9VCw0F+8PxwdmeaXq4zG
         BJrUwVetEfxqKwBc19rEpu5+BS4tA8hjENzjcY5NjpVO6e73gvyiFPCE199wbPRpVr5I
         xKiZUdEU7+uiIKdC3j8gXM0JRHGaY863PoWDeY2TV4LaxjFUp8fCZzQCThDvJS+OxcKs
         1p6zUke9PN3xcpsPqlj5EzQyaUu02UXDAkho/Y93vyKx13ZT2qcMo5t0+jhKrFiSL66E
         iyxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bS13ViR0qgseMahcjnxXtxNS6VmDbWNQLvaVG6xpuFh07ykRLuiQugE7UsRcrGWYi5SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdObs+KeY7dWjecKYgJ8vr1Lqwyx4E3xbH1KPcIVEwkqUHd+P
	17aBnNN+WYNVRm2It0N4ekNMdbxegO40jAb/LWSWDFVePz02a4c/4ksq
X-Gm-Gg: AfdE7clw8ENq2k8OdRQ3lfWDncN4xRoFnOJg2mcOtJor+X8/q6DGaYCqyS9c0Bpbsdd
	zLL4SK6ml8F6r7BB7OtSPaO4lw7T9tGnBGQfWC3awdZup1g2bAv1FkCb/jS3ds8IBZajB3NI5Yr
	Qc5qfI2l4jQPcZv2CKBRdfGbp8n39gLxJ6h2skKMVxc1S4F6OPOLu2mjNzHcbUQ5lS9dG20YA56
	scprHI/+MKAij/Cqsg80FDAJYX+ZSaXBNcoWGpdlbCyI4GN/9Olnsr4z3MrJXHjVE3wmA5XAtxf
	EkafMbYeBY/fxFpBP7Da6WpJUGp5LYKbIft6uEHitdzyWkLgxSd1vTJbUnMM6azIgrCTpBfd8I0
	8PeBu1kpsYYbgaR7Wk59o9kC6aYwhjgSG74Ozj7UpG7mepUkEMBRWZ5HyHoZxONnVnEDxg+0uWI
	BGZrps5S/Cd7VY5n080AIYnGFvP3YOxn7NVR0mNYITwjhvJUuQHwuLA3K+3QYwpaa0lwhGQRnMT
	M17WS1ufkQ4WUHPbw==
X-Received: by 2002:a05:6820:2013:b0:6a1:7cce:a3a6 with SMTP id 006d021491bc7-6a196c9725dmr1602986eaf.54.1782861447750;
        Tue, 30 Jun 2026 16:17:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c6a58cb27sm224824fac.17.2026.06.30.16.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 16:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:17:26 -0700
Message-Id: <DJMRMXI4W803.1JAJC33ATPG1M@gmail.com>
Cc: "Paul Moore" <paul@paul-moore.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: move security_bpf_prog_free() out of RCU
 callback
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
X-Mailer: aerc
References: <20260626093711.2969648-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260626093711.2969648-1-rhkrqnwk98@gmail.com>

On Fri Jun 26, 2026 at 2:37 AM PDT, Sechang Lim wrote:
> __bpf_prog_put_rcu() is the call_rcu() callback for non-sleepable program=
s.
> security_bpf_prog_free() called from there fires bpf_prog_free in softirq=
;
> if a sleepable LSM prog is attached to that hook, might_fault() BUGs:
>
>   BUG: sleeping function called from invalid context
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5038
>   preempt_count: 101, expected: 0
>   Call Trace:
>    <IRQ>
>    __bpf_prog_enter_sleepable+0x1cd/0x320 kernel/bpf/trampoline.c:1255
>    bpf_trampoline_6442549705+0x53/0xd7
>    security_bpf_prog_free+0xde/0x130 security/security.c:5465
>    __bpf_prog_put_rcu+0xab/0xd0 kernel/bpf/syscall.c:2365
>    rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>    handle_softirqs+0x236/0x800 kernel/softirq.c:622
>    </IRQ>
>
> The call_rcu/call_rcu_tasks_trace split reflects the freed program's
> sleepability, not that of any attached observer.
>
> Move security_bpf_prog_free() to __bpf_prog_put_noref() before the RCU
> deferral.
>
> Fixes: 1b67772e4e3f ("bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM =
hooks")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  kernel/bpf/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 630d530782fe..f14c3f0f8827 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2362,7 +2362,6 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu=
)
>  	kvfree(aux->func_info);
>  	kfree(aux->func_info_aux);
>  	free_uid(aux->user);
> -	security_bpf_prog_free(aux->prog);
>  	bpf_prog_free(aux->prog);
>  }
> =20
> @@ -2378,6 +2377,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *p=
rog, bool deferred)
>  	if (prog->aux->attach_btf)
>  		btf_put(prog->aux->attach_btf);
> =20
> +	security_bpf_prog_free(prog);

I don't think you can just move it like that, since LSM side
may rely on RCU GP.
I think removing security_bpf_prog_free from sleepable is cleaner.

pw-bot: cr

