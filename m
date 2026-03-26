Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D7946C
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483512; cv=pass; b=CYpW9tnPy3xNhGqWgHWgDDtOegWyKEex4D7s1SMTCzffMKO5Er8jq3RISmwRcu4INSdokh8V2Ai5ZjhDxbn+6s2hclt/aa01RUH1Wa3N/iHW11fzZW6e6eceU/H6jmgLjwcNiawuMIp7/5QsynSJYK87+cM+dH1FiyqQQGWM2tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483512; c=relaxed/simple;
	bh=09LknHMDIYhGkY37GVaHUaDbkJkl2uyKia+bWoJPBlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGVZRMna6TOq2ERs2TCgguxaus2tazmBClUWCu+C5XwIO187hEER0mjdEMnkduXF1NXTssHeX1AzDI3gr4s+bCzSpN7/acIV43cSNSn7azJDnLb2q4giHiqbNZ2NGLDnq5y16rlq3bvFvhRxiqE29YI2KkN20yNggkRfAxeEZmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNC/XIXw; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNC/XIXw"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128ebee22caso429731c88.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 17:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774483510; cv=none;
        d=google.com; s=arc-20240605;
        b=HI3jkqcW4E0LfeGMTHSB14owYvpHZuISUqRrMDMObSy1qjfrfoJPLBgDHgA6XWzVjx
         zu29S4NJ1jUVVy0Ya5DEw3rENh/Vd6MzS9V5iL9fblbp0U06fPPHxuackto62TCfHsWL
         f3DNwWmBNae9N2GAwVRLEaXpBBTgsKXyct5U1B9Tb+VU9YOjGtI2a3ij5M7kEFDHV7Ko
         gJnyd4NbQb1Ocb1HSUiE1dxtk47Akrz2bx0XlOyLfhjDZGEYKdcephiGOhwLXKKvVs5S
         YsPiMv6IhmRUgsDZBVE204W/0PXefp53uYDYZkrOGPJSX2Ebr/Ib70yvdO3JZcKR6btr
         FVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOHw2g9ZBT/hyeGef6C4r595s8lKM1vTjJzS7pLxOUk=;
        fh=ROR8Ga0i4Os/aqm1OMY9YxuMuHT8OZei1kPtYYVQy9s=;
        b=GFWTzph796PurQSfGwMarcXVFjv+En5zUFJIb0Qk20YmnGyXVmIfpNUyB9ROBOeBu1
         3RM6mZd2apf3vaN0RgTBvcTuAmTvZms00gLBXs3bQNkgT08Bu2dILLDJwpt0nVch9LQo
         gqXedw+7q6UtnAUB1mrsR+Qm7m8s8rq9z1ZvarqyogSTXUHtAGrYSTCj4cbtey8xwc+a
         Nh5++VzlkTojFBVI7tCslj31uYmQC7rTwQnnBHDuiTVeefyykLTS5AGUa+1C66CQS/hf
         HwCPEo5lpQaxkp1yvRVlpqWGrfzi7zp1x6eqV1MesQ86FNg5b8M5irHpQ9pnr+Q391k1
         PKjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774483510; x=1775088310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOHw2g9ZBT/hyeGef6C4r595s8lKM1vTjJzS7pLxOUk=;
        b=iNC/XIXwBdW6onX6kBucVt5AW0ywZEL/36nFVVNRw0BVP3zttsDfXrkqROE14rpnMI
         5vNplrBt7VlOp7jwsKt4HWW6mV15jqxZLVbK0AMUnmmD7LUeiqNjBusiRvNBI/fwf3Jp
         40ypgmmIVB4vvaFDQa4dRr2aqMt0oje1Yy7u3P5FxoKciEOCYiVrDPXvM6Q1OqaF2oUD
         HCLSQYB13i1gRAoQ6FQ3eu88/j47TDbkY5GWeiuqgYNLF31b8y/FuHAQCsK3Yqhl0n+B
         /Vo6Ae/+L4DWpLGc5aCi+EE4Zrc2+6YVCCilUA3njVOgjs86r6Oe4Alzd5FH9MgNx62w
         DOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774483510; x=1775088310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOHw2g9ZBT/hyeGef6C4r595s8lKM1vTjJzS7pLxOUk=;
        b=XIRhQjVnDEx17Zr6/geT5SYXLVBv7x85nk0Jd0f0AMe++XjQydXgnjfUSP4lcW9ZdY
         eW9RVYFL74w6ZtjHmnzNcwTym27u48NA/lWnCJZXsFotEU8vDmaoKeAzARzj6RcEFy+x
         TA140o45iiZedsB05jKIrJnR0sBjQ19uboYGC9PAuXKfmpEYkFnRM1Pr25OoEJEIIwka
         D3Kqkc3cbK7ZIS9nnj+MrvKHelLX/5NYXN4pHf+o1zrOdkkh+cTbnIemzbEsSPN1r5+z
         JOzQFypKik/yDiAb03TEeByEyZGjrh72t/aaFHHBIZW2PQ/8Xt4bAtVITNCAX1ty+GtR
         a3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXVpvZti9jbF1AJFTSKSAsghZ7imoPsnEl8i6D/1GliLNZ89eHvbiiYQ2siAqU+fKuFKu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmucgWEOHZM6vMZ6KIPM7Ow2KQUJwzAk/grhUb92Dv/uIL7cU
	+LJlxnjfD5ncpFSaNz/zIL3o/N4H7QpsY1IYB2zOe9B3RdhjKZ1Y/3J5s/UMTXCyGtjEATez/cR
	D671XjwYDJrWaTNsvxRWwe4iq5LL843jgq6NDsqxI
