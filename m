Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F91C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F48F20651
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfDIJLH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:11:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:57588 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfDIJLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 05:11:06 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDmmS-00074t-Rm; Tue, 09 Apr 2019 11:11:00 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDmmS-000Kh5-IF; Tue, 09 Apr 2019 11:11:00 +0200
Subject: Re: [PATCH bpf 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Magnus Karlsson <magnus.karlsson@intel.com>, bjorn.topel@intel.com,
        ast@kernel.org, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net, will.deacon@arm.com
References: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
 <1554792253-27081-3-git-send-email-magnus.karlsson@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <621a9d70-5397-da90-a68c-6f12f5cbd3b2@iogearbox.net>
Date:   Tue, 9 Apr 2019 11:10:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1554792253-27081-3-git-send-email-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09/2019 08:44 AM, Magnus Karlsson wrote:
> The use of smp_rmb() and smp_wmb() creates a Linux header dependency
> on barrier.h that is uneccessary in most parts. This patch implements
> the two small defines that are needed from barrier.h. As a bonus, the
> new implementations are faster than the default ones as they default
> to sfence and lfence for x86, while we only need a compiler barrier in
> our case. Just as it is when the same ring access code is compiled in
> the kernel.
> 
> Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/lib/bpf/xsk.h | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> index 3638147..317b44f 100644
> --- a/tools/lib/bpf/xsk.h
> +++ b/tools/lib/bpf/xsk.h
> @@ -39,6 +39,21 @@ DEFINE_XSK_RING(xsk_ring_cons);
>  struct xsk_umem;
>  struct xsk_socket;
>  
> +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
> +# if defined(__i386__) || defined(__x86_64__)
> +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
> +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
> +# elif defined(__aarch64__)
> +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> +# elif defined(__arm__)
> +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> +# else
> +#  error Architecture not supported by the XDP socket code in libbpf.
> +# endif
> +#endif

Hmm, bit unfortunate, but I can see why it's needed inside the header here
as it's installed into the system and needs to be included by applications.
Fine with me. In any case, I still think we should also fix it for tooling
infra to avoid others running into the same issue, lemme resurrect [0] from
back in the days.

One question though regarding above arm32 implementation. You match these
barriers against the ones from af_xdp in kernel. So smp_* variants from the
arch/arm/include/asm/barrier.h header need to be matched. This selects the
dmb(ish) and dmb(ishst) variant. The implementation of dmb() however is
quite CPU dependent, the above assumes to match with __LINUX_ARM_ARCH__ >= 7.
Perhaps this assumption needs at minimum a comment to make it clear for
developers.

  [0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@iogearbox.net/

>  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
>  					      __u32 idx)
>  {
> @@ -119,7 +134,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
>  	/* Make sure everything has been written to the ring before signalling
>  	 * this to the kernel.
>  	 */
> -	smp_wmb();
> +	bpf_smp_wmb();
>  
>  	*prod->producer += nb;
>  }
> @@ -133,7 +148,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
>  		/* Make sure we do not speculatively read the data before
>  		 * we have received the packet buffers from the ring.
>  		 */
> -		smp_rmb();
> +		bpf_smp_rmb();
>  
>  		*idx = cons->cached_cons;
>  		cons->cached_cons += entries;
> 

