Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE33DB634
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219478; cv=none; b=RmPfBGKsnQ0q+xgAO8yWTmn+Zi4MJyDzV6ZUIM+moqQrNeX2SNDiMtDhLiA+GVOa48at0p3LvCZs55801V2Dp1JXHyvbA72MCqMIgrg1evD0iDhpH1mTKm6ccUtzVcSN+GHpFV1CxeGw0JNmIuwd7890OLRR9ztTrBb3cbmx1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219478; c=relaxed/simple;
	bh=0WLHuUT8EFJIINdvMrOHk6rFlSg+sDAIXwxKcTug/rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+PvgM6dTr4x1AsSFsJRmdHoEqO8Wj3lr65W+YoYsBJkJtMVd1rbtMpfg7xrN378N7CeD1Krw81l8uZrln6sK+JFkQdvEoSmVKFnJHCyJW8gZyK6jSef+oEqKAVKtApvbyPOW3tjGqe9/VMHAnQ0WAet6lDIs3dFPT/T/MPhwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIu1WWkY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIu1WWkY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so929834a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219476; x=1790824276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhJ+IXzKikd9xGR9rF+dhnQrsRGhRphcurmYEIh1ZEU=;
        b=gIu1WWkYYa42xeTXnqnO8PdS/8P95oNi+WzBiXOxVoxMt2KAjHNHACvnxHlnAT9NSe
         ApYJc7jv/ogyqcD6tlOC7QKBQc3qi045CpKFMZZYWyy+SmbKtqt+9cNnfBG4obtDwUYg
         AcGIqBe9K3BTXHkzlXHlk/CGwFadWaV0Aa9aowdrCSK+zZPMIcv9uCRl9+PInIyjy5di
         QLV/KtkyCmEZwwKEAgFmn2+donDC4bn+T3rBaPlxW4TtaLAnnbgnfBhgEm2ppWJuzklM
         80l9eBZAm4Elfs0o7NpJXOm+77Ghk6Rk2MH3O9Yvra0BG6fB3eVYqU5giZtIU91O4+PV
         7wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219476; x=1790824276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhJ+IXzKikd9xGR9rF+dhnQrsRGhRphcurmYEIh1ZEU=;
        b=PJC7TeurRWMAW0OMIPqacrl6vpXaqKhMlo40Jd+p74ylofVOOvJvOvHfa2RoL5fhv0
         iNk1x/w2XL2lFmsVEJNVo9yQLEXdPe+snntA3QcezaNnY2cj7z2getZqFdWRybAD7MCk
         J5CSY+UE5j+7nXIhsqu/2f5lXbRpijp7TTGWGFJc4XbUxZss+zOSiQyN+Ahl6Azn4Mel
         6LFvH6yF3kEyR9X4YY6v+GiUYeEJ+NYvpuTDQhD0qYSAP4o67V8oKqOf/Ld2v6oM8Bv5
         h/u22DM2th0YNWmu8/kjgOb3vnEDtKBsv4e4tMOTGdqSEpPSrgxH1wjhiB1oZkV/VPrT
         huHg==
X-Gm-Message-State: AFuF++m/i9fRuQ4mzp+uH6i+EgxjzYwBTDdLH/axl/EQz5OQVlI4DWsU
	sNB2tTnZ4ROBGxGEAA6JzThDQy5j1AwafxNmSxQEGDYZ6mbwI39mWyTnSbD7tw==
X-Gm-Gg: AYBFou17iFVADhMRPK1axfycvY3lOJOrAjYEpHUm2HPq3Z3DJmd+gsNpjpExGD4EnpT
	UlGpp5BNehJ3lHdXb1w3vFhF9CAiVRJWSfttVq5IbeXxvFTfTEYqhIQJM+ZvZAAJFZFIE677+MI
	IC+mY+0hTxm/kHvkGNTD5sNvzdd6s7z/LMyv9b6P9XBsf8ieXuIdOBONS3IH/FUL15HeYZb6D7y
	WUPorx4amVNuV03yDLflOGALpF4plpZ/5JKdg1/qnhhGftjqGcHccivDj79+eWepkPgq0KVn8lw
	O2LlaujKdvGk3b0COTNxKvoOq/kt433ArLf2mrgN7H827Z+qqPvHpiF/sDapZPTqEuYQcoXfAur
	EwaGkZtnFbqQbMjdaUeQDlkJp713MUo6UkqESxxFLAMfuH6EOloPLqNJr1TbGrivTmdke2ZL566
	SJc+oH55qe5VjZ2YCpJrFDNCwHFxr+ztitH4HDbqgIBy56j3/B2/IHojNC4qyu5OY4XJZ01WKN8
	QX3Qz7vLarkG0QCJgApD1Vxp7ldeZ9TEsDSeoovmTw5DR8XnI8OfujpNKS6DQCT0XnOeGp28/Fe
	e54aojynxVA2ftWAija1WW757Utg58++Oix9Pvdzvis=
X-Received: by 2002:a17:90b:2887:b0:39e:4c7f:8b1a with SMTP id 98e67ed59e1d1-3a098e3e957mr923323a91.31.1790219476208;
        Wed, 23 Sep 2026 20:11:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09be21a68sm378669a91.1.2026.09.23.20.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 09/17] bpf: Discover subprogs described by func_info
Date: Thu, 24 Sep 2026 03:10:34 +0000
Message-ID: <20260924031042.1690890-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

add_subprogs() finds subprogs by scanning insns for calls and ld_imm64
BPF_PSEUDO_FUNC. A function that is called via callx through a pointer
in data only, e.g. a vtable, is not referenced by any insn, but it must
be known before check_cfg() and the main pass.

func_info describes all functions of the program and libbpf provides it
for every function it puts into the prog. bpf_prepare_btf_info() reads
it before add_subprogs(). Register every function from func_info as
a subprog.

func_info had to match the subprogs found in insns exactly, so existing
programs are not affected. A function that is listed in func_info and
not referenced by anything is still rejected by check_cfg() as
unreachable.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d00d0ecab17c..71b8825ffe1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3023,6 +3023,22 @@ static int add_subprogs(struct bpf_verifier_env *env)
 			return ret;
 	}
 
+	/*
+	 * func_info describes all functions of the program. Those that are
+	 * referenced only from data, e.g. from a table of functions to be
+	 * called via callx, are not seen by the loop above. They are possible
+	 * callees that have to be known upfront as well.
+	 */
+	if (env->bpf_capable) {
+		struct bpf_prog_aux *aux = env->prog->aux;
+
+		for (i = 1; i < aux->func_info_cnt; i++) {
+			ret = add_subprog(env, aux->func_info[i].insn_off);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	ret = bpf_find_exception_callback_insn_off(env);
 	if (ret < 0)
 		return ret;
-- 
2.55.0

