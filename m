Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960E3043DB
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191439; cv=none; b=Rp/1J/Ho2AsFlpsoD3cskIo1CKfgsxgUoNMz8RRk3QQaBQCDiU7mQnLkvQvkLKlYzfYSxBbfHGmMHPPI09MtQjI3izPgsYyq+u+sFUgmyMQO0v7Y1C+3nMh6nTAnUry1pnbNMR6Eqg3DAvlR8CU7jHv8aC0RHUcA0MyLZG79qN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191439; c=relaxed/simple;
	bh=7jChIlBdX5cyvaOtwNSXj8rsiA0k4H7LnVPSnAUwHtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGBNBqGTiYU61lgFYiHBC2sR2Iwo0bW9Od8eP/ZXB0EqUSTnjY8wDsQ2ygOncbimRV5jBYqVJ4W5bqoghrjKldT+bXdtCQlj29cYeEypgkEXyqDz94FOEeDP26aZxJxRW6vGnbd2ggCWcWgp2QuyB23GH8cwyK8bYVzI1VIrlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMy9nk3n; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMy9nk3n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784191435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J1risvgTnu1YANvpDbqCMcIGHxqMu8P6MCll1PDgAnQ=;
	b=aMy9nk3nBENl/4D4f+fHphl2dBNcQffAncdGBNC0V6BeMgvpEKHXtuddLi5EJX8Un9MF2W
	7VlUT3fJCszG7gEzNfPpUlZjI0rm7T0KwkjrkPDfBvLLqVFcIANxStpOwm7uQnB5/7cygj
	LgKBD1XmCraKDn14ga3b1i3t5/OAHeY=
From: Hui Zhu <hui.zhu@linux.dev>
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next 0/2] bpf: Fix two trampoline image UAFs in bpf_trampoline_multi_detach()
Date: Thu, 16 Jul 2026 16:43:37 +0800
Message-ID: <cover.1784191209.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

While auditing the error paths added by commit aef4dfa790b2 ("bpf: Add
bpf_trampoline_multi_attach/detach functions"), I found two independent
ways bpf_trampoline_multi_detach() can free a trampoline image that
ftrace is still actively calling into.

Patch 1 fixes the case where __bpf_trampoline_unlink_prog() itself
fails before touching ftrace (e.g. -ENOMEM building the new image):
cur_image is left equal to old_image, but
bpf_trampoline_multi_attach_free() frees old_image unconditionally.

Patch 2 fixes the narrower case where the per-trampoline unlink
succeeds (cur_image has already been speculatively advanced) but the
later batched update_ftrace_direct_del()/update_ftrace_direct_mod()
call fails. Patch 1's old_image != cur_image check alone isn't enough
here since ftrace was never actually updated; the affected
trampolines need to be rolled back to old_image instead of freed.

Both paths are already WARN_ON_ONCE()'d and need an allocation or
ftrace failure to trigger, so they're unlikely to fire in practice,
but when they do, the current code frees a live image out from under
ftrace.

Hui Zhu (2):
  bpf: Fix stale old_image UAF on trampoline update failure
  bpf: Fix UAF in bpf_trampoline_multi_detach when ftrace update fails

 kernel/bpf/trampoline.c | 54 +++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

-- 
2.43.0

