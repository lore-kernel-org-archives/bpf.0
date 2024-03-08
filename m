Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7E21342
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860106; cv=none; b=Sjd5lISdPOsWKZwMUy3uF9A853hU/ZQerS5/zVfm1uNOv6qDM/f+kaIDgOpqHi/lVq9numVu3b8lGbAmo+STz/RHkM6O34H9RJJkLNEjvlRoL7qBZ0ffcEz4JQA8FjK3EKbe/oLWNX9nss4ukcZwkyf4vnvAiQtiO+vNqiImVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860106; c=relaxed/simple;
	bh=S9sDfSIwZFp6TuxY/d/HaiqfOfARsWKaqoJtVBSEc3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/+jEGq0dQo7S76umjdeLRnPEejh2jbwURcqFhMQf5JNH+ahoZQNda2rMhgjoTsDgqVht2zz6UTaq422HmGVnwSbE+PbglDtcvebPwTivgeGVOzgIUh42j/wctvSom12ReIC+7xOo2D3ka71DQFctJmvKSw1ybOCc4oihAtaLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRhBL7UX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRhBL7UX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e617b39877so1295698b3a.3
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860103; x=1710464903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eol0rLj8ZVaqzxemLtYqGJLGqcrhD/N/8xdUYrW35uM=;
        b=hRhBL7UXB03GPlGDE6V4BIZFoYC4MICmsPj2LKxRsaYIxp4wwViD6DfMlq+s5vLADs
         5sm1+djTxwQKJKchJ45F0bQ4q45zdCxPiytqTFUdQZi5ODgrlpWOZV0vYTCbZf0ZpJ45
         /y0kStWtnoM3nM2F0n8BxiCPujsflaSwlfQI6caE/02QGv3IZ5myZUe7l+9z6+WxmXNj
         78WPw2xKCXFxPJ9kKMOY2KZ+7niC25cceiTuVW6+QszmVqsLUphtXFKBJC8lWX/4PpS9
         dPyz4RvWZ04SPk5QRiLOfnHMPF6WtJ6uy6tJ6H+fTyRDtfram24dm1kLq25MsNxC82Er
         Oltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860103; x=1710464903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eol0rLj8ZVaqzxemLtYqGJLGqcrhD/N/8xdUYrW35uM=;
        b=U/GZ6tVQ2QTzi5VqelU3V1mkt4ExPPFgrCu4ZBIEfUjPhIMMZ5pp2tlpgh+RpkdsTt
         j8KOPFslSL5N7n0o8Q3twjmafjYR+jy7tIQhTHqlVzOthvo5Adqwv5bX39pjN8ku2qbX
         lHwH3sSI3Qv9qMQUFhDr30p3yJwrZD9GcLWBDt9R2nK363YhPTVC7lqxJe+IrenA3PG7
         HrMZZbPrt/IjELTPMgBDM6PA1Tx8fUtWbg6nrcfjmWpTm6VDjtBJ/prVUEsL99YBAMVb
         UWARyKypLixyAVh25+4Ndc681wtUycDtoJzw0HK5rH7MA0SjxsrX+m2XJE8Iw2VCuMaW
         /MOA==
X-Gm-Message-State: AOJu0YyBnzfltCBWbYgEh04vlgMVZoPZ4JhZfk00zLRF179/BDZu3ru1
	+FNMDAuSSvM/ppaQurTaWzJmtl0SLAfbmxAoFYqRRHOdMCNB1rDon7SlyvAC
X-Google-Smtp-Source: AGHT+IEVuK7WXVcuZMt8VNUGYBFGky0WlIL+If2MnPNUNirTnV2pe36+CiCA+QDit7CvlPgNYZps4g==
X-Received: by 2002:a05:6a20:6a1c:b0:1a1:6f1b:90f1 with SMTP id p28-20020a056a206a1c00b001a16f1b90f1mr4702201pzk.1.1709860103430;
        Thu, 07 Mar 2024 17:08:23 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id gu19-20020a056a004e5300b006e6499d9c03sm3914096pfb.197.2024.03.07.17.08.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 02/14] bpf: Disasm support for addr_space_cast instruction.
Date: Thu,  7 Mar 2024 17:08:00 -0800
Message-Id: <20240308010812.89848-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM generates rX = addr_space_cast(rY, dst_addr_space, src_addr_space)
instruction when pointers in non-zero address space are used by the bpf
program. Recognize this insn in uapi and in bpf disassembler.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/disasm.c            | 10 ++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e30d943db8a4..3c42b9f1bada 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1339,6 +1339,10 @@ enum {
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
 
+enum bpf_addr_space_cast {
+	BPF_ADDR_SPACE_CAST = 1,
+};
+
 /* flags for BPF_MAP_UPDATE_ELEM command */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 82b2dbdd048f..bd2e2dd04740 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -166,6 +166,12 @@ static bool is_movsx(const struct bpf_insn *insn)
 	       (insn->off == 8 || insn->off == 16 || insn->off == 32);
 }
 
+static bool is_addr_space_cast(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+		insn->off == BPF_ADDR_SPACE_CAST;
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -184,6 +190,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
+		} else if (is_addr_space_cast(insn)) {
+			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %d, %d)\n",
+				insn->code, insn->dst_reg,
+				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e30d943db8a4..3c42b9f1bada 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1339,6 +1339,10 @@ enum {
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
 
+enum bpf_addr_space_cast {
+	BPF_ADDR_SPACE_CAST = 1,
+};
+
 /* flags for BPF_MAP_UPDATE_ELEM command */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
-- 
2.43.0

