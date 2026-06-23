Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20F3ACF02
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250038; cv=pass; b=FZYQn5cStTTHwWn8N3aSNrHwNoD3jW7D3mWfj95j84hUUykZ3b8T6TLFlQ772sk1cFo3VFCCaIDJ80pLJcjpmgNREn1Z2oPcg/m1l25UGNiH61LTXyuv/fYA2gPWNqApW8mPFfGrQtPtq3PU2VdGJJdraV3AVBX5+iZgeyaNuJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250038; c=relaxed/simple;
	bh=NkWhHVyYaYcxz0LgXuoX+rLSkF88E2rtRRNG+L6YO7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXnM9CeH01G5NM/BUIMsOOK8xwhfL2n4/FARWcQgRzi+klsYDEwDECTpn0m7/imN2GJ9ZOxJAm0b2Va4Fch6WBeUzeBQBK0DyimKimJIzQdRHlv4JAqw7Pv8A7QLua8mLnTC5Vf1/MOqyscy7UXSWJOj4XmzvzcLOCA90nvk1hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jon0aSX4; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jon0aSX4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6c57c5bcfso2821555ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782250037; cv=none;
        d=google.com; s=arc-20240605;
        b=eY26oeXNT2qwFWXg07pFw52Nkgenim5jxspz1J23mIxC0B+H4Dper1VbkOxR4qLUmY
         1d+jMY5Wnuthp0HXptLL3PjKdE04gGsa9CEKCTmGc5HsKvsENEnGh+RPJbJ2797qWTFi
         W4uhwB05UrlH0aFexIfk0NHRVrtEryuYdnCZTNsW7NLJFDIw/UN0+PNjU3BsUmFB42R6
         BMVKTtJg0pFmG/FqclnvZKUIfVo0BGtp4sqftcVmIye20K27oZwf4B+xqGjGg8xZ6/zs
         Z1I2rsQ/n/97iLtOayQ/IYt+DCpJzzLrGgG28AAgxo/Za/nynpRuwxbZBxwxulMdo/I9
         t3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L8wo5u3B+ZdxxKhZHr6gjYHFiYr35jlEHlBTv44aLrA=;
        fh=CxYqos6vUUFSHMxwAxTp7NXxUaxaWxgn49x49TjZALg=;
        b=FCCTXIbkjXOBfSHGwzxXJ6sZGFbW2VQPBu5/ADiIDdqvfypGVNJ3AnsnJSnlppAXkD
         Kq/pYSRa9kZYnNVMAH3uvuam7f33yIzAAA2nqvgkTYlcCGMXlFWeT055LaTgJ+0NXNBi
         UCnQnmJOZSWNR3pwoG+klq0HgGjvCGc281Yo1yTrsLWVx6JXzkrtZtHu+p8uLM5t4GCd
         v7vgBANNkejDPiFFSUAgv9ghmaUCaHu8Lb0JWwGuJZsf/vp3jU6N7kIjdrjVSrrSUGdi
         f3/UNfZjqaUnC9Qtn48Sh0ZqEe4Wu+/3HxlRxPdnF5UAbckYoWhAhcS+dJcXx+w+sRcR
         /mzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782250037; x=1782854837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8wo5u3B+ZdxxKhZHr6gjYHFiYr35jlEHlBTv44aLrA=;
        b=Jon0aSX4317oa+4akZ5n0ZY/yW2mr0RveIqR6+bS4gnqJwqR9YtZ9H35zXGZzE2LZH
         8200yWtUcOQ/mS5Wi10DZbRvdbiPBB2Cche8spr74S4npBMzdXlUhYDO1ZpF1yo30Qhm
         j8vOvfT5jh8lKT2zbWyuih0Y8TfcozawyWzerBux9jgWm7HOYIURIp57Vt/NFo598+vk
         lY6PPvEMrkp9eEoeX2vYwO+Bpb1bKUYfpViQi/4dwpyBn2Xxk5TPQXPZLFfE5+v1v/Em
         qb2iGeEgvEipKyhJNf0eYtkf05qMEuH9zj4R+kGZ0K2kZ9udpeZNZGBQMPt5bVTrhkdN
         E3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782250037; x=1782854837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8wo5u3B+ZdxxKhZHr6gjYHFiYr35jlEHlBTv44aLrA=;
        b=VHwpJifFBa9l2Kl3DURvdUlXvoo9G16I/1Vh0TcNhpphpNHiShdGdNrYJf/LviXS6z
         ay1qJfa/SofVG7dLP+T1wnCyAAS1f/vOz+XTNq6agxRMJEflHxJ+qZpMF196UzPeQlR7
         9GfxxbeUZ7lPhcG0y5LgBY5FMwe+XJYy+5fPMTZozBTLTk+TPrboQVf+amTTRFA2dMII
         Y28SStBbddnWfgkXt8ZvERF6OvicqgWy60CBiOLxyCKKAjIOkOTrzljbhpJWk7Oe1rgH
         erURDlfwvyboxI0+FiB2tGvCV4OAAL8umWScKVDlUUj2RkUIk0y1MUnR7ymjhvlYoyuv
         DQRQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1KyfjxLrOjryrCixc0I6SROXAFISANRDMacf9vmBn0Tr7CPjnlX7GTK56pZlmaaQ5l8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaFSNM4fQuznZnNAe4fzoXCDEshzE7PaOHAPISNETpmxwB2lV
	h9e1L5g+ORDUHNrlK38velXd/qbS68VdJ5kOc2Eu5uIE/ha393xEtbViD84cIiue3Z9eShDuiBa
	7PYHG8pI1aUupM/pqYzv3vVo2WLojepY=
