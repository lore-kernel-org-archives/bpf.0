Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888CF393DEB;
	Wed, 25 Feb 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017979; cv=none; b=bTL4KeoC8uwQLyze2w9c21gv6jBWLFctRJ6nAzAlL4Sf+aDJfZ6bVjPDMnrg2BQNY17OHbiVkaAU/W/fuydS2z+J5ce2wewEGj6dkeuRGOs7wb8PsKICaHK0PSSr/p9/F63oBvuXTy9qSzrSWkvEe82k4ScCy8WiECCnjzPdRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017979; c=relaxed/simple;
	bh=AIOWAd8Dlt/5ms9fT6CrYW4koN+0gwQ84aeIXWTJXlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGyqTl2YQZb1ipKpfLUqsZegVrJf7TEA+ZPaYu+InxaZm6JBSbYwJYQIPu8DJ2482ywLCNrmLWtxQLLkSQigtFx/Fe0DcC7QNgel+TjYdl45VQso0ZGJRl1J4mHewPjGrDO2A0kHF46FtO3QGoHjCadzNg7O3JWU+pFgX/s4wA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5im3rpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5im3rpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3423C116D0;
	Wed, 25 Feb 2026 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772017979;
	bh=AIOWAd8Dlt/5ms9fT6CrYW4koN+0gwQ84aeIXWTJXlw=;
	h=From:To:Cc:Subject:Date:From;
	b=L5im3rpU6xNVqZDUqXO0x48txzFtnQezNx57OfC7DpD+KFmjaTAT+9KheR2ydjkOm
	 u/lKY6SWRZ1QOWUSlDenXZZt7v6ODRHSOnmh/kiaoiBcaL9kkzSTa7KhijyBsltyyD
	 BhuXbB2/gn5K130QGHy91D9mg+YKobHc/+r5RO8sNgSvoX0nv0Xn2gd9SGyPXOQPGq
	 GzNKPpgu6/vKLoUgPrbOpo83ul3XH5/3RmsrgG5eopeJx5CgeTqVPyJC9zlGfPej7/
	 P/e6k/Ee92cD3pCY95fIzfJvxLnIURqA/3zC4Amxt5A1+C6BuZ8akoIvnoJkjsG4Df
	 NZiwZbU/hTm0g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf] bpf: Fix kprobe_multi cookies access in show_fdinfo callback
Date: Wed, 25 Feb 2026 12:12:49 +0100
Message-ID: <20260225111249.186230-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't check if cookies are available on the kprobe_multi link
before accessing them in show_fdinfo callback, we should.

Cc: stable@vger.kernel.org
Fixes: da7e9c0a7fbc ("bpf: Add show_fdinfo for kprobe_multi")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9bc0dfd235af..0b040a417442 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2454,8 +2454,10 @@ static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
 					 struct seq_file *seq)
 {
 	struct bpf_kprobe_multi_link *kmulti_link;
+	bool has_cookies;
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	has_cookies = !!kmulti_link->cookies;
 
 	seq_printf(seq,
 		   "kprobe_cnt:\t%u\n"
@@ -2467,7 +2469,7 @@ static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
 	for (int i = 0; i < kmulti_link->cnt; i++) {
 		seq_printf(seq,
 			   "%llu\t %pS\n",
-			   kmulti_link->cookies[i],
+			   has_cookies ? kmulti_link->cookies[i] : 0,
 			   (void *)kmulti_link->addrs[i]);
 	}
 }
-- 
2.53.0

