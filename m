Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19081379C44
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784460957; cv=none; b=Um3q6GET7/ZpwHwGCu/Sf2t3FVRiQqzpaRUFbcTWtC1s5VE76r3dTa/RaJGeoi+QpK+wusJDFxyi2++1PvNebFwqlO7jQRVuDiGkaemOsL+eMk2YlhNvlBu5P3zt8HLdXViv9WBdWbd/fSmGQNU09XvBTdrmYgESIqwdYNkrVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784460957; c=relaxed/simple;
	bh=fKzH8Zy/ObzJizp7MqYYfolykjFXjiWAlaZompegwV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHlQlQsx7cvdJlx26Z8ldDEyGj3kK5AIVO8DUPphDMCDuLu1sXoN07ZqmhdPz+VuhCI/P1b5oCGS685nkC7HX9nB4CNc1yeA590sj1dgmG5ndDz1NrPKlYeDzKX4exwmkB/w3EtQraYr1XqXvf2F1TeHvJwfyyFM4NBe/9xIl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OibNh0YD; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OibNh0YD"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49557073245so2364785e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784460954; x=1785065754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Emay/0OFEqqeNZhnV0XyrOI2KLlFBN2tlqeGHeAFTnI=;
        b=OibNh0YD2Fu26OlT5YIQ7SiAcoP0f9pJwzpEOYktz9LDNM9GN2be8+VvM0gp2eNybz
         Ml4dWmTz3cDM6w8RPng/CjKPVVrbqnet6d7upI/cwCwH+BW+F0iFMqO+WaYyJau+y0ed
         6jem/EIcP4SasCHyKP9iJ+HWeZX+7gDeLvHyRXhrSTPNNb3s6GxzooIMqri30jTywOpX
         AU9I/9u+J81n6qNqS4uuecP40Yw+igBphZ0qcvbxKIBsYjitxxYSi/ONdGwFgHBBA6fs
         0pbFySm9j7w7OysyuPo1tui2ro9RIG9w8CaOFwQfgDO10pTy9UMAiU0ibBGhINWuNzBZ
         tK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784460954; x=1785065754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Emay/0OFEqqeNZhnV0XyrOI2KLlFBN2tlqeGHeAFTnI=;
        b=pN9daG5VIFTSFREbnpiXHohAQxNnZfSpUFDwbLC7EkESM7WUW8vghhYQRR3aQVM7Hq
         6mEHQnRmRVvUo9oO/HbnDXPnEr63BikOaza8S31IU6ZuA3MREBIA9cJdhVQaPj/s8dee
         0cFfBjMQU+hQpx7O0C7SK/Yk5HpvAnmNz6GbSxx+wAMD0jRCn0vCacamDRCbw+x5rwiz
         buJpzdsIO1h4b1iGaw5ShCnpbDFAox+6ETNHHhOtj672cmOa7qXsKfSIwW5Sj8Iy60Aq
         qTaNZ8NNXYm1LL3T409n0+scfPi8SM1hJYq+CqOtvuaCWTTZ24u64eTQvk7qxdRAl9+2
         BjVA==
X-Gm-Message-State: AOJu0YxZGHF/RDu8Uq9u15+Tze+QCls2QpAUVamXB2VMKiBYOkjDSMBJ
	Yb+a79X+P1xSJivVIjMQ9ZdqGTrmLyIw1GxLciPifoFnavOpRXdXR7CMf71CUy7x
X-Gm-Gg: AfdE7cn+qPhSerc2/KijqfP314ZEbbn2Kw7xqngz4lgeL1vlI4Rj0yw1JvdvOrIjDUV
	Gi3padZ06AZTPzIT9pjtWdLmOKnqmrQ1Iq8D5O4AmU3pAEdbnNIsrLBuPMVcOzoltAC6WQfORYz
	zr1PuHh0+rc8d3T3k8N8VO8qUJTRIqVOkjkjk4jeVfoQLdLGutL51AZ6+MPiZffoc/l1KqDRyug
	8q7k2dVIywSdm5wFfYIxYkC42iR3xtUjdmN9cm1EE0xi5jSwYQ60ZDFnyCVQE51WEATeXRObvWl
	Q2Y4gfkA1SA87MUr1+cb+lCB/iB57xrX4tWY9tu51zu2hMV8gb6I7ET4CQPJdca7OEopmKXBqtI
	MBfFhWThIx+E3ehQs5OE2UPd342NhCAV+7nleOKM6ayLteAwuBaxs8aR66yNp5af+C9375ByB4m
	H9GkzQkYJ1dPxF43azd9GuOFu5lKAvUFKRTGT4hkjLkAcf+9cpJExQcrELBGhbsTWRVI9QYqUSU
	zlWl7eerWIWySK893vQaXT3NAciY4CcFw0XVfs4j3Xw
X-Received: by 2002:a05:600c:35c2:b0:495:4c74:6a14 with SMTP id 5b1f17b1804b1-4954c746bd4mr117294835e9.14.1784460953948;
        Sun, 19 Jul 2026 04:35:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm20618081f8f.21.2026.07.19.04.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 04:35:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in all contexts
Date: Sun, 19 Jul 2026 13:35:49 +0200
Message-ID: <20260719113551.1294284-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719113551.1294284-1-memxor@gmail.com>
References: <20260719113551.1294284-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=memxor@gmail.com; h=from:subject; bh=fKzH8Zy/ObzJizp7MqYYfolykjFXjiWAlaZompegwV4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIStmc1cG931dzf3iHInXEl2eu8uIWjy3y1atPya63lFPu e7viTMdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIjYe4bf7BO/uFyInPv573r5 6+Iy9c+vKfxzOhJYqcFbZbOoO69Cn5Hhc0azSYvIpEuVt75NDH4S+0/IleWu01ZF9tgdKeXbON/ zAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

There is no particular reason to keep bpf_res_spin_lock() disabled in
tracing programs, since it is safe against reentrancy and deadlocks.
Remove the restriction for tracing programs covered by the predicate
is_tracing_prog_type().

This is a prerequisite before the definition of is_tracing_prog_type()
is updated to include raw_tp, fentry, fexit, and fmod_ret. Existing
tracing programs will be updated to use bpf_res_spin_lock() instead when
it is available.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4446f0bde88b..bb6e16668d0d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17815,7 +17815,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
+	}
 
+	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		if (is_tracing_prog_type(prog_type)) {
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
-- 
2.53.0

