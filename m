Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5F364053
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969960; cv=none; b=E4PVTlSTiiyygIto1IN9OqV+pRZwiaIEpC2TMYklY0cFco/hWyuHeifluN0XEx/LzLt1+BsD7HcekOPG3LWlHXFYCShpNbhVZm02r6MoITUyOqH/+fD1HWItHaZZkugwy+N+ZrkHtNjg/cv4QnRWd05IHBSY0VH7mcRlbbr6W6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969960; c=relaxed/simple;
	bh=XiAMW+pRNa+aD1lU5+Q5Gpx66P7cvRfGyB9zZp/9KIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTEI1BY/uzlhzeHlll+jD5tXC/trmAHQfHNlRm/UfcP33PdybcJW70VeNc+WqP3bPX+A97VeK9N9eueyF3nmW48t3g2tSGSXUCryzZwRiWWdWPAP7M4a7nc/C3TPeev8MAo/nVNyPrR312/5b+vuKfXogKhoG6NGgLauagsPv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 904273B021A57; Sat, 11 Apr 2026 21:59:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 08/18] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Sat, 11 Apr 2026 21:59:07 -0700
Message-ID: <20260412045907.257368-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
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
 include/linux/bpf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0136a108d083..b0f956be73d2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1151,6 +1151,10 @@ struct bpf_prog_offload {
=20
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
+ *
+ * Also reuse this macro for maximum number of arguments a BPF function
+ * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
+ * stack arg slots.
  */
 #define MAX_BPF_FUNC_ARGS 12
=20
--=20
2.52.0

