Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560076;
	b=cy62hTO7dnzf2TXk8GuSRo9tKzW8d8LJtPb6CORTMDKzSGno/zyHhSZyitVZ+mNu1pBQ
	 4JiQfQrQH8RMtbc80pqH4UfhioWiHsOFz3G4vLBUutawz/cOfzMpFmxFmI39uVLndjIV2
	 tcli11fyhUEnsfiM2OgSMEctBOijNoJN0615lpe16om+z0Tl0Qqx9rWfxO+hplSuPUFDB
	 U+eu9iHQIMxCLowYBcnUJcexiZgbOtJW/4LphQiicn862MaZVR27C8kEwXs3m7/DPVDMo
	 FZlxjwBw/yuLFclHFXyL5E/zw4FY3RX2Q8SDnijNgcWFnoLma69HgkphhsVWcDVAdfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G17/r5+gfb0brPfboLGHK3O5BHFPdOD4rw96BSh3q40=;
	b=Hon3ZilipsiMNDA2xtuG8VNh+rqYWu1ibuSZ5vmVJLc85/DRUodHuO/g99x8WgOEzgqB
	 kdZAoS6/eXImj8CLLMBMTSwDOyD1qAIg58rqg+cECqTQ7jBeQgQKVU4CRjVkpGU9or59N
	 Lif67SHuWuy9I/x7grVxgRVmUKjjHPJIJK1o+kP4NHS2seCrMYLQt4zQYmq99WdWP4Lf6
	 e8d8XjXb8s8+DMMbmBH0orw5nc+x0QzCjE6z3JgbOMZQRb+YziGNhpIjugtqyKVJuYUi7
	 qFDslh758sL+9QArr2ZIDZsNRsVdxm9X/oxh1Hdnphy2lCGG+WZDEnAATy6X5imuE6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRZKZ1ib;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFD606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BFD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRZKZ1ib
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso762062a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560075; x=1794164875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G17/r5+gfb0brPfboLGHK3O5BHFPdOD4rw96BSh3q40=;
        b=yRZKZ1ib2kye8ldNVcU1Y7qUkP/Uz+LnTEF1hJ6tzrY3oOiqYuMn1pgHS9ZOfXs4UF
         NZ8FmtJCuIOhRkvL0jSkMu/jrpVb53jztWcT5ydrrkYaUzO5rrnuV2eD/RNZ/Vhc6tsj
         n02iZLLUAJ/fkMgPcO0RrFSGD4Xjp90outg5OBUy8HCH87JlDG+TFFYcrUqi1gEkwjNp
         OTwrPNWgpoQ3rbJ6DZmJI9qAP4zyqCEfH2iceWOieSNUuqjhm98YX6tR7R41BJgRk0DK
         0uW0cIQiEzEK1GccyTRfN09rSrHnNyLEPgC7IPCvX+cSzehhnF16GnvxHgpVNsm0qol4
         OLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560075; x=1794164875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G17/r5+gfb0brPfboLGHK3O5BHFPdOD4rw96BSh3q40=;
        b=v2ILDvdaNg6SCU6jwTLNUzzuJLOoHm452TFmueVDOTdKmo9QfazAxKQETdZB2hwUfG
         taDs5zwyS7maYGI1sLq+rTLbvKel4e6I6o8OpFBCfrMKjSH44yVans6Ry+yL7JNZFs5C
         lpoYM4EZTRp/NFeZ9jkZCJYT2oyYWrR5U6lWKWN62M+f3m6EkiiW8JkFs/f/cJy9UD5i
         3RzkB8RqUGYy0pqDCc0FAJfhioP+ws7WnGylhhrPdOctRLWb8Fy6oKwjNjeFpGg+qcLi
         oGO4vokFmHwWU6aQd6hfcdpidgAEZkr11QJUTzbDUUhZgzaY8B94SNejM77+oCvjb2Nf
         x8Zw==
X-Gm-Message-State: AFq9FYI1BnwTwPjElILzVBng8aroyma6LYbH3Kkr0+HYuavzz9kVt/su
	vXDDbWEc8ZorHGjQc+KsBQXHCPO2c1mwGExq1JyBL+vJVnLvc3/Q77X9ug8eOg==
