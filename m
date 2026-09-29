Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B65187CF;
	Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705251; cv=none; b=KP6pXU0aYxWsSRp9ddudczRnv7upmsDQWY8jkBKNvhEdeTtajqwtaX9VASYg4qwhD3zSHD9uB2J4lkAwfBhfbUdUAqnI1iIxK5sIsWyBSzEDrEZaoByMFRv12Qk7mNjhauJITpOAP6Zq9MwW4Ow95HgARAacQNucyFxdzetZDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705251; c=relaxed/simple;
	bh=GI/d9/oH5DJNiFiuZOnJXcMZNNvA/Gob8NoXCPf5QLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laHga02lYzP1Tfux+0ZOiyGDu4fOv+gyo2EXWZr9czotRjt+ljyJamYISg8O0wlLOrmhLT0wLerVqW6zEB7lJ5/g/ICv7nXpJU65+ZA1AaC+WF59mXBdDn6G8G9SV1KocTR+kn2EunPhMB/k7UWB/1ZsaeQMSTbzYcg37kFUpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/ir9Rya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/ir9Rya"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D987C4AF18;
	Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790705251;
	bh=GI/d9/oH5DJNiFiuZOnJXcMZNNvA/Gob8NoXCPf5QLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a/ir9RyaE1m83eyci6RFp3m1wf/ibVTRxaaVpSDc6t28fg69JxuduKppO9PldTevF
	 I4Fw5rBS8NmDcKQle72DvvAoDtqE5CtqcGKxfkEhGBzqnIpuLJSW9gn4xyZ8YGVPjo
	 iQvm9BbCShBO6NV55KndgcFH5yT/fTP3T6autwBya6BsexCu+g9Mkxn9YkLq9Al6U/
	 2ZpvFYneZD7wz21m/ZHfX7UcbRGdaZnMwUMPv67HkQIuEDmCU363n1VeAvJcwDIBvJ
	 OC8Jn9nWf23lwB0Etk734O1jx8juinFT0CUJbdZircfP7fVSYgRB6RloQQhIrPGjt6
	 hUurBGhQzOGIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706D3CA5FB3;
	Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 29 Sep 2026 12:07:32 -0600
Subject: [PATCH v7 3/3] kallsyms: Unroll 24-bit sequence reconstruction in
 get_symbol_seq()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-ksyms-tune-v7-3-be568ceef41e@gmail.com>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
In-Reply-To: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Kees Cook <kees@kernel.org>, David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790705250; l=1647;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LVYPylbZu3M6VrXkQZcoyGu2621tAs/rWNxgexduWm0=;
 b=18zIC0MoLg6SshbdQ2c6r2UbPDpfoY7JKrPcWeWmYJcT5UL6KV9dbk+P1GtGJuztBH/8RyOEv
 lWDE0w8lYjiAVxFNU2x6cj9HT2SlwLd6EljjuRzFQK0LZpyrCiDFu7f
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


