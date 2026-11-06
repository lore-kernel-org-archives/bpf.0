Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965605;
	b=21dnhL7OCKKeMc6D2jI6Zy0esPaGaRKWlJY+abeaJKJUHg/2c3Oi6E1SUJEbPYZk5g+g
	 I9OkB3dCvf7m1sr2HgxCWrmCnLdLIHfpb4JnBo0TBLTKvvhvuunLb6DG/UtCFw00ozhqM
	 omKM9VFIA3Q06cqqefAZa0yRVEEUZxkW7mBxdxgRFwc6KFA6oN4wzm+mW0bIPLyGwpWgt
	 z1WgL1W8hVZtIvoCG2KYtynzs9tuaKYfpXRlNYFRQnEo7eGZ5ZGQ+E4h5+wy5OJsBnzfA
	 yZO0FVlga5YiQOKjQNYmDdp4CQeeRc3dWN4+zzh94FMkIJxy+tnRCWkkc+0O1amdI4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RvWrLEYpM5Moy9Pqd11nVJaZOtslNfsd0zo0WJXntO4=;
	b=Cl42r4PEl5bwzPbrt2DSRo6vu4KllGEdWFeTdEGLzXOFv6ZS/TsTL8F15xTl5qLOdEs8
	 JuuN7LvOxD7TDuMT3Orm6/wWDtfCM7TwVEtM50v3p8RJTyqDJkNbRw35sQ1MlPy7anChF
	 +zeoVxv1o9/IPjDdri9J6EPzd0W0oV9sp78W94O+8E7CXWDTgRhqExUMlYKNrJpW4L1yH
	 k2JYsX8DBbH/Wr5DHMru4v+l4+aUraphanYQPp8JFSS4+Kp83oXr1X+vyV7qD42/dT2kq
	 lwbrbKFhX+YJJTLvA0U+ohZ7pQJuyvpim/NtxtDvmPfac03DJF18WRh+IehoP+2aZ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1K5J5hY;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAD606A333
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCAD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1K5J5hY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so746339eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965604; x=1794570404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvWrLEYpM5Moy9Pqd11nVJaZOtslNfsd0zo0WJXntO4=;
        b=t1K5J5hY6r2RnC/01ss6nbPT5V289m2YfKUuHGhxKSaztuC6WQBSrL/BWU8pRrAPU8
         y371XJZNUcEDEBYrXa5iVQFwGupOIfhawwBXstKszp1ATBDPuMEwMXpXSTqbjdoM6qnt
         Ey1V9iSzPpkSkQl1AA1LEiE6kTspQOKFdD1g36oyCgzkQy/1S6qDl/rw/CWJPnikTqbc
         XDSKEXwSRSjZ0c9KhQZ2+C5c64GsnPyTfkCD/gKZAYNXX21TE0H44pVBO80+G7JLf3W+
         8rI89oDR8HinF3pYheIczcShq++NPGZHZPdIv7aXzNbSkTaROvDPd5N8kAHvXpIBUtzt
         bnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965604; x=1794570404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RvWrLEYpM5Moy9Pqd11nVJaZOtslNfsd0zo0WJXntO4=;
        b=vqrXdqmgmNXPe5Lsfw4cQarEZNfw7QYblU8ejKKUuOsOarbCTonGWqCl5EkqJQIGxi
         +BD4TgIQqXIXGqE9th8LJGbORrIh529xJwdXw3ygq5iPmyUG6F9G/iMxeKZ3xyh/7l+u
         1WrRMLMhw8qYxlFuHjI9X70X+3xrhMSibDt7fJLAKkuMBOCwpxoymeuC0ck3pq8Sfacc
         1Sizsw0a4xQUsoPwfGnx/aX1atp64V5c6B+j45rvq2U6KnXoTEGppB1JdnIQDgm+ZA4N
         ybxyOSvPxQN93AK6G6cJIL5oewBKZy1Q0R7DWPyt51OiPSIy81hDssLUcVlypXjI+P9R
         ZExQ==
X-Forwarded-Encrypted: i=1; AL+hErGnmn88Tx+B338WfKc2sKyBl32Aug7ckTmiEQi+B5s0fGbyZIbBwciLshENou4BIM6q/Yc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dxISXPO8Dru46n0X1L8L01Cto279i62m2w+Xw0jL1a02jjiYX
	ju+Wnu8a82Na2krqSgvvG4xj5i8HArmFnLMwUd5OuxtivbkWJfH3rYcF
