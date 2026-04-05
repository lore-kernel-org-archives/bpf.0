Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8631352B
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408003; cv=none; b=B/M/fwysEAodlAdNQcWBIFCSg6OHcK4JVuUvAZ4bAc+1hHOkKlP3wOTCNXMO91nJSkTK8OW61df2ptPiTn6/Y6LzkKL+GECHxF0ij3hLKUWxyz/+ApzCrMMB80Biw6BIqwbYjuySp6pL4z1Ci2BjAxHgGJm6tlAiTSzxcJrT+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408003; c=relaxed/simple;
	bh=rOVTP6j2o5AgrSQ2WEsvWutJxeFvkZXp06A9W4DYdjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEAQ4bhY35HO9HbnmUTi8J/18/58sG0oN7h8tV8cF/DD0+VV4FcsZDd1rDzrAKSjE2700fQHCjo6KPPRpakSQ+gKq2T8hnzX4pwN1YJdJOuJnDhWCzbC01Q0ybTLpVQ+qV05Ocu1SZmsq5y+dcG6nEqE7ZboaNnaXi15uIDVhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BC5EC361CEF57; Sun,  5 Apr 2026 09:53:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 02/11] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Sun,  5 Apr 2026 09:53:10 -0700
Message-ID: <20260405165310.828078-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405165300.826241-1-yonghong.song@linux.dev>
References: <20260405165300.826241-1-yonghong.song@linux.dev>
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
index 35b1e25bd104..99701c4cc34e 100644
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

