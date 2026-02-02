Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AC296BBC;
	Mon,  2 Feb 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019142; cv=none; b=BNqUCNjh1qDVC92udtfEoN7n3Z5ISVgxk01wlGLfZh68u80cJkgeq0ypvRPvovs11CwnSZkMb0PPbkL2ADffY/RZtfkcvEOqtZ4JaM1lxzHdi4OrxLhD1sXnxlLSXoAjL+23HMq44uloKm8otLO6sQ7EKWhcjZervdFcyHDtA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019142; c=relaxed/simple;
	bh=s06TNK3cVeFUZA/ywu3mGZMMd3DZ2hNGJmDGLVoIGfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iC18z25iW76FEZsEL5DYL/g7bzwmnmtHcqr09lzi91pF/65DUqQsN++5rEM6X5JFQJ3jzJboqZOmSnUBs4jFXkWJl+S17HQTuPg5j9GRRRZNKQZqf8ayPH6+vsVClB7ImARmmHceYuywwnsadQSNaLvsCXco1914XMGBO5k3YBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pChLpB9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pChLpB9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC02DC116D0;
	Mon,  2 Feb 2026 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770019141;
	bh=s06TNK3cVeFUZA/ywu3mGZMMd3DZ2hNGJmDGLVoIGfU=;
	h=From:To:Cc:Subject:Date:From;
	b=pChLpB9i8R1qqp+YeU5puUemAnYkpZZDHw5ygrrI5r/DhEeM5O8UIS8PWoG6SlBwe
	 Di5TrkWUKRmqr2sEHjELzJ9k8Fl+jVvovx3T/lRlKgZW+pguhZI8obO0ctjYA3FixF
	 il8f26+u0sTVpaSulQAsYIxWUFEffApMKbZ5rDsJ3GI3qGa1R57e/+yZOtRoLNSxBF
	 LAKZyOi6x57dd94fr9hhrQpmiBWWchyTNCFCGRxzSk/L1KIGMUVfZbUHzXzkvHonT2
	 kSfBDLOfaE8x+Rnog0fn0MUDWg/woliOc2LWxfxfI1BomE85uNPb3kmZqIZBOjjkui
	 4YLibecFBKVtg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] ftrace: Fix direct_functions leak in update_ftrace_direct_del
Date: Mon,  2 Feb 2026 08:58:49 +0100
Message-ID: <20260202075849.1684369-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexei reported memory leak in update_ftrace_direct_del.
We miss cleanup of the replaced direct_functions in the
success path in update_ftrace_direct_del, adding that.

Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/bpf/aX_BxG5EJTJdCMT9@krava/T/#m7c13f5a95f862ed7ab78e905fbb678d635306a0c
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8574932e66b6..b12dbd93ae1c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6537,6 +6537,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		/* free the new_direct_functions */
 		old_direct_functions = new_direct_functions;
 	} else {
+		old_direct_functions = direct_functions;
 		rcu_assign_pointer(direct_functions, new_direct_functions);
 	}
 
-- 
2.52.0