X-Gm-Gg: AYBFou1rycc+g0lhajBs+Wn7LlUF7xwaBcFiR99sYooBN3S3BFhGM9+A57PsLxEnpuc
	bp2k8QzzZVkwleaGiCEa5iL9G25nUQwLRnAJclVRylgSe1eDT9H6Ul/U3wRRbi38RCPGfzSALgq
	vZ9O4DMuhskepsMUTzhYOJBE/f9f4lEkJYG6+bv4SFP9PYD5alXk0q/hduMXCPeUPXDUpmkO+Kv
	IO/PE9hrLR24S8cHuE+f25JsCqm527X2C86ns55QeSkxLnxPrZDMmVxXDASv6c9hHNeYoChO16K
	yssl5lMLsOdncvdf8KSJFisXj+7bXPNSi0hWtRgruewOgDYrJ/XNhhzWCFU9uz6jeripFQz7Uly
	+y87G4zxWW61QEPezC0y4U7sz+18TEvY4asyrgU+3MDgILecM+6sEVmHZAbV+JxJ+6KTh2vUqnL
	24vN/8IID15jXIvGMK4E+rS4tdBcpsq8PjTvyAj7FJvfnmKP5l4VKY7oEMKzHWfw8KkDMHXZ4S9
	U1gLpXceoAA/GU2sGB0Pb+S9cwQ1IY8My5Bx95JoVAdB1sxOoJzrxiO0XY2a5kFnNgNgkcfCrSI
	7rJdnK45R6/0TQb1Cn2UeNqGkuubNKnMvc+GAx/8S3gR
X-Received: by 2002:a05:7301:4301:b0:36c:d1fe:84ce with SMTP id 5a478bee46e88-36f76b15aaemr3260646eec.33.1793965603627;
        Fri, 06 Nov 2026 03:46:43 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:1d31:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9be7077sm6167055eec.17.2026.11.06.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:46:43 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v4 2/2] gve: fix RX page refcount overflow from the pagecnt bias
Date: Fri,  6 Nov 2026 17:15:51 +0530
Message-ID: <20261106114551.212675-3-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261106114551.212675-1-amaan.cheval@gmail.com>
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
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

gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX and
hand references to the stack by decrementing page_info->pagecnt_bias, to
avoid an atomic op per packet. This leaves no room for anyone else: while
a fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
single get_page() from the stack overflows it to negative.

splice() of received TCP data into a pipe takes such a reference, and the
onward splice into a socket then fails: skb_splice_from_iter() sees
page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
commit 2e910b95329c ("net: Add a function to splice pages into an
skbuff for MSG_SPLICE_PAGES")). tee() of the pipe fails with -EFAULT via
try_get_page(). On GQI the reuse check gve_rx_can_recycle_buffer() also
sees page_count() < pagecnt_bias, WARNs and calls gve_schedule_reset(),
so a task that merely pins a fresh RX page (e.g. holds spliced data in
an undrained tee() pipe) can reset the NIC.

Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias
only has to make the per-packet atomic rare, so a small value keeps
page_count() far below INT_MAX however many references the stack takes.
Refill by adding a fixed batch and setting the bias to it, which keeps
the rule `references = page_count() - bias` intact.

Refilling at 0 hands the driver's last reference to the consumer once
every USHRT_MAX handoffs rather than once every INT_MAX, which is only
safe because every consumer on these paths holds its reference until
the driver has recycled the buffer. The previous patch keeps it that
way by blocking XDP on DQO-QPL, so this one depends on it. Trees before
6.17, without commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT
support for DQ RDA"), still refuse XDP on every format but GQI-QPL in
verify_xdp_configuration(), so there this patch stands alone.

Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12) and in
DQO-RDA mode (GCE c3-standard-8, 6.12, where DQO-RDA still uses the
bias) with the help of relay.py -- a small splice(2) TCP proxy --
relaying a download while the RX ring is refilled with fresh pages:

  ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
  ./relay.py $HOST 8080 &                             # splice()s both ways
  for i in $(seq 200); do curl -so /dev/null \
      --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done

