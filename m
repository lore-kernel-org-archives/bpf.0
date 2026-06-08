Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C24134CCF
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883498; cv=pass; b=chjgmm+8+th1CLCapi5yX0zKKjKuileF5Q4ardu9gDH+a2/uH+RK8n055XfBBZro0kGqQUGCYfjuu/f51NnG/9s1Gn35Xr7n1JQ/nUNlE7KKtMPhH/XaS+TRHlZZdaDM0esSWgNKYqCboaX9kHHqgKpY2YJQTvSCiBkmHylTaLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883498; c=relaxed/simple;
	bh=e+TvKjENjJcmqfF3eIqFJC7STajlijhB2h2M3HF7zCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFuFIuMhSPFRWojdsFjr+3+TyzPWbLWz5Go7KzcpqF8jXC0GMPy/GItlDzH+aPpsfkxAt2k/o0jX5tf14LzFk3HxAvd2NVuVkahFEuVuDJLOrzjiqOlcPd0qpA8VBy0+EPBr6wYWv25JmZ6Ujj26Dptx+r1KRLzGAvOjF2j7VVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMex+jDn; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMex+jDn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso23850555e9.2
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 18:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780883496; cv=none;
        d=google.com; s=arc-20240605;
        b=NeDgTwBcG1RmhnKT62y8PaETL1Cew78vO6dhl9W0fWhMqvy+r+JNcYcNdoPT70VRUO
         imo0ynXcMArSNuzR7Jd1qkK5qCvsIiz58N6pIYJIY8rgAsRLFnfKBgFBeVqANKqVbgyv
         N4om2z6BqOpEA1IXr8qejYcZboFoJkZJS3rR4GtYLo3+FbouSl7Vy/OCZYpFzzFxofhg
         RJD5R0Q/FRVUwHDbzRhrN/Nk3oi6RVtfxakXEM4Sp9OUyGqTHSLIaYS0k9+2gyiQTaS8
         Gbsv9KWkxjGsFcZhmWA/VzNmx3mYr8+tHd9KsyJNIdr9fAZKSN/Dn/eInuTH27glhjMW
         pYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLugEH68E+R8mMpiMCt0JD0ZdZa1TLECWrRDF7kqFug=;
        fh=Gzd2+ngsykKd5aBPhJ97vjF3koVpLCRhQbnYyjjLps0=;
        b=OgXY3Ycp7xBF/jRHnUZc4f7FuUevq3bEbLw71wBN4gz3F644u9bWLD1dE6CD+rTiUX
         Y9qnHg0sZYIvlqS0MxWvQ4Kdekva97kWJY2Q7acSd7aBC5w7hdpXf1zPkOOedEBIiidl
         yqdpfU2HxT2pxEaMRhAs2CUTQuQqN7LQ8WDLVStJWtj4p9fzwkSQuoaNAxhKOZvPfKQO
         dxytxNdOgHpyJZ94Wr9ceQGz2o9jVb1AWXuxYLl+kCP2oquD4K8tNz/oeDH7axV5HvCR
         ay6hvTMxFImwBqxFeuzANcuHo/KbXQVPp8/uvqhFxXWVRzTaPyhYPz+jQOKrWF8sVCeJ
         g0bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780883496; x=1781488296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLugEH68E+R8mMpiMCt0JD0ZdZa1TLECWrRDF7kqFug=;
        b=mMex+jDnf1OZIv+b73WQcfFoXh1t09Bu3OlMq70QovdAHwJDSO9L/Wi2q+PcYoXqV2
         oMhQEYs5Q0ToTJbLN1rnzkh6oxeiJmpEGpu2PXe8gDvXLDu4yc9iQIJFV63bBYN/n+Up
         j9sT7kGXQFpSL1LlEfUwS9xT1XkMJBxT/s9nE/GRFp08qiolOqgZdXOM7o2qoT6NXJVM
         xU7Hd2h5QnEEH+HBG1yYh6PxZI1Nmfjmhl629IFwkqHOMcrwZtNAqpOIql8PuxBjd7Si
         x925DaQokCJXx96H2LaFahm6OnkhDWQguLfYsY9Y7mB8xKGZjnU+HCpD2EsYVoNdilKE
         brcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780883496; x=1781488296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLugEH68E+R8mMpiMCt0JD0ZdZa1TLECWrRDF7kqFug=;
        b=ZYrMeKV4vo0uQXfgKg2g8Y4tQiLJlZ1DcJAzDN6hRcNKA7j1upvbsDuIcYc3l6Iz1q
         jVWgA+LkpiX3tYQI90elj1JC6c5chH8hlmjfhcdTXVVrtS3SN343QUOQjJEu7OHoR8pK
         GPrwnHLyRTRQp5qtP1lWTh02KeAge4fKuGUQEOuW+cNRDXqXpXxFWVioadtaLzzpeszD
         HB/3zIjo7v39LVVfdc0Lx6phUc37e7gyIQXWovgGa7fqDycJh83PKfMpbCds1uw41cOG
         6a01zspxBdfTUpkG53T3eqvi2f4CBPGQbQw3VSrL2igCZZ1vwvh/Aq+joHr5wUfdU3az
         Pjrg==
