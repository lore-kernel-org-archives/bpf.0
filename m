Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361134;
	b=WY1PVvJgqDg9wS+9lyjPSC9wNuQodthHWqmOFIoPfrUr7MUZFge+JxlwchIXrojwlwqi
	 ud07MrKIhUx2Zqh0YKrlgMl0WRUEPE3Li9MxGxSqopC7Rc7rnazPJ1pZuwdKCIHBp2Aq3
	 p9NagPqjCIm/JEwiJ03tElpItj4J8M4GBMt5v6FgB1DRguZVeJaiw+SLtkpZ7ImZZk0lA
	 K/E7rFmFSapAZScX2dF6rY5UxCV9JaD/kqU0yUs1eV6nDVavyYLQPXk/c2Gfi8HpLFvTq
	 g9LyJeYsCCTtyhJRvpsxnh/dGE4mNRvI/UdSMCJB/dK8g+NalcMP5MqUT/xnnkM0YXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=9af/XKS3Oa6ntF0hzYP7heRTeTtoyKml5lxTgNvQCXA=;
	b=Fy1uaFIZOvelnDZu0iOYLoN1ObsSJYzsXZG762vuk6pGCGFrjuYB3k/kVq5b8Pln8alJ
	 y5lmNr94bIV0pKQ2+RYYz+kh6tKtznXbugVF8C0ZLw9iseBihBUTgaS0nNxT0FzgUxHNX
	 uJ6pU6LhxrNBZ9nl+1vw2mkMMDDKaHAuCi3I7UCnV/M5pxILnfZhZ1N3vHs5WkFet37Yw
	 ObIrnbjSt9MnZ6ZY08dl/BdmgYoTTm6QQqhlgftCeUYn6OGBXIKP7U2xcuJmRBQ9WXl9X
	 a7Fo949tQsqLUC5qVFEPxow8FHUBt2VtQWI8nhDF3NFPaQZWQJdtRtw52U+t/8m2J3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IclhGUs9;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B31606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IclhGUs9
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso1495871c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361133; x=1793965933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9af/XKS3Oa6ntF0hzYP7heRTeTtoyKml5lxTgNvQCXA=;
        b=IclhGUs9Lp7lwRKZN4zOJIgx1BipK2xX+DKVInSQ7zjLfKfriBQeF8tv885asTbRVM
         bG7BJfjXDEgDbqV2OoZ3Vp/DXZx3Mv1pdskfO1V/mSMKqlViObK1dcSk6zyPrPwsaGkP
         Y8JWaYkTDPuZV0Qs7LDrcG8EgNoSFY+R0ipKnTfywrTt+Ro4dTkb48YIfjHfDGFJ5tdk
         BVJ5Pd+sbn/zCoXKuTHz1+oRqFwpmQPArFCW1XGBmP0yZt8y7Dc0kYcMREWDVxs6HjSv
         FGoer1Ti+4QkzHNu0OiYbagx7CR3sOUnRMvdKNwxeIQwXFyvJX0vBJiMa8/n36gPgjge
         4j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361133; x=1793965933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9af/XKS3Oa6ntF0hzYP7heRTeTtoyKml5lxTgNvQCXA=;
        b=tDjN94bKx9BEBIpYCzA7sYrQdYpI6COTosmaJUX2xUtSFieoG5JxIHFGz/fY5kme0D
         3Z1qJXSyxGaiKPJztVMAM7xmV8nSWOfVZuiFbsUwM1uiopGQqI7G9Zm2G5RHeqgcFIMY
         5YK1suJiOrCAKNKXnqH0DfT+uaoR8zsB1FXokx2+6OGPCrHihM271oU+tlPBhY4+IuUy
         FVRGRXWwiu4xf0Zs9asIUf7+mzaxuhqrDx+tV3GdBifrI6DVoJF9Yv9CuAznAzOp+2B5
         0wkh7pnYYBOsxeI2Gga8SSgKAT8tH3vcuz4uWvVigoRWnw0TGRS6gqjKdnmqa82Ofox1
         soMQ==
