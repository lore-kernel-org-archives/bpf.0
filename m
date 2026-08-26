Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF353FB067;
	Wed, 26 Aug 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759765; cv=none; b=LVT6iwGtRXDJoPQE9n4cgldpbH8ADOKsULiGqX+Ysm9+uuM6nORWV/qfk0hju9i4yy1/RLK8RE/UtXtzXUrUBHwGksZsr3MriiZJAJKU4yDGVWqS1Kf8dNRcuOQRPMdey+OWCvFj4EFciG+mhxWJXup9nZwbivyZqQHh/SoTByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759765; c=relaxed/simple;
	bh=/DI1LeiV4wOLRgjpw4V8nHUf0uW01ksKySY2chdDeSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcCFyux3+6nyS1dJ58bqmLLrUuVX9mZV2gck9CQnHnem6LuEeG1qhMn5cnWJUFWEzooF8vnOcSTzsiH82bqxFrlg18lHAQJ7yxkjbrmSA7irlc4scJPq4ZXoTpYzyHf/PRHZb/SpVd32w+rNiIvp8A0/giq+kPHzgUgVXMe7dFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG2+GO6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG2+GO6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3DF1F00A3A;
	Wed, 26 Aug 2026 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787759761;
	bh=Xv6LvbJXor25svpyF1shB5+LUX7dxOQBbe5g57lme0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aG2+GO6GAZcXlhCpgH4qqw7omdbZ3lTajbsgfjPtKnShfu336O/+yok0gpWBwbMyW
	 UnC3yKhfup2dfl8lfHCHm19GXWaVZy3azoYf08PvN+emHgQA68VZmlbExfYvzG4ekO
	 yB1ubax7/mGSYGYh7XcMZqHFdcvDb9Ka7DtDiYl1HMXEsh8yginUNM2seFi/jfnExZ
	 7k42I0xrAC9bIOd8BJ49XyO5DrZa5syu9TCHEDgn3iFFmDyKa3pXDmiSNUkNu4UJoM
	 kUuQEOZyLKlJSMPF63ra2VbzjCIRXHlhL0QFhj6CKWD5OyK1lW4h7TEsF5DE3f6A+w
	 7kQdiwLbw+CMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 26 Aug 2026 17:55:46 +0200
Subject: [PATCH 1/3] binfmt_misc: only let punctuation delimit a register
 string
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-work-binfmt_misc-delim-v1-1-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/DI1LeiV4wOLRgjpw4V8nHUf0uW01ksKySY2chdDeSU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT183Qz6cbvOhpjcTr2U+iqQ49fPVTbfn5tje3Mt9t/r
 rkoOeHixI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJsOkyMkzVKO9/Z66x/tG9
 n8vYinpqf/s85Ft4z/Drr7KZE0WOGl1kZLgotkVbfnXS9FDJX/cXL1pcsXyFxu6F6z6/z+bsteP
 teswNAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently we accept arbitrary delimiters which really makes no sense and
from looking around it's an unused feature. Everytime we add a flag the
number of possible delimiter shrinks and it makes extensions much more
hazardous than they need to be. Stop it and only accept punctional as
delimiters.

This extends commit 8e85d50ba111 ("binfmt_misc: reject a flag character
as the field delimiter").

Letters, digits, whitespace, control characters, bytes above 0x7f and
the backslash now get -EINVAL. Everything deployed uses ':' anyway.

Suggested-by: Farid Zakaria <farid.m.zakaria@gmail.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ddfd3aa57ac8..809c91d21b39 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -100,6 +100,13 @@ static const struct binfmt_misc_flag *misc_flag_by_char(const char c)
 	return NULL;
 }
 
+static bool misc_valid_delim(const char c)
+{
+	if (!isascii(c) || !ispunct(c))
+		return false;
+	return c != '\\';
+}
+
 struct binfmt_misc_entry {
 	struct hlist_node node;
 	unsigned long flags;		/* type, status, etc. */
@@ -872,10 +879,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 
 	del = *p++;	/* delimiter */
 
-	pr_debug("register: delim: %#x {%c}\n", del, del);
+	pr_debug("register: delim: %#x\n", del);
 
-	/* A flag-char delimiter runs the flag scan off the buffer. */
-	if (misc_flag_by_char(del))
+	if (!misc_valid_delim(del))
 		return ERR_PTR(-EINVAL);
 
 	/* Pad the buffer with the delim to simplify parsing below. */

-- 
2.53.0

