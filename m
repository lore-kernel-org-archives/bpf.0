Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F92868A9
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374698; cv=none; b=oM7lcBqHav5GOW/kBymZAYyskk25EXySMcw12M56YDCtU0kPO5dOszI7/95s3n7f1PjsqGEpvgGGsCHdFFBjqeDOl8VA7g3x0ZWQVMG8HhFSNiP7YejHkG0pKBd7sZ+Z8Zz8Bx2JbxdBjD9R/yvEaNwb+sNXY+nBU6qPyxr3Ev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374698; c=relaxed/simple;
	bh=4XWG+yKNbjLV5S8DLeBinhCC+i5vGRqMtejq5J8ewuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS5K1v1wMJgY8egNoG8IOByKB+sVFs3dWUzniGBNMwMJ0eom96/404M9hpreEuQopZZ4PVlFKIuaumXdK8DupJOXsQKgXofd3BBZ+MdImGCNUS0WZNyu5VQOh3oRMcmxpcMqPMUfHBHWjaEFvCmrfRZ46QcnSSsZGen9Z43ozwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqbdf8v0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqbdf8v0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uneamLJI7gKkUe6gRTHtLyTvtCQ+Fkon9lXZOT1KJIs=;
	b=jqbdf8v0JoB0cXTKe5QTfKAv+xfmRIUjjylcRgqLZTVm05Zjw4suFBtQ+HBxfR9sO7tAoG
	S+0EDV4zZkw6NCjHkSBhMWSKh8s9RS+iwfAi1NMjfuLL2Ec9pLxf2SD9xOuano59weAyot
	2a8d4DG6kOpKo5MfMh6KU8uF3EiynmM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 09/15] selftests/bpf: Fix double thread join in uprobe_multi_test
Date: Tue, 17 Feb 2026 16:30:35 -0800
Message-ID: <20260218003041.1156774-10-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASAN reported a "joining already joined thread" error. The
release_child() may be called multiple times for the same struct
child.

Fix with a memset(0) call at the end of release_child().

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2ee17ef1dae2..be6ff1d4a75b 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -68,6 +68,7 @@ static void release_child(struct child *child)
 	close(child->c2p[1]);
 	if (child->pid > 0)
 		waitpid(child->pid, &child_status, 0);
+	memset(child, 0, sizeof(*child));
 }
 
 static void kick_child(struct child *child)
-- 
2.53.0

