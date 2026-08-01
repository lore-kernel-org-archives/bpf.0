Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B73CBE66
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625448; cv=none; b=JR3OW6xdyj5kzjPXSmIBsc6m9zckeYzy3RewlaRYDdGlrJapTS24MRhyahxIFuQvz8chjfeSR7a+BcTxVon5JUKB+mj6RUxnRZLNRvuhDm/L76V7dXUczSkhMojDHRZwAkq219U7HuKWO7AnwbSfusejwX+u26GtEyagXaQdNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625448; c=relaxed/simple;
	bh=Erq5Ipp+j+lJCQ2KIhfIe38Wn1FE8fJw/51n1nwJ36o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFeTUdnabdtDWbeiC25GV+OtsdDJWU/y22EqkSEBOM1wek80wz7TxJ5Sc6braDcmhctkpR54nLpIaMI33rPlSiFuQjVeXc/DCpsWvewb3a4cQodI49C4xfi7Bd/q4owRUDbP2qqK58ApXntkDanWu+zaSuIL05OdDtV/7t8zhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLUlKhH9; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLUlKhH9"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso701188f8f.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785625445; x=1786230245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5mU9car1S/MNLYzNXU4pp8Cd+dEMuhaasbfd4qaidA=;
        b=HLUlKhH9mUq4x/WJ3c/xY4KIZrG0TGxtYyL3CQGDhmHT6LL3Lel3cozm3GszmjQAY9
         IC5Mp1UCpcPkDxzC3GldEKRybxyRuSDwPJ5jffU6SM42pGGxmqCe3nevAIv9sZcbmBr/
         Dz3BvzolRSUGkxFFUDR2bm4fRIJ2cN7CXvifMPrz3j4Y3mc4/UDNjkO0dFFtfTf9QLms
         gymi1CAgaCvc6ODscY3JtRYLOYxuQFbJF1Vnk1Cso2INWxG9B0PC/bctcasWyCsfVswz
         Tr5AYtYGofzolDfgIJtfgEDBPVTpUeDxue1Dl7vuOuuFgs1D0zewQBtZbU6VsQ9s6nov
         fpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785625445; x=1786230245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5mU9car1S/MNLYzNXU4pp8Cd+dEMuhaasbfd4qaidA=;
        b=aMPlbQOrjvt4DWO2m/2tTGzvSKjfxDYmtPD0ep5eU6q0tnkVXll9RMpnZ/P4OibZ3/
         b9jYB1y5t+qd5G/siDcAEWg5IYaxjrNmm5SaIXmql+tfD+A2yNRJqYiuathdMPqzzMMy
         c/HZiX5sko3LKwrbFCzoFSTqXnDC9CDwenf4ptzG49mymqn2BHv6gDi5t37EvODm5S2R
         xFkT15rF+hN4TaE4IRoDmWzkIZ0+fdBylV8FkSJU0eEfWLxuPOY0TW6rnd1j5l7OhPFa
         sD/WMWyj86KxRhPWCOeSvg1p+L6inrHHMd6ouwBUNrJKLQd1FpFZUCRXMjd119Z8hMuH
         RjnA==
X-Gm-Message-State: AOJu0YwU4wCDJZvqUzcuR2Yc14UC4PVrdIOYqppIng9Jw+keaWGVWZgH
	61oEvx2dIffF90637g2/xdnmrVs3kOyysWymn0X/9PbAeandMvkmBOYQpRFvnGLV
X-Gm-Gg: AR+sD13cNlZcgW9lTX0pc6lfzUZo5udHpuMOg8Y4GQClM8Y+TD/p7By/ufDDAuQvPp8
	00YFEOaDApWamOEiaoajxcbpGzjB0BDhC+D3cg6oA+bIKjVu/GEY2AWA2hSxVkOg5vfVQ2lxkv5
	G8eDToih9eHsXvY711bzTNEcR8TO0Z9ea/XhX8w6fZUXKtv2dj35gLkkGnDnta3l1LoQHnSJ2O7
	SDaRs3kFDtbAquYyx65agX8+2++nyngaReveGipK0EtqX/nA6x7UOeW24XH77Ncq5neLZchPw4t
	aGWl+LNNShj6eiOhdwyD1zCWhYI/6Xrh9+IxDEsZ/mcB4sqHTdDOkIsP54rYt1QoxOe5uPAqd2G
	tupS9WyybfKpIgmKq/DvKVaB8Iwv1dL+dRFN1iNlmMBqDWXyrjvHhipyHSNWjDjVgoACU8KgcHW
	Rp9ETaXDPNon8btIXvPnUPEsPHExMmXb3q7wXicK84z0Witlb7nloEhfl34t4IUbNRadwFvO2CU
	tBzALu3VqnvMG7QFbtePKzj4DRYySVLfbk0BbvRjEmpVqVJK2Idl7Kz14kxLP4txQ0LMXPXXaT5
	NdKds24To6Rq+fhmaPx/1zA60N5/2D2XG6AhBg==
X-Received: by 2002:a05:6000:60f:b0:47f:8112:f793 with SMTP id ffacd0b85a97d-47fd72b5cd7mr11152136f8f.13.1785625444993;
        Sat, 01 Aug 2026 16:04:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d17f2sm22295043f8f.2.2026.08.01.16.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 16:04:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Sun,  2 Aug 2026 01:03:58 +0200
Message-ID: <20260801230400.850271-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801230400.850271-1-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=memxor@gmail.com; h=from:subject; bh=Erq5Ipp+j+lJCQ2KIhfIe38Wn1FE8fJw/51n1nwJ36o=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuvqvPksmahaeW6/T/bfswzXHTdN/bpHpMrhTalvivjT C7bX+zpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQCvzEy7JRbebKuxS7tq92q mqId756tfPrj5S6pE9ZfPG+t0lnzMIvhv6NUYJG5g0Tiy7CM+54Nhc+Y281i/llJppj82Hl045K /7AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the case where we don't supply names for the subprogs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  | 5 ++++-
 tools/testing/selftests/bpf/verifier/calls.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..61f0b2951bcd 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -133,6 +133,7 @@ struct bpf_test {
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t insn_processed;
+	uint32_t log_level;
 	int prog_len;
 	enum {
 		UNDEF,
@@ -1559,7 +1560,9 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		       test->errstr_unpriv : test->errstr;
 
 	opts.expected_attach_type = test->expected_attach_type;
-	if (expected_ret == VERBOSE_ACCEPT)
+	if (test->log_level)
+		opts.log_level = test->log_level;
+	else if (expected_ret == VERBOSE_ACCEPT)
 		opts.log_level = 2;
 	else if (verbose)
 		opts.log_level = verif_log_level | 4; /* force stats */
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 302d712e0d7e..1f7ca271e07a 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,9 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth subprog[0]=32 subprog[1]=256 subprog[2]=64 max=352",
+	.log_level = DEFAULT_LIBBPF_LOG_LEVEL,
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

