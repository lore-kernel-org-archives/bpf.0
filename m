Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732923890F6
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813381; cv=none; b=JdUL8wxp7ywxNusdMBqOXUWGT+syL93Wq5l6QVUkdJzZ604ngAn8TDkwXGGtrfzAKVTy4g7tnq3BEgEi9372d+raGMvfTT66VC/q4xdIt419x4dzGrztSUnAn43ixVcEhV2bRSzDeCDTuTNlY+JE70fH9BSvHBSjM0nQOi6rLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813381; c=relaxed/simple;
	bh=6fkvZ1NFE4H64WA2vDPjJAWZschxUSC2Df+MOA8TzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDb0V7//2poWRcYvYNngTPslFarFt8R+kfDXu4Dv5qpcZAReXB9FrGZ3vH/oRIUvgIDqaUF8I7Pgo9df/lNE57q7vN5SKeoF5zaQydEBhSn612yJK3E+q7SBFFYyhDk4YjrxNMEQwybx6qtXpXdyuptzpocxuP72wlnVgHNkFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+Ga8ulk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+Ga8ulk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b23fcf90b2so17845695ad.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813380; x=1776418180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgRdlb5kd8tbRib+nPOPFDYEtcnvdpIQv8Ho1uBWLLg=;
        b=f+Ga8ulkE+RerWigRUWNYVAvqRrqm2Wf0aXTriqzRbCT/b5uL3xKoixa8NXy+lr7ns
         0e/GDJ2LgrXS8z6OoRkdrN9Huzq53MfICO0lSP2vTHnQtT9yVdsz+wGTOlXeY1TgM5HW
         vJoCrdRFl1NyRgS5QyjSdHIjDSNYa5E+pCB9Y6a/TPzQ04b0S8iAKtnYu6dbqkR9nE8Z
         Y7he0JwDWjU4TCqodSbk1A5Iksjkszj+aL3y4TWigIt9ZcT+6T3+1v2EWjyAIIYlNMGs
         RkRP5zsR0B4MsvCQXcQUXdcdisqcO/i8ezLrEkWSjXbd7lPWchAvKfMUfpzxVv3z3EUz
         ttUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813380; x=1776418180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DgRdlb5kd8tbRib+nPOPFDYEtcnvdpIQv8Ho1uBWLLg=;
        b=qZDdVARJr7ANeGBJ5aVYD33j9Q114Z0fJ8HMyvbxeOZ/gqY6pz+bA/Eyis3swNwRFY
         ehXdZuAzi5oU6dZQZnUWwLGjZxe3MGrncuXna5R5oEWvgypYriZ6ZkOyW3KtzkdxUSGZ
         C36lwtkdnjqFzRkdHmlHWGhrvSsI+VyYsNb341rIoOmSZTVqs8S84yVsRZmbFdIHQzAP
         isEWh05FgloPUNoCBOiBQsfvz4LfBgiG8z7OIfZ8jVyKD7AuHXA98wOquqaEfOb+IEcm
         BUFZr+IrpU0YXUz/NcwsyUZQaVnJ1VXXQqwaTi/T0h5JSqvZW4q0kV1AwlnruPzYjU/b
         r3sg==
X-Gm-Message-State: AOJu0Ywz/8xnnlKl6gzQv6lzt23insA/5kR2Q+JM1/DZ6HphwQjuJSdC
	wMQ+CV0yu25JwwHrfR9PeYvptXQNSt3CzEimXYMCl56P7yvheSuNToUecLQAFk3g
X-Gm-Gg: AeBDiev0hkxkOKZYiVMW/IWdnPoeWTA7S70CBlR5LxIJqxmmBKejsw8pJat671mL6/w
	3ggI9wqxhK+KHVgz6NkUpuks+b1ffyqauhjt+rzepdVI0Chv2EUZSZEPLXORnt8Jw6YV4yJv+9b
	C5hpNKD5IJ5N9G30k+ZA5CU2VeaS09RLeKVg2ihzkkL7b46BpF1b6FhxmIaRTdYX/eXpzJnS1LT
	u55/7E2sXY2uyedAugvYPtYcetl4Vp41UzlMOsngPU3pZiB8uXOVaxDOazQ5mSeE+zFDfhjbNEA
	kxkk8lKZRmHYfL1ssHEp9pepPPjOcIzzvFkk8sTGe7WyklgHvJuDf1d4LC0FQ83nfs+EmLItTd+
	K1qmc/klWJ9C6GS5dvBbtw7t9cwVR6MyJROOo18TWLYZf0lLTQoOtkI/kApiiSnq5+IkH1a/VXa
	1K6T1A52HId87+6YZ3E1ziEAgvVOzBZfaiM3gHx/OXt6/7IFwMMVduKRSZC3B7gzWuT+4=
X-Received: by 2002:a17:903:2412:b0:2ae:7ed6:46e3 with SMTP id d9443c01a7336-2b2d5a2943emr25310175ad.27.1775813379697;
        Fri, 10 Apr 2026 02:29:39 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 11/13] selftests/bpf: adjust verifier_log buffers
Date: Fri, 10 Apr 2026 02:29:15 -0700
Message-ID: <20260410-patch-set-v3-11-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
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
