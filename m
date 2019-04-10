Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B08C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBEF2070D
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfDJS4i (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:56:38 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:35000 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfDJS4h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Apr 2019 14:56:37 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us2.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id EA4EF80069;
        Wed, 10 Apr 2019 18:56:33 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Apr
 2019 11:56:29 -0700
Subject: Re: [PATCH bpf-next 2/5] bpf: cpumap use netif_receive_skb_list
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        <netdev@vger.kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <bpf@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
 <155489662285.20826.2411693802215419579.stgit@firesoul>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <3e1973ea-3304-bec8-46f3-536994f9e5fd@solarflare.com>
Date:   Wed, 10 Apr 2019 19:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <155489662285.20826.2411693802215419579.stgit@firesoul>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24542.005
X-TM-AS-Result: No-6.463400-4.000000-10
X-TMASE-MatchedRID: eVEkOcJu0F6HYS4ybQtcOia1MaKuob8PC/ExpXrHizyJ5xZahLul5JPD
        bikkMnICsXzLumsEQ3LwC+yY/IpROKLCTO1UKypvv1vPAPz22Fmy4iyjvVWTomHZ+cd7VyKX+r4
        ksoUQ8wXT01A2vEikVnPL3KdKFhM8wdbU3akH5Ay+dJWHbg4ITpKLNrbpy/A0FAsTXoyZ8MsIqG
        5TetjhMNOzjHdBEheNbCcQdI7TJskPRVepDWIjx+0/o+/4D7DzFqhQk68kpacaUFNX+UFygD+ro
        IwmQ1LV+7M9+8OvngujNIrIg5n4kP/8uo2LJpjtEgwM8US/pTEHgh3sKJBzP2/Fw+PM2volwRge
        clnEWH2h1BRkgqaEc7gtnN6cOEY/v1l2Uvx6idpWdFebWIc3VsRB0bsfrpPInxMyeYT53Rn/dvF
        FQCvI+yYcvKjVSozR3E59IcyyqbHVsikrEe980vuPzj2OClt4ks1Oi4kjl5X58+J/QG5iMq5txV
        P8sEoA+lXwaI9uovvUNewp4E2/TgSpmVYGQlZ3sxk1kV1Ja8cbbCVMcs1jUlZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.463400-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24542.005
X-MDID: 1554922596-BM2bdfihwUrl
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/04/2019 12:43, Jesper Dangaard Brouer wrote:
> Reduce BH-disable period further by moving cpu_map_build_skb()
> outside/before invoking the network stack.  And build up a
> skb_list that is used for netif_receive_skb_list. This is also
> an I-cache optimization.
>
> When injecting packets into the network stack, cpumap uses a special
> function named netif_receive_skb_core(), and we create a equivalent list
> version  named netif_receive_skb_list_core().
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  include/linux/netdevice.h |    1 +
>  kernel/bpf/cpumap.c       |   17 ++++++++++-------
>  net/core/dev.c            |   18 ++++++++++++++++++
>  3 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 166fdc0a78b4..37e78dc9f30a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3621,6 +3621,7 @@ int netif_rx_ni(struct sk_buff *skb);
>  int netif_receive_skb(struct sk_buff *skb);
>  int netif_receive_skb_core(struct sk_buff *skb);
>  void netif_receive_skb_list(struct list_head *head);
> +void netif_receive_skb_list_core(struct list_head *head);
>  gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb);
>  void napi_gro_flush(struct napi_struct *napi, bool flush_old);
>  struct sk_buff *napi_get_frags(struct napi_struct *napi);
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 430103e182a0..cb93df200cd0 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -256,6 +256,7 @@ static int cpu_map_kthread_run(void *data)
>  	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
>  		unsigned int drops = 0, sched = 0;
>  		void *frames[CPUMAP_BATCH];
> +		struct list_head skb_list;
>  		int i, n;
>  
>  		/* Release CPU reschedule checks */
> @@ -279,23 +280,25 @@ static int cpu_map_kthread_run(void *data)
>  		 */
>  		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
>  
> -		local_bh_disable();
> +		INIT_LIST_HEAD(&skb_list);
> +
>  		for (i = 0; i < n; i++) {
>  			struct xdp_frame *xdpf = frames[i];
>  			struct sk_buff *skb;
> -			int ret;
>  
>  			skb = cpu_map_build_skb(rcpu, xdpf);
>  			if (!skb) {
>  				xdp_return_frame(xdpf);
>  				continue;
>  			}
> -
> -			/* Inject into network stack */
> -			ret = netif_receive_skb_core(skb);
> -			if (ret == NET_RX_DROP)
> -				drops++;
You're losing this `drops` incrementation and not doing anything to
 replace it...
> +			list_add_tail(&skb->list, &skb_list);
>  		}
> +
> +		local_bh_disable();
> +
> +		/* Inject into network stack */
> +		netif_receive_skb_list_core(&skb_list);
> +
>  		/* Feedback loop via tracepoint */
>  		trace_xdp_cpumap_kthread(rcpu->map_id, n, drops, sched);
... yet still feeding it to the tracepoint here.

I ran into something similar with my list-GRO patches (callers wanted to
 know how many packets from the list were received vs. dropped); check
 those to see how I wired that counting all the way through the listified
 stack.

Apart from that, I like this!

-Ed
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9ca2d3abfd1a..1dee7bd895a0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5297,6 +5297,24 @@ void netif_receive_skb_list(struct list_head *head)
>  }
>  EXPORT_SYMBOL(netif_receive_skb_list);
>  
> +/**
> + *	netif_receive_skb_list_core - special version of netif_receive_skb_list
> + *	@head: list of skbs to process.
> + *
> + *	More direct receive version of netif_receive_skb_list().  It should
> + *	only be used by callers that have a need to skip RPS and Generic XDP.
> + *
> + *	This function may only be called from softirq context and interrupts
> + *	should be enabled.
> + */
> +void netif_receive_skb_list_core(struct list_head *head)
> +{
> +	rcu_read_lock();
> +	__netif_receive_skb_list(head);
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(netif_receive_skb_list_core);
> +
>  DEFINE_PER_CPU(struct work_struct, flush_works);
>  
>  /* Network device is going away, flush any packets still pending */
>

