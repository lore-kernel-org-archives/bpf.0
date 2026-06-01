Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870A3E5EF4
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337273; cv=none; b=Ce38f754OOG5BVWVzWTIGYoXNxF5GVYhBV3Y7YHxy17un5yqMviCdBYqiPDAo5C9X9E8ixcnaM/oNbxmPghHL42mEt1CF6GU5ncAduBDCIvGeh8DhM+XE1obun7oyZ5JN+QRWQY9EUIBcbNqLf6DZr9vmkOai6FTNK1SsNmkmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337273; c=relaxed/simple;
	bh=ka4I5LIiQBnHNvY/EZOZsTEKE+R6lb4aAN9hkXUw03g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly3dAjDlequdz/r39VEl28HaTvTx0AxiF2ZcA8IrnuFOCDUaSmulniZ/uLVE1AlIdSeXheM0zt5VFqQKRs7/lMalzsaGX+alba/mUu4+25JYuha2fiRfzxv9+85VwLp8G0yoIVpP3h6PdgwGTizGa2VN4PMoJJfC6Z887u+bRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDByOU/r; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDByOU/r"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so1521755b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337269; x=1780942069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pSIam+Zmfc1zu7BLy+A4wZtk1mlnebSbErGhuWkvnc=;
        b=PDByOU/r8eGvGbH+E6Nm4MH9GMamN3C5qRP0F+zRH5+quzM/uFAtVuDVRBeQ0Gjlkm
         xHdgJUB07oZYKy3+uEz1rWis52jD8XYiS0t6XrmFTIMzSXx9f3Tz1I7A1UdOGgSNoN2i
         NHZX2ump0LsTi+UM8YSvL0IuOiXijeV2CkIMSe4w6yMY7NVDEtODhlosfIS8iAdTTwAH
         QfsUXijQ/GXkePY5pE/FsDFapjeJgCXVEhSgWxPZKNlC4t9U5/PteWC7WjwQ8R/zsUXf
         7fF0aPC52SFZXpJm8vUV4TgUL61nmX5wfQpoIVYWg0tIw8inDU3JRVOR1amXGWg3ef6t
         zykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337269; x=1780942069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pSIam+Zmfc1zu7BLy+A4wZtk1mlnebSbErGhuWkvnc=;
        b=pMTM2sQtzYGw+oz5oQ6T4T6UqmIDVHTjviRrlpBxzU+FPHboQKrjrmvy1J+bQAcJR8
         Gij7f+xfkyazmLvSTvc4uPhbjZccxwOrkJtqIuWTlCXFVxtRdRXj1LjFFf6TK48REJ6V
         /tbHcwg4VqiLJ917Hgc03mhEI+E4CZAVbIZ8SvfnaMeFKQSj7umvHyCLeEYmNUGTij2K
         KKUdivivQqrDW5Ox9tVMJ32NCBaIv8sJr2jx1vw2njkcCwvSjI7LFQPs2xFIHg++EY7N
         MpqoyLiPLvT5JAddODKiV54M4F+1S2+QlyL6dI/Ly9R8tFbGetsIY/SbQIqi+IRSEXv/
         fslg==
X-Gm-Message-State: AOJu0YyEf7cO008WVzbc87x59/jdP0DECHRLYdSUKcxjTr2W6DrmPV47
	gSdARX1vjs1N/iSP1FAYrwxL7kmbDGg0t4lpXbTM1YkvgqAFkcPQYRsRXGUIS5xBveY=
