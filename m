Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78713B7757
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345163; cv=none; b=h8Tz/Y6VOT2ku3GrUiY0lOGtfU2Enm1o90Jt+Bf5KjUlqzyymNrLfhTyTkVFH86eWxcmePz9GWCn2t+XeW0Uo8apoHqxsx9WqGd8bOjdxHT+aoDMWZgvCLavGFEvPVuLv3MA2ciVThPfBhcCs6JkbLCvV296Qw+PECaH31RvABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345163; c=relaxed/simple;
	bh=o8Pe5lEY29vbYQXJQId9J8NjnPLir8Iu/lijWh3rw8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IexQgus3S7cgCMGiqVjjWEN3u4Yvu9YTf1Q5rpFwaFv8kQJbu2iVuszy/voriXGs5TVXiF3E+Tfyhzmh7zu4vSx1hWLrQZ1FMJeFvJ5vO93JzvF5gu4ttq9uSXfY2k/h6VYbIghCuXjVzuoEFYzNWjl+WBBHIO534CYsIkHWXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rX6ItHrX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX6ItHrX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d572f7437so5035463f8f.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345160; x=1776949960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU+0y83TWIH6HB2fWAcA8BpsdL5SuyYgPIuspz45kmY=;
        b=rX6ItHrXB46mp2hCTs3vAXJ5Y834T1LPpQHM5cRqK+P6cFHSJwc7uXoDGSXrGm5t6y
         quTqHvbqct0qxSYIZ39p+fAAalSsLZj0KSnLIEdIKkIUG9O6oqFzVKwdsKFBLC3cW745
         aA1w3O0Z/ZqDHE0wPWUKHG0Q9habFUu4SnaoQlzIzNwCkAEK9dtPWUNvN75e+oIyl8R9
         Ijk8XVpYu/9dzadpCkSVgCkG4T2xnSeQ2PxrhLBrhqRFSxmZ1pSPJPZulVRjNK5JSSsM
         LD9S8xbpqgGcrD8XzCdqDHBApmIzr80IE0Wg/V7I31dfbo6103vHjWfXWft6/9voJwwp
         L30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345160; x=1776949960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU+0y83TWIH6HB2fWAcA8BpsdL5SuyYgPIuspz45kmY=;
        b=dOdM48myXeyJ0Co46JxL85lnvD60ayc0vqZnL9hT8GpQsyEGeF5QUD1lnTLH0ruwa4
         7t3wgvJHcpEqpGUELNhWMmgUaXEgWT6a+MRB1sAdLsSBOF/jGraAsDiQ7Iykeb6WCogN
         FSE/0GBXXIU4EuKf00v3g6gmy9P+7cPGiWcRkvYxLCySIHtVG7KwLQPJZx8BPYwCQbf1
         luEsvnG1/ZxSz8FRc/ITnmLVUy+d5T7DRKgNS9SGjvjsDuwsij8pZa73h2JjT53oYqFw
         x4JzUdkxnqRDjQQDaFPViU4wmGOrI2OzUjGGBR7aoZXXhl20Hc94yTdG6oNdIdShqtyG
         ISGg==
X-Gm-Message-State: AOJu0YwZaVApsiQ+2Vo6DWHGnuA2smArnOF4TIemOznZkwiY9wFOlhhq
	szsdP9EJBS1yhuWPsTgf8Y1nU0H/LuIcWZLTM5PcK3POQd4+/J/is1ZWi4ReanQ/
X-Gm-Gg: AeBDiesHhBKwX5sYUxWaR8+g0/9xD8DwTVALmoxZtdwi+YIOIc7jEaDSVrKg+97q5Z+
	uvtWnSR09jBB+ERvROH4/S+JjUc2sf+PXuK9FoTw0gD5VRz6QTZHreHDEKbpkKieUtz7lKfykp2
	TD9DAxUlE6wCm1TeuKXSWhhZiIqW+FCqfmse/KP2xyKbWGWuN2Q9G6txUjlyRrgAREiGJTOAwQu
	opbgE+52mvdX1XfCVorJz8rpo8+tB/hC93xcYSb5AcIb64T9p2nDQwiyOtomTWwTvB+u8bORIw/
	Mx4eiZuKdx3kmD4JEBCLTS3e84kqiJcTha75KFWB/0fVcYvSUtiYZV1Rt31DxLVyecSW8nSaFDw
	wTJyLB0r9Gphj4ukgyXDjmqQjvKFJkGybBv+LgdK3nu37avkl+Yb/4FFTLxNjEVcyfsM7T6mIjN
	+vNgZGBc/giASEEF4cbY3/tFkR49MxF8iUHFUJq/t0sZSCd7AoE32TxuUBcfJBMmAHULwPwuI64
	zu2qxVojLh0aE44P1NoV7mXA3NqwAPxB4N1zmq3mSfZXJnHV3vqs94RSuGU9GJpy5V6VvuDhdJJ
	QYsEpdfSEskUIxXAGBLDy7LX0tvv8ASwhLvX2a2V/BLViYONP/fHHnknGPO+8Ww=
