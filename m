Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E34582D4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107729; cv=none; b=hQvWfVpDPU2lgVEwltFyuBISbKaHq5Q+g9RI2sdH8+y83fuBmTopYmuK20Q2fdPUftJ7muFvGgVdSI/LOrOasvG6UIrg/EUbnSu83IK+L5ZiaxwFq9lhQaxXy7y1LTJ5oMExLDZEqKLD0es7AUZZiYb7fugRFTPfY1VmEvKtXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107729; c=relaxed/simple;
	bh=q0sZDppUsa+eu5sPpZoAEi+M6OKVy6NJVptfUVXehJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozYHbFyFYZDjpEetlh3YDVpjPKMK7x8pLZ1RALofPA0qkHWiUs4v9imm3uFgfyx7XRuS9DlYV6sS+RyeuguiBQDgfSg8ntNCjaOYjWo4ei3WX8xHKtZg5YYTAYYeF5LFeIhgR/qanNOb1HnIW4lqdYsE04bmVUtxzbt6ES1Ja0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1+oAekl; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1+oAekl"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f1dso125494fac.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107711; x=1790712511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AlFlDOH8oZxKnMeTYk9lUtSf3sYQz7J3e363i7elvXc=;
        b=h1+oAekldty/KlscOKiGPYVEtvgOO2vLr2xMaL1f78rh2FMC/qnCkoKhbEm2U/fsrv
         1h7wA/Mpc2IJobVP8meGgjHsOatUjfbWcHaWQOMkbypk0+/3UHKafiXnok3Th06GOmw6
         kUMYL3njRRlIbisYK7A7jZCm3vUTiYPdysm2ZMzvM5XxOm4xYS8lJBwSrsu2i5QgTxN4
         jObObBzwlpvEWRIgnXb0X+NvxD1MLge0vgs5o7rNNMMYtFkmgDKlYXDU7EqHEN7SpWpm
         7fYq+lZqQ+ZJdG/fM0XQ6Trhrqx2+2qipAN7fyk+XYOVcynfJwfQ/7ifnPCjLpZmhWZI
         r0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107711; x=1790712511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlFlDOH8oZxKnMeTYk9lUtSf3sYQz7J3e363i7elvXc=;
        b=KaRBg/35j9Oy5jxb9159rY1uZQT3xUu0t+j0jpxutRbdLLzKIYrOfy8c2XLNg3PjYx
         RoJxHLVIiqQAWorFg1LgCR8HrsxxORbWEyCZ2aKgSgoL5I3wsWDIxLxjuVlC+4oyqEr/
         QXfSShPIuW/EhuVZR935TY5B8ACekVvj9ctIDKyeFW3qLWclBSOnN9hiB4K9XLy+K2+t
         pgnTWpdJ9cHe+UDcpbKtDby29QnI9Vag+I5FrUuOO7SeNpitZelBf+bnS5SBod1cuzf+
         f1+uQ3hqw0EqnP6gp8np+oj9hv8poMb29iIf6uqBGaecYvb3ZZFzB4A6gA52tSJkNUSq
         VfJA==
X-Forwarded-Encrypted: i=1; AKwUvBzJbCS3q/9Qn1TVlKRV1wb37y+Ksjtn/cA/MQmP3v7mSQBme5SDExon3/mMZNfceT05Z2o=@vger.kernel.org
X-Gm-Message-State: AFuF++mfiMxwI6+LLoO0BMgxN5/rOJDesUVR4QBW7egTriaiuNG0bRwY
	A4U3MdSSOHZ/s14JI41RW4QzYbEoydzZvkB9ZkPZ+Cs1d3aBgV4h3b/t
X-Gm-Gg: AYBFou14+up/A3yjhCOV3RuVaCjt7/3MFTd8lUsqJ7LpKvFXYpxtbfiJ9PRa1+h/hb5
	3GB1PODp0tUiLSoPzpozUGILcoa6WO6nuc9GCjZ1VGNEmHvSmU1flcEzJq1nefwIb4s1Gt/WVkB
	LjhqqMI66mFbPOYaT2SNmGKwE/9BthiV7Waf8xq1rwXIGLqXEZ3dWHEYQNjIHPinJYtNDcMZ5KP
	Dp4xCA9V0srM2/EUcBxeUORvx3tm36JFvhjJY0NBfQNMME8/3pVxJy8EbNl0vG/M8sP1eHrQaHL
	LCrJ1qSpz7kdm9eDYHbrLlYRg3M+OqAd9CHnJ1xXbGCOSVTGGopa7T/y+NyTTMkGxekyEzhubwv
	ok+LGo5fL03Fsee3EuuUmCz4iskqOXUxNH6lFBBH2vFibn58vP/zt30Tw29B+VuJUpjP2/BKPLb
	njlA2VJrNoLIV9fMr+fsHcy3ClwrAamlsNfv572X1yk2qwYOBOerNt54uunmrssUs7eHWGV9l9o
	yArUWKbC8zZoLxCW9eh6T7OjgkjfBg8juwjD+F8dHkpE0CWVE8ZPbvip3fKPRDpDFNwEW/bydP3
	2Ka0quJdDCgD1RO03/isMRhjfAzSOq0k7Iv4yDBX
X-Received: by 2002:a05:6870:e996:b0:48f:82a7:84cc with SMTP id 586e51a60fabf-4908e34ec00mr569116fac.0.1790107711491;
        Tue, 22 Sep 2026 13:08:31 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4908eb9237asm564087fac.12.2026.09.22.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:08:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 14:08:21 -0600
Subject: [PATCH v4 4/4] kallsyms: Unroll 24-bit sequence reconstruction in
 get_symbol_seq()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v4-4-92acea84b911@gmail.com>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790107704; l=1647;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=q0sZDppUsa+eu5sPpZoAEi+M6OKVy6NJVptfUVXehJQ=;
 b=YtdomdHVifgDSmUNlCebB5wNAipNPmPSACPDou6l7lL+wvQSUi9uR5FwEr5jNvxcdDOPZLnBM
 6f2Qs6omN03AmSblhpXa5N5LBIdHGXVNnX0ZTVbc9Yh66o/qdxqaklq
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

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
index bb34b4c0f690..35484361201f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -280,14 +280,11 @@ unsigned long kallsyms_sym_address(int idx)
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

