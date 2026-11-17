Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879070;
	b=zOYgwLwyx9agc3XV+Z7+Hzj6WzbThyA9pezqRwdrm4nhm4sGlG9wY2DdnGzNdk34VreQ
	 qG4MReuClemXgKuf3HIaNKe9wMEUNu98bRrGyKkBwNzXhZGYqRze53wWnGXyNNxPXv5hl
	 I98D28g8an9TGw4VeZW6YTaztDCCNiehCVtm2zBVjkdXFlFzWUs48tCSVbj5r1ECRfJaS
	 OE3tPJ9A+G8RI2ipW0pnwLvKPuyg+0N3JmZ2/oIK8vHFFVNg6EN0rFlWJXJsvvTOIUPY5
	 +7Uo8mbKfspqWZyKGi3TBD/ef9OAvRx31Mh4Mjtagb9EQewKvD791OKjdhcoPA74DYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879070;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=qYRGI+XzUctQbj0xrSR8pkRusIWSVpK3hTtQzfb40+I=;
	b=EYFx6g658ick/JAyzofghcB0+fF3e0z8ZDd5gMHu4GDE6Mv2ODOPArKE0umRAV2bqGEt
	 x3h2zNaAzymyECPlrLaDRdGTz4/qJPZA/0i/TJ2asGgv+oGnl1benbTJmB/0LjzD4Rop4
	 ILAJLStSfLHUkizFXXSv56FbpRnVw66ss+SdRNoVcdtBgcyrEEfBFmCaaANpd/8gqvV8+
	 gcglf5jlyBjtjlKQmYlfyuRH5k4QFlJmrVxHWWBx0e1YZbJIzv15SCymMGwTEXDhe48ib
	 OSWj0BuZGjAk2ri030XiM2Upi0ype0ocoaxuwdgRokr7k8baACPxZng2xfikohso6jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BoX902gI;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3C606A31C;
	Tue, 17 Nov 2026 01:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BoX902gI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qYRGI+XzUctQbj0xrSR8pkRusIWSVpK3hTtQzfb40+I=;
	b=BoX902gIGtdyPrqHfeL3q0Hvu2JKECSuzDeQV/wJhnyWzQVYW0hnp3Z55ONWjd
	kAb4OI2x0Ird2xPyv6zg4e5igCkCLXKKJAVvigYoffnEDRvuOKN7wETYiSBLbLp6
	DbKygzwO7pXgRG7Zp6qQPs6WYL/Ef6lLxcDEzNNVwmEBI=
Message-ID: <974f55cf-66d8-4ff7-a4f3-5362df1b4af8@163.com>
Date: Tue, 17 Nov 2026 09:30:07 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 1/2] tun: keep a kernel copy of the socket filter
 program
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, Rongguang Wei
 <weirongguang@kylinos.cn>, Willem de Bruijn <willemb@google.com>
References: <20261109023848.59575-1-clementwei90@163.com>
 <20261109023848.59575-2-clementwei90@163.com>
 <20261113162751.309d3544@kernel.org> <DMUJISP1U0SF.2VE8F3IUBU0F0@gmail.com>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <DMUJISP1U0SF.2VE8F3IUBU0F0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHpREfrvtqd+FpIA--.26271S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr4rCFy8Aw18Ar1fXF4fZrb_yoW3JFyUpF
	W5Ga4jyrW5JF40gr1qvF48ZF1avw1Ig34xu348G34Y9F1qgr1rCayUKryYvwn8CrWDuF1I
	qa12gr9xW34vqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-QFNuGr7riHlywAA35



