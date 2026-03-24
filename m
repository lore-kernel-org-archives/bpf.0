Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9B2D3EC7
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381135; cv=pass; b=dVdOB9hAXshF8ZwXNW3dOqIue4x1Sa9FJRRp0JGXvBi1OAOPgwOFR1RJEQLQOtmxlEw3KVyRppRxtuqYDMFsyFIoy1zRCxY3cD6cYuAYtdmKOSgEpycgILS3cE4H4T32nJ9ar6rUZXa4vzYj8tU7QxhzaQgLrFJWP6F8t32K7PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381135; c=relaxed/simple;
	bh=yI3xCTn6GHth7mFYEZb0fW+liPFwZsS6/4VS9PzQLAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUiWKH/cCMF/OB7LKQRabsc+UHDDCYVQti94MTkzR3AQ5uI83oQ5Wo1vVAtYaSCkHXoQ0peuOtVpYNGUNQqvwZWKqQ/95cTVdfkZFQibg1LjOlfpQmMPKakXQoMNCAZZ0ZwYp6+lOV30/Ue2InDjQeQqB1kYs+S5IEbDxS0VEXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVl7tP6h; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVl7tP6h"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso3113045f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774381131; cv=none;
        d=google.com; s=arc-20240605;
        b=cZpLCAM775oAR5BbzCT2w711CtCILZzUV69KqsgKkvS59/qrbCZu780REfxwpQ2r1w
         k/cC6ddOe/bpr8vMg5Ky4ocGibczGDhYV+F+N8YrUu7UpggGG3nyhPUlBGB8MRD/5XmU
         TWA3iwiVFeeaDBGp5p72c9AIFMLwRwgYw5ffpPTQLFzE4ZI1nd7SzN8McQHEECxdcZcL
         0ARmH+QAO9yf2ssAU7gcX7aJrG1theQ9TlVZFzqCg+i4X+ahqn0ju4hN+n58jrLTKSGM
         53732v32ETP1Q+re7sNQXjBKO1iqJbpDyh7P3yIu1oZ+HM99lZgoC6In/X1TAfxX5IqU
         yweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RyulBWdtbse6vY2m0hI5hgut+qotDEBTgU/TQet2TLQ=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=W+AjJAoJo2plIsEEQt5PkSdEKpUVhdwOOk1uWm8WqftstPP98omC9VvoiidQbJF7IS
         Us/yu3ZvlHf1d8WpfwYthERVhJ/6Ixn9VmXK6Cc7bExyGMqts2uMEZ9eSAMhyNMZpowN
         GvYLNVAlf8CUuLXFm1BtTtLNLwI+EEFkJeAAGkDo2y/5nhQnq1WxMQLokmJ1+FuBPGN2
         Roo0BpJiENX5XuXhNq12IyN9ZftZwWDWu8VqN4lXbT5Yr5c3UpTHRii6xcEOMdoKjsC8
         Bla1P+f9GSa6YqWJ17Jf+BvXX5DuNMJBvL7KLAJID9bR60xDWTD6SqbxyWgyz/XjPbnB
         sOKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381131; x=1774985931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyulBWdtbse6vY2m0hI5hgut+qotDEBTgU/TQet2TLQ=;
        b=KVl7tP6hJOcHZsSDB5aht62sVghIDYXvpJItuhQH4s2FQTpUMvQeK9q4DbyGwFDho/
         IbQuxme7haNi1Kp24OclsJpPL5fgvFnZb+DY/T/2emZTOIROLC3sIG/E9hDqatLCn889
         UVWuUZ+z7BUJETA5PHjFPeYfCqZv97QBQc0azIKGuG2po3UX0IkewK8B0pruW4/FPTW4
         or13noZQ7w6N7FKJ8jZ8J0EcKHKBiwb5fcnDSERqT261G0l/ZwGmpYnMNTzTsgfaiRaG
         8+/al1fo/Zmm2fuiYm7eDMQRvbc62HVIc+OZ8lxBAi6Mo8ZP60Om+jUAC+U302g/Yxcm
         LaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381131; x=1774985931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyulBWdtbse6vY2m0hI5hgut+qotDEBTgU/TQet2TLQ=;
        b=gH/ygJea2KN8aemWiuQOLckQgYANSGNvFFt12mcd89389ekLXWquT2buxo+wTf/gVk
         9kv4eZlrPZBw5gWjcGAD0+BFmznhllPm7XV4Psm8yng1Xoqu1Cnd/GlxhUaiu3Ux1FT4
         vqopG30dTDn7J9ryeiWOIwrS7FadSClnKGAn8j1vsQVdIIbyX2jL1ai4cKc/7Cutf5tz
         bEhwFNgxuyewyOIXjAVHmfvEbKh3E/TCL1BOrsfMVLo+ydQVRwI1Dp8M3QITYa/pwrep
         DOoeA+y2XA9GMgJQfNWVmF7onqjK81p7H5KtuajMZhahNXkJZULvoYMqA8G6jUC+UcRt
         I97A==