X-Gm-Gg: AYBFou0sPCXYXmApXid6I2NpTzioycZzXR9/fKSbqZ0JagoC0BcqlTunzK+0yUwHp1W
	0msxMXDv5nJ/bsIjnBwmS2/12o4E/CmlkK8Np0uhp2gl2FUmVsCNnFwzyFxjHGmvB2USscmRI1t
	ziXqk2PvIvO1q4ZqUMSJkM7+WvfB3mxiFI8ZxyGz+uaxl5RN5YRzPprfi7x4QYlrZ1Ko1KiNgSI
	a3rKE3Ep/Vl0gakp02jDQFWgFRsC27KSbfeTQ0bDQfKvXVwuswUMnBL/tn4sMkhqdN10e2Wllca
	4rjGmXnhjXUGC3DSovI9PDLh/tvAUxQO4+ZjyrpyWVIO1elEKXFOpTD0X0whukAceAlVLa4fDPK
	NaexHq/fa3bM3Vz1slaYZTova2z6gDKn3L/PRXM/C60APo6ndt2demWc24vhB28OAFBDdJ4ezvq
	lyZDng0rnNsDdU1lYmiGHlJAGWdl2re4f+drBMWKzZ083S4mwcdq67EI/J4pyHiAW//B2QZRdks
	OZbv7V6zFK8Q9YWp7JEvF09fjUcSMgzHFaVo2F6w/VMdJqI5KhDyS8FU8Uzifbae5AEo+vmoa7i
	g4M8vb1Z7Mo8yp2vmaNuR5TMXsAJwW25jXiysUWPV4jdrAk47v8le2NN2X062dhcyxSTckb+F21
	nx8gQrmv0noFSr2IMcxAllq/2atA2pPwGIPNfsjWRoE1jIOEROiUrGI9XpoJPAGappqyYSqxxKw
	==
X-Received: by 2002:a05:6a21:4d8c:b0:3e2:a935:8bc4 with SMTP id adf61e73a8af0-3e928df1650mr6611815637.13.1793560074914;
        Sun, 01 Nov 2026 11:07:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096fcf15sm2172533a12.18.2026.11.01.11.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 23/27] bpf: Require BPF_LWT_REROUTE when an lwt_in prog changes the protocol
Date: Sun,  1 Nov 2026 19:05:31 +0000
Message-ID: <20261101190535.1454146-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When an lwt_in prog returns BPF_OK, bpf_input() calls orig_input(), the
input handler of the route. This handler is for one IP version and needs a
dst of the same family. But BPF_LWT_ENCAP_IP lets the prog push a header of
the other IP version and thus change skb->protocol. Then the handler reads
and changes a header of the other IP version. The push of an SRH also
replaces the dst, because seg6_lookup_nexthop() puts an rt6_info into the
skb. Then ip_forward() uses the rt6_info as a struct rtable.

Drop the skb with -EINVAL when skb->protocol changes, as bpf_xmit() does.
Drop it also when the family of the dst changes, because skb->protocol does
not always show this change. Today no such skb leaves as the prog made it.
A prog works as before if it returns BPF_LWT_REROUTE, or if it pushes an
SRH on an IPv6 route.

The commit in the first Fixes tag lets a prog change skb->protocol. The
commit in the second tag adds the check to bpf_xmit() only.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Fixes: 3bd0b15281af ("bpf: add handling of BPF_LWT_REROUTE to lwt_bpf.c")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/lwt_bpf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 3a946e8709b1..60f4eda7dae9 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -165,6 +165,16 @@ static int bpf_input(struct sk_buff *skb)
 			bpf_lwt_reset_cb(skb, proto);
 		if (ret == BPF_LWT_REROUTE)
 			return bpf_lwt_input_reroute(skb);
+		/*
+		 * orig_input() is for the old protocol only, see bpf_xmit().
+		 * It also needs a dst of the old family. BPF_LWT_ENCAP_SEG6
+		 * puts an IPv6 dst into the skb.
+		 */
+		if (skb->protocol != proto ||
+		    skb_dst(skb)->ops->family != dst->ops->family) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
 	}
 
 	if (unlikely(!dst->lwtstate->orig_input)) {
-- 
2.55.0

