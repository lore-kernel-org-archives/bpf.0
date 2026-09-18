Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116F2C21C5;
	Fri, 18 Sep 2026 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696702; cv=none; b=hUOFyrenqOO+4hvvJxhvQ90zDoyGdmYnVE3VGljEEN22MUm8V+EmOrsi4Z1KsCGR+ZfRa5zf+Eq8DrS6Ya8HucWwIO2+RG5zqgiZTyBFZgQp1zsi8un8ArOpjmS03rOBO8euXl+ieiDlSlg4wtZCjjmtfHrqfFldcCvgVsiGGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696702; c=relaxed/simple;
	bh=610RdKKW1k8JqtrGaMlGVmw1Cz7bGsDX9t/8H//+p8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqYnKT/zwbUT1wnJ4m5YoKtF2DfjEWRJOhK+ug0prxG0oZayZq79GSpzOx6fyuxQDq9TpjX3wbmSkoM4NHTqnetrUluHA5FVoeNfItNycXQEL+Vqbf12xS1cw+sVAuNg70hKxyd1Ffyr7NmMwsfyLeVIqtJiQmlA2GXcRUL0nmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORTnwf8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORTnwf8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8951F000FF;
	Fri, 18 Sep 2026 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696696;
	bh=pzjpAtyiw/1Nf7WU2WJ0sXYhMWr8adFLZXcnokdDmYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ORTnwf8Qan7G9c/7mXFgFlaU6eP3jvLNd7VSm4NC2C+hTkzhrB5swfgpe9cf4Lh1D
	 I3QeFgVB0opsprgGwy7SUU1gUIFflr5yF5qTG0EipR1RQW/h3VNtEXaBI0v5aiFeoV
	 JUVwMtwBI5NwnSXZ5vyDURlUcrbmM6mI7VhXpU1CQkCJO75O6n1tHVLoSbwC8W/012
	 ERpBf3MKj48uzeHXYtA+WfgBGWrVZMW751kYGQvQKPiFRXhcQRoYo+d2vNYGxJqgMO
	 0FuhJ6DGqrHXpf/HHcbyIb8Dj2TwqeIUtV5iEX8f7TkxLtn3gLPTR9EdpuuYl6ktpY
	 1jO/rckxqy92g==
Date: Thu, 17 Sep 2026 18:58:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, kuniyu@google.com,
 liuhangbin@gmail.com, mkarsten@uwaterloo.ca, toke@redhat.com,
 lorenzo.bianconi@oss.qualcomm.com, echaudro@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
Message-ID: <20260917185814.0f944e78@kernel.org>
In-Reply-To: <20260918013128.3451350-1-kuba@kernel.org>
References: <20260911135711.109338-2-jiayuan.chen@linux.dev>
	<20260918013128.3451350-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 18:31:28 -0700 Jakub Kicinski wrote:
> [Severity: High]
> The new flag only overrides mem_type in one direction (towards
> MEM_TYPE_PAGE_POOL), while mem_type is still initialized from the shared
> xdp->rxq->mem.type:
> 
> net/core/filter.c:bpf_xdp_shrink_data() {
> 	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
> 	...
> }
> 
> The commit message says veth's rq->xdp_rxq.mem "is shared per-queue state"
> that "can be clobbered under a packet still in flight". veth also writes a
> frame's memory type into it and never restores it:
> 
> drivers/net/veth.c:veth_xdp_rcv_one() {
> 	case XDP_TX:
> 		orig_frame = *frame;
> 		xdp->rxq->mem.type = frame->mem_type;
> 	...
> 	case XDP_REDIRECT:
> 		orig_frame = *frame;
> 		xdp->rxq->mem.type = frame->mem_type;
> }

I probably lost most of the context over the months, but for veth can't
we simply: 

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3fdf1959b76..14dac44487ba 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -653,6 +653,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 
                xdp_convert_frame_to_buff(frame, xdp);
                xdp->rxq = &rq->xdp_rxq;
+               xdp->rxq->mem.type = frame->mem_type;
                vxbuf.skb = NULL;
 
                act = bpf_prog_run_xdp(xdp_prog, xdp);
@@ -664,7 +665,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
                        break;
                case XDP_TX:
                        orig_frame = *frame;
-                       xdp->rxq->mem.type = frame->mem_type;
                        if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
                                trace_xdp_exception(rq->dev, xdp_prog, act);
                                frame = &orig_frame;
@@ -676,7 +676,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
                        goto xdp_xmit;
                case XDP_REDIRECT:
                        orig_frame = *frame;
-                       xdp->rxq->mem.type = frame->mem_type;
                        if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
                                frame = &orig_frame;
                                stats->rx_drops++;

Local agent digging into the "concurrency" claim says the only
concurrency we can have is with the teardown path where we unregister
the rxq without stopping NAPI (probably deserves a patch in this series)
