Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474940;
	b=iKAGdY1zbpfbovnOsJE32fvGV9+dmsjn4VZT18NPUOM3ZZ97yUdEsnFu/LKZ0J0XD3PM
	 7MX4AMdztAwoFnDMj5lkciKRwiFIT4gO8KTxg1awvAFB8WEx2hHqDTeLVpUO2KMWqVuHm
	 WtFTGoM3YTEI7M/U9fMwl2jIMWggfK/K1t5s/0ocgS4imi8kYpN3nJ95rVc6jA6ySd8ZW
	 pbIDfK3rnXHauNy11NZp8KFOKUrgHT4Akac4H3mTM0IIXPHa41RjbMJsoTEHEB/a3eddh
	 9fTL4Rc7WkhJaRriW1YumkLNhKU27zOdS514v3eHOb/z0wGZu7s0bi03/jYus9RPOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tm6gw4Nr3ga8o79ZJ8Y5quYuKLdUr5b2uF9gkEscNaE=;
	b=oQlAmSoo24kGy2FF98wChWYbVsW/+DxcXdMgqt8szqMvsmmq+eD3H35PepsQ9kQdV0nY
	 lxDtv18R3xAy6jT6UivzZs+fgH3VLNgjF0pXKzuL2/xumlsKsEfIOmWA3i2ycJ7TfWOSV
	 9gkYjpaknYAzCzT7LrPycbKOPsUL9r3KPec3MW/MAezjKLQujz39evC9a6XGhzbUcxi8V
	 BEmt2QOnFyGNhbAXHYl349HmRCrmdOXUhcS0dBDvl33/1cyKfZL7JQah7BpuJ+/gznEQX
	 OvPkngP6WyxdqGkubusuOsE4XOAa3NngiEBUnkwB1upeAsB0RDi5WI8uPG+24nG1FUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcKSa+BQ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91300606A8AE
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 09:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91300606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcKSa+BQ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a315ed211so697842eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 01:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474939; x=1795079739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tm6gw4Nr3ga8o79ZJ8Y5quYuKLdUr5b2uF9gkEscNaE=;
        b=CcKSa+BQ2xokalyWLWa4SPtACIKAXSJQ9rIOBPvApBTPCld/gDSiBcYTCk1o0zG2tc
         /UkLv7SR5ovLqQHHql//ePt4VVqqiJsSjmA951wBr0vBtbH9vx5WDdedzDu5JCI2Nsx/
         aFpNOHOZ1yoL+0xDWWuyj7AfZrynAkJElSAQfpzEood0tzp9dfX0DN0lDoOKu3tXq0vx
         ibDpeYiA1InGWH34coPEVmrbZfzDngTdYWGz42uzH+ka9xuRXzI6kUQdxTY1mBuYCwsS
         zb5VdZFba032HZaSp6h5ivpBn66p2NwqNsrQ2Es3n6k3RbEPxm2LJUmKHj9Hc4Rq0DIu
         uPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474939; x=1795079739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tm6gw4Nr3ga8o79ZJ8Y5quYuKLdUr5b2uF9gkEscNaE=;
        b=VohCc7kIMga2RVyBIXP9Yeva8QzvxtHYxNvc/eCV+z9tv7zVyW4VYYhFnfV4TLZPHa
         BNmbzD1CKzhjOO2QWOKPKYRgs8+gQYG/ZFZoeKoVzKzoTTa/U+E7RFSfQxM8d492UcVq
         Tjidjhs33SZMFlYKts7lSqPYhcez2PIoMNXv0VUOhmEaSSGPC47rScyBAJjaJ8QBdNZq
         rw90lrT6mzYewDv9s0aEcMigYpINx/mIhX+gYK2uHlch4kN8lQjZBhyNbfPiEMDw1jCI
         e3TjhDEdby4a5ErDzQE/NUJE4emLuesN4H01vQGppWvtNX03o/VKyx/JoM8oa4kMNy9i
         7C7w==
X-Forwarded-Encrypted: i=1; AL+hErEhqYfY8JXZ+EMNwgFApTPk8K180z42UsabWQzdNaiCojTx6/4F1vx2OhOX/4QgdQE7swQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gFg99FkMsZ/Njkof6E51FP4GFmFW6BsbD6RUfBbkx2BW42ZO5
	edWmWM3UxGIK0MFdMPb99ti8DkLqjtI8ghX1NHxqcp+PQ6IQnmdse45O
X-Gm-Gg: AYBFou153Ix9lfxlr3N+GNnZl6VilkFFB9MsCOBjfK7pvBAECj7g6m59MhU7yz3CyK9
	b3AHMlYv12/e7zNPoVeDWuYtsOCDQ/QR4m8oKCbTykptUEmNr+zSlIPaPy21P0hTeywk6Skwonv
	32PrJwQbmFJJfOIfzKBOXcoIyXx2q/1izp1X6pAZKktBPwk77jBXLWXi+ELGDeeklBQHP0Ry4WQ
	2KZkcaSzA5syFkNy4BH8jyY7mIroEzWFFhy0MV8vH1MlIwAVfJvme5XorZwDA796akq0Y95o4ZP
	hDkNB6NMI1c6x5UuuCNPuZ8Pl7/FK/zO6Vp16BR5pGT90GwX1KMIQtcPcKZN3vUuTvzYTiInnmH
	Mb23DUZGgxPeGREPJG0yenv+6N09IlBBtGwPTETnvqw7zFBnClwPaBL9EK8aUv0zRZJMjflr+YJ
	mqTCUxEZBaJIn47wGlanYEnx0OODC5ykXMAAzpGpV4xMAgUh6YErZhFM9mUf9tG3CLaMmonfxKa
	zb5R8nGMIPU4ONtobwc2f7+JfC9UQHj/hm4SCzVbMFkTuWCNyqmcxXx6W+P5ryx5/yquo13AmQJ
	ChVbbIOzRZcbehcSXYORHpwFYdL/FEWIMmANxuNRUMS/
X-Received: by 2002:a05:7301:2103:b0:36a:1a7b:d1bb with SMTP id 5a478bee46e88-377e1af5c7bmr1885067eec.22.1794474938445;
        Thu, 12 Nov 2026 01:15:38 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:27a4:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm40096319eec.22.2026.11.12.01.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:15:38 -0800 (PST)
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
Subject: [PATCH net v6 2/2] gve: fix RX page refcount overflow from INT_MAX pagecnt_bias
Date: Thu, 12 Nov 2026 14:44:51 +0530
Message-ID: <20261112091451.22969-3-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261112091451.22969-1-amaan.cheval@gmail.com>
References: <20261112091451.22969-1-amaan.cheval@gmail.com>
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
v6:
 - No change; patch 1/2 changed.
v5: https://lore.kernel.org/netdev/20261109100437.331423-3-amaan.cheval@gmail.com/
 - Name INT_MAX in the subject. No code change; patch 1/2 changed.
v4: https://lore.kernel.org/netdev/20261106114551.212675-3-amaan.cheval@gmail.com/
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