X-Gm-Gg: ATEYQzx7OVkJGB8xvArTEJjg38x0n3WDT27rt9dr5Fj/Jo/+j/KeVrMVUNzCWw9aJjj
	6kKKVm6P7Jyx0PE8gqQyzXWoS88+p19Un3p+hjbmeZoE/XfpkPbXd+RDq8j6RraXQbDkZTStfPq
	Zv6tqBd/dN13/WU5EjaBXZieJUdbMmjX5qv4hdxUFShmEgSKBZSC9aWLnhtasAqvpvb3UgPdB9+
	ogDUsXA3f+1lHqYWv9jUCZkeRWSzNLcIC2Rxzju05MiEh6o5zwz0tmMiwjhRWTtX15PF4Doxvxl
	sKF9+9BN8nOz7CMiyjs4EnauAtW2wAQPS2i17zGEcG5lZ/fS3aCyAG9SgWj/F3EjUn6i/w==
X-Received: by 2002:a05:7022:ba5:b0:128:d967:466c with SMTP id
 a92af1059eb24-12a96ed373bmr2822619c88.24.1774483509090; Wed, 25 Mar 2026
 17:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323105510.51990-1-jiayuan.chen@linux.dev> <20260323105510.51990-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260323105510.51990-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 25 Mar 2026 17:04:58 -0700
X-Gm-Features: AaiRm52AA_qp46xzo-zT0U_vZFvFfC3jyAgRm4AjFmf0jkfgDvGqPT6HupdXIf0
Message-ID: <CAAVpQUDpkro_cA-vP1=L=NhAQ4WDPGdm8nVrUBiooiuji3kXow@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
> check the L4 protocol in the IP header. A BPF program can call this kfunc
> on a UDP skb with a valid TCP listener socket, which will succeed and
> attach a TCP reqsk to the UDP skb.
>
> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
> the TCP listener from the reqsk. The UDP code then passes this TCP socket
> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
> it to udp_sock and accesses UDP-specific fields at invalid offsets,
> causing a null pointer dereference and kernel panic:
>
>   BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>   Read of size 4 at addr 0000000000000008 by task test_progs/537
>
>   CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREE=
MPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl (lib/dump_stack.c:123)
>    print_report (mm/kasan/report.c:487)
>    kasan_report (mm/kasan/report.c:597)
>    __kasan_check_read (mm/kasan/shadow.c:32)
>    __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
>    udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
>    udp_queue_rcv_skb (net/ipv4/udp.c:2532)
>    udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
>    __udp4_lib_rcv (net/ipv4/udp.c:2742)
>    udp_rcv (net/ipv4/udp.c:2937)
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>    ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_in=
put.c:242)
>    ip_local_deliver (net/ipv4/ip_input.c:265)
>    __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
>    __netif_receive_skb (net/core/dev.c:6280)
>
> Fix this by checking the IP header's protocol field in
> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
>
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks, the fix looks good.
Just curious how you found this, are you trying to use this
feature for CDN or AI just found it ?


> ---
>  net/core/filter.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..fb975bcce804 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12248,11 +12248,17 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct =
__sk_buff *s, struct sock *sk,
>
>         switch (skb->protocol) {
>         case htons(ETH_P_IP):
> +               if (ip_hdr(skb)->protocol !=3D IPPROTO_TCP)
> +                       return -EINVAL;
> +
>                 ops =3D &tcp_request_sock_ops;
>                 min_mss =3D 536;
>                 break;
>  #if IS_BUILTIN(CONFIG_IPV6)
>         case htons(ETH_P_IPV6):
> +               if (ipv6_hdr(skb)->nexthdr !=3D IPPROTO_TCP)
> +                       return -EINVAL;
> +
>                 ops =3D &tcp6_request_sock_ops;
>                 min_mss =3D IPV6_MIN_MTU - 60;
>                 break;
> --
> 2.43.0
>
