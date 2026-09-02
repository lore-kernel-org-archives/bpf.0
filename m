Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01142B327
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375544; cv=pass; b=KTifVZuaEkMv7c2oS2Vk358fHPRtMvR+iyv3Lf/bHC1MSfe8hm0QqRQPbLWXxgKiPs0aImUECe6dI+BXP9n8jk24mUWN0ycbV3vbqH5E0rTWz342TcvNVa2r+fs0xaBp8ZPxZFTcp5REq0CS70YqGnt/85UF6AyOAYiha6bFe5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375544; c=relaxed/simple;
	bh=PlYDKCubdg2Vpkzfi7BodZEu89/tMEosCuvgSei2oKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRG1VEhDJ1J1tE7NLkPhxmrnhnwAruFod6fA/A2MThVWQ+Xdd0JmNqt8H0oZIM1QV8k+P75uF2Cv3FotfzpsWpSWxgbU2sxKXfTmpal3wk3h9rYW0OhxYhIt97w4PW+Jx3IjfpbBc+DMktbmBCuDk+Nmom2N/uTaYX+dIC81UEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZ704HKh; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZ704HKh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1685077a91.2
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 11:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788375542; cv=none;
        d=google.com; s=arc-20260327;
        b=iUqp9iwRbkDruiNlTmtWs6RAl5Mptt28p/eJOmSaeMHPDkI2Nfk0WtDw4zUXtKvCXE
         uL761UtxEKCojdxqpySJNAM6q97HGwpFd6LlH5wytDFDcZ3nJE2V2KaYXcaeQpZova0c
         TH+qzSl3ZDilYenhjTmDLD/jWFpze2nszvZV8IWN5Ot6K8uxN+NT4SWTZ7vV80EuNAc2
         hfLRdETOnTZmjYsmAvtg7qvvao1uEo5ZUUpJO5ZJfa+y1VPZYvHczKLltua3tedPAfVr
         nQEHJMpz554TZ2O6FRIo+AJzospNYn+QrqYEoLZ8x3PTirPUUakRV2p/uI6ln5LO4iWw
         0v0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dmoGpki0UxRpf1bO8pSrPH7StAL/x6IA9T+AOAVdnbg=;
        fh=BcjAC3PlGYSOI2d5y2wqJei984XuYVuVlF4LnqDXWSQ=;
        b=EKgczyo9ZeUWornlJc5h7SzDsgYEmNuXjQYXBmZjO5uATbysiqsYuXEqNin2V4Vb9d
         xPAoEDWPPb0McKVqcPc9nYUPOGewBqPuFlHRrpT+9b0naOfbgZXeN3DnHmLDhcJPM/ji
         z2or+qtdDBeqlNJJIhHOsAsyS5Z6e/crlmnd7KPitO7wnja780e5B67EvfxgXztaqtC+
         o8mhOLu2MApOWAD5h1M2tFSW1MSDb6bNsNiOjpBwwXB8XRObOz19bMMrvCbmlK9x3oBX
         wHNowcEoqNv3wEWS878hg59otCieZBsQ9UES26OIGw202KtACFsX2pyuKwyCGRyyW4dq
         nlOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788375542; x=1788980342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dmoGpki0UxRpf1bO8pSrPH7StAL/x6IA9T+AOAVdnbg=;
        b=sZ704HKhx08Xe3jzi+Zaf4HAzb94oHM7OCT/EJC/g9kw0xoe0iD44fTOdpKDBbtz9B
         vqjuo87RU9LmGZnBILrPOhNnTpb1zUD2PpMO/04Q3CDAnZpaK+xmIBwB1glgbTFq0DPY
         tQsPK9ISA32zTI2hOc36tsNU0daYGnWvIne/cQVTNQ8KWaXZGU3MkMXVXMCb168LaIsQ
         XB2Z1aGb5ZKA9/7F+gC7OV16C6gdIG4cAtsTsqUzlkN7pjjgO7UjEO3XwUL1/lRo/+Ar
         2yVUhJcIt5GX1YKpttl0HK8F86Bfh3N755fe5u395EWx4O37EXxMyATLg2TTkBjfPuPD
         s2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375542; x=1788980342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmoGpki0UxRpf1bO8pSrPH7StAL/x6IA9T+AOAVdnbg=;
        b=Gp5DNo/Rl7lP8x+1h5tmFyqY/E1NSS+5vwHCt+6PEqdhoXAZDKvDUkmIvE9UCDKdlo
         ud4cOiCW2wMFBnz4g6GNItdh+QznKrtBL0ZNCJcHet/TfELMobb0j7vfrltvkyxVup7J
         WE5pm+itB2t+g3ILM3XKj9BP54TZR3fqt5SB8wcNA/jRz0mD4q/GXMQBIaoqwq9sOFOu
         Boaf2wq+MrkKco8O0/p3nFwFz3Kc34G54zaQvsO0m6nZwRkI0SgN3vm2csH/b4xTLDzJ
         6unMKa+mWEFxT40pX6VJV70rh2gz9VDZ2V5io70L9qRL90CyT+D6nbT5vwvTqPpUR0p2
         US5g==
