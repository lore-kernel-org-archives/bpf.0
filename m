Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619512;
	b=uwb7veLzyKjnvc5KmXw4ed6b19sCC+dCBAGso3EmcyK+zAQu+YbeUCYyDMJdankGXFkS
	 WRsNbEieurwwf4M+bzReCCNbIZH16AxXitqoF0GSX/2/fBTGMI0rmDvw83D9kCPeI1gGX
	 KqrD/zQOqkyHRcBpxKKUmYkwgysqmaJll+CyhTIZ24o+O+trwPBt7codbVRxa67zRVtK2
	 aruGs/SJEF/q1VFwx0RtTHkd00NcOw0ipL3W6PGfb4e9QSszCcAstMStIfBsXVmMIKQXi
	 c1dEGpswtR8+CU+8v9ZLaL5i9LQCpSTDDwtmJMK41KpnCEcwTVuW2c3RI+MYl2m7ioQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=+WEg+P/B7K/tRZO6VBT025PejOv9QsKePvT7Zn+/aPc=;
	b=1OQuPUWEeP+JFTrCuZbG0V5cXV2Sxq1nkJsD6dzp9Vv7NZLEn9D3qbj69Qu/wTtFDmSF
	 drqlsFK1OKA10Z69VmaNtKcGQsfo5nBWjDGNvnwuDKlPVauX1aIpHqhxDQQ3hAwMV/AlL
	 2spmw6g7cXBE/x0qMfjKOfUa1qWc6C0s6chpYzPGJMxqRkdXinhv356fST+BJs5G8R14p
	 /z+n99yBCVDfNqE+EDbx8QJnNn6GXb17zrRT/sB8+68SxgTeY8wY9p1dipIblQVnONrSe
	 ZWA2UMuRAZDIiuggmcKusY59pYCMjtSMHn+jOLNmSaH0WZBqs2dxOUwEGgzXEeGRCHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNaSqBSg;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9444606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 01:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9444606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNaSqBSg
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso340359a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794619510; x=1795224310; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+WEg+P/B7K/tRZO6VBT025PejOv9QsKePvT7Zn+/aPc=;
        b=kNaSqBSgQOoBYpC25L0mxJ627/w06VhGkLDst/2wejGDxe12CydzhoRzGGyfTiFlEb
         CCcYPxSQyT3fQMqF67hxX5+VCr1nEvvg/hrOn8DqOTOPTC9lS2HuczR9m6lEEGWwbNRN
         ml6R/PXdrJryywpbZhEVVzLheZhY1rOtIOG15BtbiKpUg/S4XfDR3DdCeMmTLriii5XC
         o60BPo3+tyIbBPhkYA0Jn8tAzRH643f3WhqDGOUYoWIX7rS41HXWJ5EAWysllKK/mdMr
         IRow0pld4nFSLnmFtyF5sqYpcbP69Ou/5CWpMPAqNabVgP01v8Ju5hBBhkUkRrxM3OTv
         Rfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794619510; x=1795224310;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WEg+P/B7K/tRZO6VBT025PejOv9QsKePvT7Zn+/aPc=;
        b=tw4upv6Z4ExFQsJqSWQnP+ufxcNHQUSKgFIdL+BmFqNUooNzO7TTT5/qUffF8LzEs2
         v2Y5PjrDRwPnzK8FICW0ba3s+gvo1zNEgXQyBbX9mFPywtkhgu1wHuEzh6YS+WXsbDFC
         8na5flZbvaEOeSeA+skxplad4ZsvXeHMaDpMPpT+ddUbtKQzR5FQhj5FDdpiJhB53+Pp
         HFLvLEw5b15YNqrFhrFXh8rzGeySHwsy9NGaPKXVEKmMCSe+TFZmBfO4W4qX4SFtn9FE
         EEgkVWrduaNjYQMiYevoeN4UltY3EU3MDcIs2anspvW99UEKXBUNV/KJbl6eiiQ03och
         otXg==
X-Forwarded-Encrypted: i=1; AL+hErE4Gs12ll/9xyQP8EcZGc0dqhdLPqf5h1C72kMsj7mR8Nj9QMOs5SBLBM8OLmt2lEhBYlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0CpqywdqY9sH82T5k4aaOO9nsSFxAn4TexEoThxyavCYWov2V
	aS2sWujYi2ubGocrIV8qAlTU0ckRFQX//F+EXTXaYhoZHPT8bo307/Gg
