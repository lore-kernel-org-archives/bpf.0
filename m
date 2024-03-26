Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434F8287F
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419731; cv=none; b=rdjPOXzgKOwQazjhYPgVrVwD+NU1ZgKp/yM62AdTlHTxuj42FwRk9aW1H5kXKyQ0mO2uHsS6qNHDA8RbcJvW4kjl1uPjtW/cTcBiIyr1ifGJI/XrIMWKQVtQo1wTXD4HnP3ySgfhyWB7jz7TIfkkQ++QbLChKIA9RWQ80S21SEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419731; c=relaxed/simple;
	bh=zo28Nqa4SArFr7gRtpvVv+HSl02o7ZdRBy73ayf+GNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzRULUvbirqNKDNsnvTH/3cx8166WNC9JXW3ZGNwdvRPEpXRgqEwnOSZov3q8UVxKZolXuh7pRhEDHErsV5HRDdlUWGks3c6GmuoqN2dBdW2rCvx10F6tChjknG/T/Fezd8BdWaVg/3vLlfXWXEudM61+m/q77z+TaAeM9gdhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id ACBC824DD1DD; Mon, 25 Mar 2024 19:21:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Mon, 25 Mar 2024 19:21:53 -0700
Message-ID: <20240326022153.656006-1-yonghong.song@linux.dev>
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
 net/core/sock_map.c                           | 263 +++++++++++++++++-
 tools/bpf/bpftool/link.c                      |   9 +
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/libbpf.c                        |   7 +
 tools/lib/bpf/libbpf.h                        |   2 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 128 ++++++++-
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 +++
 .../bpf/progs/test_skmsg_load_helpers.c       |  15 +-
 .../bpf/progs/test_sockmap_pass_prog.c        |  11 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 15 files changed, 473 insertions(+), 27 deletions(-)

--=20
2.43.0

