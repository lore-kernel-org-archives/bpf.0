Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9484433E75
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579945; cv=none; b=mxiR7FJXdhLRsB6DM1BxYq5mOW9ippjkUSzizCLNAyiTsFaaeBMMqvyWW9v1/Iy4m8eJWZ8/HQuGe/EMUU0zreZB/P3OybbaO4WXrvHMvtQBanSJoTTJjMCr+7xWx5hcKDHSqX7XLvvAk6zRLJyIF6H4/SlHzaU+tzXk2eo7V8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579945; c=relaxed/simple;
	bh=JvLBx468Dx7rBqkWZqjh/9u4Rpx1xG6cBfCKwWNGXwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/zoBfpxC8HErQw8ScSnmodFb2OxNcfY/8T6tpRGpgnOEggSUHF8QI0fMVF6880tN8vUp3hNgJcazv4ISBzK+TDAp+md7YuzoPM3toXCBKV8107sNuRW0VkTuGDiVC/QJKgPfdtjVlmjiFkaNNDJYyr43oizIExGWmqZsJ99MNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElajDPmz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElajDPmz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so32290775ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787579942; x=1788184742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4oGhcwhpPQQ42k8etegg5G1ArlgT12tO1DRMCpefVps=;
        b=ElajDPmzZk30/7HjqthMSQNRX2yFaTD7uskIdCmAmS5D8+pIhtg7srB33t8TYnVy6P
         qAFjYbnURS3gullHeBVnHQXxDlKLl00L8EwlxU0sjcweYxBN0wRk9lyydtFGVM+YH5Rc
         HSYJMxFLHAVZLhGA2LMJ8/XP1O122VguZDs9H0EllP+vFIQx2XNp7Er9EyQbcn8wBkbq
         0Byk7uNxLfsGeizAv2Ik04oAsUg4xBj26silNIzv1xT+jcRYlWUJ9PPdg1Kzetwo4OlQ
         pT1AIoWcugGFdrnTIaGylICjjtehtGmu3H3eUBxr2aWfsgc+qaktfOY2CvJxnrzpvEuD
         Xbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579942; x=1788184742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4oGhcwhpPQQ42k8etegg5G1ArlgT12tO1DRMCpefVps=;
        b=mYCn8m721vEYHWfR+IBNGv5jNhMJw9ZqmqXJxK5moZ7lUMR2PIeVhM3NnpolE8rr2/
         nLzF+veDItMh1ZCdpjJ4aXqpwDPMfMO/KVPT7xa6NVGe0Pwye4anh3VpA92lpAyt9fUG
         e7x2HuREW063J0eteyWhTJRMFLWqr91b1prEUhgm6tEk4Y06kuJD35LLLvp4qGqLhu+L
         o+44UcX2dVye1qz9vsJzE2qj6Lt1rS9rnV9jxzoS1jgiqpCfN+ESjsvoVTUOdW8T2YGh
         1XoZYNs/5oViBY/dlqVk75EUHJ3LoKSl01j/fKrBAAHwdkIdK5eklr+Fxe82AvwmDdsK
         2BKg==
X-Gm-Message-State: AFuF++mjEVrwf9JIYBkhAjxEl/t/MvU8ArJTX/zEakzZGhNoa+oEhPx/
	+TxA7u4ODd3XxX9jXXFrrnBP5B7DpqsuNQ/eyDIjmCXChJRKH7vM6fApAGtAmp0SUVM=
X-Gm-Gg: AR+sD116ExpThBWIqmfSBG+RyF31VvJWyAd9dKS64kYbUwRtTK6gCzDQRPlIQ1cL/M/
	iXtznCxxEqDi1apA/tkoMqujdgHsOGOyZ8NHC1eLhD5K08PxpW2aww+1pWniKRXuYNMfwxlKW5h
	Lx7x4kQzcfne6ey6a7dRpTeAcMka0oqkechMVG8PbkKhNymf2gfrtg8kIG6+RrkbNO2WdTPGgov
	s1Wro4X1OzNA3B6aSo4grYJTicVPw6Fz0bUSjj+lKchFIbSvHkQeGeNY7660DSmVCi8n5ybx/tQ
	AnyG5rZ2NiLXrdfPzOHgKPJZ05qyw0HhU1ukYNDDvep3mSNjEGVg5R6LF/Vic12egMIdYH//+Zu
	1BqytYXehEUTrarP0RPbJIZUM+U9QYVf1zfRpUA+SbWbfFmjGUxW+pRuj4u5GtPRYlbU8zGXU0m
	nyOoU5+GvAj/NAjTCyw1iIQ04hEI9grymoZjOsJpCHwBik3a/tVZ/T3CWo+tUt1UE=
X-Received: by 2002:a17:90b:39a3:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-395c4bdddaemr21087320a91.1.1787579942439;
        Mon, 24 Aug 2026 06:59:02 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2b97fsm10710231a91.16.2026.08.24.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:59:01 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH v3] libbpf: Ignore exception frame section
Date: Mon, 24 Aug 2026 21:57:57 +0800
Message-ID: <20260824135821.597634-1-tw19881113@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exception handling in BPF program is not supported right now, let's skip it.
BTW, I found this when building BPF with Zig compiler[1].

[1]: https://github.com/tw4452852/bb

Signed-off-by: Tan Wei <tw19881113@gmail.com>
---
v3:
  Use the full name in the commit message.

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

