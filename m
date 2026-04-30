Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB440B6EE
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553610; cv=none; b=ezLaP6tYi/9UERyV6nZo7P7GDNOXibkzCnFmP93FHimC4rvuj56ZSQY+GKzNrNCGdSC9YHYVSZi5fdyhZxVuVPlMcZkLT5DbGIZBPr5qE9dIxzoiz1PtEV80VoH7eBUpyaS3/OPX4qX0A+0RDOwq4F+B82NKVEHuZX6OGGihZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553610; c=relaxed/simple;
	bh=/jGlD16wwf+LKViAk9+60yGEYsvt20pYf1s5W49VBcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oH10MH/jOynHsw+/S9fzjSXt+R1CY4t+jsPOK6IPA6CwSjwmkQZto6O6f+NmyWnG4etZaSbGA4Gx5LikfKmRfnwt+a5hIvDHBbjTy3NMgu0tdPi1FHQd0npJoKFF8gLTwd5uvqnc4MdUnFCFzf+3JSqbJ24X84bSjP03LGgNJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BX/s3/eq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BX/s3/eq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so8804325e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777553607; x=1778158407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+aXTQmh1BdIEplotgCd37rKzWea3sfpPCHgEBxHTL4=;
        b=BX/s3/eqocHaqWKJXOL3SUlNJhDlHybH4H9pVEm/u0D236n2GOm393cjnX59C/n3RA
         /eTEvaR3oxA1PPU0ToBEiui/XsKbcQ+uGCIIS8zf2IzkGkcvMBNCJ17aZTvY2YS557X2
         L8lUu/ZZYwm6J6GYD8TU8r2E087WTXD/6qRgOIk0wr7Urf1YQRiRqzyltDzTCZ/fEa91
         T2jwbjh4ofISZFN6BRF0GMacimBRH7Yw6zFI9l3IxKM9XUKrEZ+70IVnNggmvxSA846e
         iDG3378SyDY+djASI6ewl46kLpDIexGfKHF798yi9I/WT4OQG6J91uWwLRNRTQ/94O/B
         Oh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553607; x=1778158407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+aXTQmh1BdIEplotgCd37rKzWea3sfpPCHgEBxHTL4=;
        b=Zf06+fxZgGyz1y5+0o6DmgEJQiUpufMXv2Mcfr7OaLYss5PUFpZXqK4wFRYeSDOra8
         ik8PHKqKDceYIN+tahe5V6bLAbfhLJVvpaOX/DqeaiIqfXHNvnjhogG9n53H9YTXR4vQ
         bT5MUYTavAMJLJ3x1XvlqRK/zHouRmH333++WWGlYgE1DI+AtyphzfLOEzXPpm015nPy
         hKvm1w4P61dO0zSc1WNYgH7T07JbnlJrwQhFA3TMjznWfaD27xRZ3haOO22JQbKKaqOc
         l2nAojpCeedIVCxr/EIBCiFEwm4hQ7PKxZkwdifLOqk9nuU1XBnNC+jG77lnRQ3FyK1K
         T1vg==
X-Gm-Message-State: AOJu0YzHJ7hw45Prib8B1aZpYi5Dx8YN322qDQYwKB6v1sgabU6fjucv
	9L/bOTXZ4OrvYUKXayoPdsxsv9GbK1xFTCsBgN8RclGnGbMwxC9K3DGk8aoINuTK+UU=
X-Gm-Gg: AeBDievD536sGSTcxseQ0JZu/NkfEb5/GlLGN5od8zgRmr0Sfqu4x1UP1kkIyoAj8WK
	Q7JCGDjR/0oGGG9Dc17jqPYjJFUz6VoMf/XdwB3nJKYFduepG7g7tG5IbOglLWd5Yu0tSY6gQI9
	H9sLb/T83RpEH/HysDB6sFgFvQhVeRGoPvPHc+Uf710byCzcKmQmWqZcnZuIJP8Q/XPGfmpAMqU
	V0Asuklbe08HeOnWEtcgCycD2t/MFvC8x7PBMAU0+vGTNiOTGCOPk1yjCkKaEq/Mgokr/G2QSdh
	SDLu1SVpWm/O9ljbbCMqdIaIqfxHZTG7d37762ZhVaQlwck7tYVPlXd7RTUuC1sV5Y2SAgaNJKb
	Xy5Y+EALyJ67hoIcDYywjcoKHtEipc3Jm91dAzCPIbjK2oCNkWn3WiniiGxvNmDE4hC83mSinVd
	KQp250TvAfcCYsAF6I5OYoX+T8
X-Received: by 2002:a05:600d:8451:b0:489:1c09:6c4b with SMTP id 5b1f17b1804b1-48a83f6e2camr36515955e9.6.1777553606714;
        Thu, 30 Apr 2026 05:53:26 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0d218dsm6470287eec.27.2026.04.30.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:53:25 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 09:53:13 -0300
Subject: [PATCH bpf-next v10 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v10-1-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777553600; l=1573;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/jGlD16wwf+LKViAk9+60yGEYsvt20pYf1s5W49VBcc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH6rhM5l3D06tpi0qU8Si1/N1l9Wd2RxcyfC/tNWuUnFz9wkBshuox3jwVTAQY8IE4x05O95ehI
 qWHtqeAxplgs=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Distro kernels often lack BTF types or kernel features required by some BPF
selftests, causing the build to abort on the first failure and preventing
the remaining tests from running.

Add BPF_STRICT_BUILD (default 1) to control build failure tolerance. When
set to 0, the PERMISSIVE make variable is assigned a non-empty value that
subsequent Makefile rules use to make individual build steps non-fatal.
When set to 1 (the default), the build fails on any error, preserving the
existing behavior for CI and direct builds.

Users can opt in to permissive mode on the command line:

  make -C tools/testing/selftests \
       TARGETS=bpf SKIP_TARGETS= BPF_STRICT_BUILD=0

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 97ee61f2ade5..6094fe99b5f6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -44,6 +44,12 @@ SKIP_LLVM	?=
 SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
+# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
+# benchmark compilation failure is fatal. Set to 0 to tolerate failures
+# and continue building the remaining tests.
+BPF_STRICT_BUILD ?= 1
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))

-- 
2.54.0

