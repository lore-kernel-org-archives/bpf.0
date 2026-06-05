Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D3346AF8
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674821; cv=none; b=D0Qntl+rc9smB3h1NotQlKhqgoPm95ZsFfZMMgECynn9fY77/Y+BE8I9GBxuG16ifsdwo+xPtv6PuuuNFr7jJ/CvDbVP9MVhjBR5dBpUng5ohdJqQ8GR6aWNK4IMxCamz/01HKdGaFmiVR46Lo1oyhniIKjRDOq8umjxNWWpolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674821; c=relaxed/simple;
	bh=AsYemdDigXDp9oUoft07eHIdkmpo5Ty7xA2pB9vEs5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4M7gcmguh2YMwqtzBkIJJblAJEqE83bV32Pdbfe0a2v/C3XhuTglUicoVFvL5eZU71Dt6rZFz9mL8pzTuKa/On8+s9mMhJLXjFBMV/KaceRABDR+Sc94enWU1sYPhJfrhszf8Q7OtGbWi1HConJ3GvKKwIONxTeUwuNEa3yyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BITvi4nW; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BITvi4nW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780674816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xUZiWTXEw4+RKNRN80Tns2ahwzMtrr19/1Zrsel1Rgg=;
	b=BITvi4nWlGC6nUca4zaXW/gKilgPhXM1F2BizpObHgiTwp3KsdGcrd3KCnnJKJ4059lpRD
	gYyT9VcTbqP+GN/z4AiDtw70KbMPF3i8KQErskzfct20LWX2DBB5LLDEC9LNYc8pKdi/ZQ
	Vgqrsq1jJtKRL541qt9UQEyOWysjidc=
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
Subject: [PATCH bpf-next v3 0/3] bpf: Check tail zero of bpf_map_info and bpf_prog_info
Date: Fri,  5 Jun 2026 23:52:46 +0800
Message-ID: <20260605155249.20772-1-leon.hwang@linux.dev>
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
v2 -> v3:
* Add "__u32 :32" to bpf_map_info and bpf_prog_info (per Alexei).
* v2: https://lore.kernel.org/bpf/20260604150505.99129-1-leon.hwang@linux.dev/

v1 -> v2:
* Collect Acked-by tags from Mykyta, thanks.
* Update Fixes tag in patch #2 (per bot+bpf-ci)
* v1: https://lore.kernel.org/bpf/20260603144518.67065-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Check tail zero of bpf_map_info
  bpf: Check tail zero of bpf_prog_info
  selftests/bpf: Add tests to verify checking padding bytes for
    bpf_[map,prog]_info

 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/syscall.c                          | 10 ++--
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 55 +++++++++++++++++++
 4 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.54.0

