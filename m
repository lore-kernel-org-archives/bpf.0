Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287463D9DB2
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749828; cv=none; b=IFl/Y91pHr6qiNg3u4FzYfoBHQQL4dKXjDD7ylLtaveDoTyYIoBdwxVA8BtmROq4VfuAIMLxHhhWfo1HrcziG8r3WO4h4CdgKIJoGywCfkHoYJszBuwepO37vh3QnZA32j2yBxMvP9B62VFIHmmMugpfvKCEbFcCVYFggt/gEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749828; c=relaxed/simple;
	bh=ZbHLOFhVKcEGmybl7KKLPwOljzibDQwOshKeJ55BZMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuO/CuJPrewjT3lU1t3mvuKEPHvB08NuRECg1xcrwfKn3unwDUkz2/19VI7sTZ/YMVyIYyfIbT9z2cbvRPKZGdkKjs/YPsXF1fRNjgnzLPq8eMBwNrugpLkCiKc6Lo8rNjjjAFRbZX3whjczPrhHvpRpuL0ddQrd591KUcEqHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hvJqC+gl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hvJqC+gl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=JG7Cu4N3ve24hwdqXawknf9IVCKH6E77lTOS3SlHTTk=; b=hvJqC+gl8UJTUb2FNKVhVWEaAO
	MfVXPLKbJeVdgmksc7br29XhLmI8A3lAn1L61TxKWFv97GsdOfVj1dV4/fXWVQCqy/wSEVp7jBpSG
	cZtl2HYDwoC2FczTeD99JHJeEDpDorT05oV8kmTpU1mZFGQvajLalxVr3r/WTqGfBh/KgczDUtnnK
	PUBdsW6OE/aqeH3JkfzRYGgdbIdBiRu2segsvXL6dchxvnIpfHvdrv1KcbL/gcQDRj4M34EMTK76Z
	9p5BkizBwYHk2XfU5j2RCtZjevjwSO5X6GbXE0b1Ej0mKcxESjObaKnD51D7Zv9+4bYMm6gWHTZjz
	ybNdfLdQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAre5-000ESJ-1b;
	Thu, 09 Apr 2026 17:50:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 1/2] bpf: Drop pkt_end markers on arithmetic to prevent is_pkt_ptr_branch_taken
Date: Thu,  9 Apr 2026 17:50:15 +0200
Message-ID: <20260409155016.536608-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27966/Thu Apr  9 08:24:43 2026)

When a pkt pointer acquires AT_PKT_END or BEYOND_PKT_END range from
a comparison, and then, known-constant arithmetic is performed,
adjust_ptr_min_max_vals() copies the stale range via dst_reg->raw =
ptr_reg->raw without clearing the negative reg->range sentinel values.

This lets is_pkt_ptr_branch_taken() choose one branch direction and
skip going through the other. Fix this by clearing negative pkt range
values (that is, AT_PKT_END and BEYOND_PKT_END) after arithmetic on
pkt pointers. This ensures is_pkt_ptr_branch_taken() returns unknown
and both branches are properly verified.

Fixes: 6d94e741a8ff ("bpf: Support for pointers beyond pkt_end.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1227b168bb07..9c1135d373e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15448,10 +15448,17 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
-		if (!known && reg_is_pkt_pointer(ptr_reg)) {
-			dst_reg->id = ++env->id_gen;
-			/* something was added to pkt_ptr, set range to zero */
-			memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+		if (reg_is_pkt_pointer(ptr_reg)) {
+			if (!known)
+				dst_reg->id = ++env->id_gen;
+			/*
+			 * Clear range for unknown addends since we can't know
+			 * where the pkt pointer ended up. Also clear AT_PKT_END /
+			 * BEYOND_PKT_END from prior comparison as any pointer
+			 * arithmetic invalidates them.
+			 */
+			if (!known || dst_reg->range < 0)
+				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 		break;
 	case BPF_SUB:
@@ -15490,10 +15497,17 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
-		if (!known && reg_is_pkt_pointer(ptr_reg)) {
-			dst_reg->id = ++env->id_gen;
-			/* something was added to pkt_ptr, set range to zero */
-			if (smin_val < 0)
+		if (reg_is_pkt_pointer(ptr_reg)) {
+			if (!known)
+				dst_reg->id = ++env->id_gen;
+			/*
+			 * Clear range if the subtrahend may be negative since
+			 * pkt pointer could move past its bounds. A positive
+			 * subtrahend moves it backwards keeping positive range
+			 * intact. Also clear AT_PKT_END / BEYOND_PKT_END from
+			 * prior comparison as arithmetic invalidates them.
+			 */
+			if ((!known && smin_val < 0) || dst_reg->range < 0)
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 		break;
-- 
2.43.0

