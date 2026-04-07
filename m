Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22483370EC
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583248; cv=pass; b=VoHASeKqp/C9qgTnO6ozd15LeQrXYJr/PYK/1pZntb61gSO6pIcAyCrK4FtsPTjrpo+mXwclQmYBrdQSuqsNI+wQPlRpIZiRvjl0h4z02VzmgP+DUNccN3iSruHaIBWRq+yG3ScbeseQYlxJsWts5yWMUxL3Xv6yIJ69ssJk6UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583248; c=relaxed/simple;
	bh=oQg3ep74iaTvR8Wg9brp6Jgh4R1nutg+DxmHVNWyOJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiM3Fledk/Q1fE0mPqSqURppt+E1JCoaWcy9cFEFSUTU8P/Ig3VYN/7LU/361F8Doms+31mridylR1L7LcTpuS9Rid3KeQl7BpuNuVw8xMonV8HAcXZlP9VQVVd1WN45S20NAS+1x4PKZy5Y4xAQZqUwCA16o9+BoAvRH5HGPa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oW5ER4oc; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW5ER4oc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so4331350f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 10:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775583245; cv=none;
        d=google.com; s=arc-20240605;
        b=gJMn0/Ie+MR1gs+mXYifUvm0Z5A9jLDOE8b95ZUC3UcFb72EKr8K9ZUeSZEC6iAoC+
         J1asASzV1/n+/lgMc/q8oVdgB+RbZj2Y9st0A2qcn74mxSZmF13/hCXVvuFT5xSxXPSP
         uFML5UsJwGcp30f1TMXVLnmUG4X3zQ8bg96R5hulm95LjFwW5BPU3qR2wC4Vcg7VeBgb
         i0TQcjQOi4JE4TY6EAZUzjPNkKPCg/2+9WH1jc9wJ/iBaaMVX9gTXdehkY/YiomJm3CF
         IUwhRApsaAedTxEviFJFJXTDwD9ipYm+MUgdXgNbf6anaZnc7eMOKZICjCKLfVZaVMCX
         IQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjtGgq+hK1F0LaNJ3LWDIG2ft9r++3YuXro2vkt1YTQ=;
        fh=t/AnSy67X2uPLng3/IPKAQgDjYIOIJtVQxAtR+CPQCU=;
        b=AdLO4fPMaIKZBsBxbXr2KrFQAi30k4YA4YbymoakQrT+zDqp4g8sxD0TlOG23VleGz
         oskijMQRrZfFUaJaD33pHGeRxXq9NYIbN02YmCIh0mu8tw4AVQDKW2+5t4tdwKCxrheG
         gbIiy6rVp0gCt+sij0FHehLoYZ2FD1gwIh5yydrTdlPYMH/hjDFiQmUWWg2ryJCX99x5
         ZU6y9xabecIT1MuU/Rd4e0F60UkBRHnUsKNbCcTUWvEvjYLgyFwBHuVCdEd31yN6ARtl
         k2OcYkBlSWo7cfCOnw53IleTvmULzdDd6RCIfMZczEBtS9qgbDi1WKRTKxYZgyDLJCZd
         Y/Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583245; x=1776188045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjtGgq+hK1F0LaNJ3LWDIG2ft9r++3YuXro2vkt1YTQ=;
        b=oW5ER4ocdeoZ9yyUyMsIKqkXZPcpy58u3Bkc5cXm/NFyOhu3AjskhK6pSw7Hbj+SxH
         RlS/VrFgqL5yVcIZ83aWrcqYmYRMxhubzQnGUsNUoMLdFZmoYNZeFySEcJaMhrLPSBfX
         F6oagkqphtQNZwA3o4bID9gZ6cFFUNxWYvvpyDlmc4b1yIfDaacnGF2sUXhG9+Sg0zkg
         ylETC3U37fEJoBtL7MPDPbPyzA5ORWEtPq3+xFkTx2iaUXlkl8BuQS0iRTa/QEiDiAR4
         jqoMDBNJizhwVPiGZsPo2iKuWNSLBwx/Y9EEvAepN23ZdBPRYNIbAJpj2cwHXnyJpIIO
         XBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583245; x=1776188045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjtGgq+hK1F0LaNJ3LWDIG2ft9r++3YuXro2vkt1YTQ=;
        b=f2YtCf1CDPhbEzTRGxZPrGmXbDRtmwROKrzYHjUi1DNfyULRPG7tkWBqwc22zSd7zQ
         eEGcbF42V1ddRnB6tZ/CcT3iXjLOw/jrC+yiuWwFbDGeWwtcjgh5cvlpqB+W4qA5x45L
         XK+1Fx6HrX0ZFxVKFel3k9NZ+saXS3ynPrNXIZecFxmOamdEjpd1RnO1WuMC2y1inMPr
         XloYF7kz4qfsk6MRQGgLzO7aBZaBeUzNtwboXuVlsY5DD9WgPgLH0Q6UDeWspC85nkgw
         GOphP8kk2M52LUv8CwrnkNXd8S0JlN8WEllCygFjhzBk5lx1QX5P9cNzPBqUOXwo4tHu
         hzNQ==