X-Received: by 2002:adf:f1d0:0:b0:43d:68e7:5f0b with SMTP id ffacd0b85a97d-43d68e75f44mr23449814f8f.8.1776345160216;
        Thu, 16 Apr 2026 06:12:40 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fe1sm13688320f8f.22.2026.04.16.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:12:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:12:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 3/7] selftests/bpf: Fix reg_bounds to prune on
 range violations
Message-ID: <91b8f1840277989ac65d05a9ad5e683a98d3d6ec.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

Since commit b254c6d816e5 ("bpf: Simulate branches to prune based on
range violations"), we use range ill-formedness as a signal to detect
dead branches. That logic was however not reflected in the reg_bounds
selftests and can cause test case failures. For example, the
"(s64)[0xffffffff00000002; 0] (u32)<op> S64_MIN+1" test case currently
fails with:

  19: w0 = w6                  ; R6=scalar(smin=0xffffffff00000002,smax=0)
  20: w0 = w7                  ; R7=0x8000000000000001
  21: if w6 == w7 goto pc+3
  21: R6=scalar(smin=0xffffffff00000002,smax=0) R7=0x8000000000000001
  [...]

  ACTUAL   FALSE1: scalar(u64=[0; U64_MAX],u32=[0; 4294967295],s64=[0xffffffff00000002; 0],s32=[S32_MIN; S32_MAX])
  EXPECTED FALSE1: scalar(u64=[0; U64_MAX],u32=[0; 4294967295],s64=[0xffffffff00000002; 0],s32=[S32_MIN; S32_MAX])
  ACTUAL   FALSE2: scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
  EXPECTED FALSE2: scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
  ACTUAL   TRUE1:  <not found>
  EXPECTED TRUE1:  scalar(u64=[0xffffffff00000002; 0x7fffffffffffffff],u32=[2147483648; 1],s64=[0xffffffff00000002; 0xffffffff00000001],s32=0x1)
  ACTUAL   TRUE2:  <not found>
  EXPECTED TRUE2:  scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)

The verifier is able to prune the true branch, while reg_bounds tries to
refine the true-branch values. This patch fixes it by marking branches
as invalid in reg_bounds if their ranges are ill-formed.

Fixes: b254c6d816e5 ("bpf: Simulate branches to prune based on range violations")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 71f5240cc5b7..c0b3a357a0f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -761,6 +761,16 @@ static void print_refinement(enum num_t s_t, struct range src,
 	print_range(d_t, new, "\n");
 }
 
+static bool is_valid_reg(struct reg_state *x)
+{
+	enum num_t t;
+
+	for (t = first_t; t <= last_t; t++)
+		if (!is_valid_range(t, x->r[t]))
+			return false;
+	return true;
+}
+
 static void reg_state_refine(struct reg_state *r, enum num_t t, struct range x, const char *ctx)
 {
 	enum num_t d_t, s_t;
@@ -792,6 +802,9 @@ static void reg_state_refine(struct reg_state *r, enum num_t t, struct range x,
 		}
 	}
 
+	if (!is_valid_reg(r))
+		return;
+
 	/* keep refining until we converge */
 	if (keep_going) {
 		keep_going = false;
@@ -837,6 +850,8 @@ static void reg_state_cond(enum num_t t, struct reg_state *x, struct reg_state *
 		z2 = y->r[t];
 
 		range_cond(t, z1, z2, op, &z1, &z2);
+		if (!is_valid_range(t, z1) || !is_valid_range(t, z2))
+			return;
 
 		if (newx) {
 			snprintf(buf, sizeof(buf), "%s R1", ctx);
@@ -1401,12 +1416,14 @@ static void sim_case(enum num_t init_t, enum num_t cond_t,
 	fr1->valid = fr2->valid = false;
 	tr1->valid = tr2->valid = false;
 	if (*branch_taken != 1) { /* FALSE is possible */
-		fr1->valid = fr2->valid = true;
 		reg_state_cond(cond_t, fr1, fr2, rev_op, fr1, fr2, "FALSE");
+		if (is_valid_reg(fr1) && is_valid_reg(fr2))
+			fr1->valid = fr2->valid = true;
 	}
 	if (*branch_taken != 0) { /* TRUE is possible */
-		tr1->valid = tr2->valid = true;
 		reg_state_cond(cond_t, tr1, tr2, op, tr1, tr2, "TRUE");
+		if (is_valid_reg(tr1) && is_valid_reg(tr2))
+			tr1->valid = tr2->valid = true;
 	}
 	if (env.verbosity >= VERBOSE_VERY) {
 		printf("STEP3 (%s) FALSE R1:", t_str(cond_t)); print_reg_state(fr1, "\n");
-- 
2.43.0

