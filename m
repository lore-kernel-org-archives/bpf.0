Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F6320393;
	Fri, 23 Jan 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157807; cv=none; b=bVyYcIBmUZbyQ5LAjsoihOZi+9224g6yRNUgyOKyC0vF1h3JrDemqCUV2h3OCjt4WOhbiwdPmYx0wFRfuv5JtL73DqfsS+srIB5caJrU4cRXKmKL+4M3ekQQSjS3Z9/1uQ2ueK/IQtcGNqQm9GeGNI+Q70B6R9RGEfiUo18ub5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157807; c=relaxed/simple;
	bh=hdRQXtpBDp/KrhlShTrDcvoJUE3SiCXTz+WfNVB3Ngg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBIgzCs8Dn7XQD1PSujT2ed9E1IRfhx6gy96OpxF2WIN7MsUBYqcMWbdtZkws1c7GIwIe4BwrFu3I+YTzNiyR6d1rDBmi5OLmPTMnSt8waRzO4fEJGruTfjL8PInE3ZavZUu4hXCWDx0H9EI7DhJgN4dIDUg0UMAY+Yt9tZbFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ww+zHeF6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ww+zHeF6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pU1OQJT0Jh/2bTQ5ipBAyQmVOFrZ5xe/TVYCbtEw5Is=; b=Ww+zHeF6MRigOxpKuIuhWJE90c
	xAUuv24X9e0pia/sScHG4eHe3ePfFAoAPBBjBYygajWWaq31gxvf3EQAfBboSJz0CPSuz/8qVARuQ
	POTXB8pc6Djr4vU1GyTSdBAZSc2yo+yZ+8zputD1orr5ExapDYXX5BnnI3liyWmPXvCPS/r0UmZpB
	/7ACGBi2sdPQAb0jjoORJQJ1kMKTnWO9wE17XzvZlDjpXTmZTIbfg2UFgNKL+YA+N/RwrkUWt8jTQ
	blXLvluUHG13gE/Zh1oNo6K3ZP/LD64XF1OQzifm72TTNZfFqs+OMSCTiUJjyNLxuP1FLYNmPDavm
	MSqNJ3vg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjCkt-008nS3-VF; Fri, 23 Jan 2026 09:43:01 +0100
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	kernel-dev@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH bpf-next v1 0/2] bpf: Introduce execution context detection kfuncs
Date: Fri, 23 Jan 2026 17:42:46 +0900
Message-ID: <20260123084248.259278-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces four new kfuncs -- bpf_in_nmi(), bpf_in_hardirq(), 
bpf_in_serving_softirq(), and bpf_in_task() -- to allow BPF programs to 
query the current execution context.

While BPF programs can often infer their context from attachment points, 
subsystems like sched_ext may call the same BPF logic from multiple 
contexts (e.g., task-to-task wake-ups vs. interrupt-to-task wake-ups). 
These kfuncs provide a reliable way to branch logic based on the 
current CPU execution state.

The series includes a new selftest suite, ctx_kfunc, which uses 
bpf_testmod to verify context detection across Task, HardIRQ, and 
SoftIRQ boundaries via irq_work and tasklets. NMI context testing is 
omitted from the suite as NMIs cannot be triggered deterministically 
within the software-only environments typically used for BPF CI.

Changwoo Min (2):
  bpf: Introduce execution context detection kfuncs
  selftests/bpf: Add tests for execution context kfuncs

 kernel/bpf/helpers.c                          | 44 ++++++++++++++
 .../selftests/bpf/prog_tests/ctx_kfunc.c      | 59 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_ctx.c  | 51 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 ++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  4 ++
 5 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ctx_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ctx.c

-- 
2.52.0

