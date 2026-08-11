Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728412C0F6D
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422293; cv=pass; b=e42joiJpGo2LinoZcfT0rzbIUmfW1Q01nBY/ePdSnz5t5zR39Uohzfvdy6FQEbvX0xFCRrd7qq0MUDQbxlwZZjPSCR8ulZPFUU26BH1cw+ub9MhCCY4HFtl/l6cvLdpTGQpQGqvbCQiPq8/h7WWPhEBX3HqTkRSCAHQf1sdN2pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422293; c=relaxed/simple;
	bh=EzvUFlURMLQZ+fBEOT0Pq3pG8BaYy8JHgkr/L4UBR7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBtvN9Hg0AKhHGdrL/Ic/EQ45PZdi1p5fU5O18qUDqcGeXKXsMaBhz/aA8P2BPWwIABttK9cS5bC4dSpmYkvCSVcizPpPy+Ta5BUGgqM3N0XxeXPt1fSXmKTfC8064vztIaRPmThrk6C/xM7akHv6isxZD7Xle07dB+rQ+ZSsPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOaP0fYn; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOaP0fYn"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca80d708489so373584a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786422291; cv=none;
        d=google.com; s=arc-20260327;
        b=a9rrfp2rgbK4Xg+d3xTVyZDK1N9vaZfWXUmlzJNAygoDu1ANh+i0p2C6ZIiLnvfTiC
         V1oGuFSKj3kv9FHhSD0BcZ9gIikBDnm61ECvA1/lFMhsRmjMNgJZ52hhR73HTeNfDDdU
         77PmBjVRCigNFCgSEroCZcri2YnucUqbUG2hpIdy+gkk8DgqhRpVL6w3PSEyQTbqXdzi
         QoAmDUsght3wxQ/4G3Q6TE0CyZH0GJS7i3ZV4s8XiQa1MPzanGXhFT6RgXPwWvETup7l
         WP2tI8JJo9oHX+r/UpyjJb2hBlTZD8/Vbewco1woJfDO/TFZ8k29k4E60aUqAWy5Xbk4
         5TVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lbSuihJxeCYnPcZWXMCuT0WQeDCqf/LX/8H2mE8P9Cc=;
        fh=tIft1W+1yI1ewJUuHlHaCzqxmAWp5pHc60UEWLQNmE4=;
        b=nw/5hE2w2/VFFGhBAFZJa58S+463zLrDk5Y7R9hUPu7ZZNpnxYUUaA/Wg51yYroT4t
         H+t7jpwWsK9SsBG/GvrTXxX3Sn7fHZ1e52S0m7cOdAo964B6xWDy0Y5bAX6TGqilpgmw
         Ey5mjIJzjryKl3Wv6wiFEOKFAhwnjujr74sQZ99sPidSu/+vvPB6St/dUMFSvS5C5aGa
         1Z7BxOrqGrUZPGIs3ES2n9xBcyhbPHDV6MesNqQb1h4hWNeKwtHaxEe0a5ee51WwsojO
         p9ahNaTuUPKvnRAOR1gAt3QYY8jAtPpccdNhst9tktCmV8Jguv5KngQ0jqwQvG4V+lrr
         z3KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786422291; x=1787027091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lbSuihJxeCYnPcZWXMCuT0WQeDCqf/LX/8H2mE8P9Cc=;
        b=gOaP0fYnMdvsBH/boaZCHMoO2/ClJh5xid8GV3OPsPPqvuXHv6vzT4x2a1KuMkBqsI
         AbneQfI+jS7nyQsX0HyLB24kad+OQ/mYeeOiSiUe3oK3VLaxn5NoWBJjYU3eMol7R/yR
         vjq9VYMmMx2n2pJn6Rb2evxI/g1V6z4qi8Q+qel2hFQEohWf3BgMw4YRmytev9DhYPzv
         AZIoUDnO0wlLrw/FDBihb4OOQSHgy9hr7BbnxhwN8WHlNywpo9/QeQfVfjVMAdABk34z
         TrLV09aj5vH3y2l+9CYVvhoPwZ4657uMtP2I0p+nwBlvolybdxrvPyRUhtV3/R9cIGtl
         4qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786422291; x=1787027091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbSuihJxeCYnPcZWXMCuT0WQeDCqf/LX/8H2mE8P9Cc=;
        b=pB9nR5q9VMtsmS88hSsBeYqQlT+NNmAx/5wzl/qalMcav7rnK8VKr7x3LAlTuor6P/
         Wuy1n6H32hSyiK6osQIj2LLBQj9fC+rxRgFwNY8uI5nzEbac/ceHqBdzTVrZ4EL3rsRG
         2VGx/Mph6Qk56CVwH65JBuxhzLx3MyvS+CTv5qxGIqmlZSZ2hBcJuEE2Dn5S6a2N1bLu
         5NzXfoty9DPamxm/XHFvMKFCqIIvRzFwRrZ/JPzm+2A/nn/vC7BnidazdEArQtY8R04k
         DP/HcmrbltnxmI9foVVX7d+rK7mKp1jO8cIuIT4PUi3RYlMfZlQ2NbKKpiDln0qTuXl0
         /npQ==
