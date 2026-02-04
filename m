Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F542BD022
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183630; cv=none; b=QvlNn/AI+Suf0Ez2AdsjS6xKqF5uP4eTNX8vDidvMIZdYBEt+wQwA9DwKQnnHfc8r1U83V5a0oNoLxkjZr8jdBmseSbA0PzKfR1Gdp7EOKKudFsOEZ/aBEimj6OnydstGPqs/Nvb0t85zahzT4bD4ueJjqeNPjhlkkTKXjIGmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183630; c=relaxed/simple;
	bh=l4MrBo+6CjuzgRtn5pPzZ+gEF6DSSMFOv7HnSi0Yj18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gy2q4d05F/Xb8iexBi8mWZUQO2tQgu/foLGLZxRpzaREcbYrCqq/wLnbpcVRBpB79Sq8HNV9b72D80WMiQWkcX1z6qOgdWkpHFdaWDrRvjREYI2lEeSKQ0dkkdsbZg55HN6qd8TqRuNqrrHQ+QZtHzQSdeshmpKbfFioayBpugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNsJnWyv; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNsJnWyv"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a95e592fso1506748c88.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 21:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770183629; x=1770788429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XFYmuOieHfW88o1iZ8tRxu744JAOX36TkB6kEmzKKQ=;
        b=JNsJnWyvS8zjCWOb+U6kadRhzU8sduInwZQglMEA+eFbTdZN3+DFz8Gdrh39p4nDsH
         2eNmnWJQxKPsZv7sXowPyHt2CxRBet8DO6yXRd8DDqHyDc1lwpjsj9GCM0Fl+8chAsOh
         PuQ8Q/BRcSSwgtoJrFOmOj6lQwo+V3NhvEv7Y23J909T8rz77NK07Hgw9tgGVkjo5pcg
         /y2FwZq6W2PpaxuFnZ4oqVbPnKxh2ungKC8o5/nCQQyq5AeGo2vSYoslUTsIW7XDc2kR
         f/G5blGcD7IoNHNKlPJ1lBVW9/hxeVmC/N/KzFyyD6cLXBEpNUqupZNDR9huw5bwK8Ad
         6SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770183629; x=1770788429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XFYmuOieHfW88o1iZ8tRxu744JAOX36TkB6kEmzKKQ=;
        b=e24eEu24966crIOGvAyHPUKQuqDLAKCErPjQnEyzK942zGy/uyYIHxTEVxY9bl9lCJ
         XZ4IfQz3UsWk9/CzXIGEx8mAYqUFRsR2Jw9VRfAQkpes7GcRUP8TBgE2758nemGWDHxE
         tdAX1acs9whEffWgn79+iCLpzcIfOU5J3MJgUfRmz6EMB25fKUMQ1I6BsgNMUCiU+lD7
         quw8G56D09XX1stEvuxyigr59tTyfPge837j1vvG1rPiC6fl6WcJU80TxBi+SNQvRag0
         oVuF9QveaNfvjE/zkNti1oz9r9+AtxO0If37lbE9z+T1oS0kNpFMJMFPzwKYw2TGuXMo
         QEBg==
X-Gm-Message-State: AOJu0Yxa/89/suQCT685bblNC/sior1DATAzHl3aiZJW6+0YGOov7XDV
	2aZeMqZh5KJFHqRmEQ+34fhLi+3kgWfAf6XC6lbjm2UmaP6yA8yFuKJIgFljNQ==
X-Gm-Gg: AZuq6aKRyZGi/e+XisgPTw2VCR7dqQ8mwtBUlLxucN4MRoOQn7Ccco2eNaqxMWWWYR2
	KO6ioUu0sFcGD0I8uKMDmQKq/5omsyZz2y3SROFMQZnjJbt4ipVsNWEo+8I2CjtjHWKHUsNpKYd
	CLkUsvpk1G/DWwvG5oCbXA3y0J/HvZ/4ZiEMyVpFRulKSCghNWXWIcbaySIw0BuwpL+1c1Rspr4
	EDcaAhaPnvwWbkIblOVL2/qAuAzFLm9b4dSBNbfiiIwxsXtgz4xJDKu7nOFFajzn5iTBztRqlAX
	QdAQO/B3ntGR9TcTj3qGplJdF5uFHE9BcnUrR/3WwAWG5bq7L6S4l/sdSRfsQj+vIrP5emSvefh
	lDWL0feNEFRMSQkJtfY2iOGeatSUXsyDp10HGbPqS68jRf/2Na5j31zz2Eh7eubLEeLq2AfAmKe
	wWqbaS56p6Nq4s/dWbV22Ev0ZsTFGe0UOBXR2urKbFFx1PR4FQstBOE+XHnhrtr43a6pw9ZknbP
	baRQCHpSDlLstYOXfRsO5N/BFEk9UKUtE7P7COYjlDviANpQA==
X-Received: by 2002:a17:902:c411:b0:2a9:2858:19ad with SMTP id d9443c01a7336-2a933fb6422mr18597685ad.49.1770178116014;
        Tue, 03 Feb 2026 20:08:36 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e945sm8815055ad.57.2026.02.03.20.08.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 20:08:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v2 bpf-next 0/4] bpf: Fix conditions when timer/wq can be called
Date: Tue,  3 Feb 2026 20:08:29 -0800
Message-ID: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- Add a recursion check
v1: https://lore.kernel.org/bpf/20260204030927.171-1-alexei.starovoitov@gmail.com/ 

Alexei Starovoitov (4):
  bpf: Tighten conditions when timer/wq can be called synchronously
  selftests/bpf: Add a testcase for deadlock avoidance
  bpf: Add a recursion counter to prevent loops in bpf_timer
  selftests/bpf: Strengthen timer_start_deadlock test

 kernel/bpf/helpers.c                          | 29 ++++++--
 .../bpf/prog_tests/timer_start_deadlock.c     | 33 +++++++++
 .../bpf/progs/timer_start_deadlock.c          | 70 +++++++++++++++++++
 3 files changed, 126 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_deadlock.c

-- 
2.47.3

