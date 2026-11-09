Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254221;
	b=AZ+O8yHoRJSs6qw6FTB7DwaUmdAzFoYKPX86w930dekpcmtDIMm/w8E22Rtjtb4ZqgD3
	 3Wv0t3GHjO/l+xFOIBgfp5vtaNE021S0p9IJxteJn9zde5JLWZVgjOrfD0s1oB0KfqZqj
	 5ZxM4dcBhBYXscFDxERUsn7MGwfp0hI94nfbGiPdUfw/A9Ml/8lNimnYmFSvm6uCNl4mp
	 2qK7/WF4jALDIWKMn3BIzlL+kkgYgelIN0kcdQTQTQSNuASW3R7Gbpj2CHvOd7Ka4eoV4
	 4we0A2oLlquApRCUe9SLRfum2TMUmDtUURJuuzmys5yY5oN64aPKdA0hJjx1zIpqR8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/kAtYQTLAJCbBAM/raGyI+joG6BcNUH0LJkN+94b/rY=;
	b=hEFOmVJkUmn0d/EfcdODOdfnhPUh16DD53HOSMzv2A8jAZ/SFLi2G7ZqaL18d2MubkoM
	 lZtOwnmoNOaYteR7Bwgk5vNf/NbVTH769jeEKNwwtHZlOczfQQDGAfxkzUKsuOfHa4XL/
	 2IulkYmyUpPoFUl/32z/hIKlBTZX2hBpZwNfewkKyDAza4xlnvmKoouD/IRlCOH5Uq8/0
	 25AKnU65CKe/Vps6XHn3piZ3CYTEs9g9EkA7NMkAdjQq/Lc3YnLusBkwACffrNQZAmeWC
	 CflfitLsEZPjgVW2uU7gQ7GYho81ozABE9t9mQ2r6tKmymg+nO0lFVNU8jXZ1QYn++Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg4QOIUX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DE606A325;
	Mon,  9 Nov 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg4QOIUX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431ED1F008A3;
	Mon,  9 Nov 2026 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254221;
	bh=/kAtYQTLAJCbBAM/raGyI+joG6BcNUH0LJkN+94b/rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jg4QOIUXPxQOL5vsYjcQjhjAN6I1RYvdu9/vpo4tk9O6539z3ZbjiPyf/+c/tNREy
	 LOkLwjM0XG/guhx6PC6EQbsWrjVKm6XY+C/baI4MTltrD2NZbGuvxveIOvRmsIhKpy
	 osyPioF6wi7QuezhcNVOk27a4AfQg5hRNC1LYztBcXSuqutUvNzkE8QBhRFvdZwZqD
	 qSEhVHkke3iCWfsq3wf1LFlW0pcpXMTwML0qD9IPHyDF7s3uRXyt2s2ck9hQEAqzrP
	 fsnek578kdk9wXjgMF21DBRqekAGC+m51+Tol5bcUFCdSypOC9EFu6PbjKojrKsdQK
	 JiWUmb12xrlQg==
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
Subject: [PATCH 07/13] kprobes: Use kprobe iterator in get_optimized_kprobe
Date: Mon,  9 Nov 2026 20:56:55 +0100
Message-ID: <20261109195655.1091099-1-jolsa@kernel.org>
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

Use the kprobe tree iterator to find optimized probes whose instruction
ranges may contain the given address. This replaces repeated hash lookups
for each preceding instruction address.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/kprobes.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6655c24bb66f..371ecc7d5b54 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -591,23 +591,25 @@ bool kprobe_disarmed(struct kprobe *p)
  */
 static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 {
-	int i;
-	struct kprobe *p;
+	unsigned long offset = MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t) - 1;
+	unsigned long addr_val = (unsigned long)addr;
+	struct kprobe *p, *candidate = NULL;
 	struct optimized_kprobe *op;
+	struct kprobe_iter iter;
 
-	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++) {
-		p = get_kprobe(addr - i);
+	/* Don't check addr itself, since that is a breakpoint case. */
+	for_each_kprobe(iter, p, addr_val - offset, addr_val - 1) {
 		/* A disabled probe can have prepared, but inactive, optinsns. */
-		if (!p || !kprobe_optready(p) || kprobe_disarmed(p))
+		if (!kprobe_optready(p) || kprobe_disarmed(p))
 			continue;
 
+		/* The iterator walks low to high; keep the nearest matching probe. */
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (arch_within_optimized_kprobe(op, addr))
-			return p;
+			candidate = p;
 	}
 
-	return NULL;
+	return candidate;
 }
 
 #define OPTPROBE_GEN_MAX 2
-- 
2.43.0

