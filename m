Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAD4A64E6
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687952; cv=none; b=lNcrMbzdObQ6e8hlDVtgT7xNb070TW9cQu0yXnyogUkX4x2lGrsqB+w2+S0pZdItn0Au/w8I9+iN/yfVVBf9LX+PEAAraXyobk/ZmwO2vvbQBlSHA6xOURJerOLra/b5oHXL/QgMQpB7LCwmJmWsqVl/arOB/eZfOUOMiIqoZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687952; c=relaxed/simple;
	bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLatrsSjxRbChlF9r2vhX/PtUiDOnYpDJslig0AxpdGThlZzTBek0O7X6sbqCofqFLjBeJ6pyeZuC58m0zfSsgUT74CGXeWEbK0KcCWMUSAQ+cTTJvuKtvcRFoOWAaWIu05mhHK5ApSH2WU7FXAci9N9+Vi6jMOQKs5WkAhCoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjXJ66F4; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjXJ66F4"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-485ac0c75b9so45360f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687949; x=1790292749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=VjXJ66F4scAMp6JMOCYzaj10Uw4vmBVKXOTcAfEe+rQZgSIJFR3qPZW2VC0bHlfyoH
         7APxRS3dioDQhqf96Ftz2anLfwYjsxHdIcm7YdLrx2R+Kpm4ChfVmUekK/VxEWZUrJMm
         e3wPcnabO1UjFM5Hxllt8M3Z10VBHSWyNj/V0E2fAqXoAq/4cyo9bm1zGKaLnEU//4nc
         lHgLQ0TCl9PKtFyz0w1x6qgUCpYU15pn26DJe3j7pqNAhNmySzaDCAlvp/7N33D8wXkF
         +0+lWM6k3XODqT8PQ8JXTCPWQdtcLVVqOmMk3M/h3Revja87c+okSe5qxlVA7XIgpXfN
         gXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687949; x=1790292749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=1CmYmpKdXaGItCCTwXssgcxA6yAK70QZEWxAMozPmB/aXIZAyyMwi8BRXt4BnPIVtg
         xyUmUwA6ywbb+aePGTOJDeQ+0lXcmq5A6AInE8eHTWoa+HajXjraS7jRdkLf/9k9jyqG
         H/VrlSly8i5npMc03sD5YW2/EKySREEuE6nBnpmHTjiXQk0GnhoqI80X3Z87dDaAnN1Q
         hzFgjv10VTbllc6nrUvSK1yjsAIvxtFqxsNSh/TLU7WS5qSkwbZebl81OZqNr3Fh50kv
         /ko9zzHKj9AwxhXOeVTOUs5NF0Q/yHtkrddP2qtHZi+iGZ1e5Q7BEPRaIsjJNq7SWleT
         s8FQ==
X-Gm-Message-State: AFuF++kWWNJJjmErdtBiCjCZJKPUYMN3tXD7haKj89Kyh2ssZv6jGsb/
	PD8eT6y/2KrvaRZFdjW+qRcYAdO7OQIWNXdkG2n8SGtkO9OtZZ0uWZjTelCsrnFK
X-Gm-Gg: AYBFou0li5ijNSMN1uE/j0xMP5s4zAERgXIWuOlis0bAxspqv89i55OyycV5q7OIKjA
	yLkIUwACHxnLYAZQ80c7eD++Bu83pd+JTx6BpI+WcoV8zy+CCh5VtB3ERS9VNkzZgCuuvML6fCE
	E3h88meOUO22HWn+eFJMd0Ktd6vf6p8IrKiTTqts1MJiUcdT9rzz70yHGoVtFH61YKS5x37NxCL
	aQk/dfN4TwKBuF5PlIHztjvHkasVGYtqALRZtSqh2+GwRt4Q4bUEoItz/Dp5QkoQght1QaIDqvp
	i0c+ZZqGqdD7DAIzXHir3/aVtq7KzGczPsVVox/SUSSDhEAvbmURrN+4NtXIKqwNTpRDmF5D/y4
	rQ98xJoZCzTMfXPVBJzbOHw3/oha80k5sx5OaSyv7lxF57zh6cNjLEw1QVC46tGTAwYYV8bgiKO
	7OqoJxtK6IcU3y//7S7KjoshZjEYD99S1N76zp+jZtQXCPJR612mE9peXJWW+SDmYcMAvFpnEvs
	KVpmqybSaoY2Js4c3zp+McEO8p1k0a0dzIxyIj5lpoImRe45GR2AIEJVDEAl6RLWYPt0jmWmx7v
	ubmaoBkRmAZKRzU3hM88abWByCN+6QuFRHGrrYcMHk8/opDF
X-Received: by 2002:a05:6000:26c2:b0:487:b32:9d6f with SMTP id ffacd0b85a97d-4871e21beabmr621681f8f.22.1789687948738;
        Thu, 17 Sep 2026 16:32:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm19117292f8f.20.2026.09.17.16.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v7 03/10] selftests/bpf: Test packet pointer class displacement pruning
Date: Fri, 18 Sep 2026 01:32:11 +0200
Message-ID: <20260917233222.2542500-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=memxor@gmail.com; h=from:subject; bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRUbbzTc/WBMrP/Xec3AtTS4x4C/hVmEKP+muJ8Off CRsb2FHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJrKpkOF/bauQas/WU5df9N/T T27wW/5tBYt0kfJVtT7T9Fv5Ah6xDP8zF2XpzGv5fmNX6NXd/1+wztm/+WTsf8b2U1x1pdpvfr9 jAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add two paths whose packet pointer ranges are individually compatible at
a join but whose members have different relative displacements. The first
path proves an eight-byte access through one member. On the second path,
the same guard only proves that the access starts before data_end.

An affected verifier prunes the second path and accepts the program. With
packet pointer class displacement preserved, it explores that path and
rejects the out-of-bounds access.

Read the unknown offset and branch selector directly from XDP context
fields, and force state checkpoints so the pruning attempt does not
depend on the verifier checkpoint heuristics.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../progs/verifier_xdp_direct_packet_access.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
index 0b86d95a4133..9866bc154194 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
@@ -1719,4 +1719,39 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("XDP pkt regsafe preserves packet pointer class displacement")
+__failure __msg("R2 min value is outside of the allowed memory range")
+__flag(BPF_F_ANY_ALIGNMENT) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void pkt_regsafe_class_displacement(void)
+{
+	asm volatile ("					\
+	r8 = *(u32 *)(r1 + %[xdp_md_data_end]);		\
+	r9 = *(u32 *)(r1 + %[xdp_md_data]);		\
+	r4 = *(u32 *)(r1 + %[xdp_md_rx_queue_index]);	\
+	r4 &= 15;					\
+	r0 = *(u32 *)(r1 + %[xdp_md_ingress_ifindex]);	\
+	if r0 != 0 goto l0_%=;				\
+	r2 = r9;					\
+	r2 += r4;					\
+	r3 = r2;					\
+	r3 += 8;					\
+	goto l1_%=;					\
+l0_%=:	r4 &= 3;					\
+	r4 += 8;					\
+	r2 = r9;					\
+	r2 += r4;					\
+	r3 = r2;					\
+l1_%=:	if r3 > r8 goto l2_%=;				\
+	r0 = *(u64 *)(r2 + 0);				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
+	  __imm_const(xdp_md_rx_queue_index, offsetof(struct xdp_md, rx_queue_index)),
+	  __imm_const(xdp_md_ingress_ifindex, offsetof(struct xdp_md, ingress_ifindex))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

