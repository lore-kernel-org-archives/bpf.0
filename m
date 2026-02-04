Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708E28505E
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184321; cv=none; b=Le2Uk31SHaXrlIWaFXvVLVk1RTiNLWQUrgxUaKgm0nScWaxWsAp7syqYMAa15qhfLBvlwQlJgHeWldLqJfelWnkZt91f1rIIby8Qbn8HJjXaU1EbIpfQuyr+NeYuphHmiJlGotyJParnc82GSZUg1MKDD9ZH/B7ccfhHqZHYNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184321; c=relaxed/simple;
	bh=/S+etfuorB4JOg8c64Eam5cYiK78H2/ahYAQYzDaMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGpe/81qS0f1qu8KkavenjaCiRh3OouXCDPFwj//UQVcDE0PIBpWlrhX9W8DDBB0617C/Ul4MRZDey5RXioVE/aK7xznkH6FlO6FvzdoQdJkFv7FWXU9/vWpuHvPtYgIpJDMfehdaS+KJCpdL22WxfrNToBKNDF6f0bM1UbAQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J99w2LAS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J99w2LAS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3854751b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 21:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770184320; x=1770789120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy96ccwe/DIbob0XU38YOrX4Z8oK6cPORd0GBiVrrfg=;
        b=J99w2LASqjrum3opVp18C7RVJqu+/1SZkt/uF37BY9jPOALIx99mGWRvrXOHnnI3p0
         MXjEOPpVOCLBWpLK9tOFb2ED4QVAWHhsIqP1IflfM51FfSmMLT3OnDtqNIlUhAp82m1U
         ntnGCD61gm1LF/qcSbq0BBqm5jo5EjwFyEsAxNkvG6FleGbpEURoBNMG0iSWh5vKH1vQ
         3HDpmKjr95hfqgizaPSO9NMvxGYiW4FBWYlOiaDHW3iwhcravJPV1N9if6ZSAeIWWG1h
         Z/u2KeBgblIufCUsc9hMPu1S70ylCmoiOMDe+brrMs0tbBH2lK8dew7M75D+P1JLWSW1
         7yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184320; x=1770789120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jy96ccwe/DIbob0XU38YOrX4Z8oK6cPORd0GBiVrrfg=;
        b=j3vregEyveTCV4cVaJygxHMsumMUfuE1ki7J0wwKvVdyq5jj3i34zsWMiw1wLIezPa
         wWQ9+8zZC5K0JLYk5Nry8FYwDdXvzcLXf6Sn0dYHO6nJJAV5jFpVOwsGL6FChLvl9Ny+
         iHwsZfi9ujP/2GLPd1Z6EH6zcdehymUV0l9zTCY/55gCEYqe9OhGJrZ7TsT9e1GVvBFo
         vnWmeUkJAPw/MtBH6Uo2H8rs84VWWtASa4XExHqgT778ElfNwYeKZk4RQOffkJn7yf9q
         LpPtvkgqoK1GCpvOluJcU6/Es2L0R9HdKiEFJuRQFwyRIjiU8ioy0aHBKJUoLuszgEpk
         NBXA==
X-Gm-Message-State: AOJu0YxIV+Dt4clrcBY7orC9cZ6L8E5ZODLxvdj4ePxXga1qYOwEDU5T
	nMDuU7wPMcL0KWmzAvB7pKRgEernpRkeL0NCkfE4ieNdhQh3Tbau5BZcHB3Dsg==
X-Gm-Gg: AZuq6aLEpZcfocwy4llHcIHT/p/msshAU/NLI1mFTXL4QcwWPJdOkO5KiTNAaqhB5aR
	y2jQqgDoewBYqpUbcd7Q3An8sx+VNQKoXqJqv2jnj299mhCk5PnFN+9gN3pnB+qvfXX6q06eZbt
	0aAAscI5yGDe6PWBklhj5enQOfiWgKp/BzmO6tgHIx5U8zZRbEYlj0zvoR+/VRqc+fu9WWrw2Ma
	ag5yS5GswawHsJ3h5HBDoKIhlnkBIAGpoM5Ki3NfAnyT2tmZuRYA5DgdBOwWrzn5nRwzdsm1bnz
	mA9bzAYmgtv728zBy91iVwd9zc4nPNfQz3UvsZUvA+UiXphB6iGvAcGXSDu9Eb6WwN/F4SMm5iq
	UNAA8rFaDxNbYt6wYymJ5KufJ24rys7rqNp8emG3Wwz1l2m50ps+KUAybKRt67ZSINKU0SxyRia
	e53VbfLWZ5dD9va3NdNK8v+7lpgwaKUptErKJRzRBiwJ++bVhCjHVfCjr4Xoiqz7/xXqmBF3g7+
	YbJSAPpraLLsvq5UgmNui7Y+wgPLavwjanTCn5kL2bCGGaEBg==
X-Received: by 2002:a05:6a00:a907:b0:7ef:3f4e:9182 with SMTP id d2e1a72fcca58-8241c644cd5mr1926788b3a.47.1770184320412;
        Tue, 03 Feb 2026 21:52:00 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d43513esm1182091b3a.43.2026.02.03.21.51.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 21:52:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: Strengthen timer_start_deadlock test
Date: Tue,  3 Feb 2026 21:51:47 -0800
Message-ID: <20260204055147.54960-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
References: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Strengthen timer_start_deadlock test and check for recursion now

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/timer_start_deadlock.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer_start_deadlock.c b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
index 368563747a46..019518ee18cd 100644
--- a/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
+++ b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
@@ -31,7 +31,6 @@ SEC("tp_btf/hrtimer_cancel")
 int BPF_PROG(tp_hrtimer_cancel, struct hrtimer *hrtimer)
 {
 	struct bpf_timer *timer;
-	static bool called = false;
 	int key = 0;
 
 	if (!in_timer_start)
@@ -42,13 +41,9 @@ int BPF_PROG(tp_hrtimer_cancel, struct hrtimer *hrtimer)
 
 	/*
 	 * Call bpf_timer_start() from the tracepoint within hrtimer logic
-	 * on the same timer to make sure it doesn't deadlock,
-	 * and do it once.
+	 * on the same timer to make sure it doesn't deadlock.
 	 */
-	if (!called) {
-		called = true;
-		bpf_timer_start(timer, 1000000000, 0);
-	}
+	bpf_timer_start(timer, 1000000000, 0);
 	return 0;
 }
 
-- 
2.47.3

