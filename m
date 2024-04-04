Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7213233
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199202; cv=none; b=bvHj7wbutE/0S1wTmEocO4E5zfhPRhvW1pzudIWl9dgie0EkF0nZ1SW2bK+LgtsH8Qv/wZUuWJENdXl+jqq1l1hy0Ml7tZNO7c3cmB1FM16RRCGj2NphVOSJzHV1lxOn4KvWMueFIWC4X+oi1wdetEiz+E0pUHzgtBy0ITmuAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199202; c=relaxed/simple;
	bh=/OscLixrV1sGcAiwoOsGWyqaYQO5Zz2b39kJtx1u+0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9/6oeKA4ZQHflTWgrJYqA9NkLa6XPAST3cwPgEfIbLpMWgKwGflLAqx0TwYZxLUfP0A7ZsGGPH9t8Ft+OxewMW7+mW+KkYGaUkLTTQy7rZlLfzpe2NTOkCLZNTW984PqzQXiLe3rhwgfFI+ofHbZXZTs0ZceaTZIDw1EG4w2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9A11D29CEAB7; Wed,  3 Apr 2024 19:53:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 0/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Wed,  3 Apr 2024 19:53:05 -0700
Message-ID: <20240404025305.2210999-1-yonghong.song@linux.dev>
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

For the patch series, patch 1 added kernel support. Patch 2
added libbpf support. Patch 3 added bpftool support and
patches 4/5 added some new tests.

Changelogs:
  v3 -> v4:
    - use a single mutex lock to protect both attach/detach/update
      and release/fill_info/show_fdinfo.
    - simplify code for sock_map_link_lookup().
    - fix a few bugs.
    - add more tests.
  v2 -> v3:
    - consolidate link types of sk_msg and sk_skb to
      a single link type BPF_PROG_TYPE_SOCKMAP.
    - fix bpf_link lifecycle issue. in v2, after bpf_link
      is attached, a subsequent prog_attach could change
      that bpf_link. this patch makes bpf_link having
      correct behavior such that it won't go away facing
      other prog/link attach for the same map and the same
      attach type.

Yonghong Song (5):
  bpf: Add bpf_link support for sk_msg and sk_skb progs
  libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
  bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
  selftests/bpf: Refactor out helper functions for a few tests
  selftests/bpf: Add some tests with new bpf_program__attach_sockmap()
    APIs

 include/linux/bpf.h                           |   6 +
 include/linux/skmsg.h                         |   4 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/sock_map.c                           | 268 +++++++++++++++++-
 tools/bpf/bpftool/link.c                      |   9 +
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/libbpf.c                        |   7 +
 tools/lib/bpf/libbpf.h                        |   2 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 171 ++++++++++-
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 +++
 .../bpf/progs/test_skmsg_load_helpers.c       |  27 +-
 .../bpf/progs/test_sockmap_pass_prog.c        |  17 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 16 files changed, 545 insertions(+), 28 deletions(-)

--=20
2.43.0

