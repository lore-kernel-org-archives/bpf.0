Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD303EA95C;
	Mon, 15 Jun 2026 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526521; cv=none; b=OSPPvfVrZUXg0rAKiYb88t5ZnVib1mqmBPW9lYy5xOZl2699O04v2qBIMFxuAkywdf/WeiV1NLxyQwSxG1qBcIBoa2hqu0FhhpnQltlYeMgoMz/BkpgFmdHrrYlrpIaOy7JVdXX6S72E+9rRgLZHdKZTkjz1t6LnnDqNpSZw078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526521; c=relaxed/simple;
	bh=H9WM0CRtxQ1eouBJBfExCpgUcSUnSXlkMf52rcRw0Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRrEvBbFsrtzOCSy51zLNcmCoDxLjqP0F+WJLH2lEBMBPx8grVauFsw4PODX7sOCtCImIKRKpZDxF1iMnNNqbl8gVdYVxByJShjlpWn8lDup/OyzlM6SFXXuD0ntVMERKdIOBBe9f/ZnMhuyek5p/3iaaHPtTyEqudWLheF2DNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=StVmpSjy; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="StVmpSjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=2eSG9
	u2+ppUU+KuEW2yyXHbbEixnr3c8rUqMkyq0Ig8=; b=StVmpSjyEPe9rJafma5re
	kOSuuJXQcwRygMsTYKeIvQ7A1IVAnQxcEBeShhWKcrzwGJPnaFxV27z0M/Xhj7Zn
	fBNtgxDTv8faeyic2Fzk55/AXKeqFKyqDD+Sgfs7Fsh6o6PlPk5e1LJQ1R2mvzav
	UHUUh2qbLp8PE+f2iskckk=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAH4Jfb7y9qtBtQAg--.40734S2;
	Mon, 15 Jun 2026 20:28:24 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 12:28:08 +0000
Message-Id: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAH4Jfb7y9qtBtQAg--.40734S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5Cr45ZF4rJFy5Kw4rKrg_yoW8Ww15pa
	yrGryYqrykZF13ArnxJF409rn8Ga18XF43Ga47try5Zwn8XrWYqFy2gr1UAFyrKr4fXw4S
	vFyaq3s5CFy5CrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRXZ2VDUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writer kfuncs can mutate skb packet data.
The verifier does not currently treat those kfuncs as packet-changing.
A direct packet pointer checked before the call can stay usable after the
write.

bpf_dynptr_write() already clears packet pointers through the helper path.
Teach kfunc argument checking to do the same for skb and skb-meta dynptr
destinations.
Keep source-only dynptr arguments unchanged.

Validation:

  Without this series:
    linux-stable-v7.0.12 accepts the three stale packet pointer cases;
    linux-mainline-v7.1-rc7 accepts the three stale packet pointer cases;
    the source-only bpf_dynptr_copy() control loads on both kernels.

  With this series applied:
    patched bpf-next rejects the three stale packet pointer cases with
    "invalid mem access 'scalar'";
    the source-only bpf_dynptr_copy() control still loads.

  Build and style checks:
    git diff --check: OK
    checkpatch.pl --strict --no-tree: OK
    make O=$BUILD kernel/bpf/verifier.o: OK
    make O=$BUILD -j$(nproc) bzImage: OK
    dynptr_fail.bpf.o build against patched vmlinux BTF: OK

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---

Changes in v2:
  - Resend as a properly threaded series. No code changes.

Yiyang Chen (2):
  bpf: Fix packet pointer invalidation for skb dynptr writes
  selftests/bpf: Add skb dynptr writer packet invalidation tests

 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/verifier.c                         | 62 ++++++++++++-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 89 +++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)


base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
-- 
2.34.1

