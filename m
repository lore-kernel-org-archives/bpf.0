Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455713E9C3D;
	Fri, 17 Jul 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282782; cv=none; b=ZB7aMHjawaBegTO3/C/zdoqv52VcGk3Dn+pR+Rg590mx4wA/8wK82R5fKxLs8xidc6Hg/euEE6pCmCDcKMKrbIEiC0FXoWDwbhQ5NUzlTsuV7KGp+Z+p5CtnscReTtDo7B13p8oHMR6YvKJMiwPj7ErofxOKvB5mQsdVpldyH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282782; c=relaxed/simple;
	bh=7ODRxQ1Qnznw6oFlmp4IQyDsK5WC4u5aJZid17ad3GI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RN6OaIoWdYuoSfrU0WjA/+NasJJJU5r1QWO7lmZylfWzPYd23UiIdtgzo5MZbAJAwLdso+Evca5qWXKFe519Zg9pwHLPTRr5pfpuCA2SK+1fjIdIVzfYb5KmZy66hDRk/3g2NqdBLZVVq/gsdLKQlB6MqSyK2MNCYYOvLqu4L94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=PnKb9Xue; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="PnKb9Xue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=8nz40
	Tc6hoLFo5EGGysyuFnmKq4JJ7JcRBJoFTmlWrU=; b=PnKb9XueBQl3UgEJ4nyFd
	ZKVKN8mLRvArXLFIuhBHwIEDd8C+q9T3XBg8KBkDPwWmrMmRdnuXO6Ni2e4KM2b+
	rKlHl8jQ7WCplm5o5s2ydg95KNjPPkV4XhfgG0R1tPePc+fZU25fuYF73EKJjZTp
	BVnRclJZrjpiWhS9qubPIg=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQDXpRR7_llqNYAPAA--.22378S2;
	Fri, 17 Jul 2026 18:06:06 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/2] bpf: Validate byte type for helper stack reads
Date: Fri, 17 Jul 2026 10:05:43 +0000
Message-Id: <cover.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDXpRR7_llqNYAPAA--.22378S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFW5WF45Gr4ruw4UZF4rAFb_yoW8JF45pF
	Z5WanIkF1kGayxC3Way3WIva4fJF4kXr13urn3C348AF98G3ZrZrWFgr45CFy5taykWw4F
	vFn3X3Z0ka1UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOv38UUUU
	U
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

The verifier checks helper memory arguments byte by byte, but its scalar
spill fast path only checks the slot-wide spill marker. For a CAP_BPF load,
a narrow scalar spill can therefore make an untouched sibling byte appear
initialized when the sibling is passed to a helper.

Patch 1 makes the fast path require STACK_SPILL for the byte being checked.
Patch 2 adds verifier_spill_fill coverage for a CAP_BPF map update helper
reading an invalid sibling byte.

Changes in v2:
- Rewrite the patch 1 commit message to explain the uninitialized-stack-read
  invariant and distinguish it from the pointer-leak check, with references
  to the related producer-side fix and direct-read selftest.
- Add the regression Fixes tag to patch 2 and use the neighboring inline-asm
  line-continuation style.

v1: https://lore.kernel.org/bpf/cover.1783920884.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (2):
  bpf: Check byte type when validating helper stack reads
  selftests/bpf: Cover helper reads of invalid spill siblings

 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/progs/verifier_spill_fill.c | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)


base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
-- 
2.34.1

