Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F747F761
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446692; cv=none; b=BKnSo3EHWS3zTEdCOUQgWvNGTJ0ta71gBuX1AQdmxgND9OSAm25c6MTinEh/UAIYXW1xyod8JM37tuhoDw2EvMOIkLKoMs0wv2/O+dyRbJ9+p4BD21JbxGz74ks4N/bYqpErPwflQcF+k9iNa/aguzBcGqtgJF/7hsC89Sl3vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446692; c=relaxed/simple;
	bh=N8vxHa417heLzyAHn5WFdm9t8sqkhfIH7fFya7kODho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R27M6dG2EsuVn9p5ugdbXc72sX/Hj1JE5gBINdTFcZWNh5eH72KHubotEya5zQadP6n5gb+Y6D5hjVkFR1Ndwq0T3ZjG4sojgoV8L0A5vy+IEUOIKIV4B3Xk5p4dausMqHN18OL8ttmJzMzRURZ1d+5d2E8Eaot8apq5zPFX6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl4DvIM1; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl4DvIM1"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482e067ec96so522909f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446688; x=1789051488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4o6pQe/L6GLhRRiAvEQslb0hHfItqSuJpIDo/rk0c04=;
        b=Jl4DvIM1CE1rzzENSVfFGCnsHtpMPHulRXDQH1o+CW5lxOLgOBLKszpKdhL1SgMCKC
         drt07oNTqm3OJGa9NYOpr8vkYUYUHFwcL+ge6ldr+78EbhcB50/XY2uhTISy+Td/14GR
         dGgrTzc0qM2sjfEgX6SasbHnNVNuyZd9qPXuHk0gYm31DFq5abAK4qx80s+aOosoLnX6
         7n8PaX5YIfOk/7yLkK/OuAA/cknpYPX4Zg+XLPfkSGyLKVrdBINxccPXBcbnKSqDSO4M
         vPoglO38bicP4cDyWOqXvnJyucU67DYBUkxfbsvRmfgZ5pr1uvBMKWkjxodmVVDMk83C
         G8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446688; x=1789051488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4o6pQe/L6GLhRRiAvEQslb0hHfItqSuJpIDo/rk0c04=;
        b=IuVlayyJfMKEvBGkNoLwTD2e81G+2uqvoc0ZGpC6VcF7nrge3nRgxl5hs+0+J0hHZc
         avXpaGq6oXtMIGHUmX4RSrmONBN0uR8krtYxaqMmBUT6cX2Hbp2czg0z7su6CCsn9ccb
         rUvKMWxmbB82x0tdGbwDwpGKkQ1v4PCbxaNkv3hYnvv+/lPvu30UB6n55OsIHiemoKas
         NOz4Wwzsr+7KlMUcjt0Y5BCh20vjgMpkOZfcumGYzMbk5r/k7Qa6E4Q1lqoAK1QhvjQz
         Z+L0vKQ0tS02UIct4xwqO87COhgnX4G7Y/tl4JpDPulW6bJNZs5Ea/igwC7/yQkj9XYn
         VENg==
X-Gm-Message-State: AFuF++nCTaMzZur0SaAId8ZfQp2q9gfUjcTQ8JHi0eqTUqpCYS3xxCQf
	tiw3N1uIHPXP0Et6mBP2nCNCWYEQzK6DlED9NZdrjGWKFKrL21JvMSIovJlRJ1WB
X-Gm-Gg: AYBFou2I8mSvqEafWCZv+Js22k58fieoCiSssudulk0CJAD0JCO6CtOgYrmbWrzw0vP
	xevKel3Bnb62B5TUE62B3Ie9yi7Vp4ZDoral1QBEf831kQEsrGEd9dsDK+FNOxFR1/9sVk1OP4f
	f/GSUgRfe6Q7lIekf02R2N+5pvklTo/oQdzOzgDz79IaA3sfwf6oLdHmZ1NV4GstJh8Nt9vTflw
	i4f1Ylqa/GilC/Lhgt+SINwObmNIsWGis+x8r2u1kv/8uCkCZy8BwEogH2uZIXSNuxej7jsUQcN
	kinfLCo72MdZnhk5BNXGo2XMqwj3raQjEffKUN90LRtlWwu3dToN2gldaDG7AAnMPWwmKEhdgPt
	qf1YvU+IWuOFNsPC6QejF5r6mCMNkHWwjB7osmpN0vBgbjZHou7CwEQ0ZfLpR3dlKNApwoRHt8w
	I9PUwLUSXzda/OsdL7z5Gik/V2aC340VNW9/0FN0tO5IfI1abSw7YOsxQqAKycAh9dl9z/IZk+h
	Kv+rY2IhBM7CFyKoEjwMHaapA9v67kmjl4MujdJSRcZi+joyopmU10kpyTeVTCvS23SMOrQR81v
	WAWJatov+pa3
X-Received: by 2002:a5d:588f:0:b0:482:e707:f5e8 with SMTP id ffacd0b85a97d-48488f02926mr22864300f8f.10.1788446687669;
        Thu, 03 Sep 2026 07:44:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72df2sm15057192f8f.1.2026.09.03.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 07/10] bpf: Mark sched_process_wait argument as nullable
Date: Thu,  3 Sep 2026 16:44:25 +0200
Message-ID: <20260903144433.1716731-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=memxor@gmail.com; h=from:subject; bh=N8vxHa417heLzyAHn5WFdm9t8sqkhfIH7fFya7kODho=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm88Qpe68Xi1mvvxu0Z+Us4ZIT5qc+uU8M8VrQaKbka P93/yzPjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzELZOR4UTvTO8D957siM9w PNL/cLeQe2rLxD9T+4WZ9A/KvjFPymZkeHLwz8m7CY9V/oubfL44fU3e2+bse3NNDAMVzspsulT vzgQA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

do_wait() passes wo->wo_pid to the sched_process_wait tracepoint.
kernel_wait4() leaves wo_pid NULL for wait4(-1), and
kernel_waitid_prepare() does likewise for waitid(P_ALL).

btf_ctx_access() currently types argument 0 as PTR_TO_BTF_ID |
PTR_TRUSTED. Without PTR_MAYBE_NULL, the verifier accepts an unchecked
dereference. Trusted pointer loads have no fault protection, so a wait for
any child can then cause a NULL pointer dereference in JITed BPF code.

Add sched_process_wait to raw_tp_null_args[] with argument 0 marked
nullable. The verifier rejects an unchecked dereference while preserving
access after the program checks the pointer for NULL.

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d6d243c262ea..41764356d2d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6657,6 +6657,10 @@ struct bpf_raw_tp_null_args {
 static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* sched */
 	{ "sched_pi_setprio", 0x10 },
+	/*
+	 * do_wait() passes NULL for wait4(-1) and waitid(P_ALL).
+	 */
+	{ "sched_process_wait", 0x1 },
 	/* ... from sched_numa_pair_template event class */
 	{ "sched_stick_numa", 0x100 },
 	{ "sched_swap_numa", 0x100 },
-- 
2.53.0

