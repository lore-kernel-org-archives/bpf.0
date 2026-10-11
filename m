Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260443CF963
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699725; cv=none; b=R3OePB9Bq6J4go+Uhten4vowSwrKvvxOVheKWF0ytg1sqCTh5piXZzSqrjUptdbul6I+Wqi9DbL1WYXDcc7hyaXrQIIqZ/LeTEty5VzPf5Y5q5WJqWvlQAwrjjm2owDmr4Y/A39uWuiPc0xqn1UWo7eqbA2PGZxePlwoMEOLjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699725; c=relaxed/simple;
	bh=wT9KfUxDTOAu89c4sxAb8wXWXUXJ/Df7bwfvcjApo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdjmv3hnstW0cx3NGrlzdfvSSHsfi36BA1qhA2e4EzONm8ESM2VFtU9GNkGXplIZmUJ83KpMeAMRwpfMEOy7fWTeNa736cZSeOJOY5vklo3il8XEu3tZAn/QFkPXTADsuyt+uznz3fw6voag0q7/ibFcbOOSR+9+SHJJmRWo/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+6cGRGE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+6cGRGE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-878b44611ffso581974b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699723; x=1792304523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O77XLMAdbvfeLp1j1TgVELADlqP4W7JqNL9jlyw258M=;
        b=b+6cGRGEK+GNMjM9Rd5qgfE3Q4Z1DDvJuH4dTYiHL78sdFTuhXJdQ9GHHm1w4czHpe
         ki2RtQRENW8amyBgoS3+shkteQTGdrRg6rl6y1x4rY4Kc20F6k0FSlJRa6Q9XxYi1beu
         tpVpRr/Y0XajQSPEvSXmK2jhFa9EGX6mcnSRgfMBZVMaOS7l+SJ26mNT46CGd2Bq9OZ9
         Y9Jb/VxQPw7cnB51zLz6UUTze8iajw3vR//O3dz1v+mGIkqCbVxT5GpMAeR8Okj5oLxl
         bZKYtDNbRTe4OZ3qJqX7SQU45dWuE1Aqrkll0wPqCVQ7S7erB7FHpKb9kQ9jeB2QpECZ
         YLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699723; x=1792304523;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O77XLMAdbvfeLp1j1TgVELADlqP4W7JqNL9jlyw258M=;
        b=gPtwHxMZMw+izfuKBrOkLKVoXLHoN+Qu2jAi+ibjXGI9uVuTs1R/RmqPI5zoFV8gT7
         4WXFx36b0YQOtW9w+R1vRt6nfJADfrFNDOOvNVhj3QiTO3yMSYrUHTKD7WbhXc12tf8w
         aLLbaX/jvy+d7X4QdaNrotqnu7D85Knllb52pfczx6M3F1ATxbu3kHB08oImIB7x0Ytx
         9A1TtKlWCDXboWj3evyW3zMikB1FaDscxzXqpezsd3NjIw3yWElaIr+UL9PNXe5HD4z9
         BZrBim/vF51fhi7NZMU3TKseLt/ftff3QHdLceuhVzqv2/+TSjYNpG7xptFg92r5U/Wm
         eH0Q==
X-Gm-Message-State: AFq9FYJATE2YwStPT2ZE6LYKZ9heOszSjc/qtf51dqvyb9BqDUtEbplA
	+877huLmaZ+zoIG6MfYCEQu8OUFGfi3RIRv0Vx9VwQDBptwnkWB2E+5vGsRo5Q==
X-Gm-Gg: AYBFou0PzQRKcC5h0lGRAsM7gf+EkZ56HPvWfT2uJWjS+cWAoHcK15G6TTmAvLoNrVK
	7SubI95BBKqF1o5XUzC9/iodyGVubeLHsC+7OJs9Lwf1FILc7747WafdCTHwe+RWBEx3ZgmBp+0
	8JJ45f2S5Aif+LjMJZii+oS/5qAw0rafZZlbEDMe34Tj9iGmYTm6jBGlM+lQ0oh4bkagQiysh4a
	aXC2yIPlYjIqjfhg9f/XJJUuJxrAp0gEsEjKJw5ueptwS6tUnD4wqJCKXc8Uu+rLh+e2zBDE1qI
	Obyd0jKrOfYmYns7CTCi0MGubVrw77KNCTXA/OVHWPsxWtlDwjOL/kx584m7Y67Ix9Fy3bmzXaa
	eZsohZfWO5o8e/VTccBpzGLi690K/+6QiwVBISHi3Y5u5qIMSKJ6NoFUVdeR4Rwkvh0NNHuI5Xj
	uUEB4yyktphQYwvg+r1MgpSFjKhIgMIafComBabudkSa1UNtQElDSoCKCLWLzz3eBom3hHo40zZ
	jmaD9tI/VwqtHTy
X-Received: by 2002:a05:6a20:a124:b0:3de:4b0c:65e4 with SMTP id adf61e73a8af0-3e16bab9c9emr5679039637.4.1791699723524;
        Sat, 10 Oct 2026 23:22:03 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:22:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 9/9] selftests/bpf: BPF_F_ANY_ALIGNMENT for byte_array_size_spanning()
Date: Sat, 10 Oct 2026 23:21:43 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-9-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The test case indexes inside `char bytes[32]` array with unaligned
offset. Use BPF_F_ANY_ALIGNMENT flag to avoid the test rejection for
unrelated reason.

Fixes: e187fac8ac6b ("selftests/bpf: Tests for varying offset access to PTR_TO_BTF_ID")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_btf_array_access.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
index be001cc77f81..9dc2c9a5f8b7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
@@ -114,6 +114,7 @@ int long_array_in_bounds(void *ctx)
  */
 SEC("syscall")
 __failure
+__flag(BPF_F_ANY_ALIGNMENT)
 __msg("invalid variable offset access into struct outer")
 int byte_array_size_spanning(void *ctx)
 {

-- 
2.53.0
