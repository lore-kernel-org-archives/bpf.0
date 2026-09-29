Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB82E8DEB
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648716; cv=pass; b=Vf/DUxkVwdRniJTLP68r88+cl07fccqHCh9sm0puTUKHKZx5v92Sw4AXkUdtyKtKQjqoFYq8Q5pHk94EKXvjzuVKWgfNL6iLIVcfjNuY8LOvm76k+TfrdxCwlmda15Sv7BsGUssFTii9+5flwH4Z+bRtig3Y+ZiADtOpjtJSBaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648716; c=relaxed/simple;
	bh=gRofY94116ewXssUMqxmKOiWev4JCA1Bvd0JTvEcWgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcJe4oF6woWTsE0zydOKbNfKnvgqoXmbD3P5bRSRVfsAM2XPU9/8czFZcxnRo69XgAc5tKaifv5Secww4OfXlzfFRiAbIeD4noEoSangOPJhIrU3FTqpz/yTWKahrpQxIzsKBdOxNkvOcgw/Y68u9x4CXdAijv/gONcBiPzg45I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgAiUdE7; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgAiUdE7"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so22194185ad.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 19:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790648714; cv=none;
        d=google.com; s=arc-20260327;
        b=po2D4Wq36fXXBcr843QerVCPCX1gz6/1f00dnjAeLoYiNP2oWCXkFRvnQVJeOZGMdx
         tBiYbroyZawVhQtXIuRovO1VSJ+9SmWss3JZU2mAWahFGif06KwVt8oifONRQxak8D0e
         jHiB6RvYnF9IpSJ0Xs1mT/gNgYS88Lwx65cBWY60vpRPgr59eeV4IJ5DR+HYklfjrFrC
         kwsW8dt9BVoI+tmfaJvNVLvUMBqeyHgaDeRxKal0n//Trmd9L3EHK6R0k8vf56M5QEEe
         2RctJnT3XucIMkanDwcGMwS/WCCHO/0SDXeYiquv8pZcg5S1E2VdvcRuFboU8TLVEhMH
         TLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nkKvLbzRYukGPbTIPd09ia/Uh277ngkm3fC9shqQYaI=;
        fh=pzW3LipFedjE8TZoD2wByMolC5I+yyGJzr/AE3s8UlY=;
        b=gnRkZmAdE7yJIaHyq1KWTGGYDA4LHTxedaaf1i2ZWZDg+LoYMKex+n0VyLNuSpp5th
         nrWzcWQ2e3z+PiCNztELH6oMgdhzz8OyxD5eWubqAxvtrkNfQ1/j6Nsb90DUCuKdGi5C
         G+OxfbtarNeffUb8endJioMHVhUgf0UC3Ot8/FQrA1x7mGaaYnzqABP90X99MJJpRm3A
         clC6DOIZflND+ROLefEfL5MS9t/SxFL6T2KUHQuQ83t5HN1RC00x2N4vsTqOMs+c7j0k
         B+eq3EiwU43fWN6nvTXf51B3OizBG8x0RKQN/EX1vjBpIQOK1Jj6fUkAtZtT4k/Wcob7
         HSXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790648714; x=1791253514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkKvLbzRYukGPbTIPd09ia/Uh277ngkm3fC9shqQYaI=;
        b=lgAiUdE7WwwSrJj+oan6qBylZEEzEJcaNELFxFwTmFzS+L7PBASmGB1vnhazrB1/OG
         opZUX9WyhXoQkUMEty6q2FcjYTrtWAhpJRbUZNmx12Kb1Fu5yB/np6g1gIE+eZbsYWui
         UdHaZ3IMhaagoC+k7P+p3Hdua9quDs6zNxgLT3fwzvTAhDmthrMHdLPjCIH8cjpqQ6FY
         Mm3HoQBNsZSkVS8rW38HSmtq+EiK46+ONoWzwJcE6d8/vphYtMy9UQAKQ1FQg7W0T6R8
         t5SBuZjJRGkVFfIAmQ5c4b5Vb89WFF8jdjFIbQ+NZ0s2E/XMucEtyCO8F5wo3/xeehBo
         W2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648714; x=1791253514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkKvLbzRYukGPbTIPd09ia/Uh277ngkm3fC9shqQYaI=;
        b=KB4R5yVNzZbi2odGiJ3bSZmVc/zdn2EklzsChP9oQ38K0iX6xmmpC8uod63NXlmOZR
         PtTdtcLkZ+MtgexiST4ZNOqw3tCHYU5MqPQ4jxwKl3xYXNU2DmveV6U9Jynx2XD/ucwl
         q9ce6TUsOUSDLEu+gFIMXq99opol/B7rrl+IXHjMO1azDzaG/8Q0OYHt6pOdv8SqAH+1
         /jD2dJWmb4LsjZ3jWqjQBFv1Jdi6fDE1whlsUXy4gQ6yKZofSAHNZ+AJR3U4MuOdUitQ
         WMxaz74fIzzIQ2BulECu3njVJhlLp6uW3S638IT8e88MLGNdlldTIEHslnYtwtPLMf4j
         z2HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsHDXQ13i+Xs0+gfho96yIveak/7233QHLW94ngQRw+S1VaDoBVv2eqoA8BVaDW506j9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJz78XeHdG+ZrzIrVWJd43j0cds1uCsaYN9/fQU7rWhed/x9XUL
	MOQN25eKuyyYAw0I6fLQKk0N4qvq1hO5qq7vSr7hW6RPn+lhoXcs9iFaC5Cv5+VlX4HWa457+gC
	JscaOTWrcKRAN4TCSFdPHKOxOueztdKY=
