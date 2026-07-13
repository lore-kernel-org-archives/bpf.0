Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203214E2F2;
	Mon, 13 Jul 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923410; cv=none; b=dwZzLfuiJH8GZGihwsoCvB0kn5KHAsJIZyuMl+L6KJ+JoV43Z5fsRt7kVUN9huysh1SjWJiVSoqGUrZZ2D1WwSXLJQbj/WggdIwIAwlbVlm7HUvob1hHr9J882G+RoVYGz3N6zTK4P39ExSkls5lpv/fMyTIv1Mqi7i3sRI0TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923410; c=relaxed/simple;
	bh=lm8H0UjsLM1CR0i52ojSjVWkSqAI3K6+0IAr+BhRGOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YHguqeiud4x0joGg+87bOFas/FTNTzbMzhwvLYM0AVkc3N+xIftwJpG6onu1giaFA6c/tZEW71pcA1uEFrjq/VHd8t5yto3yy9vdxbwN7LL7FjbpIFdUGYy0Bdjaa/NX6FPZEZdzBjZ9JaJMKqz/NqnUXZsuTOhl1cWlkOHza48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=OsczCrSD; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="OsczCrSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Qscm0
	rC8uiUpdrQ5hpDMMTPaYHfRgRsy/aSfaGBQz/E=; b=OsczCrSDL/1U7LWojzGvk
	BX0sEL+MVIYll0avAv6bMpxcCczIO109cYJrpVpJ/NI+EtDzGeQViTRHy279mhP0
	+/+DJcqzWimXHVOWhBdTD/7wbqhwWhEw4zmz7DnssU+D11bdYTt+7PsfLnTkS1j+
	o62WE+aIps9DyfOf/6h0YQ=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQBXpJGwglRqEFAjAw--.21425S2;
	Mon, 13 Jul 2026 14:16:31 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Validate byte type for helper stack reads
Date: Mon, 13 Jul 2026 06:16:10 +0000
Message-Id: <cover.1783920884.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBXpJGwglRqEFAjAw--.21425S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW5WF45Gr4ruw4UZF4rAFb_yoW3Krb_Z3
	4Fkas7Zw40vF4IyFy2kF4vvrWUCw45JFy8Gay7Jr47X34vvF13WrWDWr12qryDAw45KrZr
	AFsIkayIyr1F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUT6wZUUUUU
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

The verifier checks helper memory arguments byte by byte, but its scalar
spill fast path only checks the slot-wide spill marker. For a CAP_BPF load,
a narrow scalar spill can therefore make an untouched sibling byte appear
initialized when the sibling is passed to a helper.

Patch 1 makes the fast path require STACK_SPILL for the byte being checked.
Patch 2 adds verifier_spill_fill coverage for a CAP_BPF map update helper
reading an invalid sibling byte.

Yiyang Chen (2):
  bpf: Check byte type when validating helper stack reads
  selftests/bpf: Cover helper reads of invalid spill siblings

 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/progs/verifier_spill_fill.c | 33 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)


base-commit: 9a3a07d06e7d74f4aecc51396c771149336ac55d
-- 
2.34.1

