Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F136F8E0;
	Tue,  2 Jun 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390787; cv=none; b=umEsIBV/1QWZ4pPtHvc5EoheeKeOModp8N1XBN2XmxIYknykREY4/Wz102F1uRyV2aKfJX3pyqvRnRVWKKnh8ZZcMlFjxfts7pEvtVaurwb6cs3Kd8QEzcdmbtB5vTLbgpcD3ZY3efdZ/W+UhaS9ZJIiMokambwp7EOACfykK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390787; c=relaxed/simple;
	bh=v+vH/QeLHTFb0oYjPuuXE+h+9OJsOPoxKNtRvJtYPOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVfJOiXse+U472vTp9cTw4FBkj5uiVCxUn0qjHNivm4qYDLr+h8KcKfaBPttpqvp2uU0piMJbBmbK01CSC+5jca1LiNavWemlmFNYw2UQiqqGHKNtcsmF29UZueVH/4o2Ob4a/BwPtR/icImT2S/TB1FaczljVwMqxHRtsAGLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K3/D/tor; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K3/D/tor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lK
	YvhLOsd9NnhXAV8Oi1iF6qA9uiviOdk6lkEEIcGiY=; b=K3/D/torssaCNcajNd
	M/M0KTLWkvRBA9/Douip02GkFl5qxlhyiMQpNZvERgSOYFnE1PMahnWGBtkkYWag
	Cub/kbByrG9TPZK38DFdaSscCjXOI6OwKDa24U6jv1UhOwNb9IY7cD7S0t3KjIZC
	obYVQZHjWbDyZ96PMP+CNs7X4=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXKCA9mx5qOzE6AA--.5610S2;
	Tue, 02 Jun 2026 16:58:38 +0800 (CST)
From: chenyuan_fl@163.com
To: eddyz87@gmail.com,
	yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	chenyuan_fl@163.com,
	clm@meta.com,
	daniel@iogearbox.net,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Tue,  2 Jun 2026 16:58:24 +0800
Message-ID: <20260602085827.2562222-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXKCA9mx5qOzE6AA--.5610S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xuFyUtFWDtrWDJF43KFg_yoW8Cr4fpF
	WFy3WYkr18J3WSgF93Zr4xuFyrtws5Xw45GFnxK348Aas8Ar18XFyxKF1rtas0yrs5X3ya
	vas2qrZ5CF1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBOJ5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5h4Y1Woemz5A-AAA3Y

From: Yuan Chen <chenyuan@kylinos.cn>

v1: https://lore.kernel.org/bpf/20260407080900.551797-1-chenyuan_fl@163.com/

v1 made btf_types_are_same() cross-BTF aware by comparing kind, size
and name.  Alan Maguire pointed out that this would be too permissive
since two different structs can share the same name and size.

v2 used a name-based classifier (get_kfunc_arg_inject_type).

v3 (this revision) splits the combined is_kfunc_arg_ignore ||
is_kfunc_arg_implicit check in check_kfunc_args(), so that an implicit
argument reaching is_kfunc_arg_implicit() without any prior handler is
rejected with -EFAULT instead of silently skipped (Eduard Zingerman).
This prevents the silent fallthrough that occurred when module BTF was
inconsistent with vmlinux (e.g. pahole 1.30 breaking distilled base
dedup).

Patch 2 adds a positive regression test for the injection path.
Yonghong Song pointed out that with pahole 1.31 available in CI the
test will always pass, so it cannot reproduce the original BTF mismatch
scenario.  The test still serves as a useful regression guard for the
injection mechanism itself, however, and would catch any accidental
breakage in the future.

Thanks to everyone who reviewed and provided feedback on this series.

Yuan Chen (2):
  bpf: Fix kfunc implicit arg inject type detection to prevent invalid
    pointer deref
  selftests/bpf: Add regression test for kfunc implicit arg injection

 kernel/bpf/verifier.c                              | 15 +++++++-
 .../bpf/prog_tests/test_struct_ops_assoc.c         |  7 ++++
 .../testing/selftests/bpf/progs/struct_ops_assoc.c | 40 ++++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  9 +++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  1 +
 5 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.47.2