X-Gm-Gg: Acq92OEkB+H3EmMddYQUFQDbVuxNQ/QifWHQnocA3Cu3gp/U6fpvZv8V1+tgo14FEk3
	LLwC76KTJcJvoGxp/ybeIB+bK4lxBSSS5s3kEl2Eq2wKWO2zLNLF+aW6sINzQAKPv4DHv8r9mXU
	edZMzUKm5rHfdpdLxWHt37GRofXIxwMqAgZYTbmXTvFNeLq4t6QRv14XnHiVDA/6FT8kbVjOVDo
	9kcFhrhEzDaZsZgzw3bB2mfKxiqrkqghOa6+cKorWIByRklgl+0huciRM494yOyqGm084E80taM
	NF2zmhateTzee0K93hdoR3ImGAuhEpgBrHJBr+pmUaR1dIUuc3Dyo3Fv6Y8O6CU4Qcutu5YA0iF
	5C8+DSIK5KTuuffXMmzwNB+vaYIskGLYx5lrHX+QLiS/5twiogpQCtayvzCafBVE0+yRVQS73Tg
	JlqtVGi7BJR5cunEmrTOVaNT/Xzcvr91WvVcvktXg3g2E=
X-Received: by 2002:a05:6a00:928c:b0:82c:6683:b866 with SMTP id d2e1a72fcca58-8422572beddmr11155406b3a.4.1780337268885;
        Mon, 01 Jun 2026 11:07:48 -0700 (PDT)
Received: from localhost.localdomain ([212.107.31.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84237a41a3esm7389702b3a.22.2026.06.01.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:07:48 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	tamird@kernel.org
Subject: [RFC PATCH 6.1.y 2/2] bpf: make the verifier tracks the "not equal" for regs
Date: Tue,  2 Jun 2026 02:04:00 +0800
Message-ID: <20260601180400.1381736-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601180400.1381736-1-jt26wzz@gmail.com>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d028f87517d6775dccff4ddbca2740826f9e53f1 ]

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u32 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231219134800.1550388-2-menglong8.dong@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: adapt to 6.1.y reg_set_min_max() layout. The upstream
  change lives in regs_refine_cond_op(); 6.1.y still refines true/false
  branch states in reg_set_min_max(), so apply the not-equal range
  exclusion to BPF_JEQ's false_reg and BPF_JNE's true_reg there. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e029d1..e51f44b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9954,18 +9954,50 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		if (is_jmp32) {
 			__mark_reg32_known(true_reg, val32);
 			true_32off = tnum_subreg(true_reg->var_off);
+			if (false_reg->u32_min_value == val32)
+				false_reg->u32_min_value++;
+			if (false_reg->u32_max_value == val32)
+				false_reg->u32_max_value--;
+			if (false_reg->s32_min_value == sval32)
+				false_reg->s32_min_value++;
+			if (false_reg->s32_max_value == sval32)
+				false_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(true_reg, val);
 			true_64off = true_reg->var_off;
+			if (false_reg->umin_value == val)
+				false_reg->umin_value++;
+			if (false_reg->umax_value == val)
+				false_reg->umax_value--;
+			if (false_reg->smin_value == sval)
+				false_reg->smin_value++;
+			if (false_reg->smax_value == sval)
+				false_reg->smax_value--;
 		}
 		break;
 	case BPF_JNE:
 		if (is_jmp32) {
 			__mark_reg32_known(false_reg, val32);
 			false_32off = tnum_subreg(false_reg->var_off);
+			if (true_reg->u32_min_value == val32)
+				true_reg->u32_min_value++;
+			if (true_reg->u32_max_value == val32)
+				true_reg->u32_max_value--;
+			if (true_reg->s32_min_value == sval32)
+				true_reg->s32_min_value++;
+			if (true_reg->s32_max_value == sval32)
+				true_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(false_reg, val);
 			false_64off = false_reg->var_off;
+			if (true_reg->umin_value == val)
+				true_reg->umin_value++;
+			if (true_reg->umax_value == val)
+				true_reg->umax_value--;
+			if (true_reg->smin_value == sval)
+				true_reg->smin_value++;
+			if (true_reg->smax_value == sval)
+				true_reg->smax_value--;
 		}
 		break;
 	case BPF_JSET:
-- 
2.43.0
