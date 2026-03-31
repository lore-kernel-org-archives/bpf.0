Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30613B58A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915254; cv=pass; b=QYnENXWxhhsIp7JWdqGE7ynQHfD2pa+srmdGb1UY96EnuPbK6KvMI8Xg/bI2HsEfhbqfLpT0uCwEPfXivGOjczczP/N/vMjmUtChgH3y48u5zHHcU0B3IoxbvEyq6CSv8vmylDgGm5l4xR6ZYqmd4yYc60Wg9tnW9+Abrph38i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915254; c=relaxed/simple;
	bh=nHwhVDl9M29m8cguKpbgKWERBO33l7O2315Q/mOZCZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLVZZLW8Li6ZP1urUdjqBtHpmS2tRSGB3shSvgW70bN7smnh0Qirj/OwomQyjyK9LEpRR2IixLHuUgEAU4RuJqN/ttiG6xH+mTTbNPcv+On0qsCnM1DEonnI3Yzkjkf7CRwZoZyJb7GwikTwTtY3IEBMtBAl7OecnDGqFal4TLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBXkruNj; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBXkruNj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so1506759a91.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774915252; cv=none;
        d=google.com; s=arc-20240605;
        b=NROMP0eVGD/TGL8spMR0FkGmyz2FFQAH9umTVItB3gZ21vD56MQFULK6CARfJ3gnHe
         Lmjf8hIy4U5RFnR79QOvBNp79CYwnYCpmrr0scdEOpRPVSsVnkNUAOgC/wuBxX0ZBsSf
         53LDNws49AI2W6QfOisb9y8/GKl+HygGB7/GLTIi8u5VL00D+tJnymfie812LGbGPmlv
         oCYZb5aq9jLQih9+6PJZZ3QzZKmdQLX93+vk5HJaaPnrNf3Lii7LvSzXVsgteMKYIiFV
         CjBdfdgBDGq3CPVGcff63O8nX90oGdlL7QoneXJRjJJ9zLHD9fWqyaV2OEsHr78aGo9o
         dEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cr7j0HsVNbqsPgoaBvukCbj7pTwmikKMYhVC0DnufEs=;
        fh=YXhxD3wyK33+PQ10KTCk2H4vVOOakTCPA9bwY3a/OaM=;
        b=Ub+UwmWm4jroXlya2lwcqOzuy2cQzoVeGLaqgNs81nkHnPhwHxMv/TFO4wrsF3BfoE
         aXNRV2H+LrbhY31xIG3m9A3lbXxFJQYsDbhFsgPL7+ieiNHtSVY5tXb5CXszDDjS3sMt
         8q6XPjPYIb6cg0Mc8qSV9ZtufexbE58HuReMIZkIFm2xEEXicHGoq60yOvbUb+vS5sEv
         QGVBWmGd/SJ+G55Vk4l6p2GnP5nNuZqZj5BvrysPUF04FaEewJmireqaqmLZ9bz0g5J7
         RDoKnObGDuCnFg2XKQX+fqGmtZgiLIo+COr40TbG7SaDb0zcsizBly94unt4DHbnWIfh
         gK2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774915252; x=1775520052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr7j0HsVNbqsPgoaBvukCbj7pTwmikKMYhVC0DnufEs=;
        b=iBXkruNjtGiFMHpbol/pZlkARfZnlJ1K7+ebL6EmUGD7zaCvuH1JKLCPWFm1jKO2S/
         350tmKjvMlA4ztOO9bQ20NJ2pf06EM5u6RgWZjh2fMc+OZHJSH2+WdR+62rtTBpZPPt9
         gqO4PT8A/3nQwyIdUdChAzvOFYKDJ8HpmBSF5WGgnS8kMam5uMbY8ZtmbFMjD6w4E4ra
         8s8V8c8EU0FxqDZUd3q5P47c/kd87Rbv2RQT6+LVRvyJQfwHaL+5FwDQ0D7/S2SuiQlc
         aMBxJB7zn0dwnRayTaDohLj5G84ntkICorbU6fs0B2sRphP8uHSjruolW62g91/ntUkP
         wkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915252; x=1775520052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cr7j0HsVNbqsPgoaBvukCbj7pTwmikKMYhVC0DnufEs=;
        b=ii+nfi1BCeFnP2W+CKpUYrPQcO6go36nccfz8F9Q2ix88saqHAe7KfgqnpVCEZwp+A
         OQlczau+lzlT2LvHVW0g+TwFcJSGGp086cmgOnKEkrbUfLn99ALNBF1D9/CjhBBs4Moj
         MOZLzhr4udhRnWgccRzk+CqIy3bayDcEyxsLwBq6wXRZ1yx57dTG/xG/smfZpAGmIXnp
         82fzP9nkfFHUxfh+ENCawuct/xWC0NjfF4VmXfYCKRPcZ4xx9mFK+eU+9w7+ETQsds7B
         DEzOEPvfIhY1gazs31khW5vK/wr8rXTPZTWnJ6mXOqf3ZFFGejSPElv0MomxtYzmWkKR
         yzhQ==
