Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43D30BF69;
	Tue, 23 Jun 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236086; cv=none; b=hMhhA1xtUALGwvrANoaKerIXPQwZEFuM434WlCOVwXquMAFsqmQtWEPtLrtGgBPB5JSCTMPSEpbGQ5ydNDQsD8Mf0AAF4dLKBxeHmL6MZ7iyfrIV4dGxr88HOsqMxhwowqarTmz03TjBLcsSNs5bV1L4vg/cUe+E1EAOm0HWX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236086; c=relaxed/simple;
	bh=PYCRYsLrIsR4tx3VA5k/UtpRuiBcUN4bCCsX/cOyCrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9jCjB5ST9CDzE/bnd5/G6mo5rNWsr7Pl41418o/DnH7UfRvHgstiJeNCzITEu0lYvIUnfVADTS0WxX5JSd29UOofngzS4LFAmM/4nMSkiBpUMS9JbWkIrVfRT+kdH6NVgYXschadev9xVsOkDJ8Spw1tihdap/HbJDQT8DeN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=C4ZeqRDm; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="C4ZeqRDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=SImGT
	Daeemmk9Ot9FDkfdNXfdAxQdSFL1gE6A0cL9Zk=; b=C4ZeqRDm8jmp9bG/HG3RZ
	qEsfojzLePMAP7uf1D4Z1auLEJPCNxRUUs6SQZWrXagniCDVpY6vs5rqSlfInnIw
	dHWxTg13KX7YTrBg2jBojPt1yYGYqWgN6XucqUTUUq8kep/LUC9btBfyDWo5h1PQ
	i9zqZ7bcJE7n61zILTqSSY=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQBnP5eYwzpqIo19Ag--.49585S2;
	Wed, 24 Jun 2026 01:34:31 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Reject MEM_ALLOC BTF accesses past bounds
Date: Tue, 23 Jun 2026 17:34:11 +0000
Message-Id: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBnP5eYwzpqIo19Ag--.49585S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry7uF4UurWfCw1kury7GFg_yoWkKwb_ua
	y8trWDurs8XF15Aa4vkF1fAa95Cr45Gr97AFWqqr43GrnxCry5Xw4kJr13A34jqanayry3
	Zrs5ua40yF17tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwV
	AFwVW8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjb_-DUU
	UUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

BTF struct walks can relax the top-level struct-size check for trailing
flexible arrays. That relaxation must not let a PTR_TO_BTF_ID | MEM_ALLOC
access escape the bytes allocated by bpf_obj_new() or bpf_percpu_obj_new().

Patch 1 rejects MEM_ALLOC BTF walks whose access range reaches past the
current struct size before applying the flexible-array relaxation. Patch 2
adds a linked_list negative loader case for this path.

Changes in v2:
- Move the check from bpf_obj_new() type validation to BTF struct walking.
- Reject MEM_ALLOC accesses that reach past the allocated object bounds.
- Update the selftest expected verifier error and carry Eduard's Acked-by.

v1:
https://lore.kernel.org/bpf/cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (2):
  bpf: Reject MEM_ALLOC BTF accesses past object bounds
  selftests/bpf: Cover MEM_ALLOC access past object bounds

 kernel/bpf/btf.c                              | 14 +++++++----
 .../selftests/bpf/prog_tests/linked_list.c    |  1 +
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

