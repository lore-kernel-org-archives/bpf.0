Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604439;
	b=XtPWCD4O/N7i7ZCX+R7yzZ34A5u2GHBAeh355/eQzXPww2GhPm1A6NyAoXeoAZ6oJspb
	 AFvKDtWts8/OG6XYy+BEsBd9WOmoVUank6tUUSq+QJE7LL0B4jCXz8VcPd63wfWZ64Bab
	 8huAbPHWqezEWPCWMP/IuNX9zKkD4i1QX8kd0PmgPDxopGB+t5wCci4uZ2jTxRKZFZotZ
	 neBL5CyNBeKDFccRlzGeB0SB1NDZPJx8NzVVHdHEMZMFjLkG0k+Ch6du6DzxcRz/5T6q6
	 a+oS9E+O0X6idGQZDWQ6QBnSwXW2i0T8HU1yn9g5ZCw74+p8d0yWJoB2e1uxYoi1j7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=00X3tkeYEageGUPFxKdI7i9tn0PnsQa8KK7nyWnisf4=;
	b=Btg5/04Aae5oD0ymAtSMuMlWSd0rQkO5UR3B7rBYKzoO4wlyb7kduWnOwEIukUj2ACTO
	 lKMdiGr34krMoqLtJLIkPWchtrZsuyM+zSrIIeUSl5VaKStfMYtguKmhMV78cfDl62ysg
	 djR7+I6AymwxcJPBxtK1A8rgoAoSySW9ZjGyz/0dTY3HChmSVv817/Pwk1QdMaoKy0zmx
	 DmhdMgZ1i6/k5EwqteNSdjLBkdhj2gDQC2h4hxlZaZx1VLAF/+Iuh68Kv6gbFmkPRvvJl
	 v+bPZIT/GhjuiMgUko3VuuHI096p4pGH0EBp2seHl4UxQKZ5KULIFpEUqprPSsUzqcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a6mbPh4b;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D633606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D633606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a6mbPh4b
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso6714555ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792604439; x=1793209239; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=00X3tkeYEageGUPFxKdI7i9tn0PnsQa8KK7nyWnisf4=;
        b=a6mbPh4baF5S+XvtoMt5BFfbKPeHhZgNSoYnmMmhUBYT/dBZf9DU/4q53r43EndSXP
         RWGdz0dw7Rj23sSAJO2BH+cHasq9kNE4O3omu26ENerB4UwfTAYubhTV5YdUM5Tosk44
         I+AMoABrAg8C0wPPjaRPy7Tqtw7mA6OBewbE7AEYXqzNXCGAKiBcby1XI46dtyWQ1eQ9
         7k6AGOu+X3E1mOcXLPdyuwxZnG+Kk1YhwneMsV5kNqQPv9EhusXK/6tJhdcMXnkHvOjn
         dDiUJICzxLAlqaNUdU8n8LlOcTssNrg4KM5TFqTVaZHr/HlNdg1IX6XUNfAqXQKeagyO
         HgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604439; x=1793209239;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00X3tkeYEageGUPFxKdI7i9tn0PnsQa8KK7nyWnisf4=;
        b=mHx8WtfzjW+RjYtQfjMKwD1miCgsqBb0vtflOdtduILrPE2Z9C3WnZgRTDvFMxl8Dd
         6robXYOcpENo1rPO3uv1BLsVJNeCl/sSFID7AxYXBxvUkJyq1nA4zQVwN7caR50Bu6AO
         4/tmzpcLCkMtpbDV8NjftkQIK49f28lgldQSCA6RNWUlmbFPbZquGdabCibKg4G7I5rx
         tgt/JB7uH6RJHfsl6r3K3sbCStRF/mMRoU3/kY9wUwnblSxtxkb+2t6GsWppz9c0CDnB
         6nYFR54ldTkD0GXV+49o3lFj2s8X6QCQDdC3eqFl2/s3XPn3o9uTGmyLX9zz5G9UkbzQ
         1ioA==
X-Forwarded-Encrypted: i=1; AKwUvBxKZAa8khlBTnNdUE3nDiqumXUiu4UkFmqj118O1iUtHGjruLVolI3JNhxoY5O7pcSF1Nk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXmOW2AAG3A2lgc4PXBiA+gR5HqXloYXOv2WPJW216qdkkyFtj
	6H4YtWgNvr7tEaF0KqTDEhSCJYAcbfdwBUdgjxpRwLYDdZCBuIehgn4C
