Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9E566C6A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190723; cv=none; b=s9cgam1YO1duQhZSlSw1D8zWc7vHypv25fE+aIvb/GGTpJjUT5xeYvfBuB5iNFED9W1H+1LwhZEtmR1UAMrKqkRLvsYSM3XF6YdqFkWmBrtc2hnoO/b/kcn2ik/XJR8GvHGjlFmObRoz+lIpLQmKeRPgdKaD20uSKiMiT7PqnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190723; c=relaxed/simple;
	bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY8u7ptj6OH3X1zpv07FJmAzmzs8cD0ztAyLpV+jaBE8jgAVQJgc37kO8y/BzlPf7Bddh3Z06HY96vtJW1a5oIU55Izc6kjvb2gJpvaJsgPcPQcT4pB0bQ4HI7VBZBlxTv3dut0pvnE5LQESBTojchttE6GJzruwXMyhJeSRiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZCGlj/x; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZCGlj/x"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so6522435e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190721; x=1790795521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=ZZCGlj/xhWT4Wuhqt39AOkqO6yp1jbgwsUhNgTQZ4Ter0g/qqJFbk1/h8BcbHFe7pQ
         v5+T8tnl4Pwc39vJUoQ/j+Io2XSK8PtQAjkRo83UO7FJPtenZ8XysCcFDZWm11Un1PUK
         gj3W4KxiedBvFrAcKOlKmKrqwWwBGTXrzMuK3dt/bA3BHPmd+Z+vFk8lAToKYz4AmTs2
         WtUMoNKt5X+nmMptRmvcCwLEETW9z/HjJt3n9Q3fdXmN+cqvQXMaNScrtkrSVK+fET6d
         LN9qXa60hrqqfo+uTedFJnFS2mcFegaE6fNlGGtnjX/3y+jG7+kBOkZz8VLyHzPE05KF
         mzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190721; x=1790795521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=xeGGjEBDjmq9LAbwJiwftxa3QQayU98kqvekzoN87M5qjT204gWdMsDCvltTvm9ahI
         KxgVjqoK0kIOlvF7NqOazZUwc1BIjbVvHgz1w+l/32jkwt9GAxKyK6rF0z/3uGhAwWz5
         CxaX07blEXJtiTyRp4Lun6NILFm9e3lJqlKkOZcw6nw2AFr0Wg7TCaWQK64BrpNepd85
         JCEiRPmjPrQN9H6ZldZjZpODvxOfLVyag0CkraqM3pcKiT1VPdVIGX6fWqI9dGDdBvCR
         fdl/g7OlGhCOKOUrmcAWVn4EqtYFnkzf7QBuPPJ9YO9NQkyJVitA+7OgaFSOMuf9VcEW
         DeBg==
X-Gm-Message-State: AFuF++kQeCS4ZSAAjuuSfPVeHmNnEV8BRrUKxIoOIt+K48qq50maYHrU
	m0/7tb4tuqMOEEzl/VBwJSes+lj2JpE+QGKHR17McdRi9DxmukLyYYMAKOr0NgCQ
X-Gm-Gg: AYBFou2iV1udrvdgTyt08jRAYfr27YeT6TG0DSG8FT3RmuaSs5GD3qh/4FNdG8tVZfw
	Ny6Um5T0H9akUUysPgEzvKi3lKZ0fiUH12NHIxdACJfM3uojYN96JKSOmrYBI6/a22qwiRu3nq1
	QnRqtPXqdJpc9BHEM4r6edGBprRHZAEuicPPVD8Uew6UMcrc1gG3yHrX1qLNEIQjY2J48TyPytJ
	CIzNZJ7/yjOusAIDj9mwvgmpKzPLLVj0NtVrNLi75uyyFN0Nv/QZK+NDnLskK4JvSfcRlXAnzzd
	K8PF2LzEYcMDgqcwtgXLnSWS5EEDnwc1CD65qQjlsKoJwTA9vAiEkethrvyaGMgJ9MsPihPPgVH
	qWtRxFP7CtOqr8LLKavga4KIPVTKIaDlq4LWcN773hXQVoyuMO0xcxKwKUJUzR12ucKTozasm1I
	J4f575AuEMEIFK20bd3OSzv8vw+8qSMz5deugQv7wKnA2ERIUu3St8uT4VwHlO1tyxv6n5pxosd
	AficWwv1mW3/rc9HuzLbtsw00xjM08+x3WSWtBe/S5NadgB9xsBPTTfHxsnTy7Lhbi2KdP/BWli
	E1oktUB+KrR7SeQyujnRGK0ULwGkKI/yDVjSZ5idZ6c2yreD
X-Received: by 2002:a05:600c:1547:b0:49d:15f8:2bdb with SMTP id 5b1f17b1804b1-49fe66ab956mr3341395e9.7.1790190720462;
        Wed, 23 Sep 2026 12:12:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cca160sm6914585e9.12.2026.09.23.12.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 10/18] selftests/bpf: Check that narrow stack stores define no slot
Date: Wed, 23 Sep 2026 21:11:17 +0200
Message-ID: <20260923191139.2816206-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=memxor@gmail.com; h=from:subject; bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4rfLNgd5zu6fx/b8Wf6h5cZBfizyx57qr17Rl3Vlb bjXsZ71HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIGgsjwyG3jc5lvo3OcdLH JS4um8OvK9ltvnSjivH8HJWufZ13xBgZJpn0sMmoZsbN29BSe1DviXxK3UKTnrtGc6VnnjvH+CO LAQA=
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

