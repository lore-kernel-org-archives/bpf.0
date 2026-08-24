Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EF3E4C72
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576574; cv=none; b=i+O2LlMjn3Ab6M7V17qhUeZUWPVOCO767u6WkbXSCTG6s+Vvst29v18nt6u3LrNvOJTHGzr1zrrdXCTtHlxJwvGu+p2pzVzQGQFkxx2kc8NvCIvWNZ0PNq4P3HFgJnHh8ZvNRdSi/GSbd0YDdsSoyxXlDeWU1Sfvga/sD236WOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576574; c=relaxed/simple;
	bh=Yf3CocZxlfDiGRJYeS7Ln0JnuXxH4X/3PH3KUml+5EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3OSgnyZlQiA+72GGAk4SzNTwH5LnV3aneurr8iXp56S3+a5bKpO4/eQFtOg8XMocT1K+RGVzBMwm4DkTV5bjAKArIfQdHv85CgjvpzxgjIb3IqWkt6geOfEuCbOOo/9fKyL+HYNfhzG6dJfxt91K3Gm6HNhA/ZzlSAwJ6NeGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFj+31bi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFj+31bi"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2907780a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576572; x=1788181372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJ7oBady2LpWxPMZn0imQAKTUkwJ/XDLCM06C9AlGKQ=;
        b=TFj+31biEZ3wP93wrxmQbsFXjQyX31qwyT7dvrFHAreqcVb0ke1cgDlp1dYkt1YaBu
         Y9/fsHdUoRhwGMDjVKtIk+R92AvzasvKl39v2Zk3dYFlIVXxdIKtr9pnjGqSllYh0LdK
         gEzPJ79EmSaJ0NRCOf8M3eOVr8IZVpRK/Fyu7Zyo13jTQUo3QkTs68J4kYUlCwvBhsuI
         cmKysfyMSjfbkcf1yn6v7sqgmtmA+DZHoxi/rHG0JUYeara+VG3WfhF5W4DNQBVtRJh/
         0tqG259LM4lW45C7OC5g4FHylN/PNKbl2u9cNGKa5HHFerpX1PzuIvUXnDO/5RiEwzaW
         XeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576572; x=1788181372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJ7oBady2LpWxPMZn0imQAKTUkwJ/XDLCM06C9AlGKQ=;
        b=JptHBdq9fmRWB3uCa99ppKNwO7xBFOCLmnv0Aia3KUCnYIx1SwPMrSJR84t07fum7z
         GM4Uyvv1V0+xclJTxWJ5nvhPFONzajr6vXiPKYugHysbhPwJPC8HHLsq7DyfgAzx6lzc
         UjXyF+fBHqIUjGgWQ95enE56u/Xn9owGjUt5sPgRQx3cLGyYok+xoAApG1wPEENY2DEw
         2ocklt5oOJ4zjaeROxa40OSQwNbKlytbUR/Pkw0GYlx6FwIzrPnL4kuPlGssBM3Xgr74
         mImx9WqD/3+kRYbGSYTj9pHSUZqE90rW0FyDI/rEg9jON8j2q4s3S6IQhgNbX36K3TbK
         1rxg==
X-Gm-Message-State: AFuF++nCBreqj+oKmXeCfxqwW+AwG3gewfMrqpiLcc+qYeQKY6FmN1z4
	rux+quzXQw2FWjZDCdAbaQltruz8wy6+a5voS3wjmQe9SqrAGWXETVF3UfJjeXNT
X-Gm-Gg: AR+sD10vZqQ7Pmh6mAAUpoimVsnPdTaW3zpIFCPgEJ5m5WnT5mL0AlXDT4G1ktrR3Fi
	K9drnddFmSusFWVkqC/ypsun3PsoP+7wrFhN0EYAdXzdrdIRr3bOJ10DRcvOoGzAqYzaNHwC6bo
	bnLSJCGJ0Mwks+qmwP9JnwnQKOxEvs9Pnzpqtt9Nkg/k1FtyH35P7jy5PV/LDpbQkY4Pq2YXBi6
	xLq5MsENpxXx+WrjC1ecQv0C5AK43l/9Xv/1yWMnBgK4Kh7zvzXi2sUHxBBiLSbPuQCuPBhKMm3
	T51jEeWMennLOxRWZfIaKBdFwb3FMWzw2ztYpurBv8kg/u6oouQP9C94tJ1zihQti5Pm+b+Bpo7
	EnV5B9dvCOEbAyGKI5G3JPS5Mif8rPvmnsDQgft/5qGkueBL/SNtuGBkQA860z2PhN/6EYdctHZ
	C/vLQjm6FBHePjYK303BvzW/AR8OdsH+kpiZKeihtLQUcVEdrO4pAMo0vYiHQiKww=
X-Received: by 2002:a17:90b:37c5:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-395c4c35ac3mr24350418a91.3.1787576571408;
        Mon, 24 Aug 2026 06:02:51 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fce4fbsm4330776a91.1.2026.08.24.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:02:51 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH v2] libbpf: Ignore exception frame section
Date: Mon, 24 Aug 2026 21:01:33 +0800
Message-ID: <20260824130245.580545-1-tw19881113@gmail.com>
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

Signed-off-by: Tw <tw19881113@gmail.com>
---
v2:
 Revise the commit message.

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

