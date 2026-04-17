Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75573B0AE4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417672; cv=none; b=hrpZDM9wzo0vuBBg1V9r3JgQ3UzUDL65k54OMvE9Wxi8gLHYxbYU9hkVWUxCUI5OYeodG+XmeYexwJOii1OvLxXAnsgKGr2rOfrgINCE6y++NUgIO0CbQDmj34vI/SCIpiukO6FiUB0HfY3SWmQC+7hJVe3RGoL2puHhMnMFXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417672; c=relaxed/simple;
	bh=gGL8y9AF4lTaxH7I3Hf+h4oTv5K4c3+5pygQgEdtzCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MXbyj12MDHfU2lBfzQTdycSUtd7g6m1fEbaeq1AxzBbgUt2f7XXc3BPmiPZgOkpAcVyGBPo7IEAXUISbc/4T2FaHvQYHynV2V7z/tbvBS/EInaHYCwrZ6hsVkypQ2wUb4oYMURZLc8e8kYqdxMaLweyK82NAgDLkYIhZb2yG7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JI3f5Isa; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JI3f5Isa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776417656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i4FscWzLPOcyfss0x+6DvY38XSJbaQ6nBMjNqlK6dJE=;
	b=JI3f5IsaTr2y2qTAMDDHo9qIju1CQPcgv02W0eUzGNGjFz9lg9CCqYN11r1MJlW/ZbSGtC
	T0BgxX7YAqKB3krNQxFjUQNe71h12nZdjfAZqmIulwlQHN5v6DFVzf8mbc5KCN6hNHQqNA
	3jdEVIU4NbeKSkltpuxFxksABA33Euc=
From: KaFai Wan <kafai.wan@linux.dev>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	kafai.wan@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Reject TCP_NODELAY in TCP header option callbacks
Date: Fri, 17 Apr 2026 17:20:33 +0800
Message-ID: <20260417092035.2299913-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid infinite recursion in TCP header option
callbacks via TCP_NODELAY setsockopt.

v3:
 - Remove CONFIG_INET check and add comment (Martin and Jiayuan)
 - Fix the test case (Martin)

v2:
 - Reject TCP_NODELAY in bpf_sock_ops_setsockopt() (AI and Martin)
 https://lore.kernel.org/bpf/20260416112308.1820332-1-kafai.wan@linux.dev/

v1:
 https://lore.kernel.org/bpf/20260414112310.1285783-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Reject TCP_NODELAY in TCP header option callbacks
  selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks

 net/core/filter.c                                 |  6 ++++++
 .../selftests/bpf/prog_tests/tcp_hdr_options.c    | 12 +++++++++++-
 .../bpf/progs/test_misc_tcp_hdr_options.c         | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.43.0

