Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244F194A6C;
	Mon,  2 Mar 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439391; cv=none; b=Y09DKKasNk8p7nw8GJDziod5DT5DwcMWiMP73bqhTH9us+fTm3T5UKw6lAfeTIx/+M2KbmJaezVUGwBbR0R3kclzb90n2gB3swJCUnU0uWhQgmTxiCibMgQLoCv8RHlMAeGooWogf2dxOoRo/3dROEJSq5jLQXe9jgSKtFya9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439391; c=relaxed/simple;
	bh=G8xfkw0TVKiIlzgb/yyqd4y2C4Fh6LpWphZK7+M80tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yy7tp1OqoM04sIv3w9vyYQD+4UuNE1T+qwFUDkrfFascCj2COkObjt3hchbbuLJj/uvMm1XNoFqdoCpDIPJth1DpBeR+7KC/ip85N63ZSF+MoFwIaD7dYkR+c7JBBEgFnj7uBILK7gh2fXig8eJbeBlQ1/mN4zqZDBF/k6x6MEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5a5ncSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5a5ncSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2378C19423;
	Mon,  2 Mar 2026 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772439391;
	bh=G8xfkw0TVKiIlzgb/yyqd4y2C4Fh6LpWphZK7+M80tk=;
	h=From:To:Cc:Subject:Date:From;
	b=c5a5ncSIjJklYlJWGEBDPxV+rzLPMeWsRzuAw2HL6a0K30oGkLu4OxOZ5tpgsnu+k
	 DiiJEs7n/BxPT8oYUv9XCvCTSS85bbTqFeEW97POYJYclq5vX9nwrN6z9tNcslRv8m
	 1k6iuxKKb394AD8b3IrOSwSabFMVzeKwN2GVdUcJNmK7yLwQXTbH7lP35+X6laymp9
	 TRPR5yWxxAMJQ/MIgKsRwaszFm3D57lN+FhkBcKzoaX/O4kDNCBcSf8ygOCJ4jaqxR
	 sRqIhFwGZr2iUjxt8x1XHPvCbNZ7K6dO4wXzI8J8fjZgBZsm8nr7PRv7O1KlFvB4b2
	 zrvm6p1rRETlw==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf] ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del
Date: Mon,  2 Mar 2026 09:16:22 +0100
Message-ID: <20260302081622.165713-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ihor and Kumar reported splat from ftrace_get_addr_curr [1], which happened
because of the missing ftrace_lock in update_ftrace_direct_add/del functions
allowing concurrent access to ftrace internals.

The ftrace_update_ops function must be guarded by ftrace_lock, adding that.

Fixes: 05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Closes: https://lore.kernel.org/bpf/1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev/
Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..8baf61c9be6d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6404,6 +6404,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 			new_filter_hash = old_filter_hash;
 		}
 	} else {
+		guard(mutex)(&ftrace_lock);
 		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
 		/*
 		 * new_filter_hash is dup-ed, so we need to release it anyway,
@@ -6530,6 +6531,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 			ops->func_hash->filter_hash = NULL;
 		}
 	} else {
+		guard(mutex)(&ftrace_lock);
 		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
 		/*
 		 * new_filter_hash is dup-ed, so we need to release it anyway,
-- 
2.53.0

