Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3952FD69E
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970857; cv=pass; b=h6KKOTW2aAUe7qAbgDUQa01MvcdLzGqFHxFPTXTbdqntmjrPUytZeQNS7NREoeFtLJWN5+gVGJRL86IHcp0XVquDTKHj9ALDMAFOAF9NhkQFGM6aSwWMzmttIuF6Bv+IG5LeJIaWatruvuRNsjTYKSkKwsKNO+W1pCDZFiJjC8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970857; c=relaxed/simple;
	bh=cPFk5LiS24XRB7lAHu6mk6qRe0o6w9nj+ckT8UvB7xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9g2kkRMT5/gg5m+WQttBSi/5lv4miIk7C8JhIo/FAWdpyZoOaKjKe7wPX+38Rv54a/JKTsi4cyfhhFSta8WM3Xx4Brmw0KusCFnEHdl7rV0hX3ys1zygBJ2WjmTWmllPKR659aLKdKR71/B7be5cs2Ix5RtFNZVc9WhVr/9E7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmrOG8Fq; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmrOG8Fq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so59775485e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774970854; cv=none;
        d=google.com; s=arc-20240605;
        b=RG/U5tRzSeyvSDE2bUh+Q26xEhH742qurb9E2yL0wIfc4X1RLYBtfR5LJSKwJkyQVE
         o3B+6vARV02D/wR920VLq9f9rxbMCbVtglFsTX6+7PdFFxwy4ams56bZ+gd34Ufq00o8
         AdFu4QgAOos6TSJ0DYatDxB5feqwQ0I2VfrNLgyeaVETvhlPMk1+X2nMmC/b3hbov1gx
         ALyYgKMNAAOyM4vZF7gEN/4RynLOihSUHlJaLmFFDTqqe3/dc+7/LwnImAZLy5d72mmq
         u4doy0vtomAth00gtiaW18JXsDMIyNwV4DU37ZgjQ+rcwk5dQFsyc/2lp+Q/sep2eI7W
         gpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXe9X+tFn4u72QIwhQGxlx7HiHQ83CyWQwXaiSNqjv0=;
        fh=8ZESvcmFg0Oow24nQQqJujEOooHHzecBYPPnYm4NyC4=;
        b=Mh10yaz5pT6Wxspem9yIQQX9H/suexKxmOIwWebaTnBx29LwwLJsHHhgCY1Mq8N9AE
         sJMODgZaaJzB96U9IapIy1mlqB8Lw8CeJFIbeRIuXtCXHloKXYQN+o0YShqdSTnzLpl8
         jykkpB9wAOWYT8DOMPTWsFOI5+JBm1/HcudzKaA0EcdFuzxRxuDjwJcEe/CiDrKFWPRv
         oMp6mTz/+huxDVE8G35qL/69qy6cHwHkE+D4h60kJrOyghh9lmBDXJ3drWr1boLPj46n
         +n/cpph17HEl4VQHWG01xXmpHdFzmujuE4wF3DEEtTjM8Hk68hs1CBhrRjyumU8zbxgt
         8rWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970854; x=1775575654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXe9X+tFn4u72QIwhQGxlx7HiHQ83CyWQwXaiSNqjv0=;
        b=gmrOG8FqTOUwEt84inGYTAoXkXdPKUKhJ/v6bd1ySZmiUbC/dVga27aq3CiTaIvoKP
         UVByzQRxKZ5tZ8ioc/eA3Rz+j/pavQ+My+U3zIX9KbdvLGF6oPIodQjrlNMEeGONxCXg
         GawZkIZNyyYMERIU9+dcsDVlkXp/dK8N3fuUNkCwUnVs0/p+YGe2Wj8EbsRM4MQhhbeJ
         YH/V7b+mzoiGdDohW35ZLeUNpl9ISGuNO+dmjAjPKecVVN38h39m3F25W22BKdaZctjm
         H+AHdAnPFNaEPk9XnLYNme0MNDliBG52KOZUpJsOuXv484/9PL06D0g1FRFaK+6hrLQI
         4l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970854; x=1775575654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VXe9X+tFn4u72QIwhQGxlx7HiHQ83CyWQwXaiSNqjv0=;
        b=l39hHmV5BlLYAWYS6UgnqT3MowwbwwSAOlBSxqvgd4hwPPPOp4GlqoGjzdt46EFa8H
         WA5DcezfWzqPtsxosNt6EEAKtVTxoJqIVlrei0puLVOwQuRsSnPiikVq7mX75+T4TIvi
         +sD9w8dcDr7fTmWS6yQ35yypbJZ9uTMi/SmPLFAOAIiSs5YUCt7O+FStXT013jlDE8xP
         imLyVuIsYCDLl3uQrAEOiYXk6eaeAgEx44PDs5c/nVq+HePOFUoJC1oUf5OSikuyvQxn
         r5CTMNs/xMUKHbd1HKIRNc7Ns4ek2E8+OQpl4SiUbMTRnfx3Y0ztAWq00Xczt7apEyoW
         3rhw==
