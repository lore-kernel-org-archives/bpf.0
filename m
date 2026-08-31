Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CF5013C5
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188432; cv=none; b=krdGWQ01oNGLaSQgv7SOyLNyoiWQVqzhnSOH2gaj57Ezqf9BP6eR2DO2QLGSQ+v1G83FMSseZTB9kWZ6anJJFMHBo8YkTd9LDdoyh9laBW+F/QjIcrRjNEnUzuRq/kA3EotOyPOaUWw4V1mb5MY5nz3vafPS8ZHr98c17yHgTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188432; c=relaxed/simple;
	bh=T5//L0yJEU3CVN1o5jxNYrK6S5XFuiGgpBvi0jp/cJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg/HaZzyXdyv06FBY8a4oqSxpSRWz9sE1C9KSNbNZZ3c9eRb9nG0EHblTz6YO3GLedcpu5QUJyQ10Nzk3Radzc1e6JSmbpekOq7htPTjjQ/vS41Vjbrt9yYFaPVxp5k+S56ErvmrYoCcLA7AYCKQXwVOhumwe8HLfIGBBOre7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwHXeLt7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwHXeLt7"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-861feb6d61bso16008447b3.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188429; x=1788793229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ewv3B6+QarCZOHtRgYa+vZ91GvJ2yanwE+qIJXxDYtc=;
        b=pwHXeLt7ZqCYDiNGZxJbgDt5S0lrMpY1WNrVPZ0gMBd1EHvN1FRIs2URmTzC1nBftV
         +E/gOXn+4ncnWTvG8OtQQdYIORFurWSOorqvJIfB1syAWYZCCtJIIqWNSk02M3rdt5yf
         fjPFY0vGV3q/gv8qCSd7ipGWPNFwO71BbAd5oW/tv5T/ME6z12EtRHh0pJTJsvotXXGA
         aucCPfztdXwfFGDauZqv+DaWc2/fPPDFpy8EPaZ2EOjEQOL/e0+PNZ9/RFPCdCL4qP1L
         hbjL9deuCwKvQ5OaiCP/sRb4tPnuNy/0mD+n23XaqskXce1Ks1YMyo0KFVrtwBHogOkQ
         a8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188429; x=1788793229;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ewv3B6+QarCZOHtRgYa+vZ91GvJ2yanwE+qIJXxDYtc=;
        b=W0bqcEMPJj9Xa3oOL/oUlL2je5iUZ6Sa0JTeni8SdLc6fvrFwe7jNFg1iod2qxQ6MN
         jU18idK3sV+jAm2VmOsj3iht4FCSDv2q9hQkgJ3hT22lNxefbY8NdLSRcH5sGqWpRL5N
         if7iWlkz+ATrTcSed2Ar/yP5Q8+Wt4362J3ajqMHCS2DkjTZW4n+9o4gqH+GArY8jxOq
         cJ1oYqJS5g+RaKxYw837weeXXy6TIhMHz85leZpP84ED/KOIYfws7mWmNE0Ko4VO+wWP
         k9Oi61RI+m5hy+ug9ARR1Gl1YruQPIXh6LvZfgFloQ7vpk7x5ZZB791icF1AgR9JyUE1
         LNqA==
X-Forwarded-Encrypted: i=1; AKwUvBxNGJZER0QccH5McmWn6euU9XpSUq+5/N7KHooz9fXCd1R401QR3FqQs3nxExQ2yGNynao=@vger.kernel.org
X-Gm-Message-State: AFuF++na07AHre9yMcIcE2b+5GXxsKSVypY/+kYNQXx6LumE+JCHSPz1
	bBnbh04b8lB8gi+KGkQMLave+nOnQEzKWSK/D7eNCWbwAv3kcmEIFfnk
X-Gm-Gg: AYBFou0cCMEjfzeWuM9RI7tHQTuiu1Cz9eP4NdeaRwqN6FRj57yA4bu4s6MSsVd5wvN
	Iu6xwCJIaajZNkIHWbkQvZ4KhRte6aTCvcNfOJTlVj902ivX+wM8jN0hKnspGcAAWF1RduUHbh5
	pcTv2da1Lzxt3g2snpkqO1712RB8pwQrvt08phJmI3sVix5aIRDcoovszS2lxCVtoMBSyWFNpZx
	937f3SYhUsKEKSmaNsfcbnogdhtgiURhF0CwiiAqp7Nh7kI3UJf5rRnjtNnWekZK+OMwNSe1Fch
	oU4NOz61JhLdd5MeF4IWY8f2SkON0+tIc+EAqZzech9CIR1k9SyN6feXxXEGa9wmIA7gQC3xFcn
	zwDx4RWsCCVvo4yB+kAWKXTGWb+Ka5n2TsNmKcAPFWie0m2f7UEq5CM0nQKziJZyGeOIBlGR0Ph
	uWX94XZY2EoRxX5SSsFc68Mi+RUqHCdC7KOnpj03YU2VGGXC6z96F4lXlu8HxnrFz4pKhmWwKQ8
	z6xfxPESgtOTac74kwwQlE=
X-Received: by 2002:a05:690c:a7c2:b0:822:ee08:749 with SMTP id 00721157ae682-8686ed6877emr7079577b3.6.1788188428958;
        Mon, 31 Aug 2026 08:00:28 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:28 -0700 (PDT)
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
Subject: [PATCH v2 10/15] landlock: Expose the ruleset fd lookup to the rest of Landlock
Date: Mon, 31 Aug 2026 10:58:52 -0400
Message-ID: <20260831145858.3869191-11-utilityemal77@gmail.com>
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

Rename get_ruleset_from_fd() to landlock_get_ruleset_from_fd() and
give it external linkage within Landlock, declared in ruleset.h next
to the other ruleset lifetime helpers.

A following commit implements the LSM kfunc policy hooks, which need
to translate a ruleset fd into a landlock_ruleset reference from
outside syscalls.c.  No behavioral change.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/ruleset.h  | 3 +++
 security/landlock/syscalls.c | 9 +++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index b536fa0425b7..b58e3d9846af 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -214,6 +214,9 @@ int landlock_store_rule(struct landlock_rules *const rules,
 
 void landlock_free_rules(struct landlock_rules *const rules);
 
+struct landlock_ruleset *landlock_get_ruleset_from_fd(const int fd,
+						      const fmode_t mode);
+
 /**
  * landlock_get_rule_root - Get the root of a rule tree by key type
  *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 1d02d57f4c48..cb294a3582ae 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -305,8 +305,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
  */
-static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
-						    const fmode_t mode)
+struct landlock_ruleset *landlock_get_ruleset_from_fd(const int fd,
+						      const fmode_t mode)
 {
 	CLASS(fd, ruleset_f)(fd);
 	struct landlock_ruleset *ruleset;
@@ -486,7 +486,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+	ruleset = landlock_get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
@@ -585,7 +585,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	      (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) ==
 		      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
 		/* Gets and checks the ruleset. */
-		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
+		ruleset = landlock_get_ruleset_from_fd(ruleset_fd,
+						       FMODE_CAN_READ);
 		if (IS_ERR(ruleset))
 			return PTR_ERR(ruleset);
 	}
-- 
2.55.0

