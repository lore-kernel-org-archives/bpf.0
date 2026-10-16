Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A263B52E1
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119575; cv=none; b=e6aaagQ3JiGkz6Q8DadS2auBw1lSYYNiUEy0EmmQEW+v0Snsy29rSZqcxLGno+YwLE49OSURBqfAnv4fKmlS/67lAi5Y+MskT8N4+Mg54moHZrPRklf0mvuxSZV7qt7tioqfEf7hFJTZvJh0rK4XiaDO1tSx0QAJTn/ZZu3OBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119575; c=relaxed/simple;
	bh=zwamoSKtnp2UIoIEAdgjm1Ked6nmzXmafaSRA9PS9Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyQ4NRVm78j+B06y5JpQszCO5zOforrjLt/RdcqlwO2rMp1KBf9JMK4xo4Kx1NktY7SD5fHJmE7kJzzV934Vr5LjM57uiBl9WR7e6Xrke3j5qe5RDKMROHqZaw3fG98nXxGiXji19t5H9drDbv4oy3Bw5RRmEolytX7PuFPq/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dloiu5C4; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dloiu5C4"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3550c917fd3so3701428eec.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119571; x=1792724371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uk30+yg2ty9iM02IzOtK74HK1wf3XreTyUXpv5e/KnQ=;
        b=dloiu5C4zFsSeHsbu2QYuL4U6cnQNwz5n071NRbGPWE9lYL14rBhELTriwOnfC+395
         XMbYTWrK5W8lacVHSw4iwSVI1JIkHngx0L76o6uUiI2DoN+sf8BjftrVMBj7jLXBmYI2
         e49Du+GZQBHGNoahRIIB+/Rtkit/bFiWeYnu5PpebBL7AQEjsMOR/e4nChPIwYUb3k4A
         oOmwwff315MghuQbA9J870dmK3rIc8gOzt/zVoeaMgg/yBwuNN2RI38yFsNEpRlIVRw6
         AHl+kBhQSG5xgBRsMhQ8EtAmHwdVWhgjhH24+XWwM2iEm25QtDtj/rPCYBfYF1OU+2R/
         +s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119571; x=1792724371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uk30+yg2ty9iM02IzOtK74HK1wf3XreTyUXpv5e/KnQ=;
        b=EYXWyXOpEppRrradpb+JHtmrwNXFMvtwai2H8pu86VwzzeqEdM29QHRdQiwVlwir6r
         SClTGSl86HoEjhYdNUGyWrdnGCSYccA6m/BYjE+RdADmkKCRPM47v7LlvZiFVWe+zSzY
         47Nm1xIA5Cfe7A7cqVqileYfgmF9Kenubxz80PCLMA85TtHel7S50B84OgeEur65lZ6a
         UP5g6WetvOCDLbMCZGTbieLoHI6+2b704RykribslC5xtSBrJdQ10i6ulJVwvHUP+mKG
         vJKLpIFWsgMvv5DOi+Sk/lSYUYIro3kfL1d2WhIpv9gF4T5BEEfsxZjfh0jX1YUE8Lvw
         uNng==
X-Gm-Message-State: AFq9FYIV6fevKF7UwVvmLOEulxJ9inr+UkhF4OGAtf8DF0vpQoytc37x
	pyDXIITPcuM5EkgeJNW7JJiFyI/bXmTDIJNOOI6X+jfvNbPOnNVuJ6wL
X-Gm-Gg: AYBFou16+TVnbtjW9vCvvV6qeOgJ6w7eak13vN9NVvt0z+RImKUHEX6JNoiIGN2uaon
	dlM+igXxASTgbILgM+WkulkHvJcTK/Pe9aX/CpmArXscjiIPNwKBL3mPBeDDRWbTcvUW15/oP0w
	iMryTOJwZVD+kFihgQu2Wf5h13pGa1ip0t0QYzpruHh6mZ05d+4PN9SGA7CcNZ6AOrrLCrmc1+E
	3ivFOMU7HQ+1FB4UddTSlV4n7D+j8S7kttqa62zlbsLl+eByiamTWkLNoHEteY6ooGIM+GXWAif
	cSmCPksBQHqfCyZKp+Qfm8L0QYJE8EItyPFFFrf6W/XFdSzh5ynNDSahAQC+jR3L8Mmb0Tpmnat
	ssC3pzGQghy5P1drQ5xVMjSSuUyjSYtn4MY757/JMQpqwy1MMMbtWWwkJY2qoic8icJDE6OVkln
	nk7vcGv+/Pu1ja30IvK6/lE/Py9DlHzqKg1F6qiNAl/ck003FDHdyOp6vQcROP+ioT0g==
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id 5a478bee46e88-3537e033341mr28255195eec.11.1792119570559;
        Thu, 15 Oct 2026 19:59:30 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm2481261eec.3.2026.10.15.19.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:59:30 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 16 Oct 2026 10:59:08 +0800
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Wait for the struct_ops map
 to be freed in assoc_in_timer
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-4-9ad31c21220c@gmail.com>
References: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
In-Reply-To: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
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
  outcome     1 of 100 failed (MAP_MAGIC)  0 of 100 failed (MAP_MAGIC)

Fixes: 0e841d19263a ("selftests/bpf: Test getting associated struct_ops in timer callback")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 9d56e8cb5675a..435653cb7c908 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -187,7 +187,7 @@ static void run_st_ops_assoc_in_timer_no_uref(int timer_ns, int wait_map_free,
 
 static void test_st_ops_assoc_in_timer_no_uref(void)
 {
-	run_st_ops_assoc_in_timer_no_uref(500000000, 0, 0);
+	run_st_ops_assoc_in_timer_no_uref(500000000, 1, 0);
 }
 
 /*

-- 
2.43.0