X-Gm-Message-State: AOJu0Yx6mXFA074RN6AvGR4SDEsMuQv0COqebmmP47GkOwzGIlRkoee9
	dnPPBjQIAWfPgNvwWuJMrN3SjyOablwM1JDC1HxwTjsAzpMvtZRge8NhZvdR7sIOpmQRdmfBB2z
	NhB44i1KOfSsFimzqpckjFs2t3B56LPgUPxw1THdI
X-Gm-Gg: AR+sD103mbxOW1UIVOukFqlrCA4/U29fPzlZRzY4vOJxhxTsC48Ryz6Ztcl9p9WLpFP
	jIWIiJ2vRDcR1FBpO4dbj7dAE0zJ5JZYoSVizTh0sMgxEYAtv3TdiVMyF/Eay/z+ONmelHLbsJd
	A0fQcetcppj2pwOJEVlFVuSjyImgwBn+cJxlstBbEMhUvnZxqAd8/WVWsWzsdcx+bs70UNxh+00
	fyM85GdPLH56ZgmD2ern6Z39avr+wd0nWOeOb4r5yuP5s3cPd/1aVbsqkmViuHdsDr+9KcK0Ct7
	PeZ8w6R35upCApdHlrXbRHLU+1dlmRAA0YVych1OuUkIkw+D/kRjShTJEXIdeEoSIhSq0mEvj3a
	Jzm5GuaSunz9UANUEI1dwbfA3xJnutLrARlf2KUC/QcYVmYyEwBL+qDpcwCrjb8gJgj7/eMCoi0
	mOVmgMfsXNUQdB3A==
X-Received: by 2002:a05:6a21:1509:b0:3c8:e304:99d0 with SMTP id
 adf61e73a8af0-3cc2d888431mr616023637.0.1786422290015; Mon, 10 Aug 2026
 21:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807171532.125149-1-mahe.tardy@gmail.com> <20260807171532.125149-3-mahe.tardy@gmail.com>
In-Reply-To: <20260807171532.125149-3-mahe.tardy@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 10 Aug 2026 21:24:38 -0700
X-Gm-Features: AUfX_myI3UwvesCGcKgSNf5lvRKRkuds-iB5XIhn2cJP8QphPeYwzAknZgeDLQc
Message-ID: <CAAVpQUDeiDOQa6i03juWO64vyz0TnFH6mqB_vNo0ZeqA0-otxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com, 
	ameryhung@gmail.com, memxor@gmail.com, jiayuan.chen@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:15=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
