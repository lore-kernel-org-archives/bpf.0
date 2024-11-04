Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4111B81C1
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748913; cv=none; b=mpTMry0TkADr/4qvBUzoqmwNdQJMwYh+da+BtrkUjIYw4CTX6pIHLSerkN0KU7DmwLgkrN7hP36B99TQ5q71PtQKe0GEGkEplMYrcR4pnYyf+XIvsFck9GCePzB4rI4U3Y0pmBboAgn4Wx+SsgceqP3k99rzkSnnIvY9tuo3tWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748913; c=relaxed/simple;
	bh=aJVUeJaR8wIV+UxniBNtljwZavdiTAw74q2xJ95lgr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li+H2EDqgp758MBdse2jrhortp+GXAWehkkfElchOiJbsxDti9wuoLMcs9Oz9TcFQpDyKd4dB1gQTABJCDScmLzRJRmnK+f6llKtLjQzSbDJZb9sbJRDmJ5zzGzkyswgNHVLLrIeM3Uwzi2w/kdAo1RMgkpt0UFPOL/Ai2kNuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 97A4CABEC728; Mon,  4 Nov 2024 11:35:05 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v9 02/10] bpf: Return false for bpf_prog_check_recur() default case
Date: Mon,  4 Nov 2024 11:35:05 -0800
Message-ID: <20241104193505.3242662-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104193455.3241859-1-yonghong.song@linux.dev>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bpf_prog_check_recur() funciton is currently used by trampoline
and tracing programs (also using trampoline) to check whether a
particular prog supports recursion checking or not. The default case
(non-trampoline progs) return true in the current implementation.

Let us make the non-trampoline prog recursion check return false
instead. It does not impact any existing use cases and allows the
function to be used outside the trampoline context in the next patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..ad887c68d3e1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -889,9 +889,8 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_STRUCT_OPS:
 	case BPF_PROG_TYPE_LSM:
-		return false;
 	default:
-		return true;
+		return false;
 	}
 }
=20
--=20
2.43.5

