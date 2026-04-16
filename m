Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF068332616
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362944; cv=none; b=QPs14Q1lw4ZOBtNMtrtFUBr4BsDKEMvTgGypfDTIeuGxyyNFvUQj55+GICmXnM55/A5OMHpR0OBMsuUqdeTFleqKPavST9X499VeaT11MMXHSUQ6m2wM8I8fiUK53iCWQXCO49LrufOyN0SElz5ijZt6oJWkIR5Gcmwu5Pqtm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362944; c=relaxed/simple;
	bh=9MUgcVaAWSs2xwjNrkAQ7avCjAzkb6Sbs7AWi3ZFFvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ey16eM5okfabH0u9tsDFpwoKIlngwigTCymwEZ/8fjvjAoO3VmsRBGSuGMAI5zT6xuOEODf9L4SnM2Jl37CGNEz/pPb+KzICddGTYp/qSvHJ5qm1it6AdeSktM/JaC5C4MeJqMxzveuNFwHt87ef5f8EhbRsoee1UdyCPMY/jaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgWwX2Me; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgWwX2Me"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488971db0fdso83442655e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362941; x=1776967741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cn3tgD/bW+36qRuUEHcbeniBoPk3q+VVqx3HSbAOlS0=;
        b=QgWwX2Mebe7OduASBUbWouJSRQ0KWBfHcR0Pzul7OIRum3CYAFKzyleZtr37Aadvgl
         X41GD9xXyWQeDMMlYlLBQqZv86WZetyX0uoMOoqX5QZ/XXp3kGTa076G+qOSrQn85EzJ
         4R/KnJ8xsSRvx/vbTd/k7Fbhqn9Mg5kZ/jVAPc+4nufFiQu9NI1lc39hHs+jOOaCvkGD
         OMn0qPnZW7IkuRC3lf5U112uOGQnMDVPoAWDTTzrDsdrWLCGPjpEQw/9gXBp8IY+2VL/
         yhXi+0aCraT8LLV1aW5NcNk3dEuNKeKGzqWdTVqbLlaDYUUBDiqdppM/C22kS5nhfjxH
         ZOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362941; x=1776967741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cn3tgD/bW+36qRuUEHcbeniBoPk3q+VVqx3HSbAOlS0=;
        b=Ng0I6XoRfYFH/zkXr+0Db/TjtBjlMF6ysZkG/Qrr+X7IPih6TkwGEhidgAlAMBXSoP
         4scnrzEzV7gEjdY3R8q0TWX52mn11xzlCmlRIQZ5req4w6Ks31YpGTBlzbWk7dJEEgVm
         zFDxxWqG0COdYCjH7f+oi5QZhLobAibjE8qShQFf73ycSDgY6elgXobnTZ6RXLJffG5/
         6F+SoddTWF12xKT15F5fk3+wIWfNWyzfPPd0guXCRyV+4YUCIVLTMUnyYpLa4ny909um
         e+zmsyZk7txgHcOkn6v9tbLkuBwyat3/4rOYHyqCH5IxgEaH7mQwIPKA/gFML1xIEmf2
         qMew==
X-Gm-Message-State: AOJu0YxwTJ0i9Buar5FyKOGYuzijNQP1jLNM3erm3gkrcRlX4GZu8Kni
	70KCFpUiKhcBy4rpFPohpfbCyJxSoKmctpbwyQP9fk9fSqR9rXEI6KlQ
X-Gm-Gg: AeBDieugBZzhEV2++sFqoLrlgbnfq0gppsIXVOUCjbrTkGrJEdCBNRPSyPT9Qi5sC69
	csN/g4/Puc0jVHnylDCyrs+EEF+WVD4MgpdZrLB/obi1WiqfIHdAvmtgKjJbQ5fiN2eeDrYQJnA
	Ap2PUzC2lmY6Pe4G9K8CyP998wyTGMS0O6rxyHopSUhGxqVOrRkXbwW93G1G98zLu1UNPu8XBfa
	NUwtK6HRmHoUXL/22hzzBAveNAicuMbPcB/6uBPAPeuc3k0K4pAigyuGOPKeqh8VuNQ1z6tDwPY
	GgAwsJppeg3QNaT06XJ7QVb3FpqRdiH7slahxdnJZBZrjjpOvWQJnZAEMegc4Ps/dP+t+DAalq3
	4dehO4a8coSetTliS80sCQ5Lwdv9ZpW1UbDsNTWefxsw4fc4bURo3XkSNLvvzprcH/V4qEmkpn/
	MBlRgSvcUax5HD7kBGeR9K9A0=
X-Received: by 2002:a05:600c:4451:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-488d684c6bdmr323356405e9.18.1776362941218;
        Thu, 16 Apr 2026 11:09:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581b9fbsm68892655e9.5.2026.04.16.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:09:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 16 Apr 2026 11:08:08 -0700
Subject: [PATCH bpf-next 2/2] selftests/bpf: Reject scalar store into kptr
 slot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-kptr_crash-v1-2-5589356584b4@meta.com>
References: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
In-Reply-To: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776362936; l=992;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=XHzNoch9EEa++75ByIoPEnLxktkovZKvIr6txQIQSVk=;
 b=s+X8fOIssE1OOwyoHZJvnjgwYQAVrHvNW+OkoMISl2l4XZ6qQ2Aox9nZQKGRU72Tcvgh+pzOY
 kP26ipZAz+vAz9O6dsUbXXZzJ4Zs5rShtXoDmLA8oQ5mnkcyUHxv44n
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Verify that the verifier rejects a direct scalar write to a kptr map
value slot without crashing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/map_kptr_fail.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 6443b320c732..ee053b24e6ca 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -385,4 +385,19 @@ int kptr_xchg_possibly_null(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("invalid kptr access, R")
+int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	*(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.52.0

