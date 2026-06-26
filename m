Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608C3F9A1A
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494467; cv=none; b=tvcLesK0QCNiZAO1yRjT2M/qvbyTWH9hxo76/cAHA10LL5ed743DD2fX+h2jKogDLTjvK6ar7DYbMSW7pElx5CznW3m30gpwn1vNb9ORxTpEfRagjGaQHaVOIVIyod5k/lGhBIvX921n3a8L3jrxh8QFsonilV73p5aFUckXA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494467; c=relaxed/simple;
	bh=q2Cv0Xql/qftpCYgDKhvRODhJjVn1gDLrqwNHRKsOuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oltVwsw2U0WyQAI0Mmp/R/mAmMAhl3C1diHvFVuK8dyO8IEV+YI5eAliw8aCIZC1ycL9cqMB2+c5/E7GdkTuNYx6N7kQ6vgIqeq8PPTGcLW8x6MSUR95TSgXvFlJoSgmndtfOzNaG3T/aAUmAATaWEP7zw5ivIzbW8uDAnJOzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vm5itcG9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vm5itcG9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782494452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Xg7cKreO3eTZGOl7kCsYPcqSDyRb1+Ql6WyJKlGBcw=;
	b=Vm5itcG9mBWJYoa2spr2swaJPOZ8/2SXaAIqAuwy3E2sRd9O4HcKLPg6VT2AH4X3cgillI
	D3jhKOiX9XltBytbRktXQnzjVPSVQ81bR81z/IqK8RS2Zx4+ZJaiH+Ug8gM6aD7ymWiUDM
	Y1jk2XC/2sYvomvVLkyrFEKZvc3CZ/4=
From: JP Kobryn <jp.kobryn@linux.dev>
To: ast@kernel.org,
	roman.gushchin@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/bpf: make it clear that kfuncs should be non-static
Date: Fri, 26 Jun 2026 10:20:26 -0700
Message-ID: <20260626172026.7327-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kfunc documentation mentions how the macro __bpf_kfunc prevents
inlining for static functions. This makes it sound like static kfuncs are
acceptable. Although static kfuncs may happen to work, it is by chance that
the compiler chose not to rename these functions and BTF resolution still
succeeds.

Make it clear in the documentation why kfuncs should not be declared
static. First, remove wording that makes it sound like static is ok. Then
point out the external naming needed for BTF resolution. Finally point out
that sparse may warn on unreferenced kfuncs and that this warning can be
ignored.

Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 4c814ff6061e..1dbaff8d4805 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -276,19 +276,26 @@ This set encodes the BTF ID of each kfunc listed above, and encodes the flags
 along with it. Ofcourse, it is also allowed to specify no flags.
 
 kfunc definitions should also always be annotated with the ``__bpf_kfunc``
-macro. This prevents issues such as the compiler inlining the kfunc if it's a
-static kernel function, or the function being elided in an LTO build as it's
-not used in the rest of the kernel. Developers should not manually add
-annotations to their kfunc to prevent these issues. If an annotation is
-required to prevent such an issue with your kfunc, it is a bug and should be
-added to the definition of the macro so that other kfuncs are similarly
-protected. An example is given below::
+macro. This prevents issues such as the compiler inlining the kfunc, or the
+function being elided in an LTO build as it's not used in the rest of the
+kernel. Developers should not manually add annotations to their kfunc to prevent
+these issues. If an annotation is required to prevent such an issue with your
+kfunc, it is a bug and should be added to the definition of the macro so that
+other kfuncs are similarly protected. An example is given below::
 
         __bpf_kfunc struct task_struct *bpf_get_task_pid(s32 pid)
         {
         ...
         }
 
+Note that kfuncs must not be declared ``static``. A kfunc can be called from a
+BPF program ``*.c`` file outside the compilation unit that defines it, so its
+externally visible name must remain available for BTF ID lookup. ``static``
+linkage allows the compiler to rename the function, which can break this
+BTF-based kfunc resolution. Further note that sparse may warn that an otherwise
+unreferenced kfunc should be static. Such warnings should be ignored for kfunc
+definitions.
+
 2.5.1 KF_ACQUIRE flag
 ---------------------
 
-- 
2.54.0

