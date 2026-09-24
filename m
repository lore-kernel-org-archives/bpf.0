Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB347CA77
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255662; cv=none; b=X47OFJY9l6P9NSW1jKDxac3NbsXyu3faRAr8p6ZYsUxMPpYynDDnUaSs713ORdAZScuk9DL2Z9U2/S3Y8zp7cQIB0LHRdS4pdyjxwfH7NX8ihDZ4flSO9jbMPPyDPLOzFVD7c7r3AA2srh0h4GejLvFJHh4Bp35F/LbLxgWS25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255662; c=relaxed/simple;
	bh=MexQWRdjnJuSp3NcLmQCtT4yiler41bwgERQVeTO/6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjEBowo1iBpPOUCvxOC/zND7uGmNaN/q6o3/JwRTXw9qdzZlmMr7OSwxG3Z/OryEIkfRa079mW2084AVhMvkf2PyiwVeUcPtbvRbIvHdO5QnB+BVcr2HEMzimomJ2aaPit4dQwy8idKMogYRgfzn7eA6ae8+9CRkV0rzPj18NlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAqppfwr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAqppfwr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso15061055e9.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790255659; x=1790860459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AYj3FCXi3Cvi9UA3sTT6TFIXfOoMlewv06G1FePimcI=;
        b=AAqppfwrcaq0QKtHNLzn2kthPIN+0sYNhnbNKJaKANx9N6A7bU/MuG56SHDD8GxXBz
         55MUoAJg8kh9IdyfPWLPX7Uehp6oXo5sScBJv+t4B2SEyhRzmAs2NNMVssgcle6OUGw4
         OXO16TCe/J88HinWbTI2UpZ/ZLa0sPnAxRrFDWBic7/1O00GG1Ujg/avNl6YG+ICsBBP
         SyB+dqaj3h50Mt0qxUuv7YfwegZn9zG5GdmA0RZd+NvwgAbuqD8HMrfwnazOn1cotYd2
         +qf1tJpCFoU4YP/I6E7xpM3IZDNyTAZM002BbqLRn+rD2IanAtggZIOBuFdzbimo/WMN
         XiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255659; x=1790860459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYj3FCXi3Cvi9UA3sTT6TFIXfOoMlewv06G1FePimcI=;
        b=rBLz2YzSOmHvczZnJU3DE2MzyVOHmdtaiEeAcgH22C4NkGPfczwaEGqgM3YF8LKDYu
         rr3lqXaV2vMiGhNPRrSF0CYRwUYpWOz/PlsQN0BoChsmUVpm1Gvbb5CLvF7cBFlnx3F0
         FjWXumEu7u+1hrKfbmiXzScfagzKgCp+29SjVQe6YH3J+RDy4ZrEEDD6WKzGx6me4NpQ
         5V2zc7kwi1gzcvpLWRk5XIWP/xCpiuXzNlz6BsVgyAMaz2wY/YEguijauhN5XUwTAOOW
         vDMvoB+E1xcYWagOvsY4uFtKAYqSJA+/wRKt6+2VXO3AcRtYGRBYGDo0aMWYX3+YT3wg
         kxEQ==
X-Gm-Message-State: AFuF++nDwSqxjwmas4eAI5ZB7IfA9u07iqvaZlIkbho1irkFLVEUbcvo
	jNa3aQhYwlXs9AvpChX60nX/d3jon+11GBXZb5RLhyJhJSfG4xsdJbKmn1Fi