>
> The API consists of five kfuncs:
>
>   bpf_ksock_create()   - Create a socket (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
>
> The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
> SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
> bpf_ksock_send can be called from SYSCALL and LSM programs.
>
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
>
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
>
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus, the bpf_ksock_send() kfunc, which
> is exposed to LSM progs has a verifier filter protection to avoid
> recursion so that the whole bpf_kfunc_set kfunc set cannot be called in
> a program attached to security_socket_sendmsg(). Also, because of the
> LSM checks, we prevent the use of the kfuncs from asynchronous workqueue
> as the current value would then be invalid.
>
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/linux/bpf_ksock.h |  36 ++++
>  kernel/bpf/verifier.c     |   3 +
>  net/core/Makefile         |   3 +
>  net/core/bpf_ksock.c      | 335 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 377 insertions(+)
>  create mode 100644 include/linux/bpf_ksock.h
>  create mode 100644 net/core/bpf_ksock.c
>
> diff --git a/include/linux/bpf_ksock.h b/include/linux/bpf_ksock.h
> new file mode 100644
> index 000000000000..cb387fb75e43
> --- /dev/null
> +++ b/include/linux/bpf_ksock.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 Isovalent */
> +
> +#ifndef _BPF_KSOCK_H
> +#define _BPF_KSOCK_H
> +
> +#include <linux/types.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +
> +/**
> + * struct bpf_ksock_create_opts - BPF kernel socket creation parameters
> + * @family:    Address family: AF_INET or AF_INET6.
> + * @type:      Socket type: only SOCK_DGRAM supported for now.
> + * @protocol:  Protocol number (e.g. IPPROTO_UDP), or 0 for the default =
protocol
> + *             of the given type.
> + * @reserved:  Must be zero. Reserved for future use.
> + */
> +struct bpf_ksock_create_opts {
> +       __u8 family;
> +       __u8 type;
> +       __u8 protocol;
> +       __u8 reserved;
> +};
> +
> +/**
> + * union bpf_ksock_addr - IPv4 or IPv6 socket address
> + * @sin: IPv4 socket address.
> + * @sin6: IPv6 socket address.
> + */
> +union bpf_ksock_addr {
> +       struct sockaddr_in sin;
> +       struct sockaddr_in6 sin6;
> +};
> +
> +#endif /* _BPF_KSOCK_H */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce..4f3de0a4b0c1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4445,6 +4445,9 @@ BTF_ID(struct, task_struct)
>  #ifdef CONFIG_CRYPTO
>  BTF_ID(struct, bpf_crypto_ctx)
>  #endif
> +#ifdef CONFIG_INET
> +BTF_ID(struct, bpf_ksock)
> +#endif
>  BTF_SET_END(rcu_protected_types)
>
>  static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
> diff --git a/net/core/Makefile b/net/core/Makefile
> index b3fdcb4e355f..a9295b785901 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -44,6 +44,9 @@ obj-$(CONFIG_FAILOVER) +=3D failover.o
>  obj-$(CONFIG_NET_SOCK_MSG) +=3D skmsg.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D sock_map.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_sk_storage.o
> +ifneq ($(CONFIG_INET),)
> +obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_ksock.o
> +endif
>  obj-$(CONFIG_OF)       +=3D of_net.o
>  obj-$(CONFIG_NET_TEST) +=3D net_test.o
>  obj-$(CONFIG_NET_DEVMEM) +=3D devmem.o
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> new file mode 100644
> index 000000000000..8a4f0150a0a4
> --- /dev/null
> +++ b/net/core/bpf_ksock.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include <linux/bpf.h>
> +#include <linux/bpf_ksock.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/net.h>
> +#include <linux/refcount.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/socket.h>
> +#include <linux/unaligned.h>
> +#include <linux/workqueue.h>
> +#include <linux/ip.h>
> +#include <net/sock.h>
> +
> +/**
> + * struct bpf_ksock - refcounted BPF kernel socket context
> + * @sock:      The underlying kernel socket.
> + * @usage:     Reference counter.
> + * @rwork:     RCU work for deferred cleanup (sock_release may sleep).
> + */
> +struct bpf_ksock {
> +       struct socket *sock;
> +       refcount_t usage;
> +       struct rcu_work rwork;
> +};
> +
> +static void ksock_release_work_fn(struct work_struct *work)
> +{
> +       struct bpf_ksock *ks =3D
> +               container_of(to_rcu_work(work), struct bpf_ksock, rwork);

nit: if you need respin:

struct bpf_ksock *ks;

ks =3D container_of(to_rcu_work(work), struct bpf_ksock, rwork);

> +
> +       sock_release(ks->sock);
> +       kfree(ks);
> +}
> +
> +static bool bpf_ksock_has_user_task_context(void)
> +{
> +       /*
> +        * Task work can run from do_exit() after exit_nsproxy_namespaces=
()
> +        * cleared current->nsproxy, while current is still not a kthread=
.
> +        */
> +       return !(current->flags & PF_KTHREAD) && current->nsproxy;
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_ksock_create() - Create a BPF kernel socket.
> + *
> + * Allocates and creates a kernel socket.
> + *
> + * The returned context must either be stored in a map as a kptr, or
> + * freed with bpf_ksock_release().
> + *
> + * This function may sleep (sock_create), so it can only be used
> + * in sleepable BPF programs (SYSCALL).
> + * It cannot be called from a BPF workqueue callback because that callba=
ck
> + * does not retain the invoking task's namespace or security context.
> + *
> + * @opts:      Pointer to struct bpf_ksock_create_opts with socket param=
eters.
> + * @opts__sz:  Size of the opts struct.
> + * @err__uninit:       Integer to store error code when NULL is returned=
.
> + */
> +__bpf_kfunc struct bpf_ksock *
> +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> +                int *err__uninit)
> +{
> +       struct bpf_ksock_create_opts opts_copy;
> +       struct bpf_ksock *ks;
> +       int err;
> +
> +       /*
> +        * sock_create() derives the network namespace, credentials, and =
cgroup
> +        * from current. Kernel threads, including BPF workqueue callback=
s, do
> +        * not carry the context of the task that invoked the BPF program=
.
> +        */
> +       if (!bpf_ksock_has_user_task_context()) {
> +               err =3D -EOPNOTSUPP;
> +               goto err_out;
> +       }
> +
> +       if (!opts || opts__sz !=3D sizeof(struct bpf_ksock_create_opts)) =
{
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       opts_copy =3D (struct bpf_ksock_create_opts){
> +               .family =3D READ_ONCE(opts->family),

I'm not sure if we really want to care about such an arch, but
since you mentioned unaligned access in bpf_ksock_connect(),
is READ_OCNE() safe here ?


> +               .type =3D READ_ONCE(opts->type),
> +               .protocol =3D READ_ONCE(opts->protocol),
> +               .reserved =3D READ_ONCE(opts->reserved),
> +       };
> +
> +       if (opts_copy.reserved) {
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       if (opts_copy.family !=3D AF_INET && opts_copy.family !=3D AF_INE=
T6) {
> +               err =3D -EAFNOSUPPORT;
> +               goto err_out;
> +       }
> +
> +       if (opts_copy.type !=3D SOCK_DGRAM) {
> +               err =3D -EPROTONOSUPPORT;
> +               goto err_out;
> +       }
> +
> +       if (opts_copy.protocol !=3D IPPROTO_UDP && opts_copy.protocol !=
=3D 0) {
> +               err =3D -EPROTONOSUPPORT;
> +               goto err_out;
> +       }
> +
> +       ks =3D kzalloc_obj(*ks);
> +       if (!ks) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       /*
> +        * Use the normal current-task socket path so LSM/cgroup policy,
> +        * socket labels, and the active netns reference match a socket(2=
)
> +        * created by the BPF program's caller.
> +        */
> +       err =3D sock_create(opts_copy.family, opts_copy.type, opts_copy.p=
rotocol,
> +                         &ks->sock);
> +       if (err)
> +               goto err_free;
> +
> +       ks->sock->sk->sk_rcvbuf =3D SOCK_MIN_RCVBUF;
> +       ks->sock->sk->sk_userlocks |=3D SOCK_RCVBUF_LOCK;
> +
> +       refcount_set(&ks->usage, 1);
> +       put_unaligned(0, err__uninit);
> +       return ks;
> +
> +err_free:
> +       kfree(ks);
> +err_out:
> +       put_unaligned(err, err__uninit);
> +       return NULL;
> +}
> +
> +/**
> + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address=
.
> + * @ks:                The BPF kernel socket context.
> + * @addr:      Pointer to an IPv4 or IPv6 socket address.
> + * @addr__sz:  Size of the address union.
> + *
> + * Connects the socket to the specified remote address and port.
> + *
> + * This function may sleep while connecting the socket, so it can only b=
e used
> + * in sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> +                                 const union bpf_ksock_addr *addr,
> +                                 u32 addr__sz)
> +{
> +       struct sockaddr_storage sa;
> +       int addrlen;
> +
> +       if (!bpf_ksock_has_user_task_context())
> +               return -EOPNOTSUPP;
> +
> +       if (!addr || addr__sz !=3D sizeof(*addr))
> +               return -EINVAL;
> +
> +       /* Kfunc memory arguments may be unaligned. */
> +       memcpy(&sa, addr, sizeof(*addr));
> +
> +       switch (sa.ss_family) {
> +       case AF_INET:
> +               addrlen =3D sizeof(struct sockaddr_in);
> +               break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       case AF_INET6:
> +               addrlen =3D sizeof(struct sockaddr_in6);
> +               break;
> +#endif
> +       default:
> +               return -EAFNOSUPPORT;
> +       }
> +
> +       return connect_socket(ks->sock, &sa, addrlen, 0);
> +}
> +
> +/**
> + * bpf_ksock_acquire() - Acquire a reference to a BPF kernel socket.
> + * @ks:        The BPF kernel socket context to acquire. Must be a
> + *     trusted pointer (e.g. RCU-protected kptr from a map).
> + *
> + * The acquired context must either be stored in a map as a kptr, or
> + * freed with bpf_ksock_release().
> + */
> +__bpf_kfunc struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks)
> +{
> +       if (!refcount_inc_not_zero(&ks->usage))
> +               return NULL;
> +       return ks;
> +}
> +
> +/**
> + * bpf_ksock_release() - Release a BPF kernel socket.
> + * @ks:        The BPF kernel socket context to release.
> + *
> + * When the final reference is released, the socket is cleaned up via
> + * queue_rcu_work() (since sock_release may sleep).
> + */
> +__bpf_kfunc void bpf_ksock_release(struct bpf_ksock *ks)
> +{
> +       if (refcount_dec_and_test(&ks->usage)) {
> +               INIT_RCU_WORK(&ks->rwork, ksock_release_work_fn);
> +               queue_rcu_work(system_dfl_wq, &ks->rwork);
> +       }
> +}
> +
> +__bpf_kfunc void bpf_ksock_release_dtor(void *ks)
> +{
> +       bpf_ksock_release(ks);
> +}
> +CFI_NOSEAL(bpf_ksock_release_dtor);
> +
> +/**
> + * bpf_ksock_send() - Send data through a BPF kernel socket.
> + * @ks:                The BPF kernel socket context. Must be an acquire=
d reference.
> + * @data:      Pointer to the data to send.
> + * @data__sz:  Size of the data to send (max 65535 bytes).
> + *
> + * Sends data on a connected socket, best-effort and nonblocking. This m=
ay sleep
> + * (kernel_sendmsg), so it can only be called from sleepable BPF program=
s.
> + *
> + * Return: Number of bytes sent on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
> +                              u32 data__sz)
> +{
> +       struct msghdr msg =3D {
> +               .msg_flags =3D MSG_DONTWAIT,
> +       };
> +       struct kvec iov =3D {
> +               .iov_base =3D (void *)data,
> +               .iov_len =3D data__sz,
> +       };
> +       int ret;
> +
> +       if (!bpf_ksock_has_user_task_context())
> +               return -EOPNOTSUPP;
> +
> +       /* Early check for UDP. Exact limits enforced by kernel_sendmsg()=
. */
> +       if (data__sz > IP_MAX_MTU)
> +               return -EMSGSIZE;
> +
> +       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> +
> +       return ret;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEP=
ABLE)
> +BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
> +BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)
> +
> +static const struct btf_kfunc_id_set ksock_init_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &ksock_init_kfunc_btf_ids,
> +};
> +
> +BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> +BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> +
> +#ifdef CONFIG_BPF_LSM
> +BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendm=
sg)
> +#endif
> +
> +static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> +{
> +       if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id))
> +               return 0;
> +
> +       if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL)
> +               return 0;
> +
> +#ifdef CONFIG_BPF_LSM
> +       if (prog->type =3D=3D BPF_PROG_TYPE_LSM &&
> +           prog->aux->attach_btf_id !=3D bpf_lsm_socket_sendmsg_id[0])
> +               return 0;
> +#endif
> +
> +       return -EACCES;
> +}
> +
> +static const struct btf_kfunc_id_set ksock_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &ksock_kfunc_btf_ids,
> +       .filter =3D bpf_ksock_kfunc_filter,
> +};
> +
> +BTF_ID_LIST(bpf_ksock_dtor_ids)
> +BTF_ID(struct, bpf_ksock)
> +BTF_ID(func, bpf_ksock_release_dtor)
> +
> +static int __init bpf_ksock_kfunc_init(void)
> +{
> +       int ret;
> +       const struct btf_id_dtor_kfunc bpf_ksock_dtors[] =3D {
> +               {
> +                       .btf_id =3D bpf_ksock_dtor_ids[0],
> +                       .kfunc_btf_id =3D bpf_ksock_dtor_ids[1],
> +               },
> +       };
> +
> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +                                       &ksock_init_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +                                              &ksock_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +                                              &ksock_kfunc_set);
> +       return ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
> +                                                 ARRAY_SIZE(bpf_ksock_dt=
ors),
> +                                                 THIS_MODULE);
> +}
> +
> +late_initcall(bpf_ksock_kfunc_init);
> --
> 2.34.1
>
