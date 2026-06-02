Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10183E275F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405420; cv=none; b=aPxByjuYKr/uDu8Fn98PUq4BxvxThOougMNE4ULoU1x/X2k0ALveqyfGxfVnQMVgghsJle5OwMzsDSsAMkST1ZGTry+2zvnuY/dhbcvPpOaYHJGCTbLdSh43e5SV5tkIZMPnaJiWSpns5fF2QVbvG2isBNLe9Tw5EiZ+3qK2KIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405420; c=relaxed/simple;
	bh=h9YPiCy3D78JKFK96WbgjB0Gv9K8gRrn758T4BLo7I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+DuuRZL9+U6/D0UEiFZeUkbOaSeYRoUN8LKa/dlq+kDzY5D0sUH0RAuhX9bk7y+dbvVJ1HiTH7uaySKn1aLOmWXCyG0wiKGerEph64qkbCKqyiAi7SfInZjAGPbZQXA03rYkXgBxk2YHN+R+J/udrVb9E9SubwmPgVX6Lh7xIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vlwgv8vB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vlwgv8vB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68b482888c3so7243515a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405417; x=1781010217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SleKcaJS2ZrPKi8iOetVvP9OF/8OPZ5a/bR4NWlSpno=;
        b=Vlwgv8vBbjEei+PBqDmKwaa0C3+imgNy/sQ2ebkEHtM2/t3+tXIwoW6uNh4o1DsY97
         ucTyMe7XuS/XankrDWCz2VLKTeaAziGx9fJyiI50raT2G2DnLGZ2i3zgl3FgzkJUrtu1
         1WdZvNOziIrvyGWuw2Xo9qdbwFh+Cbkl9co4vr8d/YucOyGU+bXqNaXHAz7XYkQeNhEp
         HI9NkWVho8OxXUKsqeQGtatG1VXrFOmoJE9+XETl8KKj8oi0+f+rUsXcuK8BGgluGbdw
         41Rwwh9sCMlBcwxiLN/UT4boVmJ3v1biCtw6DXE/DHfckUlUfwkzgfvGPippQKMdJ2nW
         gOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405417; x=1781010217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SleKcaJS2ZrPKi8iOetVvP9OF/8OPZ5a/bR4NWlSpno=;
        b=nO351yEWNxfzbSkd9Pk7MpdXfZDTGOFdghm5S8tzL8gxpxSpzkAPD34v9O2TrKAwOe
         oWR4ioBgGYelBx6iRntzg6da7/SWOhHKe+81A6RsX6cWDD6vH9dPzASWqkSKu9k3jftJ
         +bA5KPINR3UpkRdegiKZ8gPkOZQ0F2IY5vT4mAM/VVAfVqGfaOpYoxpha8wLk5X6Nl1x
         ObfVaCS1xgW/l/6cjwJxPwmfevA68CwWcmWoPpGILpi6tVM+uy7mqJL/TUAp/YF8Y3pC
         g6iJQ6wX84mJiacrhxQw5kwsKye+akRzO4mtqP3I4GvIU+3WRnoqwVNO9UCZLssEF9cA
         eOMg==
X-Gm-Message-State: AOJu0Yx8rwYK2CeJA6On7lgjo3sW42MLBZJx/r6aClm8V8DBtqZa7zLv
	v28Z7v/vAiDpAVpnhSj4b+Z6vu9OH6FiTq0NrsF4uRbKtyxXv78UDG7Tl0ZmWNznrhU=
X-Gm-Gg: Acq92OEWNT+A2MMyZ+Xtj4txkdUzhZBXzpZ/7g//dixnOkMqf5yrSegoj+CR3/U2wAU
	8AqWtPuLpA/zLEM00eQ7hRK8asU/mkUAfKFixJyNBYly2mculGwSka3+R6p5YO6VeFxZWmXuHIY
	RdKFJLd6iDbH+jExlwrYvboBDp3n0HJwnUroyvRWAxEIsl9vHc1+9FcS3C37QID+rc2oEKsN42j
	M7l5BCEzUobLBo8dYjZm3SDdw0x4k1RBJ41mAJCgsF52Evg5Ifznt2OSZU3+xbpxKfdfMQvcBr5
	GuSpjs0B1E1dVkweTKE2S5Au8RGEyZvT6F4TSNWgXXExLLsWjJcuHmaZnuGiSD0r9ZTkRJR44Qg
	AsJfAcAlJ2GLeljMBUZ/Wno7x7ZY/mwhzVJNUdFO4hVemz02QuMlg6MN/Hs3OVlucNQOrzJ3XZB
	KlezyQWMFwBO8LAei69ziB7Q==
X-Received: by 2002:a17:907:d11:b0:bee:7c9b:fbcb with SMTP id a640c23a62f3a-beef9fc49cemr247115566b.5.1780405417123;
        Tue, 02 Jun 2026 06:03:37 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb85359bsm3373260a12.22.2026.06.02.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:36 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:02:54 -0300
Subject: [PATCH bpf-next RESEND v12 05/11] selftests/bpf: Make skeleton
 headers order-only prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-5-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=2402;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=h9YPiCy3D78JKFK96WbgjB0Gv9K8gRrn758T4BLo7I4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKabAdhXGu9n7wxD04JnGNenevlMwzntkoujlqFOAcVLNfePEOFjOxkzc/tTq4K7yqGPiLQGs/N
 FWoW72knPDwY=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

The .test.d dependency files are generated by the C preprocessor and list
the headers each test file actually #includes. Skeleton headers appear in
those generated lists, so the .test.o -> .skel.h dependency is already
tracked by the .d file content.

Making skeletons order-only prerequisites of .test.d means that a missing
or skipped skeleton does not prevent .test.d generation, and regenerating a
skeleton does not force .test.d to be recreated. This avoids unnecessary
recompilation and, more importantly, avoids build errors when a skeleton
was intentionally skipped due to a BPF compilation failure.

$$(BPFOBJ) is intentionally kept as a normal prerequisite: a libbpf
rebuild legitimately invalidates .test.d, since libbpf header changes
can affect the headers .test.o sees. Only the skeleton headers are
moved to order-only.

Note that adding a new BPF skeleton via a modified existing local header
still works correctly: GNU make builds order-only prerequisites that do
not exist (the order-only qualifier only suppresses timestamp-driven
rebuilds, not existence-driven builds), so a brand-new .skel.h listed in
TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to date.
The modified local header invalidates .test.o through the previously
included .d content, forcing a recompile that regenerates .test.d with
the new .skel.h dependency captured by gcc -MMD.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 49f6a5503e84..09de69a81112 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
 			    $(TRUNNER_EXTRA_HDRS)			\
+			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
 			    $(TRUNNER_BPF_SKELS)			\
 			    $(TRUNNER_BPF_LSKELS)			\
 			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
-			    $(TRUNNER_BPF_SKELS_LINKED)			\
-			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+			    $(TRUNNER_BPF_SKELS_LINKED)
 
 ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))

-- 
2.54.0

