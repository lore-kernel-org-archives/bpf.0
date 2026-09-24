Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763453A1A58
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242192; cv=none; b=SDC/yNAzGiqxxj/K1YDsob9W/T5BqT0htDK8gqef/NBkFt9wd9CjpDHSjWsZetUtk4JvR0aBAizN5bF+dt5K/xgriTBnxHPF7VDEGGdUJHpQR+CJce1SWO1tLU2aUAnV/mi3ruUEmJ4t5fo87uI86ppIYpUP7fMg+rydR0b61tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242192; c=relaxed/simple;
	bh=+j8tjysSebyQiEKsSaaHGJKB861gN0qzOSXYqdtBPi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2A8Lgk7f7l8d37gqHmL54f1OorFEof151LLjXAkMla2i9pylonVSHC01L0Uc6e9Jl6OOwSSV5KV/uq+HQ7pRM39+J/zf4FG600kJ4xj24kIQcfoH2Cye4gX7yH2St/6NKuDF0NR+QqwpmCDGz4oEBLehBAVWvzOJRYa8v1sA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivqy6nS9; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivqy6nS9"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe8bf90c9so846825e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242188; x=1790846988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoiU00rV+S0xqnX0Qa+m79O1j8hVwxZkiSNaqTY6Z/A=;
        b=ivqy6nS9AAQK8WlV1bBL1wKWqkGhDBxmLaJjs/o87eJ++PmYvA0fW7M+478cIORCcx
         nPGUQRzieVznTJyOk+7ijXoeeQZXRJLIkHcaULoCbgDQ9mEWzQ9grbJLsFUE+BlyTyKc
         zQ/7BKzbll5HTsVfDD7DNfXq/8x9DYd3Ft1rDiA+aHJ+R62b9429zFg1XCzXt2hbw4VW
         u9eBjtm6ixLQ4XeR4pmckWEJxzTpSkr4DaCWqwVCf2Om18Br18Ej0W+9/Yf+xWJ5VDSU
         HOK9jUrAi6/KNnJQkOe42w6yWWPz+VCs6IRfubYtQoMwR0ZrNBlF2afCsz9g2NSzy6R3
         DgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242188; x=1790846988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoiU00rV+S0xqnX0Qa+m79O1j8hVwxZkiSNaqTY6Z/A=;
        b=QD86XrvbvKLPeTRxMCz0x9VofivwSCKuvm1Nfi2nfOlRV5xk1EeBCKSK4P/Xze3oOb
         hXTB3kM3rs5kmqx+QX68I0A8glQJpzCqPjQQsl4osqn9HWN9KUUvJsMLWhbC7UkLkEmk
         itQ8AI5Ipyh4rvVTP5F6UL6c012dwAM/dDk9c3wRtmQJkgVkbe+bMrCEycPBHl7eWRTP
         8/dhWArbH9S8p6EjfbUp7a+xtgemVYr9btIvNHQX3xw15b+a/3vuO0RxdMkSj5B1Hvon
         1rHQSy9P3aOVGe2+c/ItPbNwucK1GiIvf+UZ/eYyxhmOw4IKsfDcIzFB1qD0wT4RqFDn
         +O2A==
X-Gm-Message-State: AFuF++kocAWSyiXlhN1ki1/PGiTwJqbWbcwsVGV0EOwZWae9ETfIDfqL
	thZrSxS6+0DK6amBXAW0FrPTuwRrhaJQYpiy5Qhs93BRJGBPSFgr/CHqwCVs3YZ0
X-Gm-Gg: AYBFou35KYOHx9fMSoVj1VXhwrUswdmwMSfsuU0DhnHpYJd1Nk7Mupv9WXYJMQBYTFZ
	PO0KVCshNQwb7BOyLtIhlDmw+0EJAH1zRkqW63Bu1BQnXyxQe1OwCSoWFHHUb5WJNUAvYtH1Bdy
	VKJwhIwiOhtqoZ6Md8g0A/1Ijr3/orRQmeZa89pR48Cwb4Iik6Wcp5aYxua6i6ajcLLHX4a71/A
	/jAEpzYylnDsSqkhgXiL5ZQ7BLhSpj4tSMv+jbk6Tsr+uBCZ7yK/JPsGpxgB5RKpsVou5/k12t1
	72g+tifIuGNvv/sUwxyctREBWMHsQMmCfx2K/LE5uoEFQfFr3zP8QsPXHNlHaLobuSwxRsaipOv
	CzJfxJp75pI6jMJMh5f+f50fOImMaIQV1FrWY4HHZayQ3lkz0gjGsD7dAVsVEaiMqpod8NINrai
	Qz2wowc6za9uolxN1QHBuBRv/0fGydAaNVCvOYZhgddOxUQRIoP1h+xSnEi0m6XiKJgyGNTDWFB
	Q/dk1aNyB3sRMWQ/q+ZUdsRHym3ruAifRIKWji4K1omLR2fAgqvHtPwoi8fCaq5NNrf8Kbisuzi
	qYnCpZCeY486y0PAxgkAmqHr9Re317Z23cg8AQ==
X-Received: by 2002:a05:600c:3515:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-49fe66d089dmr30284475e9.11.1790242188347;
        Thu, 24 Sep 2026 02:29:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c50da7sm80852775e9.3.2026.09.24.02.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/7] bpf: Drop dead spill diagnostic condition
Date: Thu, 24 Sep 2026 11:29:32 +0200
Message-ID: <20260924092941.3174809-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=memxor@gmail.com; h=from:subject; bh=+j8tjysSebyQiEKsSaaHGJKB861gN0qzOSXYqdtBPi4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL25y60IfLclKWLL7x+9PHtQ/m3LT6/Su58W8xv1zXl a03jPJiO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRTA2G//EOD7TniNoIeu/S OyXQqPx42in1qt/v75rsj5123NO4aTMjw0xl7z9uTvdYap23Ft1MFl+Y/+GCYdI36ckTTovwbbE 14gIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

diag_record_mod() suppresses lineage-preserving register writes when the
diagnostic snapshot is unchanged. This is reachable for ALU operations that
do not change the represented type or bounds, avoiding a redundant history
event while retaining the register's earlier lineage.

The condition appears to extend this suppression to spill events, but
diag_mod_keeps_lineage() only accepts register writes. The spill producer also
supplies a stack target and an explicit origin, so a spill can never satisfy
the conjunction.

Restrict the condition to writes to reflect the filter's actual contract and
avoid suggesting that it applies to spills.

Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04cf9c4e4f50bc791937d37ace8@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 5ecfa86ed49f..496d24064532 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1567,8 +1567,7 @@ static void diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
 		event.mod.origin_valid = true;
 	}
-	if (old_reg && new_reg &&
-	    (reason == BPF_DIAG_MOD_WRITE || reason == BPF_DIAG_MOD_SPILL) &&
+	if (old_reg && new_reg && reason == BPF_DIAG_MOD_WRITE &&
 	    !memcmp(&event.mod.old, &event.mod.new, sizeof(event.mod.old)) &&
 	    !event.mod.origin_valid &&
 	    diag_mod_keeps_lineage(env, &event))
-- 
2.53.0

