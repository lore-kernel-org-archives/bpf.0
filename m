Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78201EB9E3
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397667; cv=none; b=Q7xbM7cGSVUSZwpKyetQSOZmYQIhd0PRcDVV4W8XQm2ezTaRitZr61sX6C2K9NtAoYtWPZunx8ohcYTBPEx56fzaLQe/VV+0+I6xqFuKDZtyQ9fJuVrLvv6/Y5zeq4yWpyXPR8+iJCiJwVGQk3OSrEpx3d5shPf+zYwhXjd7Evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397667; c=relaxed/simple;
	bh=XiAMW+pRNa+aD1lU5+Q5Gpx66P7cvRfGyB9zZp/9KIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZxv37KfxODqRnbwYB2x2DGyEJNjxc36J+f95LItJElzb2gnZwSZKsrLoYgOQP4Be4nFPG3nQm50yzRemxHKKAwGTJKlaITUi1Kh0IcAPk6ft8HWaLHmAWnN4KpLx6EfpRO444b/2I1CHQvDwmcZCSQKfmaESqRk3KB8WUZuEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 717EE403C23F2; Thu, 16 Apr 2026 20:47:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 07/16] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Thu, 16 Apr 2026 20:47:34 -0700
Message-ID: <20260417034734.2629722-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417034658.2625353-1-yonghong.song@linux.dev>
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
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

