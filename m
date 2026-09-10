Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F73B38B9
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058827; cv=none; b=mX+cSexYO1I2r+GHi8T0uUsswSyKn1xkXIAUG27StHL4uN9emLlbotcr9bifts3Dw7bWQ4ULQv0E6rOQm88Qg5qVfxyborjaRbDayiBQVnLSjvkbV6A5pmw1z70FofYkKnhhXqdOc6WCfdAvLN2aIuyuVQHlLU/V7fVYVdsHJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058827; c=relaxed/simple;
	bh=5rOkBrAnAGddpfTIFywUT/GOQ42Lh1Wz2ZM+WRYQXb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZATBXZXZ//JtdlF5LefPhLl/dIRNTbDunRu7/Q0QMfjisPhfQHS9p7EhKMQKzViPy0OpSHxqG7f/5+8F+R99gMzNYh3367t0pkljowBWWo4eNgMdSTmJPddi3J9C5CZBUb+saE1uiR1lKAeQhhDs2s8jL6T5MBXPrqNy8JVKhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HUmasok3; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HUmasok3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5rOkBrAnAGddpfTIFywUT/GOQ42Lh1Wz2ZM+WRYQXb8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058822; v=1; x=1789663622;
 b=HUmasok33Sis1DKbJF+4lp9Kx3GzS6YvaRQYpIGtcy90u8wJXS0KrxsfxhOF6Y5C/27BIChW
 VjFei/Z4IwPI6rc+34JIIwXjFmC3v/tkOzkYp92AohkLReIEbju1bx42w7pk6omh5U6xcfvNcKr
 OrzTJZNL+WQKJhbZUurFZwtU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d6fa58a636dcf58b;
	Thu, 10 Sep 2026 16:47:02 +0000
X-Mizu-Trace-ID: d6fa58a636dcf58b
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 02/13] bpf: compare linked-scalar kinds in regs_exact()
Date: Thu, 10 Sep 2026 22:16:24 +0530
Message-ID: <20260910164635.459558-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regs_exact() memcmp()s up to offsetof(id), so it does not see ->add_const,
which sits past ->frameno. Compare it explicitly.

Two cases go from accepted to rejected:

  old {r1.id=A, r2.id=A+delta}  vs cur {r1.id=B, r2.id=B}
  old {r2.id=A+delta32}         vs cur {r2.id=B+delta64}

The first was rejected before this series -- the kind lived in ->id, so
A+delta was a distinct idmap key -- and the previous patch lost that. The
second was accepted before the series too, which is wrong: alu32 and alu64
deltas differ in sync_linked_regs(), so the states are not
interchangeable.

->delta is inside the memcmp() window and is cleared together with the
kind, so either case needs a kind with delta 0, e.g. "r6 = r5; r6 += 0".

Only states_equal(..., EXACT) and env->explore_alu_limits reach
regs_exact() for a scalar; regsafe() compares kinds itself on the ordinary
path. Neither is easy to drive from a test program, so no selftest.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new. Splits out the comparison RFC 3/6 lost when the kind left
->id, which was raised on that patch.

 kernel/bpf/states.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d974baad37ee..5505d7aaeed0 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -475,6 +475,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 		       struct bpf_idmap *idmap)
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+	       rold->add_const == rcur->add_const &&
 	       check_ids(rold->id, rcur->id, idmap) &&
 	       check_ids(rold->parent_id, rcur->parent_id, idmap);
 }
-- 
2.53.0-Meta