Alexei Starovoitov wrote:
> On Fri, Nov 13, 2026 at 04:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> Alexei, would you mind glancing over this one?
>> Nothing stands out but the net/core/filter.c changes deserve a BPF ack.
>> (Or feel free to take it via bpf if you prefer.)
> 
> Ohh. Thanks for flagging. I completely missed it,
> since it was '[PATCH net] tun: ..' I didn't notice that it touches key sk_filter pieces.
> 
> And, yeah, I don't like it.
> It exports too much bpf internal stuff into tun device.
> Here is an alternative that my bot came up with and
> imo it's much better.
> Especially the part where EXPORT_SYMBOLs are removed.
> 
> pw-bot: cr
> 
> The diff is on top of bpf-next. It builds, and that is as far as I took it.
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec731..324acba 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -142,6 +142,7 @@ struct tun_file {
>  	struct napi_struct napi;
>  	bool napi_enabled;
>  	bool napi_frags_enabled;
> +	bool nofilter;			/* attached with IFF_NOFILTER */
>  	struct mutex napi_mutex;	/* Protects access to the above napi */
>  	struct list_head next;
>  	struct tun_struct *detached;
> @@ -176,7 +177,7 @@ struct tun_prog {
>  };
> 
>  /* Since the socket were moved to tun_file, to preserve the behavior of persist
> - * device, socket filter, sndbuf and vnet header size were restore when the
> + * device, sndbuf and vnet header size were restore when the
>   * file were attached to a persist device.
>   */
>  struct tun_struct {
> @@ -197,8 +198,6 @@ struct tun_struct {
>  	int			sndbuf;
>  	struct tap_filter	txflt;
>  	struct sock_fprog	fprog;
> -	/* protected by rtnl lock */
> -	bool			filter_attached;
>  	u32			msg_enable;
>  	spinlock_t lock;
>  	struct hlist_head flows[TUN_NUM_FLOW_ENTRIES];
> @@ -213,6 +212,7 @@ struct tun_struct {
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> +	struct tun_prog __rcu *cbpf_prog;
>  	struct ethtool_link_ksettings link_ksettings;
>  	/* init args */
>  	struct file *file;
> @@ -756,15 +756,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		goto out;
> 
>  	err = 0;
> -
> -	/* Re-attach the filter to persist device */
> -	if (!skip_filter && (tun->filter_attached == true)) {
> -		lock_sock(tfile->socket.sk);
> -		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> -		release_sock(tfile->socket.sk);
> -		if (!err)
> -			goto out;
> -	}
> +	tfile->nofilter = skip_filter;
> 
>  	if (!tfile->detached &&
>  	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
> @@ -1071,6 +1063,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	int txq = skb->queue_mapping;
>  	struct netdev_queue *queue;
>  	struct tun_file *tfile;
> +	struct tun_prog *prog;
>  	int len = skb->len;
>  	int ret;
> 
> @@ -1096,10 +1089,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto drop;
>  	}
> 
> -	if (tfile->socket.sk->sk_filter) {
> -		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
> -		if (drop_reason)
> +	prog = rcu_dereference(tun->cbpf_prog);
> +	if (prog && !READ_ONCE(tfile->nofilter)) {
> +		len = bpf_prog_run_clear_cb(prog->prog, skb);
> +		if (len == 0 || pskb_trim(skb, len)) {
> +			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
>  			goto drop;
> +		}
>  	}
> 
>  	len = run_ebpf_filter(tun, skb, len);
> @@ -2410,6 +2406,7 @@ static void tun_free_netdev(struct net_device *dev)
>  	security_tun_dev_free_security(tun->security);
>  	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
>  	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
> +	__tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
>  }
> 
>  static void tun_setup(struct net_device *dev)
> @@ -2964,7 +2961,6 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  		tun->vnet_hdr_sz = sizeof(struct virtio_net_hdr);
> 
>  		tun->align = NET_SKB_PAD;
> -		tun->filter_attached = false;
>  		tun->sndbuf = tfile->socket.sk->sk_sndbuf;
>  		tun->rx_batched = 0;
>  		RCU_INIT_POINTER(tun->steering_prog, NULL);
> @@ -3068,39 +3064,34 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>  	return 0;
>  }
> 
> -static void tun_detach_filter(struct tun_struct *tun, int n)
> +static int tun_attach_filter(struct tun_struct *tun, void __user *data)
>  {
> -	int i;
> +	struct sock_fprog fprog;
>  	struct tun_file *tfile;
> +	struct bpf_prog *prog;
> +	int i, ret;
> 
> -	for (i = 0; i < n; i++) {
> -		tfile = rtnl_dereference(tun->tfiles[i]);
> -		lock_sock(tfile->socket.sk);
> -		sk_detach_filter(tfile->socket.sk);
> -		release_sock(tfile->socket.sk);
> -	}
> +	if (copy_from_user(&fprog, data, sizeof(fprog)))
> +		return -EFAULT;
> 
> -	tun->filter_attached = false;
> -}
> +	ret = bpf_prog_create_from_user(&prog, &fprog, NULL, false);
> +	if (ret)
> +		return ret;
> 
> -static int tun_attach_filter(struct tun_struct *tun)
> -{
> -	int i, ret = 0;
> -	struct tun_file *tfile;
> +	ret = __tun_set_ebpf(tun, &tun->cbpf_prog, prog);
> +	if (ret) {
> +		bpf_prog_destroy(prog);
> +		return ret;
> +	}
> 
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
> -		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> -		release_sock(tfile->socket.sk);
> -		if (ret) {
> -			tun_detach_filter(tun, i);
> -			return ret;
> -		}
> +		WRITE_ONCE(tfile->nofilter, false);
>  	}
> 
> -	tun->filter_attached = true;
> -	return ret;
> +	/* Only TUNGETFILTER reads it */
> +	tun->fprog = fprog;
> +	return 0;
>  }
> 
>  static void tun_set_sndbuf(struct tun_struct *tun)
> @@ -3296,7 +3287,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
> 
>  		if (tfile->detached)
>  			ifr.ifr_flags |= IFF_DETACH_QUEUE;
> -		if (!tfile->socket.sk->sk_filter)
> +		if (tfile->nofilter || !rcu_access_pointer(tun->cbpf_prog))
>  			ifr.ifr_flags |= IFF_NOFILTER;
> 
>  		if (copy_to_user(argp, &ifr, ifreq_len))
> @@ -3439,11 +3430,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		ret = -EINVAL;
>  		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
>  			break;
> -		ret = -EFAULT;
> -		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
> -			break;
> -
> -		ret = tun_attach_filter(tun);
> +		ret = tun_attach_filter(tun, argp);
>  		break;
> 
>  	case TUNDETACHFILTER:
> @@ -3451,8 +3438,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		ret = -EINVAL;
>  		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
>  			break;
> -		ret = 0;
> -		tun_detach_filter(tun, tun->numqueues);
> +		ret = __tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
>  		break;
> 
>  	case TUNGETFILTER:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9245009..1c742f2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1565,7 +1565,6 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
> 
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(sk_attach_filter);
> 
>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>  {
> @@ -11779,7 +11778,6 @@ int sk_detach_filter(struct sock *sk)
> 
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(sk_detach_filter);
> 
>  int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
>  {
Hi Alexei,

Thanks, this is much cleaner. I'll rework the series this way with nothing from the BPF core exported.

