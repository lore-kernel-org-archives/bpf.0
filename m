Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490F509EEE
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188464; cv=none; b=U1RkZm5j4/xW2RTMP1AKjC3GFERdW48N1spHWZOJNgRYpKCnMu4BGKptT9mRuFvHaXtOlPIXksZZeNP6kEjxKbwPHho0XDQbTJ383yeYbcx5CPxZHbJs+oP0XNclg0dpnoLwk6CF7CYK8zgXjDouEM9OkIv6n0k15quKtzfnYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188464; c=relaxed/simple;
	bh=WptSfOqEMNBmGXPbTwBGhZeeMOjidJMhs+vE6dbvvzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtxKB9H2+1RY6/+Mrdn0ltywPZK+pSsGx3/t9jxwt1qedxWL3dK0gO6LsRF/NQ5EN775n560Q0zxCjAjleow0vnO+115/+Cwvk1PMmaOBTVmNNcBWZUEaL2Pcw3McjSBr6p9DS+0l/ZKmV7JF6GDAFXZL66nk8I+PuyZnQmY/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpoTROpm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpoTROpm"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-865bdc6ed72so15701597b3.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188462; x=1788793262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+ivS8VeeEbj61xzPS0u7NgZI1YqhiDthhnP+E6PAls=;
        b=lpoTROpmnLLnWrEia9dsI05p8yuP+RzGQF0FDaqkjUk2Y7n+x5f8DQehqkZCra5Yc9
         1PgDfkJ4hmqrELrsVbDn7mkvLvrGv3Z97potxi9WaCQf0htPYZP0P07KH1SLBBnlxOAX
         A/lZZzwu2ZAIsvo3uubHhFQJeUKs4OF1r3oQ4dWd9msM++P0w2arMSvy9NY4yUQdr4yj
         pRHF3BC+PXHZpMSVFokaHJIuLSVCnNuD/3V4shK+eQVknTPn7KNCuaqMxCe8sbGdTpyT
         j21SSjI7Xrps9N2J1lugZr18Js/kdq9TjX8KH1uglYga2gAEz+DnlkxLUSidXUDzwF5K
         4COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188462; x=1788793262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+ivS8VeeEbj61xzPS0u7NgZI1YqhiDthhnP+E6PAls=;
        b=AVaenfWXhXlJSWfd1e7jNqbtQ4BbKaw7yb/7Paw5CBEDlAcse5p3TljP/iYhc25Vee
         CqBpEODNPTQ9cQQvjjAeNrY/GsqmVnJkkyOLkU2DgW2HkehGQqflHX4OK46lLt+d7IAl
         QPB3MWOhXonIR5DIwWoRAHfYqoJ1xZJlcSXBN+6BlkzuQIDr8tMvD/e0QYpKjyleb2SO
         a6NWauQLKyc69zlo14GuAkCkvK61s296t9BZsiBXI41xCYf849vCalA/Ly2X7utSxMKY
         P46Fj9VsA7OqmmjDnL3Bk0gAR9+eFePntq3Vq4Gz8lbN1rtKPoKAi9KlZ0tpM7HLrBy5
         fYZw==
X-Forwarded-Encrypted: i=1; AKwUvBysth4A1r/V5jdNxZcRFjS8crxTpTk3GXl6JWE5FVYz1pFu3ZNNGC5ZqLQuZplZChNSKDo=@vger.kernel.org
X-Gm-Message-State: AFuF++lVvzPXifW8OktugCbuL00ngh5YBBhIQxegygt73mgL7STxfepS
	Y11yY5h7vjZWVYJ+A14JX1Anz/njJ6j+GO6aUxXQpVOpo6+nm5csela5
X-Gm-Gg: AYBFou3jc1zXBCicmfLEKfMXVIHZEhN78iWyJ6v1Vti7T6Oy2xnr9L/Uy1/hI2ZPyuv
	+Hcrm+2i//XoPcIUXvST06AQDg8OyllPnw5B6nOSrSg3afmiQmuCjF2aZYF0PPiwWqP7LO1v2JJ
	O4UxfP88Gml7KKDzi+0UYr6x/rAnwXYYNVh2bGyJLU6k9DF8qgIWR0nEYo5CW5ejJuxKbNFbg+H
	fj2DkxV6CB6jDdb1cM/gnvg8nmASnZGvZtuspq1laOWaFpHfWR89DE4AWHWYdvS+UMqP03TTI+o
	MAJVwbOCPGKr3npQuFocXrBheNVdkbWBABnX7kXBDBnVyN0FKzp5KhxRDwzWjhyKbI7xGWaLYui
	xMEq/Sxj9deIZ7f4MiI6Wz5f9UlWHzEZL2PWkaNl/NO9o1EHdYHyNfUgbvtt6TDFtbijLAEp9gv
	ez6Z2u1rBQ0n9yM8OjmSHdXNUKIv0UyA6jEprEy4DIdBnTuHguzD8p8ynaR51RULx26zOc+o6lj
	Fj8t4ZUBLLHdaAEx/zgrNE=
