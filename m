Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C73603E0
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376907; cv=none; b=CieiwFgvbrI9aVzUH7BCkfZiNXx4LPeXmSz0PMUyLL7qUXVW2YMdLguTl1Zxqfkh6R9HurYRZ46f/ocerAF8l1RowPs3E+EY0KbrlIw3mfXzg8PGoU2BYYT7AfNiClhCgHGkX726+fMjXjWqvmdszYSv6w+aSESIJa223mb0Asw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376907; c=relaxed/simple;
	bh=VoZDbBSLnpJjhnYeKjYgnXIV+P15dl95lq2PXBtcQEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGk1JOnMWctr8HPqpV+bnjRJHSjhqldhDBdish5kSCQq4tPcMpCWHVJD7Boa8S/Vmu0sIvov+3v0ZiQImdMiLU1luPuuDdVuaL/tpzeIv03riZQPKCkFQR56HKMx/oGIYJvZQK+LF8V0AuZ6JUKebtLmc7iI+uZQEq6TgnFvEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhPf1d13; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhPf1d13"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35ef6b49813so3140080eec.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792376906; x=1792981706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56F8g7Mv7DiOapm18g1wrka7Wgg9xFTAcIlGCMlZEmo=;
        b=dhPf1d13XHXqaNcHQKkGXGtRWnLqbQor2QYu+y9ypo9U+vcFnE5K1ViueTIdZnfyMr
         +bNkFSthrYYAO9OEZKUYv/6QnF7PwsHzKW0vWvEB+oe5JGCwxTBVbJqLKXB3TZFHAbvR
         eDUtcp+D1U2R+/T6qEmi+Z8x2yBv28qANLEYgM1Yl9VxCXK9JIlIeBKUBXWxWhbMAEsk
         nXGh+NbCLXKMYAkFOhqlmG1u36Rxm9ebRiS/0gtjVMCmvQIakcpEDfU1IxRVaMtFZq+Q
         uSO4r2v111H7sj0GDlaTP6KmzSQGA5n2CNje8VO4r31cF64DDVRaBw5469f8L5E4Vpc+
         g9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792376906; x=1792981706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56F8g7Mv7DiOapm18g1wrka7Wgg9xFTAcIlGCMlZEmo=;
        b=CbQDvX+T5u5B+OCEVu5AfeigxZkVNVNmNGpiKMgZfWTwuNJucJiiEN3gjfYVshuZ5m
         Dvj6HSS32q3pYFQH0Os0eWgAf0F9uDTGGLAnbc+xMROsPAbGp7hCFTH6LFcNBBKr4Hgu
         GBYGLuPzg+atJvWTBxnmAXDT+H92QjdQnAj1zXh2MNSemUcTUyawiUODqrOrCdUYTLBU
         QM2tDYoYnv5vHYXjp7XOSEgEF4keTcuLC1xHL3xSrP4BHRW2TbK6KXR5km2tYS7QXHBc
         Rq9V0esffP/ZiD2NCleAuCYo/tkZXNmC4EHtp85sMVn716pyhqOzOWTHHhaRQuQcmfpY
         0Bzw==
X-Gm-Message-State: AFq9FYLWlxBRah6yagCuzsQJ8sqvnschB7bl0T+2jo2awQ04ra1/QwNe
	qseWiG7hYW4qC+oaWWQ/DwdMHiJaJtASAPoqoHacn5H+8ji+4MKdv79A
X-Gm-Gg: AYBFou2PZ7FXn8J4y1hJioUnuzQPa1kwyO3OvePh4mVcLMn1it7GUYCN+kwEYVhUj8O
	uMhZen97ht1X3Wia/22/j73Kop6Gf/mwv0IeMx2yS4YNpNhzBNoPq/ntcLggPd+sucWT24eDF3j
	wFEEzSY1eQjwVN9/XdCqKSN3nVr+bKi/4J5xUe+lWrs4V6Lru9m69RDqhs7Gku9lD2mMAE4UKBG
	9gQijI5SsHNDPngOqNRlSKvuvuchiNa2lLuRgfgYgUOSC8O2nwOcqY8s0j7dB8+uDfOyS7NTCu2
	90XARjZpTDfVL3Lzpo4RcTh/4JhQAzbX4HH2fOWQnKuBEEnq7WKnJeZXB4+SrTadrkNNuElJvXG
	MrGe5uHkS5yy1uLC8ihVEE+DjqhcEaMeFgmEqdifVZrz1d5PqmZnYoqHvorcMIwNmh/I70eOFBv
	3N4UrWN4ZpzyIXXe+MmE3q/E4TAQ6HeCtPiFW5a8dV/MuakJS2BNrufE/5+JbIxQ2I/5Y=
X-Received: by 2002:a05:701b:4586:10b0:18a:6c40:1a35 with SMTP id a92af1059eb24-18a6c401a5dmr2018817c88.20.1792376905671;
        Sun, 18 Oct 2026 19:28:25 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm28341876c88.0.2026.10.18.19.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:28:25 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 10:27:58 +0800
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Wait for the struct_ops map
 to be freed in assoc_in_timer
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-4-77b2e181e5cc@gmail.com>
References: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
In-Reply-To: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

st_ops_assoc_in_timer_no_uref runs .test_1, which starts a timer to
call it again 500ms later, drops every reference to the struct_ops map,
and expects the timer callback to find no struct_ops associated with
its program anymore.

The association goes away only when the last reference to the map is
dropped. syscall_prog holds one through its own association and drops
it only when it is freed, in a work item after an RCU tasks trace grace
period. With other tests running in parallel, that can take longer than
500ms, and the callback still reaches the struct_ops and gets MAP_MAGIC
instead of -1.

Have the timer callback restart the timer until the map is gone, as it
does for st_ops_assoc_in_timer_free. Calling the struct_ops through the
association until then is safe, as the map is freed only after a grace
period that follows clearing the association.

st_ops_assoc_in_timer_no_uref run 100 times with test_progs -j32 running
in the background, on a KASAN kernel with the fix, x86_64 VM with 32
vCPUs, before and after this patch:

              before                       after
  outcome     2 of 100 failed (MAP_MAGIC)  0 of 100 failed (MAP_MAGIC)

Fixes: 0e841d19263a ("selftests/bpf: Test getting associated struct_ops in timer callback")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 6c85d368bf167..9b646d134a45e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -188,7 +188,7 @@ static void run_st_ops_assoc_in_timer_no_uref(int timer_ns, int wait_map_free,
 
 static void test_st_ops_assoc_in_timer_no_uref(void)
 {
-	run_st_ops_assoc_in_timer_no_uref(500000000, 0, 0);
+	run_st_ops_assoc_in_timer_no_uref(500000000, 1, 0);
 }
 
 /*

-- 
2.43.0

