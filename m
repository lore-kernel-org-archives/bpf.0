Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4C73E5A27
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379483; cv=pass; b=YZrykTJUgpRX7x/HgeX58Ps920u80pPgndFqNfHxGnOD92X1zqKw14CCHx/bCruZPJNHi4gTd2VoJL33GQRhLjtFgE9rKl4ZBN/lTc/3yJq6GTIZz/g4uSpTAL7GcCYBXYHwW6H5hQsXn0B0SYRmRgrNj5U43CI4/9SJo3KOq94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379483; c=relaxed/simple;
	bh=0ldrpoo68rpXzEUw90JeIBxRjusqYN4dYNmPwTKPHGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vtue6VAbmiUX+IWI7FExqwBKp1HTfUhbI+81mK/w8dUTcmiM5T5QfI8mXFlCUc1mG0SO7nKAQbZ6Z6WTZpOXQQ/Oc0ODMb8L+PGpU5pvQI50cC2IhiDOjQyWeTF0g/HD5ZnJIT+QTdBYJwB10Cr8Q1SXqWWtEF29E2EBl+iDrIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMQQb+IT; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMQQb+IT"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6611669cd16so4983926d50.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 16:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783379481; cv=none;
        d=google.com; s=arc-20260327;
        b=sbWZmaacdEqgyo+zYaF33/e3umJaXLFcrF/rS5Duzc78hIO43LBz/YlLVUTCbNhxm0
         s1jJHBYvKndem0lz0t5R0gYduGWU0RxsdEpb9XtwpapjHTSRRKYlWqx/gjWb6ain9gjV
         FN2qKNBFTYdIYGzihqGu9Uplm3ieyw3MpL72vCq1lMY0XvrziTF66BdnIOygSHjOzoL4
         I/R40PVq1hIdn9l+3R0WTgcujlqWcDj0Zvls1tkDXu0CNjlrXrEGYjmvcs+7UpaI4GKj
         gbyyMpDEqmtCQcJ59W7p89FwWQTBwNFouOdFjKBLk12/ElY6owdeoI1vwnZRpxt8OJwQ
         8Dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3cdgqapzumwzqnY9k4uVmaR2nHeOOKloBNHyQRqVGc=;
        fh=HArfMcsLaCSZhpzxj3OOCZH+4oYXcuYYMGtXh5yaDpU=;
        b=bK9eUAw+/pSAfaYI/nNV6gHGUEziPClQ1cq5IWQY9hdhLkxT2127vRcxnyjywtz8YB
         XBtqkreZyoqgMBJkFYrp89BPjPYHnMSnhfQBCeMfWXIfi+4sJ7E8XntYskxIzxsm3VaY
         vogCiX92fjRGZePPeWaHq6f7OAx6PS/83WTFVep1sPcccqTMoTN2hrnrL4YnuF5pF7Wo
         wQC1VNe0mNX4ERyYbX0oNAtulGX6WWZAoqV492XtpUdMCGoTWfOOcePThey3g2OPqEmh
         1/WAXZKLHPfcj80/qpEy+sXnTaLYp+cSkoaX2dOW+o/nnZPRXBo1e9tHYoy9OJoegzzH
         8YfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783379481; x=1783984281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3cdgqapzumwzqnY9k4uVmaR2nHeOOKloBNHyQRqVGc=;
        b=NMQQb+ITiACZy51nzG8P1ipra2sFOEc9Duwxxsmnx9wdST78spV48OB/YxmfZX96R9
         EPGlvssPnTsNdyIoxqIre1BWGmA5txoWFpqWX3Abzniy5h/eIRmt8pp+l2btLFOYNzSX
         XNvIoGenl3zDP6fllVm2AfZ1J24E6CaqXpUaHO4bouMagiv7LGJ4eK2PzIPkLFhH3zj1
         TK1IKxaDDyWwzeOj2DrGnFfpbZ/tLXf5Cbsqa2Hrw4uZC+FQdgiZ23rcMyrA2trYAkFz
         C6W8kf7X90EVhiaGXd2pXJ13NBflRSZ9EnmlGSpPI5vGtWtTiwbqdyCFRSlUlYMpH1bQ
         W5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379481; x=1783984281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3cdgqapzumwzqnY9k4uVmaR2nHeOOKloBNHyQRqVGc=;
        b=d65wZbO9mZAwOhLegt+z4ae5CHNCY+gTtagyWQZKjqU7TA7FvlrQGWZ2pGLizVtP9j
         QazDmhfMhcFnlNLA9rp/X6NKTiT8M7JBsVHRtBKuZ16CqBHay9MZvtfeT0TiJnK/H76a
         YdC0yK06hHf4nsWF9/xEAfZwGacKWSm/ghYP+uugo9idgAvEFpesJM1O2pQZfkv0zhtk
         heCL56gcRiEZIyh4o+K08SpvSr1EnJPikB/5zxSaOvyto681BL+L/nfh7t5qKeSDxrsd
         /s8I2ikrmeB/7MEy2SCsiXUR6QtjIJkbgQPoQhySg8Xh6mLo/c3UdvWk+coSxyzluObi
         m2ow==
