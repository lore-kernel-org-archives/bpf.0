Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999051;
	b=FDYLFK6CyJhI+GiHyuLu1/II47SQ3XtbR2hp3LNUQrkqhqU7rpF40ihzYK7KtLcIDEI+
	 Aj1n40no7SiwJD+yvcxRe3pWxgR8+91uSw2QI2sMOpgxVJ62uhEMVCbouKfL1TjLrMPIi
	 VvdvhmsPBxCDcl7W+YyE7Q4zl+4i5N9cisVbYucXN2gX7Ts/G1UVNSGWDuqWK3uk8s6PR
	 P7MCCqpSyOHlXAhlNAG/1QghTB22LKiyA8RChpxypu5mJl00U0SGP+an+XnEfOHN6XRht
	 T91LvTtDJ4utN+EU0vmskBahKbHsr+81Nm37ublobAkm6OmZxCMkTveGr7BJLz69K7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9rbAT6HOHtgTNmvUZ4uTgxskj8ClF6GOt0gfNlKXaVw=;
	b=UpcXj3UR2j36YCb54kqfbQJUGS0dldp8/t4YdZICvr/POH/gsUHRNgrLJsJEb0Q92MWt
	 6E4IoVUVwIcPX52LHCMDpBJ/i7R00C1TtjphOOfexl5CUyi7eiiKCOBF8+Bw5Zh70Tj+B
	 GhvsqrJ5myWDN6ZhOARZ9TqwFXyE9hC/zsNigOaZKRfVJZpzduOOXHAcoMMwi0fkhSURd
	 HezdYHUtmumeXRZi+l0OWDTnGDvBYSdwzXCRgXN3/zPcf+oIoP9evvlW9luvdslkcr+yK
	 uH7o15viHhoO5MgICdQhVJXgyP+xiOZ4NMhVmQixCPDNCHnzhwTPcMy4qFqxUPF98Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t1/mf1WZ";
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F1606A335
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 21:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8F1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1/mf1WZ
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-77bf892b496so415652137.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793999050; x=1794603850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9rbAT6HOHtgTNmvUZ4uTgxskj8ClF6GOt0gfNlKXaVw=;
        b=t1/mf1WZtDOY6xsxvbLgGh7Fl/B241jNd4o6SRR+DSGM3Qn8Z8hgRMxBdx6qS/B4O4
         jd+PIRn6UhDzsgliJbg/eTLmSBNGrue6dr0DsjT+toQcnXnhodCkHM8rri94AYwdPfYN
         OEmIXEtcQQvs47lmBVRuss0zJQUz/fnCMOtLgjcGZK/oqPuafSDfdouJ+S1Rgy/hdDKd
         xBMcFUVlazFIwNb9Y/Kp5OpjBVUIWNPQrlcBukd+GG93e61WSea4YWfKOQnC7yWwE8uL
         PL0TM3AdFljr7vVEfdM1FoYsK+2AeuehG4niLoQERAF5Jw0To+tIw3fdM5+iXie8L3+r
         f4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793999050; x=1794603850;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rbAT6HOHtgTNmvUZ4uTgxskj8ClF6GOt0gfNlKXaVw=;
        b=pyyqTbes6uNkN7cjGwMxpO7sl5uWEmWtzbS4MI+/wsuJe6vcidQgTGuIvdN5ReH9kr
         FEd5sqmUhunivfqheq6hRy0l7RQm4mdyT7Cdmn3h/MXU70zU8idYdyMIjyZg80jqNzzp
         HhKRgYQWcjOSVMbgtmo9LSr6dwuepD9Jfc5I0NREsSck52xbBOBg8kbjgZ/xAr4PZRhu
         7fKC4M8c3S8BxUK9O6G5NV99C2RSpGPLj7E4HpsdiVqr2pAhVKqJFpoIa0nAAc94u9Iy
         M6/T5h8g2FFG7NLQGGMC8WeHodGC4rIM8toSqoX+0fRcXzt7Fg4oSK6GAXSMOjfTEjpI
         iJHA==
X-Forwarded-Encrypted: i=1; AL+hErEWJK7Vr7UoY8NouSjEGUqjn36o21l07TisVQI5ZHlneSrYEZrakjMvKl7HDP8Mqw31lWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F6TksT6oOxFJnFHljTsm5KSPlZeJgk5fmPdCgYWJks2cGgOzQ
	n0pU2ky+Wp1y4PY4uHp49VvXr0rQ4xvmimZc4sAxuWicmfIJiud0zFpM
