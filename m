Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9C1624C0
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367911; cv=none; b=baSJ4Wr9v0pV6BSIUDGjs1y1HHC+KB7ngKwKog74nbLiynNE3ytDU5wER8NR+kFPMQq5PMJQYXyavHWOmuJKQXKLHgrBYdq0rK0st7gDRRdX/I9/EoXH8yWl9BjQ9A5Pp4pkC55Hsot6YALjFan8t1pu2E6UwWQUQlGDfhd1NAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367911; c=relaxed/simple;
	bh=OgriboyLGBq1OvYCDbQzdpIjXmH4ZidnQhMNU3HNkHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UToaHuxa7ofwRxLiqd5fIGx1Bh7ND929A0CEyN4lzsZ5zZOEmfpjPUl7OzNgNUj1wZcQNLQcD7GS4iXs5whJSWALODVLZsK21HvdCsE/9f77P7GulKXNFrIxOgus1Hf5QZqZHrgBbEHAY5Wgri6FDLiWHSHKsfr5G4f7+Dn9r0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l6+5jb+b; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l6+5jb+b"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781367905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ImC2eKAv7X6MMI3LOcfOOKpY8B6ljjxgZ9VIjTi7C4k=;
	b=l6+5jb+buF7AKHTZk0+70TrkdYkowlgEybabSdGvrERVuWcexnjkAFg8ol0utvGdGsgkcM
	6HvWuJrMtUiZqBZXxS+/rhWmSL6Mo7m8n7d0SPc8BHL5U/P75GLwUx85yPlZNQLT9bvX9R
	pCGK6be/SK7TsE09PEYMwz63Bgq727E=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/2] bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
Date: Sun, 14 Jun 2026 00:24:41 +0800
Message-ID: <20260613162443.60515-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When TCP over IPv4 via INET6 API, sk->sk_family is AF_INET6, but it is a
v4 pkt. inet_csk(sk)->icsk_af_ops is ipv6_mapped and use ip_queue_xmit.
The tos sockopt does not work for bpf [get,set]sockopt() helpers.

Changelog:
v3 -> v4:
* Add 'sk->sk_type != SOCK_RAW && !ipv6_only_sock(sk)' check.
* Re-implement test with LLM assistance.
* v3: https://lore.kernel.org/all/20240914103226.71109-1-zhoufeng.zf@bytedance.com/

v2->v3:
* Use sk_is_inet() helper. (Eric Dumazet)
* https://lore.kernel.org/bpf/CANn89i+9GmBLCdgsfH=WWe-tyFYpiO27wONyxaxiU6aOBC6G8g@mail.gmail.com/T/

v1->v2:
* Fix compilation error. (kernel test robot)
* https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/

Leon Hwang (2):
  bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
  selftests/bpf: Add test to verify the fix for bpf_setsockopt() helper

 net/core/filter.c                             | 15 +++-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 78 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 23 ++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

-- 
2.54.0

