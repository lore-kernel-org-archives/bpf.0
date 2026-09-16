Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8046EC84
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593705; cv=none; b=SDPgdiJm3IiOOBEPGBaOGF/G/paDqTJmcVRGhEtDzYHe7oI17+K/We5UbNQxmxXFAvUl9dX79IpstKUCm0cwoIk1jDnx+iMuF+ggrzHTLCkZZVQYjPCEGK7DKblxgsn2nbty+XQqySd7pIPOkhkZfpaE7FbfB7vRCVBRlcsqQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593705; c=relaxed/simple;
	bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8SFB9P8C++1ow1KXYSycVDONnmkUeKjYk5jNVf6salWSwp2jqgkL8Y7Jl4ylhC+A6G7u/j2zFHhmACUVurEkw/bw7iMvlP0C6tRBAhbF5YkuBwbNh6FB6dO1Bfb9cJ0xsfLScI+u11mCliISm2fp4ThhOY4CterBd7p5a0izTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6x0cLUs; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6x0cLUs"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so267135e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593669; x=1790198469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=e6x0cLUsSYa1hHq8w0pwbR/7awkUpX0mXWDAX5sWHBT4edgwzGnO0zvA7W6gOyQMcg
         itc7+dLR3TwoB/6EsZ6eL5iRFX9jJZxaFkYTNYqMvxD/1lDKorATnY3jChQc+7zhBPP5
         mo2N6DHQyPSY1NlXiyS9Ep76LW96Olcz4LPPNc7Z1fzJfIXyk+nPv85qxDZDyPeL1HFm
         S6Inu+vmEVmB0t6KzNJlCtuGiUz00/n5i5xWBT9BJlPlOy8iAhQjNIabskkRceF32jhr
         janAHLRQAr5EP1lQL4uSIOgGXB5IdfcJR6HXYFlMOctowuosayLDMpDVEYvTG/vj0bp8
         lsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593669; x=1790198469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=kcqYnq9j09E9bTT1Y76RI2ukXYNmdl5vwBhRw9BZ5dZnPqNAtm3iBumZaXHNBQYahe
         +FOdGttzOxKN9I25ETUXNbZCHeDAyvfC9aETe4/Ui9HTThknI54mnaUoZWMavnhlPCSA
         EsCEnwt+Y19mkn/Db05N8T+zJxpP0jnDogD2tHRwGrtyWHuQlcyvO7qk4CeCtVng2IVd
         7cTBEcD2m3cxgv40jnNDST76uorykS6XhqB9NAisyqwdPI3M3rpG9M9WPc1lTO2Qh5Ti
         aBa4vQiH7J0+gThO2yQ0YPLrd35prHkHFzbKVMpSpTFop50zmBACpA4ZPIz8ZXWVCYcc
         Icew==
X-Gm-Message-State: AFuF++ktANKzESyva/1Z/1l3DHddw6Se7DxHQjGdoFt2eOnbKVqnhD9/
	djBMhI+ietOw29AVlhPZ1KWEaSrxgqTVtEXj2PcSiLFt/3L+45QJILUQkiMCoogw
X-Gm-Gg: AYBFou05IrFndOHNjV5M9ZOxLr1BPOArTHhNa4sDdK8387ZLOKjmIdVH/d563iRDCuX
	HQT0yJD/bDeufNTz3VrjA8xEXqfrcTPXt2PhbhJcFkzXf06n4Nf7zAcVDP2JAf/ezQ4RLnVE9vd
	y9zwYOW7GR5A2n7cmDeYspc+/SZnIX2Iqvu8TIZri/EI//htqQ9wO+uFynEHCzRlI59UGpPvF9k
	9qAlgaMR1UGwTekUPEvjk1PDeEjtI+ljD6OB2YwoP37nMYxHLUb3EpGaGezyTeyTS5srZGUO0W4
	wqeupjSKUdz/Wd63fNgZjP4NYripEtIehbXaT/4M2hjyTGYr2ykLFrQbSbNivuQ/CCKT0Y+M23P
	WJ4r7Fp1H8G1rYdmg3RRArVM9lawyaS+UyNEY338fLUnZCn+s96aG9WShin/3MDc1q5e2j9Ap11
	8GVCCsfeiTGEoSQ5nszp9Pj5C4RzEow2oQTZOJyptxwvhim+KS+b12K4x5J+WwvExjsvlYEEI/g
	SFMKE/01AEmxWyKowUplVy6V1HafmfGy00bLYWq+1Um59tG6aMsr/xp1x+kE8IVg+JH8rr+pt5q
	u8oM8A13UduG4261bLS9iw7qX5CVG7kmHrCwSw==
X-Received: by 2002:a05:600c:8a09:20b0:49f:bc0d:2e9 with SMTP id 5b1f17b1804b1-49fbc0d032dmr53428395e9.0.1789593669219;
        Wed, 16 Sep 2026 14:21:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24034esm23340025e9.15.2026.09.16.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 03/10] selftests/bpf: Test packet pointer class displacement pruning
Date: Wed, 16 Sep 2026 23:20:50 +0200
Message-ID: <20260916212102.597335-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=memxor@gmail.com; h=from:subject; bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h2zbzTc/WBMrP/Xec3AtTS4x4C/hVmEKP+muJ8Off CRsb2FHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJrJzDsNf0YmSJ+7qTzVPXtlg +C/86Hc38c38X+cv03sxO0L3tM9JN4Z/dkE/V94ya9YomD2nMyJGZHPRVttH1+Lb7iXbtn369sy WEwA=
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