X-Gm-Gg: AYBFou0PJvB5SzFVelJsLjuxQGpuKtnCpZqjjiElM6lfHrRb5BsvGLT3hh3d9yU6XZJ
	vzvFT1S+q12zuHy3lCNkjzG+Rv9MgdLjquBgfcZESDC6/Vf22fRHTYRCQZDDZPitpjPo9qkH3xQ
	KzqcVb5sWfOXvkyrgwLjuqd8HdceUyMSif5wWAE+kZs9v1Hj1Vv5eqoQDA42h8ODS+pxWm4QYOZ
	ShlNYAHRI6qpYmPlBPJ0dhsWDvl6te+1OUQkzPe8kCrTUhl4sGv+dwlBwQWQCztmmp2qxKxNQ6V
	0MhTaRxuBEpCIITQdVcz86QYddkH9tdOfP8VBKTnB0x5Vp5JVVhOPxfStg5a2jvMVhu2yMmYQhw
	XShZi7cIkWCJqXTi8Ot/rFV7wGs7IfQ/6856IYbEnidJQErNX65nLhNw1zl+w+rqOMeiFPGxqJf
	LUqxPegDvbqYjGiNyGwf8wXHCqxNXW04F4qD+KJ3Xfb4B3byZw1I/q7veFSNAgJ0FUieLKXbI3n
	Us8wcEIf4yog/1jkfd5Ew+gKOsn+dVYGJgCtvCvIKwXU9xrYH5DWbQYUkECq/aIXgUGSelVlWqT
	UZeGJVT/5YRpvKAEoGbRMjqAoG9I8qqtmusx2GM/ryINmSka0xzDo6FD11IsSL1cLZTx7fYrWOZ
	cZ3pQ2Kt1/fT5pwxrFOVKpWnspuGM0V1AyA==
X-Received: by 2002:a17:90b:3886:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b1b0a1904amr3746072a91.24.1794619509952;
        Fri, 13 Nov 2026 17:25:09 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm3010430a91.1.2026.11.13.17.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:25:09 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 01:25:08 +0000
Message-Id: <DMUJISP1U0SF.2VE8F3IUBU0F0@gmail.com>
Cc: "Rongguang Wei" <clementwei90@163.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>,
 <jasowangio@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 "Rongguang Wei" <weirongguang@kylinos.cn>, "Willem de Bruijn"
 <willemb@google.com>
Subject: Re: [PATCH net v10 1/2] tun: keep a kernel copy of the socket
 filter program
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
In-Reply-To: <20261113162751.309d3544@kernel.org>
References: <20261109023848.59575-1-clementwei90@163.com> <20261109023848.59575-2-clementwei90@163.com> <20261113162751.309d3544@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 04:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Alexei, would you mind glancing over this one?
> Nothing stands out but the net/core/filter.c changes deserve a BPF ack.
> (Or feel free to take it via bpf if you prefer.)

Ohh. Thanks for flagging. I completely missed it,
since it was '[PATCH net] tun: ..' I didn't notice that it touches key sk_filter pieces.

And, yeah, I don't like it.
It exports too much bpf internal stuff into tun device.
Here is an alternative that my bot came up with and
imo it's much better.
Especially the part where EXPORT_SYMBOLs are removed.

pw-bot: cr

