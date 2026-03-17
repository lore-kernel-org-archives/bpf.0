Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0755288D2
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746335; cv=none; b=X3k69HujFKNIZ3mF+6sglFHoCZs0jsdgAamvJvpmYIld/d0Bs953xpC2mJk2aol3bv8L2YCGGGtF4fvZ7LWpWdSp9BYO/jcfFWTZF4rirGS7LpT4M24c5mRJcNBQI90VSWUIU+toFmHcdmx61RJIOkSWopLADtScKrr3IFUM0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746335; c=relaxed/simple;
	bh=KFlFJ4ciiOxf/VtyvH918HFgXG4tkPSLar79PYdP5L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRqKisaRXSxLvNrqfEkSPuhkHuxB9z8aLzReZLreBqiqveNdSGU3Y4uCq2SQ6R1GfmDg3kzePtaZd3k2HQ5aVy3wEYbs88CyjvWzHwVuwQSuwvyII719K5TkRsTnKIx74ZFy8Uj61oCwGZ2okOPGlapIUh0xYluMCERRRs8qrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYmAz6kS; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYmAz6kS"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-467166cb638so2008165b6e.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746332; x=1774351132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PpB4nP+X1oBMB9xcDx+FfYzdaZ+sNKw9qKTlpfhFsI=;
        b=iYmAz6kSQmU3SpSkKgFKVXX9jgZSw44o4FL5fscq2O4Y2cSnJds4zjwoWq8pbVtixY
         1ToTD1o2riaaGEGVODoF71axGGlS+jQ9PWia6+vMIvJeh8U0TEv19FB5KbYDdD2m8deO
         zeCe2+t83yDpDBCov2NE3Y1G83tRkvR9ftmgqe5OQhSnbUrmBlDLZfygiJm3SojVNnoA
         NnD/ob2O3LYK6bO0DNoQhSNeird1t9wavTOHTDMduDm4rmYPweUTp3IMTZZuZ3+odN2d
         0H35kxqZMmyc7OBk2QDlYvhvgS7YgqjSxlDZ7E34ZJoxcDCDP1ywJx7uXSa5Z8dVeUzA
         SRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746332; x=1774351132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PpB4nP+X1oBMB9xcDx+FfYzdaZ+sNKw9qKTlpfhFsI=;
        b=AUb2DinhEkKUs8AwVKtQ4wzxm3XCuPtcxLdqR4DjYjAB0QsHV4417hizP28huSstdp
         T1yENvpjbPTlE+Myy3a2PYOjA/wms6drX3ceVVWUUERA8z2Linti+PzJPPUKrykQl9E9
         P/d3aLkWIInhITfGZjjKidAxBq3sJJd3xYxfjt64DLgpDrsjz8Nz7N5zkvXTUnM4CrxN
         nI6xFVa9hrX0Df723T68ma+59H4rvCjn2GjVzM+1aR10EHxL88w/yoagwfTUNdkPUCdn
         g75ibkebL7G8jR3CzSmTENeFQhmrtbdJZnp/Dl+WxVvSKip/dIM0bsjxSQomaJ/Q8G7z
         EOWA==
X-Gm-Message-State: AOJu0YwAyT3NcIKC3GwOHAT/n+Bq2LCjEzVw2J3vmAf94UXlk9OmQcSk
	1wJlfMXgCtu85CkXg+YTwosc7B1JCL/rNs5AdTalAE1/bGEIPE2DT6QTYCMb2W1qw80=
X-Gm-Gg: ATEYQzysL6KuOwNHHF5FHfcjNi0zoTBAI/Xy0uZHUrsK6eSJVT/UrkV8LT2jXuvigLj
	ABPhoftP6wtCtbqY20eq2soezJJM7OkYVS6nV1QrDF/6MQnpiBPZfz5jyxtNjQcSHDnIpNtI9UJ
	N64lpTFDoz5RtQPsvqhod8if8com7O4lhTVHuKyzlUj5HG2TApW3vgrEegnceBu6uQUddrXyFYC
	m6mBntJPo0y5VaPLZqs6OReepXgRlnOXJGaSyfR9OZdZwCEorS/RTW/2MYDyJz0kRAH5vdtI8Di
	JlDuQnbPcJ3Xk6GqHAnOxVxKh19iRl+81rDdwSEdeF7uKJedPKEU/Gm5jtoR1Gncx/P9B0eyk7U
	vbypI6eN1VR/VkMRf78w6ujv+bkav6uUKcqfTaLfyn0PU3Jp8VCPjMzFc157mubuT+q1mbfsNWD
	/5tuUn8C6wxgJjj4FL4AxnOf8hmjqxAj7jvXqWL9Xwq2L2
