Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6821292C7
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670133; cv=none; b=fMQP5q1Yn8KX98CUHlevO1bkP7Yep/H/m9Hj7p2NydNDEvMHZoNYeFFHexSR+Oo9x/h32BYmn8hHzj46rM0oeoXOdY6i675BUfqvz9Y2NsC6v3McOfmeo90UscYASLmGmcyiNnOb44vQx99L172u9W+eJTAOn4bvv/XwnE36Mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670133; c=relaxed/simple;
	bh=l+mXzYpKxptKj9ePtL6zsBIj6Qiau4/+WAG7l+qnnzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nypdwA9+GESNUxKIX+Xgcc44sSoK9pSoBBg7gF+Yn03+2pGZqNpdOG2vtBfBnPWaX+ijC2WDabDs+KayDXyVzFBgdh3UuogQqTvg0XaAG+41dJ9sQ4BNbOcsICdrAfEanu2HrPZScXXaldS+wzHU974EBYA9WO3XCSa2zQln6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E47A114A90F2; Tue,  5 Mar 2024 12:21:55 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 0/5] Add bpf_link support for sk_msg prog
Date: Tue,  5 Mar 2024 12:21:55 -0800
Message-ID: <20240305202155.3890667-1-yonghong.song@linux.dev>
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
support for BPF_PROG_TYPE_SK_MSG.

I marked the patch as RFC as not all functionality are covered
by tests yet, e.g. update_prog(). Maybe somebody can suggest
an existing test which I can look into.
Or maybe some other tests need to be added as well.

Yonghong Song (5):
  bpf: Add link support for sk_msg prog
  libbpf: Refactor bpf_program_attach_fd()
  libbpf: Add link support for BPF_PROG_TYPE_SK_MSG
  bpftool: Add link dump support for BPF_LINK_TYPE_SK_MSG
  selftests/bpf: Add some tests with new bpf_program__attach_sk_msg()
    API

 include/linux/bpf.h                           |  13 ++
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/syscall.c                          |   3 +
 net/core/skmsg.c                              | 153 ++++++++++++++++++
 net/core/sock_map.c                           |   6 +-
 tools/bpf/bpftool/link.c                      |   8 +
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/libbpf.c                        |  26 ++-
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  27 ++++
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 +++++
 12 files changed, 279 insertions(+), 9 deletions(-)

--=20
2.43.0