X-Gm-Gg: AYBFou3kM8tMe/hDmPFoQp478c4ZtbrXOD8HDSraWV3pZoT9KElqdHlip84BGih8PDt
	rcWKg7XYIVZgUtDfMOzLHdF5ORKZ8PwuJTdEt2BIsYhprMQuGIZrm+sn0AhwDTqGxrXyfab5qmr
	i3rQMSRj7GunGQdBNdgf6GKCTLPgFlLDkPhzLg+l1gR+P9VLL+vJgWtugHNC8an8huhU1ynoyAv
	QUuhjhqYXWalKOMef+27+ViJFNEaKA7atjrzlcQ8ARvlh+IZgRepgt50Zg4vHd8iuJwoGb3toXV
	H/IkV28ZaXKbEefVkE5IZdy4JTigtEABEPCdNAGixHymX9gknCSxcURoqtkvZFzCoHjVQo/o1cd
	ybIzCeRmUhSCaiidQ2MYEsNeE2lteoxwmuUmH1iaNN7SYpcvevxPY+JXRrhy/I0Dv7sRlUk0fse
	p5indKVJmTfG3CVvZt9lTJ4y33zGuqg19kShuIuaik47xywhUou4dpRnZL33i8oMxpPGQIy+g2D
	Pb7BSsVOx7pI9oK2fzHJuRq1pxZVaFkOC6M64py4Za71Cvww5BL+Yora7Fo6JHXjMv4MBEfsZue
	ycfCiQr1qQ==
X-Received: by 2002:a05:600c:630f:b0:49f:bd3c:bc1f with SMTP id 5b1f17b1804b1-49fe66fd51dmr40235095e9.26.1790255658497;
        Thu, 24 Sep 2026 06:14:18 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c104a6sm123986495e9.0.2026.09.24.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:14:17 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com
Subject: [PATCH 1/2] bpf: Fix uninit read for non-fetch atomics on partially spilled slots
Date: Thu, 24 Sep 2026 15:13:41 +0200
Message-Id: <20260924131342.934290-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_stack_read_fixed_off() skips partial spill checks for non-fetch
atomics; the following prog can be loaded:

0: (b7) r1 = 1                        ; R1=1
1: (63) *(u32 *)(r10 -8) = r1         ; R1=1 R10=fp0 fp-8=????1
2: (db) lock *(u64 *)(r10 -8) += r1   ; R1=1 R10=fp0 fp-8=mmmmmmmm
3: (79) r0 = *(u64 *)(r10 -8)         ; R0=scalar() R10=fp0 fp-8=mmmmmmmm
4: (77) r0 >>= 32                     ; R0=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
5: (95) exit

When test run:
	retval=4294967295

Note fp-8 is ????1 at #1, yet it becomes fp-8=mmmmmmmm after the
non-fetching atomic add at #2; hence the high 32 bits are leaked.

Fix by applying the partial load check; after the patch, the
prog is rejected:

Verification failed: Memory Safety: Uninitialized stack read

Reason:
  This rejected read uses 8 bytes at stack offset -8, but byte 4 in that range is uninitialized on
  this path. Programs loaded with CAP_PERFMON can be allowed to read uninitialized stack bytes, but
  this program is being rejected without that allowance.

At:
  ...
      0 | (b7) r1 = 1
      1 | (63) *(u32 *)(r10 -8) = r1
  >>> 2 | (db) lock *(u64 *)(r10 -8) += r1
      3 | (79) r0 = *(u64 *)(r10 -8)
      4 | (77) r0 >>= 32

This affects CAP_BPF only.

Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
Signed-off-by: Hao Sun <sunhao.th@gmail.com>

---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fec5a1ae6a4d..68859328c564 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4038,11 +4038,11 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				return -EACCES;
 			}
 
-			if (dst_regno < 0)
-				return 0;
-
 			if (size <= spill_size &&
 			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
+				if (dst_regno < 0)
+					return 0;
+
 				if (env->bpf_capable && size == 4 && spill_size == 4 &&
 				    get_reg_width(reg) <= 32)
 					/* Ensure stack slot has an ID to build a relation
@@ -4084,6 +4084,9 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					return -EACCES;
 				}
 
+				if (dst_regno < 0)
+					return 0;
+
 				if (spill_cnt == size &&
 				    tnum_is_const(reg->var_off) && reg->var_off.value == 0) {
 					__mark_reg_const_zero(env, &state->regs[dst_regno]);
-- 
2.34.1

