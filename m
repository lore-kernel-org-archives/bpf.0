Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444037;
	b=BkZZxJughatvWTka1Liy3Barc1v6/HzsEQYpG1ylYH2S2XbQRzqcTm3PKdV4PDOilERo
	 cnIL4+u4a4tz+IC/vNEOpFCxpspbLCcWIG8++QSnt6jVLcdUMNTDKKq4+xtDO466fbkaj
	 MdTrYCDYXDt2/3XOmI89kPLpP1GjXCkETBLzYltjOczhq7mkgqMo+4ERT69iXZ85OYzBM
	 yKZalSClTG+lSunk7vTEDqe4j8WWP1Z1kteuJbIAUFW/JDSXMSgMrJBgMY+KBC9CBIBVW
	 pxeH0YbGJyzFS6TTvZJCoFa14eVvC4wXV0Fb8XQAYLFOhJD6S4f/mLAO/m0MYMZt4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444037;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FIEfwqPEdLR1peP9GpNXpgb1AMo7kYGqg+6f5ry6xZQ=;
	b=Y6tNoyaBOP6UE2ikil+mazE7Kw7vapeqrCrg/pIUAdyN2Uzt+XpMVfUkk1yw65rO8Yra
	 542hgzzcLQhoUJ3i69mSZgh/sXZqdBcn+d4eTTFj4LyWR+h/QhHisxSR5zXWpBkrprTcH
	 d/7r29+f/aAb5ShXxhbtiYbhtvWvT5/1Yk/wsgX/Z3MgXsBqklI6EuWCA/KoRgRGtBvO1
	 QGk5ZWDY/J5bJpexrA8Txd9+TdwgElEGDzKzrLoKBUMmyMgTLRgUr+MaO9avCVrnSIory
	 +HkmklP4hm3QCo+NKCsL+Ti4jYiQu7EvP/FRbOXpMFto7brwGOhsRm53R2lvmfD8cUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMqTM5aq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E92606A335;
	Mon, 23 Nov 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMqTM5aq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B11F000CF;
	Mon, 23 Nov 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444037;
	bh=FIEfwqPEdLR1peP9GpNXpgb1AMo7kYGqg+6f5ry6xZQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RMqTM5aqKIsgIJ5jQlguQl6i3vOAlFN8rFfTlC21AaPzdFzY2zBRo1ZYgM1Z7fEsn
	 rJvk4YLG1GDDBAHIdp2pbxJounVtyQiUlXyCjkpLMR0htc29yUjXWIHuC2xMh2joAl
	 xjYzG20wiO845OuL6Jo17ByCrAvqB6xeqJAwynZaJm9YOHGMo1upidX7pf82n5lmaR
	 zjBfE9WtxCZWUe/B/nswnwm8dUhNzVmzE7uf0XxvGXdifDBmeU5dMsnaP7V3Nq0AhQ
	 lluG0+xEyh/Xau8e6XGFXUQLsOEx6kjEMJGna/ZTt2lttTB3sA9w3ZISVyfMfZPVQS
	 x6n0lS8jMUdjw==
Subject: Re: [PATCH net v3 3/4] igb: link queues to NAPIs under RTNL after
 runtime resume
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sriram.yagnaraman@ericsson.com,
 kurt@linutronix.de, maciej.fijalkowski@intel.com, hkallweit1@gmail.com,
 joe@dama.to, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 23 Nov 2026 14:27:15 +0000
Message-ID: <179544403549.3135.9240068740889565692@kernel.org>
In-Reply-To: <20261119140412.163202-4-antonio@mandelbit.com>
References: <20261119140412.163202-4-antonio@mandelbit.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch's safety argument has a memory-ordering gap.
- [Low] In __igb_open(), the comment '/* From here on the code is the
  same as igb_up() */' sits right above the NAPI enable/link loop.

--

igb: link queues to NAPIs under RTNL after runtime resume