X-Gm-Message-State: AFq9FYJHyHa/wlwnCWQ7ZQcikVGVyqcorVLmQrXH3TjpPehLJQdE1JyR
	eoC3ZoXitz/O9tjwebo6/COQ33OhfI93IAOvvMUO642P03dFwF4r/l2A
X-Gm-Gg: AYBFou1OKlB+c3M/QmkOu7SKQhBA8418fz4aaDdEgZLHdrI7bO3gnvEKlhQJW0h9srb
	9RNKgv/qCgFy0Bug6odN9H8VVSA3CPklVtKcXYxeTqmnIq2pg8oNXFwkm6wZQGK4gm65TWX6MeS
	zb29iUW/bKA7xia69uBfuBoxVCfvZ0c0UA78j8NAfGSN4lbbuFkIqGp6S3s8F6bYW1fEcFh7Wgd
	pUMwYyIGtBsAgoWivFc02lwbJXiPbRg9WSfhv4VTeXWRA5dLXUm4WawUj0sbVRkhteKBB26da1C
	qvdUT9e9XIzJ85On33zZ2uUZNaSHxweBN6xGQMhib8BPFhvkOM6jd4Wmnf6x9l8GlmKutBWiQ+T
	52+Ii7lFYbQoqyUxIkqdxGKBRhRumEWXhGWkXRVFXmfRQfWxv/PrtQNx5zTeo3tn4kg/LbUhN2z
	B89ZXykJLbIjIdcBhMPjtfGqzNrdMFjDIgTHG0VcbEBH6lkHkVw2hWDjTVgLilJf/+L0nTiwPlk
	CmXc1bGBORlxvHckUwS9N1sCqDp+dciT7bvqAtwNPvJvE5Fg0eFrEhnJNIglgy2BYj1HgTVEo0W
	k7KEOVSdaYQADHND0ADjI+6N
X-Received: by 2002:a05:701b:4784:b0:165:4b88:abc2 with SMTP id a92af1059eb24-1ac5b5ee632mr3868276c88.26.1793361133396;
        Fri, 30 Oct 2026 04:52:13 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:52:12 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:48 -0400
Subject: [PATCH bpf-next v2 03/22] bpf: Apply single-instruction patches of
 the verifier in place
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-3-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_patch_insn_data() replaces one instruction by one in place, and
only sets non_stack_access of its aux data from whether the new
instruction accesses memory.

bpf_patch_list_add() queues such a patch like any other, although it
moves nothing, and the commit fills in its aux data the way it does
for a longer patch, which keeps non_stack_access of the old
instruction where bpf_patch_insn_data() recomputes it.

Write a patch of a single instruction to the program right away and
adjust its aux data with adjust_insn_aux_data(), as
bpf_patch_insn_data() does.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 0697f66b1ffc1..a0dd582312d86 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -382,7 +382,8 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 
 /*
  * Queue the replacement of insn 'off' by 'patch[0..len)' until
- * bpf_patch_list_commit(), see __bpf_patch_list_add().
+ * bpf_patch_list_commit(), see __bpf_patch_list_add(). Replacing one insn by
+ * one moves nothing and is done right away.
  */
 struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 				    const struct bpf_insn *patch, u32 len)
@@ -397,6 +398,13 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 			    env, "insn %u patched out of order", off))
 		return ERR_PTR(-EFAULT);
 
+	if (len == 1) {
+		env->prog->insnsi[off] = *patch;
+		adjust_insn_aux_data(env, env->prog, off, 1, NULL,
+				     BPF_PATCH_KEEP_TARGET);
+		return &env->prog->insnsi[off];
+	}
+
 	return __bpf_patch_list_add(pl, env->prog, off, patch, len);
 }
 

-- 
2.43.0

