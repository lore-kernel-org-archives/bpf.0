Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1083207DF7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142615; cv=none; b=SwwfZEFH7NzC1kTNKjjn95txiisI+ySxqqRzUu/hTHGI0zvqAt3Drs4GL3O8MeDnx3kCuqyxy4UsqSDoRn5KfWwYAF9z68IdIVuAhMlWXWwzjVj4Ad3LFDBy+beyogVVOA7ilty20JfyUdTrSEPtIhRKXHGxBzrYpWAqJDn/X20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142615; c=relaxed/simple;
	bh=W5U3TV8WmLG3gIts08oCCYJ/bHitfpcdQtfMKvrGzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RApCqrMreLLM+dTNb+JbzwCYsqDLdJRLMm3GOFkHQTJa5xr9lOeJFuk6eNYK7gGvCmL8JPyek7b+tJrVXJ9tmZ6e1DVAtvQvVvajtTmkKL58gr/IKs7eFfM7uNzHeZlIu9VNkeHhaf5MSjiQnCIF8ibwYKRiSYmzyCcup7LntrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQCsKEVq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQCsKEVq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso8997995e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142612; x=1775747412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7ClQzhU4mf/93Wn6HtNM1rz2QX+k6PSWy4yviqgoP8=;
        b=dQCsKEVqAZmbdv2Zw5s3ZFXsnu6ez0tmdqHF14M0YTqHhvY06IyQKxV5BIXT6+1Uv/
         xuxzVy6cHHME7P4P5vPQ/bp8K5xbzdkRpu0I3mdIJE+fE+klF6R3tEcqkyq6YrkPWBHR
         spfwxzFtFyjg4FYRC1+T8ws7iWe/1l7wx4ov1PQwqoIVjQ9MVN+lgCZgk9vWCEPsus88
         47xUYQLLl1k0hALcfGsJmnXytZTIGnAm29sMijxQnNwejgWZlXqsa+XinahxJ7PAqs4W
         xsbnTt9HTjTETVkOIh6Fz5hGX0LYV0oao0RLQL3k4NDdQgCjGK7GuoV9SC3YB7UXPJet
         hGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142612; x=1775747412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7ClQzhU4mf/93Wn6HtNM1rz2QX+k6PSWy4yviqgoP8=;
        b=q9Xia8ogVo70nrwKhQ2uB58p2Yc3WKuThBvwUoDL+maOAzt29QsrBR5zwzfaAXv9pn
         lgnFlLlpXz1OH0zk/+dHHat9ZrwQbfj8z5F6/5/3TcWsTAbTE8k/Voc7cE870vYB1j54
         hea6QkyjjPu5QOUMx6o5aGpn8B3RdDO6Rx7AClJBIl1iAPJohSFbiw8vySeAQU0H9WsV
         HXPFHwnnJ9jfNBoLZkpEga9T9ekVmBNFY+Cf5UZlBvD8zIhk+g0g0+lwIBxT/jKzyEW0
         VwuNid3oX1J2X2Bdk83VUGKLCMUFWeGZimBB5E02kbnAR8sKy19pWLsX6BUElY1YyUrM
         quxg==
X-Gm-Message-State: AOJu0YzHLfwKjXdsEevq3SDfgEvA8fMm7otAnD+fTIm0wQqZYyI6UyXu
	6lClL5BeRcBGDaqYfIA3WxbLz8CIZySKLzYGCIIPsrBpLywljMZAZYIUV7+Et1nf
X-Gm-Gg: ATEYQzz3d0/7wCTK6JLogvacxuXmQQf7wTIi9qSQ4q2JUFwy5IDaM4WRdbCf/Jg97nh
	Fi5R1Lm7z3CPklXMW1wS3v8wBqCtB+Jb/JFxQ3BPgepVMI6N8r1k1hFuljENT5DkusRbNnQQp1k
	XaDAixUZOoM/HZGAFhjXpD9ZmpEjD0KTTkZC85XxSmY2I27VD8LktcAAIq25xnpS9X1fyXqkU6J
	dvaRznY7ML8sOwtM53bsaHmHZd6MiJQZuMBUpgfosa3z0Vll88TlkHjUSFypqu+oBpKWF955SHs
	9NEorTxZlL6KtSr0U6Og5DllQHSMXwRPApwvYDBzKpke6ftSodM4fjEp+1qxj1OWJ7XOUZNMHyo
	hRY+u8dKJ5YzpEQosQs7+LSYGmhiJZ38p8hyxJoNqnRqvS9GXDvTEQi9VvQzpQ96s7dchVficxv
	l7f7N0lcuFdsPInB57bv+ri2n50G1wWsgMC7cLDhCiRQwfHglzFXZUW+MZ/5M8uIDbLis4csbUG
	6wBLsyoKMbi+L1Cdr2kGUeXlf4pA1Ig51ChJLZ3F95JeSqxZPG+uSOeLK5PY6MJWnObRjIaET9g
	ej32Lc+4BirH7zPoAepY0WFqEaqYEoYrlpoQj2SsNpc=
X-Received: by 2002:a05:600c:304a:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488904b124dmr22989985e9.22.1775142611853;
        Thu, 02 Apr 2026 08:10:11 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48891d5437fsm22667425e9.5.2026.04.02.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:10:11 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:10:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next v3 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
Message-ID: <73127d628841c59cb7423d6bdcd204bf90bcdc80.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

In the subsequent commit, to prune dead branches we will rely on
detecting ill-formed ranges using range_bounds_violations()
(e.g., umin > umax) after refining register bounds using
regs_refine_cond_op().

However, reg_bounds_sync() can sometimes "repair" ill-formed bounds,
potentially masking a violation that was produced by
regs_refine_cond_op().

This commit modifies reg_bounds_sync() to exit early if an invariant
violation is already present in the input.

This ensures ill-formed reg_states remain ill-formed after
reg_bounds_sync(), allowing simulate_both_branches_taken() to correctly
identify dead branches with a single check to range_bounds_violation().

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15defae1d7ed..8215355f6be0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2788,8 +2788,13 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
 
+static bool range_bounds_violation(struct bpf_reg_state *reg);
+
 static void reg_bounds_sync(struct bpf_reg_state *reg)
 {
+	/* If the input reg_state is invalid, we can exit early */
+	if (range_bounds_violation(reg))
+		return;
 	/* We might have learned new bounds from the var_off. */
 	__update_reg_bounds(reg);
 	/* We might have learned something about the sign bit. */
-- 
2.43.0

