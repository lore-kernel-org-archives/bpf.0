Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3E335BBB
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663787; cv=none; b=eRESuCjSR9NL2zVk+X/AO0Ep05jeqSX1dNtZI50E0pQ8wjUhwJn9l1lU23yFH8AA1HBFr7K4vyKXWx7eJRYwgLEUKF3tptGLSe+XfP3cxZzfhuksWlVi9VBSNCC810h4sXlLLN5NIN2M0NkQMzEtJrTQGMQZD01gr18j81X5oVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663787; c=relaxed/simple;
	bh=9FknhN0JMaZnjNXqGLSgkJwcXke2Td7BPRR311XykbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4ZRghN+lhGahugwtwrbfarQmyUT6rxsVb9OP4dOwtd8vEq2ijNP5rXTE3ZDmcpbREzoMEE873I6d1XhvZo1kZbCVm6kx/5Ginl2mB1myggxyq92Y3npr0RzNGbrYhY4a3Jgf1JzDmIeJWchF/ZkQ3Vr45CZQPXYZ9JsF6L+Ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1aWMze3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1aWMze3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE151F00A3A;
	Thu, 13 Aug 2026 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663785;
	bh=3He9FrizLsFFuiV//whqdklvAJYQ1cxbLk0JQVHTNks=;
	h=From:To:Cc:Subject:Date;
	b=X1aWMze3KFmE8RwyWZlZTFaTdXBFt0zeiX6KeeQPETVIuMP7rTgvnmz3VBvGZOw0S
	 q2fWtlY3ul8j/U8bH3i1UH9U47XAhosSFd54+DrW62vaWU3Rh6wy711ZHMDDHhnQ8g
	 5uANcZYaAP6Y0dJsezqpNMfrDHA+EoPq7UHP2hkY4URl0/LqpGq2/HJ2UYk5ATXREB
	 kshYDQ3uqFDSwvL/WJst8ttqFvNVaf4/Sww4q0pTMKFarYH3Vz8aH+n/wrnU4v7AqV
	 WjM5UvWn10PvpCz2rZWW9Qa/0HeKs+SMIM+q2vYYgoSXJlB5ClSTu/k/PHHf6wz08g
	 zeZn4iZH4lMWA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftest/bpf: make pyperf600 a success again
Date: Thu, 13 Aug 2026 16:29:43 -0700
Message-ID: <20260813232943.581283-1-andrii@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pyperf600 has been running into 8K BPF_COMPLEXITY_LIMIT_JMP_SEQ limitations
for a long while now, after some internal compiler changes.

Until BPF verifier is bestowed with scalar evolution logic, make that test
actually work by doing what would anyone should do in such situations: by
moving repeatable per-iteration work into independently verified global
functions.

`void *` argument is a problem for global funcs, but a static function wrapper
doing necessary casts and a bit of __arg_nonnull magic dust is all it takes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/pyperf.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 86484f07e1d1..fd93a96e5901 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -85,9 +85,11 @@ static void *get_thread_state(void *tls_base, PidData *pidData)
 	return thread_state;
 }
 
-static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
-					   FrameData *frame, Symbol *symbol)
+__weak bool __get_frame_data(long frame_ptr_, PidData *pidData __arg_nonnull,
+			     FrameData *frame __arg_nonnull, Symbol *symbol __arg_nonnull)
 {
+	void *frame_ptr = (void *)frame_ptr_;
+
 	// read data from PyFrameObject
 	bpf_probe_read_user(&frame->f_back,
 			    sizeof(frame->f_back),
@@ -119,6 +121,12 @@ static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
 	return true;
 }
 
+static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
+					   FrameData *frame, Symbol *symbol)
+{
+	return __get_frame_data((long)frame_ptr, pidData, frame, symbol);
+}
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 1);
-- 
2.53.0-Meta

