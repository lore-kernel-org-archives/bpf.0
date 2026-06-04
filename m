Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD830D3F1
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610948; cv=none; b=a0+37ZnDy3lDfedhzfz7jqHnvApSNMA5ZyZaN5p/IpyCZZ6ImGrpzGAT+JER6Qr47K+BloOq2TYmokJvF4h0wxU1lzGzDxaiEmIoudSJLx3E/69HQr5glruv1ULJE98TAysKSPJEAN2LCFHllHNDcYnI1oFQdIuToSC2c8e2yjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610948; c=relaxed/simple;
	bh=6v/aIgeg/cCjORMO77cTrI87aAwG6H3vcqGwhTc3UQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rODGuVcs4peFEXYjwoGmC0MSjaB9Pz7pPUg7lIWCBVtwbtbfeK8BgCfa59dFzKmeaCFaTGkDvHoUrO2SRJL3N9daxqx31F34Y6/0ZahNdSed2XzGFDPU2UwIRkFNZ6SgHXWikVmBPXiqd2GjEP5hbDVbAiqYJ7jwmZGa2XZi4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUbEIVSH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUbEIVSH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c858d69bde9so596717a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610947; x=1781215747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/L4DIvq3OTXOgiCt1psuEKnggjX/25MwpcePnkwj24=;
        b=aUbEIVSHpWvEY0uvle2riXMSXgyoZprTB7UmY4dzkACO/PtNM1YZ3g4Quzhn/fcXYj
         8M6lEboqTCZHe21CwJICzJan8BD0bE/Z07HBbvcsJ49Qwep9Ol/BzTQDIS8GsinoXINY
         ve8Xz1eIKVOI4n7xI2SOPTdcVU9dgBiQUZTEh8Ed0b+u5rf9XUNIXAWzTZcz1rAb0b14
         wv26cNsSsy1Dy9ZYFS91NvWbKibD3cAUVKNl45PBtlYTu4vJTsqYoBw1mClPTHv+13gA
         L+5IcrUqLdbEuRd3gAWcs2s/2mVGVu6+Smy3U2EkJ77DlJH75fGxQGC6VXpRCimp62GV
         Ii3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610947; x=1781215747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/L4DIvq3OTXOgiCt1psuEKnggjX/25MwpcePnkwj24=;
        b=c6SSlsuyMXyYzVKZHNW4tdor/8aSgcNDXFjUV3Suz+LYqBVa/md8JyJMTxtJmt8zbp
         g03rWtLG0axRoSYRCDSoa88YH4veok9KdfVx6uDHJwYubBDVD7tbBeW/rWErZ9hwdklS
         6zKQZNv4Sh8cM+WTYxet7c0wdBSwXM660QXQ7/dU8/ILtOPcUQgutMfTuEyHuwxOeauP
         rX9ITnOL0Uj/na1A5LoaD/fxgDopAMp8U/T/1PnuxJtyB2CXc7nL/0lUtuzWkbTfeid+
         W6QZntjYIuM0GGCJus9vkKE6a6izGMN4nFajjyzmxX0RRt7Ir4pKFPrrXHWZQPrkfMRY
         /I8A==
X-Gm-Message-State: AOJu0YxHlywGQ/8iJH78A+w1pyjIZ3NgIbf0GbHkjfoA8HJCFolA76If
	bH/00EJA6OEmncnOjsd2pqE7FSlt39ia4HR3R8A0lDs6t1dpHyQ/yfkhKxOg7w==
X-Gm-Gg: Acq92OFkAUawKVhxY22x5THRVtc1LM5Xw3C9B4JL+02is0qj8N6kikgeqGs1Vv0txbr
	ZQA8K+KFcZya+ORzZZGskQHUKcS9FFzpuOTIgGOaJwJ04yDXY5vkLnvEausaKVw7QGd/nzzqU9n
	NNe0bb7VZpSLYxhVOew5Q1C8bwWSTtXGW4tESMsGDN/5WQ8HZdIcSc9f41oqaWyN9FNbQu+ZCk1
	e+w9PgVJaGIMgAet4i2iqofiK7IQ+AaOBtN4R/xPc7cjAUKEkz9ipmjA5lfpsHIim0LDr8c2N5u
	WyrINGNKUhW8TQZ0vOc/eIMRbfLZW0sD1buwHe6mSxiFincf/fkSLY/6ATUrphTX30JELlQwCHW
	UKPPSTlp99A3SHApDfYiJMP/0kOlcduEcSbUIWkL72PYPqU4Ahk4RVkRmS8SlfHakZ98Fzv4b1g
	POnNh+QNxlQguJfcleBYIzmNol+lLCq+T8NpE=
X-Received: by 2002:a05:6a20:1c8f:b0:3b4:6f7e:d0f4 with SMTP id adf61e73a8af0-3b4ccd5ffafmr989568637.15.1780610947191;
        Thu, 04 Jun 2026 15:09:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm7075507b3a.34.2026.06.04.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
Date: Thu,  4 Jun 2026 15:09:02 -0700
Message-ID: <20260604220904.1032145-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acquire_reference() returns a signed int that may be a negative errno
but was converted to unsigned, which makes the subsequent error check
deadcode. Fix it by declaring 'id' as int so the error path is taken
correctly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..6446db9628ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
+	u32 i, nargs, ptr_type_id;
 	struct btf *desc_btf;
+	int id;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
-- 
2.53.0-Meta

