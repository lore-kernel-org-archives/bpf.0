Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF7259CB2;
	Wed, 18 Feb 2026 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374850; cv=none; b=vB1sNZ55PCRF+0ZDujTu03wQheXspvoAydQLY8HON+UsYRMUT2FQ67863cSoF0ej9JDU82fd+VS03nBK1SCJL9CLZA3+87S0M6k7uxClrw5vUBfGe3HGmh7Si0eMQ2VDmk7udj9jC+P+lG/Fu/x8K+W7cEGRq8rzo+2nxnrx3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374850; c=relaxed/simple;
	bh=yB0tQEWiCFqYLhZPbyGnhRDK+LkRBlNQcvhvviUeqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnepkhQwKtjxUFir93kQ7KAq1Mrv4q7GTSzCWUspmNOIur0PfJik0zRs1rNgyYMzDeK3SnbcoRMnB/Co/yfZfxdq6+GMNuBYcIX03gvHE/v1gipXzDDgbDpklXQUsuvYtlHxJIKtNaweNx8QwUd0jTZSv1AeMfDLasoZOBa86Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO+TPqOV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO+TPqOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF76BC4CEF7;
	Wed, 18 Feb 2026 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771374849;
	bh=yB0tQEWiCFqYLhZPbyGnhRDK+LkRBlNQcvhvviUeqgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SO+TPqOV+ja51p83+LaEU2+oyJrVMspfLKyzV/vBCHH5S3/UtMmAKFvIpnNciNA5N
	 HbBu44pOaiIvNH6nAewtLwudXHiaa1fPbfSnJc0QirjFTkC7DNSU/dJ7pPiaw28JSq
	 YI+uqpE2OoUfudteKfpXpY6UyJNci6YwVPvFEANBSRw+fkYHwhKBDvfTsPB9ORUSly
	 IDBcq8gX0Y8yMXECISffybJ4IUHhAhNUni8M5A+vLFzUdPL4JwOmfX99lGw8UaqwZ2
	 voB6aBNgRlxoWtHhTNHCGwHqBuwQe8+WxldFP4kdThcIRMrMm3KqMzgq1fD1CX23c1
	 TEACXLi9M50VA==
Date: Tue, 17 Feb 2026 16:34:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
 bpf@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v4 1/5] net: sched: introduce qdisc-specific
 drop reason tracing
Message-ID: <20260217163408.2afc1921@kernel.org>
In-Reply-To: <177125582938.2500844.3162442443588680144.stgit@firesoul>
References: <177125575993.2500844.8718737675156179479.stgit@firesoul>
	<177125582938.2500844.3162442443588680144.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 16:30:29 +0100 Jesper Dangaard Brouer wrote:
> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
> 
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
> 
> Convert qdiscs with drop reasons to use the new infrastructure.
> 
> Change CAKE's cobalt_should_drop() return type from enum skb_drop_reason
> to enum qdisc_drop_reason to fix implicit enum conversion warnings.
> Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
> SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
> comparison logic remains semantically equivalent.

net/sched/sch_dualpi2.c:594:12: warning: implicit conversion from enumeration type 'enum qdisc_drop_reason' to different enumeration type 'enum skb_drop_reason' [-Wimplicit-enum-enum-cast]
  593 |                         drop_and_retry(q, skb, sch,
      |                         ~~~~~~~~~~~~~~
  594 |                                        QDISC_DROP_CONGESTED);
      |                                        ^~~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr
