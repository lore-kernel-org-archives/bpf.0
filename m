Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925301FB1
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953629; cv=none; b=n9sAQzXBClHlfXrzqnRip64Ib1jhLCsoKTD/5V0paHSVmc1Q3WQrlgz/XiNxlMTBoXKaDOhtXz6BkwWqttb3BoBTwJFjwfIsg3IGd6mQd8/qKEgKp9ewdryDcBCIG7tPdyAUvzHBpFGGw6yc65m39DHsS992W84hRhX5WcSNeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953629; c=relaxed/simple;
	bh=kW7an51eJvpDHnNEGEBNiNBe0YG9V2ThTRygTdGHdaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwd6h+16Jt1bLoB/zv2+glvs8f/F0+N8Ew6OCrspqZ2OGF+oagvd5Oe1g40cvDkfMNpRKRB++dYHI0ua8VmuRSNJ0QpTnGCS9Q7lIzLH552vRj0X+FzF+ck2MxzpSsonA+jt83RuI0h+tNFdLsBmVZYzNvAdOrG7VGDVWNDLE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA72KiGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA72KiGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CE1F000E9;
	Thu,  2 Jul 2026 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782953627;
	bh=zJsg1voSa11wkoutyDOPQCiUpK1rwwDyKvj9JUcdZN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZA72KiGSyp3yuqmkgoLmags13/amt7Md63HHDZXle4WChuf4UvFQAsewXfzXxhKUO
	 A8gWjeClEZNIwXylvpqyjlHDZKExVRS8kdLVacdlm2Bzyeh2zgzD4WSSqfEgvwTMzd
	 srztJDE0+byGvauAmVtmqTiO/996H9lSw86wT008Bhy4eysc0AQ1/K3R1irMDJEJeH
	 Do9yc8g+Jbhzts2/Ih1GIhVJyrafRzlZYmQKpHsknDKUmxoerjq7QzvJjFgRxbWTdE
	 tUq+V5rN+iMZpA9xE9hCE/ZpwKv/lmnzVQbUUfonRvSaM+3yHCdqxEaMcyZF4xJf2c
	 XoEeXlp+3R2WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] gve: fix Rx queue stall on alloc failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701005341.3699161-1-hramamurthy@google.com>
References: <20260701005341.3699161-1-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 00:53:47 +0000
Message-Id: <20260702005347.893CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Updating u64_stats_sync counters from process context without disa=
bling preemption causes a seqcount deadlock on 32-bit systems.
--

commit 1e50350a60c2a580ad86412a4cff5327452afdc7
Author: Eddie Phillips <eddiephillips@google.com>

gve: fix Rx queue stall on alloc failure

This commit introduces a starvation recovery timer for each Rx queue to
prevent permanent queue stalls when page allocations fail during the refill
loop. It also adds an ethtool statistic to track when this starvation recov=
ery
timer is triggered.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 02cba280d81a8..303db4fa677b3 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c

[ ... ]

> @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>  	}
> =20
>  	rx->fill_cnt +=3D num_posted;
> +
> +	/* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> +	 * visible to the hardware, and no doorbell was written, the hardware
> +	 * is in danger of starving and cannot trigger interrupts. Start the
> +	 * timer to periodically reschedule NAPI and recover from starvation.
> +	 */
> +	num_bufs_avail_to_hw =3D
> +		((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> +		 bufq->head) & bufq->mask;
> +
> +	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> +		u64_stats_update_begin(&rx->statss);
> +		rx->rx_critical_low_bufs++;
> +		u64_stats_update_end(&rx->statss);

[Severity: High]
This isn't a bug introduced by this patch, but it adds a new instance of a
pre-existing issue.

Could this lead to a seqcount deadlock on 32-bit systems?

If gve_rx_post_buffers_dqo() is called from a process context where preempt=
ion
is enabled, a reader thread (like a netlink get_queue_stats_rx request) cou=
ld
preempt the writer thread while the seqcount is odd.

On 32-bit architectures, this would cause the reader to spin infinitely in
u64_stats_fetch_retry() waiting for the seqcount to become even, deadlocking
the CPU since it won't yield back to the writer.

Would it be safer to disable preemption or use
u64_stats_update_begin_irqsave() here and in the existing rx_buf_alloc_fail
stat update higher up in this same function?

> +		mod_timer(&rx->starvation_timer,
> +			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
> +	}
>  }
> =20
>  static void gve_rx_skb_csum(struct sk_buff *skb,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701005341.3699=
161-1-hramamurthy@google.com?part=3D1
