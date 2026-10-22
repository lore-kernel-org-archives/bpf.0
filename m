Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658941;
	b=baXWyQkYtF8QQM6Qjjkh73I6exjldIOrV9vIc/eEnEdnobuX8AELT8iXa/2ESnREUZuo
	 BRMvxLbwkq2M8hwdbe/O6d/DTMS+j4w1wsJ3GCT4cJ0UT9OGrAj3nHf+GQlfhe2f4xh4v
	 fx9FdqvNXgmS4t9/oivjFnSNDAl6bzljp1Kro44bKiiP5MKSvk+u+UJ3W/OiD7nOddp7b
	 j1nCspUhaBxjMINr0my9t1QGz3bvfClvildXNMpHMZAJ9fyRxUqqpr7M9TCKja69kyKDR
	 8GqUd53Zc+XFb89RWP43xXimccysG18baG+1mKrVOub7mPqUV23k2mM0T41lcFABLrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=56F8g7Mv7DiOapm18g1wrka7Wgg9xFTAcIlGCMlZEmo=;
	b=mOUbI3h60XYCJxxvh51tzvpGTv6Xen/eC8zFbzfcxact5hS240QTqYH4pBYgP9VPr98V
	 bmpn89WkUEHN/kYIefyDMPiWT11S9Z9+Wepk/No+j19IwqSaFgMMX3Jm03xeDm2hPbJD/
	 HzTc6NPGjkWlphgLtmZsVl8fXj4NrmUFB9rp4H9wZ+auPsyoMlTlXLE7CiZ33EHiLLdIx
	 qU83Wj5X+Vd/qNa11YttMV5h9Njp4HVb9ALUxyyvHl1rwp5o40TDmyPIhQaWAsnzDyr2S
	 fWKBypE0HC/m0sCMTCWzjnJuEVO424nRvFT1t5oa9lPWqnYU2B6bfT1gVm1OLYP0P4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KqvEMzoT;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41660A261E
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 08:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C41660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KqvEMzoT
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2764519eec.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658940; x=1793263740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56F8g7Mv7DiOapm18g1wrka7Wgg9xFTAcIlGCMlZEmo=;
        b=KqvEMzoTtb28KuqtFbbWU+sfxJbpAPus7et3gw69bOMr4KMcDrvt8gV2nK08PFGy2M
         TeLBhAtTesCjBdXBxDzmjkeEZ+CZ+NSk5V1vXI6OqwrtlPHCJvKonKG+7uZNj8bCSS1M
         Q+zVGrihb1JB9pr9AuZM/t6MvkIvciTngBHxIYu71m3FE1N0Y5wQVik3scOnBAt3yEIi
         Q4wfuL9oiRDqSe82LqmrIwUPhao3GZm+2lb3uoZIQD2dltyBH5GbWGSC95+1rFo8SNIO
         vAzxIq+yrTFoLZ8O1ZjPYubaYKrxSvBpWlvb4fnr/busXJag567rwut85t0anfsTr0O1
         hBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658940; x=1793263740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56F8g7Mv7DiOapm18g1wrka7Wgg9xFTAcIlGCMlZEmo=;
        b=zhriVr5JsZ40nyo/1BFnTWCIy/B6dmUDyMaaiP3juxhwUQmR5JlFlPcrUHnnL1lGQ7
         +/+j/yfjWUnW6kX5sxgU2gHok3qo90RULbhmH9cwEdqMd3jzto650AsIzg2d4ukXwe0J
         mL9QMeOajSdHMyAvAGD7nrFmW7NPvQEDdK74AeFMUcuuU5wx/MoJ/CgxIfoSXd9vQSBh
         xX/cUJ+vc8gJSVUeO5aNNn2PTIMQvilocY8Jp664bc1PIn27Wi8V2ZIC+o0gZkHrvMOe
         YRiBuHfilMoGUh3Mc9lch3uteJFuFtMXpHMCbdVFykHG+bMobMIxkI4zRlho055wazUV
         b2+A==
X-Gm-Message-State: AFq9FYJC6M/pf/lMfwnsvTrRW8ZwQNBxPtl25LvGlniG3c4amV6CMiKT
	ZHUTmuL8j/o4KG4nqz9OJIGxNB8umJTXi5DtVjg7vlqdv9odO+z8CJKL
X-Gm-Gg: AYBFou2BhNOrXkLJv98ksv8aSNBw8KdgJbjj2EQQwzgIAgBQ3nDXLZ50U125s/kpei+
	QUxOuNYpwXCFMSZ+/K4beBvVsYOOJAJ0oKv8xorsJJCPUaHsswqHdUgh3clQgu64of4A5/v9KIb
	NgMpD3Vav+kfqIAyayD34L+98kLLHqMdntExzfO9FrySmzcqQjTJCxRqrSx8Vojy9HuQa0ZAZDX
	h8INCS4yyIidunyAj7lTpqZYRVzpAJ8tfqdve1xCvWg9Ap8PqGZGUYLHYINFKRKOpnQFIvcTT6M
	rT+7DJtcpRBYqUtoLzvI9ZVBt2l8bXpVJfdW5JAiEQHUAl351d1XhPxnfcqE9YJcW7F/i7fRXPe
	TL9bEdaUzTdw/+pAe7GFsEUYuzkAuKjInCQya4Hp36SOe981sNu5iZB/V7RU5u+8d79JRq+VN19
	gpBAKy8bJYkYUpV2WgnXc4J/AuaWvLv2igNfxerytZ3PaA/RZH9UbGm2vJ/C7zh1jqVcjAnCkhc
	Z1i/gm4DePiMVNf7BjObnA5O+r2jUgXDmnysswZtIIq8t0zSSEwnCHXo2I+dZVKxuGOgoJ9
X-Received: by 2002:a05:7301:2706:b0:353:5b04:8d19 with SMTP id 5a478bee46e88-3674c92e2d1mr6183474eec.9.1792658940316;
        Thu, 22 Oct 2026 01:49:00 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13962472eec.21.2026.10.22.01.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:48:59 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 16:48:39 +0800
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: Wait for the struct_ops map
 to be freed in assoc_in_timer
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-4-2c0f18e82582@gmail.com>
References: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
In-Reply-To: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
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

