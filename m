Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9023E5EC0;
	Sun, 16 Aug 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920399; cv=none; b=lRzLyFKv13CuKQyrq+Q4Rgyb4BQvd+CLWR1+4+SnNMhu+gQF0MUFnYpREaxRwnrDkE53nG5waIL7Vqkxfk5PkDtRpnE+zZCkgBy2QbsU9hSUEJFA2KrfQYsECB5MeaHNgvme9Cr145mXV4s206stk+E2NH8icikWEqP2sUn+Tn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920399; c=relaxed/simple;
	bh=ZKykw6oGV9m9mVc5sFT/N3XDmLaiZXCrjH8hXh72Hio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7rGFp1WSdPoHhAw7ZMWkTuWQCU6jhwMs1UE2UakkAm8mHswvvVB27QHXuEGPCpglWrzbZ/ezd22tKQ9LQN9Q3tVP0QWcBHPcUwjVMB5KoTTXAWCyJLXJt/XAmoCStRlRkV5dDgNZntAYiodsHxh7IL3CH3P/RMeEqP/ce9tPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=mc1G/v9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fOTtMaWM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="mc1G/v9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOTtMaWM"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 66121EC0244;
	Sun, 16 Aug 2026 18:46:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 16 Aug 2026 18:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786920397; x=
	1787006797; bh=6GvdX/z9pV4lxPc5SRlNT52Nk8AS9W2M2/m8d2d4Is4=; b=m
	c1G/v9uXgZYFsICqr+QjexNh2FmtgLrSlr6dPVqX0XI3dImjsBSP1R60zY41Eoaj
	5aRJnqRUNOV/2Ws+I0YNMdLWWNFMBoPavhEa15M9Reqq/cBAJGzVVG7BANQlctcQ
	Ei887na/bVCIyuCv54DNliN85QSOUnoY7nIhSy1UhtPPhpd0InWAtRNcifvMSAJg
	ZLvl/+nZtAa4Cl1H6KXdQ9VzpdYdCAR1KFN3j1aGJITx2ArNKl3lxRQTEUQNKtfO
	8RbvJLiXrVKTED9/bZB4RdM9DAx0G7tYye4mch1AH6wtvm9UzuJZ0IUXtrJaDQSC
	VX7nN2uk7kO5tu6QZ+K5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786920397; x=1787006797; bh=6
	GvdX/z9pV4lxPc5SRlNT52Nk8AS9W2M2/m8d2d4Is4=; b=fOTtMaWM84K4Muz6r
	PzZ0Lal+gYVeumdOkmn7iZovsSiLzZPJVthtDVYytfcbi+dZBHqz8BmCdN+qRzeK
	r2PEUUMbakRN8e97AVEPFbRJ5ledgJlT52d4v2BIYtIrX/jeQqmlAYLBdSGer+CC
	VzS+09RzmGYz4oB772oWkJqDqqZryZxDXwpzDRNYIVKphAA38rVJM+QENVEFMDpE
	1TrYhQ6vDcoj1KaRuRkVbkGDG5ZJY0xWeY28Yw+GhsK3mgH3NkXln9+fJfkK2Tb/
	pdBY437ADNxHaltx70MYrrHfelsGTRoy9Cj0ZEI6SRkXE9H8ojAaYfH+ZXmtfX96
	x9CvA==
X-ME-Sender: <xms:zT2CamQZsKWHQaT2C1Xgj3C_sbjPqQ53-U3UYMBLaAVfFTB3hzsPKQ>
    <xme:zT2CalWfyD_io5bqyASUOe0QmmQhQ39FYd7M8HMoaqW_fNYea6wLpI60SkWi3T8mR
    vOFmJnnK826CMqTYSStktvi-ga7UZUUfO8dkFdUUwPAgrB7nptuK0fQ>
X-ME-Received: <xmr:zT2CavQXe932g71QVg43mZ2xGGDU80Dv00DBryWa4zjsqKp-V6QrhLPHHe0>
X-ME-Proxy-Cause: dmFkZTGQiHMMNOd1xnoN6lXQSIrGAe7MwYo75Qud3VSOh3aIjL1T4IX+wE1i/v23Y8aWnG
    m9SHT5inuXsr6fNeLF7q+XcMZ+pkZJxjpb2XQQyKrFdYKaLz7QDFEiegvQaT+Y5rGxRgjF
    euipinLXiFMtCpFgMqQP9Dwn4SHq3YG285QsMU4KB7YfRQHYWKIG6dJTmdP/7bPKv1qUNe
    3LkhBXaaROXWrLGafj+UVrogU8Abxo2OvgWTBKIlLl3SY5Eb27sggkfdoaZJgpjY1+W5mK
    IYgTH3bmg7umgeRjJmx+WAhyhWPmGn2xLzWKHa3nzXVCTdFk2+6Uh9D41+s+1+4ThvFtt2
    jeK1puiUf8/lXHw9run/+wq4ZMkal3NqfCGVfHNZQeqzajSoM0xs91hLNdfkGJVMEPEo50
    EPe+Ncx4BTBm7MyOsoX0Yv+7dODbPcL1P8bwxI8Ww0Vd+OJKkNSE+UeUiLjokmOTqE3x/g
    NVb6tth4Fc2XxFG8ViDfPqUuCtPt+2/drARpFjlBg0GZTT3TNpKGPRy/wAl24096Jq8fMk
    0IMtaDT4p2a5c8LGBnQHrXa+BH7i8dsceJq7w4HtmfDRlPOGvjk72Mh1kFWRA+NJT+Ycq8
    hlwNa62Gk1NaJ1js+PYaOu4IOTxXbZOkzWhgmhlQmOvIcjzJo6//3LBCCChg
