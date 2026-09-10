Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F73C3F4B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076124; cv=none; b=PsiKcoPxPApjKcZAyRot8Ip2JChUohBFxGGUivAqDuniGHTRWnF3BJsKpwO2notczkhSBmWE/GXTeeMU+BC5sq5V7VNyrcIEGhJe8iPIncXCul1ZtaTpDRbKQPptUtpiDEJXgPLawK2EYG1aWKS9UIU7br4CdF0Q7YIrYLam9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076124; c=relaxed/simple;
	bh=qazRIji5A+0gI3RZ1IL6lIcXNK1ftLbw9Sc85Jlz9w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUYAn5ocTz5Ia46Z3AO6e0NBTzaltJ1lzKc0ZpaE0+H0sUWOEp7+RC5ORH4KJV0yFAkHXa2DjhTpaqmwAPhEZ4HTXwaEZLzMXIBmmZ32sCaoBXBZXOjgGPaDeUAU0J2f7JCOzU+Z5e+qcvXKjsCbx0OOmvVC24SQeTQ9qStTszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Y0nr/HwE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Y0nr/HwE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OJhwjqwey4zGKezUYPDDBQXymqeUpEOJC4QAcSF4XM8=; b=Y0nr/HwEr+q+pLOvxSVOlyty1P
	e1nOV8aRX48SoeS0uNCzHU++54bBZJ0xLpoJtt1TxfDLVuYqZEH3654dhayc1q5tNmhUJcRdgLURx
	HMQw/CHbCVcakL5DcFoyJavXM9uXNkb+eiqP/UnDrsgetaL++5JQJ+D4ZaoP9VGUB14bsZ0UNNJ+D
	7Mn/nzSe9cHY0x+Fp84z7jXev8F/lb0ZC33JE8d6r3XCAqwu3MlQ+Y05rkoBkD456C8LW8gTK68v8
	E3LDGLQMeZlctFjoJG+9+RRzXoCwUzVtl6t6uE66cWmQacFLXhvzL822a+I140eVCiyWDv+nc6jRU
	nsJa0XUQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4mQK-000H2M-1w;
	Thu, 10 Sep 2026 23:35:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 3/4] bpf: Require CAP_PERFMON for untrusted read-only memory reads
Date: Thu, 10 Sep 2026 23:35:09 +0200
Message-ID: <20260910213510.49358-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910213510.49358-1-daniel@iogearbox.net>
References: <20260910213510.49358-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

Marking bpf_rdonly_cast() KF_PERFMON CAP-limits one producer of PTR_TO_MEM |
MEM_RDONLY | PTR_UNTRUSTED, but not the type itself. A global subprogram
argument tagged __arg_untrusted results in the same register with no kfunc
call.

Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - Fixed formatting bpf_diag_policy (Alexei)
   - Dropped Fixes tags (Alexei)

 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 939e535a3442..8058f684a9ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6453,6 +6453,15 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			return -EACCES;
 		}
 
+		if (rdonly_untrusted && !env->allow_ptr_leaks) {
+			verbose(env, "%s access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+				reg_type_str(env, reg->type));
+			bpf_diag_policy(env, insn_idx, "read from untrusted read-only memory",
+					"the access requires CAP_PERFMON",
+					"Load the program with CAP_PERFMON, or avoid dereferencing untrusted pointers.");
+			return -EPERM;
+		}
+
 		/*
 		 * Accesses to untrusted PTR_TO_MEM are done through probe
 		 * instructions, hence no need to check bounds in that case.
-- 
2.43.0

