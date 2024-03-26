Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB391804F
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419408; cv=none; b=LzCUnnIPvT79JA8Ebj0abYRqF+rXP3eDx2tiPYFg/3OnDqwaWycyilhJCuTOzggnkBgqicSZnOTPqzN8HT+hrZx09NztxHv7ScqPWjH/NRD5qkk4kbN9U8OyE7NxC6ONZ0j8H0Tv6gE0ID79BtdAOO2IPHpe9VMBb0qhnWCmJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419408; c=relaxed/simple;
	bh=KJhUciWbyge6z6Tl0DYYlpQ0mnN0K/pyHUlf2t5vHEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Usp2nJ6koTAiby57AC7FDwGVxaPEEuCSK6Dux3Uxf5tVkT8MDSXbYZs+cKmuDsegLqYjHmfrZJ06chcokkCOP3g0/MrLtde/Q20kLqfmnSW6KD0pg6Pw+wPO8EnEFDCti18V0Z8kcFpXgGnJ3B7jmZ6MIyw0N8Pgb7q/gM9o5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAHbNbet; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAHbNbet"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3416df43cabso3495141f8f.3
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711419405; x=1712024205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLtlSOh2yxHoZNfhF9AnWFCyFSJLWYGfVZApR1FjNQU=;
        b=SAHbNbetlBM1MqUY4tXiIdedIVKworzYATPvicYNxAvxlqZJGgdgGbnSEC08jU4Exh
         S8e/pbD7dIalOezQ/g0l01UyulFc6dT3MLFQMYK7kE+CcLhb0BPPuJgX3qARAKcDJFd7
         DkdiZnM+1n2L+cd6tjE/0vy1A004P9Ou/aRraJLCP/pRcQZv7gxLn8hkj/c4CRU5QPXf
         qi/g462GEny0/cms/0Rc4nnv8bpilmTf8CfWDAtNBMGiRCjeO+IZ42rUsfa7KdgVjL21
         ZpfpUybEZMAIqhiXd7McNvCiNy7prCMGxnEXQhtKX8DgyPfXHbh1QXQduh58Sa2Mj3Gw
         DE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711419405; x=1712024205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLtlSOh2yxHoZNfhF9AnWFCyFSJLWYGfVZApR1FjNQU=;
        b=V2OI3Mvv5a6+Ltx/17hiBmZk3/xZcGtTx1otm4Us1UWzQvDVZB2MnkWtCIkIB9yHmK
         lz1//d4Hhd9EMHpbxQRaKoJQHjs9Oz9N4xz9mOflsCi4HsjLDSNIQvhv+dhus4uZQT0O
         N5TgwWwDuCU24/jG6cr3zFYsKOXsFemah1c6g5TCmeKGx1TTwOeNV8qcW5IScMkVzwxA
         /UvxkbCoI2GzpN64HMlJ+u/WYgZNP+0ZfBvANMvQj/CzvZkKkeQYc6+ON+7urf5hTvH7
         gnfq2+td1Zp8GCD0w5U8NcqDY7nZB5c5S9fKNxzAy2CziUCemnY2yeHjgFmk7EuY7Iwh
         EskA==
X-Gm-Message-State: AOJu0YxuiwBol4Uk4oIazZa99GKE4NKA+b2SHuGV0SF5qF5Dz5zRcqs7
	MVrp569nMEzjTKa5n/k4tH/jCvb83rzjQtpU7wmbSHDTqiBtqBwNi9cMjmIFvWlk8qwhfidKdXe
	LDt5h67Jsuk451wNmhs/ulNbT6g8=
X-Google-Smtp-Source: AGHT+IG/TNMh6FbH981oEgEhQAEg5BloDLjLHVI+k3cfXRdRh9BaAUMKr3v8bzttKu551DZSRDT9lrAPt5DmLmZr1T4=
X-Received: by 2002:a5d:6884:0:b0:341:ba31:b8ba with SMTP id
 h4-20020a5d6884000000b00341ba31b8bamr5730763wru.57.1711419404018; Mon, 25 Mar
 2024 19:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215144.3786732-1-andrii@kernel.org>
In-Reply-To: <20240325215144.3786732-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 19:16:32 -0700
Message-ID: <CAADnVQJ6SDtLKTx_68iBuLXv+=tthNy81r_cFhrwTbED6N-10A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next] bpf: defer bpf_link dealloc to after RCU
 grace period
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, 
	syzbot <syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com>, 
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com, 
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:51=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> BPF link for some program types is passed as a "context" which can be
> used by those BPF programs to look up additional information. E.g., for
> BPF raw tracepoints, link is used to fetch BPF cookie value, similarly
> for BPF multi-kprobes and multi-uprobes.
>
> Because of this runtime dependency, when bpf_link refcnt drops to zero
> that could be still active BPF programs running accessing link data
> (cookie, program pointer, etc).
>
> This patch accommodates this by delaying freeing memory to after RCU GP,
> which will fix BPF raw tp, multi-kprobe, and non-sleepable multi-uprobe.
>
> Perhaps a better approach would be to have a per-link flag specifying
> desired behavior: no delay, RCU delay, or task_trace RCU delay? So
> sending this as an RFC fix to discuss desired final solution.
>
> Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggerin=
g raw tracepoint")
> Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h  |  8 +++++++-
>  kernel/bpf/syscall.c | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 62762390c93d..d73a8978c800 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1573,7 +1573,13 @@ struct bpf_link {
>         enum bpf_link_type type;
>         const struct bpf_link_ops *ops;
>         struct bpf_prog *prog;
> -       struct work_struct work;
> +       /* rcu is used before freeing, work can be used to schedule that
> +        * RCU-based freeing before that, so they never overlap
> +        */
> +       union {
> +               struct rcu_head rcu;
> +               struct work_struct work;
> +       };
>  };
>
>  struct bpf_link_ops {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e44c276e8617..af1591af10bb 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3024,6 +3024,14 @@ void bpf_link_inc(struct bpf_link *link)
>         atomic64_inc(&link->refcnt);
>  }
>
> +static void bpf_link_dealloc_deferred(struct rcu_head *rcu)
> +{
> +       struct bpf_link *link =3D container_of(rcu, struct bpf_link, rcu)=
;
> +
> +       /* free bpf_link and its containing memory */
> +       link->ops->dealloc(link);
> +}
> +
>  /* bpf_link_free is guaranteed to be called from process context */
>  static void bpf_link_free(struct bpf_link *link)
>  {
> @@ -3033,8 +3041,8 @@ static void bpf_link_free(struct bpf_link *link)
>                 link->ops->release(link);
>                 bpf_prog_put(link->prog);
>         }
> -       /* free bpf_link and its containing memory */
> -       link->ops->dealloc(link);
> +       /* schedule BPF link deallocation after RCU grace period */
> +       call_rcu(&link->rcu, bpf_link_dealloc_deferred);

Do we have any sleepable progs that access link as well?
If so then call_rcu_tasks_trace ?
and check rcu_trace_implies_rcu_gp to avoid extra call_rcu.

Doing that for all link types like networking that don't look
into link is not great. Probably needs to look into link type?
Or look into prog->type and do the extra work only for raw_tp,
multi-[ku]probe ?
