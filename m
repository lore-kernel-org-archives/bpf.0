Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624A4F55C1
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328273; cv=pass; b=p45BDHRfs7CzMkzo594Eallbpp/wOGVmFgfj61h3E8IBgQ+k3slugcWetZ0gWIGBiBwQgW04dUKPVyVNMxpui70X6AhgJpNwtYwaE/x3AxI5i/81NbfKtUWjfNkxK8wZAaqFFo2wL0JsMtZ8Dm5tjIvwe5wjtGijhcSwcJMzqpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328273; c=relaxed/simple;
	bh=CzPyoKkLuN6YdefgiA4a4Y9SQlN8BqOchdi34oZRDM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDvCRrJasGzPUKBuSeVFDi7BbIF0SN+sxZjXGwM1HeCb4/367rwrxD9pm8qIyZFEgzRyBweSYV3obkj+YiK6NMOXeirqEZ0tjsfiDwSVK9pq7jeCJ/0sYvxGOWymFvMQdIkIxiV9PJhusSS0ZjpXdZoQ9437QE6vj2CalgN7Oz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRVDIVqK; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRVDIVqK"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-81c5aac8478so701082a34.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 16:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328268; cv=none;
        d=google.com; s=arc-20260327;
        b=kRsHVuqipJ/tNqViq3im1msYfp6lmPDiByN4rYO1saNs2fZqLVpP/MnreLeK5iVbCW
         l2IJ6Lf68W9QSmy+4b0t9ekDT0BBeU8jxkcBoS/1K+zr8mYSS422SDUQgr1Ahq115vnS
         5vDSeZHJFbXnb3UfNwTBcKTw1F5oeS94EilUr/DAIYbqr6BebPkzFRzJHWJ29zyS1k1k
         4SXHZ6+gLto5ZCoOG/nmhOMSvsY+NJrXgLd3JEN7TIDvanMIRs37fmBxPp/gWx9CVKEY
         ZuJwNHX+eQmY/2GdUSgxrh+EhkEInkOcOQICbGm+uQUJzuALlSpCznO7LBx17jFBU+3j
         oNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVgHFCxZmWjJoybenBY5+/9cQs47rZgohH/Njdib7q0=;
        fh=dR8TGPtFuTMkpPy6DHFEVUcZici+/hCtHSr63Sb1GM8=;
        b=Tu8u+1hJ9YSMTQ+wUQ29h1nq4pSKV52ez+wtz8oFMCJ3Vy0/ZVkB5hVdnOYRO1qGyX
         Tg0RhIbMad2sG2pEESao4bXtEDfBV7tuw43WbIx2BSK5KFm6sBsfwq9KOk8ag1GV5I8T
         dKVhGWd/viJdvYMdI5bPWAHqUX4dginLRACPXl2SoD+KhhbDyPVYnHXKFua6yPAU7UvH
         g2nZykLZaw/o5BD/8dqsP0Ca7Lrw9MdbrUcwvI5lMb85K76wccEcAOg8OnXu2APniOrq
         mx5oBf8qH7xxZQh51I2gNLnZMn0pyQ4dx/gBMZXrpYeRSHUqaLq5dHqN+hGZT8N0mftt
         Hlvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328268; x=1791933068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVgHFCxZmWjJoybenBY5+/9cQs47rZgohH/Njdib7q0=;
        b=pRVDIVqKqtWtMXWjxjzAlIUtsZodi8wRQAKYbkSZyH166rRx8omdAC4N2rvXE0BtZc
         pVEMLk03XY/MayzCBTKticARmvnpFEBTbXnnrDdlbIv/duZMY4F2Oi0GWVA7MNb3Zg+m
         lee0jZ3u3ygWk7PDFeY5g3XzJwC34C6Np3lJHl8pc51IdyNRsVMXh7O6IY3BqP1ecscH
         5ewj/+taVR0tdr1OSCjTyhYhs2kFFUyFVDT5T77q3HgeFFwn98qmaBLQrsGFZO0qpglb
         M9hw3x9AnIUNTnNEaIoGt+kWoVPxAnkFO33ESqYmwUljYHNVR+DwVCJXIlDPYOcHPxwW
         WIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328268; x=1791933068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVgHFCxZmWjJoybenBY5+/9cQs47rZgohH/Njdib7q0=;
        b=BHAniYootopAqw/GgKy8r0vpIKVN4FNw9ak/Z0y8m024kLY/oDoU2J9RPfvulieYb+
         SpPzEnW6Zy4BdktJujZb0qFkn8JTDL/5CCb1qxDzvt0nJYQWAtJAFZEkLMnEMXClPaDg
         9p2BOym4k6XPnkKDP6dThm4F6tXubCx7oqyIcbAD/DUAvvdnTxQCewEcvX4YOTheE7kZ
         z3ErYiMbLY1omjwAGcYBJsSO/yI6HdARsXHk+gIO3vabi1IFPBSeRMUtIYG6F9SG2jyI
         rwLWhAPEvWVx7krSGlqVYNF7ntu4mAmf2BX6zQO35bs06Ymqha22YsTO7m8DykwumLru
         QZRg==
