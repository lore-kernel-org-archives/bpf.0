Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBB4035CE
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364732; cv=none; b=RMvLVbRlggbM+mO2e27v1ypSYlNYqDtQJRoPhGiH03/zH9qgsPPYt3cm3rLYkY+dMD8hqAa3v/ETihkanEnQM1xgh+s/x6cIk6t7JG1IUGYaEES6dykdwSh160X7kK/ihWiYAv171cNIYHUx8R/yrmNP2joDurrM29NcWRry5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364732; c=relaxed/simple;
	bh=EoNw4rON8XzaHA0uEutSrZfbbRMvyo7PgfPlOdOBkbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWIJ6iqmW2LpsuqPcyjJU4OwEpVXxDCWWviRzf1lu8+IPkC0uraxBXCbuOFsIMZSFWrpF45T77h6c92Re8nMmQy5/QB3zHFGzLJkS2YDUVNmlL1iLmJ1ggcwo5UjUUZySva+Ze1x+wbRms+lQ5+4x3YEau4OrpJM0RuQK+r+R0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLwZcOa4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLwZcOa4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774364717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mp06N+shbK0OmAG2sS+vpYyT6SVE6VmkZ+2R/SmM1WQ=;
	b=dLwZcOa4xkEdhUf8UK6PH6sByGiDxFH8LC8tvgwRrebJIQTl10z6/LEaaCEj6kpA/euVLE
	2OOI+3j359tGPdQ6uAtjTu+8uZoSP7m8UVVyoFszGCnjwPdZ5UPVgae3hNRJyUrm2FtSet
	SzDGUyuf9NGwOhonGmqp0osNSd3/lMI=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Enhance freplace compatibility
Date: Tue, 24 Mar 2026 23:04:41 +0800
Message-ID: <20260324150444.68166-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The potential issue of kprobe_write_ctx+freplace was mentioned in
"bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs" [1].

It is true issue, that the test in patch #3 verifies that kprobe_write_ctx=false
kprobe progs can be abused to modify struct pt_regs via kprobe_write_ctx=true
freplace progs.

When struct pt_regs is modified, bpf_prog_test_run_opts() gets -EFAULT instead
of 0.

test_kprobe_write_ctx:FAIL:bpf_prog_test_run_opts unexpected error: -14 (errno 14)

We will disallow freplace on kprobe programs with different kprobe_write_ctx
values.

However, xdp_has_frags does not cause such severe issue.

The issue of xdp_has_frags+freplace is that it is able to break the backwards
compatibility of XDP.

At the commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check"),
the backwards compatibility was protected against tail calls, but it missed the
freplace case, which is also able to extend XDP progs. If xdp_has_frags=true
freplace progs are allowed to attach to xdp_has_frags=false XDP progs, the
backwards compatibility is broken.

We will disallow freplace on XDP programs with different xdp_has_frags values,
like the way in bpf_prog_map_compatible().

Links:
[1] https://lore.kernel.org/bpf/CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com/

Leon Hwang (3):
  bpf: Disallow freplace on XDP with mismatched xdp_has_frags values
  bpf: Disallow freplace on kprobe with mismatched kprobe_write_ctx
    values
  selftests/bpf: Add tests to verify freplace compatibility

 kernel/bpf/verifier.c                         |  12 ++
 .../bpf/prog_tests/freplace_compatible.c      | 124 ++++++++++++++++++
 .../selftests/bpf/progs/freplace_compatible.c |  40 ++++++
 3 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/freplace_compatible.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_compatible.c

-- 
2.53.0

