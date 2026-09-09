Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6C3BFAE7
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982697; cv=none; b=iuFsbaBo0GRrVJ95x17XG+CfdqYVmkvSGSEcvtmR9ODqdSZJ6hqnQRlHvt8UUD2auUoygsPxKYsGSUwBAjqHgTaM3f9cwMbanKHtEIgrqFZmBHAs+0NSymlLue56JL8EV2DVjjdSoNyfryje3FjzIMQmtnygQJowtdhH30tFj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982697; c=relaxed/simple;
	bh=Rd/Pd3Leo+E3YU6ucU4gtKFQXVKmN2yo/RXforbd1n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTdvRPArUTikW1eEgXvWZpdOxO+7HFFGJd1ASd4VrUpQy8kqMEMAnutSe1BSv5OdSxAtN28aP2jGe7IME2mz9Uvv30pmwdFQk2tVNDGdYvGOuN1+ulkQlnSyM5EOL5PTFKcM4mqdkuB5Q4Dk8w9IuSjJlViPNtZHZRrHxE8NSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3kK0VBE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3kK0VBE"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8588583a7c3so67386977b3.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982693; x=1789587493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=os/pHxblfNO+1KqvqowSwfs/2gIGC0QX3UM4Kl6LzkE=;
        b=H3kK0VBE6GSq1egktkw4gh3qWBPWAIz0pn4FXTJACwpoWKFfEVs4k0mwZWenVfvHBv
         VRcbGOcpogc6z0kwCpop6taSb3Qblqkxve/IBAiyAGkddfSMAZ+Kth82G3udwfQUCJKP
         sI6E2ukVrqoKAVDI2VkPdoGKgoiJVHmnn9qm3Qhy/h9URxHmP5YR2YqSIt3CBi3HrXw1
         Re+hEkQPCr3apnonPNQ9P7d2XDYK3WW4D/UwzIGbMaVsElNvtBRcvjE5rlKInfrcbab8
         tvYd4V5NOITqQRIYjUKWyc2k2U0iVlfrdVIquB3GVeUlIJm6YmimjRCQYBqebUlXt5AL
         Xx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982693; x=1789587493;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=os/pHxblfNO+1KqvqowSwfs/2gIGC0QX3UM4Kl6LzkE=;
        b=mJlDSEVmg+vutv/VATz4Xa+imjTIk8E/JQ+aOgQd6IV0KeMyQ5Fzx7nKs7dmtTlo4i
         vh+7vc9LH0x4zd94N+CA/NNF5nIW1EaUhIdGqC2w7vrZZw1oZhL9RvVypQ4ncmwxq11w
         XpkrlRZkPDJwwtAxKmxv/wsjdYRGgvg+Mc+md2e/0829J64F3NyJdjWVDQhIwxhP7SG9
         /alwyVmnRvx9XbcYcIsczDHvxHspLZTLFmoMj8aOkSzwQI2ldaVJaw3c+LFrUtPhltgf
         i1KIJ8q7jaOSGYYwQJdm45NasffQUUR7r31l9fAoMgYtoTFqF0B2T/5MeZycoyPKJgDy
         G94w==
X-Forwarded-Encrypted: i=1; AKwUvBxf3zyaXcp8YYH8zk8fIBMGM2cCyOzL1LcJQp+9ri2LCDSt6PADSnYaiqMLKcXqIcs2MkM=@vger.kernel.org
X-Gm-Message-State: AFuF++lyjWVNo/YDIi+7yywEdQeX6733SD3YvGnAKa+6iYOvx+RIUZkp
	TrulbjL6rjSp4kWu94eA4A0aKNmRDC+pefVH5R9vhD7Jh+QJflkAF9/Q
X-Gm-Gg: AYBFou3QzvK12VKxROut2oTdwetOJPL+UeQqWguQEyuqCn1Skzyn12ubaBcTLwthQir
	RRUq/1CxPR/xe681PZ85Lh5eoE6Ma/ZW4nYeqmSwfhksVhVyRS4SzZ5InCpfCStyyXFG75AiR7t
	wZR2Oy67MQgJj98K+ZsAo3/1wl7agA9cgbIcvZy/8VgEWVyGAQZkGqgGqYA7snwsdh+RgbaFn+u
	mZc0NLFCNRzdJyfW4yQ8zaq+wo2uLSAw37vvHFjHM9WULaiUpokVLDsRP/55zhdiB7iM4JbgOri
	h8bTy/9ngCVbPXkfvT2O80waq6lFUkzjh5nrFgcYjcoPH+R/HQw8jhqrhKASXOJuxaTA5DjKLLx
	AsZFejg3IP36tzTSikUeIUEvHf1sARVuzs9VOuoH3Lo2HYemvrnq7M3i5t5i12mcr1TyNjYpeis
	4ZA/BzrdBtiHB0OTFDceJnNr1mR9HyaSpfRX+GmTCrVbjIsU8BZoO0hrjQfHhKxgADIh6q4hswV
	0wKDhrfjyhl0f6jkoYzEjFb+cMz4sfV5ZbGMKGTqak=
X-Received: by 2002:a05:690c:9:b0:87f:bf8d:3377 with SMTP id 00721157ae682-87fbf8d35efmr29761407b3.63.1788982692601;
        Wed, 09 Sep 2026 12:38:12 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:38:12 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 10/15] landlock: Expose the ruleset fd lookup to the rest of Landlock
Date: Wed,  9 Sep 2026 15:37:13 -0400
Message-ID: <20260909193719.518517-11-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
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

Notes:
    v2->v3:
        - No change.

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