X-Gm-Gg: AfdE7cmIxito8u8OWcCU2dXts83wtkEO1ESfgcdm2aRBXdnlTTP/IRrTEjg7I+dx45g
	VMr+oGsfcftqZvZjlcsdXUSv6kyZ/gqN4lGW+1Q64+7ZLBMnQ9lgO8vePZoR7KKGh9r5+15/Km7
	LVkORnsoov0wr52KQG3NupRxE44on0ckAoHgVa/pidRScoZEuh0Iz0gm0pQH0P4T3krLOAlKaAX
	QetXV2Ec26nHozC2nYCrlDm41Wa8jHh2G5n91IRXVUWJXZu7fKsw39yNSjtlhdEOQgdvaL6QOBP
	4/jCtINkpJL7ftE3fKmfNrtlI46wLXOxccDe86SoUd5E2X4J3ysPTxWSzv2C4GaT7FlQoA==
X-Received: by 2002:a17:903:2f4e:b0:2c0:bcff:e191 with SMTP id
 d9443c01a7336-2c7e155da25mr6288945ad.36.1782250036987; Tue, 23 Jun 2026
 14:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
 <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-1-2dd0a369e153@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-1-2dd0a369e153@mails.tsinghua.edu.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 14:27:02 -0700
X-Gm-Features: AVVi8CfkdaeGRdVzm1GoBC0ms0FotRchPzMTLAMKpfLmVhtWsC_AuyITHsOw_FI
Message-ID: <CAEf4BzZONoJz3TYdPz_b9K=bZm=+Hyvrayv=4OHU15fqmPu7yA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Preserve dynptr slice lifetime across rdonly_cast
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 1:57=E2=80=AFAM Nuoqi Gui <gnq25@mails.tsinghua.edu=
.cn> wrote:
>
> bpf_rdonly_cast() is an identity operation at runtime and is also fixed
> up to a register move by the verifier. Its verifier return-state setup
> must preserve lifetime metadata that belongs to the source pointer.
>
> On this verifier model, dynptr-slice kfunc returns carry dynptr_id, while
> refcounted dynptr release invalidates aliases by ref_obj_id. Attach the
> ref_obj_id to bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() returns.
> Propagate source id and release metadata through bpf_rdonly_cast().
> For typed rdonly_cast() aliases, keep the source dynptr_id in reg id so
> stack-overwrite invalidation can distinguish the originating dynptr when =
a
> clone keeps the ref alive.
>
> Otherwise, a cast alias can survive bpf_ringbuf_discard_dynptr() and
> remain readable after the dynptr release.
>
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr=
")
> Fixes: a35b9af4ec2c ("bpf: Add a kfunc for generic type cast")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  include/linux/bpf_verifier.h |  5 +++++
>  kernel/bpf/verifier.c        | 36 ++++++++++++++++++++++++++++--------
>  2 files changed, 33 insertions(+), 8 deletions(-)
>

bpf_rdonly_cast() takes *any value*, garbage or not, and returns a
BTF-typed pointer that verifier and BPF JIT generated code makes sure
can never do any harm (it will return zero, if the address is wrong,
etc). There is no issue here and we should not invalidate the result
of bpf_rdonly_cast() just because some dynptr was destroyed.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 185b2aa43a420..0bc4b40e76bd0 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1366,6 +1366,11 @@ struct bpf_kfunc_call_arg_meta {
>                 u32 id;
>                 u32 ref_obj_id;
>         } initialized_dynptr;
> +       struct {
> +               u32 id;
> +               u32 dynptr_id;
> +               u32 ref_obj_id;
> +       } rdonly_cast_src;
>         struct {
>                 u8 spi;
>                 u8 frameno;

[...]
