Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958083B0AC3;
	Fri,  3 Jul 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092148; cv=none; b=U/G0tDmZDStpc/6XYzDgiTi94LETZ/wRvdbdvD4y8Iq+USFkb56Ny/TlD9weUBRuCdTmtvz237hb7bXmowToFxdApJcC1Jt32N+KgGcVl0J+TS+3aqdEWCoO9ZsPKQAEfT8s3zUgCux5PhZHz5y/VQFG88Yf69ijrqSbYos65Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092148; c=relaxed/simple;
	bh=eUroo0fU5yL/blMjii7v4YjpGgV1jgMooBoRLcpSp6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LDfiA1SyD4sfXDG8+NXj2RLcxdKBMHE2XwTbdNl+gq5Jw/laXHrMtVwUw35N4pYvvysjU0q6vsJSHmOoibASfU+9UVNJCkjfj121U7xRNVy8016lqtncu84suLSoh/77b5fY8RnSscX8iWVktMVxuKvAZaHKHfm8H4Zb6928hA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wEHn77ij; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wEHn77ij"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=V+78rN3APZSyQrCASdVp80tzAl8KAm2NRcUFK9s0VeY=; b=wEHn77ijjVW5ZeyTmxaZvCfNgs
	HZbM6ITzSHEagP1zvZKfVwyNmotRnSu+SAyxyfaoIBVCmVBEcz0aUHj2693rwhWH7L3SqxnUMzvRb
	uFrRu8stjoGmgJnRBviTwnkMMhiY2N+gusf8CuOBiDn0/bcNKGW3E1jGWb9AguG78Mo5kzFavAa3e
	/DGGla9Ikk/bXLJnf2I1Bzpk76JxGcptgPjrcvteU857GPK27xNA95FDoqw03rfCa/gQzql8caDVS
	ryN6fiZuJoDvkrFdi4JhoPK9TcJn64YkyiVpwQwG7sgZqGbCPokzodh0k4QF9FD2SO8QoNUOS2EM0
	2l9+w8vg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wffiW-009UVs-2A;
	Fri, 03 Jul 2026 15:22:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jul 2026 08:22:03 -0700
Subject: [PATCH v2] radix-tree: fix kmemleak false positives on tree head
 reassignment
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-radix-tree-v2-1-38bb6efb5f6e@debian.org>
X-B4-Tracking: v=1; b=H4sIAJvTR2oC/23MsQ6DIBAA0F8hN0vDUauWyf9oHFBOvQWawxAb4
 783de76hndAJmHK4NQBQoUzpwhO2UrBtPq4kOYAToE1tjGtsVp84F1vQqQ7TzWGu63RIFQK3kI
 z71f2GioFK+ctyee6C/70b1NQo/ZdO6F9jGZ+Nn2gkX28JVlgOM/zC95VpISlAAAA
X-Change-ID: 20260702-radix-tree-8ae41d324101
To: Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kent.overstreet@linux.dev, arnd@arndb.de, bigeasy@linutronix.de, 
 kangas@redhat.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; i=leitao@debian.org;
 h=from:subject:message-id; bh=eUroo0fU5yL/blMjii7v4YjpGgV1jgMooBoRLcpSp6M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqR9OgoUuVzD+7SNZPhjWxESlnNtL3rlBK2ZGnU
 7+Rw7d/LuuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakfToAAKCRA1o5Of/Hh3
 bS8pD/9gj2/yPoA0yaIC+0CRR2WtyYgKCVxjCxnw8ujw20CM0PL2uSdVM8mVA0UJu6TgL2GlIZy
 3iMeuy97lblNaR/vS2hFzLI4GRLJ+fnl7vFo5pUyqzoAtQE4R2vEqWTX/+Ddci1VO2A4C9j9MIO
 EHmDKAfkcq8UMlV6AYNQN6zhLtJKv70rgfAdeBotob0A+KChnSoa9COCZuugwJTsuWYSF04PoK0
 hZ8PY+qtXtV4lPdTufgj7ZJ72fN2SUmRJvtiU3htv+qtvFxrYUNv0rYEGBdhxmyVsicKIRoS3hG
 /Osz1RtwDbqUBkwqUbdsLSwURmX5TReiZ3aLjaALXHqXoKpeLN2QXUvZ73G4sH+a4EsrMNzZoEx
 OIxm2boejR7gIfk/JXYdPPsJ2BZWKq+NpksxTvKtBrROouyC+jAmJ3+SDtkoKwcAhyIgHRfcjdu
 qs1AZ1BIlJTQa2jsxE7VSBQ0uv21oLSSXIW879+o6qmmB2pM77t6Kkmt3UDY9wf0/C4F2I8rWn3
 7/aHb3HsEL4QoJbpasTSAdYI/FTzb6AQ3IT5jkET1dLO5eG1Nox90XdZUTvOZVAEmRsEjZqyp/r
 vGu6fQ0J/GCdosRa1tR7h0FmOjEGwzM6QqoEN7fYDPnNDjMo25FTXuelLPfkOen5qU3UFycuhJ7
 TGjpmrZDfopDjPQ==
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

Add a matching kmemleak_transient_leak() stub to the radix tree test
harness so the userspace lib/radix-tree.c build keeps building.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Add a kmemleak_transient_leak() stub to the radix tree test harness
  (tools/testing/shared/linux/kmemleak.h) so the userspace
  lib/radix-tree.c build keeps working; reported by the kernel test robot.
- Link to v1: https://lore.kernel.org/r/20260702-radix-tree-v1-1-a87c125b0f96@debian.org

To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
---
 lib/radix-tree.c                      | 7 ++++++-
 tools/testing/shared/linux/kmemleak.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

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
diff --git a/tools/testing/shared/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
index 155f112786c4f..65a383090fb51 100644
--- a/tools/testing/shared/linux/kmemleak.h
+++ b/tools/testing/shared/linux/kmemleak.h
@@ -1 +1,2 @@
 static inline void kmemleak_update_trace(const void *ptr) { }
+static inline void kmemleak_transient_leak(const void *ptr) { }

---
base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
change-id: 20260702-radix-tree-8ae41d324101

Best regards,
--  
Breno Leitao <leitao@debian.org>