X-Gm-Message-State: AOJu0YysWGchGeLSuDKYFyyo1OYzA1C4x3TDCb00ss6S1IlNaMmftyCz
	seLQrVYE5JGb3ET099Dvs6LIIQljnxNkzID5g8YbRfl5MmQcnXzVFV527O9c+/SphBZamO5FCkz
	RDfIv2e5+4RIC/atxTioFkNLOVUCye+aBCw==
X-Gm-Gg: ATEYQzwYtMPiloJ+1Gs/GQQxxVrMb6jo7UXn5zFKI5EmpJQl89rNZmaoYztAdZS/FhP
	balxRXerpGeIzSsRRX2rUWBjrRyQjvXx88d+Aggr3ejpH7YVij/TKsRMbP/6aghuN6QV87MCyYs
	0GNcxe8kenEbQQeIz6RULe7UKiYqwxfSVIyw40Uy23lcw3/NUdFaSbcuyMzHn2TsBXzU7PbRS5p
	fKZkRqG7BZWA8g0bF/w+lmGDLdAsZKrEAtSMSjCDdUcjcXBaYp9hmGZCNbDusLLpmBVLTsy9RX6
	SzrvE/PlFuySahvm/vfhfDbcx/O6SaPQumNctusiIAcXI/usxQfWJS6kIVLZyTPOqsY5T/YfNRA
	ij/HS60c8MEWzhroeTh0W83H3XA==
X-Received: by 2002:a05:600c:c0ca:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48878397374mr48590485e9.10.1774970853919; Tue, 31 Mar 2026
 08:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331005215.2813492-1-memxor@gmail.com> <20260331005215.2813492-2-memxor@gmail.com>
In-Reply-To: <20260331005215.2813492-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Mar 2026 08:27:22 -0700
X-Gm-Features: AQROBzC3wVvP7NZmscfs3jasgSylBrbgTbK2duClcmZ2_q2c2V4jfWhI4RPi3PI
Message-ID: <CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint bpf_link
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 5:52=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Recently, tracepoints were switched from using disabled preemption
> (which acts as RCU read section) to SRCU-fast when they are not
> faultable. This means that to do a proper grace period wait for programs
> running in such tracepoints, we must use SRCU's grace period wait.
> This is only for non-faultable tracepoints, faultable ones continue
> using RCU Tasks Trace.
>
> However, bpf_link_free() currently does call_rcu() for all cases when
> the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> this by doing a call_srcu() grace period wait.
>
> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> unnecessary for tracepoint programs. The link and program are either
> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
>
> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> to generalize the logic, even if it conceded an extra RCU gp wait,
> however that is unnecessary for tracepoints even before this change.
> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> true. Hence we need not chaing any RCU gp after the SRCU gp.
>
> For instance, in the non-faultable raw tracepoint, the RCU read section
> of the program in __bpf_trace_run() is enclosed in the SRCU gp, likewise
> for faultable raw tracepoint, the program is under the RCU Tasks Trace
> protection. Hence, the outermost scope can be waited upon to ensure
> correctness.
>
> Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_=
CALL() with SRCU-fast")
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h        |  4 ++++
>  include/linux/tracepoint.h |  8 ++++++++
>  kernel/bpf/syscall.c       | 25 +++++++++++++++++++++++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..35b1e25bd104 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1854,6 +1854,10 @@ struct bpf_link_ops {
>          * target hook is sleepable, we'll go through tasks trace RCU GP =
and
>          * then "classic" RCU GP; this need for chaining tasks trace and
>          * classic RCU GPs is designated by setting bpf_link->sleepable f=
lag
> +        *
> +        * For non-sleepable tracepoint links we go through SRCU gp inste=
ad,
> +        * since RCU is not used in that case. Sleepable tracepoints stil=
l
> +        * follow the scheme above.
>          */
>         void (*dealloc_deferred)(struct bpf_link *link);
>         int (*detach)(struct bpf_link *link);
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 22ca1c8b54f3..8d6df1e7b5da 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -122,6 +122,11 @@ static inline bool tracepoint_is_faultable(struct tr=
acepoint *tp)
>  {
>         return tp->ext && tp->ext->faultable;
>  }
> +static inline void call_tracepoint_unregister_non_faultable(struct rcu_h=
ead *rcu,
> +                                                           rcu_callback_=
t func)

The name is too long. imo.
call_tracepoint_srcu() ?

Steven ?
