Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C433939A3
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497572; cv=none; b=MUZo7g+v1eYiQV/L5OpwglW6QnbDQH18DHvNPFAGYi2XymAbs0Yd6W1CAgw/4OBcLvZoRQ7sJy9sfhFta8HqS0ZFcSdNXhjlP6Ln44y2OqQa9b+LW3+GSzXkR+tQpPX8EMUey2TzlttTU2uxvu9mFIQujtC2HEQttQrOAytxe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497572; c=relaxed/simple;
	bh=r5trWWADAEYgIZruXQS4j6vIghp/Au4M38USr/27Qhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PTZZYa7ro19zYJZXgvU8xL+Fixho6MDjBSh+GSUleXwhezXNfB9is+5wc3drYJ7w985F3EUXaivmkIsyHqsAW9ciCmcdOVbbha6aVBat/4sx/2TP96qkkTBVJ3TjHSzEtGbYcoV/K8qZd9G0K3lR2tSEJYiDidVAv/ZIrBvQF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBApz54Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBApz54Z"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eee266c6cso5029870f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780497569; x=1781102369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rO597UOV/n14j0OJ0SwzD/CQ08P5uRBLHTvbS6GsC0Q=;
        b=MBApz54ZSUHhHy1FeRMcS5TX0wRYJt51d16jo/p9uE5xYDy9wOX2AnCRSsQzf8LwHt
         D5hElUVtbvCL9hkUnNhWNkOStpH24q60nPIIKM6K8JrqFGibYfKNwcFoM56JyhvgtlDC
         yiVzS/vkzwtfj0yrf7AUv3ZfFEy5JK2hoE18TzvUF/Wshp7NHshvXR0l+J5+pZhykc/z
         mtqBYIPbPN0b72ZkIrhXUfWyDPqW4sAFzYIRC3eIsPWtI44cnlq7c5rS6G3PZCie/qYF
         U0VCm7lAj/358Ot268uHVrQz3ql1haUAsjzxcAlYI39TQOIar56fiETkdtWnHhTGTsrT
         T1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497569; x=1781102369;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO597UOV/n14j0OJ0SwzD/CQ08P5uRBLHTvbS6GsC0Q=;
        b=WuW+tjUrLb0OjniNnZnWCEdEtIr7osNf/3j5WEEZJ7JjgKK5h0jzWtsNa0AL1k4Z6J
         ADDjX0dlqPU7rfS9cTkVnTx3w0ORRzkkT2UoK8urKi2iJCl+DDWlJTYplAY3hkeIXIpb
         lVFO/lANJhLEq+e9xocBuzp8E6eD0sWy3fzjsEQ/GXcg7tKgjYCccNP0hHh9kBwzn/eS
         vX6nS926o15skSeRR+Un15IL0yfedQCWQmi4xP34kkLykFPLOHcb1M3v9B7XsNcseppi
         53cxea4aMAztQTwvY10ie6YA3/PlWzyFMTVybDhevqA+WdcdLqvRFqoLY8JlYNCJEBPn
         QqEg==
X-Gm-Message-State: AOJu0YwLVIEWqiQIZ0THhNhwoSZ6LivL7d/WlTZD/bP9GM/61gW3sqTo
	5b0KnvAPe0nJhmHfnssSXyV0nYm9Zsk11S4HuAWLSVQKtS4n0JToptsY
X-Gm-Gg: Acq92OEGecWKQq8Rx41cQyn/ZiT6oIVY3+ohoTKIUpeaslqpgLP1OvHan6vOZjgPy0f
	T9YxAMcuySiaA2ojgkHb6YRhvhP33uWdo8RsMX2kNaA6iy7YjVCLRvmOZIzwWPXNNt6JscRuGXT
	9X1BgqtLPPsn+ZggqwMPVsZx2+UVmniBBTRONe5H9B9JouFRmD86UO+E8ZJLOuWbjB95y3PBDWz
	3e6TAWv6rfr2EboH51KR/1Xe3wP+jqk++8p9c8wPC6/hP5tJh3YNuTEVkeYYf89zfHTsf+pCk4f
	ze3fEWagrcxseCQb4mrsu7HjdIySLsGba8SC6YN9vzWHFCFFqdoYzVJZEGvGHbH9/rQtzZ4rAbx
	2b/nOk5JFo18JCjRyq4Th/U+Ry0VoWF7WMTpKL86zH9E69bbfsyaoHDPON9UOe7fbpQkWgjALbk
	Tr1n1AY8blsHhAAl3VjS4EjO0=
X-Received: by 2002:a05:6000:2086:b0:460:e00:121b with SMTP id ffacd0b85a97d-460218f8df7mr5572776f8f.15.1780497569086;
        Wed, 03 Jun 2026 07:39:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344148sm8198965f8f.19.2026.06.03.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:39:28 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 03 Jun 2026 07:39:15 -0700
Subject: [PATCH] selftests/bpf: Fix flaky file_reader test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
X-B4-Tracking: v=1; b=H4sIAJI8IGoC/x3MUQqDMBAFwKss79tAGmmEXKUUSepLuyi2bEAE8
 e4F5wBzoNGUDUkOGDdt+l2R5NYJXp+8vul0QhIEH6KPvndVF47GPNHGuuSZrlQ/3PvCWALRCX7
 Gqvt1Pp7n+QeBXK3tYwAAAA==
X-Change-ID: 20260603-file_reader_flake-bf0753be6b2e
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780497567; l=1383;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=1DToXCvpEaXdEgMxHbdzprutpewrEBJy7uUNWLRs5og=;
 b=4BbEZbaO8xXvOsdosi2v/Y1pwqdDOdYAoN94zQ9pA3vbvJWoi1HSJRWU+sxWFXIT9gAAavXrj
 XiZT5wqSp22ArU5thO2shw6w0MlaHfKI/bvFbTwZU6//gcxl/dxBmsY
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

file_reader/on_open_expect_fault test expects page fault
when reading pages from the test harness executable.
It is not guaranteed that those are paged out, even
after madvise(MADV_PAGEOUT).
Relax the condition in the test to succeed with both
0 and -EFAULT returned.

Fixes: 784cdf931543 ("selftests/bpf: add file dynptr tests")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Closes: https://lore.kernel.org/all/ah6g7JSYOWGp2oAG@u94a/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/file_reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 462712ff3b8a..aa2c05cce2b3 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -50,7 +50,7 @@ int on_open_expect_fault(void *c)
 		goto out;
 
 	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, user_buf_sz, 0);
-	if (local_err == -EFAULT) { /* Expect page fault */
+	if (local_err == -EFAULT || local_err == 0) { /* Expect page fault or success */
 		local_err = 0;
 		run_success = 1;
 	}

---
base-commit: 245da8192c073820390f7fa1cc1e834b32119bce
change-id: 20260603-file_reader_flake-bf0753be6b2e

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

