Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078D4418FC
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989753; cv=none; b=XxoU8p4wa6ftqyT3blJrNsHP/LF3b/0HvkyPHPkeUI1HYrgE493KKf0iwVfS+eH39T01tNKUrvKxXP3hSLe9bVYSQxS4RexZkdnbfmnn+19RixEYfQKzIHH3t4I2yBznlY99klsBw8VGEC1hoqqpIm+rPWvVcEttmbCHznLJEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989753; c=relaxed/simple;
	bh=vssmHa+T7bAA4ZAilJAyWMcbHY9cYUjiolG0Gse1JWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3LLmRX4Q5r65jcXCXUqB31XZrQgOmg6PoECIz0NLsn8EOrD38ptAZ43I7pYNJ+KYD2H27RyH2X9xSExEQDDFEaNC/fyu4W2GwUj5R5XjIFvpsbG2cnKlta0oMoj8gbdpfMFplRXHJ4qwWFtNCWhBmn0vPxMvcfhrLZtpyg0wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk7aBoJw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk7aBoJw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b23fcf90b2so39188135ad.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774989751; x=1775594551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jeKcPy/ZXologvjSOFsDlDYOtk7c/GfbQ3C0JvgJVU=;
        b=Rk7aBoJwdftqL9MrS7/9WEezQI/rahwGlD+yZ23E1Hn0QIJuzJrfHWZ9GVJJ+wpnZY
         5XjsZhfRms9eqOiI/eXCXirDuh4juubiGNPLPQjZRNG7D1aq27EhLx/EJk6HA3TVAdFd
         KhbQtARp7OGqBa4Yl+EeBwCe10WyX2KT7Qi+C/a92Sn+EvXm3jp/ahh5iZckYHsBtihS
         tacCDGpsoMo0HOX2rqi8tSZVGFe1zXvaX2jAsYnvkxHyZeksGm4sHURZCJt6trgurEsQ
         xyTzFv7QXHXeaSTGofHueVB42TlXO7WhjdhodWOK4t2NtCq5+9ugcwJluPez3o+0udsX
         uulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774989751; x=1775594551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jeKcPy/ZXologvjSOFsDlDYOtk7c/GfbQ3C0JvgJVU=;
        b=o/irUy6OWbYRzTc2/024IHUD8A+Lv33q3zNOV1CK7GOgKtXlnfMcM3j/FAGXdIRJHW
         gJbgh7MFNJLA1JvKJQUzfbDjnbagjHsR4Gvb0MHOv3tWd5putd2LV20cUy72KdKA//ZE
         LlpnZBPytfj3oXq2viZYTFsveJK36eIFf4eSqu9wl+oXpRoYYICzNXuz9Nzg7di82cBK
         4mb4AnuZa9zrnzBv8A5YWQlw1rnTAMsBYxR0de6507G1Cwd+ebe5tY6GftI+SOiyU6an
         tY6Esbtis/RcMN6q7z0l4g8CgzZhlHme1N8Lhdtof9dQmLWKfRw+3ZtxkKXguZ0Ddt3O
         o6OQ==
X-Gm-Message-State: AOJu0Yx3Ww0/+Gk/hBs/eZ56BAHegBXH8GaEPTkNvAb5v6B4SOEXyMIU
	ZPg8i1iOLP6WQyU86imEWlyLqdph1osEE4ggdb0Ew7eR7qA3ifROUOdEhRbQVQ==
X-Gm-Gg: ATEYQzyXKKsDtyj0ka/AJItpG5HNK9frJv4UGkU4fRU6WqAL/AGrSpAhr6VMNBi9yRk
	dk1/V9hg6uZsC9xsvCE254ac2sxCxbm5VXPS8PhJvSu5HVWNz5Q7H+KD9Nl/gzTKI4udNkh3xQL
	J1I56M3wKPbK5+xr+q7M5UhrwPCiCR7quZKRADQkcGwIRoy1jXVsAyTlk0RCBv6JcKMdnpPcG2X
	fkhM1yovcV9pQ8aLAPtC6wUX5JCHGLHD6NjeZqrPThOgSRe5twp4Nb/I6JVQa5uTyd986xW6jGz
	ASEMOoKMDUwAJH+r3Z06uhnU0kG375OIN+/pLJIRLbQJtLebmgvWjDVDnLvF9dHrcQ83XlXY/+D
	j+9ZhjMjRqbWJHFCytXWMKYAma3L76TX9gOlND6PVcOhciMpVsxw3wJqi+1sUka2NJ1/MZiVg5l
	YU5eit6RyNVbeEKd+nUZtsESCHJjNhRAbAv0+l5l6eff0MenYW7BilYlOFt6iiuTUgQIYqV8I+g
	00sDv4uNMLofDSIzMQea1kRDCh4TBnl/t6DeyZmrZDwb2jtWvxMz/yW6d87TQ==
X-Received: by 2002:a17:903:b90:b0:2b2:4f43:b48c with SMTP id d9443c01a7336-2b269ab23c7mr5191735ad.14.1774989750718;
        Tue, 31 Mar 2026 13:42:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2426896edsm122610005ad.34.2026.03.31.13.42.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 13:42:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf] bpf: Fix regsafe() for pointers to packet
Date: Tue, 31 Mar 2026 13:42:28 -0700
Message-ID: <20260331204228.26726-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In case rold->reg->range == BEYOND_PKT_END && rcur->reg->range == N
regsafe() may return true which may lead to current state with
valid packet range not being explored. Fix the bug.

Fixes: 6d94e741a8ff ("bpf: Support for pointers beyond pkt_end.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f108c01ff6d0..658b24341df9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19915,7 +19915,11 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * since someone could have accessed through (ptr - k), or
 		 * even done ptr -= k in a register, to get a safe access.
 		 */
-		if (rold->range > rcur->range)
+		if (rold->range < 0 || rcur->range < 0) {
+			/* special case for [BEYOND|AT]_PKT_END */
+			if (rold->range != rcur->range)
+				return false;
+		} else if (rold->range > rcur->range)
 			return false;
 		/* If the offsets don't match, we can't trust our alignment;
 		 * nor can we be sure that we won't fall out of range.
-- 
2.52.0

