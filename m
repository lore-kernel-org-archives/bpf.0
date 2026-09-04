Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D73A544A
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505342; cv=none; b=b1yrnDkgYIjHWuu/YeFsrgsHED42Hr3lp0xL+SQDUtj77A+ZDhW/nqA7POTkUL6Xmi0QHvKQ4/x5BZ28sjEOu2+P8MWiXjG/jOPbsf4DbnDstz/wA0q2ZCa67J0TiOM6yZfSgwYceJVlCHOcNpR+W8cFq8h1qWbXx2yfrRUSbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505342; c=relaxed/simple;
	bh=OsS7JXbczUOKWByEP5CiGAcQ+FzXXK7rO90IZ4MvpM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cr2rKCF+lulEYejTDAo8PqMLlQUxW92tkmz1xc2lw7mygbhLOlb6a2w9TyFRCY8o40IEe4Ii6O6RjLZec2jPO0RM1kp3GCe02cxMCHNHB9hKBEz773nEC3IabaCr1c/25V+SYkyxXKixph3/jktfzn0zSxv8fhzB5bXrzP4iVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sc34Oxn2; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc34Oxn2"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2d6fff25530so2009285ad.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788505340; x=1789110140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2JcMzX/PCeTf7UGtxAjVYfuJkqAdewy/yttwf8L/2oc=;
        b=sc34Oxn2DaydCYOoLpXKuzrz/V4nm5LW8E3DW5Gp45xF5akMYYOlqGOv+eV/L4AWjf
         QOl3ysR1pl1iKj55V/xOElmsZFnwGD0yjgwqLEZLHWXBOTOI/wVlrkPlOaU1lTux6d/v
         OsrBJL/nRIpP6cHKrcU5uPYhugIgyhmQAW5ldsaJ3EuBnInJWksOZeVW4kWEpagsOTvb
         EtnPaJfBpG4nw3LNWuT370supaJ5WUZ6Qpktmw3enWFpqVO8YkF3c42V0sS4MFsftO1Q
         KV2Txe6Y6gvyiKqS+0/f3VIZqMObBsh1KUUcft0J9+Cj0qhSSSsOEk0N7SQW8QypqoNy
         8EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505340; x=1789110140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2JcMzX/PCeTf7UGtxAjVYfuJkqAdewy/yttwf8L/2oc=;
        b=BhYAe430gEmNJHSxyC1fTeFJ2GeRmr0vM8UR9QCF+g+aV+O745xtE17y1gXaXbrWrd
         SOGO8VaVb8kRjgAbTjQVuCfbMLkMKIwHpQcVGwW6cZPOdymfSVTHy53+LO4ZsMOsgi9a
         TQp2QGcZt37FuB4oi4ryAsHBR5L1JTwIhd+SKptZ7qZzWBU+mTFZ3OlZTSAQDH5I55Nn
         cUxxVeX0b686rlR9zfOTfTK4Fl35NFdMWQ++3K/07Ud9gWXZFNe5PIuLmvkUwVm+MpVd
         IHwzduErp0EV9Scbz3yq3XcWZnh249DH/QPzq9Al4QAG6NGSQA5ZL5hsrzpK58vOq4Im
         WATA==
X-Gm-Message-State: AFuF++lUEVWnmv6D5hVC2OUqhiaWRIagwDEZDDEJxNqYsJh1l4VyfL2F
	g9a2f05uKtVoOHpADs8E+KIjVSDi+sWd6M47ixxKGR6Lgt53ccJ7+E8QWQ4JDcniiqxRbeY=
X-Gm-Gg: AYBFou1nZBeclqyVu+SngaThD0T+kWyrEjwa3CRDLF7ZmjmG6X1Pin6wr8JiKDlqpLR
	Ehv1lV2MzykvhngCSnOQC8cLmq+qq+6Ef7hfWNPs0ZYdKt/iuhYLvWwR+mDzLQHmvdPV+V357V5
	MXKU0LrO1ieeUlUiXEnrR+X8JEGgMP3H5fRQnA2kMX10taLVqpn0KlRrd0+RZIBo4dZpXYwQieT
	dVRBcqGmWmY4W3X+ItZeUBN39WFVyYUEoIxxazsS1pXLBU4phB/v8I9VXRRuZDxWLwz7V2n7fUD
	k9vxRuTfgbZ1KY0o0h9lwvyDj88l62RnucmRhQAY/Z2b3GNV1gZibdnpJweONTj5KgYCo9N4IUT
	zLPdpkPYkEkcVeZaAIy12eEwZSC1n+LWQ6NEjlb/f9iIaI33/zPLA7sv2NA/Wz7LuoGrD/7l2sz
	9ZEjoVemLOfv0zR+sOiDJP1/fIwyvFnfz7EYoYslpK7M1I9U/kzjKbmohzPrDn5PcundiXabbSh
	dFjQdlSJhGBYxoHh8wD5X5R
X-Received: by 2002:a05:6a20:6a1d:b0:3c3:a31b:3949 with SMTP id adf61e73a8af0-3da39d2e51amr5960262637.11.1788505340274;
        Fri, 04 Sep 2026 00:02:20 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615273e3a0sm755511b3a.23.2026.09.04.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:02:19 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xu Kuohai <xukuohai@huawei.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH bpf 0/2] bpf, arm64: fix the exception callback's frame pointer
Date: Fri,  4 Sep 2026 16:02:08 +0900
Message-ID: <20260904070210.4163193-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 JIT does not set BPF_REG_FP in the prologue of an exception
callback, so the callback runs with whatever x25 held when bpf_throw()
was called. A callback that materializes the register, for instance to
pass the address of a local variable to a helper, then works on the
frame of the subprogram that threw.

Patch 1 sets ctx->fp_used on that path, the same fix commit b114fcee766d
("bpf, arm64: Fix fp initialization for exception boundary") made for
the exception boundary. Patch 2 adds a selftest that reaches the case.

Tested on aarch64 under QEMU with vmtest.sh. Without patch 1 the new
test panics the kernel, because the address handed to the helper lands
on the helper's own saved return address:

  pc : 0x1234
  lr : 0x1234
  Call trace:
   0x1234 (P)
   bpf_test_run+0x188/0x3e0
   bpf_prog_test_run_skb+0x47c/0x998
   __sys_bpf+0xbdc/0xdd8
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

With patch 1 applied the whole group passes:

  #116/11  exceptions/exception_throw_subprog_stack_cb:OK
  #116     exceptions:OK
  Summary: 1/118 PASSED, 0 SKIPPED, 0/0 FAILED

Not tested on other architectures.

Donggeun Yoo (2):
  bpf, arm64: set up the frame pointer for the exception callback
  selftests/bpf: cover the exception callback using its own BPF stack

 arch/arm64/net/bpf_jit_comp.c                 |  2 ++
 .../selftests/bpf/prog_tests/exceptions.c     |  1 +
 .../testing/selftests/bpf/progs/exceptions.c  | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.53.0