X-Gm-Gg: AYBFou0oYM11Jr21watlJDu1v86RaBVSOERO61x8igGl+kfuK7BUTdp1vqGsYNDOVP+
	DVY5ZFUNXDJGDNWPG8aK4YcsYEIiPqQyUmQ80RtoQGjOs53hDrvOWX7WKFBQrYlqcizS4uA/FP0
	PPMaaaX7SnKfPGAXcdeVUt3gMNABvr5ZVh2H5nVG9yIIOEhnXSl5WLlktt2Kmdgjyh5Z/V7p6qa
	EGsFEghStaEZeAvLXXgD7QromTNPlzXol/N++P3ewHx3z9aHh0Sh/Ox3PLX1+Ni1FE9rK1aCk5o
	KOy6o6vbcx7qPYnQ9jx6a3om199FKfymJXyyvntss7jC+hBa1b2UGphwWOnr2WqF8AzN0ngW5nA
	QQGCgUkj962Ge0lzjCXYyLpHnPmLGRBuXpAqPxtpY/Dtv+ZaIjx5xQFxgVm61/TeplDn/ctmqvz
	On95QiN+xyfTj8Lw/oonPXXDddu8vaPg3MMI/MPb03VfllR580YcEklIu4/JtXZqVs5MKvuy761
	pBGGgdHD76P9h8utaOaWn3R+edCO9BSHPoW1+Rq6nq/ttz8Wj2aZFMmDAbXXwd+ye81UiyfXkAY
	w8QmoVT6LaeZKtRijTi60fun1h4LM7RjM7+VwITxQjC+Rggq6busdb/lqGdv
X-Received: by 2002:a17:903:26c4:b0:2e8:2d05:9780 with SMTP id d9443c01a7336-2ea437a6be4mr22440335ad.8.1792604438573;
        Wed, 21 Oct 2026 10:40:38 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b41096bsm15144615ad.26.2026.10.21.10.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:40:37 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 17:40:36 +0000
Message-Id: <DMAP8LNBJRPN.2THUHLKURP25G@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] net: return page_pool frags to the pool in
 bpf_xdp_shrink_data()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dudu Lu" <phx0fer@gmail.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <20261021155645.69120-1-phx0fer@gmail.com>
References: <20261021155645.69120-1-phx0fer@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Wed, Oct 21, 2026 at 08:56 AM Dudu Lu <phx0fer@gmail.com> wrote:
> Before falling back to __xdp_return(), try the page_pool path: if the
> frag really is a page_pool page, napi_pp_put_page() recycles it through
> the pool and we are done.

This makes it worse.
netmem_is_pp() says that the page is still in a pool. It doesn't say
what kind of reference the frag holds.

On XDP_TX and XDP_REDIRECT veth_xdp_rcv_skb() does get_page() on every
frag in veth_xdp_get(), consume_skb() drops the page_pool references
and the frame leaves as MEM_TYPE_PAGE_SHARED. A frag of 2k or less
shares its page with other frags, so the page is still in
rq->page_pool when the prog of the peer trims that frag in
veth_xdp_rcv_one(). Today page_frag_free() drops the reference that
get_page() took. With this patch napi_pp_put_page() drops pp_ref_count
for the second time and the page reference is leaked.

Jiayuan's v1 in August had the same check in the same place.
See why looking at the page doesn't work:
https://lore.kernel.org/bpf/01fd251d-1134-4251-9c11-79943e367ffe@linux.dev/

rxq->mem.type has to be right when the prog runs.
v3 of that series adds a flag to xdp_buff for that:
https://lore.kernel.org/bpf/20260911135711.109338-1-jiayuan.chen@linux.dev/
I think rxq on stack, like in cpu_map_bpf_prog_run_xdp(), is enough.
dev->_rx[i].xdp_rxq never has a mem model and in
bpf_prog_run_generic_xdp() the frags of a nonlinear skb always come
from skb_pp_cow_data().
Below leaves out veth. It needs the same for skbs, plus
https://lore.kernel.org/bpf/20260917185814.0f944e78@kernel.org/

Something like this (compile tested only):

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e..ecdac67 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5542,6 +5542,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
+	struct xdp_rxq_info rxq;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
@@ -5565,6 +5566,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	if (skb_is_nonlinear(skb)) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/* The frags came from skb_pp_cow_data(). xdp_rxq is shared
+		 * with other CPUs and with BPF_PROG_TEST_RUN, so use a copy.
+		 */
+		rxq = rxqueue->xdp_rxq;
+		rxq.mem.type = MEM_TYPE_PAGE_POOL;
+		xdp->rxq = &rxq;
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
@@ -5577,6 +5584,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_eth_type = eth->h_proto;

 	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	xdp->rxq = &rxqueue->xdp_rxq;

 	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;

xdp fixes go via net tree.

pw-bot: cr