Most downloads failed with EIO before the fix (tee() with EFAULT) and
all completed after it. relay.py is at the Link below.

This bug was found and fixed with the help of an AI coding assistant
(Claude Code) over an interactive session; it read the driver and
splice/pipe code and ran the tests above.

Link: https://github.com/amaanc/kernel-bias
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Tested-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v4:
 - Add patch 1/2, blocking XDP on DQO-QPL, which this fix depends on
   (Sashiko). Harshitha said Google would send such a patch; I'm happy
   to drop 1/2 in favour of theirs.
 - Say "overflow" instead of "headroom" in the subject and the commit
   message (Maciej).
 - Use USHRT_MAX directly instead of a GVE_PAGECNT_BIAS macro, as the
   other drivers do, and move its rationale next to the refill in
   gve_dec_pagecnt_bias() (Maciej). No functional change.
 - Added Reviewed-by from Maciej Fijalkowski.
 - Say which trees need patch 1/2, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
 - Refill when the bias reaches 0 again, as in v1. DQO-QPL is not
   supposed to support XDP at all, and it will be blocked explicitly in
   a separate patch, so the v2 refill-at-1 change is not needed.
 - Added Reviewed-by and Tested-by from Harshitha Ramamurthy.
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
 - Refill when the bias reaches 1 instead of 0 so the driver keeps a
   reference of its own across every handoff. At bias 0 a consumer that
   returns its reference synchronously, such as an AF_XDP socket in copy
   mode on an XDP_REDIRECT from DQO-QPL, freed a page still registered in
   the QPL.
 - Commit message: explain the refill point, drop the build notes.
 - Re-tested on 6.12.113 (c3-standard-8, DQO-RDA, which still uses the
   bias on 6.12): no EIO/EFAULT from splice/tee and no NIC reset after
   applying the patch. DQO-QPL is untested; I have no access to that
   hardware.
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

Built allmodconfig W=1, no new warnings.

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 5 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..18d7edbf4b3b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
 	void *page_address;
 	u32 page_offset; /* offset to write to in page */
 	unsigned int buf_size;
-	int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
+	u16 pagecnt_bias; /* expected pagecnt if only the driver has a ref */
 	u16 pad; /* adjustment for rx padding */
 	u8 can_flip; /* tracks if the networking stack is using the page */
 };
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5..52223baf0303 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
+	page_ref_add(buf_state->page_info.page, USHRT_MAX - 1);
+	buf_state->page_info.pagecnt_bias = USHRT_MAX;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e9..3bed19866376 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 	page_info->buf_size = rx->packet_buffer_size;
 	*slot_addr = cpu_to_be64(addr);
 	/* The page already has 1 ref */
-	page_ref_add(page, INT_MAX - 1);
-	page_info->pagecnt_bias = INT_MAX;
+	page_ref_add(page, USHRT_MAX - 1);
+	page_info->pagecnt_bias = USHRT_MAX;
 }
 
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
@@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
 
 			/* The page already has 1 ref. */
-			page_ref_add(page, INT_MAX - 1);
-			rx->qpl_copy_pool[j].pagecnt_bias = INT_MAX;
+			page_ref_add(page, USHRT_MAX - 1);
+			rx->qpl_copy_pool[j].pagecnt_bias = USHRT_MAX;
 		}
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index caed38cd5f2b..930555ac8fe9 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -93,15 +93,11 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
 	if (page_info->pagecnt_bias == 0) {
-		int pagecount = page_count(page_info->page);
-
-		/* If we have run out of bias - set it back up to INT_MAX
-		 * minus the existing refs.
+		/* Out of bias: take another batch. USHRT_MAX keeps this rare
+		 * while leaving page_count() far below INT_MAX.
 		 */
-		page_info->pagecnt_bias = INT_MAX - pagecount;
-
-		/* Set pagecount back up to max. */
-		page_ref_add(page_info->page, INT_MAX - pagecount);
+		page_info->pagecnt_bias = USHRT_MAX;
+		page_ref_add(page_info->page, USHRT_MAX);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index bf2e9a0adb36..c686142d37ea 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -25,7 +25,7 @@ struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *nap
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
+/* Decrement pagecnt_bias. Top it up by USHRT_MAX if it reached zero. */
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
 
 void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
-- 
2.47.3

