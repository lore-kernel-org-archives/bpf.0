Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F784FB9BC;
	Fri, 25 Sep 2026 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370997; cv=none; b=JZsCAXpqQGGVqgu6kUtwTCZMhEPS+yaFn3Q1rRitPkF4sIGIbClICe0VGjjdrRdicjlhVQkhgRe4cGjiIJQn7yEbuPvWRh3WdhR7irV73s9FJ4GAC7xAAHo2MVDIXz0x+jkYVHN4Bv1ENv1z0FapsMgb9EGpuomzzJ+DbFulC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370997; c=relaxed/simple;
	bh=GI/d9/oH5DJNiFiuZOnJXcMZNNvA/Gob8NoXCPf5QLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0dSr1AX0x7ZKcxdUSNMtNhLHsEschcI3wnM2EvJqi3fih6B6qBtzHHdjJk7JL5v5BPamxD3zd0Jr8akLqTyIoyzYvuLbBJwwkq3Cg8QEslIqkTGvl2OnkWq2e5pW9jBGS29Q1lVpA8nnqi4Oe71ayJQc5FH//JKn9/7xYafwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfJEM9nL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfJEM9nL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CEF3C2BCFC;
	Fri, 25 Sep 2026 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790370997;
	bh=GI/d9/oH5DJNiFiuZOnJXcMZNNvA/Gob8NoXCPf5QLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pfJEM9nLKdWZXZv2trRmJEngIEX+mSVXqb9xqBotKgZRqZGUTQANfJTa2uzTLQ+Te
	 GZq97F3/PtFIS6ITqgbZb71dibrKl/Ab0GLwtH2SycQK15Ck7PL70w1ltTAy1DMkKo
	 FXD8b+mitlCOkkIpAOItY3lp7whyEXWjZlOf2H7OxNoclY8TXa0//J+zxa1i3AqX31
	 1j4N+fOHd9K8rHxcVs7BiajlMyXXbcB67dhk6HldT1jSw7X52WT85RHvTUdYCy1UrR
	 MOMimizWeXcQjFayN1KrOKsfdbWHqqBKlG1GXdQamh0DcuonmKqbiOfqbY4h1sU4KX
	 hJ2bXHbaJfccw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE4C9832C;
	Fri, 25 Sep 2026 21:16:37 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 15:16:38 -0600
Subject: [PATCH v5 3/3] kallsyms: Unroll 24-bit sequence reconstruction in
 get_symbol_seq()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksyms-tune-v5-3-1f75ad0c321c@gmail.com>
References: <20260925-ksyms-tune-v5-0-1f75ad0c321c@gmail.com>
In-Reply-To: <20260925-ksyms-tune-v5-0-1f75ad0c321c@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790370996; l=1647;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LVYPylbZu3M6VrXkQZcoyGu2621tAs/rWNxgexduWm0=;
 b=bSolZ+xGo7YGVyE/3Cc+G5drg3brNK2iYeolVWvKMXXI2CAqLCidykIGWr5i46jOAhTuIs6OA
 KhazXZcFQ1mDR5TPuzNNE+OE1QA9MUIkT3Dfl335jc9Y8TExPKVlrUe
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

kallsyms_seqs_of_names[] stores 3-byte big-endian sequence indices that
map alphabetical symbol positions to address-ordered symbol records.
Currently, get_symbol_seq() reconstructs each 24-bit integer using a
3-iteration for-loop that shifts and bitwise-ORs each byte sequentially.
During binary search in kallsyms_lookup_names() and duplicate boundary
scans, this loop introduces branch and loop overhead on the hot lookup
path.

Mark get_symbol_seq() as static inline and unroll the 3-byte extraction
into direct byte shifts: (p[0] << 16) | (p[1] << 8) | p[2]. This
eliminates loop induction variable maintenance and allows the compiler
to generate direct loads and constant shifts.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- Added as a standalone micro-optimization patch (addresses David
  Laight review).
---
 kernel/kallsyms.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 91ced7aa797e..52e41879c24b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -185,14 +185,11 @@ unsigned long kallsyms_sym_address(int idx)
 	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
 }
 
-static unsigned int get_symbol_seq(int index)
+static inline unsigned int get_symbol_seq(int index)
 {
-	unsigned int i, seq = 0;
+	const u8 *p = &kallsyms_seqs_of_names[3 * index];
 
-	for (i = 0; i < 3; i++)
-		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
-
-	return seq;
+	return (p[0] << 16) | (p[1] << 8) | p[2];
 }
 
 static int kallsyms_lookup_names(const char *name,

-- 
2.55.0


