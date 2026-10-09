Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB4331EAE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510556; cv=none; b=fQJPqzm8c7pwHLMWPyQZj2gBr+w91GFGpWuk+052uTTHkv7W6aD+CWfSSS6VHmIb0Om/e7KzocVhex5hHyNw5fWTuObI8o8NaDw+s57ncm3/hkitlv6gyQNK9V+ixH2HVMeSMlJVYmUPGKg0DF57zQd4u0cBXKNbraRLjFrF2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510556; c=relaxed/simple;
	bh=032pgBxE+bEmElrm5bfactnEl1Y/Z8BUO05rrlaNSI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FB/O3egisy0/6bddy5GGo/lKQaF4xm4KvPYtowI/cECJgpEzszN2xiwWy72HgEkY0eBuYIfNVMdNoQevqbR7K4mhXlvpOZHDuNGbrTO5JbLNy728dahH3iQ79g9d5DetMDSpbZNhS43wWMlh/i1sCVbIY24jTG6MZ1mmbBCVSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF9dt3fK; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF9dt3fK"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so2626950eec.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510554; x=1792115354; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o0KR8QjY9hwJdZY7Zw1o1kndljF5sDSUksolfeeiLpc=;
        b=CF9dt3fKE8cYLJVZlEYlDq0RjD9SZWpTFC1M/soaFuiZ/UiOF9DodXc5zCgh5ijvL/
         mmmMb5BO6G3Y3q+GqTMUp2FLSX6UpoeB/rqveyulhYD1aVHw9PEnYu2Akg4B7jAZiO8h
         renyIKJ6lTprwHd6iUtwMnJqLxlTaj/gdW2LpbmNv64CtVpfazPjU/r4ycJEMZtbjp0A
         inR/18gyCUayCGQcY/c+JBCVRcQriYbMlQXB9B+b4XXsx+gZt8msL+o8snbKz89K/r/F
         BxSwwmSC7g/k8yu/nfvf+TNgo/Iux/htaxRxcOiLXKyH8iVkKdJkw1m950ucgo6MfW4T
         JNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510554; x=1792115354;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o0KR8QjY9hwJdZY7Zw1o1kndljF5sDSUksolfeeiLpc=;
        b=IUF1n6g9hFi6xpYH+zlV74fOAqNIdkT/lqx1ea7i1WAtrqw5Zf8s2ra5u6Ni4Vv5nZ
         bLg5VahyiqXYh73lU1h1jPSOc6DK51Ts5GbRRlC6Vhhz6SxEuEizWl5cV+GvvbAaZsls
         ca6w0QodbRIxM248oZh2uZ+vEN7+ZSI5xK6MoYfe0JC5/0xS7XMrHAhFsLUETifKoFEc
         Ejc8nptxIy2S6Oc7m1bzYXZHXRXLl6XtvVYzE8aQEjuo+CoR8MZn9sRAOzMUtnl9F7il
         iNHQ5pR56UiHaTMBUJdge5ZcgKJEmG2UyPPMg2suIZ1D90MkgjgiF9cM6fbazkKXovIz
         s6/A==
X-Gm-Message-State: AFq9FYLYSMbzA58NV6ZCpdNjQmJdqz9A7d+nUxAyd293MQ4jPA4wS4ZT
	lYDCp39wRep4xgs3ikQQltsX0rEN8G3Fxx8yP9ZPxFJen3kUtAwtPmDk
X-Gm-Gg: AYBFou0kmn2BfdNdBwUBJRatD/YxncsX+Fzaj5DF1AEKbIbRYcolyEcFI7CQFBM1g7+
	CdbktCV3MIjJpkIUu9+eZ1lVqvEQSuNik4mW3i3SrQ4JNfbA3hBm3PzUQGrKAq/QdwPZ5H3f/TA
	BB4ij4D5huE+pCCG1B1Qlszef56eiFzArVNnLCznUCYWX7orJArdk7pqQguEsAC/LFIeT/bC0RJ
	R3vpevCY/D7QuKdExiSR7An3hp/GxIsv27Zbh96Hafk5TUPKpi+5S0C9fUdXKrU8CtqATdAYU2D
	QBhIp7GFgXTSPs6WxqvSEyhsxE6fxAPHWrchSWlvCsT8FP0eKKjXyfRiqqnhdBiLl7772hEX1Bx
	MYXM6witRd0caB0mr71kkSwkDfr68GP0jq7hzSgMB5ydIUK/j4okAk0GJVFyytaCjG9wEiHFEsK
	/2Q2r8WSAbzfQVuwVN3ff1dxP479PS3QL/AblY1/secmD5EOiTUdzH/9/zhat6/sMSfw==
X-Received: by 2002:a05:7301:c016:b0:351:1cc6:995e with SMTP id 5a478bee46e88-3537dde3aeemr868263eec.5.1791510554037;
        Thu, 08 Oct 2026 18:49:14 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm1763323eec.29.2026.10.08.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:49:12 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:49:08 +0800
Subject: [PATCH bpf-next] selftests/bpf: Drop the on_enter recursion check
 of task_local_storage
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-task-ls-recursion-v1-1-c3a3e3c41f8c@gmail.com>
X-B4-Tracking: v=1; b=H4sIABNIyGoC/x2NwQ6CMBAFf4Xs2U0Kscb6K8ZDgVfdSCrZLYaE8
 O8Wj3OYmY0MKjC6NRspvmLyyRXaU0PDK+YnWMbK1Lnu0joX2DClAivG/Zy4RHvzZKwYFj1c9vH
 qez+eQ0CiWpkVSdb/4U6HkrEWeuz7D6SrQNV7AAAA
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

test_recursion attaches on_enter to sys_enter and on_update to
bpf_local_storage_update, makes one syscall, and checks the task
storage values left behind and the recursion misses of both programs.

on_enter runs for every syscall of the system and returns early for
other tasks. On a preemptible kernel, a task can be preempted while it
runs on_enter, and a task entering a syscall on the same CPU then misses
the program. With other tests running in parallel, on_enter ends up
with recursion misses that have nothing to do with the test task, and
the check expecting none fails.

Drop the check. map_a holding 200, which only on_enter of the test task
writes, already shows that on_enter ran for it.

Fixes: 387b532138ee ("selftests/bpf: Tracing prog can still do lookup under busy lock")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/task_local_storage.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 5b2b56cc3a4f3..c03ea94325d9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -138,12 +138,6 @@ static void test_recursion(void)
 	ASSERT_OK(err, "get prog info");
 	ASSERT_EQ(info.recursion_misses, 2, "on_update prog recursion");
 
-	prog_fd = bpf_program__fd(skel->progs.on_enter);
-	memset(&info, 0, sizeof(info));
-	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
-	ASSERT_OK(err, "get prog info");
-	ASSERT_EQ(info.recursion_misses, 0, "on_enter prog recursion");
-
 out:
 	close(task_fd);
 	task_ls_recursion__destroy(skel);

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-task-ls-recursion-5a85b5d499ef

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

