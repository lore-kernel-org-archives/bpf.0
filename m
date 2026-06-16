Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D4426ECA
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607559; cv=none; b=gYPB70x75Bi8mFTInNVUqDaHnQ1MIqoXPW9aXGTNCaUFojp0d9rlEqfBPi74TWLIiSgx3mMhHbAZFRu3eNosCAE70BvNtFyaeemGeHu7Lt2n56Es+OPZGblBCU5+GFwzSjT/W04mODQIMaXY7IUvBzDdxsUPd6R9486wiYwFW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607559; c=relaxed/simple;
	bh=BYiitEcXHhRh6eR+a46Lb8G8JNceCCN8CajnI0gLC0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJ524Dl3bb/5QHR3OQTnwFASqxza/r+pEpzDK+AjOAWsHgd3JW3JGJXayE2t7wK3dbO2570G6GuAX3+/bftZhWDrs5VhIjtB6qepsf/Mr4e/SvMy/qKbuFrlKf9ja8QARfQzKlqWUJ8CV63cM+HpCdopto8aMqDfV5iBmZRB3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz4/3xcF; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz4/3xcF"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-bec4639953dso730380466b.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607557; x=1782212357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBInyREsNJJq2tfrHgYP7popCDV3FF08GB9ZJkZM/f8=;
        b=Wz4/3xcFxSEDbnfYo/5iJ67sYaZec+0QGGxA3BVFa3c4HqZQUHfXVfpiyc8fzo2cwR
         YYIFwmPUiXWAaVu0jhNcRSVJuDKI0yTrtIPMKf/Jdx78234KspOn4WWYwOKSX0C9FU3g
         gThfv2bUE6XVO5ijCJnSkzDq4khLzbaaQSGC+bcfuipRP1Ui/42be9wotXTHTiFYvoj2
         yyKbRdm1gprdcjuoCTDQBQcbLGS/clULujUGoApfALz9hAAITioKT8vU+jDI26nogD0H
         Xd25M9NtW4rK4MAwSjYOUjRt205cmRNUUuIwA+vKp1FsleVD3PGmIFS2XgmMC4PgMh3D
         WUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607557; x=1782212357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBInyREsNJJq2tfrHgYP7popCDV3FF08GB9ZJkZM/f8=;
        b=ajj9vzz5FiViYc7CDyjGUD3suOp3ktX225vWOQWLNjdM9rYsqDacrtlzAPTzTXUrXP
         32LwbYeWoW3PQe9KEyo2wq8lYtuKVa7vzFMg+xo2hbvhqdTTieg1lvGj50c6WYmDnMGz
         Qi8lSCxKCzjXtZbruc1vd82qi+tZB6QBNnNDDPbotOVBlFLoigCqNG6HamYvYA0gVcHQ
         fh07RGeu2WCt8S8UXonidJQdm6ciUInHSUDhF90Mj+cni9sYLwpMbb9xfECEioYDrgdB
         d3uw50H00HZPZvVAxxDQ2lZMRiFtX9TrkBbqP0S7nyqor0uv5yPLK/xwNOr0uf2RCSYS
         MUYg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZmhsXygslwuT1Lo6h9bc4Ww4WrMR6oGYdNFXzMY2QRrtFjrpY8s/RWDpxPcCHlHeHhGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0XIETqXMJ5EwHbanSOFZHJWYCmWCyFJw6IiAlQJjXn+zRnUu
	SxgVrZF7jPr3wGj4giaKWUB7B4ZfiLXdXPAfw90WkcCAenaxaQuMJHNZsXkHzTvRJ4ukIA==
X-Gm-Gg: Acq92OE04axBsrsc6B+aPP335P8aRnJLJlDq72TCPWYJUzT1zcl0C/4H/EYHOCMDStj
	1x+ZVFCffptPwFJ6TWlVAu+feVnoSTY2ygKt+Wc6M9q/kMZu9W/DG0QN5Hhetqz1lLkh7tQVq9Q
	gVzvpq2F0PMT5eAiHKfUD7QU3bOW/JfvbE70EnUalZiK3/IS3D6CXWV3/7uZ46TrHNcHeRo2YFV
	BwolDssUDbNTQnSX5qnGThlmEy0JnirjBLGVDzZHA9y6lBAioilJ8PbOWg9kBIPwTJKjO2ve0tI
	8K1UvlQ6al4b4ZSbPPHH4Q1lCTAC/2UgRNWVjjvBq4oLJ0IfaW7QMkzh6lCOB6grpMG8dzoHCQN
	YGtyb6vd6sv4DC7gpjHhUL7GLkvKY5vgBHLaPZ9ic/dSZvQ8HaAsw5z48+aopFllJi9TjJBuMqC
	tVTLH2GJsrz91jaVTzrKxY+aOTqnnNUCYxi6grFKuIyhtgy8KjHsFnP+Kej9LiMizvm8r2
X-Received: by 2002:ac2:59cf:0:b0:5aa:6c2f:2a20 with SMTP id 2adb3069b0e04-5ad427a8bf2mr621532e87.30.1781600513392;
        Tue, 16 Jun 2026 02:01:53 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1715d4sm3301048e87.34.2026.06.16.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:01:52 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	lvc-project@linuxtesting.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] tap: free page on error paths in tap_get_user_xdp()
Date: Tue, 16 Jun 2026 12:02:01 +0300
Message-ID: <20260616090202.693916-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2 upstream.

tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
and returns -ENOMEM when build_skb() fails. Both paths jump to the err
label without freeing the page that vhost_net_build_xdp() allocated for
the frame. tap_sendmsg() discards the per-buffer return value and always
returns 0, so vhost_tx_batch() takes the success path and never frees
the page; each rejected frame in a batch leaks one page-frag chunk.

Free the page on both error paths, before the skb is built. This is the
tap counterpart of the same leak in tun_xdp_one().

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260521163230.1478627-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2026-46320
 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 6fd3b14273b3..b51ce7af1b20 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
-- 
2.47.3
