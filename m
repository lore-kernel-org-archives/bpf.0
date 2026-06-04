Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55412F8EB0
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585535; cv=none; b=j/KyXJk/RxEBFArfe8EdMOOJcOEi6+9mD+lDL6OpEcMkyT1tAqD1rh0DRJ4TBvqfrCPMQgIhcF7aJxNMcM0rItIqKXIqT6FgQ1O7SWnEB93VK+YzRlm6vG3y0Eqj94tLGA3/pi+EjowWT04TgQXXsdaLKCq58qc+PEwrlYXd9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585535; c=relaxed/simple;
	bh=RfKDy9oK0PlJOhdoRCKGHZlh8f7RYJkIx+W4Q573Wv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSobPn/tS+ITkSYojwdGRlh5hmgsZpfu7+Am9hdc1szs9Oythtu/iuUaZsMTFAPQf87k7/2Oj/Zon6xlW0tpo+yJwrPZpMrQKrk+X/mOiNwqda47yNn3F1YHrvQln+xVFmRFhSE4wcM+uD8wHeihXX/2lJoUseMFaQv8J5BYE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kdtu4A1E; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kdtu4A1E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780585530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QxfTvY5CaX+eJ3jT5EwAiE4kyTbDc4rVGXPsieDGojM=;
	b=kdtu4A1E9iM7GwiPPxTYYgknNOvk04SraPT5BoHNGHFinabu9A1ur94OGzUzXEszIkoW4p
	IlTyIcnvFUFafJlg0Sw/xY33szyZGoDF2z8nptIirVhg/7wI5kwHHH3t6pNUmxOOSASskA
	o5bbL8TS1GoSRd18m0yq2kfSclxzI6w=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/3] bpf: Check tail zero of bpf_map_info and bpf_prog_info
Date: Thu,  4 Jun 2026 23:05:02 +0800
Message-ID: <20260604150505.99129-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Check the tail bytes of bpf_map_info and bpf_prog_info due to padding
when getting map info and prog info via BPF_OBJ_GET_INFO_BY_FD, which
was discussed in the thread
"bpf: Check tail zero of bpf_common_attr using offsetofend" [1].

Links:
[1] https://lore.kernel.org/bpf/20260518145446.6794-2-leon.hwang@linux.dev/

Changes:
v1 -> v2:
* Collect Acked-by tags from Mykyta, thanks.
* Update Fixes tag in patch #2 (per bot+bpf-ci)
* v1: https://lore.kernel.org/bpf/20260603144518.67065-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Check tail zero of bpf_map_info
  bpf: Check tail zero of bpf_prog_info
  selftests/bpf: Add tests to verify checking padding bytes for
    bpf_[map,prog]_info

 kernel/bpf/syscall.c                          | 10 ++--
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 55 +++++++++++++++++++
 2 files changed, 61 insertions(+), 4 deletions(-)

--
2.54.0
