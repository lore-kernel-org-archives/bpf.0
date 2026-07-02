Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767448AE20;
	Thu,  2 Jul 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997130; cv=none; b=ZvyVMl6t1cOuDIF+Ao3HL7WoIaHzb264me3mcE4YI+yxUDup0Q6+cEfp6EbEoVKCMp4ykjCX7vgcfuuNZiECnbK8JzTE6A4fk0fgagewdD4ytmKspM1lou9HfbKjapOLvXrz/1KYSuxms4PLwUYO18N+Iw9KpwsPAEMvexY3KI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997130; c=relaxed/simple;
	bh=T4ADteLYKYg5AaQGhaBpoBHsOh/4UVoNZQ3SpG0Dp6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KfpjxCzjyQFoau0cBjcgEkpDovub/s7c614X745W81ikWWDEO8joS76+2XuHxeAZ9J9oS5vVM5mZrT4oH2L1Ao+VNTnC5HZkcjY0l/7+/6oKoB68iQuVzyiZlKV42FARwZRA94fbxzxDQrOB8GQtSlgqS1qtbzw5au2aCnZA/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WbJz4NUu; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WbJz4NUu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=6CE5iuMYrd1Q/RUldXDbld+/EnjNdJ6JRr2ZhCktWjc=; b=WbJz4NUutZ1FXoZFCH7bPJ4KG8
	1VCxYbBYKk5dw0fyAvHA/+Kso4wSFgd9vLRqYxZY0Lx4OS5ac6GJ/F1r8U7Tc7MUBLYuAtwALHCNi
	3/r1cbb+L19gkj/kXsd+cb+ATwK65m0NlsNfAtia3AtuTgLsq4kbFVWPT/dB5qHA18Ua4byDQP7W7
	WTAyzuOzGjbiOGJZ/rCrXY4xlkJPigCpiZ33FiNFHUyjrLK+T0Bqx0KJyzAAQH7EvOhUrH+sRDCX7
	zOTvrzYsrmixi8MTKG41PoMfA5af7xh54MeHEWXoDsC3/ea+JQa89HmmEo0KSZXK6smxJk9EBOimE
	Ll4ng2Dw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfH08-008dbm-1h;
	Thu, 02 Jul 2026 12:58:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Jul 2026 05:58:34 -0700
Subject: [PATCH] radix-tree: fix kmemleak false positives on tree head
 reassignment
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-radix-tree-v1-1-a87c125b0f96@debian.org>
X-B4-Tracking: v=1; b=H4sIAHlgRmoC/x3MQQqAIBAF0KsMf52gFhVeJVpITjUbizFCiO4e9
 A7wHhRW4YJAD5RvKXJkBHINYdlj3thIQiB463s7WG80JqnmUmYzRu5can3nrENDOJVXqX82ze/
 7AdtNi1hcAAAA
X-Change-ID: 20260702-radix-tree-8ae41d324101
To: Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kent.overstreet@linux.dev, arnd@arndb.de, bigeasy@linutronix.de, 
 kangas@redhat.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2277; i=leitao@debian.org;
 h=from:subject:message-id; bh=T4ADteLYKYg5AaQGhaBpoBHsOh/4UVoNZQ3SpG0Dp6Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRmCAZ9vpx0AiFrsv1uCk7YjAL9uUYkZl7+mMs
 59Zx1UQzjaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZggAAKCRA1o5Of/Hh3
 bb/6D/0VCu9t/+VpWXJb3oNFYG03fXJojkUvvBBpFwzku6flTrbr4TbaPAHXdBpvPXD7bpUfZ8t
 DS+KBUHjA935zr5NyHCD5q/Dz3LPZxOfcKuo70IAwyznqrByWnARsp4a9Y3upbFcpC66W55WXAe
 kaw32xadAo92eZHXTuF46rcA8WKyq/OyOIZFDhPgPM/lv53X3C4VKAxaEkcy/+xjioB2WvW7Pz5
 tN3y6e1LUSutL0NLY25MOewH/r7V4VbVZwiABqQeDSVtuB5RcbSTooTVCCJCvJqW2MRaUOhV15W
 gHrofqKCkaxKMaxh4PbCF9BWrnbnesVjT6P3bMmCMI9PFKzSdRpGUFOnCqeElocOhU+ZVkFfE80
 mfhHcpYl3HuBsA2LLBB+LZguMka/4VL+5ww1JQsFdosQcRqIJdDve78X+AnNB/ufvKDbXk4kNUe
 2XsRc1UsGc7laZElSYZoMqxDlBJmxrGBD2ybCXoSC+cfOEVmfwP2g3eU353ibu7Y3QgcCVhYOVN
 V5u+plWbtpBOeVoOX/aaauOLtc5QwVI2sTTFa4LxJOPvB0PoahVBuaDIE7hOsZ6k+3ebY/WHLCA
 22kqeotkjo6u7MqRWPnPaMl5opyVDCGy4lZlKVSjpFg9P2hNpCtdCv0ZblD3abwh0C70kKDMrEQ
 YfbdiXgOe9oqwJQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Kmemleak periodically reports transient false positives for radix tree
nodes allocated through the IDR, for example:

  unreferenced object 0xffff0004d6ac4200 (size 576):
    comm "tcpeventd", pid 6412
    backtrace (crc 335d668a):
      kmem_cache_alloc_noprof
      radix_tree_node_alloc
      radix_tree_extend
      idr_get_free
      idr_alloc_cyclic
      map_create
      __sys_bpf

radix_tree_extend() (grow) and radix_tree_shrink() (shrink) repoint
root->xa_head to a new node.  If a kmemleak scan has already walked past
root->xa_head, the new head is not reachable from any scanned pointer
until the following scan, so kmemleak reports it as leaked even though it
is live.

This is the same race fixed for the XArray API in commit a1a029bcea59
("XArray: fix kmemleak false positive in xas_shrink()").  The IDR uses
the radix tree API directly and hits it on both the grow and the shrink
path, so mark the new head as a transient leak in both.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/radix-tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b5..cb5ca920fddb6 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -455,6 +455,8 @@ static int radix_tree_extend(struct radix_tree_root *root, gfp_t gfp,
 		node->slots[0] = (void __rcu *)entry;
 		entry = node_to_entry(node);
 		rcu_assign_pointer(root->xa_head, entry);
+		/* new head may be missed by an in-progress kmemleak scan */
+		kmemleak_transient_leak(node);
 		shift += RADIX_TREE_MAP_SHIFT;
 	} while (shift <= maxshift);
 out:
@@ -495,8 +497,11 @@ static inline bool radix_tree_shrink(struct radix_tree_root *root)
 		if (!node->shift && is_idr(root))
 			break;
 
-		if (radix_tree_is_internal_node(child))
+		if (radix_tree_is_internal_node(child)) {
 			entry_to_node(child)->parent = NULL;
+			/* new head may be missed by an in-progress kmemleak scan */
+			kmemleak_transient_leak(entry_to_node(child));
+		}
 
 		/*
 		 * We don't need rcu_assign_pointer(), since we are simply

---
base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
change-id: 20260702-radix-tree-8ae41d324101

Best regards,
-- 
Breno Leitao <leitao@debian.org>