X-ME-Proxy: <xmx:zT2CagusP5FR8Kcb9L6a-8P_d6_Lfao_Wei_LCG9KyHRzdP1aGpLUA>
    <xmx:zT2CagZB00Az8HWMudWkHlQhxPss21VWr3iR2ZFkUYvv-0_w6nNadw>
    <xmx:zT2Caj9oruiohkqvAnRN0FLvKySv4EVZG-vOmI81D6twhQMIPYb4GA>
    <xmx:zT2CaiCh-BxLuM8yzAnYJe-ELwUpcFlS1enjrMT3iG3a2RYKzmAZEA>
    <xmx:zT2CapOH4Gc7ODx-0-N2H503P44BpMoKoUFLW7X1iyu3gewhPcL4V2gA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 18:46:36 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	nico.pache@linux.dev
Cc: baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	mhocko@suse.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ziy@nvidia.com,
	usama.anjum@arm.com,
	agordeev@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	jannh@google.com,
	willy@infradead.org,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 10/57] mm/collapse: run a round and feed the outcomes back
Date: Sun, 16 Aug 2026 23:45:22 +0100
Message-ID: <20260816224609.308019-11-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816224609.308019-1-kirill@shutemov.name>
References: <20260816224609.308019-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

A candidate a round attempts either collapsed or did not, and if it did
not there is a reason.  Selection needs those outcomes to decide what
comes next: carry on past the window, try the same region at a lower
order, or give the table up.

Fill in collapse_run_batch(): run the round, then walk the batch handing
each candidate's result to classification.

The walk covers the whole batch.  A pass that refuses one candidate marks
it and carries on rather than truncating the round, so every candidate
has a result of its own to hand back.  Only an outcome that condemns the
table cuts the walk short, and then nothing of that table re-enters
selection.

The round and the classification it feeds are both stubs, so nothing is
attempted and nothing is decided.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/collapse.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mm/collapse.c b/mm/collapse.c
index 6dae5e35e61d..ad9e5a447854 100644
--- a/mm/collapse.c
+++ b/mm/collapse.c
@@ -115,8 +115,16 @@
 struct collapse_candidate {
 	unsigned long addr;
 	unsigned int order;
+	enum scan_result result;
 };
 
+/* Where a candidate sits in the table, in the PTE offsets selection counts in */
+static unsigned int candidate_offset(const struct collapse_candidate *cand,
+				     unsigned long pmd_addr)
+{
+	return (cand->addr - pmd_addr) >> PAGE_SHIFT;
+}
+
 void collapse_control_release(struct collapse_control *cc)
 {
 	kfree(cc->candidates);
@@ -132,6 +140,17 @@ int collapse_control_init(struct collapse_control *cc)
 	return 0;
 }
 
+/*
+ * Carry one batch of candidates through the passes.  Every candidate comes back
+ * with a result of its own: the passes before the freeze mark what they refuse
+ * and carry on, each pass after it works on what the last left, so no failure
+ * truncates the round.
+ */
+static void collapse_round(struct mm_struct *mm, unsigned long pmd_addr,
+			   struct collapse_control *cc)
+{
+}
+
 /*
  * Is @count past a limit stated per PMD, when only part of a table was scanned?
  * Scale the comparison to the table so a partial scan is held to the same
@@ -455,6 +474,18 @@ static bool collapse_next_candidate(struct collapse_control *cc,
 	return false;
 }
 
+/*
+ * Feed one candidate's outcome back into selection: its region is done, it
+ * re-enters the retry store at a lower order, or the table is abandoned.
+ * Returns false in that last case.
+ */
+static bool collapse_classify_result(struct collapse_control *cc,
+				     unsigned int offset, unsigned int order,
+				     enum scan_result result)
+{
+	return true;
+}
+
 /*
  * Run and classify the collected batch.  Returns false when a candidate's
  * outcome abandons the table.
@@ -462,9 +493,30 @@ static bool collapse_next_candidate(struct collapse_control *cc,
 static bool collapse_run_batch(struct mm_struct *mm, unsigned long pmd_addr,
 			       struct collapse_control *cc)
 {
+	unsigned int i;
+
 	/* collapse_anon_pmd() only runs a round it has put something in */
 	VM_WARN_ON_ONCE(!cc->nr_candidates);
 
+	collapse_round(mm, pmd_addr, cc);
+
+	for (i = 0; i < cc->nr_candidates; i++) {
+		struct collapse_candidate *cand = &cc->candidates[i];
+		unsigned int offset = candidate_offset(cand, pmd_addr);
+
+		if (!collapse_classify_result(cc, offset, cand->order,
+					      cand->result)) {
+			/*
+			 * The table is abandoned: the candidates behind this one
+			 * keep their results and are left unclassified, so
+			 * nothing more of this table enters selection, and the
+			 * abandoning result clears what earlier ones left there.
+			 */
+			cc->nr_candidates = 0;
+			return false;
+		}
+	}
+
 	cc->nr_candidates = 0;
 	return true;
 }
@@ -502,6 +554,7 @@ static void collapse_add_candidate(struct collapse_control *cc,
 	cc->nr_candidates++;
 	cand->addr = addr;
 	cand->order = order;
+	cand->result = SCAN_FAIL;
 }
 
 /*
-- 
2.54.0

