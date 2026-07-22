Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDED7317163;
	Wed, 22 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698100; cv=none; b=GEzE6CKfbelT0Gav8MVIbwJyNjqFStSVaJyna4Hy0gyFuYOoKUdEtOY++LuQy/WrRDkrX4nxfgIHRWn2WIcOa8tkEhtIrfXRe5ZmcTwWqEZV63Z0TgqUKfA+iQceOpo8ftHp0DEKD1khSzL1pvL3kyD4pr/rjEbQE+DrlNVg6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698100; c=relaxed/simple;
	bh=sJwUV4c68aV79UpjZxmUlGcUzwp8jye+tMF9s33rbw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpMFal9KwJPgjuUSvvv31oZVbNIr4Sz7OuOuLYecLpQMCnMdwhjDvxQW4h8lnRraKfEkpPu0wrmAnPY/ulSCZMHlmfte2wA0AWjCzPqbkElNwBPvYrhKT97YgQvMwTe5YrfU3rit2JlTid5GDUXAzcoqmqcDYl16gsRaj3sm9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=IfY6r6NM; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="IfY6r6NM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=IYyKVj4+V1uChN5v0vRokVyhFYp0ttNjnZ
	/959qYKVs=; b=IfY6r6NMKdGbsE6O9vOsnLnUHXKUuHmW5fKOSE5hTgx68PYxio
	Xz0Hl1X2ps14eTZVQonVcS1o3Ttgdy29/4eEIl3/5CNYr8zh6tFy7H/5mZajCasn
	bepr92cJYcJcro89ZBhzypm+nppKzl06iepgnGStqFyuj47dXFKQcIpYU=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQCHWRjYVGBqhCwkAA--.51860S5;
	Wed, 22 Jul 2026 13:28:02 +0800 (CST)
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
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Cover commuted pointer state propagation
Date: Wed, 22 Jul 2026 05:27:33 +0000
Message-Id: <c1023bb6c9e24d98cbe69f63e1df487f4d490108.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCHWRjYVGBqhCwkAA--.51860S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4ruFW8Xr4furW5ur45KFg_yoWrGr1kpa
	ykua9aqr1IqF17Xa1xAFZ7XF45Cr4vqrWY9rWIyryUZF17Jr93Xr4xKFyjqrnxCrs8u390
	vFyaqasxuF48X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi8ucPUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add verifier coverage for the three cases affected by preserving the full
pointer state across scalar += pointer: stack frame number inheritance,
readonly-untrusted memory access, and dynptr data-slice invalidation.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 31 ++++++++++++++
 .../bpf/progs/mem_rdonly_untrusted.c          | 17 ++++++++
 .../bpf/progs/verifier_basic_stack.c          | 41 +++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 94489ac64da8e..7da4266bae09b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1635,6 +1635,37 @@ static int callback(__u32 index, void *data)
         return 0;
 }
 
+/* A commuted add should preserve the parent id of a dynptr data slice.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_slice_commuted_invalidate(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 *slice, *derived;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u32), 0, &ptr);
+
+	slice = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!slice)
+		goto done;
+
+	asm volatile ("%[dst] = 0;"
+		"%[dst] += %[src];"
+		"%[src] = 0;"
+		: [dst]"=&r"(derived), [src]"+r"(slice)
+		:
+		: "memory");
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	val = *derived;
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
 /* If the dynptr is written into in a callback function, its data
  * slices should be invalidated as well.
  */
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 5b4453747c230..f166fff8f2176 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -226,4 +226,21 @@ int null_check(void *ctx)
 	return 0;
 }
 
+SEC("socket")
+__success
+__retval(1)
+int ldx_is_ok_commuted_addr(void *ctx)
+{
+	int v, *p, *derived;
+
+	v = 1;
+	p = bpf_rdonly_cast(&v, 0);
+	asm volatile ("%[dst] = 0;"
+		"%[dst] += %[src];"
+		: [dst]"=&r"(derived)
+		: [src]"r"(p)
+		: "memory");
+	return *derived;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f21146..d3df7a9f1d8c8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -97,4 +97,45 @@ __naked void misaligned_read_from_stack(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("stack pointer arithmetic preserves frame number")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void stack_ptr_arith_preserves_frameno(void)
+{
+	asm volatile ("\
+		r3 = 0;						\
+		*(u64 *)(r10 - 8) = r3;			\
+		r1 = %[map_hash_8b] ll;			\
+		r2 = r10;					\
+		r2 += -8;					\
+		call %[bpf_map_lookup_elem];		\
+		if r0 != 0 goto +2;			\
+		r0 = 0;						\
+		exit;						\
+		r1 = r0;					\
+		r2 = 0;						\
+		r3 = 0;						\
+		call stack_ptr_arith_preserves_frameno_subprog;\
+		r0 = 0;						\
+		exit;						\
+	":
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+static __used __naked void stack_ptr_arith_preserves_frameno_subprog(void)
+{
+	asm volatile ("\
+		*(u64 *)(r10 - 8) = r1;			\
+		r6 = -8;					\
+		r6 += r10;					\
+		*(u64 *)(r6 + 0) = r2;			\
+		r7 = *(u64 *)(r10 - 8);			\
+		*(u64 *)(r7 + 0) = r3;			\
+		r0 = 0;						\
+		exit;						\
+	"::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1

