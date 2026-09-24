Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348A4AA57E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269082; cv=none; b=o1llHvyBUWxTFm884Otj/PwBo6DLZVuaOnpb/hZxh98013hTQDoT0jCWBrlOqRP5Na/UJ2KF0LMAPIdnlPrRqf2s6C5x/fUBBli7H3K787MXVdmlJDbmiau7WX0gQdlPwaTx90VaZO5Jrbfjpv9nAxxgGX6NHadKzYtQmhOd+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269082; c=relaxed/simple;
	bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjIW6os8Fq8GInaGYFthIAX8dCFfyk0wfoWCwGYl+fAo33PX2O6oVKn0L1p2HzjlDe1LWM7yw8Qt4xdrdX3qO0SM0AWG8/d8DxCxYiv1hc6Sy/Taa5xCpY89R0C0XZ2uVBGdoLV5bZy+7C9LkC4/L+qryEWM/aX9ZfCFfLqwrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4y5JPDh; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4y5JPDh"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e7f43f439so19635e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269079; x=1790873879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=R4y5JPDhTJob6rGRYbd7wNyV/MX/P7BmeRbFAqddwBGWFtbfa7K1pPh12VmDFcPlEm
         3IYN3CyQ3RBH+ski/3gQ5RvD23dIMvULehejLSUz1K/NQTCBq6cQe1uEadGHV8bvj7FN
         Hi05bnVJeV0n8aWFR7q8NauV89/Z3D76MbslMhalCrc/Z4EuZbSL+KIGTVVZslu8tFIQ
         bfWhvebnlqVCUTk5ZnCblNjMudkad8M89+6zKzBUyyW6+NmPAM49Xp3zszfjMOv/hqlf
         fqoZM3h7xMio8+ecKqw7vSIzY9knblEHpHeo7NcNcsG2noKN3S4+WGnyMkLtvtia+IFm
         5gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269079; x=1790873879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=b4KuJP9Ee2Sa10d/04yZ+GCaCh4Bu2U+JNqqPQV54A0C0VjbBpchqlxN+zSdR3AbBd
         YPMAa4kiI46VX848lHJ5C+Lz7hq9btrFnKqusEnYVLgsbv4h/yEJew4CLSiLemFOvZVy
         KROe39ueJfCNO1YWZzDlPZYylRe80/K23tjQREVqVUYvCiP29kDiZKRleoNqRsUZMPHg
         r4y7x8wLgLP904G5ozJ4pxsMy6ZIRKiK3M72WSgADphy4gAXPPbScA/QL9vr8B59fcYO
         No90NmsHiGLze2tHZY2gCFSSSemglIX+D7HJea/YXvXXriY4PceCznuIDd1rYVL2d5e5
         A+dg==
X-Gm-Message-State: AFuF++l7RPHTw5JCgmEbUHpQCWXIgoguuTNkgUFUYD1l0a2yDUsQx63X
	3OVxlv6p+OWkuZDRy9vP+HMorwe0sf4h4qgCR6fOKn06/IXV5pv9EI4ZANJHZT64
X-Gm-Gg: AYBFou2zTMde2EOMduDdtbpAZAd0IoAw7pyg5f7LwznOnMkUWpodHqd7MYkIR+Nr8UT
	ALVBZggzQe+BeF5aJwpnrumJwEGKa/U248ESmLlVdlTIszUoEBgEXOpy7gqW9Ss3PpMrdSKVsrI
	lUbqAqCSdiPO7QTSQMOH8YvwQsCH6C7DuFLJnO/x+ILtQx3n175xx8eNuEMQhQ8cCbtla9/cKmK
	yO46mXl9jziV3llSYNOs0ufUXWnViQE2zr21vwXtxpyOCI1O44dVCkWodIccvhqPZjiZRSGa/sX
	xPsAYz1AyTaLOxzURjToKWpsQux1HCPbcpMnFFtLORqk2KRlvk3+6mku0/42SnuMIudAQ7bbvXT
	Hu0Xywcl2dNNKRi2u8ilrfjUhMbwaP71AT1n2P/eg0GLE9U7q3QaDvQtP0OHOSErdrsjr8UReu6
	CIqi7dX3s8qMyWucwQ1rwd3VrjStxIFLBDDQvm/slBZ3J3Al5lBgezhPBZDxZfBBuf6mqGHb8RK
	gL3MWkYxnpJ6qOVEqmn9k1DhZfEykg+pc5b+nAIEnVT23oLd4V8DlvvxK8+i93cT69xxJ7dLzwb
	qDXUROnqFHUGGQCmxK+Ktzvu4fKafKmUdkW34w==
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fe66ca6f5mr60565335e9.0.1790269079282;
        Thu, 24 Sep 2026 09:57:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ce793sm2078445e9.2.2026.09.24.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/18] selftests/bpf: Check that narrow stack stores define no slot
Date: Thu, 24 Sep 2026 18:57:11 +0200
Message-ID: <20260924165740.2146806-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=memxor@gmail.com; h=from:subject; bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraOFlm4M8Z/fPY3v+LP/QcuMgPxb5Y0/1V6/oy7qyN tzrWM/6jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExE5RUjw8yjb1ZUKWl79xz9 kiZTknX0Jucv3g13ylcyb5w5z/zHA0lGhin+zN58/9fz1tfNeye+5Msk1Y9fPs490Kl1voWhRqN IjRMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The stack liveness analysis records a store as a "def" only for the
4-byte half-slots it covers completely, so a one or two byte store near
the top of the frame must not define anything. Add a test that reads
fp-8, stores one byte at fp-1 and two bytes at fp-4, and reads fp-8
again, expecting no def mark on either store and the second read to
still use fp-8.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 7a1a0670f851..f8758eb62dac 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2839,3 +2839,25 @@ static __used __naked void imprecise_dst_spill_join_sub(void)
 	:: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
+
+/*
+ * A store that does not fully cover a 4-byte half-slot defines nothing, so a
+ * narrow store at the top of the frame must not turn any slot into a "def",
+ * least of all every slot of the frame: the earlier data at fp-8 stays live.
+ */
+SEC("socket")
+__log_level(2)
+__msg("0: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__msg("1: (73) *(u8 *)(r10 -1) = r0{{$}}")
+__msg("2: (6b) *(u16 *)(r10 -4) = r0{{$}}")
+__msg("3: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__naked void narrow_store_defines_nothing(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r10 - 8);"
+	"*(u8 *)(r10 - 1) = r0;"
+	"*(u16 *)(r10 - 4) = r0;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
-- 
2.53.0