X-Forwarded-Encrypted: i=1; AKwUvBwp6+BgIBGOXalM/15IgDO6TcmXg0OcSrBqbFdu/Q82qWFabCwXdAcBglHe5w1BntbXhgI=@vger.kernel.org
X-Gm-Message-State: AFuF++lfd6zP+EkVnUhkl8XNVu18yrqdJzlyekeooL+3bM+lxlI3Mssr
	Lc5wFtexR2jx4vHni1L74pp+maHdKFIkuf5aTZQMCxdnlpRxf5Bx/MvzoFMDyp3/BxU0ziW/CHs
	WvwSQSUwJx/+DFt5SZ5fg+LkDvuQklkU=
X-Gm-Gg: AYBFou1hraQ21vO4+mo3nnNic7pyGyO2jU0mS2MB1TNIN3yAf3YmD/vzb0pSzAg2Sqn
	vRvCEPeAMIMipd3SzVIbcStSXbOkCOS7t93+vOpmceHqCX0J/v2XSxOyrY2x+WiPbTpECmRlcRM
	owyTCK3/0BA54MrcuLCD7zrwy+bNGn8kEDv7aDa47U3/+yPvlahTzp5Xuww8YQJox0AOe5x+0Ky
	l0AD8kOUOxNcWtnP6S7/TzWH5s52vd0Wb/47Nq9XhW0c3Fe5vS8vJEJfi2THZslMvYdajSYCTMA
	zc+v4oUhqVeeiogwhPabW1X1cN8NxrbG8X8OK3XcCommiGA98EHyMZE=
X-Received: by 2002:a05:6808:11d1:b0:4f7:d324:bc5e with SMTP id
 5614622812f47-4fc481ca2efmr737042b6e.58.1791328268160; Tue, 06 Oct 2026
 16:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-3-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-3-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:10:56 -0700
X-Gm-Features: AclHuK_mNUq7Eu5hk01x19F_7PxCtz2jLajaGocqAK8srCVAPazrb5T94X-c_gg
Message-ID: <CAMB2axNu70HiFa+DAkia7oKhZ4ykKyV9bu51OwcPwoyo=duz3g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/10] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The legacy SOCK_OPS guards some hooks with a per-socket flag,
> tp->bpf_sock_ops_cb_flags.
>
> In contrast, bpf_tcp_ops was initially designed without per-socket
> flags so that users can simply define only the callbacks they need.
>
> However, it turned out that even attaching a bpf_tcp_ops with a NULL
> callback incurs measurable overhead in the fast path. [0]
>
> We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> 1 bit left for a new opt-in callback, while not all of the 7 existing
> opt-in hooks are in the fast path and really need a flag guard.
>
> Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> update it, both of which require sock_owned_by_me(sk):
>
>   * bpf_sock_ops_cb_flags_set()
>   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
>
> Both helpers only overwrite the field, which leads to reading and
> modifying the flags in the BPF prog and then writing them back
> via the helper.  This prevents use from the fast path (tc or
> cgroup_skb) hooks where bh_lock_sock() alone cannot prevent races
> with process context.
>
> Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
> tcp_sock_read_txrx cacheline group, along with a new kfunc,
> bpf_tcp_ops_set_flags().
>
> bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
> disable and updates tp->bpf_tcp_ops_flags atomically via
> try_cmpxchg() without relying on lock_sock().
>
> The kfunc is exposed to bpf_tcp_ops, BPF_PROG_TYPE_CGROUP_SOCKOPT,
> and BPF_PROG_TYPE_CGROUP_SKB.
>
> The first argument is struct tcp_sock * so that bpf_tcp_sock() etc
> is required for cgroup hooks, but not for bpf_tcp_ops where struct
> sock * is promoted to struct tcp_sock * automatically.
>
> The fast-path callbacks will be guarded by the new flags in a later
> patch after updating the existing selftest to avoid breaking bisection.
>
> Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX8=
32wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
