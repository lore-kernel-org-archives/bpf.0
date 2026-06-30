Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB4D3EB10F;
	Tue, 30 Jun 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814382; cv=none; b=ui/Y1pebnIsNOeHE6E9cxuXemkb2jVRRYOZUmBELaiG+iuJcglPPtGv/HDCyuSUkMH3SWrbeM/aakRKjDbiHQ1ft2lvjoETEn1mIXEtbAZ0vTmYxeQ3zUXncjiYMTqXr+smrcXwvBvfK/TZ4WG6JiigFVzDMjrqamXfTgmaz54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814382; c=relaxed/simple;
	bh=eA3bXjTF6F+3nD2VnPOck/hFRANZj1VbTZPf5V6Ecwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pv6kRdUc/Tgj7rUeMjbxLUlFdMNx4QUcYI5izez9XPI3JqeOp/XmfwCO6wHw0EPVDAkkDxSIfXCwaGMY9v7D6+3fuZBdfGn1BZ8rBCpN7PF5ya6TMkIOfvSUrliUgveDkXDS7l+aMtdoWe0bEuP7FhsBkcIJZVPftvTpVphhlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=XoJny02D; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="XoJny02D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=jf881
	FndgVC5Slh4ACwJOS6E6mVzWtVGt3B8LMK7D/w=; b=XoJny02Dep+Pqyfa4eadO
	/wKE7Z16tJa2/hqSFftxPQ5L/7MniVAp69xEEt+nZ1IAj8tDRDt5ye9gc7iBJGJB
	Nw+Rm+OhwUbeVTYRXPIgTUwkRbTTvo2+ff6RjYBY5LS1KCW4ABawvx1U/xzfWHkl
	pZP4Qa85AYxG5gDCRKklps=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQD3z5eGlkNqxZukAg--.37667S2;
	Tue, 30 Jun 2026 18:12:45 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Reject arena frees below the arena base
Date: Tue, 30 Jun 2026 10:12:18 +0000
Message-Id: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQD3z5eGlkNqxZukAg--.37667S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw43XFyrZr47XF1xZFWUArb_yoWfXrX_ur
	4kKa4DWw4UCFs2ga43Aw1fZryxuFWjgry3Zr1v9FW7Xry5XFnrCrs3Ar1YvryxJa1Y9r95
	JF1ayFn7trZ3ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQID7UUUUU
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_arena_free_pages() can be called with a scalar arena address. The
runtime reconstructs a full user address from the arena base and the low
32 bits before returning the range to the arena free tree. A scalar one
page below the arena base can otherwise produce an out-of-domain free-tree
offset and make a later allocation return an address below the arena
mapping.

Patch 1 rejects frees whose reconstructed full user address is below
user_vm_start. Patch 2 adds verifier_arena coverage for the
scalar-below-base case.

Yiyang Chen (2):
  bpf: Reject arena frees below the arena base
  selftests/bpf: Cover scalar arena frees below the base

 kernel/bpf/arena.c                            |  2 +
 .../selftests/bpf/progs/verifier_arena.c      | 41 ++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)


base-commit: 7feeed42d8b97d0db0eab2c1c30aa86f110fe49c
-- 
2.34.1

