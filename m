Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681937CD20;
	Tue,  2 Jun 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393182; cv=none; b=cZgk3wqnyl1vRoC5nM93g1iwf30D01NiMvTCKj622nRtXH7xtzfnhvSs14V6Gzrhv8QDzVBbAEfn2K1g3Y4e1yCOM8Wv2zvR9N2HwbA+y9FxkwvZ46C5Aj49nfNNGyIbNo8RGQMDmq318shSzc8Zm9oM3+RFtcwsIVM3BPGBb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393182; c=relaxed/simple;
	bh=pSIQE64PaAlUMz0FCJdQHmaqw3JTtoHMl7pFjj3V9TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy0h2BS0433saIRKOabyt/a30rxCeaS+i5TmJpWcSR3K/fkIjzxxMbquA590aeYXhx1OBrKzYQTTfVeMVj285bq2DQ9XASd7mBISQJ4V/6XOmy7A9WhC+Uco5YlQIbGXzMQV72Oh8vWyK5LfbXjSWFyxHWeA7FD4OZWIdWMNiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aldm5Ocb; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aldm5Ocb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bK
	g6D6cn5GVwPBDQJrjPxDPzagJkxDLn235ihYxuUvg=; b=aldm5OcbA3izMq2xZY
	I9PKSrJ41wrngPqMFuth6cXqb5MTXxfy1ZsurkdxVNehsheaofv+rOMOeIS/qF6X
	Hv+FwgMU3jGOp4peAzzZv9umuO+Dd1cSw0Bf8dkNCrNCmrhQ6qXRi8T1ASWZlU93
	9fSh+LLaj5ZxgvsMIvlthnAZQ=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCnYo6mpB5qDzU6AA--.7425S2;
	Tue, 02 Jun 2026 17:38:48 +0800 (CST)
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
Subject: [PATCH bpf v4 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Tue,  2 Jun 2026 17:38:31 +0800
Message-ID: <20260602093836.2632714-1-chenyuan_fl@163.com>
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
X-CM-TRANSID:PCgvCgCnYo6mpB5qDzU6AA--.7425S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xuFyUtFWDtF1rGr45KFg_yoW8Cw43pF
	WrA3WYkr1kJ3WIgF93Zr1xuFyrtws5Xw45GF9xK34rAas8Zr1UXFyxKF15tas0yrZ5X3y2
	vas2qFZ5C3WUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHGQDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgh1M2oepKjcJgAA3O

From: Yuan Chen <chenyuan@kylinos.cn>

v1: https://lore.kernel.org/bpf/20260407080900.551797-1-chenyuan_fl@163.com/

v1 made btf_types_are_same() cross-BTF aware by comparing kind, size
and name.  Alan Maguire pointed out that this would be too permissive
since two different structs can share the same name and size.

v2 used a name-based classifier (get_kfunc_arg_inject_type).

v3 splits the combined is_kfunc_arg_ignore || is_kfunc_arg_implicit
check in check_kfunc_args(), so that an implicit argument reaching
is_kfunc_arg_implicit() without any prior handler is rejected with
-EFAULT instead of silently skipped (Eduard Zingerman).  This prevents
the silent fallthrough that occurred when module BTF was inconsistent
with vmlinux (e.g. pahole 1.30 breaking distilled base dedup).

v4: fix a build error in the selftest (test_st_ops_assoc_reuse used
the wrong skeleton for the new variable).

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
 .../bpf/prog_tests/test_struct_ops_assoc.c         |  6 ++++
 .../testing/selftests/bpf/progs/struct_ops_assoc.c | 40 ++++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  9 +++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  1 +
 5 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.47.2

