Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBBF2EDD78
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004538; cv=none; b=ICl5uZd/lT/dcHAm8yATieik51jy9wMjwTjyqKXPGOYngTg9/k747vwHIp0AmBFMV3xCbcpuu7+hEGr0mLj+yC1DfOdq0qNyqhueXGfjkKZ/d66tCOJqa/TGsBsvlteEaGT3etfE8HX0IjeXqR3wqtYDaDjzgj0/jtnJftCLG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004538; c=relaxed/simple;
	bh=ps2EZAI5YrDKjx9lnvzkHJ19L3NjEOMyGa12/vfnXrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIaxDmiDZ/QNhCjXv1xa57igdZdCc5QXF087tj4vGVE3nQymlj65Z76yk9BF3E3HJcRT36Sa28VGrUKuxk4lAVVeJhlbawZnNYDtvAl+Dci8LIreiK+1sOADiKD5DIsX1kNweLL7NeKFdiMar7MjtbiyiMXBol7fCwFSC0lXuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAe8C6mP; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAe8C6mP"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso14764985e9.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779004534; x=1779609334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMsQn6B7jmQ0Yihtlprt30BUdYKDLYuh3p7PW+adwtk=;
        b=bAe8C6mPZSHAn7PLdKk0du1tqd7r3INmNQyvhR5QIlDbCvSqqEu/s1kGYnkdF6gaRI
         k5ytBdpl7ZEkp1AJ9N3KvzJk9+w08s2xdSntVLCOYdV7iAxuKD+f7Bh5ZnEtk55AhbUl
         LzFhVynr+CuYbgF29oabV7QhX8uYdcoqeGIPb0H6oHr85f7SCXBL2aIpxebLxj0sF9yF
         AQHoN6I1sG5920DpQzxM8GqzJkczppbwkw+TdYd+7JojkIGTS8R0OjQxXhXYX00MCszx
         E/jsJrzaid0eOeZnOshR7vs65iVKTyL8sWCZAToAUYJ8RiH0QvEipeI4NPxlHmQyrmL2
         C78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779004534; x=1779609334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMsQn6B7jmQ0Yihtlprt30BUdYKDLYuh3p7PW+adwtk=;
        b=D6LFkFx0FF+kLKJ+oNdhifB/VG4C1BU4G9Xxy0F4Mz0WwRLRkg6q74V8qdYfzQjBSU
         WHpJlvjPbflbObgAjFqfQVxxuAseEuoITpjQ+hsX1Oj35QILAML6P+dqpmxclgEw7PA7
         ImKKh646QJ8LFgD4+UXjbpD7n2jDpDd485tj4Ofa9T0u+XmkZebOxeFEzk84EnR6avNU
         r/bt7PryQd87i30iI77nbFXOmM+ZgqOoptR+DijoHuBsvteU+B7UrlX67nPxPEw+Uvy4
         caeoXe51w1pfaZlpW5V5kQBr1QRVmEWWUF84rj3ZFHrMny3ZZK5P4jqriO+I5bHvkCKd
         s1Rg==
X-Gm-Message-State: AOJu0Yy68RzkJqNaIdBVs8mbS93Rjz+v0W1jyJgy5eAC/l/xB6FYWWR4
	VMqS6aFy/RlN6gLQoGD22ufBjuKDr1of1zDkdlKnyqHnDzwXZwjatORmMWGpmoAx
X-Gm-Gg: Acq92OF1vwVAJ/PO1AW+IZnqMKmTc6ALdmgwj8XTQLbihQA1HRuAGxAD4qWdv3wvC/N
	5IsCCX6zrfB+6r8wdZbkkA343cEng4rt/137jstELuEppnRWcdkXXQA5v/5HHtBsyenTUBHgFvV
	Wm34ESkSSN4QHnSsfDYeStiyfRzjipvBFGlAv4JFiEp2dpNTj+2PEk1GBWJocivwPGfiXsSPWZU
	K+YEevQrlab2VZqkSSTbFXD8t+yEaGRvW0SDDn9oV5DtOCdYQGuy8BXbTUMVEJQnqqjoD0a3Tox
	SAPDB7l5wNws1o7ExIVuJZu+uakVIvy3hjFum71wIsNJUdZnNKhKG2VZjwqofishNSC+mpkDgm6
	1czHDXmdOdxoDRjpe0MO2ngQX0ElI78Rzs0nPqg3f7Mm2MF12ogcMLLE9CsTx96u9kxzKco4h08
	KhsNlNqIHeqwrWDOjtasvD/CcosfY0e8WvfD1b+8pN9f1nwFgdubtiOzCKgOnFwWMjb7MVaosCZ
	eCyvFNWCjXzh07fOY1OTGo31UxaswcKEKYvDjTAwcfSZ4WfVYSf7DtivHmTJm9YmTfSkvvX7H9Z
X-Received: by 2002:a05:600c:1f87:b0:48f:fe2a:1099 with SMTP id 5b1f17b1804b1-48ffe2a1244mr49678805e9.5.1779004533566;
        Sun, 17 May 2026 00:55:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm9826225f8f.27.2026.05.17.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:55:33 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover global subprog exception leaks
Date: Sun, 17 May 2026 09:55:29 +0200
Message-ID: <20260517075530.3461166-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517075530.3461166-1-memxor@gmail.com>
References: <20260517075530.3461166-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=memxor@gmail.com; h=from:subject; bh=ps2EZAI5YrDKjx9lnvzkHJ19L3NjEOMyGa12/vfnXrA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIYuzxGNlaubzmJs71s25oCcSx16+PGH7At4PE5q7Zz0pu hy1+NHWjhIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExEdzHD/4CTE1wtPr2a0MFR 5/X66o6wOfW7RXewdq5YzuR3cut+9x8M3yuWHlyVfvzTyYnZZxMnFWoprSstcfd1DdnM68X7IIC JGQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier failure case where the caller holds a reference across a
global subprog call that may throw. The program must be rejected because
the exceptional path would skip the caller's reference release.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/exceptions_fail.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 051e2b6f2694..ac44d60e5066 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -208,6 +208,28 @@ int reject_with_reference(void *ctx)
 	return 0;
 }
 
+__noinline int global_subprog_may_throw(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_global_subprog_throw_with_reference(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	if (ctx->protocol)
+		global_subprog_may_throw(ctx);
+	bpf_obj_drop(f);
+	return 0;
+}
+
 __noinline static int subprog_ref(struct __sk_buff *ctx)
 {
 	struct foo *f;
-- 
2.53.0

