Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC632B126;
	Mon, 24 Aug 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604136; cv=none; b=TxGJCAuoDrb1qxUbKxx9V5XveFEp3xF46QfY1hPaNpG4BT0VoykCfXKm3HZD9X1QKDgdzBoWbdxoKVfQn8CJ6pN6MKXP7mIZ5gSWbebnuNt6vkvWJVZoyOqgVvN6WcMBb0K/AGZ297alNNUgsRljZyujfaJD8pv1zLUqnHEOWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604136; c=relaxed/simple;
	bh=N9ao2tIoejKeT4PtogF8TIRbIeDQYxmEnoUtTF1LhuY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s/DhzrSXk4kO3b8eL6GDYSBcH7Bv9/jALUXafAw/5KqyVn3+j/v5NY+maYVvf+Fz10yMnQPSbphxmyWWDSNtt15SfzDi5Wj/8rGFtfawXfbamOjBJIOyzhx1nv1W3HV/zJgZvlV3XGBKhExQBSz8GiMQasPXRzwCIPfRoJAHbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Enq1dWk4; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Enq1dWk4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=H4JltXOvCzyBgDsXlwVthf0STjunErKLt3IuZn4hkII=; b=En
	q1dWk4l7Gzg7Ssz9CP7ucIperKWD8L33iwTSSKHN3FLA0GcAzFjM5HkEaulS7Yj5mWzH7BbjrwDkf
	q7U6x+wJbwOWntcyrevCgtO68h8ISCHoC4eCvIK04YO73f35bFTReYFUYILFuYemEs1dhdTtmMadx
	vZMuN/R/rglylCn8H5t/v4WOp+k8FYlwpgApUU0F9QxDsvop2Lbs4SEpYLSaWyI69O+gP5KsBiNjj
	IJRfhFYDOvOIyYJ8mv/orVHiE6i5m3rNt585+rr0hZozWhQ1sWHMSD4wGywoqU6D3pfwOoNC2fUsa
	cZaA24K8LoptHjhNbbgFhNjo/fVcIK4w==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1wybUK-00000003A09-2rI7;
	Mon, 24 Aug 2026 20:41:48 +0000
Date: Mon, 24 Aug 2026 16:41:43 -0400
From: Rik van Riel <riel@surriel.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix array-index-out-of-bounds in print_bpf_insn
Message-ID: <20260824164143.485301ca@fangorn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

syzkaller triggers UBSAN array-index-out-of-bounds and panic_on_warn
panic in print_bpf_insn() when loading a BPF program containing
BPF_LDX | BPF_MEMSX | BPF_DW.

bpf_ldsx_string[] holds three entries for B/H/W (s8/s16/s32).
BPF_DW gives index 3 and reads past the array. check_subprogs()
prints the program via bpf_diag_program_structure() before
do_check() validates the instruction, so the illegal insn reaches
the disassembler.

    UBSAN: array-index-out-of-bounds in kernel/bpf/disasm.c:306:21
    index 3 is out of range for type 'char *[3]'
    print_bpf_insn+0x2328/0x2940 kernel/bpf/disasm.c:306
    format_disasm_line kernel/bpf/diagnostics.c:633
    diag_print_insn_context+0x3a5/0x930 kernel/bpf/diagnostics.c:783
    bpf_diag_source+0x615/0x14a0 kernel/bpf/diagnostics.c:896
    bpf_diag_program_structure+0x1f9/0x280 kernel/bpf/diagnostics.c:1215
    check_subprogs+0x5c3/0x650 kernel/bpf/verifier.c:3057
    bpf_check+0x1935/0x89f0 kernel/bpf/verifier.c:21097
    bpf_prog_load+0x17dd/0x2990 kernel/bpf/syscall.c:3133

Guard any size index beyond the corresponding string table and emit
BUG_ldx instead of accessing memory beyond the end of the the array.

Fixes: f835bb622299 ("bpf: Add kernel/bpftool asm support for new instructions")
Assisted-by: claw:muse-spark-1.2 syzkaller
Signed-off-by: Rik van Riel <riel@surriel.coM>
---
 kernel/bpf/disasm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 50b3ca5149a0..67bdda1c021c 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -295,15 +295,27 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "BUG_st_%02x", insn->code);
 		}
 	} else if (class == BPF_LDX) {
+		unsigned int array_size = ARRAY_SIZE(bpf_ldsx_string);
+		unsigned int size_idx = BPF_SIZE(insn->code) >> 3;
+
 		if (BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) {
 			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
 			return;
 		}
+
+		if (BPF_MODE(insn->code) == BPF_MEM)
+			array_size = ARRAY_SIZE(bpf_ldst_string);
+
+		if (size_idx >= array_size) {
+			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
+			return;
+		}
+
 		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)",
 			insn->code, insn->dst_reg,
 			BPF_MODE(insn->code) == BPF_MEM ?
-				 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
-				 bpf_ldsx_string[BPF_SIZE(insn->code) >> 3],
+				 bpf_ldst_string[size_idx] :
+				 bpf_ldsx_string[size_idx],
 			insn->src_reg, insn->off);
 	} else if (class == BPF_LD) {
 		if (BPF_MODE(insn->code) == BPF_ABS) {
-- 
2.53.0-Meta


