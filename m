Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D7385D7B
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278667; cv=none; b=jp0xA3y53gUp/RkJV4vi4n3Pszhw2e8+6LaTmm6AGHBqDqGl8HtcpfSKxn60IkAzRpw3oHu5PbMzfUtrIhKE31Itkz37jGyr42kIKKkgYYj95tNSRuycHQzEBmRqnnn4RpvDtnsJ9q35mG8M6Iu3gCP/q81EHfw3WmjS8j2O2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278667; c=relaxed/simple;
	bh=UIQN+Q61gjDaJl8bGCz4srPdWACG2LjBjOorbT7b3OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5riKf4AA2rv8mR3COD74RxkJnxysjAO5N9NopW4m53ZwyTAFdZyqurRqfIeCYT5oB9Tdn3ePxy5UmMXMeQHu8ct0+C7VTukcD1bSDCJwDLTmGpXUjUndu1+1ltFYxhMbvCWAwtvYS6zYcl+pXwqccQxXIAwnN763/+K4imtjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqvyG1IC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqvyG1IC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so473446a91.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278665; x=1792883465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wb8NTxayR/aWi0nxQz+YM7CQg2uaa24XpY0+UeFxbfQ=;
        b=qqvyG1ICBQQhzM9pNIL5Uh3QSQ62qlJUKivTN590h4yuJpX9GAkmRi5A8vdmIbwulG
         LJHrOKguFH/kWAqTeCbY/Ok2WLTLbPxFTFtBdYoABHt8CyxcrFr/FPCKQWJlcXXy7s/X
         51K6+Y9ajDURSl0tSULAoWdQZtixqchyNtDAMAeJCyEMxznhsn+TvmBl90z6z8yL/sLm
         0jr3PbA3+vvJiWdBT5clmWJx6AXj9uE/6qnZsTh5XterNTIAkDBvwaeEgNAMC6mIaPnu
         Y5RAA/jCzNuge5M5iXmbkkELTlx/FbQPOZ9Pn1ZUC7d0kBjeDC0QKRxQmT3n+7zVhnVI
         1JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278665; x=1792883465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wb8NTxayR/aWi0nxQz+YM7CQg2uaa24XpY0+UeFxbfQ=;
        b=tZjw3Ir2QotbhyvdFk+Hl6oF8WOWlmRtIRd1kExR2BQhZ6krfZks0y3vMLh/t3mP2d
         7fq0623bDRpAlhYDNUUwWnKRt1lEiJMqKNbT6zuNm1D7JSwJpZJXgTra8TCXUFwsGuqi
         ytYj6IzGS2WMD5YxIlEkQG8c9DHb4TWFAL+VEv2uT1c+ITujOikiCPWtBUpihIqYyHFe
         wML5N6Dy29wLITd4FLTkRAGq9TWs8v/YrPxzWwX01f883K7d5tEy10g6VQ5BPV4QFWJ+
         OE37Xft0Vju+gGTaLsaqptDDHNDIs48DIeiqd8OdlUZKC/At4+HnBefZ/VbVITxLiyXH
         rVew==
X-Gm-Message-State: AFq9FYICfNZscI57QgQtrhOlBi5S3maLhXF4i2o1buewwRkZ8g93XaQX
	rSTmVbrFiCUD7keNryCdAw9GcCB4kQ0pnZ8I7GIU6/9A+Dr1p7eMYq8YKv0pKA==
X-Gm-Gg: AYBFou2hOr0o7h8IqC22FPheicS7U+We9Crki6EIk9SZ2EHYdSyW84uwDyRfu4MbXoQ
	gKjQqsCcnB3+XgHyBm0+30qYNfWFmNkOeeK1kxkJB8VKMsybE1Rbp3kHtacFG9uy3ailL6Ag2sa
	1wvMT7pvuv/G9IlPPeRW+j0hxw4MvM4FFmWuk37wN7D2/PGTaT0WTJmCDTKkI3YwwSY8aKHozb9
	VYy1xEzrg5RTANYXEAtHK8VX2dN86JbOwKV7Vfw4S1QVL7Sx4in8I3lDDIpZeAobWVL73EH4ko5
	jwlq9VteAeIjDr8ONocEYuO2mMhdMhTsnJN0moCeYlN8i5OAdKTreAuxR+l2WIUA/Vwf8+oS09u
	yZItRkP+NeDC0+08XBfehhU+enNLw7v2zGcmviNafo1UszMia/RZLwHeKtfzES3MiBEtFpmqTis
	8Dh1M8sb3CInqlAv/zduSvwY2VhnUECZ79DUCf0jCpuiC94fdRETH/T6MFj1MQWjo+CfGrviylq
	n1ORc4OOgZknwjaooYdmqcjjV/6ovG6vPvxjD/oS36bjUBQUXXKCSJsE6gdJALhYGhsHJ61SrBl
	V0nurH7goor97zHjsBUR3RyzwTclHBZ6NAi/cI2UXkfN
X-Received: by 2002:a17:90b:5623:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3acef6391ecmr3326391a91.63.1792278665259;
        Sat, 17 Oct 2026 16:11:05 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm9924264a91.3.2026.10.17.16.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:11:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 12/16] bpf: Unclone the skb for kfuncs that write through a dynptr
Date: Sat, 17 Oct 2026 23:09:46 +0000
Message-ID: <20261017230950.802052-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_dynptr_copy(), bpf_dynptr_memset() and the kfuncs that read user or
kernel memory into a dynptr ask bpf_dynptr_slice_rdwr() for a slice and
write to it.  For the linear part of an skb that is a pointer into its
head.  bpf_dynptr_slice_rdwr() counts on the verifier to have uncloned the
skb, see bpf_unclone_prologue().

The verifier does so if the program itself calls bpf_dynptr_slice_rdwr()
or writes to the packet.  A program that only uses these kfuncs gets no
prologue, and changes the data of all the clones of the skb.  A packet
socket, whose clone is taken before tc ingress runs, sees what
bpf_dynptr_memset() has written there.

Treat a call that may write to an skb like a direct write.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 338376492647..3bc1df7aabe2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15683,6 +15683,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	    bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
 
+	/*
+	 * These kfuncs write to the head of the skb in place if what they write
+	 * to is linear. Like a direct write that takes bpf_unclone_prologue().
+	 */
+	if (is_kfunc_dynptr_write(&meta) &&
+	    dynptr_write_changes_pkt_data(meta.dynptr_write_type))
+		may_access_direct_pkt_data(env, NULL, BPF_WRITE);
+
 	proto_slots = kfunc_abi_slots(&desc->func_model);
 	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
 		struct bpf_func_state *caller = cur_func(env);
-- 
2.55.0