X-Gm-Message-State: AOJu0YxYBEVoJ9nBs6vHECij7cukP9d4v3zCm+V+HfV06E5eJfwJj77X
	JJZL0loSwlcrWfS6Kcp+mlqef+OHf06bMVIGhurrWkqdQgW+ENkm/iezYae+twNwBll4Q6Q1I0U
	opeN2ZV5RLdeFXKDgc4J5BXnMabFW3CI=
X-Gm-Gg: Acq92OEQ2ZwmchHGouEDp3U694tk2PC1MtUztdXimiddh3E6AAJcN8cysJEjTJEuVaz
	J516hx++GhUyIUtxwjVTRXnDeIMuj6Y0mrxm6N/2yz1Beq/bBividmFk7j3ooQo2FEe8pQJu/Fz
	kVjoTXhGFJxlkS78f7DeSwNdTIMeRm1RgnQMXsI5km9PejJJT6Nu6nv9Va57+Oi6gXgfowriaZE
	VSB/jesMOdTdJHUCFjSPs8Qyot7uj//uMo7p9IUBfG2z3FmfVWe/pPDOMMZ7bpqi8JsNmIjRs1H
	sBwtDk7nw8+o6RPOdBqiTbVfPH2NNSisNBpkmAhjVdhOkLj7VBByyESdk5X6o0ueIYK25pRcfBh
	D6T7Zt2LzT8hQ7lBsvIs3UZna+7k+ZIMp2KQ=
X-Received: by 2002:a05:600c:83c6:b0:490:bcc1:4edb with SMTP id
 5b1f17b1804b1-490c25fc11cmr227818475e9.27.1780883495583; Sun, 07 Jun 2026
 18:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com> <20260607-lru_map_spin-v3-1-bcd9332e911b@meta.com>
In-Reply-To: <20260607-lru_map_spin-v3-1-bcd9332e911b@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 7 Jun 2026 18:51:24 -0700
X-Gm-Features: AVVi8CcM6eIw_WoUwFsXYK2Ywk2GIuZ-4kFiw2nCBXnhK0PYuWVL0Z1_EF2xObI
Message-ID: <CAADnVQJ5dZnqM79GG+eaFy44J2qeyJ2hoPys-y-UGO4bKRA50Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Fix NMI/tracepoint re-entry deadlock
 on lru locks
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com, 
	syzbot <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 1:31=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> NMI and tracepoint BPF programs can re-enter the per-CPU or global
> LRU lock that bpf_lru_pop_free()/push_free() already hold on the
> same CPU, AA-deadlocking. Lockdep reports "inconsistent
> {INITIAL USE} -> {IN-NMI}" on &l->lock (syzbot c69a0a2c816716f1e0d5)
> and "possible recursive locking detected" on &loc_l->lock (syzbot
> 18b26edb69b2e19f3b33).
>
> Prior trylock and rqspinlock based fixes (see links) were nacked
> because compromised on reliability.
>
> This patch converts every LRU lock site to rqspinlock_t and adds a
> recovery path for some failure windows to avoid node leaks.
>
> Failure recovery:
>
>  - *_pop_free top-level: return NULL; prealloc_lru_pop() already
>    treats that as no-free-element (-ENOMEM).
>
>  - Cross-CPU steal: skip the victim's locked loc_l, try next CPU.
>
>  - Post-steal local lock fail: publish stolen node to lockless
>    per-CPU free_llist; next pop on this CPU picks it up.
>
>  - push_free fail: mark node pending_free=3D1. __local_list_flush(),
>    __local_list_pop_pending() reclaim the node from pending_list.
>    __bpf_lru_list_shrink_inactive() reclaims the node from inactive
>    list. Nodes from active list are reclaimed by __bpf_lru_list_shrink()
>    or after __bpf_lru_list_rotate_active() demotes it to the inactive.
>
> Fixes: 3a08c2fd7634 ("bpf: LRU List")
> Reported-by: syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc69a0a2c816716f1e0d5
> Reported-by: syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D18b26edb69b2e19f3b33
> Link: https://lore.kernel.org/bpf/CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2=
YS1P09GWT6kQ@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/CAPPBnEZmFA3ab8Uc=3DPEm0bdojZy=3D7T_F5_=
+eyZSHyZR3MBG4Vw@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/20251030030010.95352-1-dongml2@chinatel=
ecom.cn/
> Link: https://lore.kernel.org/bpf/20260119142120.28170-1-leon.hwang@linux=
.dev/
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Applied.
I couldn't believe that sashiko and claude
didn't find anything. Even a small nit.
I even went to read sashiko reasoning.
The list of concerns was quite short.
Maybe it's budgeting the tokens :)
Anyway it looks good to a human too.
