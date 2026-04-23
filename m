Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5063CBE77
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915316; cv=none; b=ZqNUyJwj48ntPKI3q9JETcFhEAlFMyciJ7Gy1/3ZGZWyqi09AKMXOBC/g6ZB6ge/YgHnJnuinpUY4j3ErrzSbs26t0TPeeqpdQ0m/CyqJ9AukGeW4u3tfzvAdZhbY9lZqdGDNgduW7q0+QjgzLi/PcqHAjLwlV7KbTvxjq3/Law=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915316; c=relaxed/simple;
	bh=5YAAOv2TzmNrNkRlYrojAzXCjVJT3KK2SYM64kEXegM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlRfujStp1zOSTfIf5FgUOrr+sUOJTB0IO1v5pkkRcK4L0UmJYytOX9h4jzziH5FwotTu+/NnNbanpNn6RlGN4eHmSLhP41Wy8ZM605+4L6KPbJ/p2pBkZhRkzRr4XRnSDdVnnQ6mCxrX5Vle0MrLCQydOicnxnmsYRAzmTPCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BADC445844BF5; Wed, 22 Apr 2026 20:35:11 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Wed, 22 Apr 2026 20:35:11 -0700
Message-ID: <20260423033511.2542870-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423033425.2536883-1-yonghong.song@linux.dev>
References: <20260423033425.2536883-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, MAX_BPF_FUNC_ARGS is used for tracepoint related progs where
the number of parameters cannot exceed MAX_BPF_FUNC_ARGS.

Here, MAX_BPF_FUNC_ARGS is reused to set a limit of the number of argumen=
ts
for bpf functions and kfuncs. The current value for MAX_BPF_FUNC_ARGS
is 12 which should be sufficient for majority of bpf functions and
kfuncs.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d3aea3931b85..715b6df9c403 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1151,6 +1151,11 @@ struct bpf_prog_offload {
=20
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
+ *
+ * Also reuse this macro for maximum number of arguments a BPF function
+ * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
+ * stack arg slots. The JIT may map some stack arg slots to registers ba=
sed
+ * on the native calling convention (e.g., arg 6 to R9 on x86-64).
  */
 #define MAX_BPF_FUNC_ARGS 12
=20
--=20
2.52.0

