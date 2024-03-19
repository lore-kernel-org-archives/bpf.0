Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAB2D03B
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870858; cv=none; b=WRnIBJxawFiFT/4N0UmPgYUiEOruTJRInm0UinOiUy73V3fib0Ix0qDo1YgEeh29NHAMALU8sK3XPuG3HqcgcR4ZDuKiBzZWukELK7w/bd5j1qT8TJ/jESN7ojm2TcGi5kzgcbFtV2frSFHHksVXefBS9qp5CSyu3o5t3UB+k4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870858; c=relaxed/simple;
	bh=w8udPClLz+XVxtw2duTpgZqSu7Ab98JDwhPX86uANs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0HI9PBv2Xpv94kyhKEV/092EE5MKDP9k05HWVCVISwsd6+bu2biRvYKbT6qBMGQgR57216tikEpMAE49jobKFfj/pk8VSKX2shH5jNaHzQNiAG7DZBGqbhSRsCAavl64GsGfqMFQJ6tJlzEq05GDj8sWqwc/ybOMNfY4lf7/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C877C206A7AE; Tue, 19 Mar 2024 10:54:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/6] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Tue, 19 Mar 2024 10:54:01 -0700
Message-ID: <20240319175401.2940148-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One of our internal services started to use sk_msg program and currently
it used existing prog attach/detach2 as demonstrated in selftests.
But attach/detach of all other bpf programs are based on bpf_link.
Consistent attach/detach APIs for all programs will make things easy to
undersand and less error prone. So this patch added bpf_link
support for BPF_PROG_TYPE_SK_MSG. Based on comments from
previous RFC patch, I added BPF_PROG_TYPE_SK_SKB support as well
as both program types have similar treatment w.r.t. bpf_link
handling.

For the patch series, patch 1 added kernel support. Patches 2/3
added libbpf support. Patch 4 added bpftool support and
patches 5/6 added some new tests.

Yonghong Song (6):
  bpf: Add bpf_link support for sk_msg and sk_skb progs
  libbpf: Add new sec_def "sk_skb/verdict"
  libbpf: Add bpf_link support for BPF_PROG_TYPE_SK_{MSG,SKB}
  bpftool: Add link dump support for BPF_LINK_TYPE_SK_{MSG,SKB}
  selftests/bpf: Refactor out helper functions for a few tests
  selftests/bpf: Add some tests with new
    bpf_program__attach_sk_{msg,skb}() APIs

 include/linux/bpf.h                           |  13 ++
 include/uapi/linux/bpf.h                      |  10 ++
 kernel/bpf/syscall.c                          |   4 +
 net/core/skmsg.c                              | 164 ++++++++++++++++++
 net/core/sock_map.c                           |   6 +-
 tools/bpf/bpftool/link.c                      |  18 ++
 tools/include/uapi/linux/bpf.h                |  10 ++
 tools/lib/bpf/libbpf.c                        |  15 ++
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 121 +++++++++++--
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 ++++
 .../bpf/progs/test_skmsg_load_helpers.c       |  15 +-
 .../bpf/progs/test_sockmap_pass_prog.c        |  11 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 15 files changed, 410 insertions(+), 23 deletions(-)

--=20
2.43.0

