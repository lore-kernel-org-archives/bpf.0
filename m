Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E42DF134
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424723; cv=none; b=E6VJMPBSdmvHJxncuaOCnULIPnz9l2gPu2f/PeBqwf8vbspX4HGOQpWVprTE8VjUA2J+wktZuryKUpHcaA+r8n7fNOesi81mQ7PsnUR0TBwqnGJeYBKx8epbTrHzo8y9ScR+3wi5AU1kKUilsJW4wKmXrDEw7Ur6yYWwwNaFReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424723; c=relaxed/simple;
	bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1F/bRAcYJsG2ASKmUJngTE+js12+s0Vlj/pzq1xN8cQ35ngyJ2T26eAJcvuA1FeeAntBavDRyI75WPiLSqrhBLFXnfFOg2pCdqiyzuf7Mpvu0CvhjKt+KzwN9lJJmIWUTXockbXWedvj8oGL8RNng8pN0gQF5+nSUFYkMBqpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOa7Yyso; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOa7Yyso"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so7070015e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424720; x=1790029520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=QOa7YysoquH925+F7SJWfF2f7F0YEMRVvVbcLIRkoUqPPOILz/RdVUhgwqLp9q7UCz
         lPZ4pcZMs7PUfRiTi6L4GdbL987YfqEh4IPFU7ccX7f9cP2HpWOCLWgJ4a1lyaOsOJ2n
         eeMcdxBSZlOKLBqURecMwGf/o30rJJGnkFxkXbcX0QozanRKZowcK5q/sMYAA38pBR2v
         KGRYsmvvfZYG3XcK9YgP8KCjf15Ws3A+S54zJNzfmyc6fj4QeBR6FmWM9YGsbHwoCls/
         0/HQ/V4fLh2N+BfdecsbbBJnuwnpQrGpMVeYv0MyLSNgxFBn+V1BzBebYbI70WPE9yym
         Gs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424720; x=1790029520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=XJKy7omgfv0XIuFFfStNIJtEOtYY41toHXkF6G53PDl41ctiRXjm0zjxLa+w4LyqfS
         LM4wOUTJvtJD/g6D3ZbI3Cvl7HktN070VA1UKe26jte/zYPJH2O3hdOVya4Ftco2EVYQ
         78tGwSx7KlaCYaBAq/fiVv0f/K8l5QWPlKZRfkm/btNYgyxO3aDekW4/oaF/9Z0gwS6f
         wyhNnW03vB5rx1G36LvXIUbPA3ZpRc5JTGbV9DdMPmQH5Jp8qCfswRJxZYJEzxz9osEL
         nfL/Q9VFSQ56ewubMx0buLGWkvzluF70EwFFlKSzyftGmmbdiFZJrJYgu9YOdqsrLh+D
         tuZw==
X-Gm-Message-State: AFuF++ks5U0nfN2zWykCP6h0LWRHy7R9AQFzrCNTbIV123NoygdblRfL
	q8Kmj/YsxK1YIcT3eCKIOo9vkVOU5K2SRnxHEoGyNdyiq3FO4csDdt7rUedtBCv19tM=
X-Gm-Gg: AYBFou19nmoKf/JluVHB8ZvZsMlID+D5Cs7BOJsmogCnsLJzHabfA+6wIP6Pe8bvsjG
	QqAh1SUjuUsrwk5eE0YT6yLCl2adMBx2r+EPlncEvr0NqcMrLsgOh8rgH1c52pce/oTg5IDtbYH
	aTadTcYxz5JrbR5RFyDmeYuUyEfSXXymK7dTM/yxpndhqiGIcocFumCrMr2BSLiwFW+ltfJ7oLh
	U+PDGTxxPcqEQ+X6wYKMgh5Kypgu7UE+HfjVudD8KPUVqVZvgTbApt/t91mciJW8c7c7HAKYY32
	/Recgo4u4zhkVabWe6o1Xv64NoqL7zDckfr1QfKMtGNyndhy2pEpT104lVTPlxMb2rY6O+JziAh
	OTXEpiK5N6b93Epk9GPCFvgCzC4BYOuLQLAjHVh0orjW5uFOpnfaYtlb8ZIIXlMMvyrSwCNI/5C
	NLL9qZIJ5FjpU0RQ4LpbRn9/5qTo4NsX5DYKIdEMB4F47d1eFXTESw71xxjfo3Ly7Mg3AEFV0UM
	Z+qufd2AiUa0/1RfimWCUS2mBHXY0CANOK5tEL/XcDlaMqLeBMkkMs6e/5miSCp+YuewsM0cOmd
	NKN/yJLpMwJAK5wVtOCP1QB43Q5Uq4XRTz+jSfb3VwlifkLnjQ==
X-Received: by 2002:a05:600c:3487:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49e7a66af92mr125399975e9.9.1789424719947;
        Mon, 14 Sep 2026 15:25:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea60sm29487361f8f.17.2026.09.14.15.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:19 -0700 (PDT)
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
Subject: [PATCH bpf v4 03/11] selftests/bpf: Test packet pointer class displacement pruning
Date: Tue, 15 Sep 2026 00:25:00 +0200
Message-ID: <20260914222514.1635018-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=memxor@gmail.com; h=from:subject; bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFiW7bzTc/WBMrP/Xec3AtTS4x4C/hVmEKP+muJ8Off CRsb2FHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJvJQhOGfYvPv1dVyB6IiIpec 9vjBe9r1Zcz3tPiXm/6wPJry+29bDSPDzx/NbHkRr+cJL/66fqOb5+fd6W9jvG53aC6v7+S4wp7 CBgA=
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

