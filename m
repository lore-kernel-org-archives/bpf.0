Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D237DE99
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352355; cv=none; b=r+7QrXKjtMei73q+WQE36RKC8rxKUw4BgQOI8CQHhB4pp/ZSuFlAbNQvYeYUAjGfpru4ZUbBNO5i9EaU86MAqln2dTc+GPFS8Zn8vYZCQqEgo/5hYo0MCv2/OsNj9ncyv0s9CNkCA04ni+AQWuUYjaXrAZKOOLK+6B1JPu+tn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352355; c=relaxed/simple;
	bh=oG+5+MvKCfttHvIr7RJHu4qPlhBnYbFWLMYaTQcpB9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/Dt4YTO8YioWDsjYRTzmMKZJjxLshb3+mqNF5qFCvmYgJAT7L1vetsxJNN3WMsTpFsp1LV8ELtvMYq4Xy2uRqv4p9gjNBEHZNurB6ihfUTSKnuV8Sv4PsqUg+T45jEuYeRdvpGvs69H16msrYl5gU4W0maAE2s12rzrf+nLsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zh9lYQim; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zh9lYQim"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Jk+Ji88NKRy3bBjCiIFO7NHOyrkla3JOaTTOhexnXE=;
	b=Zh9lYQimv4wLuYe9tKNmjHMLspzdaZtTE8rr+sC+1vzWuVvCmeEWAUGaY6QgO3nqLYQyfN
	lcwM/Hjhi0XIKl7SqTF7q1eJujXf1sF/Q1xBHfs13kyA7ZqR0uzpRDN6OLuhSm3Dz6yIWw
	O0zVuuCSXCDC0CzQT003sib/jrTJDjo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 09/14] resolve_btfids: Emit a decl tag for kfuncs with KF_FASTCALL
Date: Mon,  1 Jun 2026 15:18:00 -0700
Message-ID: <20260601221805.821394-10-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-1-ihor.solodrai@linux.dev>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Following bpf_kfunc, also emit the bpf_fastcall decl tag for kfuncs
marked with KF_FASTCALL, so resolve_btfids becomes the source of truth
for this annotation too.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 30a07ec4ebb6..f276200b1a68 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -161,6 +161,7 @@ struct object {
 	int max_addr_syms;
 };
 
+#define KF_FASTCALL (1 << 12)
 #define KF_IMPLICIT_ARGS (1 << 16)
 #define KF_IMPL_SUFFIX "_impl"
 
@@ -1309,6 +1310,12 @@ static int btf2btf(struct object *obj)
 		if (err)
 			goto out;
 
+		if (kfunc->flags & KF_FASTCALL) {
+			err = ensure_decl_tag(&ctx, "bpf_fastcall", kfunc->btf_id, -1);
+			if (err)
+				goto out;
+		}
+
 		if (kfunc->flags & KF_IMPLICIT_ARGS) {
 			err = process_kfunc_with_implicit_args(&ctx, kfunc);
 			if (err)
-- 
2.54.0

