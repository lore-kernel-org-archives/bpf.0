Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118517;
	b=JDn87xLKVmkkynk6j8J6edCySTOFKw84r7gxjZhNLSNoh4C2xgX1vyZL4sq8uHE7frDP
	 stK9hGT9yeqntJcMtSJZLPBpjQt8fIQYCnXZSx+zfLykWvn6VjqCOr8BVRhevr2W9c8oO
	 V2gaEoMkUxCqZaDAqXxWTmorX2CqXRmNXgumzsO2ggga7BffZD35ABiQFmv5hA7B4VpeX
	 +T+P054h1dPM8/ZZXKRCanBAzbZMnhYk3j/DMZWACDTbuhsazg1y9TcGaXJ5w05As97nw
	 6cNS5u0u5JM099OS28AHGu2XLrVL1T51SvYb03vFrR6dG60ZdGrV72NzH7z7D9FYTdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ARaY+urqZiq/vDGjaQFRnXEzmf9yD69xj5cO6BFdPmQ=;
	b=s1cyLWg/mKTRwsngzEZ2kSj4NDp1T/cK9JQ5YNRiwph4WdwiAkenqjTl5JLWGvZMqqSV
	 BkbGNCVg0GyCH34beHJu4Y6RTPCrs4a1qYCSXbu4VJsYWN1QImuE2jxzObCMtdkrIXFPy
	 i0uCzaWXZPG+Cd8dDlS8TITR1z/la4G0OEksZkgujPxkPvjLkVPs0mR/FtH79IYTCGmWI
	 5Q4Tvl4er/6GeYbz5/oSY7DJJtmY9nueHh4f04nSL7O8cwEojQT6GXkiZ/xie+z8kMAzU
	 OpWJRg4rey3CSZDAcyTegGaxTyI9kxBSWu8ahjL3jb+FRWIThiFYuG4ACCWi+REfhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=fJXPoQi1;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACB606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFACB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=fJXPoQi1
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso49186b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118516; x=1793723316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARaY+urqZiq/vDGjaQFRnXEzmf9yD69xj5cO6BFdPmQ=;
        b=fJXPoQi1sroeMjkHd3i5g2Nd4W0bKDHM6w205Us5c7jbSX0DpP68rzNIrZeZrunhIh
         d/msBZbQERgoK2moKuUnJtXP1ryfhZGI14zATMGWTbrfacj0pP8PhyM0nr25ptG0mmtW
         bMZD4RuqvEQVJQyWrQIQ1cdcnsOo0RBPeZZNxp0Aa9MW3S+/cqpCg/N/W50r/g4fiZZt
         IP6cLXg4ghGfEAzhG41TE+VR0oO6PRIntPkz0P/uuDi/ebWM/FIdyqVbpy1DcehmbFhd
         mL/iIkwj+/9qAa31PcF1koKKm/o6pRjnKsNfW2+XH/+h/RBXr+8M7kb1fLgBExpga2sL
         wGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118516; x=1793723316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARaY+urqZiq/vDGjaQFRnXEzmf9yD69xj5cO6BFdPmQ=;
        b=goRKWpj+wHKyrcvNRXbORoi9fdK9+jqKwL1I2l2z136Ibig4w0vmulh614BWh5/bb3
         fIgv6IfYgUnRu2Cb2kbgr/sHemMp3z2MCiRXS1T4ViajUJpV7hQOgazC9XI5wa4NEn2q
         eAvduKsYZ9aoOeJd9ygtJ/aI7ZUIouHBNNyxf/aSjwhxfpwXchMzvJhaf6GZ18LTZ9UY
         m0q49vyRXSMP0xlvMJfC20pe3wHCwt8G+e9iDZaQxnMZk8gYVvHnE7Mw7yq1tvve0xAx
         t0e7N+BZLNF+pRWyQHAdLIbl62cah+JWEtslwLzvnM9HxOTbnjQLRLy4/5rK+jvpj4Rq
         +tQg==
X-Gm-Message-State: AFq9FYJIw7tTTXJePUtJ7hBrkbupr3zCm6Cu7yqeHLNoDQMFxWIpd7SU
	7s5W5ODPhuZ/Yj4TUkdZS1oj8DfdRY2lU92iE8iEizAF4Rx17toj0fFmTuAjvBNpiZA7/m9d9MD
	exRzK8w8=
X-Gm-Gg: AYBFou36+hiOH5HkGa7JaDxVUk3NSlq+s/aZEIQZrZEYxHbyRReWAxhnjeUFn+RCvBK
	HNoihGpv8Eb4CX+hp+fHH6d2okmBCI8ey/vFIrEGR8MkJaobPrQifI8WVwYyLadWWGLhpmv8UtU
	8/DmuBwi4GG/yvyefbUEbsu4g+uVimPsHkGLet/TdmXaP+BS3NdnYJ22h3LDn3lRiHyyHcHzqZ+
	J4azjF71hngczvvs9cz5N36igu5pdM0OKVWeF5tNwfxHcK82GzKcVe6HGRF8lSgHXiB53ZmtNyR
	Gqgm8gVqxBF2RfnLudvgAVM321BGPaOg1mtUVOrfqOaQn7EPzoUc9CT9VPDhR+94/BiFL0fEWvi
	+FYtr5H6vOco77wkodcKJ1CQACT4l2evVScNlvXXd2mfLYwXPIrZrfCS9k2OJNxEPAaqL8AGDvy
	dW3f3I3DAhlO60V7Ix6crvZ1YdHiZEi3XeLDSAqKUYj52iU/LPLl3E/xXrv9fZXIFjqgH1M0bHd
	xOzcuJTYfkycIbxVl9ikPimFnUAdFzAklbhwUfWBtDQaqT//Fi4ESm64IGDBqPyi+mSXJEFJJFT
	WxOJMQAnIZQ82H+9wA==
X-Received: by 2002:a05:6a20:ef1b:b0:3e2:6825:beec with SMTP id adf61e73a8af0-3e7bfac2547mr7211296637.19.1793118516047;
        Tue, 27 Oct 2026 09:28:36 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 4/7] bpf: Inline local IRQ kfunc calls during verifier fixup
Date: Tue, 27 Oct 2026 16:28:17 +0000
Message-ID: <20261027162820.10887-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace calls to the core bpf_local_irq_save() and
bpf_local_irq_restore() kfuncs with the corresponding internal IRQ
instruction when the selected JIT advertises support. Encode R1, the
flags-pointer argument register, as the instruction destination.

This runs after the original call has been checked. The existing
process_irq_flag() validation checks the stack flags operand and tracks
its initialization and IRQ-region state, so the fixup does not accept new
operand types or bypass those checks.

Keep calls unchanged for unsupported backends and configurations.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..aff7080b5c85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23372,6 +23372,16 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     insn->imm);
 		return -EFAULT;
 	}
+	if (!desc->offset && bpf_jit_supports_irq_save_restore() &&
+	    (desc->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
+	     desc->func_id == special_kfunc_list[KF_bpf_local_irq_restore])) {
+		int irq_op = desc->func_id == special_kfunc_list[KF_bpf_local_irq_save] ?
+			     BPF_IRQ_SAVE : BPF_IRQ_RESTORE;
+
+		insn_buf[0] = BPF_IRQ_INSN(irq_op, BPF_REG_1);
+		*cnt = 1;
+		return 0;
+	}
 	base_desc_idx = desc - env->prog->aux->kfunc_tab->descs;
 
 	near_call = !bpf_jit_supports_far_kfunc_call();
-- 
2.52.0