X-Gm-Gg: AYBFou2Tq4Yyuobsetz2MiCdEknGhsynEAe7y+74zpo5iytmAn6MPNLJfZbzQvCXf98
	s1RBDgLzUPNb9ijHSrOdjDNsgNlQKtXQ4NaHZIWDCvFPAilDHlN8xnKwEN1+7Ko/q87lijrhlfI
	D6cTwXfuUiuHXadOea1B2avbiHb73WmQ7OIZoOI4EfxE8nUHrcuvIb2sQtN4RkH1jthO/B7f/eN
	2GwgfpZnlT/HrL48VeU5YdCymfQ0klrj3YFOsDy2ai/TX0ugq8Y+bmoo2a/L+FHfkLtIJdyf/BW
	UXinS5/XLVDbHpIYd7fVTH3YWEpx6O11PxNUd534/1XAWaJZ4zhCFzbamwFjPkR+cgDoeIMCP56
	Q3xUz53xY4wBf9INYX4EshsjcnfA3CcYyzAYG
X-Received: by 2002:a17:903:2f50:b0:2dd:c0ff:e72a with SMTP id
 d9443c01a7336-2df7dff64ffmr110127895ad.60.1790648713958; Mon, 28 Sep 2026
 19:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929005411.4105448-1-vineet.gupta@linux.dev>
 <20260929005411.4105448-2-vineet.gupta@linux.dev> <20260929010327.024281F000FF@smtp.kernel.org>
 <0499fb85-d323-4141-b76e-bc9812b1d142@linux.dev>
In-Reply-To: <0499fb85-d323-4141-b76e-bc9812b1d142@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Sep 2026 19:25:00 -0700
X-Gm-Features: AclHuK8MvjEF6nKkv4Z6ye1ak46nrlLfbKnMlxuKQXs_Elcb-3k7e9WK_870Png
Message-ID: <CAEf4BzZJL3jkyXo7XwTYwH2St-eiQB_FNCM6ZP=_TzC_McW2zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:22=E2=80=AFPM Vineet Gupta <vineet.gupta@linux.de=
v> wrote:
>
> On 9/28/26 6:03 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Low] cleanup: mixing goto-based error handling and scope-based clean=
up
> > --
> >
> > commit a6de528fef00ef67da15965a7a8b3944fa92b053
> > Author: Vineet Gupta <vineet.gupta@linux.dev>
> > Subject: tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
> >
> > This commit aims to resolve performance regressions with ftrace graph t=
racing
> > when there are a large number of tasks. It replaces the pre-allocated b=
atch
> > approach with inline allocation using GFP_NOWAIT, avoiding repeated swe=
eps of
> > the task list. Additionally, it transitions the RCU read-side section t=
o use
> > scoped_guard(rcu) instead of manual rcu_read_lock and rcu_read_unlock c=
alls.
> >
> >> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> >> index 40d373d65f9b9..1c5ccc3f80d53 100644
> >> --- a/kernel/trace/fgraph.c
> >> +++ b/kernel/trace/fgraph.c
> > [ ... ]
> >> @@ -1057,26 +1056,37 @@ static int alloc_retstack_tasklist(unsigned lo=
ng **ret_stack_list)
> >>              }
> >>      }
> >>
> >> -    rcu_read_lock();
> >> -    for_each_process_thread(g, t) {
> >> -            if (start =3D=3D end) {
> >> -                    ret =3D -EAGAIN;
> >> -                    goto unlock;
> >> -            }
> >> +    scoped_guard (rcu) {
> > [Severity: Low]
> > Does this mix goto-based error handling and scope-based cleanup within =
the same
> > function?
> >
> > Looking at alloc_retstack_tasklist(), the function retains the legacy g=
oto free
> > path in the initial pre-allocation loop (just before this block), while
> > introducing scoped_guard(rcu) here.
> >
> > The cleanup subsystem guidelines recommend that for a given routine, we=
 should
> > convert all resources that need a goto cleanup to scope-based cleanup, =
or
> > convert none of them. Mixing these paradigms creates confusing ownershi=
p
> > semantics and is highly prone to double-free or resource leak regressio=
ns upon
> > future modifications.
> >
> > Could we either convert the ret_stack_list array cleanup to use scope-b=
ased
> > helpers, or stick to the manual rcu_read_lock() and rcu_read_unlock() h=
ere to
> > keep the error handling style consistent?
>
> And a third option is to drop the fallback allocation completely and
> return -EAGAIN and come back. Granted I don't have much experience of
> typical handling of GFP_NOWAIT fails and retrying immediately: would
> that recover at all or does that take us back to where we started ? Peter
>

Not Peter, but I don't see a problem with scoped rcu and goto-based
free/cleanup. Unless Peter objects, let's keep it as is?

> Thx,
> -Vineet
