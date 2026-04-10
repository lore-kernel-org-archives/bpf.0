Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F73876D3
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863617; cv=none; b=fYFoNlVlBdx13ZslEvLhNQt/uJg25HaYkmJYpYcb4tF2r3cLLY1/58LJxRo+/ACZE1Dz8znkmAckgAN0Yfgrm5GsUBvimTtnn37N8f8IUEenjSkPKSRgrqeXe95ZUX0GVl9Z2oZFNDw+xA05HLBoMUv5EphCRS2NO45+Mm8hYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863617; c=relaxed/simple;
	bh=s8xOCoE4+kOv5I1nJcNj2AQIoiM/s2+mf12XGcbzHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EW0QSDHOU4KazY2SyHbnmv94m0mpGRGCtR/irAnSdJcZxM8wevZTbUD1P8Hk4Lc4AlJdj8vhnn8ClL5nzpTpY1aFzmu3gz8lZ79MoBJMBLMSGtHG8NvYUIR7zE84TG7wWuiXnuVNi+RyrQWa9IN8g8hEPvxRgagdrnmTGMzYCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rQWk6mx1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rQWk6mx1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=dTfYrX8B9t+U4CWvKr4FXELj71rCQ3qP+WhI6Vm8WT8=; b=rQWk6mx1rXxE1ldHWB10HTj1k8
	v9r7Qkb73149cEYtr+HuGzij6/EMq3b/M6H3xd8ZdrPTNgTlfGbbemXkHACDkjs0zGtlPOLm3OwCp
	7bDYUPl5rt56OM5JjS22eKuCqcHTSVZi2lMi3TLR9gECZw2QIkQtwh/je/oyUJlB+ka35Alps811c
	s/uhI195bErquKoMVk21zgvygFczQNHFpBu6EFgUficAkldXsmpUatMGRkyWUnWHdFPY/D0RxSPfj
	CkCB7S+RP2WY/seeexPrVAc0tg/yru7P/YbHPiFQi1GoZrhoeBsqcW6y+GB3AO/LTtE5kDfmvJMY0
	fw2qEUWg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wBLFT-0002cm-2x;
	Sat, 11 Apr 2026 01:26:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 1/2] bpf: Enforce regsafe base id consistency for BPF_ADD_CONST scalars
Date: Sat, 11 Apr 2026 01:26:50 +0200
Message-ID: <20260410232651.559778-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27967/Fri Apr 10 08:24:45 2026)

When regsafe() compares two scalar registers that both carry
BPF_ADD_CONST, check_scalar_ids() maps their full compound id
(aka base | BPF_ADD_CONST flag) as one idmap entry. However,
it never verifies that the underlying base ids, that is, with
the flag stripped are consistent with existing idmap mappings.

This allows construction of two verifier states where the old
state has R3 = R2 + 10 (both sharing base id A) while the current
state has R3 = R4 + 10 (base id C, unrelated to R2). The idmap
creates two independent entries: A->B (for R2) and A|flag->C|flag
(for R3), without catching that A->C conflicts with A->B. State
pruning then incorrectly succeeds.

Fix this by additionally verifying base ID mapping consistency
whenever BPF_ADD_CONST is set: after mapping the compound ids,
also invoke check_ids() on the base IDs (flag bits stripped).
This ensures that if A was already mapped to B from comparing
the source register, any ADD_CONST derivative must also derive
from B, not an unrelated C.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 566311dd4fba..530bc0c2f116 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20130,6 +20130,13 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
  * and r7.id=0 (both independent), without temp IDs both would map old_id=X
  * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
  * X->temp2, but X is already mapped to temp1, so the check fails correctly.
+ *
+ * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
+ * base id (flag stripped) must both map consistently. Example: old has
+ * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
+ * (r3 derived from unrelated r4). Without the base check, idmap gets two
+ * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
+ * with A->B. The base ID cross-check catches this.
  */
 static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
@@ -20138,7 +20145,15 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 
 	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
 
-	return check_ids(old_id, cur_id, idmap);
+	if (!check_ids(old_id, cur_id, idmap))
+		return false;
+	if (old_id & BPF_ADD_CONST) {
+		old_id &= ~BPF_ADD_CONST;
+		cur_id &= ~BPF_ADD_CONST;
+		if (!check_ids(old_id, cur_id, idmap))
+			return false;
+	}
+	return true;
 }
 
 static void __clean_func_state(struct bpf_verifier_env *env,
-- 
2.43.0