X-Gm-Gg: AYBFou32gkXffYs+qGsH/7qS0F9k4kMRgZK4KosVVmnsRC6Von6ttnv9nOrILMssP8v
	QmERzoK7yyIL4AIBfx+TTpHomhobntUxRg763So8D1fEqVCMVFznAoBrVoYFNLfwjhaR+sMVr6j
	pOARj/r0dXVT/VGdX/Ej5cmPqXgC31W+E23vbhFhitNCqpkiN0q3zNk9AuGluhaaakwKyQcNqSr
	B0g9k7Fpvqq7rzFGDaaSuRRMbdIp3RtalFEOdIPh/r+GhhSnXcWv3pPNZ9CO59q0Q5kztBXzUxD
	b1h1CmHT3rKNfbRBxr2aKBk3yRf2b5yRCN0bXfKrrr9qp6q4EVprQN819zWGfbQD9O8Tpob6H8A
	h9UAOnq14qNIxNLN4wpHsnnKO5vw9GMfV5FYSLgH2Xjv1ChDElAzp6kvUzsHKtJjX9Tv2Xzg5/9
	lqFRKHOKV8h1WIEZL4KwUEOcdTxvhexe1f51OnviZBK4wF0yX6opkckNf6pYDCo2wosHBNaE2O9
	J7+NnocXICM263OSqSp2dvr7RydPIeOYQXvCDNiaHFbR6lxNdwoLwP688yMJen9TuoZ1bJs7yIo
	ioVcaFNujR3vs2J3SYH3+wKyeTL2rlJKthc+WCzZP7t24xzL4BNZ5/1seNVhVJ7HMuUtDWSXLmB
	7gUyYgwkqOEl1nAap+U/BHkPtO4f6TtXwiecDwmlT5ZukXK5Pi+NCJNbCw7+37stWxtnwrEg=
X-Received: by 2002:a05:6102:6cc:b0:7d2:7c63:59fd with SMTP id ada2fe7eead31-7d2a169a84amr1938421137.34.1793999050220;
        Fri, 06 Nov 2026 13:04:10 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a89a75b2sm2222405137.5.2026.11.06.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:04:09 -0800 (PST)
Date: Fri, 06 Nov 2026 16:04:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.20268598d87e6@gmail.com>
In-Reply-To: <20261103142232.1869185-2-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
 <20261103142232.1869185-2-antonio@mandelbit.com>
Subject: Re: [PATCH net v4 1/2] tun: bound the NAPI receive queue
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI)
> and is slower than the writer, the queue grows until the system runs
> out of memory. An unprivileged user can do this from its own user and
> network namespaces, and the queued skbs are not charged to its memcg:
> in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
> in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
> INT_MAX, and the build_skb() and XDP batch paths do not check it.
> 
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped: before
> allocating and copying them where possible, and again under the queue
> lock before queueing. This covers write(), sendmsg() and the batches of
> XDP buffers vhost-net passes to tun_sendmsg(), which share the queue.
> Zerocopy buffers of packets dropped early are completed.
> 
> The NAPI poll moves the whole queue out, processes up to its budget and
> puts the rest back: while it runs, the queue looks empty to writers, so
> with the poll on another CPU the backlog still grows without limit. Keep
> the leftovers on a queue of their own and take the next batch only once
> it is empty, like process_backlog() does, so that neither queue holds
> more than the limit.
> 
> Dropping because the queue is full also schedules NAPI, in all three
> places. vhost-net sends with MSG_MORE while it has more packets, and
> tun_get_user() schedules NAPI only after the last one or once more than
> NAPI_POLL_WEIGHT are queued. With a netdev_max_backlog below that, the
> queue would not drain until vhost-net ran out of packets; with zerocopy,
> vhost-net never would, as it stops sending when too many queued buffers
> are pending.
> 
> Reproducer, as an unprivileged user in a new user and network
> namespace, without kernel modifications or fault injection:
>   ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
>   ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
>   ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
>   install ~500 iptables FORWARD rules and a MASQUERADE rule on d0
>   open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
>   echo 1 > /sys/class/net/t0/threaded
>   write() 1400-byte IPv4 packets for 10.20.0.2 in a loop
> 
> Tested in an x86-64 VM with 1 and 2 vCPUs: with the reproducer running
> for 15 seconds, memory use stays flat and the forwarding rate is
> unchanged; the tun kselftest passes, as it does without the patch; and
> the tun_vhost kselftest added by the next patch, which drives the
> vhost-net batch, copy and zerocopy paths, passes, while it fails without
> the patch.
> 
> Still open: the limit counts packets rather than bytes and applies per
> queue, up to about twice the limit can be in flight (queued plus taken
> by the poll), and the queued skbs are still not charged to the writer's
> memcg.
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

This is quite a complex solution.

