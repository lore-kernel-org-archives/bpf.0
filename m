Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769C395DBF;
	Tue, 15 Sep 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503750; cv=none; b=LjwdjKACLQBg646HNtpLBqfCMnx1tM+mHjIqe1wZkPKerz3IkIYI/U3G0t7nNtLs1AagfyboRRAbuv4hqiCkUUcOiFNWSfzVk4L4o7vfwX/fUxsR/LIEl5ERf6MpMnm9Hqq8o7Dk1li1d7Uge5ZO9cKM8JVydTMzYkEYLFkFsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503750; c=relaxed/simple;
	bh=IhCshPMisyA5RzAfuQ48WvutxKE/BImzgd0SyyM243M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrDoVn4HE6k6DeFkti+7DT9TXgk1ATxSq5x53/J5xamvsjjCb8niP4O4aiQKk8n6TM9j2eq1wroBVyEXwOKRMlSFTxBKPqJMeTVgenZLSig3OKEe1B/dOAx7yi3aphYJJR48iGc6zIPVbdLa/LM+0Jd/5YGtxZruscqoHom1Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm2znzhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm2znzhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D1C1F000FF;
	Tue, 15 Sep 2026 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503748;
	bh=H4ovA+O8RxR19M4awAjvuIdTnz1e6wDUOJYDRLyHkqM=;
	h=From:To:Cc:Subject:Date;
	b=dm2znzhdE6OvSJSwDwwzTrEylPdpNaqFuuYJhKsn9ylpVNzw2Oa+QBtZW7xG05GKO
	 3JhlW6Dct4n9TXGtw1Ei0zQAcYSiSd/VcwGNDDg26hbdPAa/lpSL+4ocwARxNdPogm
	 UT4Gpodn4kypD7yaHFvt7Wxn9SPWhc9t99jL7kgHcwrP52nCjBQ3F8kM36l0p+c9zY
	 aOPjb5P6qZO5DC778Z931noqYi2eK4XsPU3HOvNlOUmYyVHHxJlzpsIdvgnSh/eBds
	 NjZ5MPVcDq5pCFDc/NjAlSJkAObGXRDjkeNyHZcndK/6KUjk7sGVezDmY3PGPaxbB9
	 N0bqyaNWXiZRw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	Kees Cook <kees+treewide@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: add printf attributes
Date: Tue, 15 Sep 2026 22:21:55 +0200
Message-ID: <20260915202220.3535321-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with extra warnings enabled shows some missing printf attributes:

kernel/bpf/diagnostics.c: In function 'bpf_diag_source':
kernel/bpf/diagnostics.c:828:9: error: function 'bpf_diag_source' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
  828 |         msg = bpf_diag_vfmt(env, fmt, args);

Add these to shut up the warning and allow the compiler to check the
format strings.

Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/diagnostics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index a2cac59c6639..b069fe73d3dc 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -291,7 +291,7 @@ char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size)
 	return buf;
 }
 
-const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
+__printf(2, 0) const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
 {
 	va_list copy;
 	char *buf;
@@ -309,7 +309,7 @@ const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list
 	return buf ?: "";
 }
 
-const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...)
+__printf(2, 3) const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	const char *buf;
 	va_list args;
@@ -794,7 +794,7 @@ static void diag_print_insn_context(struct bpf_verifier_env *env, u32 insn_idx,
 	}
 }
 
-static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
+__printf(4, 5) static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...)
 {
 	struct bpf_diag_scratch *scratch;
-- 
2.53.0

