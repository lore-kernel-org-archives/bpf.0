Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC57284B25
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698429; cv=none; b=I+/t0MCkkjkA8dDTdtIEyP16eavclAlposBWHknzwYVc7I87/8OviD1iLhYTYgMEF9XBF+SZcoe8JoJzGyChrWtHtRDXpINRclQVGuY/Yr/PD0K4A0jx8jJSg+SgDc0T+5VNss5+GFjNYTE2oEBFL9UEjk4E13IWKbBnG3WNCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698429; c=relaxed/simple;
	bh=ezdVBMbFveYq/5ecMLtsl8ni92w1Ep0ih832EHDaFN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhXNtGRX7j5RYALC0qfnCeqBzxr0TcyCgej/59aMK4Gh6KQS9xais6ldwPaBTvOCL+a387gg8EKgIb18xqdA7s2z0U1bNuUvHwvkFSqLghLeiZG9pSLdWUNV3dxYBUmsHMTsYOPaurTkcteEFeOB1fTaeXE5MltdlxVEiHwDYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt0BuKDC; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt0BuKDC"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c15414820so142592c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698422; x=1776303222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwpUEz2XNoBMnSjPhVbKS80au6PKgwXigXcy90F9wKY=;
        b=gt0BuKDCsAXbgAZ+YScpJgaF1TPaIkEMAaZLFDTmdYjXcQWCMy+b9ZvH8akdPlm2As
         CBfeDSYa04yqc5b7w8cVaghSWsCKTadl3R6PV+QpTjjz6wB7Bo3OKI1ph5yHTyQB/Hjh
         ylJWu3quo6ByvrCIMcVRZa3/elvrwsK8gfj0XahnEHE7vitl+LIag2uof8qFEd55nEaj
         VdS/mAhHwFoy075Q9CAitWkV7OiR91+Sfsm8QLyHkLUNqE60PE0X5oDbDL9AobbDPfYo
         CGnaxep5v1K4V0TvjQwsi94NxY4IWww1sh5RS4tXQTA9HWsAFDIYyLLiIZ4NJomCwb22
         wj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698422; x=1776303222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwpUEz2XNoBMnSjPhVbKS80au6PKgwXigXcy90F9wKY=;
        b=mUpXmLXWs0s4KGEaNpcRa0WchDUqorEgJzCPbVloeOUozbUcepZuygTUVsi9RGo/W+
         ZRtT2/I+0bO1Y9OetGhPciAIe2eUfsf5YavYIgCpN6oTcOKcvrjOUkEyYW9pW+A9bavl
         /k6qM3kKOvR0zcztLJE8QBmgBGFRi6RaVuPMxVJ19kSNlm6uJeCdX7s6/jIR+V/D9Esq
         Xe8W3MID7IFAbY8yXg8owmT3s06Ef5k9Hrw3XUrkwK6QuDdHa05rmvyDc8mvflXPUHHL
         3NbsUBOTBIagNn0IwC6REFD9MA9Njpf4DfEREG2H2mzwSfMlynHVia9A/kbnNeZNyXwn
         ZW5w==
X-Gm-Message-State: AOJu0YzX0xBJ1igYo8MvlUf/fOWN0Tm2eNyPs3G3spH4u7edQd9hQ0cx
	REhJPCW4ZTQiHaAoq31Ehp0WPVirzg01PfZl+8qMVyOgqGYgmvneXrwhODhF7dag
X-Gm-Gg: AeBDievN+pim9t7NnBcvcmJKtf6OdSLU6t0QRUUaEBnAx3l/f66Y+el6Gkigz7TFQtI
	rMDTckW2vlUrbCgzdjUBGRvttfCf6uYnRiKCq34lpSgS7BPepey7H/sgW4Y9m4QPtmPqjBPOdOP
	/fDUK4slJiqWeSyOJbRJsu5HkugFvZ6wKQd7f+MhOBdSOGiv30ILlpjJpNkKpEHG7H1oMEFk0SV
	DMIl4YeCE++LHRTxGorH1ypLfONdbGWlR0byCwTeJ2Yucnx+kpSeV0KHKaGIEDhx0OFjQGbDIzm
	NrfB3IX4sYWzJ/RTRmA7mmRkxzz5nvxImv/DStx/sf1Q+frgUOsy2rnmbmX4AZ+aQyWUy+7ygID
	I48WrO+iEj7Yb1Dd/ytNtDWh94Wu8ya65J07WVOd3MnU9sLzJjuKTdiNpmL5EM+X/d6YhZyBe4v
	185gTKGXE3JgE5biLNhWF/1clpvwn4RhYLBVT9ugAR3+NRvdwhwUp/mjGw+G4ZNhsPPxqlFfB2G
	SQLwWm+jA8yHg==
X-Received: by 2002:a05:7022:224:b0:119:e569:f875 with SMTP id a92af1059eb24-12c28c35020mr711552c88.18.1775698421916;
        Wed, 08 Apr 2026 18:33:41 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 12/14] selftests/bpf: adjust verifier_log buffers
Date: Wed,  8 Apr 2026 18:33:14 -0700
Message-ID: <20260408-patch-set-v1-12-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
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
index aaa2854974c0a91cbbb9fc13ae0f966de1bcc818..c01c0114af1b7476d27885ce380d90400a4bdc89 100644
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
