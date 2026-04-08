Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D093C5DA0
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675568; cv=none; b=KPpiFW+K2pxj7odpMcXljy7wVOtST0+6fR/911evg50oiTKxBJUXKvbOUYPUYe71itIRrlsSgcAX7JdierOjm4UgNSgBWTf9jsFn6RPkl82hpFzBafD7fu3KTc8AuGZ0yklD2qbAQfO7TW1kUpk+kqKZ20GWQMDmL0EseY0n3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675568; c=relaxed/simple;
	bh=XHkTcuC+JfMuMwqjnSCr1XDFMBygMZphdkZ/5IdlAQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCDc3Jy266wVkTHJ8KFRqU3d2U+nnRpK/Iau65SLxukF62imYLWKwNnj09JwgqUDCQTaZJ8AJigJsT8sLl05+el7IujfKRm8WGBQepdX0UGC6rhk78vX8/33c58IKvHYaIT7V0Tvq5dxcLBQ1kx4XcGT1XFNsIwjUOCv4+eHbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JVt7tFBR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JVt7tFBR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XyDN72mhHCqzpk9k2x71XXZl0MKcQ9b3N+s01C0SzTE=; b=JVt7tFBRpSZW7fGPTRtslNXrvW
	KAe/T/UqS2aTMdTUNRFOSdnHPFyNdEXcjhnSSYFx1L43pyVvXExmaykhspyzAJpKnBSXImDl4jXNS
	ppgoExtd0wr3tCL+qMm9qMgmgGOeoEWjOR6BsqPEftOUppD/Szcu9P7Gqq0rK0HrjLGYeVnkorujp
	YbOb68qxQ4etGmFCrPvUCOwQk5LFVTB8aG8TvxOnZcsuGuPLs2ZCK3yyCDBMDmgxLP6+EvVEIbplf
	O6VqJfEoEKqy22AKb13MFCK+YdVpraVuaBLkj+OkAO6GWqluYJ5b5WuvnEh2YkIANRT0D/gxHnQfp
	qBzLoUVA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAYKS-0002O4-1T;
	Wed, 08 Apr 2026 21:12:44 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v2 3/4] bpf: Remove static qualifier from local subprog pointer
Date: Wed,  8 Apr 2026 21:12:41 +0200
Message-ID: <20260408191242.526279-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408191242.526279-1-daniel@iogearbox.net>
References: <20260408191242.526279-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27965/Wed Apr  8 08:24:37 2026)

The local subprog pointer in create_jt() and visit_abnormal_return_insn()
was declared static.

It is unconditionally assigned via bpf_find_containing_subprog() before
every use. Thus, the static qualifier serves no purpose and rather creates
confusion. Just remove it.

Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fffb38a441e0..1227b168bb07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19225,7 +19225,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 static struct bpf_iarray *
 create_jt(int t, struct bpf_verifier_env *env)
 {
-	static struct bpf_subprog_info *subprog;
+	struct bpf_subprog_info *subprog;
 	int subprog_start, subprog_end;
 	struct bpf_iarray *jt;
 	int i;
@@ -19300,7 +19300,7 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
  */
 static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
 {
-	static struct bpf_subprog_info *subprog;
+	struct bpf_subprog_info *subprog;
 	struct bpf_iarray *jt;
 
 	if (env->insn_aux_data[t].jt)
-- 
2.43.0

