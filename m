Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD634AB01
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416946; cv=none; b=jv18wnkIe+wBzYYBAo9W0PBV5hHmB0IN1577v1OwQv6Ez9UOuZQ09zXlY3yScDT7qDg6aTiL3NVlgKuVlX9zeIxcjMQm4jDw6Yx3nfM9hMjzUPRRkm/OMGtQ7ob09NFMHGX5ngJx7YPdBqtdeox5R2gkDsuJ5uUmd8ibg/eS9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416946; c=relaxed/simple;
	bh=sLCRk6/uSism7PBL6YsWZlfNGp+Bcx2uJV7GEoytOEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWwBGxARlNu8pTQlbYadN8qCerWcdng6a6YJbSrmlXmccEgfZleqWkdHvtcusXGzkFfWAwInaYej19VYNjw6i4JH3fouQEHPekwLo9ihTuWYKZ53jdb+FeLktdHTmltuegot/IcAcvHZsXEjhGK+lis+FrJ8za8UwQtlUVjIpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9ygx0rk; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9ygx0rk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786416942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aG3L4pZ1FR2dyN32epn3qJmKPYriOUXFnmtM/oEMKSA=;
	b=i9ygx0rkJo4eCEAnOxTzVmUSkuqJDS99pecALEmRr3rW8AGgGXtL2Lk9NZj8Melp02i6qd
	MJYuMQXxfKtQCqsUqvj63xc8F2oHueS5wKKs6D9Rju5VAXSxkph/cvXNjB9JorVsOXGKWQ
	/fTmlfJfx9MvAUdDbLfN5dgvOZeQNpw=
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v5 0/2] bpf: Fix trampoline image UAF on multi detach failure
Date: Tue, 11 Aug 2026 10:46:18 +0800
Message-ID: <cover.1786412280.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This series fixes a UAF in bpf_trampoline_multi_attach_free() where
old_image is freed while ftrace still calls into it, and makes
bpf_trampoline_multi_detach() return void as suggested by Jiri Olsa.

Patch 1 fixes the UAF.  Patch 2 is an independent cleanup that
changes the return type to void and drops the WARN_ON_ONCE at the
call site.

Changelog:
v5:
According to the comments of bot+bpf-ci, split the single patch into
two: the bug fix and the return-type cleanup.
v4:
According to the comments of bot+bpf-ci, add Fixes: and update comments
of bpf_trampoline_multi_attach_free.
v3:
According to the comments of Jiri Olsa, drop patches 2/3 and the
prog-side machinery.
keep only the simplified image-side fix in
bpf_trampoline_multi_attach_free() and make
bpf_trampoline_multi_detach() return void.
v2:
Folded v1's two detach patches into patch 1.
According to the comments of Jiri Olsa, Pin the prog (pinned_prog) on
cur_image so it stays alive while ftrace may still call into it.
Make bpf_trampoline_multi_detach() return void.
Fix the same UAF in standard (non-multi) trampolines.
According to the comments of sashiko, Fix the prog UAF in
bpf_trampoline_multi_attach() rollback.
Leak the trampoline in bpf_trampoline_put() when cur_image is left
by a rollback.

Hui Zhu (2):
  bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
  bpf: Make bpf_trampoline_multi_detach return void

 include/linux/bpf.h      |  9 ++++-----
 kernel/bpf/trampoline.c  | 16 +++++++++++++---
 kernel/trace/bpf_trace.c |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.53.0

