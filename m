Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105595;
	b=WCTacGxfuxn8+qC+GGqtMmtCCvaPo0uN9aD0Ecbf4CB+R8uHD3xBC18hRv3cNpDkshhM
	 PxX/aDxXQ1Gw1TXpNglu5VIB61T/3Bq000UJ6niqh0PpVljwdeIPDUs2Bz4j1AJO7AmIM
	 BnO75eYWcq/dAhkJSKYTO7/kvze4EkEYCCyNnTyG98ZGxsfgWMUalmhYL+wQVRCqRcwE0
	 R2IoP28PZDEzF9PV+3aBo4klEXBGc2RQA0UuQK2CGtUVZZOcL7IphV2tmhbDtW0hTTauR
	 myUx/JNblC2hq90Wt4i10xz+p+hckZc8Etf+Tj8z6yZg0FBDj+9mRFLn3UsMr5AKqPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
	b=T3oALihJmNscknYZA6qG6S/slXkelH4q9uNXp4jdbkb9OflNC4PHBTBlYgH+F4TnfZIr
	 kmj0xWO8QwykpqqCfk8W5N05zU6w72SrHbf/0hz1k2btKEm27yNHuuB4zKKVIR5Gtd393
	 kq6ytTEFXkBJ/lU3tndCPjNA6N6t5b5wU4YHUpRuP+4grenkVSdeTvwlEhA/A1fgxP40i
	 akOkB2y0fAzNlDOY+tG+U2o/6OqLFfXnhFt5beqRc0PX9G1kuvVarIOpaRwP8ZF0FYEK9
	 tIsS301b8X5jesMAvpl2JzM9p2C2PsBfmunroIwHRKJiXTy15hAIiIdEqMVOO30cmkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3XcvJyP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE9606A33C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65DE9606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3XcvJyP
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-980c4258105so1456253241.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105594; cv=none;
        d=google.com; s=arc-20260327;
        b=Lyo3d5P8v7+G2Bf92Gg9gCnR/NrLpNuU9RGqJiKFPO015HCUf7GuZ1Y//kcLQXVRDb
         Rl/sijp9GlWS3caaateWxK8cpYjpZR0myRooncHjVxiWIcXR3Wg0Hhr/thePIeKSZAR1
         omYEGm3jaksJFuiB1vhDQdeMWmkBhEh3P0JdlbWX0B6usdfykrD1aAD7wOmzH/AOe81R
         cqmfUIMKwdLqvJbW6Y3fbOeCnBTYBzpIuEUfGtLUUnNUFFPmJho2Yv5wgd5hdT6yZW/x
         3B5f4XxlKIcGCCJlcH9N/o/svwvlCR2UpdKjRuZeJ/NQ1oG2dKVchnVo3rxK60tXFHzl
         3qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
        fh=4Z8kUo7ZQAE52QDzrWjAPPpNicBFhQXYM+Ho8XX93z0=;
        b=Te5gXCep2YtG4EMhvM5TJbx+/fwXYqCWgcrR0IP2QOAyumfH7soL27EcfLaPYTylzl
         dmi4afrl0UvX5f3gZTXYWeO7XoXPbRe/wtTdDV6Mr+Fng/o7lFDoNiXTA5DTBEVGJdrM
         BZW2LqCzvT+PFmRChCBRS12vtM5BfSLW3bcDTU6SmdZ53O2IEFO6E3SmbWd/8Ov5oT+h
         CG3YiyMkjGsyxgtWqeCUK77u70gzw3kexsAB0orY5T4jALCwjk8Jb8pSf47LjBOgUZ7q
         x1qtrefajVykrOBsbAoLKVql4IK6uvA3aSAax0CESjeRPnip3K3ZgIiDtBs8bn7+7QTG
         k3hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795105594; x=1795710394; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
        b=o3XcvJyPDMVgo+Y9ljM+UiiOmEX1i6mzTbS9AvOr5Wlrxm5UrmqSnJx63v1kqO+tgq
         CJMCj2RP556/QMgxXBGQIZe95L3na8iuvojp21Yee8N24VgYVQjFYyjJUS8Mc0FFY1Yj
         B1jCQ1a6AmZaJlSWIa4b+NJPb8URGzwycauK7ADiRDkwTufnCah3cD5ybG9EMxRY63P4
         yVXRwO161+a/Fk4PjRSE6QE7SkeRCWE39PzN15zbnHk1Y5ts+Dab5csAEwCfN6KnVWzr
         oYWseARcx4Ev4FWcWgufOdCFyv7wYLyTCWafwl7epxGrkky2l6y40EaUAFOu5qvN831L
         TOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105594; x=1795710394;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+MSfWkaCvsypi1LjUwVegIyh39nXJG5xylP4jvGm2YU=;
        b=2eRp563fTD2poAGKxTqd7rab5abw3cyIDpCg3CTTu7auFGpsiOWvrRVQTL8O6aw/PP
         4YB/q9Ct+E9JLj7ypWM6ADMUOBsmoLW3gaxt7z8Rw5+b9mcmvll/Xw3QHGG+RiryGO7r
         UATSb11/6NRn3NijQFV9ka++TqPtL8HmKtF7+IW2d/v0pBL0hBbnr1chgJytb0TBCTXq
         FLrKPEG/sciIZho4RwDV7lUahI89Qv7TaMZTZumLH2Y/uaEZ5R7XM55nkh2dCPef6vxM
         v1Aa0NiYPQBVU9r/V80lNe266tVRPQR2TxSHgNfzERWyKbvu7yi2dLWICmbDEqJh4NPC
         ettA==
