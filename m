Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977E4C9DE7
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542946; cv=none; b=TUosYUGceri0lso05wNE2nMgbYIpAl1VpcBn9U6hZDUoT0KO0GPuB0kHgKHQ6RyJOBCsawQV1bF68FVUoVQ66Vcmcdz0PLqVwU4oHsYG9BvizVA7x4M+Ui+gwyLVB4cWZMEEbPrUbtGJ100vHIOjS05hLtdgKH5YBXJxVXfhIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542946; c=relaxed/simple;
	bh=6S8cH1bqlcq7T/h6mQ30mvcQ9fRXLDjlnKQ7ZgoAcP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVhvqXPXfEadGIO0m0M2vRXXyQ59sIM8LG9gSdZxU6Szjy+qCJhrhzPlTNW+NagdpOR+pvfJ0pamtzYfBZPqqvplYfzRsBApMAGLqZ7ZWEAN2CqVefmQ04H0tqaSKZpWL5o6M95xh9vmw2jeprN+qt3m6w+PfPaep1okJIb6Vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JddyVo7w; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JddyVo7w"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3aacde0cc0fso844861a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542931; x=1792147731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X7PJPzJZGU2AkofMPY9UCrVSthvRHaJqicCwZlnHrEI=;
        b=JddyVo7wsIYzq+Fmi/LI9OD+iksb5H9MIQ35drfvj4+704nFZR2HzRpxHEvN6cSOcL
         7KQWLwPj3Eklzt2Dn2l9iCm0Jkzwx2/7je7DxiERrc/rRYcyipaPK2HdVlUo2V3aYfzS
         0MDVqOHMsAkFcuxT7o5gcwmWiQosYvAulHwB0ncGS8U75r1gy70mQXv9B2zxpYcwpM1T
         XWvVnIyy5j1Tv1oZmRwGq1Ckgc9JYbLaAn8stgjDcVxgU1EOQ6mYL0I0UtlBw2sfQCpj
         uchmnL1UAOXf9C1dYA3zFJdivpB6BIDqHUmBUqgLWjZ6PxOKJBh8zYGRXPp+sNi1LOlh
         k99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542931; x=1792147731;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7PJPzJZGU2AkofMPY9UCrVSthvRHaJqicCwZlnHrEI=;
        b=yAloss9uWxgqEdycvtT0IKMyWp0VkydMrS+dED3dEdCNz52OJhWOAHzbnics8TEX7q
         Fg31Ign4zMmHrehLejxDAuL2aKTMu3gWAGoVeEaitR5b7ey5WKr7nzajiDfwlc29jeAe
         TIpMWCsONF8r0j0R0UF9yVvDy584KpsF/MxtxQ4PuErCua6dJ6WL9ryku7YqNvRRKZtu
         lUBpkSbpPIf/80jmJo2K5JLUtbamBIpH/G2UDxPbE6UZygoz7iHajLgw1IF/gtqgtc7+
         qB/ciBHV8Hgkd8xTbFlG6slzCYWPj4Somyd8zf+zwRSq0I4yXSV4TmjZabPCd8wGDCcg
         tvfA==
X-Gm-Message-State: AFq9FYLjuMWrS6nXfcmPy3DiAerrtMo8HA1H1JJJpByAYCPAxdrd7WER
	HtMeYgOXmUIsfXglzX3ME2ljb8obIiqSqEJw4b322O3L4JO6HhC6ETm9k2rW9VoR
