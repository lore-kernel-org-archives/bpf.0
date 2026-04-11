Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146B175A6B
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775916892; cv=none; b=MHwstJcFu+0JAEqSw/eGbAYllLStyuxTd+Lx5pVundO1thR9DP52+rr3AIs5TvvDIPqkr0Y/d2koDF7mSA0rL4cmBXWAfbrKPR3PinSaZL5zKMGDu8V78u0tlxhm0yoT+kmfUpoiNLZnlAZTb1YGpRvHMnjz12VTTZsUVkyLwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775916892; c=relaxed/simple;
	bh=qAytnbamaUzBLN7iApLxQf9vSA5/uGw2fHQ4GLMZfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6ZsSDDUnKlKC1NwdKhO7JsWvWTiWalbxmzrx00fkxi2b3z7e5emtux6PBE0n71zCZCtLXDg5+Zc9YY3faNOC8yYBxl/Qnv1qVwuaL+hP7E0dMMTd+bCEYo3AleEvciid9SopYTX31NgaHlh34CKN1MdwwtwQ29wTaATa83lBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKsTQb4U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKsTQb4U"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f1f6103afso266070b3a.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775916890; x=1776521690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8DEYcBTWnAaRsZsHThl3Wv/DSP0vtu+sXpjHjBvSBs=;
        b=EKsTQb4Ucd6zIAwQ8Ra07Tm5lGm9pdo7adVaHY6Z/4/r0uDonOZ1lFCr+RQ99507cu
         D9/6C5iWue9M/kJuTbRbzSrsbJgNtqbGuZAoxkQn4VXeqxQuzlj7zZKugLblnTaSv83Q
         VdTyTJY88Q2qWEbV41QE8dAKhcNdj9EDv9MXdwCrF48hDqzsbdgGKcptziO8OszWQ6em
         qZmM1rEQNoOISfytZuiWJNQrNn6N/o/YM+DctX9tss+lRmNrsSaJ3SjUHqsYwgpd7bDK
         3VloB26Dccow+64PMlVvyihYvflUQK1m+m7GdfkhavhbpOmMIo10lv86eT7meJRrQ/5+
         v/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775916890; x=1776521690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8DEYcBTWnAaRsZsHThl3Wv/DSP0vtu+sXpjHjBvSBs=;
        b=aWZTOdm1UYkmLz4ZH9p8W3B1LXZIRLXt8gDaSlrPJfwskrAx7y5ZVt1A8779a10R73
         aUF6MNVRgM9TwgfcZ1gs+F2BrTbwtM6BdkgaKN4jiZHcwU+EZRyBLKqMC+lOh2ZofQth
         AFK941BX1sh0WdYV8ZcS9zYmsqxgjkmuoAr4ivrgWmGxcjAGpUYWgkYBg+2xcbb4GrnM
         xiAHGS9s0mJbHrs8VI16B+EtIuwwzn1VwdIaezTstz/u9UduAfYJASYxoAqsUTUvExlF
         1bxQx/08gXxGisWGP4FC2zDKD1LricuLTvQ8s75nI4EUgUFeCwqiwAYF/yv6n0RWh/5f
         7EGA==
X-Gm-Message-State: AOJu0YxDE8YSL712l/mjg3KX1XD1PGIxHt1Pt6kQOpxWJ3UFCvOdqg9P
	fpyR20AE8TpBH0GAicDNzYjhi5ky0A8m/t//tSUuay/TBWc06meGEpdyxEYSGg==
X-Gm-Gg: AeBDietfZMViD+MOpyURgc5GClQ968G0ek0QQS9wejUPi6DKbAmKOC+blXep4kFHsfA
	oJQOFCSo9otEErh172cZJ0XG5plItryU1FS/GfzrQw5CiedHj2HoxyGXDqhZnE7pmEtVK7WVqfv
	KQ2YuiGSkYafPiQU3WiTE5qqkcNW7ZfmYHdG9sjQDZodYyrscE7yZ8WZUDlsMvSLYnJP8teaitM
	fbkCx6DhW3gbBI1VK4gcm0B7LYYCM/IzIpKXaPgEJyGgjk4PtvltRXRXh1y53mUaPy+zleKmXXR
	FLrz9/14NvMsuQI3H8FO9BXE7MnnXhD6eDW9R6bLI3q/bvwyVKFCXtWA0Kw3tr7ovPF8GIDQ+b+
	ZkpfovhZBiU4oDlr48eO0taHZkLTiPvdnlZsWb+tC6IjVkg65Fh8ubC9DHGx2DfDyZGVsWhaMr5
	tAoNwicN5NDI7vJPAJV3816RYvuTB6mdMweEe5JUNlZVDLgM7PuxR5ajvF/J8a70GeG/ZSszj17
	ZFH3P247Sw9l5UWzkac42Nxh1x6oYJVDzcVLfDQRILCrIOX37Czo/1R1STt3Q==
X-Received: by 2002:a05:6a00:6c89:b0:82d:24f:2511 with SMTP id d2e1a72fcca58-82f0c28b69cmr8149104b3a.12.1775916889688;
        Sat, 11 Apr 2026 07:14:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b3dc2sm6135838b3a.34.2026.04.11.07.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 07:14:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] bpf: Delete unused variable
Date: Sat, 11 Apr 2026 07:14:47 -0700
Message-ID: <20260411141447.45932-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

'cnt' is set, but not used. Delete it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604111401.eqzyF2kx-lkp@intel.com/
Fixes: 2c167d91775b ("bpf: change logging scheme for live stack analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 9bb6574d73fe..59d990237cbd 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -306,7 +306,7 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 /* Fixed-point computation of @live_before marks */
 static void update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
 {
-	u32 i, frame, po_start, po_end, cnt;
+	u32 i, frame, po_start, po_end;
 	int *insn_postorder = env->cfg.insn_postorder;
 	struct bpf_subprog_info *subprog;
 	bool changed;
@@ -315,10 +315,8 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 	subprog = &env->subprog_info[instance->subprog];
 	po_start = subprog->postorder_start;
 	po_end = (subprog + 1)->postorder_start;
-	cnt = 0;
 	/* repeat until fixed point is reached */
 	do {
-		cnt++;
 		changed = false;
 		for (frame = 0; frame <= instance->depth; frame++) {
 			if (!instance->frames[frame])
-- 
2.52.0

