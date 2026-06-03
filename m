Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD933481AB7
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497955; cv=none; b=Dolpw2vPx/7ge3PALZuwVsw5VP6pC8f2eIEFN6tSDlh5Kx7b8cqP0q6eIjb2TEFbvIYLPonS/bwvz//Mr3cWtp/u1RiSCQAPyrTAt+bbGQ4kMzZT0ftS5QyBkpdm438lOCKSaBNhy1/9h3ygtdXcjwYBYfAobf/bE69yxcR58CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497955; c=relaxed/simple;
	bh=SsGMRZT/cVUfvDTh3BrHLrehtRXQHPp7zScLtzXLPEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe1aqINZprzniv8abCQ0xiHIPTFsSY+SWnoxJsWw95RnBh13LbJva1tsf1NTRDLKcCVZu/85vQjCfE6LmQ9+jMFgHWcnfnwoxFTugoFOXA9EcwJeuZ80YRK7tMsmJIE4CrEnnyI2Y7fRKgrvu5iEdNzzJYK466LcpHa7Q6ooPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=af6fwyHg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="af6fwyHg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780497941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tCvkTQdNVGT6vvkggJMveRuS5pMByZLtK/66o49e7Pg=;
	b=af6fwyHgHZfITkW6jQG8qAeC4OO0gcdipGjsYxKNhS1amjEpKWJnu3ereRUU7tBebpCXOM
	pCJXa3E1BwwXj2YDd6WVJ1oM0nAvHVX/+KMRn7TAryAEQwPZjQK6oJIP+d5A07zpIVppWr
	NWrUfAfH3q3/9ieA0Lrdz6f6AkiTM1w=
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
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Check tail zero of bpf_map_info and bpf_prog_info
Date: Wed,  3 Jun 2026 22:45:15 +0800
Message-ID: <20260603144518.67065-1-leon.hwang@linux.dev>
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

