Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6EB327BFB;
	Sat, 20 Jun 2026 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968686; cv=none; b=aipQRMGdHxYmC25fNpCtfedGaDdKY+Xa4CbmJzaB5oBrD3o3Jv+rEsSrcxrQJb3Kd8mrBQ+JRcprG5+lany1mlu7zEY6k2vHHs15Jc9xea6MbTQXG+UmUHrI5rGX0memWFgh4UgcytvYcPr3qV8IYNe/8HGKl0P62LlBytIO8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968686; c=relaxed/simple;
	bh=OpOjMdbQ8++TILHVWXC0YLsoz6GMhAAEpCYTX9eZP6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpeT1xuQoZaGPklPW8yhj7lWgl5c92HaiTxEaeUmlx+j6Wmh+uzgKUpQZdefqN68a4/sTmzxmpfYfxQCBaNzuo14waQRYmdr5cDanSI5Pj/nCENURSCdq87OTbDi6+bkB6E1VtoaHpHi1mWYWlVnhD0VEwXBUrvv8iU7SBpaZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=IQxeVcFl; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="IQxeVcFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=6NbRD
	5BW7VWdRoHkhlmFlXIaRtETnANpowlq9Y+jZlw=; b=IQxeVcFlcJpWZg4QfQ5wZ
	ECRGx8vd2jnUO5PahhqrDuz4Ns990iMUFRYjwXujvoPzmqoYM4urOVeBJzMZLtoz
	2lAguhGQPt3sovDhOsycVxQlEnmg4KgoEhclY0mB8uzoj1/IO/4UYrmBwh3NPL+0
	1xdr8f0VGMguTnF5h0BYbc=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQD3Q5EbrzZq3PmUAg--.8562S2;
	Sat, 20 Jun 2026 23:17:52 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Preserve RCU pointer nullness after unlock
Date: Sat, 20 Jun 2026 15:17:43 +0000
Message-Id: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQD3Q5EbrzZq3PmUAg--.8562S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1DWF4rZw15WrW8JF4kXrb_yoWDWFX_ur
	y0y34DJr1xAFn8KFW3Aw1fXrW09r4YkFyxJF4UGrnrtryUJr15ur4kXry5A3sF9ay8KwnI
	yrs5G3ySyr1YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_XrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDkuxU
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_rcu_read_unlock() converts MEM_RCU verifier registers to
PTR_UNTRUSTED, but currently clears PTR_MAYBE_NULL at the same time.

That loses the nullable state for BTF_TYPE_SAFE_RCU_OR_NULL fields such as
skb->sk. A program can read skb->sk while in an RCU read-side critical
section, unlock RCU, and then dereference the pointer directly without the
verifier requiring an explicit NULL check.

Patch 1 preserves PTR_MAYBE_NULL when removing MEM_RCU.
Patch 2 adds a focused regression test for the unchecked dereference and a
matched null-checked control.

Yiyang Chen (2):
  bpf: Preserve nullable RCU pointer state on unlock
  selftests/bpf: Cover nullable RCU pointer use after unlock

 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 17 ++++++++++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 20 +++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