X-Gm-Message-State: AOJu0YwjgWbZ3ghzQm7KuaZ8szEurNLLTAZ0jm9//s0AIAbh/3IOOhu4
	fBiFYopNZetzbLom+syBXFRKO77ht4+Qf+MwVh0hwIG+laq9NgCtwNlZY2GV9k6RdsdsuMx7y0P
	0pR82ucYq5Y7+E2rVAHJDgVJFC4p4MWQ=
X-Gm-Gg: AfdE7cn2AIdQj5Z+adEUfaqXf/EtfzVBAPArc7itXIbGUeFenEWPzcObFMRLvMImjTb
	eT8CNkIHe476L29LO0hcW5TPlPytridEYeuamb7H2fgfoQF+xbG+bOcCwNWLN/PDLjU4o7Q2b2P
	uqsM4aJ4cNpjnWka6l4ccBUr5F5663nC4+HR6Rt0SNnPxWu/3WB0Z+7nEUOUaXdQazXaZE78vVJ
	/GtCofv/oxGqAhfssCaVcMIxN71dFq56Av67TngOW9AG3VHubTtuQGC8O2Ck6LLNNWR01oz
X-Received: by 2002:a53:d012:0:b0:664:d7aa:3ebf with SMTP id
 956f58d0204a3-6677faee048mr1719697d50.1.1783379481249; Mon, 06 Jul 2026
 16:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-12-ameryhung@gmail.com> <53de193473737a3692df075a179e186e996dc26a592b697f2f335d9d4039c943@mail.kernel.org>
In-Reply-To: <53de193473737a3692df075a179e186e996dc26a592b697f2f335d9d4039c943@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 16:11:10 -0700
X-Gm-Features: AVVi8CerpQkWQBGKAnXiwMgd3izzJDVAW6uUXCJoT_umDqP0xKf7SNii83bPR6g
Message-ID: <CAMB2axORKWYVfG_ZSHosX70Kf61bEqtyTnRPhuJy79avBJAHWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] bpf: tcp: Support selected sock_ops
 callbacks as struct_ops
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:28=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > new file mode 100644
> > index 000000000000..3febbc8dd1a0
> > --- /dev/null
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/bpf_verifier.h>
> > +#include <net/bpf_sk_storage.h>
> > +#include <net/tcp.h>
> > +
> > +static int timeout_init_stub(struct sock *sk, struct request_sock *req=
__nullable)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     return ctx->retval;
> > +}
> > +
> > +static int rwnd_init_stub(struct sock *sk, struct request_sock *req__n=
ullable)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     return ctx->retval;
> > +}
>
> This isn't a bug, but could timeout_init_stub() and rwnd_init_stub()
> simply return 0 like the analogous int-returning stubs in
> net/ipv4/bpf_tcp_ca.c?

The stub function returning int here must return ctx->retval to allow
the next program in the array to inspect the return value. The stub
function are the struct_ops counterpart of dummy bpf program. It
replaces a normal struct_ops program when update_effective_progs()
fails and can be executed.

>
> These stubs are only used for CFI/trampoline generation and never
> executed. The sibling file's int stubs (bpf_tcp_ca_undo_cwnd,
> bpf_tcp_ca_sndbuf_expand, bpf_tcp_ca_ssthresh) all return 0. The
> container_of() plus ctx->retval logic here duplicates the actual
> bpf_tcp_ops_get_retval() helper below.
>
> > +static void active_established_stub(struct sock *sk, struct sk_buff *s=
kb__nullable)
> > +{
> > +}
>
> [ ... ]
>
> > +BPF_CALL_0(bpf_tcp_ops_get_retval)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     /* bpf_get_retval() is only exposed to timeout_init/rwnd_init, wh=
ich
> > +      * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the=
 int
> > +      * return value chained across the bpf_tcp_ops attached to the cg=
roup
> > +      * and is this program's saved_run_ctx.
> > +      */
> > +     if (WARN_ON_ONCE(!ctx->saved_run_ctx))
> > +             return 0;
> > +
> > +     return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
> > +                         run_ctx)->retval;
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/288106=
80939