X-Gm-Message-State: AOJu0YxHl2ZRit3C7q+FgN96qQL7lA2ttmBkTSBlKCY9lcSef+8nuoow
	NGH5dcoRHUzjiLGy0/wNh5kcF/GUGIqfRg3JAUrpEQ094C+PL5910U/N/7Vc64/blcpkW/Spg7i
	Lr+sOksO32QYj7099NiBok7+XC73gIII=
X-Gm-Gg: ATEYQzx6yyHtwRD5iXFw4kLp8Zq19q68/BNAp0Ug1fITyxSoxCWTArwStSaaf27HzTI
	+KqiwmOwacF7wXUTU18F4V3UTN0KFfZZiCHxBY20ylgRI4g5ofj4DTzlB1iKInLw1V7vipWbRhv
	/K77Dk7htQ07o29QkPqTu6c8viZwN0J4dNvEAL34djhs1O4cnpdcQW3DD4b1b5RYAC5N4KDO7lP
	fVcjcjHaaCeqeGrKatR9GQf/wNgvQnQ/Wfg+YEqUsUBHgumdbt7/B8ZxHKQ32qbd31iAfefTRRS
	s6UItRFwhio7WcgeJMSenim0cheLNSY96+YhrDiQd2VLuKpgblxCrSyRA4oYddyAVuNJnXZ9c/f
	Wd2tz1dRR2DcXf4sfA+W5vXo/Ew==
X-Received: by 2002:a05:6000:184d:b0:43b:5672:f01 with SMTP id
 ffacd0b85a97d-43b8898d33amr1160048f8f.4.1774381131317; Tue, 24 Mar 2026
 12:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316185736.649940-1-puranjay@kernel.org> <20260316185736.649940-2-puranjay@kernel.org>
In-Reply-To: <20260316185736.649940-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 12:38:39 -0700
X-Gm-Features: AQROBzCiBu9lti7-1Lpnd4u1_S86kiJeOdQhwm77mL2wJsRvPYiP_RnVzG4xnqo
Message-ID: <CAADnVQKbxiBsXOsyau+rh86aK2VFHanNhBWRF49H0J+Tn+h0bg@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> The open-coded task_vma iterator reads task->mm and acquires
> mmap_read_trylock() but never calls mmget(). The mm can reach
> mm_users =3D=3D 0 if the task exits while the iterator holds the lock.
>
> Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
> via mmput_async() in _destroy() and the error path.
>
> Reject irqs-disabled contexts (including NMI) up front. Operations used
> by _next() and _destroy() (mmap_read_unlock, mmput_async) take
> spinlocks with IRQs disabled (pool->lock, pi_lock). Running from NMI
> or from a tracepoint that fires with those locks held could deadlock.
>
> Widen the mmput_async() #if guard to include CONFIG_BPF_SYSCALL,
> following the same approach used for CONFIG_FUTEX_PRIVATE_HASH.

...

> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 95d0040df584..5908de0c2f82 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct *m=
m)
>
>  /* mmput gets rid of the mappings and all user-space */
>  extern void mmput(struct mm_struct *);
> -#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
> +#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH) || defined=
(CONFIG_BPF_SYSCALL)

why? Is this some kind of odd config with bpf and without mmu?
Is it even possible?

These hunks make it impossible to land without broader review.

pw-bot: cr
