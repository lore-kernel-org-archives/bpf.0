Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465241C27
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781179; cv=none; b=idfXcDx3cVucZ5QOpb0DjIezj3L128biiso4m2aJWFpuc751Uut6XZHwb1I0j8R7YHHRdjGBhYqSvG0rTUS9GnXiwCxAImF7tVFEStUqqoM9mOKKlVc8WbL+FbNWuJ4WEHlLz09YiciHh8SqTsgIEptrDsYt6JtS8rWWoelf47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781179; c=relaxed/simple;
	bh=D3qO1GMlOnd5cfKg57eDj48b+xlJK9DwlonYdfJjqMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NO0HvHtZagkTyMwKgLuzCo2buO3uFThWgOaccGv2aM5gxnhtIZ3jQVWpYD0903jQPhZCjh7V47tP8eIE1R5AN7h4wa8K6zSvdmZ6hGmv9WVRZsMt12vK4y4/1mf5btbIyLeLzN2A2jRlquS/4ahP2XduiTw7qJkUtldNgpCwhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQIwfeL3; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQIwfeL3"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c19dd9ade5so172243b6e.3
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781177; x=1710385977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adxbi6QDcay2Ge9X2I0DlgAOdU2KFX2PZB04faHlqxY=;
        b=WQIwfeL3pMb51HNddf69HhlsIaFuNUtvEa0AUROd4/KejzpEHUD85783vPCMAZiwXZ
         94Kbg5zTfcc3YLpB+JWyrD4dAvSnDHT3lDjXsspo/30qnmqIqabxkxsX9QnekEx47TG7
         pW99Xm1lm6eri2r+e9O8yXWDyH3zHiQ2A8c2nH5s/S8tMKSgkpvU0lWe2FQet6dVyMBd
         xIRhAwdOUjsiFDRpiTILFZTBDrNv36PpsUF+Sp3INUtTqVyaHL9QzwDAipO4Z+ygT1E9
         Z39higknCozuW09BIxm+8TzfdbCHSD5XPSVp16QlocFmn7ubQZgCyz+CZYpObGea7jfX
         wHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781177; x=1710385977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adxbi6QDcay2Ge9X2I0DlgAOdU2KFX2PZB04faHlqxY=;
        b=Ukk/YPLf1ZVLgcq2JZ0zk0GJsPBBEK/xCXIctirevJ2hTIAf9ERcamytBAawJOg91M
         yX8py2gDSLl5ycdAfGz6k2m3MQ4xzPm5xHQHCGHcuSteDiY0RtiLDliZ2bH0u9svltta
         f55l113wEZBlcV4fdSk78FaXHq1BSjXAFCo5JDEAwnEjov81qPdKhiuW+LcBHoTd5zl2
         WNXLMD3CBR8tw1FMXJj9z+57x1mdeSEOCH40oCdx/4/Uxww3tXHMTJrY8y5oOX/bx+zP
         Odalnk9PoueWM4V9JFLuAnPRWfg1d9YQ/lrHpT18rJoy1K1cnXATtxRajjQiJjC6Rj+1
         UkdQ==
X-Gm-Message-State: AOJu0YwmgRwjndNnPZlhbwMya+IZ1uXRcYIFkf7qDHlNqULh7mOEGIx0
	IPqW09+GS+BzS76V4tdy8VTgaOgex2lFcd6NRv4AGSKJscccXI5NiYrdAbJj
X-Google-Smtp-Source: AGHT+IHjAzfNiwCy0xPG0KicdsKWxhw/26oqi+gOT7athTrrKabx5To6xxuwAbGWUPIybLoRZmT68A==
X-Received: by 2002:a05:6808:1494:b0:3c2:f88:664c with SMTP id e20-20020a056808149400b003c20f88664cmr8516179oiw.22.1709781177003;
        Wed, 06 Mar 2024 19:12:57 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id fh8-20020a056a00390800b006e4e600d15esm11501241pfb.160.2024.03.06.19.12.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 6/6] bpf: Tell bpf programs kernel's PAGE_SIZE
Date: Wed,  6 Mar 2024 19:12:28 -0800
Message-Id: <20240307031228.42896-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmlinux BTF includes all kernel enums.
Add __PAGE_SIZE = PAGE_SIZE enum, so that bpf programs
that include vmlinux.h can easily access it.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9ee4536d0a09..134b7979f537 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -88,13 +88,18 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 	return NULL;
 }
 
+/* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
+enum page_size_enum {
+	__PAGE_SIZE = PAGE_SIZE
+};
+
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
 
-	size = round_up(size, PAGE_SIZE);
+	size = round_up(size, __PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
 	if (fp == NULL)
 		return NULL;
-- 
2.43.0

