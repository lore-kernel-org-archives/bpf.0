Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEA4A49BE
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819787; cv=none; b=U8E/RuI99UxDj7VblNAVhtwRwhK8G8du1oLRTqF2n0W5jiiauR4iNem71nijfhlQH+Nx0DwK6FeypcIjZdeuFynku5acqIEsLKq8oyOJi8ZSsJvyKU+qWMrCvTMiL/IuzDLiEzLbNTZikViG34ZOrQOPb3B6aMH00CL8ztHRyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819787; c=relaxed/simple;
	bh=MMwLQgaIH8iOkYCAKi6D4zbeDsMl05kzZIAsPledUBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahjc0Wb7t6XIA5ER5ZBhZR+QOMpmRKj3VGmCsYDUScqTMHJe8Nz1nhBNCe0BVjmC0vbueDKYUpI2Tam9uvKNr9JHMjS5I4x59FoWTSG4qju3vR+Saf/YFoAaCbY2dOtMYAPOHkxNSvQEgFe2RXN3EF4AEPP5nxsCgpHXZ1D0NZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3D0Zr+q; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3D0Zr+q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MMwLQgaIH8iOkYCAKi6D4zbeDsMl05kzZIAsPledUBw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819783; v=1; x=1792424583;
 b=I3D0Zr+qY2FEefgHs5vhAXV6h9PEo2dwRKjo1PGQWuURfyPL8/Ocq5ed8youYj9iH/XdXgqL
 ke75ETu2ZHlGdt4ocBJJL10KUTZUh2c9vce90gsMignEOtrAzygkaMP6YUKXfuml5sUy33jsfD/
 G53KJhsl5JU/M74hOp9hxSvg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d8f0d885529dae07;
	Mon, 12 Oct 2026 15:43:03 +0000
X-Mizu-Trace-ID: d8f0d885529dae07
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 07/21] bpf: Check tgt_prog before is_tracing_multi_id() in verifier
Date: Mon, 12 Oct 2026 23:40:09 +0800
Message-ID: <20261012154024.29423-8-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding tracing_multi link support for bpf progs, it must handle
tgt_prog first in bpf_check_attach_target() to avoid the case: the btf_id
is a valid BTF ID of tgt_prog, and also is "bpf_multi_func_btf_id[0]".

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..f2af2bbdd6fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22284,22 +22284,24 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EOPNOTSUPP;
 		}
 
-		/*
-		 * *.multi programs don't need an address during program
-		 * verification, we just take the module ref if needed.
-		 */
-		if (is_tracing_multi_id(prog, btf_id)) {
+		if (tgt_prog) {
+			if (subprog == 0)
+				addr = (long)tgt_prog->bpf_func;
+			else
+				addr = (long)tgt_prog->aux->func[subprog]->bpf_func;
+		} else if (is_tracing_multi_id(prog, btf_id)) {
+			/*
+			 * *.multi programs don't need an address during program
+			 * verification, we just take the module ref if needed.
+			 * *.multi programs don't have tgt_prog during program
+			 * verification.
+			 */
 			if (btf_is_module(btf)) {
 				mod = btf_try_get_module(btf);
 				if (!mod)
 					return -ENOENT;
 			}
 			addr = 0;
-		} else if (tgt_prog) {
-			if (subprog == 0)
-				addr = (long) tgt_prog->bpf_func;
-			else
-				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
 			if (btf_is_module(btf)) {
 				mod = btf_try_get_module(btf);
-- 
2.55.0

