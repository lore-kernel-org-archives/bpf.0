Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5A31F99D
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836559; cv=none; b=I8AeectjTWt44nla1rl8VS32bT1SFjVLDS/aukUSsmyqs2kqg2fqQIuc7Az+lI4jW/J9NJ7Nh2re6uA4D4Qw9YccGpPuHr/lKq+nd2pqGNQYZOFH4S8r1Yj6s7LRpXCA9GXbVdaMjBt5rD5mh21C5tZFBnv95v+TPQHsKHHLHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836559; c=relaxed/simple;
	bh=GnI0Exv4pkEf07nz66T7hPIQVEhbDry/zpFE2F+ct3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwu4fu6KFp+jsNuhQD+Pejw/Jh+0vpkSy5gUUEt0joR4NxA6YybCeCJKMOMFfy0MokxAMfVhB3Y+TSa1Ut2uRnc2NIXNlBo6sXt+vIHGZmqBhvby0J6X/zQaxKBa1t4B1SA29+Q1H3i4hmE3zBWIZeoSdZ/6PbSSmC+mzChQo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1DCB744D0849A; Tue, 21 Apr 2026 22:42:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Tue, 21 Apr 2026 22:42:35 -0700
Message-ID: <20260422054235.3129028-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260422054149.3124342-1-yonghong.song@linux.dev>
References: <20260422054149.3124342-1-yonghong.song@linux.dev>
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
index 3cb6b9e70080..c8e387b0ce46 100644
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

