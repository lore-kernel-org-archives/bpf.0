Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FE28469A
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036638; cv=none; b=OLo38CQYaDyfjeG08cHAFgi03kveqLKWMPTZjAYUF+d9Q3F+LtGbtwCLuuClF9qRkZxqOQdYBmcfEGxQHx7os7bOF6sC0vJtTzXtio8Li0c9w6QjALyAlFIDXdgdQ2LXrn7e1U16AbHojwwpE18Z1vEh7XtXGzY+UoMP+P9maCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036638; c=relaxed/simple;
	bh=AeiVKLsCJRmiRaNRMIWhZPM41Svv0XRYbbydxIy8/6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRgcZ621bQWf3kLajc5Zc1KvescXYxfqdlxIK27M8ec1PvP38XbhaxG8RRHrClXNNXBfgMYGqrBEYJZ+ftqcGOBW6C4OpfC0ZYY0oToidrpZN9iuCJM32WKE2vqDSEk2EuzQkVYX8IjtSFT5gSUEBiflIxo3tz0De5pISyYhZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnGbSx3F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnGbSx3F"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483703e4b08so10001855e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036635; x=1772641435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYyuuM1gwHz7Pa17EejJA2IJzX2XF5uixq6EEh0OQsM=;
        b=GnGbSx3Fp9/3PVDmVm5Y7x3ipHkQy/myILbLZGgezrGf2QuCOirUgt/s07dX8hrnBq
         DX6jgVitpM8+gFe/ZcCgX23wlqDHBEF8Rn/V+/Vs0BN3kFiadn72tCHhr9aJ84N21xnV
         NAnV65KPaYTzjdV7V7UBhXixUythdL3MnU6zmuDZMBhrJndXql3Mz/EbGAtPMpIJUNKs
         UZQ0IlhORx7kP+LgGY6c72xJq7Oms7yweFFFHKa16C7K6xkOQkIgksQ1vrgnZY5NWC1O
         DWTv/QPpKDomQG+iNdgiRRGND/Q9nIUoei2A8RZeVOqCHh/xEb/+7tdo8HxRd9aLKqrf
         ZeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036635; x=1772641435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYyuuM1gwHz7Pa17EejJA2IJzX2XF5uixq6EEh0OQsM=;
        b=Z/SHhkuZofco05VDu4EavyWBoSLaSt1ML/hCV3O3GF+zn2XHvpPbdBMQ3ltt5v6Msp
         GhOrDWQ4l5i6G/W6mYmUrGLJ+rmJBsitvz00+l9CJQo76ktqiOb3gEce0/2WTh2vO2Rx
         FM0kP4sdMC7FcoVIrkQJ7z+OSfzp8uS1kCC3eAQFR+gvV4aRcxB62CJqQXPheD6z0ZV3
         1Et8XTmSTrQzlNbcwakIbvAORvTQoioFWY7c1jOrQd01AAj4oJ1f1DxRnTVr8rlhqzMO
         GuwnK5tTuSWhLDry3juhwqti4aDD5u2e/QW5sg0AD8IlONgDB1jIhzZcXI5u70rDJTCh
         5oNw==
X-Gm-Message-State: AOJu0YyzaNKtFDDH1KpqHpvCPosCumTg97hSMYNOKfTnqWoyZfy+kniV
	ZOyckiTDQdwR3yZkSm5PisG3kKlAd4vNdohCOKDIbmlfKZP/zrrRdTDq
X-Gm-Gg: ATEYQzy5QlIcyvEQqK+1dBPYlI/nruQhZDgTary+y1kmBGj+qpZmWitLoplcRSNkQJ8
	TOG/EZqVm4QenucXwYShDzcmwu93mhloauYRCaQT4D2mrjGuHbEsWFdTuM8O98mG2FzwbRl4WHV
	OSQjiIavanBjspykpN81Bg1rzOsE1XFMQQPWhuyub/yzSHEysOrTI0LLG4lArnJcTFK20nqt2HZ
	dFIVTEjNxWjgC5HEbAF6RWDDihJ5CLYfuJeubCN/0xyh6HZuVmTTk9oGKlbXpTI2KWQyAkC84id
	zbkpYVBYxfYTlwPdSiID5wPaMLQI9WnxnMlB9RskMFaLyuZsvK5wruCEIuJmFoHDYf1LM/5sa8R
	a1gRBXr3SUGX3zNk4ZkAIw5mVfBFrp1kQK0/p8DTp4/5vVZ0xl+2FZehqQUe2EG69QWg3e4mfDk
	7TJF1kIEfHNsznd5/g
X-Received: by 2002:a05:600c:8b56:b0:483:7b99:131d with SMTP id 5b1f17b1804b1-483bd75e26emr79096335e9.16.1772036635184;
        Wed, 25 Feb 2026 08:23:55 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm87267625e9.11.2026.02.25.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:23:54 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Feb 2026 08:23:49 -0800
Subject: [PATCH bpf-next v2 1/6] bpf: Reject sleepable raw_tp programs on
 non-faultable tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sleepable_tracepoints-v2-1-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=1073;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=3ug39tIJWf7aUfLIJsKQQtvtZdmXLhfMIGplgErV9SE=;
 b=1zBaEOo9xysnTGwGOr6SwF8rcrDdLIqgPAKdeshtIw03mqvpmoUmZAZzIoukRSYWiK7ccg9Dw
 2XpEJS2FgW1CA7UwKQUFHScsUCqR2wYyV+V6USl7JZ8OGfvP8AXkq+t
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add an attach-time check in bpf_raw_tp_link_attach() to ensure that
sleepable BPF programs can only attach to faultable tracepoints.
Faultable tracepoints (e.g., sys_enter, sys_exit) are guaranteed to
run in a context where sleeping is safe, using rcu_tasks_trace for
protection. Non-faultable tracepoints may run in NMI or other
non-sleepable contexts.

This complements the verifier-side change that allows BPF_TRACE_RAW_TP
programs to be loaded as sleepable.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0378e83b4099..6ddafb1b03fd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4261,6 +4261,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	if (!btp)
 		return -ENOENT;
 
+	if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+		err = -EINVAL;
+		goto out_put_btp;
+	}
+
 	link = kzalloc_obj(*link, GFP_USER);
 	if (!link) {
 		err = -ENOMEM;

-- 
2.47.3