X-Gm-Message-State: AOJu0YwXYTHPMRGPy7Anout4nDp4xf4yffXgr+TuVlj9JjSbGSFom4lH
	98SeiACj5cpg9WhOSiGru/M5Aws9B+VflKz8tBX5Nakru6TvpQnZ3XKXR5b/qaTCT/omOR6PEgg
	UFNWapbeX0VZ8F/YDkWMgC2Nb/9xyTDPTNg==
X-Gm-Gg: ATEYQzzQeEiFyVrR8CWehWLKkmImModp8RtyFkYPgBn0GF6SHe7wPA+kMcrX95hMRX/
	xnSblqvviwfF9cH0uiKYFRtZOTk8bFcUQconu7IG6mp9yh1eZy+h5mnK0Crimu/OdOUr+Q34gFF
	BnFwXDHfslaCkEPU3sjO7c+EKmW3PW044kDRBtpyNNW0qE0q9IoclVXNo8IKLqBSUeknFESw8T/
	cKivAw5Pdo3uzdrLuayUPlvDQK/HPD6fWxfJFDdiYtwqFMjqphFwFxY+4uzfiS0x5MRV7ndlgEJ
	uJRMhKGIoRbqodWM1XDo3Ao=
X-Received: by 2002:a17:90b:4e85:b0:35b:e566:15a6 with SMTP id
 98e67ed59e1d1-35c300949c4mr14888068a91.28.1774915251924; Mon, 30 Mar 2026
 17:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com> <20260330-kmalloc_special-v2-1-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-1-c90403f92ff0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:00:39 -0700
X-Gm-Features: AQROBzCAbJHnOTGVqRGnvPjs7yDRQU4QEbZNoh13LowdD79PnSCGL7y5U1VC_S8
Message-ID: <CAEf4BzahW744tL+0DvvB_4nhstRsgMui0xEX4+obQ4kYo77YyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Migrate bpf_task_work to kmalloc_nolock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:28=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with
> kmalloc_nolock/kfree_rcu for bpf_task_work_ctx.
>
> Replace guard(rcu_tasks_trace)() with guard(rcu)() in
> bpf_task_work_irq(). The function only accesses ctx struct members
> (not map values), so tasks trace protection is not needed - regular
> RCU is sufficient since ctx is freed via kfree_rcu. The guard in
> bpf_task_work_callback() remains as tasks trace since it accesses map
> values from process context.

I didn't quite get if this change was necessary for correctness or
it's just an optimization?

>
> Sleepable BPF programs hold rcu_read_lock_trace but not
> regular rcu_read_lock. Since kfree_rcu
> waits for a regular RCU grace period, the ctx memory can be freed
> while a sleepable program is still running. Add scoped_guard(rcu)
> around the pointer read and refcount tryget in
> bpf_task_work_acquire_ctx to close this race window.
>
> Since kfree_rcu uses call_rcu internally which is not safe from
> NMI context, defer destruction via irq_work when irqs are disabled.
>
> For the lost-cmpxchg path the ctx was never published, so
> kfree_nolock is safe.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 56 ++++++++++++++++++++++++++++++++++------------=
------
>  1 file changed, 37 insertions(+), 19 deletions(-)
>

[...]