X-Received: by 2002:a05:6808:4f4e:b0:450:471:b9ba with SMTP id 5614622812f47-4675707b853mr8671997b6e.14.1773746332037;
        Tue, 17 Mar 2026 04:18:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4673415d291sm11065422b6e.6.2026.03.17.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:18:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/4] Allow variable offsets for syscall PTR_TO_CTX
Date: Tue, 17 Mar 2026 04:18:45 -0700
Message-ID: <20260317111850.2107846-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; h=from:subject; bh=KFlFJ4ciiOxf/VtyvH918HFgXG4tkPSLar79PYdP5L8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpuTHi2k7z1x312OB2Y1la0qb+diqD7d/qZZnzhIkK KiWkNtaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabkx4gAKCRBM4MiGSL8RyqD3EA CPvv7HWj1tI2rkNw6BoDO4q1Nk6vLvEQSZ//1Lphf1eTR4MkR0le2RtxG9fOYNbL9BwB5hMe5xJuRT 8Hs3JMhUL5xAS455KJ2RzXxBkaR2qxdVmZXq8GnJKHTclg0phyOip7cgW72YOx9DWvmqYBUK3SrcdQ RxLx+7CSU/tH5Nm0QgqtiLmGfOvGTQHpi/jCawZkwLJl/B/DhW8f7+7abT58oogRBjTsIoHgI5ygxB dcJOtGP8SBDH3d7VA372SGRYAEERZfAhDS0mOUCnrvt4cr6GXr+fBCs+xre3K05R5vd0LeCJ8jrslD uXzh1hZF9WjLWs/SVWE8Kn9BmDg+TQeXl4f3gPYnSt9Vqqr678ByyZAmIXEbdh8vWWY72QWjCbSiM1 2KpfAMU0vaoOFPbyLRXT9jxJT6ZtBs7Yeqy6QdPsrKOy3Z3NGI5ErnspfpXMerj5eBIJMOTwYy5RTy cmJVWGyokheJqQI5v+N08v1INwVUA1v02vmiyPgumyQYUBH+9N2eRnSWlZKDpCPZE7ubP5mzBXM8fd RmQdwJq71WuymtC9OPXXRQD/K1VeTYj1mazw/aHtXJ84Vqgi8GhpvtEdeiR8s4ROvIWJpHutNpteY7 XQb+YdCSDQ0Vcnp7YbA7GnfXcrNncGO1K5h7VDPbPAxkqUtOgqVs1eQds35w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Enable pointer modification with variable offsets accumulated in the
register for PTR_TO_CTX for syscall programs where it won't be
rewritten, and the context is user-supplied and checked against the max
offset. See patches for details. Fixed offset support landed in [0].

By combining this set with [0], examples like the one below should
succeed verification.

  SEC("syscall")
  int prog(void *ctx) {
	int *arr = ctx;
	int i;

	bpf_for(i, 0, 100)
		arr[i] *= i;

	return 0;
  }

  [0]: https://lore.kernel.org/bpf/20260227005725.1247305-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (4):
  bpf: Support variable offsets for syscall PTR_TO_CTX
  selftests/bpf: Adjust syscall ctx variable offset tests
  bpf: Reject modified syscall PTR_TO_CTX for global subprogs
  selftests/bpf: Test modified syscall ctx for global subprog

 kernel/bpf/verifier.c                         |  62 ++-
 .../selftests/bpf/prog_tests/verifier.c       |  34 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
 .../bpf/progs/verifier_global_subprogs.c      |  43 ++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 5 files changed, 409 insertions(+), 88 deletions(-)


base-commit: 2364959abecb052d7b798ae51d0626edec8b9288
-- 
2.52.0

