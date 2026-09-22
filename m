Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF8576ED4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097644; cv=none; b=daj14QcSgCDAyuS4bHFy/TN8Qz4H8TzzMtMstkJRptJTsK8ss0qmqIwKGfnkhs2o3pjh9w8H5OJFX9yRAH3+e6fA7Bk8JFG0bWT0kQP2p2D3qKkt5MV0IZ/HrIMIIQWinSCaEY5sWNJILXHwhHHy+L9pa0P4kU0848c6Jd0Ckx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097644; c=relaxed/simple;
	bh=uIHbOgEAu0soLHFO7ir1S6J+OWyGMvw/JIBrZCIRTxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB2Wo/soq4+Kvnrrr4Y7JMJnEdWc3xa+bzPx+RaMuCUYRGMs780VPFGxqGNCeeHmJVsDHuVmmPohtpebXy+9QilUv0+um/SLmCs6UXgWqTP1JRhFRSqL5niMsB/5qTgqk38DGpaL/hC+Sz7khH9ZlOkzKOsnGVRTr9X5tUGiAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=wjlzjFRz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="wjlzjFRz"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so144309a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097643; x=1790702443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLHDPq2S52oFpXVCC+/Yu8ajK87ioGIQWdml46+Frp0=;
        b=wjlzjFRzJBeAaf7Hawk2lBbj18BmuhvUXDlk3hf0YWc9kqPYJdO9rz1eANpIc/iOy5
         XQMpECtNvQeWjpqOerRICbn1jmQ+t+f+JsbnE/p0fzI9MGcXqwfUyMgcfBODF3pnNSlv
         cGZtikjI0m9gx8+yw2J0IkzLwApKImY/iPm64v//SHQSfUt1oQrL1R79Kxhz/dOpD5cM
         YMogRUcLRCHPNHg4ksRjrud+ynuo8fw/Bm9al5o31S0W7OxThfa+JjLrSlfwuS+63Com
         KFlDkugdPNlsLzmeLgAr15TOugWgL1CCUPqpNn4Holi3KB9HSF31RKBkYwrGD/y73K7k
         V4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097643; x=1790702443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLHDPq2S52oFpXVCC+/Yu8ajK87ioGIQWdml46+Frp0=;
        b=199yHUJ5+v/QbLoL1CbbRZ1t7riE1/9bNCJ413UKe5yFRHGdNrC5VRDJTyPLagLgLE
         aH3AJJB99UYUmKjd9oi6p7SlN5z0goQ1mtHdxpfpfJiauCFawgdcg/N2G1OCoAdWJmXo
         17CNmHc/f+3jiCnd5TvCwvXC3WZ42ft79m9OTmPHqZzki0EPSNTYOR2kTKBuMoDY24Ek
         wDAgqg24FruLXUrkHL2tmp/3szAAl33U20ISkeQVu131ZpRrSjSawRuIftINBGlOoJN4
         skfVwO5gzbI4Tr60JwATSiZM63f4Jo+1i9EuUq6/uFoV/gXP/g40/3XAyxm4RR1Ws2Fl
         CpMg==
X-Gm-Message-State: AFuF++k8OPRbFhpkglBUjcxcj/e2Iu4lVkrfosM92QT768OHYMycs6JL
	qYYj9XawU/sG2wwL5jPRZy8KrS8+tVpslGMkyKG3fIKjNQblRymXbnnHpFDQMvkEchQIatOGy6+
	tDw7l
X-Gm-Gg: AYBFou1cunpQu45NPsoVbxRlcFaiCrVx0cfvydOpJL529mXYH4MZyzCbCUUpycSR5Jv
	MCKiESmX5AxJlXBWIY5eQPJZ3RCn3VgYgIhBCpxIM/eMfxyE8W4sf7T80WsdfDOXG6FG/BBkXb5
	fNHVf9ZOAmcrnrhrjjWmvw0AOYdawh7kqrpWDV6cB6OcvjBakb4BsrvMP98UhdY+091eAU8bG07
	iUDGpOKKYjCq7gPszGry+pJg+F6P6V9mIiUxf8FVKRlxXduaBhkeLQX5mo0Ub46wx7qJ2fFngyz
	xB9JxNw0V5S1k7aIDWOSECfJJqt/39Dg9/4YDYjU4pdezJbqqeCDA59DB7Ll43oVUsowCbjtTOV
	uXpgwgEfs1ixqgB/mNMPqhFwl9eMkBqd1B7kDv8MuSiwuXllHDXjL2Go8RU0NMiGWBnWIpXAKt2
	kmc+wl+1jUa8iJTrtoo45PG2uZd8mbXAtcuXePKkXu0J0m3NKCvi+3POeUyYUmii+6GgZPB4ln6
	WB9A3dUSWkH5DshUANI3KG/NIGMAwc6t0PD+/0HSQ==
X-Received: by 2002:a17:90b:3b4b:b0:39e:6a7e:ee1a with SMTP id 98e67ed59e1d1-3a07e654a03mr126538a91.38.1790097642576;
        Tue, 22 Sep 2026 10:20:42 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:42 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf v2 03/11] bpf: Fix bpf_sock context code generation
Date: Tue, 22 Sep 2026 17:20:20 +0000
Message-ID: <20260922172028.6269-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the ctx access code reads the rx_queue_mapping
field with either a 4-byte or 2-byte load. The rest of the bits
in the register are marked known zero by the verifier. However,
the emitted ctx access code places in the register on certain
the special value (-1) using BPF_MOV_IMM64, which gets sign-extended
to turn on all the bits in the register. By shifting this value right,
the program ends up with a value at runtime above what the verifier
assumes is possible.

Fix this by ensuring the read value is as wide as the assumed size.
Use MOV32 instructions instead of MOV64 instructions to keep
the upper bits zero as assumed by the verifier. Also properly report
the size of the destination variable (the bpf_sock field, 4 bytes) instead
of the source (the socket field, 2 bytes).

Fixes: c3c16f2ea6d2 ("bpf: Add rx_queue_mapping to bpf_sock")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 net/core/filter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5feb99884..eb0d33fb4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10577,11 +10577,12 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				       target_size));
 		*insn++ = BPF_JMP_IMM(BPF_JNE, si->dst_reg, NO_QUEUE_MAPPING,
 				      1);
-		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
 #else
-		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
-		*target_size = 2;
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
 #endif
+		*target_size = sizeof_field(struct bpf_sock, rx_queue_mapping);
+
 		break;
 	}
 
-- 
2.54.0