The diff is on top of bpf-next. It builds, and that is as far as I took it.

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec731..324acba 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -142,6 +142,7 @@ struct tun_file {
 	struct napi_struct napi;
 	bool napi_enabled;
 	bool napi_frags_enabled;
+	bool nofilter;			/* attached with IFF_NOFILTER */
 	struct mutex napi_mutex;	/* Protects access to the above napi */
 	struct list_head next;
 	struct tun_struct *detached;
@@ -176,7 +177,7 @@ struct tun_prog {
 };

 /* Since the socket were moved to tun_file, to preserve the behavior of persist
- * device, socket filter, sndbuf and vnet header size were restore when the
+ * device, sndbuf and vnet header size were restore when the
  * file were attached to a persist device.
  */
 struct tun_struct {
@@ -197,8 +198,6 @@ struct tun_struct {
 	int			sndbuf;
 	struct tap_filter	txflt;
 	struct sock_fprog	fprog;
-	/* protected by rtnl lock */
-	bool			filter_attached;
 	u32			msg_enable;
 	spinlock_t lock;
 	struct hlist_head flows[TUN_NUM_FLOW_ENTRIES];
@@ -213,6 +212,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_prog __rcu *cbpf_prog;
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -756,15 +756,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;

 	err = 0;
-
-	/* Re-attach the filter to persist device */
-	if (!skip_filter && (tun->filter_attached == true)) {
-		lock_sock(tfile->socket.sk);
-		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-		if (!err)
-			goto out;
-	}
+	tfile->nofilter = skip_filter;

 	if (!tfile->detached &&
 	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
@@ -1071,6 +1063,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	int txq = skb->queue_mapping;
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
+	struct tun_prog *prog;
 	int len = skb->len;
 	int ret;

@@ -1096,10 +1089,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}

-	if (tfile->socket.sk->sk_filter) {
-		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
-		if (drop_reason)
+	prog = rcu_dereference(tun->cbpf_prog);
+	if (prog && !READ_ONCE(tfile->nofilter)) {
+		len = bpf_prog_run_clear_cb(prog->prog, skb);
+		if (len == 0 || pskb_trim(skb, len)) {
+			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 			goto drop;
+		}
 	}

 	len = run_ebpf_filter(tun, skb, len);
@@ -2410,6 +2406,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	__tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
 }

 static void tun_setup(struct net_device *dev)
@@ -2964,7 +2961,6 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		tun->vnet_hdr_sz = sizeof(struct virtio_net_hdr);

 		tun->align = NET_SKB_PAD;
-		tun->filter_attached = false;
 		tun->sndbuf = tfile->socket.sk->sk_sndbuf;
 		tun->rx_batched = 0;
 		RCU_INIT_POINTER(tun->steering_prog, NULL);
@@ -3068,39 +3064,34 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 	return 0;
 }

-static void tun_detach_filter(struct tun_struct *tun, int n)
+static int tun_attach_filter(struct tun_struct *tun, void __user *data)
 {
-	int i;
+	struct sock_fprog fprog;
 	struct tun_file *tfile;
+	struct bpf_prog *prog;
+	int i, ret;

-	for (i = 0; i < n; i++) {
-		tfile = rtnl_dereference(tun->tfiles[i]);
-		lock_sock(tfile->socket.sk);
-		sk_detach_filter(tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-	}
+	if (copy_from_user(&fprog, data, sizeof(fprog)))
+		return -EFAULT;

-	tun->filter_attached = false;
-}
+	ret = bpf_prog_create_from_user(&prog, &fprog, NULL, false);
+	if (ret)
+		return ret;

-static int tun_attach_filter(struct tun_struct *tun)
-{
-	int i, ret = 0;
-	struct tun_file *tfile;
+	ret = __tun_set_ebpf(tun, &tun->cbpf_prog, prog);
+	if (ret) {
+		bpf_prog_destroy(prog);
+		return ret;
+	}

 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
-		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-		if (ret) {
-			tun_detach_filter(tun, i);
-			return ret;
-		}
+		WRITE_ONCE(tfile->nofilter, false);
 	}

-	tun->filter_attached = true;
-	return ret;
+	/* Only TUNGETFILTER reads it */
+	tun->fprog = fprog;
+	return 0;
 }

 static void tun_set_sndbuf(struct tun_struct *tun)
@@ -3296,7 +3287,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,

 		if (tfile->detached)
 			ifr.ifr_flags |= IFF_DETACH_QUEUE;
-		if (!tfile->socket.sk->sk_filter)
+		if (tfile->nofilter || !rcu_access_pointer(tun->cbpf_prog))
 			ifr.ifr_flags |= IFF_NOFILTER;

 		if (copy_to_user(argp, &ifr, ifreq_len))
@@ -3439,11 +3430,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = -EFAULT;
-		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
-			break;
-
-		ret = tun_attach_filter(tun);
+		ret = tun_attach_filter(tun, argp);
 		break;

 	case TUNDETACHFILTER:
@@ -3451,8 +3438,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = 0;
-		tun_detach_filter(tun, tun->numqueues);
+		ret = __tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
 		break;

 	case TUNGETFILTER:
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009..1c742f2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1565,7 +1565,6 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)

 	return 0;
 }
-EXPORT_SYMBOL_GPL(sk_attach_filter);

 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 {
@@ -11779,7 +11778,6 @@ int sk_detach_filter(struct sock *sk)

 	return ret;
 }
-EXPORT_SYMBOL_GPL(sk_detach_filter);

 int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
