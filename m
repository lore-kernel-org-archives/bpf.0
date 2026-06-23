Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC62BE05F
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184120; cv=none; b=nZvlORJ/wOjnBsz4I5ZSG9PYGpm2jj5QGUfCdt3xKwyFTwYm3B7b1nZiXl540xvE9j603q/1biZCmiHQnsk63hM+LglI9gqtJhlJ0BwdhvaADsk33QKmDG/ooFrz/N+37Slihq5joLhKdesL1IuhfslO4Xit7sY+bU0DUNnbeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184120; c=relaxed/simple;
	bh=9mZbYIjg6RD66RtjZ3wC3T16LnEe9uXlGO8uH+5VPqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tmj1bjqnq/Mo6SZG+SLAeOq6nbykuLJEokuGFHk1HbUKE/VC05gKtZp5HoXF6qQiEI/ftIsnIZAt5vYIkc1xU9w4lAcyp8+6qzzfhLNaDRgy6xvpk4rLwoR+2dS/5WTcuU4V8XitGKm+viuNUhRLoOjD1ruMngYqfMJyPIGCjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HLmTFjvu; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HLmTFjvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=up
	oPx/JXwnJsrNPaYFzIh3VDycK1ZXHwsZAVcpqGyAo=; b=HLmTFjvuQbIv27aAKg
	VH1dtApxxsIZYGxmLXp0ASZ/6Hqg+QTtkApbDF3gwXZI7ojV2mMleQ0AZK5mx9aU
	Si9eJQVcZpdGLgAiEQjuj0kLy+kecuQC5sJqSPLp1anAqKQzWX36W5S0i5gIYYkm
	U3mxUc7GgLUO3/DlA5kaHnRkM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwOT+DlqkRWbDw--.6101S2;
	Tue, 23 Jun 2026 11:08:05 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next 0/5] bpf: add bpf_memcmp and bpf_strpbrk kfuncs
Date: Tue, 23 Jun 2026 11:07:57 +0800
Message-Id: <20260623030803.44798-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3iwOT+DlqkRWbDw--.6101S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrurW3AryfJryxCr4UuF4xtFb_yoW8Jr18pF
	4Fgw1Ykr1kJF1fJ3ZxZayxW3W5XwnYkr4UJryxt3sYy34vqFy8Xr4fKr1Ygwn8GrWUua1Y
	v34vgrya93WUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR-4SnUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hVMemo5+JUdoQAA3f

From: Longjun Tang <tanglongjun@kylinos.cn>

This series adds two new BPF kfuncs to kernel/bpf/helpers.c:

- bpf_memcmp(): Binary memory comparison, unlike bpf_strcmp null
  bytes do not terminate the comparison. Returns 0, -1, or 1 with
  standard error codes (-EFAULT, -E2BIG, -ERANGE).

- bpf_strpbrk(): Find the first occurrence of any character from an
  accept set in a string. Complements the existing strspn/strcspn
  kfuncs for string tokenization use cases.

All kfuncs are registered in common_btf_ids, making them available
to all BPF program types. Selftests cover functional correctness
(equality, ordering, edge cases) and negative paths (NULL, user,
and invalid kernel pointers).

Longjun Tang (5):
  bpf: add bpf_memcmp kfunc
  selftests/bpf: rename local bpf_memcmp to avoid conflict
  selftests/bpf: add tests for bpf_memcmp
  bpf: add bpf_strpbrk kfunc
  selftests/bpf: add tests for bpf_strpbrk

 kernel/bpf/helpers.c                          | 105 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  30 ++---
 .../bpf/progs/string_kfuncs_failure1.c        |  16 +++
 .../bpf/progs/string_kfuncs_success.c         |  25 +++++
 4 files changed, 161 insertions(+), 15 deletions(-)

-- 
2.25.1