X-Gm-Gg: AYBFou3PQH4EZ6g27GKXKQ4uSkLBE8iwq8fOXwreBhcxqpJuhHzHKYiB2c/k0exNR1O
	RSW/FNS2zq5qvF63T0Ew34VBcrPka+2ZsCTl2yq+Owy4l3MCPaJRIgxsFqZS+wPv9skIPuTGZqq
	DrwW15VjyXNzyf0HODWwDdO62Krao/4xdHV+wbSveFCTRo4DSxTECj8AwUZZyaXOk7/VMNjgInL
	SQrl4ik6o2gcm2P5PviOksW0LJgrF63CpSdQtqFEjKLkbF5aSyjWs7b+/5i6+DPGxScXyoellP9
	uQfS8mceiiavDKM4gWHxg1eTfPTZ2QU4hNI59FtZQ9mgaAU6+c+siJ3o6e8g3vUZzS0qs18HzOc
	OZqhUZRkxiHHZ8G46rJdP2nAEMkW+S55kAsHZSLnokxHgppvrJibm0noAad+oDboU53HildsOOf
	JCNCErHkl+gyLjSaFaWGZT+ScGm3czdQTQ8Sm6J/hg7/8Lwb1awFUgQg0K/B54KReaorZEcHh0A
	pE9zm5Rh0EFWm8=
X-Received: by 2002:a17:90b:3d81:b0:3a8:5f61:1bd4 with SMTP id 98e67ed59e1d1-3ab3ab5cfa5mr1224793a91.51.1791542931466;
        Fri, 09 Oct 2026 03:48:51 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 43/51] selftests/bpf: tests for map special cases in bpf_helper_stack_access_bytes()
Date: Fri,  9 Oct 2026 03:48:01 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-43-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for helper arguments whose access size or read/write effects
depend on the map:

- helper_map_output_known_size checks that for a known map access
  MEM_WRITE | MEM_UNINIT produces a must_write mark.
- helper_map_output_merged_sizes checks that when maps with different
  value sizes merge, MEM_WRITE | MEM_UNINIT produces use and may_def
  marks over the maximum value size, without a def mark.
- helper_bloom_peek_input checks that for bpf_map_peek_elem()
  on a bloom filter the buffer is treated as an input.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index ae4c5062cfa6..0fbc43a5d4f4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -3262,3 +3262,79 @@ __naked void helper_output_unknown_size(void)
 	:: __imm(bpf_get_prandom_u32), __imm(bpf_probe_read_kernel)
 	: __clobber_all);
 }
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1);
+	__type(value, __u64);
+} queue_8b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1);
+	__type(value, __u64[2]);
+} queue_16b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+	__uint(max_entries, 16);
+	__type(value, __u64);
+} bloom_8b SEC(".maps");
+
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_map_pop_elem{{.*}}; def: fp0-16")
+__naked void helper_map_output_known_size(void)
+{
+	asm volatile (
+	"r1 = %[queue_8b] ll;"
+	"r2 = r10;"
+	"r2 += -16;"
+	"call %[bpf_map_pop_elem];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(queue_8b), __imm(bpf_map_pop_elem)
+	: __clobber_all);
+}
+
+/* The maximum map value size is not a guaranteed output extent. */
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_map_pop_elem{{.*}}; use: fp0-16 fp0-24 may_def: fp0-16 fp0-24{{$}}")
+__naked void helper_map_output_merged_sizes(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 16) = 0;"
+	"*(u64 *)(r10 - 24) = 0;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = %[queue_8b] ll;"
+	"if r0 == 0 goto 1f;"
+	"r1 = %[queue_16b] ll;"
+"1:"
+	"r2 = r10;"
+	"r2 += -24;"
+	"call %[bpf_map_pop_elem];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(queue_8b), __imm_addr(queue_16b),
+	   __imm(bpf_get_prandom_u32), __imm(bpf_map_pop_elem)
+	: __clobber_all);
+}
+
+/* Bloom-filter peek treats buffer as an input despite the helper's output annotation. */
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_map_peek_elem{{.*}}; use: fp0-8{{$}}")
+__naked void helper_bloom_peek_input(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = %[bloom_8b] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_peek_elem];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(bloom_8b), __imm(bpf_map_peek_elem)
+	: __clobber_all);
+}

-- 
2.53.0
