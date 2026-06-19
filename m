Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864F35E1A3;
	Fri, 19 Jun 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856031; cv=none; b=SE6J7S4cbUmCxCqnMDjIEn8ITiIDRYdlqgghcM0csJkDpYAOqWQUy8z6yjEwvYaK32/hEPjYnlG/WZsETrYNFMgzh1aXGOCGWkBtFs11vwN+YDHcAy4PtpGWUtpaG31JQTbEJjHbcLbtIwl1ozCMzWrllxp+42Uu6RcNMDz1VAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856031; c=relaxed/simple;
	bh=nmEK2MD+81RYDqboD+eiJsgQ2bPdThwRpHoHqrpyNrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bftf1d7B3TQmN24/p/xRaXPwP9/th2xDCfe26loQsoqAPI/CmHhRO4O+3kiFb5V3vq4oskN1RVnr5xDVkchP9ah5FuNaU5/GAQamMU3oMuNOSbubWEm7BiyMqkTFiqJa57UF3LYJskqKzJhv0deVfgUA5w/noUtDG5O7rXoy46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=I8w6ZcgB; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="I8w6ZcgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=7Py7p8KiKzl5PHNsHoN+tGAmGAUcGyTkQU
	c1Sy1ss6M=; b=I8w6ZcgBV6fQSypk21q7r4QFksLkcptiAS3VRq0tzze1xi1Dwe
	eY1vVR596hyiUvy+2mxMed5872JqB4g/W9wq+TfswKD4PEi735XJOQv/XRu8IJ5E
	pssn8Ue1prJ7T/IJcsA6U4984hGu7q9TGzIkCkYsilXoukgDO0NgL4oTk=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAX85r79jRqhz5nAg--.64298S3;
	Fri, 19 Jun 2026 16:00:07 +0800 (CST)
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
	Viktor Malik <vmalik@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Reject offset refcount acquire arguments
Date: Fri, 19 Jun 2026 07:59:53 +0000
Message-Id: <fa2336b329055908a401ec3b18f8498ebc03846f.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAX85r79jRqhz5nAg--.64298S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DXFW8uFyUZr4UAr43ZFb_yoW8WF4xpw
	4rWr9FyF4ktryxCw12y3Z7CryrCas8t3y3GF1kCw4ayFyfXw1Ut3y5CryYyFyFkw48tr10
	qr4Y93yYq3Z8XFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdYb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c
	0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvj4i-BM3UUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_refcount_acquire() increments the refcount at the caller-supplied
pointer plus the refcount field offset, then returns the caller-supplied
pointer unchanged.

The verifier records the return value as a base pointer to the refcounted
object.

bpf_list_pop_front() and bpf_rbtree_remove() can return embedded graph-node
pointers as PTR_TO_BTF_ID | MEM_ALLOC with a fixed offset equal to the node
field offset. Passing such a pointer directly to bpf_refcount_acquire()
currently passes the refcounted-kptr type check.

That makes the runtime operation start from base + node_off while the
verifier models the returned pointer as the object base.

Require refcount-acquire arguments to have zero offset. Programs can still
acquire a refcount from a graph-node-derived pointer after normalizing it
with container_of().

Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf..4510fe0b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12392,6 +12392,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
+			if (reg->var_off.value != 0) {
+				verbose(env, "%s must have zero offset when passed to %s\n",
+					reg_arg_name(env, argno), meta->func_name);
+				return -EINVAL;
+			}
 			if (!type_is_non_owning_ref(reg->type))
 				meta->arg_owning_ref = true;
 
-- 
2.34.1

