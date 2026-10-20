Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510705;
	b=tGPC77+ZijVUfFruA+zus1/Ut3F0GHUsFpyfKimLfufr3Rj2X4jMJGPRLyzyIrqiKzvn
	 b4r3hdO7Nx399rATqaXJDihJn2u2PEcQCPP6IJA+y2dvYfelfdzAa6A7169WXlzhE5EKD
	 b5qJ4yedSCV8xw3He/tEuHcIrpiD6mSdJTqSjczVUCT8x39OQOpQ6sNVWcbyqCBv5en2U
	 7AMIBNaUlzW4u44vRNrN7rZbOfN286Z/kElYVHcC+LnWLVttXSHnOXjnntig/aclvBUCH
	 vsTd/if5hY8fFvNv1pz/7A8mQ2wjoU3v9CVY6TD7B5g1sjbKueRsQ3McfSOjAoB3cSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510705;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8OwD2EpZJ6TLZtluTLkbmn4wyYgYcYS5zVnYe4qqLac=;
	b=ivI8+6o0k6PUfB08FwbI+7kmFNzwIva+Zpu1to38WcvIMysWtYfjOVemKrtjxEHeSF48
	 HLV6Wo0gATEcGlREPJXFOa8D8BZJBSbzQA4gWdfj19s3hnDxd5IHb8Q6KBTyrX+mLU+7X
	 hA4GzkWYdMPKJaK5zOizeWqFLydQZXwLORIQgk19DSa3Zw5Iu1ADO7XyCqTMDe2bdclD3
	 KrxppH3bQvA+4FUSm08+xBvAzz2UnOvJFC4IwYTX/kSzsbiR9VJYU3hkR0o4C1G2mNyLZ
	 UUDBEyorWe+e0Xo5I6NUXgAdEdVLRFECqAt6wKDalNiF3ADeX9S4QBy9I+6ujGYHTaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B365606A319;
	Tue, 20 Oct 2026 15:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F17D1F000CC;
	Tue, 20 Oct 2026 15:38:24 +0000 (UTC)
Message-ID: <sashiko-outbox-179266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Add syscall common attrs support
 for xdp link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261020152804.39863-3-leon.hwang@linux.dev>
References: <20261020152804.39863-1-leon.hwang@linux.dev>
 <20261020152804.39863-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:37:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] net: missing struct bpf_verifier_log forward declaration in netdevi=
ce.h
--

commit 6d93234cac5f9d8bd1858f0479e625aeca6428c5
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for xdp link_create

This commit adds syscall common attributes support to bpf_xdp_link_attach()=
 so
that invalid target_ifindex errors and underlying driver extack error messa=
ges
can be reported through bpf_log(). It also defines a no-op stub for bpf_log=
()
when CONFIG_BPF_SYSCALL is disabled.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3cff2174dc03a..4548b0fd824db 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4417,7 +4417,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_bu=
ff *skb, struct net_device *d
>  struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_devi=
ce *dev,
>  				    struct netdev_queue *txq, int *ret);
> =20
> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g);
> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g,
> +			struct bpf_verifier_log *log);

[Severity: Low]
Does include/linux/netdevice.h need a forward declaration for
struct bpf_verifier_log alongside struct bpf_prog?

Without a file-scope forward declaration in include/linux/netdevice.h, any
translation unit that includes <linux/netdevice.h> before <linux/bpf.h>,
<linux/btf.h>, or <linux/bpf_verifier.h> declares struct bpf_verifier_log f=
or
the first time inside the parameter list of bpf_xdp_link_attach(), triggeri=
ng
-Wvisibility warnings.

In net/core/dev.c, <linux/netdevice.h> is included before <linux/bpf.h> and
<linux/bpf_verifier.h>:

    #include <linux/netdevice.h>
    ...
    #include <linux/bpf.h>
    #include <linux/bpf_trace.h>
    #include <linux/bpf_verifier.h>

This causes the prototype in include/linux/netdevice.h to use a
parameter-scoped struct bpf_verifier_log while the definition of
bpf_xdp_link_attach() in net/core/dev.c uses the file-scoped
struct bpf_verifier_log from <linux/bpf_verifier.h>, resulting in a
conflicting types compilation error.

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 18dc88990510a..96be63b9331e8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -97,6 +97,7 @@
>  #include <linux/kthread.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
> +#include <linux/bpf_verifier.h>
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
>  #include <net/busy_poll.h>
> @@ -10771,7 +10772,8 @@ static const struct bpf_link_ops bpf_xdp_link_lop=
s =3D {
>  	.update_prog =3D bpf_xdp_link_update,
>  };
> =20
> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g)
> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pro=
g,
> +			struct bpf_verifier_log *log)
>  {

[ ... ]

>  	return fd;

[ ... ]

>  }

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020152804.3986=
3-1-leon.hwang@linux.dev?part=3D2
