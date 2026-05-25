Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE83ED135
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719257; cv=none; b=uer6xScWnBDMaaWIhulAEkPhkBB5ZG+MSCgu6AANzJkOuPjbmIqObEk74S8h/o6dmvDcqWpdUxuCzq1G5pXVt/RuEaXg7Al0QfyuHdc+HA9G6LVIF7/DG9AlTueRnrJjwAcoNNV8Z0cvWoNEs07Tw+goHQApk+vouhz0ZoEDoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719257; c=relaxed/simple;
	bh=DdlJTwgcH8Hskm0aQlb2+3MO4khdT7+xenazzhACAsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlTRrVnrmvRmWMB077cYkwyoI90oo78ug6F/aYfp0I+uGJVlEIMHBpmNgOZ52iMbn5sPN6Nal+Dod9P8dZVXBDi1UMP+LpyJ7yUnD9QBcBoMcmQnjeQNsDIdjMhay7EnhOZ7dRdUtgXr93cNbQtpt/CxnCQldyvY9/xVIDu5N+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BEKGalBM; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BEKGalBM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779719244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CS+d/spaUBgHeMwKFqcNkDbODw+p/c8/w3UbPt/Fbq0=;
	b=BEKGalBM1kBP3fQJkbY8KEb0CchgrZASv+1VCe+ME4Ex4NyHdRbypQvy+pDd+RlOa5wkTG
	VsO7NlWFcnbsfR0+CoIrz4kKBgk0zeXDDKgzalHyy57tPdvt7DYMgL+y4vroni2l+PHca/
	x04KiOKTg2OZ9Z9muNI71sYybhTqlcM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf 0/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
Date: Mon, 25 May 2026 22:26:48 +0800
Message-ID: <20260525142650.2569-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver, e.g. ice, reuses the stale skb->transport_header to
offload checksum computation to NIC hardware, VxLAN packets encapsulated
by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.

Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP, so checksum offload works correctly.

Leon Hwang (2):
  bpf: Update transport_header when encapsulating UDP tunnel in lwt
  selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in
    lwt

 net/core/lwt_bpf.c                            |   4 +
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 153 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 112 +++++++++++++
 .../bpf/progs/test_lwt_ip_encap_fix.c         |  36 +++++
 4 files changed, 305 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c

-- 
2.54.0

