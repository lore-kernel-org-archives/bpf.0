Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C993438A9
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787476900; cv=none; b=a4x8TRzcyBvFL0DVV80y1hMDYgR0tM/jgko8nIXLTpn7I/0JhDONArGBangqljvUKn4i/Et3nzERuSimeOuGY0hiydJBElfd2Sx6126NE3Dt6jaejFkV2K4rehXFfjeGDY6ObQQMC6FxWxlYEqkW/6KYTBg8slVDqs4ccr7gi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787476900; c=relaxed/simple;
	bh=nQmntYOWK7++9Z9+s+Z7jdXMLX6XrUwFr5RaDZgTEd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXykJm+yvmPlRQAXkIcxPW5xXN6OrsRdNaq/Jq5xmYqtmr/Hl/j+l7iMPwDDLe4VuiFbYWZM/Ua/G4HNoZ5dBCgZStjtynwtmGY3w9DPBOPjZKr9uokjCSrAspUumYIQXJ7hoqr9rIe+0H3JT3ZQtLGAwWHfPR4VPBBbTbw367w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3PR5JaJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3PR5JaJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5335cf904so18823095ad.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787476899; x=1788081699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlr/DJG7BroCe4Giah1t3kYzH+rrXIGGUIGLzYRvoNI=;
        b=A3PR5JaJ+TxZ1NG1MRM5W3lyKx9NleW4QpbR1i0o2P7hsNZZnQJ6NE2rvWXx7lUK4m
         3JMfJgfbDs3XDmg1selXjL+E3gpx7AToIvu2thTqFm+7lfCYlZ7sbBl4dJC72F0l0ujB
         IHjApXOGywBw5ReBlnAAjijJ5CQd41I5AnqSJNuEkOB1lHNL6mR0/TPTP2Btwa4TPAB6
         0HsVxTiys3kdYb7jNjcXj+IG1pCYM+UyA8YD+As5QAMPe227bK5eWWfCPPMp7i/lPr4i
         nUxpLBTOM2aJUtKSxgaBbQUjUT3OrKfF7Dy5hKyC2Gc3MNZ8wFjcKKBFUPTc5WDV913P
         +B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476899; x=1788081699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlr/DJG7BroCe4Giah1t3kYzH+rrXIGGUIGLzYRvoNI=;
        b=RxA+ZF3VpTkSgyTr6jIOMuxoyOys7Y0QKTS5meLgcYAe97gRi7UkmCB5/lTUY4CFEL
         FMUhyUiKz2UP/7Xlf6EubwUjwNmKRLZHDTCFOjqOE/qK5Yfc0eQFOOYsBvsBJ2IIH2fD
         Mb/pts1ij505LIHvbjEVOa+PRW+NQfCoeoezUCgg9qAE85YcqrVCkw5WuT7Dxv/zK/Wt
         MgP3g9bH6ZmMjJe4mITnZWlQOlqe/XfDtija6JYwU/n9MsB0LXOnfll0joNtTUJNTuh7
         z6+D6H0iWekoEcLwb6LsR/y6f1VeHqP6PPSh+2mtijhHu57+AXDNT91SoRWpZwLPhsN4
         B8FQ==
X-Gm-Message-State: AFuF++lc392mmY5+qr0SOu4yNgmrk53NAokGI+CEyDmsbX/E1PGLuGDC
	J99Vcz07b3WohnX/YgzQH1OZZ94gi1l1fKD4O0vCbCxIzo0kIldvOKTNBaIwunA+
X-Gm-Gg: AR+sD13rA+UO2K6czeDeKwNp/f5Ylzl41ykhDPIPGu38GESJHf00pp+yIYD9nHMD9nJ
	TuNEmmeUSIlzZmyxmzuajKNOk0jgsTYBawvlOwAQBSDcYyWY0WrhChQs9I4T/2Y1DYn/Yu3jMjJ
	5cipRhOmoGP/43UYrIpl0F1bdVmFSs0o2+C+UghlbW//u/S1tScifVD+CiZShMficyShJeQZPWk
	X9zTZ/18t8hPF6IXa2YxmEifoKruguhvBAnNFLx/GWYhQymA4zA+MllI5tnvN+WLmJrdoCqDJA9
	TRtCzGpSnfh8KXa/cVBw1leklWRMfbqDh388iagbLM9a48Lev02nLg/rNZ14vvk/BPgQGIWjrNT
	npAtZ4+XKaaYJgdUS3g9/JpQyWMUhS9r77822TimyzNWM72/Rbpr3vHhNwkbKozcgy3TvY/xE6Z
	StImIuGQtfkG3p9rykJ0F/j4h1BcC2blsaf050GkajOhQel0Eoji/Edct4S4PLCKc=
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d64af6f8cemr349236645ad.8.1787476898534;
        Sun, 23 Aug 2026 02:21:38 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768b9ad3sm8721915ad.58.2026.08.23.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 02:21:38 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH] libbpf: Ignore exception frame section
Date: Sun, 23 Aug 2026 17:20:57 +0800
Message-ID: <20260823092057.82200-1-tw19881113@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exception handing should not be the interest yet, let's skip it.
BTW, I found this when building BPF with Zig compiler[1].

[1]: https://github.com/tw4452852/bb

Signed-off-by: Tw <tw19881113@gmail.com>
Change-Id: I5ee6c05bd8a684261c53effe9c95d9f26a6a6964
---
 tools/lib/bpf/libbpf.c | 3 ++-
 tools/lib/bpf/linker.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c0174..05727c418 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3867,7 +3867,8 @@ static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx)
 static bool is_sec_name_dwarf(const char *name)
 {
 	/* approximation, but the actual list is too long */
-	return str_has_pfx(name, ".debug_");
+	return str_has_pfx(name, ".debug_") ||
+		   strcmp(name, ".eh_frame") == 0;
 }
 
 static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c392..1fb0efdbf 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -599,7 +599,8 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
 static bool is_dwarf_sec_name(const char *name)
 {
 	/* approximation, but the actual list is too long */
-	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0;
+	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0 ||
+		   strcmp(name, ".eh_frame") == 0;
 }
 
 static bool is_ignored_sec(struct src_sec *sec)
-- 
2.54.0

