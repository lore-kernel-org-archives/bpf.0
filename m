Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F73812EF
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788733630; cv=none; b=igaUG1EjmPi9xujD643/2fb60XUHRN+SsieUDj3Q7JGwyVozBlksvTTcW8N8PuYVPL2d/E7Y3f++u+3AiwDH0Ddj3LZBYS2BFqxi/7QZUDRUp7ECTQqths6VSxUQnHRnQLBbUY+7O8nddPTnrZv+LGISFczniOujjJE9L0/CCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788733630; c=relaxed/simple;
	bh=h3MY+etQFRyDC5vTUte9Ey6CUC24f9Tomj2v46v8wQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDcx6Ls8uI7JhYBii7sBkRraA1p64QC8o9720HIRa9+9TBUK7dw5NaW75LRW1lu1Ze2zPoG1umsR5Pw1uf2godRlVrCW793Y8yHJ5l7oNIh7OGBnaa/tplMkeGFVOLMvaoldDZKxVauCerwGtB3U8USUJhUAUJPtq92Ux6NA72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXhJIbN2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXhJIbN2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482e067e908so2400846f8f.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788733627; x=1789338427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zX+QAFEbpQP+MEQRst9ypdyQVxu18GwQkXl0+/O/eYs=;
        b=GXhJIbN2ot7mXoqA/x1uEVefFrm/YfBLP9mffbiVXwqAriZ9K9zLbxlJtt5U1dOi/D
         1NihEwNR0JauAkHnm1oG18YHu5UPKk/YZlKUkyrdfu1Jh1+dTVMAg5qjkAaS79s0BF/a
         /CJVdy4floyEOvwOOYZmTyBgB7FrgYMozOKPFJOfgvPFAuNsHQzl9OI/KYK7yEaiZ0ps
         mAowL7A2xx+yzg/PA86VXCXZgoXVQdADtsX/3LEWciS1kB3sgGqkvk1fpptNvw6zFGLj
         +0PZJbaj3SPOg6+apQqqbBadq04AAOUZ69HDg0nT9Y42BDjyqJ5OPEQSq4AW5zgGsd0Q
         8a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788733627; x=1789338427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zX+QAFEbpQP+MEQRst9ypdyQVxu18GwQkXl0+/O/eYs=;
        b=NIRrE239milbf5+XSaQKmdZf+/oZZHViFP5TD2jUIxAdffHZ9E7MBcjRP04ElH6Ig9
         loZE/Odrkh4xqpQ836VSjZy0GAjcH3MJp5kinGOWpGR42nI+Ph6Cr+dqSiKzLsIMllzD
         fW7rbiYCW9OpcdXlgEzQMkigM5fKJjm6wZckcacYO5PPAYb+e1/dUK1aJ9lIHjIsKZ2k
         n14Y1o2KQ4NQeeoU9EzBy/z0RTLIZohlgpudQ1/K4bUDBGLtd0CPy4xyoVF0MzrpeL53
         Hg5HspLoWaMPfUCWhkiEPPgXoVkgTf4iDahQPOwJ0bljJLL3fZAvIksMTIf+TGvdguIN
         7oQw==
X-Forwarded-Encrypted: i=1; AKwUvBy+126Mzw3tJdh+jM2dpK0Ik2L5xI74mMNKkF7UrN8gcm9L9md6MkP4XFVE/2CKgyXsmlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k00ny9Y+bT+UB99q3XGQDoQb2Wn+JdJSJHS6jN5qqse/87LjGz
	mN7bwh6Zo9/q7tLuCbVM1RV/aBgkdwTVNqNtYkaxzk2nidyDws7XyS2D
X-Gm-Gg: AYBFou1gl8wgnGe/kTCB9Brp8gu5nVqEIycP370MMRgBKD44g62mdzEmtuyEQ55Kvnw
	KW6E08/8eE/kP1MuLYmedfgmLPziHHLt7EooSBD3/kkSLIcThVzpelYxJSiRn6AD7u68zmwmYpf
	++UjLgWWt5JndHEK22bcovtxmQDhGm6L1qvfAtHZ+K8BKqDmTVj2KlAoRgMFQY2GC/+sUsaDCA0
	E10vVV+KJFmQBoR0picqz/zDsVhNgRKN3u6ZikleqDqjDGNGhNVYmLWfgykKHbE2XXyVI+Fr6XO
	zFAVQLJx6DdaiTf7iB4ftXuDWsXch+qWMUDnownSmz3E/S1ZyXP9xye5mvOm+EnjGBlbyTApc8R
	K2g1zFr7TB/06+oL230fxzbZ/OkGiYnQsgfjauxQRUxh7DnnnTRBclH3SLk0UsWQSUW9INEDUTP
	pveIVPDvYA82dGh4GOrzOHnnv4YAqbnWelGWHf5VOUWFJdxiHbG/WKpaBVjooInGE2MRwzy8PA1
	2eGPIMM17DeoP3l9vsFFkEL4ibpU9ccwXRwtNgqn3OUEc/6DKBmCEPOoUg1/54tsIvTf+X2k6YM
	NXIkd+MRPWbiaBZatN/I4zUnlUx+6CIoYJBA7JMEC8HtdYzuZqZ3S5KjLxA8prxAnpddxzqHv8G
	KZ3AOrk4=
X-Received: by 2002:a05:6000:1785:b0:485:91ac:434f with SMTP id ffacd0b85a97d-48591ac44a5mr10269844f8f.16.1788733626624;
        Sun, 06 Sep 2026 15:27:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm22396316f8f.36.2026.09.06.15.27.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 15:27:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2] bpf, docs: Fix two struct names in btf.rst and kfuncs.rst
Date: Mon,  7 Sep 2026 00:26:56 +0200
Message-Id: <20260906222656.3459-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct btf_variable and struct bpf_cpmuask do not exist; the names are
struct btf_var and struct bpf_cpumask.

Use them.

Fixes: f063c889c945 ("bpf: add specification for BTF Var and DataSec kinds")
Fixes: 027bdec89364 ("bpf/docs: Document the nocast aliasing behavior of ___init")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: the two one-line fixes combined into one patch, as Alexei asked;
    the two Fixes: tags stay because the typos have different origins
    Randy's Reviewed-by, given on both v1 postings, collected
v1: https://lore.kernel.org/r/20260905095649.42351-1-kmehltretter@gmail.com/
    https://lore.kernel.org/r/20260905095527.42261-1-kmehltretter@gmail.com/

 Documentation/bpf/btf.rst    | 2 +-
 Documentation/bpf/kfuncs.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 3f05f17990ad..004aa1058d85 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -416,7 +416,7 @@ If the function has variable arguments, the last parameter is encoded with
   * ``info.vlen``: 0
   * ``type``: the type of the variable
 
-``btf_type`` is followed by a single ``struct btf_variable`` with the
+``btf_type`` is followed by a single ``struct btf_var`` with the
 following data::
 
     struct btf_var {
diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 85f73e0bbd0f..57831eda0a33 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -536,7 +536,7 @@ For example, for the following type definition:
 
 The verifier would allow a ``struct bpf_cpumask *`` to be passed to a kfunc
 taking a ``cpumask_t *`` (which is a typedef of ``struct cpumask *``). For
-instance, both ``struct cpumask *`` and ``struct bpf_cpmuask *`` can be passed
+instance, both ``struct cpumask *`` and ``struct bpf_cpumask *`` can be passed
 to bpf_cpumask_test_cpu().
 
 In some cases, this type-aliasing behavior is not desired. ``struct

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

