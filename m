Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253796;
	b=CdrQ6R+eZF8XlWbxAjoNRlcpm9WjdAl2d4PVL9T1StMo1P7vr/LwbZEAkEffGOy376Tg
	 uR383+klYkZPYmCkSbbsgrlchHFkMdYOeKJMbUAzxAqE4o9v9MPV3mguz9jLbowK+pk1L
	 gLa/d7FssQ0RGTJBPKN6L1CiKhVuUfOwe4YoZYP3uCC+UCZMsboLxwdp9F0nsM6RSHM6Q
	 DnpiV8ZDSxZgm9k9+fGxo/sYHd23BEbV02mHrhrhSZIaJ5FEhV46TW2IFNJm3cb0oAvSS
	 BLpNeoVv/H220QTpHxjmbyjwJlKypTlgjM956GkQFsV/lYPjno/tzUSSLjULclGFgAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RyALpbjetT/sAbQ8zDoeXpUqpB2MzJrW2/eMRWsHMl0=;
	b=N/nvkEszGhghNW6ZMY0uZLJ5hBmy3KaHvHOsodYXx/9d45wh7AU4gC9PiISIHl30cS9E
	 Mc7fCQ4ebqnG5ZectLRJSAbrz7S8uE0x21dbf0Btuw7rICyQvaGqOZ3EVHNpEeplCd+Mq
	 sedOrCekYmalBUL0SQo/zTj6iNnUvs9VXIcgYTJnd2ArCmNyYALL+q5khpzMUVvVQe8Iy
	 X4B8K5FtSslfUOpUn8Mq3wsqhcANOv1iMczD39XyYxGkA3F2lgj8n6eWs6M0RAHkmE/iW
	 zVFnH0hFIRGNeC1WUsOM8LAmypsKGuQkcSSjpsN3VjoL1x8B+qjw2rNPSrLdKYcYhpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ifbkt/ZS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B00606A31C;
	Mon,  9 Nov 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifbkt/ZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0AE1F008A2;
	Mon,  9 Nov 2026 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253796;
	bh=RyALpbjetT/sAbQ8zDoeXpUqpB2MzJrW2/eMRWsHMl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifbkt/ZSTvnfQh05yNLzvuNpJDg16qEagz2RgFSaEnCiA3X9mG8ZGVEVHHcTjEJKu
	 a8k86nVWzWt5GuPqrq34Au6WsiRN57p7X1FQ0W3HVL2Dm95C4AhOwICzJ11B+6m4gN
	 FxuhBKL0/9wOA4YXZ+M0l+qie67LhkK7RSjsiHSRhWd+j0ZvZfZIJ5q4F2pVl5OD05
	 dvPiVIQAGlv3g8Dwh8zF7Q8M7OoywS8oEQqVYW9a3ZWmUCW25dMRrlhvU10XIrPArE
	 9fLRRMw9u7RwN+A1YWze502hhK4/snFkLLy09YRgt8XNT4jZN7E6uyeE15kz199FYt
	 URnTZW56RoRbA==
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
Subject: [PATCH 03/13] jump_label/x86: Avoid decoding instructions for jump entry size
Date: Mon,  9 Nov 2026 20:49:06 +0100
Message-ID: <20261109194916.1089703-4-jolsa@kernel.org>
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

Determine the jump entry size from its opcode or NOP encoding instead of
decoding the instruction. This reduces kprobe registration time when
checking jump label entries.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/jump_label.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index a7949a54a0ff..848a2aee05bd 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -15,16 +15,20 @@
 #include <asm/kprobes.h>
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
-#include <asm/insn.h>
 
 int arch_jump_entry_size(struct jump_entry *entry)
 {
-	struct insn insn = {};
+	const u8 *code = (void *)jump_entry_code(entry);
 
-	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
-	BUG_ON(insn.length != 2 && insn.length != 5);
+	if (code[0] == JMP8_INSN_OPCODE ||
+	    !memcmp(code, x86_nops[JMP8_INSN_SIZE], JMP8_INSN_SIZE))
+		return JMP8_INSN_SIZE;
 
-	return insn.length;
+	if (code[0] == JMP32_INSN_OPCODE ||
+	    !memcmp(code, x86_nops[JMP32_INSN_SIZE], JMP32_INSN_SIZE))
+		return JMP32_INSN_SIZE;
+
+	BUG();
 }
 
 struct jump_label_patch {
-- 
2.43.0

