Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF54393DE6
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845490; cv=none; b=X4MROKZMz0chv1Bl4Eii+b4JbDcMF8apFtPVnO1MvvaN4JZDDJNv8MfJx809RAbGu+Yk6F2f4Ei3ni8kBBQhIbZqzLrewTt1xsTy+n+gldBw6T6fBwxlsHyri9Qy7dVd01cXwvOmMQpHJtpidKpEDDz8bgnoH/0GPu4J2xDrmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845490; c=relaxed/simple;
	bh=KzyNSZ9rOd2MKc8yoYe7OOilaLm6Y1dAOpsoTa78euE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpVRbrMOcLz32L6f2JQPs3KO3BAYI48YHXNZamTBC4i27NXsFAlv5obQTWXmSsACmudCtmcWT/E/4ANFObcOWEQJ39EeycrvBynPx+g34Pr3uKnMhZUVQVU4cJA7B1PBDXBNO/79S73FbGms1ZnaWRz5vvSmoZ+2aoSkx+mUsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7bNrm0u; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7bNrm0u"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4994d67d2e7so5361215e9.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845487; x=1787450287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tx01O+GghgJhj0JWo4zSNdSVeQik1DVpPY90dll1r0Y=;
        b=A7bNrm0uynpyHwMEgQXYs9Fz4mcpDHbH7eSPbNNXPsLAxtDCY6vslcxNalF7Z3wyiN
         f8lBp4z3SsJ3HQCdETXniDFAAnBAIfVBtrTlIiezr6u5oVfxWA23j0vs/klqACs57t7U
         SMsDl9SHYY458zIZsdlTIZZGJiNIFsu2MwtZX/DIhjFAs7Y4Wj1z7Ro2AK4bvZsfDJxJ
         b3lKgUDCuoCk47lSToedMrO/DbvNYm2Eqkyan7ZaPlbw9OUJEqWqLpUrobDKEZFcMoBd
         jJVqNK+1C1CvezyH3s+CSFFJ1i7EfUZSf74cL7XEfSsxBTCj6Xa1mndEA+dPP4DGAbsz
         bTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845487; x=1787450287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tx01O+GghgJhj0JWo4zSNdSVeQik1DVpPY90dll1r0Y=;
        b=ULHrZ33s6NWyYyJOpMpEQI884rsH2RDPGn9oXjjNXmc+LvBSf+7YtN16KmPFKjd9Em
         mL07uItZY7gCU2l6r9RjPBP69PHM61H8Mq5gQ3F+qEltpu8+0mQUFX8sxYt64Jl+ugvZ
         E0rfDryKILTqbn2oDuR7W3UiK9b4GV3TrVcKLmdNfFRweWsgIBL/eZam/9efUcRkipOO
         /uRfjAi1MTQAEnb4l2qgd2/qItLceBrrNiRFTIIiVSFb3eoLoYaTgsbQj0ZtsW5Wlww+
         doq/jGykZrzRvS0E47TLkBW/hRGsWz8VhdWAGtD2uLpz/+O1buRGe/FTRzMZrdBku6+2
         sHAA==
X-Gm-Message-State: AOJu0Yx/d9eXnLR6+JhR7VkKAapW7AVMgpON6NJSHVPWboGyfC5l7Jyu
	sDpFUX8Sv7mve02jesvtPEqm/JzBMWVLUp/AgBQKdEprmM/a/2JUtlUPFfK6OS6o
X-Gm-Gg: AR+sD13y6sDEib9n/czZOpUjXU3hMwAL4PEEVQ0sP577NEJ1+Arjx9wYLBSSYtIF16q
	EnYe1Yv6/P/bbEuGCbXwlbtdvD7KgQKM3+gb3cH+f596fiq1Yq7N1Kc/9hjXuz8fYRH1Ach/RLr
	FBm7vcM86xgz0wbkN9kgjfdovsXiaAARn7+hZklxPLuGvj5tKRAvhWX6/wGINlzbOUY74kMcoVw
	uMZt8huEyph/f5PLKmTTd9t5vdVpZYs428XjH4dRFxRrm0YKgRTySdI+PWZLTmaXSYuH6ndRGWD
	KRhII4ZHNytruwj1YSEE8mzbcjQ4RmY6F2nSfosaQwKKfTfi0va5jZJqaxp5Dl3CQU/p1iZURmc
	17MKxHl8+LYB5vn6l6H3Nfk0vhqjclguXENWQKd0BwIBCZHNGEq/Dbc2xGB7SCpGan4VuFSnyYg
	+I/EIeB+sT8xDXIiPsdx/RhvnSCNpi63B8FggmXSr2H/i9vVlmyS5hrWbuCT1HZnxSbJrHe/U2W
	ecNX7fotV/mhHM0JBTxmP8H5zdb4EWFQ2BhX9oEQnwCrm/Y4c4Y31uf3xh+tp//IAJ0QzlJsy1J
	sqXCZDYnQ2U/XNu6YpfYSul8J+s=
X-Received: by 2002:a05:600c:1d0e:b0:495:7888:281c with SMTP id 5b1f17b1804b1-499878cd5bcmr219352035e9.0.1786845487098;
        Sat, 15 Aug 2026 18:58:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm7095275e9.13.2026.08.15.18.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:58:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 14/14] selftests/bpf: Test pseudo-function policy diagnostics
Date: Sun, 16 Aug 2026 03:57:42 +0200
Message-ID: <20260816015746.2632990-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=memxor@gmail.com; h=from:subject; bh=KzyNSZ9rOd2MKc8yoYe7OOilaLm6Y1dAOpsoTa78euE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQnLyjjX/P/Gc2JE7Sd50L+9n5Vkt0VnrIuTkPU5NY DjvXPmgo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNhsmH4p7bVSdPhz8q6tiY5 liyxBXonuY2iVujaM93YKZt47ZONKyPDieZDXGl3rGe1B9r0XVr9o7Ki/+iDN7Wl4hlLOoQPc59 hBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Load a socket-filter program that passes a callback to bpf_loop() without
making a BPF-to-BPF call. Verify that the privileged load succeeds and the
unprivileged Policy report identifies the BPF function reference at its
ldimm64 instruction.

Also reject the inaccurate BPF-to-BPF call wording in the portion of the log
covered by the structured report.

Link: https://lore.kernel.org/bpf/d02e6a6d3b2dc43a207b8ba836ce62497b250dede9252e7409c5212201c794b7@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_unpriv.c      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 42de5cff7e52..3069e70fbcbd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -96,6 +96,24 @@ __naked void pseudo_btf_id_log_masks_address(void)
 	: __clobber_all);
 }
 
+static int pseudo_func_callback(__u32 index, void *ctx)
+{
+	return 0;
+}
+
+SEC("socket")
+__description("unpriv: pseudo function policy diagnostic")
+__success __failure_unpriv
+__msg_unpriv("loading/calling other bpf or kernel functions")
+__not_msg_unpriv("BPF-to-BPF function call")
+__msg_unpriv("policy check failed for BPF function reference")
+__msg_unpriv("avoid BPF function references in unprivileged")
+int unpriv_pseudo_func_policy(void *ctx)
+{
+	bpf_loop(1, pseudo_func_callback, NULL, 0);
+	return 0;
+}
+
 SEC("socket")
 __description("unpriv: return pointer")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.53.0

