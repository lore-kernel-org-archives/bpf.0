Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DACE30BF68
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189088; cv=pass; b=qFgKvNGaAlEnn0eAiDuLQXmQIA85Ip7KRwlbkM8JC2qf3V5qWa/ckGTXfWnWMjA/9eYVTv02ba0ZJ+946u7cfSwVoeFyhEhQ0JKthL402pb6WBD/pvS4oU1IpnpyHz+SReTVS6jHWoFmhX3+J+Bmbz+BJcc9J544io7GNjqP0zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189088; c=relaxed/simple;
	bh=06/81H6L/YT/8EER15FV2omtj3AB/Z4Y68xw1lH1wrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1M9rJKeDGQKuc8WxafMkT4qCTodBSGCiON3XqmXPQ/hXZYfgZoZFHId4MI+LlcUXisGQdp9lNh+0luR5Gljpj5cs2vRfPyPLOMjaxc56Use0mmXABXHwxUTIJ5vhCR1n3wzqwnyj0xwsXmJCfVPnYvl5dFWnEka7QlOFR//DXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5Bbu3LZ; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5Bbu3LZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso5500557f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776189085; cv=none;
        d=google.com; s=arc-20240605;
        b=TuPC4GWLRNS9KtclqgpR1n87t8h1ue5Z6Msjys8QxWRMOqofIf+yjcMSzSVqEDRvmi
         ogun+oNFht9MJqFYzEkcr50enYoNAv0Yb1SNzvNcnARcTQaIsI+dKeSyIemhYLOWyztA
         FSrF2nJ86+1cHKzlHuN/zID+eDri6/aVKjVbpi2WCw9UUp47N0y0MV7eoQ8WutT1KBWv
         fy+uVJ3sqBBCBPX2+wWLwfWLLYFc/EQBKLk1JrMI7fndqQMWoZcU9F1ghJG3sx0OYyvG
         evEEMb8lS5L1+kkdPZqqcl7g9Jj4PNCu/fLs2Uak9USdhiEXSegA3o64iT+Lq2VRNqg+
         SkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HWJfMpcG9oHHgfAvtEr2CcnzBFyrnnkcwcqC1PClYA=;
        fh=OWwM0xaO4n7Je9flLyQVgVXOPXqC7LgpTtDuu0Oa0WU=;
        b=AClP5UHNk+0Tm4Vhl6xPfId1u83SCrqjag9fJsMTJczNUKL2fmGa6ivVDlDKo6ln0k
         zEg8PNmD7BPl0+ZJq4KhZhjIEKnkPa3DZ4AfDap8icn8jz6Yca2Ry8aAfL+dGz8i/8CS
         7yv2suVYT4jnPdSWVQo6Qt4YEi+bFKCp0uXflz7966GIbr8O1yLTpPVX9nMeWmJMdUkV
         s0zZnPz8kC3DGFCOKPPAYRH7N8A66lMgJyhsIqZyw3WgVO/YOovlQkXV8Gp3xc+k6vks
         xsVIOvwIcvGGqk8PyGPFR01wZjZwyvTlbGwaH4Fk7e9aHb/f3HgChJ6Juc+65/c6rAyi
         DSKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776189085; x=1776793885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HWJfMpcG9oHHgfAvtEr2CcnzBFyrnnkcwcqC1PClYA=;
        b=T5Bbu3LZ58AOPCSr8rAQIZ4XGVEu2CPcg257+Tl0+vDIL65687HNW2soGIlLQgFuFQ
         zM3gIA/dwJBZbAxWfjK7UB2aDBkunqHQ6DWTxJG3Anvud73fh7QTfJHGUvk1dBa0TEw/
         EcqOGItuOwcCESpNknw796fwXByPrWNyXJA/Y0eOJijD/qPPxY7+E818hy6dpOFzXFvW
         casu8ophzxE4lmaewaXvIa+Lw/Jb6I6V5qb2nqrjtLRrHAWmaRIKiHmD2qemTXOGpBV7
         qVF6lSckhZpOgFV2MUW2WHmBzBOZRaaeDU+c7PDSFKDVm6ht7bYfYnJXuTM28JUJVUqW
         /7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189085; x=1776793885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8HWJfMpcG9oHHgfAvtEr2CcnzBFyrnnkcwcqC1PClYA=;
        b=shvJSNA36OAxfcwrMHhE5phAd3IdqCghWp+EKESyCAXdlxEhMEGcKayxDWP4KAT+KF
         gzk4hfj6FRC/JfjFVHG/rzstgjNVQV6rXgxn2icG2yQ+oVykM7yTkGouP+lWahnWIxW6
         doh9FvGHfgFUiaXJo2mHk4E3I0vFo9Yv16AsI263uAW1fAHO7hq6HRutaf/FmqDnr0ry
         66u1pTlkd8nE+sZs0oqggyAlHwdQ1AM99yWlPDrWLZ8k+Cs22m7Yn9gIYDgwcIjIXpzf
         lIVo5f2mIbTiqOgbDc+H/t1hb2wJXDAyGmzgjIIjjQfg5uXesFAe0wyqBrtnt5D7fZ/A
         0mjg==