X-Gm-Message-State: APuU4Z/dHtOUpGPJtnYVju5oN2tfwNrgX3WUIc4KO1WJOBis+OooZ3Cl
	82DPvYZDYxxeMkwVbkTIgcCPFcmq3383InKMAsrZkhTr82yMigL0PY2Iga+nVkK2qUs4eNBE4wM
	I+BDw2fzhGut9hYANPNsIP4PrvFZLd6YlY1ARbPDHbpLq
X-Gm-Gg: AYBFou2rnyumOBAtmNppfhArwvxhX6zx5pjWd0FJLWWH/LZeuNRGLEMJJfF53E9MjnN
	mR68qAHjItBYjammLeYBnwEUhtch9FKKgnfeldrZ4+cwr7EzubKik5RMPwg/hvLPK6dFLzo6Vt6
	Cr8X/GB9lnx0dF4V/xRsDQTomRwj7ftCr1jSj3GJAADNC5mLxMcIaQs36G7gZLEe1QFbBVjW9n6
	BJRbXQdr4bf5mlZa1dGu92j/lBQ6oyz7BCGPQL/BPOmnNGo5gEcaYW4d0dKL5c0IZHqW5F3XYDE
	KvH6jlgnELhlrJgsL/PUJVLuNYpQSZTe4X40B4KAR1zpb+jLDd0AbZiBMskEkydqnuhyv71uNxg
	MJl0lcJL7CqQteMf//O5p2prusMFdaFjXGG72UCKtwXgXMU4A75tus+Y6FX60uqezAx1ISY7oiW
	FppJbsNZ3BVZRrlx8lxg==
X-Received: by 2002:a05:6102:5695:b0:7d0:b125:79b2 with SMTP id
 ada2fe7eead31-7d6ba174dddmr3393998137.1.1795105594292; Thu, 19 Nov 2026
 08:26:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 11:26:23 -0500
X-Gm-Features: Aa3M54rjo5bOdQvVn1fygWT_1nsGpBZbzMngceuQWUpmls_oZpOA_sI6n3diqnM
Message-ID: <CAMcAce8Fc3erawRn=4SvfuZjb7rovZFN7tQZB5Zg6mLvtDKgdQ@mail.gmail.com>
Subject: [PATCH 6.12.y] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]

bpf_verify_pkcs7_signature() passes the return values of
__bpf_dynptr_data(data_ptr, data_len) and __bpf_dynptr_data(sig_ptr, sig_len)
directly to verify_pkcs7_signature() without checking for NULL. If an
empty/null dynptr or non-linear skb/xdp dynptr is passed, __bpf_dynptr_data()
returns NULL, leading to a NULL pointer dereference in verify_pkcs7_signature().

Check for NULL and return -EINVAL.

[ In 6.12.y, bpf_verify_pkcs7_signature() is located in
  kernel/trace/bpf_trace.c instead of kernel/bpf/helpers.c. Adapt upstream
  commit 49b18315be4e to kernel/trace/bpf_trace.c. ]

Fixes: 9b2d3e911295 ("bpf: Add bpf_verify_pkcs7_signature kfunc")
Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bac2db7..41e237d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,13 @@ __bpf_kfunc int
bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,

  data_len = __bpf_dynptr_size(data_ptr);
  data = __bpf_dynptr_data(data_ptr, data_len);
+ if (!data)
+ return -EINVAL;
+
  sig_len = __bpf_dynptr_size(sig_ptr);
  sig = __bpf_dynptr_data(sig_ptr, sig_len);
+ if (!sig)
+ return -EINVAL;

  return verify_pkcs7_signature(data, data_len, sig, sig_len,
       trusted_keyring->key,
-- 
2.56.1