X-Forwarded-Encrypted: i=1; AKwUvBw4QxVA0CpmqgJ0gW0027ZU2iTS+vxAtL/+59YOnQI6I0M6M6BvwnK0amSYVt4H5zJslg0=@vger.kernel.org
X-Gm-Message-State: AFuF++mniTFqQ1exrK9J1TNhG1hLCC5G5dkNEO7GoCHpvh3ooWkPxyh+
	PbnVFX/vlpXQzdHWCm0aGwZZqyE2RKhSz1vq6pXENBV534iKZQVedefViad2U+Bt9NQLhWhK+Nc
	h9LExbd5iCUOfa4oM6OdjzDsptUfKutZu0YQXH81s
X-Gm-Gg: AYBFou2VGscZCbsfXVBGCGLa0YINeoDxklhfP85srEtNORB9RUUd+BWpGt2056qoRtv
	TB69bWoP8Uye6M8H5HSsurVWaS9d7UW5ocJReNYDFd+0D8h+PMQs/8E80YxP4cJHIPsuTxxl2yN
	IEpD2xOi/OsbElG5JRJ+QkEqEUUczhTzp44mPq+6TJ14xb0UfRRmHMryLnbiJR+4EHNLeAAEu90
	WNm1gjxHV20QTFDzds8r0ItmVajAdEXn5LD5HfszyaXHMPywThhp4ZNKdJNud1qCn/ADrBLAKY+
	qcuRVKgOcLBx01Kb/po0DNJVOGS1G0PCbDRgZnPJGnpd09AtfYykQzTgW3XRvqW3vccUt9k6tHI
	0RIrH4nLmeZ1gCiEaM6VAW1y1Rj6oBwsVMpW/lL6ArgeyKxdQVqYSoY0NDX/YYAVBbXDS9fTPqu
	ItSzo+qAMg/A3t8g==
X-Received: by 2002:a17:90b:4486:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39aee2842ccmr8983606a91.24.1788375541361; Wed, 02 Sep 2026
 11:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
In-Reply-To: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 11:58:49 -0700
X-Gm-Features: AcwNN1UmGcF2VNT2UTQBCVlO5BUit75iZ8LYXzV1SdkMAusKeGl59FM9vhE-5n8
Message-ID: <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Joe Stringer <joe@wand.net.nz>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:55=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> This is a follow-up to Sashiko's report[1].
>
> Several BPF socket helpers acquire a socket reference only when
> sk_is_refcounted() =3D=3D true, and release it, independently, by
> re-evaluating sk_is_refcounted() again at the time the release runs. TCP
> connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established socket.