X-Received: by 2002:a05:690c:47c5:b0:81d:edf2:dad8 with SMTP id 00721157ae682-868726e607emr7223467b3.22.1788188457650;
        Mon, 31 Aug 2026 08:00:57 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:56 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 15/15] landlock: Document the BPF policy interface
Date: Mon, 31 Aug 2026 10:58:57 -0400
Message-ID: <20260831145858.3869191-16-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe how the generic LSM policy kfuncs apply to Landlock
rulesets: the program-side flow, the staged restriction and its trace
event, the LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS semantics on an
execution, and why the bprm path carries no no_new_privs/
CAP_SYS_ADMIN precondition.  Note the new emission point in the trace
events overview.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/security/landlock.rst     | 38 +++++++++++++++++++++++++
 Documentation/trace/events-landlock.rst |  5 +++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 2d6e1076484e..ddc0d149ae8f 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -130,6 +130,44 @@ The reasoning is:
   restrictions, because access within the same scope is already
   allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
 
+BPF kfuncs
+==========
+
+BPF programs can apply a userspace-created Landlock ruleset to an
+execution, through the generic LSM policy kfuncs (see
+Documentation/security/lsm-development.rst).  A syscall program
+(``BPF_PROG_TYPE_SYSCALL``), running in the context of the process
+that set the ruleset up, acquires the ruleset with
+``bpf_lsm_policy_from_fd()`` and typically hands it over through a
+map kptr field; a sleepable LSM BPF program attached to the
+``bprm_creds_for_exec`` or ``bprm_creds_from_file`` hooks then
+enforces it on an execution with ``bpf_lsm_policy_apply_bprm()``.
+
+The restriction is staged in the Landlock blob of the credentials
+prepared for the execution and committed past the exec point of no
+return, so a failed execution leaves the calling task untouched.  The
+commitment emits the ``landlock_enforce_domain`` trace event (see
+Documentation/trace/events-landlock.rst).  The kfunc flags take the
+``landlock_restrict_self(2)`` flags with their usual semantics, with
+the exception of ``LANDLOCK_RESTRICT_SELF_TSYNC``, which is rejected:
+the restriction targets the execution, not the calling threads.
+
+``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` makes the executed program
+start with no_new_privs set, binding it and all its descendants.  It
+does not affect the current execution's privilege computation: the
+bprm credentials, including any setuid elevation, are computed before
+the flag is set.
+
+Unlike ``landlock_restrict_self(2)``, the bprm path has no
+no_new_privs/``CAP_SYS_ADMIN`` precondition: a task that is not
+no_new_privs can carry a BPF-applied domain, and its setuid
+executions still elevate while confined.  This is sound because
+attaching the BPF program is itself privileged, granting the same
+power as the syscall's ``CAP_SYS_ADMIN`` carve-out.
+
+Executions may run concurrently: each takes its own reference on
+the shared ruleset with ``bpf_lsm_policy_acquire()``.
+
 Tests
 =====
 
diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index af9267cca47d..6cec3194af0b 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -34,7 +34,10 @@ Landlock trace events are organized in four categories:
 - ``landlock_add_rule_fs``: a filesystem rule is added to a ruleset
 - ``landlock_add_rule_net``: a network port rule is added to a ruleset
 - ``landlock_create_domain``: a new domain is created from a ruleset
-- ``landlock_enforce_domain``: a domain is enforced on a thread
+- ``landlock_enforce_domain``: a domain is enforced on a thread.  Also
+  emitted at ``execve(2)``'s point of no return when a BPF program has
+  staged a policy on the execution (see the BPF kfuncs section of
+  Documentation/security/landlock.rst)
 
 **Denial events** are emitted when an access is denied:
 
-- 
2.55.0

