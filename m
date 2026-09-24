Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406B4A6897
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269075; cv=none; b=sfxeAUr4coJb7op9Z8NemoyORsmRU4NDLO6Td0NxWuna1HIhlXMbQ2xJBPuEQDrQr4smBAcDVdR/hrdLa1hGk3OZvMbxocsB6uz+MloEx8n3sXqQXHUYXrUExefEiVwTIUqrldzsSpSOMNDhkkn5Tkm6g7AGUxv5G9anErxyjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269075; c=relaxed/simple;
	bh=TAE5cDK+wPaS/4IERiR+DYXb4uRNzHshBUfgiFnuRfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMFpEpCGAd6lvZlsd2eUj6zUdH7X0A/a4T3fcpry5x6Qz8WaGByNGMDTXZTnhniiFY11ypo1btZ+yS6usDak2ol1mQIWmfbuiT4AGaj777JaxEjg6yZuD9rhWHC2KXisXtPbwY59oC1o4pvbBR3CeA8LU2SGbJLLbFTxUL5tIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP47krXp; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP47krXp"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49814d35686so28225e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269072; x=1790873872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2g+9150saF59VyUV74KXwcQ1mn07vpxpaBtvtJ/IZ0=;
        b=eP47krXpqyf/X5TMZ4pyYX8qCTcRqFCIHPUx6llSEkrKe++RIr0FNmnp4JYp0AAThN
         rRcr6fh00WvOuRIMtPICo25K39kS/e0sPwZTG6Z8Ejk6T2s4cVBUPwZz0dQ1+SylP7zO
         Jk2HnZoG7zLf7+DIuXRZMpEAYbXAkpBw8ie5amusciksNWyTNMO80okaEMFmke3tnRAU
         j3yhxgn5zGrPAD///gx7jY5qrwfl9nOhf7X97aXSp/mAgzet4P9Oo0OMgPqQDZZlgNpo
         hG8TprCJvwN9+f07FEk/k3Q7E158LKMgpDOh3LVAJV2Vm1aI6DKq9Lm9jSZ9Fwl4k8kG
         vtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269072; x=1790873872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2g+9150saF59VyUV74KXwcQ1mn07vpxpaBtvtJ/IZ0=;
        b=POvWXy6XTQrtzfNgDglX6fy2qEgVbNgMtzhGY8TmAKtN0XAA9ctME7RxgWDxeuamXy
         6zHAtaaWFUEUkiDD45ABChZVuIGjhVmQQIPTM/RxvclVMn7evTt/9y6Dwyg0wKus5Vcb
         qB402aMg3mQPeMBc6O5qQ68+XDIXbbbRrAySfuhmAVJF+eE2fQbjmPlKrMBmDYPtA6yl
         1to8JrVWJjugnvD9yuE1rL/UbUFqf6QpKkOtSyoedNRE/Ixs5433MSebFTu0URWH52cy
         1+U3AD8HBoBT4IYIvSNmtNWtSxilaxTRocos7GeD1rUaeLggxp7P3F+7hFxlsa51E++A
         R2HA==
X-Gm-Message-State: AFuF++kVVcr8y1Kw9B7Mzt98l5qv+rQZs6KfP1C6mzHs5zUzDhglmPr6
	FjpDAMiuQD/Om3wV3rq9LP1NQm5VOI6AzJqgtf2MKEW3mejlxw9oZ9jSrWCOAS1f
X-Gm-Gg: AYBFou26uACIuPAi/rCTgRrSDsj9CPo8szT95peK5NPbMZ20yMrvT21dKVou7Btp61L
	8hZkZ0Pjn88B6T+1TnTd7WXYG8QDGlMIC9g25r87rqcqWLHpazL+j6d5X+jtNeGu93GivIOJYvm
	Gzn2JndDjTZcvuN1j6zBEwoNEmWUDv0xgkHEGBWRAVr9Z1aagQDrpr3pv8h6hkjBJab9Yv21+BZ
	Pjf8uwRuUNzqUq8DyGTcU/Z1k3W5esYZuuPCUw4K7uviZIn3XczP+HAMHvDHhb+eFt8EUg/nAh9
	yfvG/KUOIs+WsfwFtzjTzRSTDQ5ggYe5ZMhsoBnjdgTmio9Q8SiemZy0/hMZ/Gg376I5V3LDG64
	/2zIpC12OZB73Q6VLMSJQhrg+fQVKeXkB2DohfEy1yeyDsQLxnI++At28gyM84Rssvhpa0v8ZaD
	7SMvGe6+rJk7aWejij72611oEuFfY9wbO3bOIIrplB5hwRRcMxhH0e3mkaHIzAjYC7sjJaMpv4c
	/SZurdpAatvBWqE7iM5FJByuGWhUNR4DzWe/wjQFnmMrk/LXlcz/I00qfcLJlXp3yGxWBBKINsw
	flxXn1YB2PEmR1OW/aRIcpZE8HZeJNcnZ+PSog==
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr53358025e9.3.1790269072429;
        Thu, 24 Sep 2026 09:57:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cc9a37sm91467755e9.11.2026.09.24.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 06/18] bpf: Treat unknown-size stack reads as reaching the frame top
Date: Thu, 24 Sep 2026 18:57:07 +0200
Message-ID: <20260924165740.2146806-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=memxor@gmail.com; h=from:subject; bh=TAE5cDK+wPaS/4IERiR+DYXb4uRNzHshBUfgiFnuRfk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraIF67BlOFTEVebFjdz0VP+/OKJopkRWiH9OcNZttx tWXipM6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJG2b4wMD25fPtLy6L4ZB9vR 5k7DzU9K87+XuAWZsN/d9Ond+qPrTzEyNM5h65Rv5a8MXBW9+9Xdlp+XLvhw9puU8qdNm2758lE lIwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When the size of a helper or kfunc memory argument is not a constant on
the path, the stack liveness analysis is told the call reads
MAX_BPF_STACK bytes starting at the pointer's offset. Clipped at the
top of the frame this covers everything from the offset upwards, which
is the intent, but only as long as no frame is deeper than
MAX_BPF_STACK bytes.

Return the "unknown" marker instead, which the liveness analysis already
turns into a read of every slot between the offset and the frame top,
independent of how deep the frame is.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b87cb9beea0..a7b1142b0d51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14385,11 +14385,11 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			}
 			/*
 			 * Size arg is const on each path but differs across merged
-			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
+			 * paths. Reads may extend anywhere up to the frame top.
 			 */
 			if (full_write)
 				return 0;
-			return MAX_BPF_STACK;
+			return S64_MIN;
 		}
 		return S64_MIN;
 	case ARG_PTR_TO_DYNPTR:
@@ -14475,7 +14475,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 			size = (s64)aux->const_reg_vals[size_reg];
 			goto out;
 		}
-		return MAX_BPF_STACK;
+		/* Unknown size: the read may extend anywhere up to the frame top. */
+		return S64_MIN;
 	}
 
 	/* fixed-size pointed-to type: resolve via BTF */
-- 
2.53.0