This patch makes __igb_open() skip igb_set_queue_napi() when RTNL is not
held, which is the case on runtime resume. On that path,
igb_rtnl_resume_task() now links the queues to their NAPIs. It checks
__IGB_DOWN under RTNL before walking adapter->q_vector[].

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 6b299a1429a8e..4617aba5759d2 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4125,8 +4125,18 @@ static int igb_sw_init(struct igb_adapter *adapter)
>  	return 0;
>  }
>  
> +static void igb_link_queue_napis(struct igb_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
> +}
> +
>  /* Some settings need RTNL, which isn't held when resuming from runtime
> - * suspend: apply them from here instead, if the device is still up.
> + * suspend: apply them from here instead, if the device is still up. The
> + * q_vectors are only freed while __IGB_DOWN is set, which is cleared once
> + * they are allocated again, so checking it under RTNL is safe.
>   */
>  static void igb_rtnl_resume_task(struct work_struct *work)
>  {
> @@ -4141,6 +4151,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
>  					      adapter->num_rx_queues))
>  			netdev_err(adapter->netdev,
>  				   "error setting real queue count\n");
> +		igb_link_queue_napis(adapter);
>  	}
>  	rtnl_unlock();
>  }

[Severity: Medium]
Is checking __IGB_DOWN under RTNL enough to make the q_vector[] walk in
igb_link_queue_napis() safe?

RTNL covers the free side, because __igb_shutdown() calls
igb_clear_interrupt_scheme() under rtnl_lock(). On runtime resume,
though, the allocation side runs without RTNL:

__igb_resume(rpm = true)
    igb_init_interrupt_scheme(adapter, true);
        /* sets num_q_vectors and q_vector[i] */
    __igb_open(netdev, true, false)
        clear_bit(__IGB_DOWN, &adapter->state);
    schedule_work(&adapter->rtnl_resume_task);

clear_bit() has no release semantics. igb_rtnl_resume_task() reads the
flag with a plain test_bit(). It then loads num_q_vectors and
q_vector[i] with no acquire or smp_rmb() in between.

schedule_work() orders a work instance queued by this resume. Does
anything order an older instance that has already started running
(PENDING cleared) but is still blocked in rtnl_lock()? For example:

1. Runtime resume #1 queues rtnl_resume_task. The worker starts and
   blocks in rtnl_lock() behind another RTNL holder.

2. Runtime suspend runs __igb_shutdown(). Under RTNL,
   __igb_close()->igb_down() sets __IGB_DOWN, and
   igb_clear_interrupt_scheme() frees the q_vectors. Nothing cancels or
   flushes rtnl_resume_task.

3. Runtime resume #2 (for example a link-up PME) reallocates the
   q_vectors and clears __IGB_DOWN without RTNL.

4. The stale worker gets RTNL. Its rtnl_lock() pairs with an unrelated
   holder's rtnl_unlock(), not with the stores from resume #2.

Could the worker then see __IGB_DOWN clear while still reading a stale
num_q_vectors? It could also read a q_vector[i] that is NULL, or one
freed in the earlier cycle. igb_set_queue_napi() would then dereference
q_vector->rx.ring.

This needs an RTNL stall that lasts through a whole suspend/resume
cycle, plus a weakly ordered CPU. One fix is to pair clear_bit_unlock()
(or smp_mb__before_atomic() before clear_bit()) in __igb_open() with
test_bit_acquire() here. Another is to cancel or flush the work outside
RTNL before the q_vectors are freed. Either would make the new comment's
claim hold.

> @@ -4219,7 +4230,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		napi = &adapter->q_vector[i]->napi;
>  		napi_enable(napi);
> -		igb_set_queue_napi(adapter, i, napi);
> +		if (rtnl_held)
> +			igb_set_queue_napi(adapter, i, napi);
>  	}

[Severity: Low]
This isn't a bug, but __igb_open() still has this comment just above the
loop:

	/* From here on the code is the same as igb_up() */
	clear_bit(__IGB_DOWN, &adapter->state);

igb_up() still calls igb_set_queue_napi() every time. This loop now
skips it when RTNL isn't held.

Should the comment mention this difference and the RTNL dependency? A
later change that resyncs the two paths based on this comment could
bring back the RTNL-less netif_queue_set_napi() call.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119140412.163202-1-antonio%40mandelbit.com
