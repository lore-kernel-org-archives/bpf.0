Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEE3546E1
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468260; cv=none; b=f6ciqViX1WSHIYwBm+EdKPkbUNF3cCQJT0Tv/IETXM/JHHwK2u/Ddiib9NrNGoepcxwMzcgnDGWv6Pererzbrjx0nV9Lj6ys8VgkZF6SZMZFQONAlb1uWRrZkJI3i0jqT34/mXmAQKevfdnRCdPCoiRvPR7P4GL4ugjucr6Xo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468260; c=relaxed/simple;
	bh=RTtDn8xLk4cqizbu/eCai5rh4lCOJEd4o/Ihvcc9P4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvFDxnPN1SNwW91R9t9v3RSHX/6DlxmN9xIfqE+dF0XV3gaMhIyFwxtdWbkoqgBCfifOOWa0fS2gegB23O9Cojv0pS9Wv7IRYv4AbOUVho1S2e32A8J2ygx3q3GlU2IzGDJYekygFupT7+EKyvsi3BR4qt3/g2+NKaN+paq7v5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmdZ0yvB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmdZ0yvB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so403859a91.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785468258; x=1786073058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgtOPZlcFx69TNmsMfc9ttGlQcFwyZj8UdAlpvl+1TI=;
        b=SmdZ0yvBbtiIENE8Z2WPaMJSFNd7b40OaqtYAM//jmikx8JOAOlxmfRSSJ39sNy+HH
         yQOsEU73smnNdL0JJD6sL9UMLjBQ7GGAow/S3+dmuSsaLaBLiCzJHhywoN4EiefcU+DZ
         2mgWj6QxrWfeMQENNNKcRxq7yfsY1j++glUG6U6Olzjm2tOKL+UYmtku/YON12jfbOxl
         2RaE1LfUo++hyYfxnpr0bSXi2y/oKAxkoU20c480Qp+9mJu8eGZ1QKxZps816r+28fDH
         AKqIpaygnjxvMOVEcWt1AVMgSpsUjoS2ZH9T2UbqNMw4JLtCtstLBhh4SDeqoprjWIGL
         WygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785468258; x=1786073058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgtOPZlcFx69TNmsMfc9ttGlQcFwyZj8UdAlpvl+1TI=;
        b=E1bR8JtvubZ/q9OrK02yKyaxnqABGvEy5Sj5EHeYaRjewTqSnTI4SP4l1z8upIQh/X
         /7TcI3BDh2GB+JOXCO3pWFcojujN9o5j+IGhjwMhTvj31o6F01edmmnSKFpHrlyIxJsN
         2VYwM7acRKwBEIemEUQpVfyO/+fdb2dsKUrqvLdHwKVmjUBeRAyXQejjCRdGbiUU81Zj
         Evs4ctTnmY7JA1zJEK7af3rikrk32n6DIWAJw7fQ2tdrVOa9tB/2uJ8/SRHHtz0QIUcb
         6+23gLhQdWS6EwZ4TLl/O5scfGNt4V6JeGhy0I0hHZ3ctsKNQDq/BeUhs+WrkQEw50H0
         1uCw==
X-Forwarded-Encrypted: i=1; AHgh+RrNMroBdg6FjdQCN34jSxBe02zMjlen37/TVkibjrw2ActyNwTOcaRF061GP4QfpkLJ2u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGM8ak+SPi35LdBHYAWxbR9v2Fi0V5G3ce7EXYA4XZCKDOjAM8
	1GEYXuNuSQmKGleHuBMt6ucSvwJo521sBQrXhaj6xz/71hdlVHFGwLdl
X-Gm-Gg: AR+sD125bbTttzbflrBmLXqeZnw8euMdyJmphOhdU0ZZ33J/aPNgkx2f0MdciVIYie4
	Nr4LueLMZH7sySfOePxF/JdpyVkr5zm7/bg4bXzTKU3nelonlAwgdBpuB+KGaq4O03497fTyZqr
	Q6sztN2hqu3C0dE4xJb3R/YGZtl1outV4faHkW5RN/IF/samnEogGGDEb9dXR0HrEekLWrmXKCP
	y9u1IlEdc/zwqjAKKvG3Bx+KxLDn66/IiyCHkgF3E18SP7dN0/59ctxY7n3vrT7Oc5tH1hkSeaz
	ZIcdTqr7GOlOG2jB2G0rHR+Z9DdAy+vTFW3Fx7Zv8VPD4D+3yHloLtG/0buKxBM61OdFIEP+aNE
	6tCopnzNpZNxsRi+fJlgUEAqwur1seTNVp+sI4o0fbz+B7sT4Tzf/4GWQGgTDpRZjlA+6mHNABA
	bd2ViVnzJcU9RexBJl7l1G64oaypPycw+NH52uqa8kKbkCzgzfU4H2kF+nSsihGbwnA2CQ0nlCv
	guq+qesb+CHXAauUpNGrcbYtdRF0fiXdvG4CWuJtIZQByfH
X-Received: by 2002:a17:90b:4d8e:b0:38e:3a8:2374 with SMTP id 98e67ed59e1d1-38fb149bb44mr351802a91.30.1785468258030;
        Thu, 30 Jul 2026 20:24:18 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d047c42b4bsm869275ad.78.2026.07.30.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:24:17 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: fix skb length accounting after generic XDP frag adjustment
Date: Thu, 30 Jul 2026 20:23:56 -0700
Message-ID: <20260731032357.6114-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

After a fragment shrink, this makes skb_headlen() larger than the actual
linear area. In the reproduced UDP receive path, __skb_datagram_iter()
copied 1024 bytes past the actual linear tail to userspace, starting at
struct skb_shared_info. The copied bytes included the affected skb's
nr_frags, xdp_frags_size and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/core/dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..5c37cf6c4aa1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	}
 
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
+	 * from skb->len before updating data_len, then add the new one back.
 	 */
-	if (xdp_buff_has_frags(xdp))
+	skb->len -= skb->data_len;
+	if (xdp_buff_has_frags(xdp)) {
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
-	else
+		skb->len += skb->data_len;
+	} else {
 		skb->data_len = 0;
+	}
 
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
-- 
2.43.0

