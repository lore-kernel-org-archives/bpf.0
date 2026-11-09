Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254243;
	b=ekDkKlmEBxBlpyOFBHiy5zrKiNWq5Dv48Z2eqn7Q+SWjER5Aw315O48QEgoSKwAkj5Jt
	 T8an7lTaw9fhMy5l14RRps64RtXqb0pPBNimba8QR2M4BzXyhWfuJiV18YUKFA19KA7FY
	 swVOkFWJ1lKSRn43QJmC1KCUzrOJ+01CJYwnwjIzct25sXfXmqAHmU3RTcFavHozNH4Ax
	 6Guba0yh4on0VSQ9W5PJ+IDXxi+xl/sJ+WqY6JRRu0FVwPQFGy9n5hCY+ygS7jqp9gByu
	 PzW6ZRn+urCDE0gzrG+WEgeGJuYm+kQ4ufn6g5pF3i9ltsgo6PfnWVAnywCB1WVCO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254243;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0LSUu1FKxGaYsKzFJCXoNRTLgX6dRmQ1kbiGL9NiX2w=;
	b=oeTwNgoQaPZfmdRvcbzoJP7P6Q8jliL50tuOSmUKPNviv0MCgZHgg4ME3khSoBOzjpwu
	 mV7getzy8em/ZySgNqFaljwbJdPwI4DWOB6JGwWiq1DkaAx1GoBDmYjzqaUctAZk0hZX3
	 7nmbaWoGxkLF+2QrA9CwXZ9e2aftJ6CGKwJ4FCiX2u0M/dV7OjqtiQ1+VC9kvIDAlRx0c
	 g9JJoZNrM5TIMVqT3mNazqv432wVbpqpQOt0HjEkX7t+VUuXLtgs0scOqx1FdRcBtl6BQ
	 s+TrhSH05VEPqgrfu4zkXmQsG8wVOZCIMFg9fo7grqwiNJBjxXJ54/LVThCLEWj0Mdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9QGC13j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED1606A31C;
	Mon,  9 Nov 2026 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9QGC13j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63871F0089F;
	Mon,  9 Nov 2026 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254242;
	bh=0LSUu1FKxGaYsKzFJCXoNRTLgX6dRmQ1kbiGL9NiX2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U9QGC13jcU7B2xTHW4Pxotcv/UOVUvelf/zitRP3O02rC4npcEeGCLfsoFoGfTdLd
	 eck3nwcp80mEAE5F1vIK+5bFvRvKpZ95M2o4nvFfn1sNpw3NLSAn+JonTXTYAFST7G
	 WkCjsxN3Jj1xZAXsaJGxD2sD5rv1Wb+9SCFd4dwfUfgD2bmeq7KKJ8fAb6eWuEJW3q
	 cPf04GNxyQOp6WaPZ4PtblkSbq18EZ7OlGvL6G+Vs7KYCgZNrFifM8OprEXd/KIOIu
	 Bi2yHqL769HZYHYe2DBxGg+YGp5XL9Qnm8TRSlb0mqphkLRN64P6mIy8ZRi3X7rEan
	 4J1GTWg/6zXDg==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 08/13] x86/kprobes: Use kprobe iterator in __recover_optprobed_insn
Date: Mon,  9 Nov 2026 20:57:17 +0100
Message-ID: <20261109195717.1091179-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the kprobe range iterator to find an optimized probe covering the
address being recovered. This replaces repeated hash lookups across the
JMP32 instruction range.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 3f8fea52619f..9da41424be77 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -37,12 +37,11 @@
 unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
 	struct optimized_kprobe *op;
+	struct kprobe_iter iter;
 	struct kprobe *kp;
 	long offs;
-	int i;
 
-	for (i = 0; i < JMP32_INSN_SIZE; i++) {
-		kp = get_kprobe((void *)addr - i);
+	for_each_kprobe(iter, kp, addr - (JMP32_INSN_SIZE - 1), addr) {
 		/* This function only handles jump-optimized kprobe */
 		if (kp && kprobe_optimized(kp)) {
 			op = container_of(kp, struct optimized_kprobe, kp);
-- 
2.43.0

