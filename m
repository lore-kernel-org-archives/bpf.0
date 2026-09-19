Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADB3B4E95
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815693; cv=none; b=M7e1xLDUedZ/al3tC4IXOy5sHohEjDBDPvevtpFT6FxNOJNQ5kqr6S46P7GXQ1+nEfr+mxnR9e3/yayhKceHXcJqrXLZmNJkcG+6QbaDthfIpmALKoTAZjWW20GX7Ir5npeNt3L7Sy2izkovo5AJiepXPc8My5Y2O5d/HlNpchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815693; c=relaxed/simple;
	bh=ieyVfeWZqbE1yKbLmklEHB6pUgsMwiuMSXZ+6dhoRdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBgTo8u/8NdCsuKR3toC6ijIVyitEojaidodp21iv+n2JqKtDQr5I2vR/ccTWTwTQWaFld1n+vJMAQ1uHVkCbp27YlEYgc2IpK3O4h42okyJADI26/E6CAap4oUDqgoP8CX8R1V3Kx6Mb7a5uNieMkIRaW7o875e7YSaDzcnul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clZn9/ua; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clZn9/ua"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1284882a91.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815691; x=1790420491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CrEZGhAP68TvzaEU08InnPyZJBhHkfbU1+U3CFH3UQ=;
        b=clZn9/uaP18IW7DvFCYpoXARmC0vHJrCmEE3vA2XDMVDxCaLvmkYNQBAIcZy2ubVYz
         /qldp9QhV1QGiBjx24mtuouBG8yTfFN+dYbOFPlWd6QpHNOz2VZhALqgTQE7sWq4AKg7
         g5ivaxL97KewFi/PiULHhQ4DDETBrjfhxZQtPve51MjE4D9Svp5NtdoAlN21hNaSMWBK
         dJmNotjQM3et7nzXyHBiv7dO+g1fk7Hagoruz3Q2/wetuwmAxNMKQoLb6gwEPzBfNiRu
         HuVRy3a4dZJIOVZ7ry1XJoNrRYklgvwAzLjEV/MUugn8SyBVoY7Y6tdzaGxF0ULBYYZt
         v3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815691; x=1790420491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CrEZGhAP68TvzaEU08InnPyZJBhHkfbU1+U3CFH3UQ=;
        b=UvqO8ecA5+js7z5nXthO49ORCfaL6a9Sc7K8hYZqyDQoeXFsl5hnvAzUxK2vb2XZt4
         cKXkYEmqUfIFmeH7kng1A1PPO6xsFxQCVzCyOE6aftaMGRmlR5UOc2g9n5GdtlfW0H82
         v0aSnHaQysn+RhqUar6vefGYfW0L0bXiM9sCWGo5CQZfBhfx08F+08ekfsiqvkMlugKl
         yhf7fPXqJ6FSShQbd6f5MwnEQkQDeVLltnUt/O8TDtbvmqIF+oNiUWlByq/1K59TdmRY
         z/sGFBD6ktTYcmXn8eOXAvscV9Qsr81EUN923uu2DAddnSfOBCpXv3zIGEDN7906yEon
         Y2Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzHvF+R49jgO5YhbNzqBsB8tSCZAxiajOHiB3/+febze//Nu57jIID3esj+cKfsoGxM244=@vger.kernel.org
X-Gm-Message-State: AFuF++kcyHnxTclPgcsQm5I4YSMeRdqJ/hcZnuhCXJEL3mE4lPQJ1hhJ
	mQ80bwlFqktmcjA7r0UcfeSQPT2QCB+MHfeUOVNCo7VUNC6DTpCrJH2d
X-Gm-Gg: AYBFou1ChMfdd7iVBvq8Mk4j4puiKmggk8LJqxKAby4nBvQU8NLKomsdrQv4dnzuqDc
	g62coVHDzJQRM9ft1/nxCFT19bgRK5v7M3K9XqduNmyVkyGe7YBtjfL4URAiK1o7xnunOjoBUWl
	omIF+9nUgUYnd2mcEdWu+NAm6ixr8+iYGC7dBSKOObOjGauIFEcl/JEjBF4Nf7jXZEBfLHwAvT/
	0Br3yHlhMIVHb79Js3b3uObD0wNAuWR7a0MebAxbrfpxZbPOsjVcygmQOtngwYY1n2HFjtmWvcI
	shj+tZJBKT4u/aD3SqWNncU9ssEIUiAVp6w8GjMW5kT3/QUQXfBtE/oagvUxiqVo4EGdDFmIGM3
	RGH6hAw/eQSdZg1nhLp/1jEPTPnUbyfRX1hSy9201YnXy2+FXbwfdASFk3VvllZ5kxFKmdowBMf
	BUwhKFee53jk/qlGzduyufu4FSNE4Sfh9LJHALrL2egl/abTmbWNkJEJ7fy2Yvs23zBf8QqCCeH
	JDIWOR9omi604s/Np98dU6V+HHOh5Z4
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-39e6c68ca2emr3126815a91.61.1789815689714;
        Sat, 19 Sep 2026 04:01:29 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm4147054a91.11.2026.09.19.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:01:29 -0700 (PDT)
From: bestswngs@gmail.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	xmei5@asu.edu,
	co+ac0a8c41de69121d@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests: net: test cross-device XDP dev-bound attachment
Date: Sat, 19 Sep 2026 19:00:54 +0800
Message-ID: <20260919110053.497301-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919110053.497301-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
 <20260919110053.497301-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

Add a regression test which loads dev-bound-only XDP programs on both ends
of a veth pair. Verify that attaching one program to the other device is
rejected with the expected extack.

The second program keeps a bound-only registration for the target device,
recreating the NULL-offdev collision fixed by the previous patch.

Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- New patch.

 tools/testing/selftests/net/bpf_offload.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index c856d266c..017910b4d 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -995,6 +995,24 @@ try:
     rm("/sys/fs/bpf/devbound")
     sim.wait_for_flush()
 
+    start_test("Test dev-bound program on a different device...")
+    cmd("ip link add bpfveth0 type veth peer name bpfveth1")
+    try:
+        bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/devbound0",
+                          dev_bind="bpfveth0")
+        bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/devbound1",
+                          dev_bind="bpfveth1")
+        ret, _, err = ip("link set dev bpfveth1 xdpdrv " +
+                         bpf_pinned("/sys/fs/bpf/devbound0"), fail=False,
+                         include_stderr=True)
+        fail(ret == 0, "dev-bound program attached to a different device")
+        check_extack(err, "Program bound to different device.", args)
+    finally:
+        cmd("ip link del bpfveth0", fail=False)
+        rm("/sys/fs/bpf/devbound0")
+        rm("/sys/fs/bpf/devbound1")
+    bpftool_prog_list_wait(expected=0)
+
     start_test("Test XDP load failure...")
     sim.dfs["dev/bpf_bind_verifier_accept"] = 0
     ret, _, err = bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/offload",
-- 
2.55.0
