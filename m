Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343926;
	b=EAmRuLSvzq13g7+qPVcHxcZ+RbNJhutyfl2ERL6rU6xuC+xow0CDG1dTu4hQ9vH0Q2Zt
	 wxaZ077edp7v5HfuA4RMkuvEQMDcjRd3Rkpp0oOnwRgCrtzVL0XQmZX86MuICK0qBc43E
	 6dTxF/OXf6QxJBWriu6Oi+QkVoWBSJ9d3hkmwLRnfKBp+NCiZTZYuzZIDqnue+stWz2+a
	 F6IJ3nD7lQNCsM7ZW3q2R3SctWlP97iIpGQGkF7awRoYi42m7LBomBz55iK0IsHpjo0Pl
	 4lYm4kuXRK9mkk049BJm6qwJEO1d3ciF3h2vjCgxX0fi4nqygfWk9xbSp3QBHAeMqzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iIoyRD5bmDZ1wW5ozSGgF56j3yPp2m5ZjkRy/haCeLs=;
	b=rBpw58ILjMXDiKCN+mxGZ1jTAEq/gHw2Dvsp5ODipwLIRzPPq8tBeZI0uDML7hYvxQGS
	 YzIXTLeLxEcw6y7K8ZP+Lxo/m5H7BkQMV3WAQhKEGP1isBktbETEmUK7lryFFToxsND46
	 u9bUdbhqQAihVr+Xw5HdblJSsckNYucFoe566DiJw/xx5mVpTRHckIf/IbLQMn89ViqK8
	 tl9PMy1AusGAjcuqHOO5OdwY7W86rhrhsYAiohIgrafabbPQRp6fYT7dv5Zp0rtLD0/56
	 ugsVr9QZkUA1sy224b2P8bKG3rHnA5eIG+mYT7KZtYDMUFj9q1vP4k7cBN1MVBN5d+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlEMdPuy;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358A606A32A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 10:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B358A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlEMdPuy
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a3c08d6928so3170090c88.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 02:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343925; x=1795948725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIoyRD5bmDZ1wW5ozSGgF56j3yPp2m5ZjkRy/haCeLs=;
        b=mlEMdPuyJmZNrl7OSX3glBID/2JV716INprVp91bSSqm2x5VmWML7/dsRJ/QbF02lA
         ulLDJcTeEkUXlz7oLEy2bkQnykFJPvCBWLL0X/Ft11tiWZTYR6rnxXOGQRcKREa2q9QH
         L1C4Ijj5VPU3rbBSBwgVJDBkyUqCL6EwThiK+aV4d88I0PUVf2BQW2133f5KoRlJGgfY
         bwYrYoHVv/Jw7454rrkmiiHtmb2kD99rRXhrfn5N63MgdpFhjWJjxFqiQVRb9braGh6Q
         f+ysKZJy0FNUTTeyAPGIA8/h0DyG6iC7783MkwK4WdajSUBLTHXbmj4KvkYFYlc3qXxQ
         69Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343925; x=1795948725;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIoyRD5bmDZ1wW5ozSGgF56j3yPp2m5ZjkRy/haCeLs=;
        b=Kt6pbmd/Xz9qbX8OSSGi8ukt6gKSGdC7dxIItWZbzsw1FpIAuKU6w0XH93a1gY43yj
         8UrK+6I7K9swjO9RLmM+t+MSzWmZHCTKbopg3U+zqnvjW1GjyIFp+f/kg2AQHS/uNBEI
         TI72tazvoSFCdUsCOcMoxVMI2pELARnAkNZdiDg8D5fF9rKNlE4kwcZBzQO7Yjk/OQD9
         Sl2BXENte/y5EAT7B45UfNER9KO6Ce06l7iN7F0bMdFusR3YwGEYKBdUlMihyLj0sENU
         1FNmSkcN2XTN7djSB89GphnNIy3TVOrTEbuUdbD8lSeJMgvR3V7nNkSV2vB5D3gLxxDx
         JFBA==
X-Gm-Message-State: APuU4Z/5ZE7QW9Ru2LVtRRsQeB5adsjaiUDwYce/pNxe6SbHZEJo767z
	Q2Xr+5Hmr9Y50bT/e1+c/X+UbP0zwKRYdtT3GslUPweE0T3883pBDWR/DONx/nmTSog=
X-Gm-Gg: AZFdTZfNlkU4e+QKV4Z3t7yXEWnSE46FxBdUwdMqJEXQ+aVJzVaPFESXOFxdWffqpLr
	I//mH+AtprmIChPJQCSLuf3GlNqbseNOABXo7yZynzn7l1qsJX5mKq+iAjnmTQk/X9QOUlu1l+5
	rgV1rRm27vDXNvJwgstuCzoG1puvM1c3uLOmX4BrjLh65BBmPTM7suQnhqV7arRKmvYv5pzWSQx
	izssnZkJDknscRb4974apRbMPTB/+S2clZrMxeVJHFyDLqMUEW+DnzZ2Is+JlpAXvVNesKdike5
	tdA6rOtt5We/KlfeH4pB7Ple3Qrne1b9xlmENmvPrTRDt7LjqDH6WHDwPUSnOnUGfqwEEtVPnL0
	ptMgfjmqwGOUsVwzqknDMKxDJXwmh59i5UNDXeth+q9GAkACb4R+C113HtDBu2HLSDp1A/I/Rym
	OKMIjqEeZgJluDe6TxW7KB/W1ai5ZUSVIT1RH4ieSGmXFiEKdbO6O38yABUvhyjdFqvhKpKSO3P
	7SRAXsSwfUzC9zIBeNg0BuJx+tLLjja+T3cEMTFY076cHETwx4tt02k7MYFcRJ4ty3KL6zSkQbL
	HpOzFjaXBeBhdAy80+H7w2FxTQ5WtA8/Q06hnrSB4Ls5shntQMdgz+L3y10IPAP8OlI=
X-Received: by 2002:a05:7301:6497:b0:386:a671:899c with SMTP id 5a478bee46e88-386a6718b9emr2334718eec.34.1795343924573;
        Sun, 22 Nov 2026 02:38:44 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm27124771eec.24.2026.11.22.02.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:38:44 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 16:08:36 +0530
Message-ID: <20261122103838.244974-1-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces two new BPF kfuncs for binary-safe
substring searching in raw memory and dynamic pointers:
- bpf_memmem(): Searches for a binary needle within a flat memory buffer.
- bpf_dynptr_memmem(): Searches for a binary needle within a BPF dynptr.

Both kfuncs utilize a two-tier search strategy (memchr() for initial byte
matching followed by memcmp()) and enforce maximum buffer length
boundaries (BPF_MEMMEM_MAX_LEN). Selftests covering boundary conditions,
embedded null bytes, and dynptr integration are included.

Abhishek Khade (2):
  bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
  selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem
    kfuncs

 kernel/bpf/helpers.c                          | 115 ++++++++
 .../selftests/bpf/prog_tests/memmem_kfunc.c   |   9 +
 .../selftests/bpf/progs/memmem_kfunc.c        | 259 ++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/memmem_kfunc.c

-- 
2.53.0

