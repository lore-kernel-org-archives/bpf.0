Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3536308D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787158; cv=none; b=nfY2bVoJJ05joeS37benRQj6lRjJ+TqWcOisaHKHek7bhxqER1mGFZuE6adiI4umazeCZkucLqtn2ZcrnD2vZQaM2jYCpkDzpiAatWvny04Yo+PKOcAEKwW/x90JbnnzPzUI4tXDbaOYVl6sEJ3eFeTAxcOSjn08ucAekzL99Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787158; c=relaxed/simple;
	bh=k6+jasbC8ffBzSw2C6ofjZu8PltLDxN6zHPlBDQJS7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WXJavNXhaac3+784vuYeWqzsuwibCxCiyi6KCorTeh7dCfXJh6fk0nV+GeswuWz9UEwqY5lE/tr1+x4HtyVBXUo8EMBWH1BWOJgD8w+6y2QdIASL4jS7LNSguUOu3kdFOmASmSxRSCOhzQpgutl3sbHO2M6KCMKkFh/ID8ihdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rgn6Z7U/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rgn6Z7U/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776787145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+aOQ3Xw/RZsMMWfJ+rkdu/KGc82gkMlhZ8lAN8cJ7wE=;
	b=Rgn6Z7U/ep50s2sSwEmPX+H6pBOF1dVOqSD+yEIoouTNOPZ/4dOR+LdqWKRwkhmPU4iOuu
	dmdF64UUquroRvHI1Ru2Z8Y/otfetGt84RzlBFzvxGuEezxFgQYiMdf6rh/fJv3S8DUR+V
	v9kk1rlOeOc3sZSh1hj8RTLsMT5ZuA0=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	ihor.solodrai@linux.dev,
	kafai.wan@linux.dev,
	jiayuan.chen@linux.dev,
	hoyeon.lee@suse.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/4] bpf: Reject TCP_NODELAY in TCP header option
Date: Tue, 21 Apr 2026 23:58:00 +0800
Message-ID: <20260421155804.135786-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid infinite recursion in TCP header option callbacks
and bpf-tcp-cc callbacks via TCP_NODELAY setsockopt.

v4:
 - Fix the test case for TCP header option callbacks (Martin and Jiayuan)
 - Reject TCP_NODELAY in bpf-tcp-cc callbacks (AI and Martin)
 - Add a test case for bpf-tcp-cc

v3:
 - Remove CONFIG_INET check and add comment (Martin and Jiayuan)
 - Fix the test case (Martin)
 https://lore.kernel.org/bpf/20260417092035.2299913-1-kafai.wan@linux.dev/

v2:
 - Reject TCP_NODELAY in bpf_sock_ops_setsockopt() (AI and Martin)
 https://lore.kernel.org/bpf/20260416112308.1820332-1-kafai.wan@linux.dev/

v1:
 https://lore.kernel.org/bpf/20260414112310.1285783-1-kafai.wan@linux.dev/

---
KaFai Wan (4):
  bpf: Reject TCP_NODELAY in TCP header option callbacks
  bpf: Reject TCP_NODELAY in bpf-tcp-cc
  selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
  selftests/bpf: Verify bpf-tcp-cc rejects TCP_NODELAY

 include/linux/bpf.h                           |  1 +
 net/core/filter.c                             | 30 +++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c                         |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  4 +++
 .../bpf/prog_tests/tcp_hdr_options.c          |  6 ++++
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 12 ++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 15 +++++++++-
 7 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.43.0

