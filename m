Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452E3998AF;
	Sat, 20 Jun 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968694; cv=none; b=UmUZteGT5UWpENS+uv10++wJzjOk9Uj0Pq5VS5jTMPGHypPnABNBxCANfe4VD03E743IjBLK0y+kiB+BafvIXm+SW+ODqvnvvlzRRt4XBKFn7/O7q0yD8m/VI7DT58+XGVnRRNO9qDCMmnYTleoBWOmYEUSGAiEMGhzlsMgrwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968694; c=relaxed/simple;
	bh=fEM8KJrxOZJdWWmKgAjX9yMvm8/bIHgQQpB8ceyakmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HahcJ+/bhkrtWZIZT2mi5s/tOPMYac2gmg2sql9yyQVjY1e7K6a0TajudUDpPlLhi3wTQn8C2HMoihBlkRVmIqWRQC/pMSD2amyuuncWuVqxYpx/PiKgFFTkOVxASP/VmDAKPkRyIs/JZj8Cc+iLpVMRQ17KgWLiEmNSm5SO0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=gtH9Yf/G; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="gtH9Yf/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=J62ERBuF5D+z9S0HzdBYBCqRQCU40uKrCz
	kzi6R9Y6Q=; b=gtH9Yf/GA5JxkOunzyb7Ddu0075aRbIIdSM+so4kVa9lC1l5jG
	8tOnbhVi3yrjSalBOfuEV9gxFu0c9xxGeB7/7U3p7x8+UPRayojoit0YbdJra1CT
	sRD9Denu+eLsDxt1LPe55Yk1wmxR/HORMW2h4kDokMj/2WUbhdZweZqPI=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQD3Q5EbrzZq3PmUAg--.8562S3;
	Sat, 20 Jun 2026 23:17:55 +0800 (CST)
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
Subject: [PATCH bpf-next 1/2] bpf: Preserve nullable RCU pointer state on unlock
Date: Sat, 20 Jun 2026 15:17:44 +0000
Message-Id: <aaad3eeba3ea62f2c332701b28bc28387dcd5a42.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQD3Q5EbrzZq3PmUAg--.8562S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryxJr15JrWUAF13JryDtrb_yoW8XF1UpF
	48W3srKrW5Cw17CasrZF48ury5WF98Jw47C3W8Zw4SyFn8Wr10vF4jkFy5XF9IyFWkKw4F
	vr15XrWqqw4UZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c
	0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7sRqedUUUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_rcu_read_unlock() converts RCU-protected verifier registers to
untrusted pointers so that programs cannot keep using RCU-trusted
references after the read-side critical section ends.

That conversion also clears PTR_MAYBE_NULL. For fields from the
BTF_TYPE_SAFE_RCU_OR_NULL allowlist, such as skb->sk, the verifier records
MEM_RCU | PTR_MAYBE_NULL while inside the RCU read-side critical section.
Clearing both flags on unlock drops the nullable state and allows a direct
post-unlock BTF member load without an explicit NULL check.

Only clear MEM_RCU during RCU unlock invalidation. Preserve PTR_MAYBE_NULL
so normal nullable-pointer checks reject direct access, while an explicit
NULL check can still refine the pointer before use.

Fixes: 30ee9821f943 ("bpf: Allowlist few fields similar to __rcu tag.")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf..e53c4bfe4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9001,7 +9001,7 @@ static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 
 	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
 		if (reg->type & MEM_RCU) {
-			reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
+			reg->type &= ~MEM_RCU;
 			reg->type |= PTR_UNTRUSTED;
 		}
 	}));
-- 
2.34.1