X-Gm-Message-State: AOJu0YyETu1EvphU/Se3o9zitI25zSZyu5MDBT00VJKqGqnnR2iW3K9N
	HioDKQ3ITlIol75htCyDpN5x39NZt4++6Ae0ViSW1M6+xOJ0vbuoW2q0PDfvnIYuETpx8Kw/4xL
	zesKT055LfS0k8uJUF4nLJqIIPbDOmo4=
X-Gm-Gg: AeBDieu0zY8L9F8TemVZ7N2WcF5GQf4rsBUDxhUYtzC3OzAjpWHnUUs/uJM4T2SvU65
	eWY/SVS63fjod1DqExRmwTquOQBn/I0vI3QCBhCWNycj5/OEXORctusVz++J+t0llE9oqdXWPhQ
	QvVO1DI3maKDRykiZMn5OPJN6X2cNPPa0hxG22G4u8uxq3NtCZk9fsVgGp2UtT+U0fExPlAeuvL
	8oV+pYkc9S21iUzjrIKEpSK68irFtF2ySxmClr7LV1c91PtA5giLAtAD/7VhXxmAjRqmwm2AKv3
	Gd4lvr4Y01nMvEG5s9fJ4BsOqLKitkaQXUUtDg1Rs6BImNf9PaSqU0xzH/RXObrdFjq/eMrNwT7
	RdwEAiFP77cU6LNu9R46sHqyRlw==
X-Received: by 2002:a05:6000:2282:b0:43b:4aba:8f52 with SMTP id
 ffacd0b85a97d-43d292dbb72mr27126672f8f.32.1775583244976; Tue, 07 Apr 2026
 10:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3e129be5-d61e-4bc4-b691-8d69e2f58de6@linux.ibm.com>
In-Reply-To: <3e129be5-d61e-4bc4-b691-8d69e2f58de6@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 10:33:51 -0700
X-Gm-Features: AQROBzAFTDkrP649yr2CcFKlgSVIR3lDqqVxPLzFrk_0CLHmXsjVmO-8lBaBvR4
Message-ID: <CAADnVQ+wZgucXKf5ZFNeSMcgARQVsQ7knVctf5R2GOGDRSEagA@mail.gmail.com>
Subject: Re: bpf/selftests: test_access_variable_array breaks due to
 sched_domain::span removal
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Abhishek Dubey <adubey@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:12=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Hi,
>
>
> While running BPF selftests on current linux-next, I noticed that
> test_access_variable_array fails to build due to reliance on
> struct sched_domain::span, which is no longer appers to be BTF-visible
> after recent
> scheduler refactoring.
>
> The Build error I am seeing is:
>
> progs/test_access_variable_array.c:14:13: error: no member named 'span'
> in 'struct sched_domain'  CLNG-BPF [test_progs] test_check_mtu.bpf.o
>
>     14 |         span =3D sd->span[0];
>        |                ~~  ^
>
> Below is a proposed update to the test that switches from
> sched_domain::span to sched_group::cpumask. This preserves the original
> intent of validating variable-length array access via BTF while avoiding
> reliance on removed scheduler internals.
>
>
> diff --git
> a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> index 326b7d1f496a..c9f345ccde3c 100644
> --- a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> +++ b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> @@ -4,14 +4,18 @@
>   #include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
>
> -unsigned long span =3D 0;
> +unsigned long cpumask0 =3D 0;
>
> -SEC("fentry/sched_balance_rq")
> -int BPF_PROG(fentry_fentry, int this_cpu, struct rq *this_rq,
> -               struct sched_domain *sd)
> +SEC("fentry/sched_balance_find_dst_group_cpu")
> +int BPF_PROG(fentry_fentry, struct sched_group *sg, struct task_struct *=
p,
> +               int this_cpu)
>   {
> -       span =3D sd->span[0];
> +       unsigned long *mask;
> +       /* Read pointer to variable-length CPU mask */
> +       mask =3D BPF_CORE_READ(sg, cpumask);
> +       cpumask0 =3D mask[0];

No. That defeats the point of the test.
It tests [] array in the kernel struct.
Just make one in testmod.ko and access that.
