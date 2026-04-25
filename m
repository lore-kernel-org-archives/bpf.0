Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64630C368
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777161244; cv=none; b=CF6dS1Pj0nC3ZZ59t67TQFOznmvSOi+iogPiLB0wzaoiLFr7rklPzdDyLfGesMwsz8uarckqu0IeaFF3sbIEZwqDZZvriIC5L6Orr97Np3JL8BdV06jX7akL94raRKfIjIuFe/tMxWVPxUp7M/h8BasbFseKv9v5/3O+V4su3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777161244; c=relaxed/simple;
	bh=D3L2KqTIxEbf/IEATcF3Q8GTk2Ai3v6JipPHSyylsfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwjMf+cJBL4Hq5hwYT7VgNZwV+HEmcbZeaidZFnc+ak9sADb/+PtQn4UmFozTkep1IATtboobS1cf5liD2Bc2LebXLYwK0hrusO2bGaN+t54rXK9eWwS1rrHEiV3QHUskcdunMtaDU1/BmdETYSNXRh2IN3UHGT+9FzKMB45yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDX2D+zv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDX2D+zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E327C2BCB0;
	Sat, 25 Apr 2026 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777161243;
	bh=D3L2KqTIxEbf/IEATcF3Q8GTk2Ai3v6JipPHSyylsfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bDX2D+zvoAojHjACeFMF++sqA+3y9mJCUM45j1sG54/hDZoR1HcBVD6TgtFK04bem
	 O7hGJMzGhF6wn+8oOJySco6ZUoIEnUZCndZc05NKHBjCMvOkimbYDtbOJHsUGRFbYs
	 0Ei6Jy+9RfgOHeEsHBoXGqnkRCzTSSdYq7+OIOZuLa3Qf5oljzaDCospLViTiRKms3
	 b3On2MCnsmfUqACAF7VpP5ECXBYKQAkjPsYHzuJbmSac9fED+jFKxTQqBRyYyZP/9m
	 dLZq8xbbLvju5uUnoGDTSVNFnwQlOGuONULgLWreFqv6XUV+Zkr8ELbITIbrOB6Yuq
	 2PZ/g76glLlrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace
 period.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424235247.1990272-1-kuniyu@google.com>
References: <20260424235247.1990272-1-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:54:03 +0000
Message-Id: <20260425235403.9E327C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Function signature mismatch causing a build failure and an unused p=
arameter.
--

commit 6107cbce59856b0c337016870577c881817dea05
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: Free reuseport cBPF prog after RCU grace period.

This commit defers freeing of reuseport cBPF programs until after an RCU
grace period to avoid use-after-free bugs when they are detached while
packets are being sent. It uses call_rcu to handle the deferred cleanup.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772b2..5b6bd26bb80a92 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> -void sk_reuseport_prog_free(struct bpf_prog *prog)
> +void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
>  {

Does this change the function signature without updating the declaration in
include/linux/filter.h or the callers in net/core/sock_reuseport.c? This
appears to cause a build failure due to conflicting types and too few
arguments passed by existing callers.

>  	if (!prog)
>  		return;
> =20
> -	if (prog->type =3D=3D BPF_PROG_TYPE_SK_REUSEPORT)
> -		bpf_prog_put(prog);
> +	if (bpf_prog_was_classic(prog))
> +		call_rcu(&prog->aux->rcu, sk_reuseport_prog_free_rcu);

Is the new wait_rcu parameter used? It looks like call_rcu is executed
unconditionally for classic BPF programs, and wait_rcu is ignored
throughout the function body.

>  	else
> -		bpf_prog_destroy(prog);
> +		bpf_prog_put(prog);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424235247.1990=
272-1-kuniyu@google.com?part=3D1