Can we perhaps simplify it a bit? For instance:

On tx only keep the lockless check. Number of packets that can bypass
that is bounded, by the number of competing threads.

On rx avoid the new queue, by not temporary presenting an empty queue:

        spin_lock(&queue->lock);
        if (skb_queue_len(queue) <= budget) {
            skb_queue_splice_tail_init(queue, &process_queue);
        } else {
            while (skb_queue_len(&process_queue) < budget &&
                   (skb = __skb_dequeue(queue)))
                __skb_queue_tail(&process_queue, skb);
        }
        spin_unlock(&queue->lock);




> ---
>  drivers/net/tun.c | 82 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 770b8fe085c3..ea99ee0aee2b 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -58,6 +58,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/virtio_net.h>
>  #include <linux/rcupdate.h>
> +#include <net/hotdata.h>
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
>  #include <net/rtnetlink.h>
> @@ -140,6 +141,8 @@ struct tun_file {
>  		unsigned int ifindex;
>  	};
>  	struct napi_struct napi;
> +	/* NAPI poll only: skbs taken off sk_write_queue, not yet received */
> +	struct sk_buff_head napi_process_queue;
>  	bool napi_enabled;
>  	bool napi_frags_enabled;
>  	struct mutex napi_mutex;	/* Protects access to the above napi */
> @@ -227,31 +230,40 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog of netif_rx().
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) >
> +	       READ_ONCE(net_hotdata.max_backlog);
> +}
> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> +	struct sk_buff_head *process_queue = &tfile->napi_process_queue;
>  	struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
> -	struct sk_buff_head process_queue;
>  	struct sk_buff *skb;
>  	int received = 0;
>  
> -	__skb_queue_head_init(&process_queue);
> -
> -	spin_lock(&queue->lock);
> -	skb_queue_splice_tail_init(queue, &process_queue);
> -	spin_unlock(&queue->lock);
> -
> -	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
> +	while (received < budget) {
> +		/* Refill only when empty: leftovers are not put back on the
> +		 * queue writers check, so neither queue exceeds the limit.
> +		 */
> +		if (skb_queue_empty(process_queue)) {
> +			spin_lock(&queue->lock);
> +			skb_queue_splice_tail_init(queue, process_queue);
> +			spin_unlock(&queue->lock);
> +			if (skb_queue_empty(process_queue))
> +				break;
> +		}
> +		skb = __skb_dequeue(process_queue);
>  		napi_gro_receive(napi, skb);
>  		++received;
>  	}
>  
> -	if (!skb_queue_empty(&process_queue)) {
> -		spin_lock(&queue->lock);
> -		skb_queue_splice(&process_queue, queue);
> -		spin_unlock(&queue->lock);
> -	}
> -
>  	return received;
>  }
>  
> @@ -572,6 +584,8 @@ static void tun_queue_purge(struct tun_file *tfile)
>  		tun_ptr_free(ptr);
>  
>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> +	/* NAPI is disabled by now */
> +	__skb_queue_purge(&tfile->napi_process_queue);
>  	skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
>  
> @@ -1856,6 +1870,23 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
> +	 * MSG_MORE sender may not have done yet. Rechecked under the lock.
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		local_bh_disable();
> +		napi_schedule(&tfile->napi);
> +		local_bh_enable();
> +		if (msg_control) {
> +			struct ubuf_info *uarg = msg_control;
> +
> +			uarg->ops->complete(NULL, uarg, false);
> +		}
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> @@ -2045,6 +2076,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			goto free_skb;
>  		}
>  
> +		/* NAPI queue full: drop, as above */
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock(&queue->lock);
> +			napi_schedule(&tfile->napi);
> +			local_bh_enable();
> +			rcu_read_unlock();
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			drop_reason = SKB_DROP_REASON_FULL_RING;
> +			goto free_skb;
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		queue_len = skb_queue_len(queue);
>  		spin_unlock(&queue->lock);
> @@ -2649,6 +2691,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>  			return -EBUSY;
>  		}
>  
> +		/* NAPI queue full: drop, and schedule NAPI so that it drains
> +		 * even if nothing in this batch gets queued
> +		 */
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock(&queue->lock);
> +			napi_schedule(&tfile->napi);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			return 0;
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		spin_unlock(&queue->lock);
>  		ret = 1;
> @@ -3571,6 +3624,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  	}
>  
>  	mutex_init(&tfile->napi_mutex);
> +	__skb_queue_head_init(&tfile->napi_process_queue);
>  	RCU_INIT_POINTER(tfile->tun, NULL);
>  	tfile->flags = 0;
>  	tfile->ifindex = 0;
> -- 
> 2.56.0
> 


