Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6B3A6B6A
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854588; cv=none; b=mYkpg3kQEvFNYM1TYUWtgrNBltuN4KgeXTyv99/aJvfk4GSIE3en/Z6t54asEuVcp2wxJsCSwOg+bjK7csq6FhQQjTFdkmCHHaSjsq70Hxgw+gYgOPjAN9QmmbChtUCxgzdesU2vdb0cAAu/AX5Q3STcoPCWqNhHJR5YeNMB4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854588; c=relaxed/simple;
	bh=6fkvZ1NFE4H64WA2vDPjJAWZschxUSC2Df+MOA8TzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsupdR2gNh+XzwfnG1CbauPJcLwupXRkHohss5A4EJRUFpjv8DzZbuDELrGTCva9fx4iT7EHbkJFmPMjkvIIxgMHJ0w6Lj2Mu76iifzcu50aoihr81O/KcNpVgSRzLEaxcbcDY6ybdUPpRkCFN9ZR1umoA2+ibYfdwaAjQESOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plf8Poj+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plf8Poj+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82a655cfab5so2382355b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854587; x=1776459387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgRdlb5kd8tbRib+nPOPFDYEtcnvdpIQv8Ho1uBWLLg=;
        b=Plf8Poj+iCAr61GDFfq+SSnTnq0ADeJo6B73Q7lvB8aCS5DiE96COVlxm0SneyAi+v
         SVurVQ/Ht1aCYvrreIE18nCcCb62ps1Th0kZveOgSxpq+bPXwNo8Bar9cpTVsZiQpE+a
         7osOVk62fPKDbMDjqOb2iLL/7aLh4j3O8FHvbbP/xlO+0g83bgE0ys6rekPvIYRi3UuT
         FlbjJToRCrrWMH+02JixCwyu2MQOaS/crAG2weulgrgLG+zcfp2N4wPYzjYEyg0mVs6q
         PccVC5dhryFohQ4dOPrSTqFCL4bfQAs2Jcr5RsNDeUfX7aGlV4ql3GK81KHWn1e3JG7b
         YD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854587; x=1776459387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DgRdlb5kd8tbRib+nPOPFDYEtcnvdpIQv8Ho1uBWLLg=;
        b=dy8CBYKTtRxRkpwBe0A7I9coufSbStxFPCu3/nHfoG9+IHEI6M9A1cK+Lgv2lzRaiP
         cuqiBnxver4OXj2DlBqh4AKNuz6oJUOvCMLgS6fro/AZi9JyxHvXOPaXMl3THX9aA7lv
         AQSkSVmaB9Y5AkFjD2Tj5+cYOgT+8ngWGQdl9cI101vYlDBSQ6bCPsy9NagJ370a3ARB
         kAaeYcZAhclewENN+cNXdTmiCrC89sDx3ul8ka/0rpdL1nWPp0skskkO15lnADSk7gvy
         HATE6RFPxc6dQi3dHJQpVav4MPwfvShttNxWzmFm29WJg3AHEIRJ6TaXqcvLDI0Xx34F
         kYBA==
X-Gm-Message-State: AOJu0YwHNsUsqv5cHIkOyRcDbjpzwE8513/eMoB7qoBBiU+77KnR+CRh
	3aRJxIrUE26Qxt6tMWaIusBu7urMSOu1O3VQzQcRtqXknOHKaZG6C96WpZn01Ba9
X-Gm-Gg: AeBDiesVQ6J6RERDIZOiO6YnRpHtw1QNRzJ9CcmlpLPBVhi/V5QFcLunu5YwyQP6a8a
	2SByTvS07kie2pRJy+25jU8RPxRPiU6X+4yzLk3czeyXtdg5hEfgWfhAshJS1ETwH3PncfhYfZd
	lqe2OvANqdN1oj4U/nDr07oavl9iIedRWLHuvW/T/6YmtHW41VB9F+tIiTb6KFoV/g57QGBz0SE
	pc+hhFCDd84CEo4SR7W27xyYYknuJrzvYcHO9CGN23mzo/Q11bqlp5wXiC7TQ5+TDzER++SJ+CR
	wYAC9qOVgr5cNkWrhUJpuNVheZVqR/LI6rZ2bmWDlS7yFNQCJ1mk9hHX0IhlVcX5YmVGmI1976s
	ajTS4isH99Ru4vXDAeCOLftKU6CZt0ACLjTsvBXm5CxNUqDpEIG/K4/VNL65DImD53rD8NUzXRf
	NKhuR6IdVNdoiCThR0QYf5OWAvs2I0uaJvm718pkQtTsTQTBmVnnhv3+7XZT6+xnfE5hk=
X-Received: by 2002:a05:6a00:39a8:b0:829:86a5:d30a with SMTP id d2e1a72fcca58-82f0c2194f6mr4983193b3a.16.1775854586689;
        Fri, 10 Apr 2026 13:56:26 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v4 12/14] selftests/bpf: adjust verifier_log buffers
Date: Fri, 10 Apr 2026 13:56:03 -0700
Message-ID: <20260410-patch-set-v4-12-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The new liveness analysis in liveness.c adds verbose output at
BPF_LOG_LEVEL2, making the verifier log for good_prog exceed the 1024-byte
reference buffer. When the reference is truncated in fixed mode, the
rolling mode captures the actual tail of the full log, which doesn't match
the truncated reference.

The fix is to increase the buffer sizes in the test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier_log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index aaa2854974c0..c01c0114af1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -25,10 +25,10 @@ static bool check_prog_load(int prog_fd, bool expect_err, const char *tag)
 
 static struct {
 	/* strategically placed before others to avoid accidental modification by kernel */
-	char filler[1024];
-	char buf[1024];
+	char filler[16384];
+	char buf[16384];
 	/* strategically placed after buf[] to catch more accidental corruptions */
-	char reference[1024];
+	char reference[16384];
 } logs;
 static const struct bpf_insn *insns;
 static size_t insn_cnt;

-- 
2.53.0