Due to several bug reports, we are now inclined to forbid the
buggy transformation.
https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguRo1Z_4FxO=
=3D02KLmwmQ@mail.gmail.com/


> If that happens while a reference is outstanding, the release side sees
> sk_is_refcounted() =3D=3D false and skips the put; the socket is leaked.
>
> unreferenced object 0xffff88811617ce00 (size 3200):
>   comm "softirq", pid 0, jiffies 4294848512
>   hex dump (first 32 bytes):
>     7f 00 00 01 7f 00 00 01 4d 43 02 f6 00 00 00 00  ........MC......
>     02 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
>   backtrace (crc fb5bd4c8):
>     kmem_cache_alloc_noprof+0x53e/0x640
>     sk_prot_alloc+0x69/0x240
>     sk_clone+0x79/0x1230
>     inet_csk_clone_lock+0x30/0x760
>     tcp_create_openreq_child+0x34/0x2750
>     tcp_v4_syn_recv_sock+0x12e/0x1080
>     tcp_check_req+0x447/0x2310
>     tcp_v4_rcv+0x1026/0x3c90
>     ip_protocol_deliver_rcu+0x93/0x340
>     ip_local_deliver_finish+0x356/0x5c0
>     ip_local_deliver+0x184/0x4a0
>     ip_rcv+0x4f4/0x5b0
>     __netif_receive_skb_one_core+0x153/0x1b0
>     process_backlog+0x28d/0x1190
>     __napi_poll+0xab/0x520
>     net_rx_action+0x3f0/0xca0
>
> [1]: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.=
org/
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v3:
> - Add a fix for TC bpf_sk_assign() (patch #2)
> - Clean up commit messages
> - Non-fixes went to bpf-next: https://lore.kernel.org/bpf/20260813-sockma=
p-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co/
> - Link to v2: https://patch.msgid.link/20260803-sockmap-lookup-tcp-leak-v=
2-0-306e025bfe66@rbox.co
>
> Changes in v2:
> - Defer "Use sock_hold() instead of refcount_inc_not_zero() in lookup" to
>   bpf-next [John]
> - Fix comment style [Sashiko]
> - Link to v1: https://patch.msgid.link/20260723-sockmap-lookup-tcp-leak-v=
1-0-1bbdc58ce514@rbox.co
>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Eduard Zingerman <eddyz87@gmail.com>
> To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yonghong.song@linux.dev>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Emil Tsalapatis <emil@etsalapatis.com>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: Kuniyuki Iwashima <kuniyu@google.com>
> To: Willem de Bruijn <willemb@google.com>
> To: Jakub Sitnicki <jakub@cloudflare.com>
> To: Jiayuan Chen <jiayuan.chen@linux.dev>
> To: Joe Stringer <joe@wand.net.nz>
> To: Ihor Solodrai <ihor.solodrai@linux.dev>
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> To: Florian Westphal <fw@strlen.de>
> To: Phil Sutter <phil@nwl.cc>
> Cc: bpf@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> Cc: coreteam@netfilter.org
>
> ---
> Michal Luczaj (2):
>       bpf: Unconditionally take socket references in lookup helpers
>       bpf: Fix reference leak in bpf_sk_assign()
>
>  include/net/inet6_hashtables.h |  9 ++++----
>  include/net/inet_hashtables.h  |  9 ++++----
>  include/net/request_sock.h     |  2 +-
>  include/net/sock.h             | 11 ++++++++++
>  net/core/filter.c              | 49 +++++++++++++++++++++++++++++-------=
------
>  net/core/sock_map.c            |  8 ++-----
>  net/netfilter/nf_queue.c       | 18 ++++++++--------
>  7 files changed, 67 insertions(+), 39 deletions(-)
> ---
> base-commit: ce6b9e5dd873de532cd924e2abc928220cdc2738
> change-id: 20260628-sockmap-lookup-tcp-leak-bdaba3e083c5
>
> Best regards,
> --
> Michal Luczaj <mhal@rbox.co>
>
