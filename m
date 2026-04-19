Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800842BE7DC
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616441; cv=none; b=hY4HNdctH6m2t61zhUKHFXwUwkUdu/7pgh7J2va1QmR0Ct6yJbD15BZMf4/HChAYfTt9erQI0ZiJ7TGmwOqcuUuLge0eFsud39DPqTlpNJJcQTyLwZlJW5T8ORbUOSWysGeYBnmQL2NZz9sa2pbBIV8d6gaxmLCaVRqI192EkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616441; c=relaxed/simple;
	bh=3bMrLM7cQtEOPC7a3Vb/IX4CktjlXCZmYvt5s6tscHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIjZVYOH7H3EkI8v0ZnkFB32guiUpSYhrhlxoXzJEvVdLIh52ECFssi6p/9oxXNCvchgT5sBJv51mhLcjis9Wvdt4imBZsyJ+ogZl3roGnD21YKRBsv1eOHlyACQMpWMNzRAjPZBv+JmEyeMXiUKzTveSOabpEKd8LuIEiWFAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 273A942DD4DBF; Sun, 19 Apr 2026 09:33:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 06/17] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Sun, 19 Apr 2026 09:33:47 -0700
Message-ID: <20260419163347.733962-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419163316.731019-1-yonghong.song@linux.dev>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
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
for bpf functions and kfunc's. The current value for MAX_BPF_FUNC_ARGS
is 12 which should be sufficient for majority of bpf functions and
kfunc's.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4b703c90ca9..c2e614236e1c 100644
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

