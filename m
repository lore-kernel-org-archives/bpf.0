Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D334447819
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911642; cv=none; b=b+jpwFBgaYqifIMjoRf03ABySJQfhitcGAd4A5uW2cH0u+fwrFDiQJRr0M8eS0f9RwLjOmtvjJzOgtTvxVtFZ+vUbVM1H0hqnlP3sQmeZkAf5eg3JaqTmHvmsEWRxXfW4y7oAoDEJQba3dyf2fn3nI9kpfc7tLLiL5z9ImRqE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911642; c=relaxed/simple;
	bh=u96wPFRDx99Q0kIppk9L7B/0LEE6+HGGiLKJi+DRFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOLNQK8drzt9+K4H10OJwHlFwhL6+1Sq2F0JH7qAAus5cpKurAeE7dH2xUUZaOEYB8DPnHvFY6i1mUYhgZYdyeq0Vk4VweIrQiHbb67/Jf5trS+X+6ZdGUfxYA3JKjX4RiIuVcwFC+6yWIHBXJxHeRi2Rf03rYgk3CrorgxOeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NplHqhkZ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NplHqhkZ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6679d88abdcso604929d50.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911640; x=1785516440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uqFsOykAyNZKnWBbHsCIXaLcv3WJVDWXSwjdj8gA2b4=;
        b=NplHqhkZH7yeUAZM8fEcnxes6/cBQuyoFSq3VSV/DLcTClTVHs2bBrUm0MH+7u0akb
         MzYA+m3ZVfhr+cO7s0Ac6Jx8V3ERCCejdTryqCIUqW7L/vlLfPEpbM/Ec/x8rYFJ4h5l
         Z8hAHA0l0bPFJl9pe6xmukXEkCU4gmFeUfaShO89ucpxUF8UuTctk70YLo21U63Lhp38
         7kLSPrHdDPHbzRdEvUUhYbrSjmKPgPP92xGEKnNr1ZGu3K0YORoPj12/aBcxJOhWU4VY
         usWkf0PD3ZNcq770n2aOCWsSH5oXC8WIqNfi4fCCa+GdCn0UzE6hWxCurBfCEi77x+tS
         SGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911640; x=1785516440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqFsOykAyNZKnWBbHsCIXaLcv3WJVDWXSwjdj8gA2b4=;
        b=jSVOjHQ3px/22mDE386u7ujIvyv1NKYVX7enaHbWSGiEG1AGD2c85rUmu8TpziIa3m
         zx7PI0LfeFbibGGT81pvu/J4jRSK17hWLnGc9GJ1PZjcNXyFfE3y+66pk7o4GNrBp+cD
         4n4GtzzkCAM7OD9id+hSPTDnMzaEpQIqdoiVI5nyoYhwgURtB85H5+ADl1cFmqEqu5P6
         gBMbBzTOsH/MP672TCWf8UgQv4Qn573LAuBtSQj9zN7UxjRAqTGZ/tHxNyEH28xEOeni
         qEHnS6MGsguWfrGPcNkDtWizq4IS77vzB1EWvmsuBJSh9Q/QTzzPowV3/54WxNHjTW8Y
         4c1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqAdGcF6LMYe7pZ6hxHAGAA/LaUT5xN7nJ1Db+v4m+qQIC84IOSQk9x0go2GFmnWvrBw8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbcnCt44E6oOJcrr1tE/Nka2vrlh2Xjys1Ps5mu0OIztxCPkKe
	+VPPGiXK0LQgeFjRyquE/TSqGf/zhboC9sj9BseiOBk7d54Rzufun92U
X-Gm-Gg: AR+sD12EMimNOi5XEBwaBWEeoQqz6vPvtf2s6nQ/nDydb8QTAKF/Hm1LlM9kykoLPo4
	Y+RDNOCD6XROJjN5efFmApVacQbVw4YoZzAYqLm3pDOD8t2e1W4/Ud3c1u1KYwcMbC3aJKvbIfH
	tbcSBoT2wU11Xwm14OsrB1zk6snXcLMaI0fwb9LissC8oDdmEn9BmNIPF79h++gf0pCaGl+SrBp
	KHH/kWdTv4OoFMhT/plIpTl/yDNe5/YflUg9zlcO4WHalRWnuf2JtiYoH/Gr/kRLiOTqmSO+zrK
	f4OizoV2vVLbGuKKRTXfC0+8EJnqPtPiKFTIkuYPXK/5dl0HF8IBxSaDqucdg0K/DX2Bt30KXi3
	QdpM82Hr1zA5EBJP+JfZYXc5afY79uEBMWdJl5MAoa6DzgVEINXgboAyLJmU4GvWKj6CNnmNriS
	JN0vfKE5pS3O7cGF+FQRDdf2SPXEcKfy37Pt9F7KpVXCjj1TWaFMsxJs0UgV+p/I9Ccq9PpDpQw
	gMJ73ZIcAb9sw==
X-Received: by 2002:a53:ea12:0:b0:667:8b9c:e6bd with SMTP id 956f58d0204a3-668a4fe6b4dmr1505254d50.97.1784911640471;
        Fri, 24 Jul 2026 09:47:20 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668907963f7sm5154209d50.21.2026.07.24.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:47:20 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Fri, 24 Jul 2026 12:47:19 -0400
Message-ID: <20260724164719.99563-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
do-while loop without checking its return value for NULL. The pre-check
xsk_buff_can_alloc() only counts fill queue entries without validating
descriptor addresses, so it can pass while xsk_buff_alloc() rejects
all entries as invalid and returns NULL.

  Oops: general protection fault, probably for non-canonical address
   0xdffffc0000000000
  KASAN: null-ptr-deref in range
   [0x0000000000000000-0x0000000000000007]
  RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
  Call Trace:
   xsk_generic_rcv+0x26d/0x5f0
   xdp_do_generic_redirect+0x3c5/0xcf0
   do_xdp_generic+0x92f/0xe70
   __netif_receive_skb_core.constprop.0+0xf7e/0x2b30

Fixed by adding a NULL check after xsk_buff_alloc() and use
xskq_prod_cancel_n() to roll back any partially submitted RX ring
descriptors, ensuring no incomplete multi-buffer packet is delivered
to userspace.

Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/xdp/xsk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b970f30ea9b9..76e0cdd43722 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -301,6 +301,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct xdp_buff_xsk *xskb;
 	struct xdp_buff *xsk_xdp;
+	u32 nb_submitted = 0;
 	skb_frag_t *frag;
 
 	from_len = xdp->data_end - copy_from;
 	meta_len = xdp->data - copy_from;
@@ -348,6 +349,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		u32 copied;
 
 		xsk_xdp = xsk_buff_alloc(xs->pool);
+		if (!xsk_xdp) {
+			xskq_prod_cancel_n(xs->rx, nb_submitted);
+			xs->rx_dropped++;
+			return -ENOMEM;
+		}
 		copy_to = xsk_xdp->data - meta_len;
 
 		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
@@ -356,6 +362,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
 		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
 				  rem ? XDP_PKT_CONTD : 0);
+		nb_submitted++;
 		meta_len = 0;
 	} while (rem);
 
-- 
2.53.0

