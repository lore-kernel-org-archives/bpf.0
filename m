Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949B39D6FF
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205509; cv=none; b=hYGrjBXTkZQdWr9YAFUfst5iQkCd07iRd40ail7FTmoknYrfJWd+W/e1LjGal2/jvvDzEgFoBb7kaBzHxk9uLNs1vW3MXvpYOOSA8nlhmhfL2hxfiTmEFDFJm/7qh0R++SulKDGfYSB90zv5R83pxa1WEsWt8zLn9y/G2fzUvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205509; c=relaxed/simple;
	bh=vyYUgEkuTtW6R/0bLtR5RUHqYzzPJ97ZNp3EOFbNsGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1Q3S1U5keJrOpYn9IaPzS2vWPBZf2amQdW1RnTv+AMZ3M995UT4gNsDZuQ1yD+dcNGqiwcd0pEMdIgNdJ6PBvyJKo40RQF5HK3Z4p4+DoRkoNetJ3DPdhJHyvpaF/JpdLRUh9j+GHYkjwPZ+3JdpdnWPNGW/IlnzOiUGVdRdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4B82A31B3AFC20; Fri, 16 Oct 2026 19:51:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 02/25] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Fri, 16 Oct 2026 19:51:40 -0700
Message-ID: <20261017025140.1916510-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An exception cleanup needs two terminators:

 - bpf_unwind() begins an unwind: the frames it leaves run their landing
   pads on the way out to the program's exit. It is separate from
   bpf_throw(), which discards the frames in between.
 - bpf_unwind_resume() ends a landing pad, carrying the unwind on. The
   compiler calls it _Unwind_Resume, which a later libbpf patch resolves
   to this name, and passes it the exception object, which the kfunc
   takes as ptr__ign.

Neither is registered yet: that waits for the patch that dispatches pads
at run time.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 439370d73cc5..8df3f4746b68 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3424,6 +3424,10 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
 	return false;
 }
=20
+__bpf_kfunc void bpf_unwind(void)
+{
+}
+
 __bpf_kfunc void bpf_throw(u64 cookie)
 {
 	struct bpf_throw_ctx ctx =3D {};
@@ -3445,6 +3449,15 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
+__bpf_kfunc void bpf_unwind_resume(void *ptr__ign)
+{
+	/*
+	 * Not meant to run: every call of this kfunc is to be lowered to
+	 * 'r0 =3D 0; exit' by the verifier.
+	 */
+	WARN_ONCE(1, "exception cleanup resume was not lowered to a return\n");
+}
+
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsig=
ned int flags)
 {
 	struct bpf_async_kern *async =3D (struct bpf_async_kern *)wq;
--=20
2.53.0-Meta

