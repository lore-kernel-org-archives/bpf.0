Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C214BF943
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394945; cv=none; b=m+hTz2uk8Y2OLq7uLjisOC4ViXYqoGmVAxJy/Ix8S04PuDnvZ9JkS8yUV3Ce403HQOmEbInp8804pKeducqrfIoYbEHL0QTp2JYQh0ICk1YJGr7Lfx7cf68SJTxUPx2qZxQ4OlyA/9Tu2K1PsJ0aNYCRldV7Dn2f1gRHMr2IL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394945; c=relaxed/simple;
	bh=ZVEMir1UVtjeqTDd+kQt9OYW8kEe+ToC0TfYjUegh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNYgP33dcw4kUEsLmEIAKKXIqM7NWpHfeuWOGw7JXuC1+sARRO/unXPvAwVpYQFTSgPQdYcT40rUqJI+APVZ+3cJxqLUoJOaMiAIv+FZNRABtBXorWwWya/iceC9shZWAj3l+PMFrq4f7xa8wrL40dzqY0Ask8XOGYKmPJLZgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1UCkofR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1UCkofR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso676879eec.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394942; x=1791999742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHXvTpeToSMwL5+SVT0PZraPoeYCO8NWG7j1aLQ/JCE=;
        b=I1UCkofRjmJtDEMqSrRX0+dJXFFZFv0KBZ80v0jJJF/am07zpBY66FXD+vY2Agex0S
         4mMoy4tsIjEcPsSw6Zf6SRMBtfzSOflAfr5VF07UebFTzeA/jZPljV9DScD4w6aCDLXZ
         Xguu0ZQrdXIRD6n/9WELDGFznN98kt0dvQUSOXXodE3IYo49gsd7JFO0VsOvMEnokRdK
         7on36iJ8omg2aXOSXYrog+UxOo8LwZtwaHySZ7frMmUV2XfLyYTeu4d6Pv1tUynGB64n
         EoWwM5ZB08Gwr5RrHo7QBgPzGJFBIlBGjOhXGTig39tzteTjMTXuyRyPox2pM831Hqyy
         wetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394942; x=1791999742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHXvTpeToSMwL5+SVT0PZraPoeYCO8NWG7j1aLQ/JCE=;
        b=GrGr0Lqh9psEY/1QUB2LNRVHhBjZ3TkqqSQbNppZqSPZ7+wZtB0r0Dtbo/lbA3bUb4
         WEJv7U5jhU/48EbBFPeelGAOJjEjvSh5/I/pDXx+90e9hzIzK+xLQiWdSjp2twOmKdRF
         HoC5gh21zD3MCmLgm8d7U6w3L462q3cWGGpqRbqypm8XOSxMTLNg3G9rE4TytnaMaFGi
         HnRXLHIdJpHqL1WsSYJzdOUkkGHDTwcZDWvjfT7NqCfFlp6O0xF+vG4tAzzV0v0duSpw
         +YNJweowUF+eouF4br+MEJX6sajwXC56qWQ+stlfRVrc9ycO+19m6vT7CB+FnqGRSRs9
         UAhg==
X-Gm-Message-State: AFq9FYLKf6HELVQZQqE3BLVkvGrz4i6jeY8WFOWBtgLie7kYHQ54xjkp
	d+yketVim1RZdu+I+wJ5KNDWK9jO7VBJPu4IfroYnOArffS0BZB4Rp+i
X-Gm-Gg: AYBFou2yRIowd72Vh4xVE16y45c5NCHy3vFIkrGqlAF2LJoFTLK1E2kwPEkHMPXIZDh
	lb5af0LAM4WGB7i3mpC6/wgezeav+HAwzK63bu5TK8Iu63LgYpg+PCgpQRfH0VFX0g/ytfI/0rY
	Sqp/S+jakUGPMYpBxMY8xDaN5wo4/GjCleqjJ9+W6jFPiPzXQsWK07j37YpMnf0yA1bKTt4eECC
	LFqox4lwaLCq98vb68Vl5auCMx7H75USXPl1jc1bzl5ctQ2gb/YRBpPPnbLKXCoQmOvlRTKftqI
	3V8KOuB2udyxA3TkeAaf41M/g7piRNp4wHlu9K9TG0+N2de1lnsv+0HsmZOBpwzJEDEPj1p05DP
	u66vOStmnWwni/gEs+lGgX8DMe6KFc5WQIdmyUx1DWgYqH7aTtZ14EnKuP5t10FXQ0c8v7kcIAf
	wdRv6T/Nq93PfQEiOtj+/ZlEVLLQ85iUZdQWElkEgEIPJleSkE3e8s/ZOGbX7DRifSOYSUmCpry
	Kxef5ikRpdjp3fdhkTAehPuesKaDlgv
X-Received: by 2002:a05:7301:6e9a:b0:351:4d25:861 with SMTP id 5a478bee46e88-3515de80f01mr3202494eec.7.1791394942003;
        Wed, 07 Oct 2026 10:42:22 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aff5dd6sm9124558eec.26.2026.10.07.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:42:21 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Test missing caller stack argument slots
Date: Thu,  8 Oct 2026 01:42:03 +0800
Message-ID: <20261007174203.37071-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007174203.37071-1-bestswngs@gmail.com>
References: <20261007174203.37071-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the path where a static seven-argument subprogram has
unreliable BTF and is called through a bridge with only one initialized
outgoing stack argument. The callee expects two stack arguments, but the
unreliable-BTF path skips check_outgoing_stack_args().

Without the fix, the second r11 load copies an 80-byte bpf_reg_state from
stack_arg_regs[1], past the caller's one-element array. Expect the
verifier to reject that load at offset 16.

The fix also rejects the existing uninitialized-stack-argument test
before the later unreadable-register check. Update that test's expected
diagnostic accordingly.

Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 .../bpf/progs/verifier_stack_arg_order.c      | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index c9fe4857d..23c7515ea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -129,6 +129,16 @@ static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, in
 	);
 }
 
+__noinline __used __naked
+static void subprog_call_bad_ptr_7args(void)
+{
+	asm volatile ("*(u64 *)(r11 - 8) = 0;"
+		"call subprog_bad_ptr_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 SEC("tc")
 __description("stack_arg: read without caller write")
 __failure
@@ -151,7 +161,7 @@ __naked void stack_arg_read_without_write_1(void)
 SEC("tc")
 __description("stack_arg: read with not-initialized caller write")
 __failure
-__msg("R0 !read_ok")
+__msg("invalid read from uninitialized stack arg off 8")
 __btf_func_path("btf__verifier_stack_arg_order.bpf.o")
 __naked void stack_arg_read_without_write_2(void)
 {
@@ -170,6 +180,27 @@ __naked void stack_arg_read_without_write_2(void)
 	);
 }
 
+SEC("tc")
+__description("stack_arg: unreliable callee with too few stack args")
+__failure
+__msg("invalid read from uninitialized stack arg off 16")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_read_with_short_bridge_write(void)
+{
+	asm volatile ("r1 = 0;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"*(u64 *)(r11 - 8) = 0;"
+		"*(u64 *)(r11 - 16) = 0;"
+		"call subprog_bad_ptr_7args;"
+		"call subprog_call_bad_ptr_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 #else
 
 SEC("socket")
-- 
2.55.0

