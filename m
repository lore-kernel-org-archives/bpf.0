Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD783537D8
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387645; cv=none; b=RJGjlGJi1/k5lBuuV0VR3QLreo5jIuE1H7VGqw9CbwSfy1OJVHbYMhkJj5xEZ/2c2YvOukIVbxMxJnzx5BCBkgJupDBuS0zeVcDxh7wsb3fyu4ULKyq2oQZGlMIin8PZ48fLMqWgGBrUDP2LAfE2er8rPhdFcRIHGT+ZpAix/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387645; c=relaxed/simple;
	bh=HhuDIiV8tWursPG2/V/doYStZhoGJQBDqDKH9HFRUSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6yPYGyAJNjRuvEP32H3Mo3tYADT/eiGxRiMqlHvp0r28xQwAArT1zSEyKZ+KiKCrEf0CJoacYplCwgyqDm3aEkPcd63rmJOslgmM7RFJO7HIGfStYGIfrh6FI+/xg2EJfZpbUg7LvrHv67Rp7KbfT70I1H2FBTcACFusIIMuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFRdkvAT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFRdkvAT"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-823c56765fdso878004b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774387644; x=1774992444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niAhtpZI+pVVAEWcQn/pUL4i4VTELLzB3A35UQDHiAM=;
        b=sFRdkvATsWSsVZzOrDrQo8QpuoZICuoiW/NEOHw2J4NePkzROLL5rmvtogho5nFAme
         xyan45J1a/xo4G6UVNR++P/6RvAyIohAKz7xxHjOXNy291srFQV/MZgytjlgPaIreWXN
         Pw4WdBL+DpmFXZTcxHhW5sCHMlJpzvnD1418Ede+jK6k0RNzEoaCl6pKg98UC/+C0/tr
         bSAkGUxZYjTPi/nP8pPuWM8bWb5sWZRmB34y5uJaKQi7xwO6CJupq58/DtUwnWcepKwZ
         Q+T5lU5FiQi/eBFw9bYDDH3P781B2g9SNA28HcFHEXL3Uqz/6UWeDMRY5y/FP+j+HNcn
         hTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774387644; x=1774992444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niAhtpZI+pVVAEWcQn/pUL4i4VTELLzB3A35UQDHiAM=;
        b=Sd1jFHYgRkhgRmVYPpXPg+ctM6UFg2DBCMxZfk/l8V1GvWZ7q7+oWuoNVZGEqtOfpD
         Ka36WqYXK0Wdd0FOY/l2Jj/0QUV5x1w3WxVU6RNEVYdoAYd2Cv6NutSO9aUXXd+FxvHB
         rbS7L6m0HXp7m+uAUpzC3o0ysJlxLDO59DLVi7/89LTcV5sC6IAlxJOJPofRaEBQJInJ
         /JVwRG+13MqqnbO7Bgb5DTeXRPdWrwn7sq7xEj3lXGK0cZHrJOqZzwnOyiPvKba40wd4
         VwvVUX//qCLZ3ZgGC+jJrOzy2eo6vLeKNLIN0kDPTr8u4n3JyVsCJq4xJcjBlJu8XGDR
         6zpA==
X-Gm-Message-State: AOJu0YxR3fhpgCOjWEfZNCpzBKN8VaqNWQV5zG6Jy2bNh4obwI6DFnBq
	E+QuuyX7xjKOJQSoW7DDgCpM3jqGCzMjGVC92oAUsm4YlT3fDxJeS9X2ndTSZg==
X-Gm-Gg: ATEYQzwM+L+aMhwCGaZnzAiVoo5K1AwIF2mcsXIvSHKQGO3+DGjm2tG5Zv8ZEZ+gGZF
	pSrYILlkaOTqQvaxf1fVxFvypT5d4vq6Mg3J99OKWg2199uFvTVnmX/GTpvWlqYLkWpTxJfvyOt
	oFsmB98HzAItKEwCYgK/ZjW/61sUQxjxk8ZBXbj5lDrS/bCuUHCn+nxE4sJkRvGfA7u8v3ANXok
	xjfaTqfcmqNyzCmHmnj055JTP38Pjj+mpenUj11ganuNWdwNF6Yd38ErWHgiYvER5qMoEC+pCZY
	uqmaRcN+hMmxdSIAXvMBdLCFlRuaKjf0wFlZ1BOkxCHIvZp0McWg+ySkIVEsDc58vhrnmHei7gq
	GnvdN0cZpeNFrwXbyZzb/vldI0CoHGs8A0LG1suK5TjV28tAjAD39Ae/EPNFn8avoy5l7j0oGUV
	4WAu3RcVI1sYWs6mSpLw5OrB7zOyldjOcBKEApI5sgFWGK7fj22qRoZ6T7/r/WxegPRFFS+3iqV
	Lf5XLMxuwc+W7U+h0XnhdpSIcw959njCJi39LAhNqLULYYhE53BpZ9ba9gH3g==
X-Received: by 2002:a05:6a00:9517:b0:821:a7b6:10a3 with SMTP id d2e1a72fcca58-82c6df62cbamr985787b3a.34.1774387643549;
        Tue, 24 Mar 2026 14:27:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa7d8esm13006164b3a.4.2026.03.24.14.27.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 14:27:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fix variable length stack write over spilled pointers
Date: Tue, 24 Mar 2026 14:27:20 -0700
Message-ID: <20260324212721.71245-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Scrub slots if variable-offset stack write goes over spilled pointers.
Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
and valid program is rejected by check_stack_read_fixed_off()
with obscure "invalid size of register fill" message.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 70a100dd4d0c..01663bb4ae1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5407,7 +5407,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int min_off, max_off;
-	int i, err;
+	int i, j, err;
 	struct bpf_reg_state *ptr_reg = NULL, *value_reg = NULL;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	bool writing_zero = false;
@@ -5476,7 +5476,16 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			}
 		}
 
-		/* Erase all other spilled pointers. */
+		/*
+		 * Scrub slots if variable-offset stack write goes over spilled pointers.
+		 * Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
+		 * and valid program is rejected by check_stack_read_fixed_off()
+		 * with obscure "invalid size of register fill" message.
+		 */
+		if (is_stack_slot_special(&state->stack[spi])) {
+			for (j = 0; j < BPF_REG_SIZE; j++)
+				scrub_spilled_slot(&state->stack[spi].slot_type[j]);
+		}
 		state->stack[spi].spilled_ptr.type = NOT_INIT;
 
 		/* Update the slot type. */
-- 
2.52.0

