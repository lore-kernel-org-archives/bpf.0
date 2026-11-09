Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254257;
	b=YI2cVzTAFJACgWjRa9d40FGQVndu6/9Ew71aGKSu7dANtxRy/AHVXsBlFze6w+y5zpcR
	 b4wriwYmA8Xntvy+wyBElJ7/ynMHlw0JHfQ5NWwEZ6Beb58A1X4oS3KhkuiBaU0lDHKfq
	 AInL4ZlHco2Ne9YwPnJC6aoJTjxXa57y8f9SWNeOkys1OzokL/UZoa17/4jGnl0Vqnv9y
	 Nafa0/qSfdS487TTIV9ggW8KjWcw0M09TGpKTaAdOyS20whjEKme6vSaIwSiyppW0BP9M
	 ZDPzy2tQxRt/3vlLBESgpM/bqtWw4T3dzYOLdHlcpD4MRkrNRqfE+Try1euQtmWiTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RqeZNMD/GyMZFkUQART8v8x1xTg3ZSj2kgmRBUS5Nyc=;
	b=QVPZtHFa6k9uxJdL8I3XdnCjfPuNchWg9W1wNvyh+lZ7h5vQQv3Lis08TBRpOhOD43qc
	 EtBTNJ76zogeCsyQ4KgV66+AGBZLyTUW9WzJ6zE8CrbIJAfkdDzunGKzZRnxjxZMGGLNL
	 fq9VSt+nz6PrGNBkA6hF9boG475aX7S9MKUbe/yjABSjC/4TAnEICkPlyvYY8UpV+aTG/
	 0FV4r5bL20eD5NhZvUkB2WKAeyj3JPmGqY3kb7IEdjPZHoR0Rl9DQtqxvXeDjpwAg9ahJ
	 NzAV4xUTbvvLyOfpCYy1mrCW3jhhsQTSRJXIgj8iOiOooTH6SPv3M5j2SZ7aU34uQ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYHIy4UA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96567606A31C;
	Mon,  9 Nov 2026 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYHIy4UA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985031F0089F;
	Mon,  9 Nov 2026 19:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254257;
	bh=RqeZNMD/GyMZFkUQART8v8x1xTg3ZSj2kgmRBUS5Nyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYHIy4UA30DIN8+MtXFvuziRJLhsgoyllLe6J+5ftPrqZQkbCiNXTeWcf0AafEB9r
	 Zc5ZdVtUkFlBYWG/ihjn1SuyzyamqJtebth2qs7CDJpcpEmF0CwBrzthy9GyE0l1Dr
	 gAsnBkbq19PTPQY2bBf8VNRIn3IMAOLyJjnXLwsfU8btWG6W9T/LnAxjaLexOAOLkr
	 DIglluy2hDiwDIrlHbuQWZ8AGjq5Bd3ex2xb0yY3Lgc0FzN7NZkmqUq2J7a8rILRH7
	 ZrloKIVs6S3ydj5WQWK9M2ZW2KoXbwCAzGnsOtv4WhS6lkZLgf+15yycSDuaNd2COt
	 TFO5Tzba7syqA==
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
Subject: [PATCH 09/13] x86/kprobes: Use kprobe iterator in arch_check_optimized_kprobe
Date: Mon,  9 Nov 2026 20:57:31 +0100
Message-ID: <20261109195731.1091241-1-jolsa@kernel.org>
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

arch_check_optimized_kprobe() checks each byte of the optimized range
with a separate get_kprobe() lookup. Iterate over registered probes in
the range instead, retaining the check for probes that are still armed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 9da41424be77..cdf69c939631 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -334,12 +334,13 @@ static int can_optimize(unsigned long paddr)
 /* Check optimized_kprobe can actually be optimized. */
 int arch_check_optimized_kprobe(struct optimized_kprobe *op)
 {
-	int i;
+	unsigned long start = (unsigned long)op->kp.addr;
+	unsigned long end = start + op->optinsn.size - 1;
+	struct kprobe_iter iter;
 	struct kprobe *p;
 
-	for (i = 1; i < op->optinsn.size; i++) {
-		p = get_kprobe(op->kp.addr + i);
-		if (p && !kprobe_disarmed(p))
+	for_each_kprobe(iter, p, start + 1, end) {
+		if (!kprobe_disarmed(p))
 			return -EEXIST;
 	}
 
-- 
2.43.0

