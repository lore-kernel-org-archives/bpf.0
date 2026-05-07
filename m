Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA450332906
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189411; cv=none; b=aLHEn2NfBneq61V3yQt4dOIu8rucm0NDqxGH4ZleDjRp8QTnjzq9mbrT/1UniIvGYzUlBFhfZCG07ItPff775WRwF3RuA4xI9tAd1xvs+nX2tPnNh5gjeI0ipRH3C/Yw+dDDoBIgIgPiemiMlJPazvPxqgcBj+GV8afA2bMOHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189411; c=relaxed/simple;
	bh=6RsnmSRGCuQNiePBEgLbO/R9IWjvmVB4fmWGVGr/dGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLL7xOBlCDxgOFDruVLx/osA4KK2xQCwvqSxjtWU2498p/5C2cDgUG18UX7jtRnDhzSo6o02fC0osJFrtL0FxZpqXF0Tx53nNzqSz2QbmAQeluOgo5wuezpJYnPPp6i59dLJhDaEI6YT1GjXmHmNgzFDKjgr0fn2Ryw07jzEg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 698C392BAA284; Thu,  7 May 2026 14:29:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 03/23] bpf: Add helper functions for r11-based stack argument insns
Date: Thu,  7 May 2026 14:29:58 -0700
Message-ID: <20260507212958.1123333-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add three static inline helper functions =E2=80=94 is_stack_arg_ldx(),
is_stack_arg_st(), and is_stack_arg_stx() =E2=80=94 that identify r11-bas=
ed
(BPF_REG_PARAMS) instructions used for stack argument passing. These
helpers encapsulate the detailed encoding requirements (operand size,
register, offset alignment and sign) and hide raw BPF_REG_PARAMS usage
from the verifier, making call sites more readable and explicit.

A later patch ("bpf: Enable r11 based insns") will wire these helpers
into the verifier. Until then, check_and_resolve_insns() rejects any
r11-based registers.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b77d0b06db6e..918d9b34eac6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -749,6 +749,27 @@ static inline u32 bpf_prog_run_pin_on_cpu(const stru=
ct bpf_prog *prog,
 	return ret;
 }
=20
+static inline bool is_stack_arg_ldx(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_DW) &&
+	       insn->src_reg =3D=3D BPF_REG_PARAMS &&
+	       insn->off > 0 && insn->off % 8 =3D=3D 0;
+}
+
+static inline bool is_stack_arg_st(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_DW) &&
+	       insn->dst_reg =3D=3D BPF_REG_PARAMS &&
+	       insn->off < 0 && insn->off % 8 =3D=3D 0;
+}
+
+static inline bool is_stack_arg_stx(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_STX | BPF_MEM | BPF_DW) &&
+	       insn->dst_reg =3D=3D BPF_REG_PARAMS &&
+	       insn->off < 0 && insn->off % 8 =3D=3D 0;
+}
+
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
=20
 struct bpf_skb_data_end {
--=20
2.53.0-Meta

