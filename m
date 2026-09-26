Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D571466B70
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432451; cv=none; b=j2UgOIufOzVSkdJ70ldUU1ZNEuSEUcpoHpdlGpeNJ5Qx4suBdMOvvLsUuUmng+xqRlKokA07s6G/r6NN8m2tYwsFws5GcSa2Re1m9dhZTw/LGxBBmgElWFs3WC79R2KHQvgjJoZMcxF0VQ8A/5t/6VXZDxiQgvMRrWGudzKhawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432451; c=relaxed/simple;
	bh=Pokc4CABRn8Fs8yWMqxYlv+/+ol3rQAzQXZTfqGdEu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJDmSI8K0QRs4cEna7Qsjc0e8W7HjfIyNvd1GU21jqGpa6LPN/TF/4NhFhWXPO8+1DSusm0OWjKzmKzMBRHvXzxGQBvy1t4/HNOiN4kb80HImTS4sukhdFe2hEv8CTnk98QwXyBO5OSQlH2ngPoPPGc3ToiRL/Xr4Jngv5V5DCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzpsEAIC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzpsEAIC"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1340448a91.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432450; x=1791037250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cRlqWaf7bfBS3DkgeS/q1FgZv6Qr2ELGoTZp8c3fE7M=;
        b=jzpsEAICc8NxG/RU6+UYo02G/3rmpBGW2zMlnbzMBSHpY2qUoTRQwR/jXgoSpF1ewL
         jt+kERa3HPabLor81hz/rO5OWBHwGkFACyk5ZaslXqfv+H3SiTNziFEcbszbuehMfy43
         wfzjas1P2OLuL1vsX2vNOpEfJGw4mnKME6IYxz3XRWJ0KW3St1AzWhJCAHUlVqDqB+92
         NSNLgUEJkTiHv/Fog4v/EGMnuDl1zRdwnZ0iBzVyyTeNmQ6NKlQ4xm2DTCk4ncQSHMv/
         E6kiCpChKVwI/wpRne+15lPAXcqkdQQKJIdF7TvlZSz8L6EcT8xjAC5J4ij5nV79IJH3
         eGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432450; x=1791037250;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRlqWaf7bfBS3DkgeS/q1FgZv6Qr2ELGoTZp8c3fE7M=;
        b=vWhbuoPPVnOjnllnPyeX9t8M9LfhFOHQr1iFhGqeX3XuEPC2ndJeYp98tpPj6cDZpw
         2HwwXUaGwCiSd5j6QzPN/I8j+Xo3Ot8799GeH1MLFox1w62gYS5ZPlhsj6ro52yr5dz5
         Y5cINWyaQI5aEGJ2+nifTGOW0KqJezC4rcVR8q9kODNuwHNUZyP8AxQ57oFSucB/IWqD
         PSatjEzqePj2v3Zyir61lgPUnr0YrHOpln9pOpSK3fwRIEf8D7qzCRJlaBYATEykFgO/
         MJamsPLaOv338difw7WyWQwzOh7DZ1yp2EY4DQqk31fHOiLiCAnNlXpdwlZVdycyGaho
         Xjew==
X-Gm-Message-State: AFq9FYJqBqaxPFCNUEushxyPhjXoZAlmiFfN14fW9QY+tmQYb/KoGtEG
	onra5hKSVyeYvLfehSSXgNH6Ezr5qA91UMnTsJZFiaETln4ikRaUke5zlTI/DHTnl8o=
X-Gm-Gg: AYBFou3qFrHLGBsNgu5XA40ooqLv2cs3gp8qZkzDwY7kaI2/nf2pBYvNwVSjtoUb1cB
	5V5/MHXjVfcK2voR5Vzyo+dA8LI/0EzEBPh1lVj4xXUJ2KhZriv8ZwQu7Z+CG1727p86GHWn6j7
	yN+bNirvctBneDcOIXwYRaADrmiwS/NeIqVLMS2r3ELIlcZzZM9tpGpWCrT0cszNvROR3enJo6I
	SjFP92xOcZSPJ5SCPtJRdCMvYK14cPjsdLAz3Ooy8qJp97oU7bCoT5LDJG/ZKxxVsp5wy1kKUjd
	F1Q/0HeeyRp8Xd6yUA7xsctTW8TqRnt2RGUr6lCYJZUm/6BVMOvfs/XXYmfhdLV8X8Li3TUt6EA
	6b77+LU5/fwnLEazXTcuoXQcvZhN4Rlt1Np0Wsa2p4q6yjVOq2LyDwXxRuwVTu2xV2vuZgwLzYg
	AhAk+DaAQlXfEtwCQA86K+wfLy1Dpr6i2RKS57Zk+CIyl/oSFqxEPxEIzNCn5gFqdNOHe6Ay6ji
	AEe6FIJPTofTwxmmFip9W/0lGZydRfelGB8uBPjS7PEg7VfSgK9
X-Received: by 2002:a17:90b:2d85:b0:39e:3558:f925 with SMTP id 98e67ed59e1d1-3a0bb579cbcmr4342947a91.24.1790432449841;
        Sat, 26 Sep 2026 07:20:49 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 03/36] bpf: summarize live stack slots in insn_aux_data
Date: Sat, 26 Sep 2026 07:20:01 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-3-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV needs live stack information in order to skip tracking dead
slots. Liveness tracks this per function instance, but SCEV is not
callchain-sensitive and needs a summary across calling contexts.

For each instruction, union the current-frame liveness masks from all
analyzed function instances. Represent 8-byte slots as a summary of
constituent halves. Store the summary in insn_aux_data and expose it
via a helper.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/liveness.c        | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c6d617581e84..7f31ce5ea6b7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -667,6 +667,7 @@ struct bpf_insn_aux_data {
 	 * that this instruction may write to.
 	 */
 	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
+	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	bool nospec; /* do not execute this instruction speculatively */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c871744ca5a8..b6b7fd479569 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -729,8 +729,9 @@ static void half_spis_to_slots(unsigned long *slots, const unsigned long *mask,
 }
 
 /*
- * Precompute, for each instruction, the OR of may_write masks over its top
- * frame across all func_instances reaching it, stash it in the insn_aux_data.
+ * Precompute, for each instruction, the OR of may_write and live_before masks
+ * over its top frame across all func_instances reaching it, stash them in the
+ * insn_aux_data.
  */
 static void compute_may_write_masks(struct bpf_verifier_env *env)
 {
@@ -746,9 +747,12 @@ static void compute_may_write_masks(struct bpf_verifier_env *env)
 		if (!fm)
 			continue;
 		nbits = frame_mask_bits(fm);
-		for (i = 0; i < instance->insn_cnt; i++)
+		for (i = 0; i < instance->insn_cnt; i++) {
 			half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
 					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
+			half_spis_to_slots(aux[instance->subprog_start + i].live_stack_before,
+					   rel_mask(fm, i, FM_LIVE_BEFORE), nbits);
+		}
 	}
 }
 

-- 
2.55.0