X-Forwarded-Encrypted: i=1; AFNElJ9V4P707ACqqehvA52BLioDKj6yO6tM1tqVS6nwsvG5w5g1qTcFXXOZd8Tc2BjjniBIA04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp33IsE8lDIYVq+JVYVXndJ/c8b1aUV0MrDjjKkOuvLlKJxoGl
	veddhpPz7X3X0rUoWZcIPgIZky5bCHg1UY7LxpKIMcgedVRWLGrN9Q66yeK2Gu/WSmlKZbf9Tbi
	g48o2Vnzmu+nbyzOAEcr3Mr/99qNd5ntXlCEW
X-Gm-Gg: AeBDieu9zVnw88owQ0Q3NQjAJLnBeuA8yl5x83IeeEvkI4Eu2jrZGnVyDZQVLZdlY0s
	+MKJ7fux5vehpTey3AN4EgyMrmGf5DCAb9+XN4GymPkqhODt2+RZUEOTlmUnr+eRcJsF9P1yBrn
	9d/cGBaga1+nkEXyYsMCHxITvGyLSmKLJNWQu5q7yNKSsJtBCT2e9fDVesxp6lI805HQvxTAget
	FVtQPHO8MyJmIrXghyT5z2uzNMGq3xu68Mx0ifUC3zU8ybVx99pWiuX5J78h2ooLhBvduH63RUr
	2xsnrS+ovWs4dMjpVDCAk1z3CGahpqi/CPKg4MmRUHCiaMWR6QFaSyaGcNT1fYX0mOFVbWHe8la
	4AWww9K/j/VdI+Og9iCtdHvmpJUThc8+VtQbN
X-Received: by 2002:a05:6000:230a:b0:43b:6a55:e26a with SMTP id
 ffacd0b85a97d-43d642dd77fmr28330470f8f.51.1776189084807; Tue, 14 Apr 2026
 10:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050033.267815-1-yonghong.song@linux.dev> <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
 <281485db-073e-45b6-8929-dad36fea5f87@linux.dev> <af8bb98f-5df7-4cba-9bd7-84eed5239db9@linux.dev>
In-Reply-To: <af8bb98f-5df7-4cba-9bd7-84eed5239db9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 10:51:13 -0700
X-Gm-Features: AQROBzDXVm6BcI14KnhMTVEZTkUzHbWUMbYrLDunsv57Gqm3XwT1LDkLIl3rhis
Message-ID: <CAADnVQ+37QFYb9h0_j1m8M32EUJq7aakPK4eQ5wXB8bvsxt_Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 9:46=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> I think we should do
>
> for foo1 (from llvm)
>    a6: off -8
>    a7: off -16
>    a8: off -24
> for foo2 (from llvm)
>    a6:  off -8
>    a7:  off -16
>    a8:  off -24
>    a9:  off -32
>    a10: off -40
>
> For x86,
>    off -8 will do move for r9
> and then we can do
> foo1 (4 stack slots):
>      <unknown>
>      <unknown>
>      off -24
>      off -16
> foo2 (4 stack slots):
>      off -40
>      off -32
>      off -24
>      off -16

I don't see how this can work. You still need to know per-callsite max
to be able to flip the order and not only max, but which STX belong
to that callsite.
Also compiler may share single STX insn for different callsites.

So yeah, it's a real issue and it needs more thinking.
Back to explicit r11 adjustment, I guess.
