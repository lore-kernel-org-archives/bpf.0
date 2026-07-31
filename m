Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583B31AA8F
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464483; cv=none; b=fgUXJibJR3vKOQB7SlHjMoWhDsE5Sfxh1CTr9bKyeUb5GbyOZ6WO6P0MgFguRCo3z6gOBAWBFBHtnb5wqlJKjINRdoN6ppQLQoFXvJ9V6rs4MDa6Sz5+2EEgNZon5R+enZojY0bgKwtmiOuSXlL2Jmoj/2v/4szoVvfBCeOLMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464483; c=relaxed/simple;
	bh=My+S/AoHnM0sWQ2xfzHcL0mjHYwtuqRDL/YoeC794wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma+07FxaD/H8ATT7BuMIxt5W+KSYnS9tEzYU36pZhP54PeHKodiHx7NmCOgcKiuBhqhFhwq5EVEk1cLL7tRtq3GzBtww4aEXyKSrXn4JUs3pt9RAxhTrLKJOM4a0TByRdd5vSBPJoZiWMFKxwHfx9BWquGohHvaLMrzXh5NX0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1DwJtRu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1DwJtRu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ea0b7d137so4373887b3.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464478; x=1786069278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XvJusACK6JVx1ShSYZD+EOjxsALcCJEGMTDUzMzDD3c=;
        b=a1DwJtRuTrfBqJIpT7wp4bSk7RCtJIXYYrQVMamrOzMYTTbcdNX4Pz/iB/L0505v/I
         xf2+zjVBY1gVRicrjaVJNGTolZiHTS3gSpp3ASRd77GUSYpAVcvmTKDrtBR2ND8pEAAj
         dNiJhesd1Wi5oMiYNsYCDJDzy8mhvswtiyKr0cqrFG1zBtkfMPSxq5r4FsymOZQEVArJ
         +WqStX3G74jsfik01Uv8IfbeT0Mv7diKahbvxNmHwjK89ztXWL8gq3536RaS9A4iVfm8
         Ln4g0m1U8yWAQRhl401SCnyuRSzMNOWYJiR7gBlWRB4cTzzOBkOLtWVcJKP/q4RB67LU
         Q9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464478; x=1786069278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvJusACK6JVx1ShSYZD+EOjxsALcCJEGMTDUzMzDD3c=;
        b=sKZcd61aAQjmolMXow1mFN4+Duf+Y1AexaV70n7x7Vj616Fo8tWNAk7UHcbsfoUNOY
         6FzLVYI03hHXqobh+4SYevTOX/8GqcRtVo9HrlhQcddyfsG6jOxkLj0lv+W9nEFX4239
         kbO+Vf+pgf+yHfZZPZcvqfQZQPVtV8pQKmCqeu5YGpmxtwdtLcDhTuG7MqfdMaowMflu
         HCyH6SFLdYn9sex1+VjarXuKuBzSIfmNxwLPS774QgIty+1OYD2ZI1ZDiODaTScmpw7q
         f9B7mCK1v5pEP/I+qbqAlRkcnpyljQxAzPrevd84+P7VrXqidcG3i5WA19Ib1MLp8TXW
         XI8w==
X-Forwarded-Encrypted: i=1; AHgh+RpsZE0ZUvmHJpXlPKMVzASfq08+lTgCSp1SjB8GwLWP0Bkq4wdwRKuj3aSpUqNmEhplVws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41/7eSAOTRqLuLk6c0eQpwX49LNwXiYeRjTID+FF/QTpGpqf3
	yIHePg/yBNC2IRiv2ibB2EHTsSi9Wx0t/Eg7DScuR8m/bi0lslln0Wu+
X-Gm-Gg: AR+sD11qs9Bm62e88Xx9gTLKxU2dnN1nRCBfl2ATDIl0inIVpuNhmvBhDleRN3Bde8R
	O+CaH9U944TNbhCgxXWoEypfa54IYK+I12vtxPzo92OnMJLUdPGN/nwOZgXAic7ALyOIQ1zg+bN
	EshGpbmXfsDJOJNdcsR+MU7Oq3WHm7iB6fIbzOJBh7YB3HqS2E+dLAFmtGmFoaSeqLLl8onQYTz
	S+MPKbQl1CMvQMxPbO4H53IftVASHcwJu/fh+ieb3DJy8KNhnF5kl0AA5CzYESPx7F8ZHyM7dDp
	dvX2GVVA9LwRn1ql17OWUGIN48OkX+7Hu2ALHi1tixaTSlMbWQlOAC2ZAnBBnDBCl2IznSMan1f
	sz3qBCGuaC3sXWeHVBs+8chZwgjlPX2iaGLrQtszkaSD+gH3AJINRZMo0Tb+pcyWSaluvRM8WhY
	BH9/ERb7RGOIFUMUM7Xve3Hr6+ZWMWfrQzJInAtAknzaaNh842IqNnD8WPonpcvGOktV9ek55/I
	minEEKrXm8RWScf4OXPdw==
X-Received: by 2002:a05:690c:e3ce:b0:81e:6c2e:f113 with SMTP id 00721157ae682-81fcbb0187dmr690287b3.36.1785464477862;
        Thu, 30 Jul 2026 19:21:17 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:17 -0700 (PDT)
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
Subject: [PATCH bpf-next 04/13] landlock: Expose the ruleset fd lookup to the rest of Landlock
Date: Thu, 30 Jul 2026 22:20:37 -0400
Message-ID: <20260731022047.189137-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
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
index 0437adf17428..b65d1c07e192 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -225,6 +225,9 @@ struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		       struct landlock_ruleset *const ruleset);
 
+struct landlock_ruleset *landlock_get_ruleset_from_fd(const int fd,
+						      const fmode_t mode);
+
 const struct landlock_rule *
 landlock_find_rule(const struct landlock_ruleset *const ruleset,
 		   const struct landlock_id id);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..9af2407274b2 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -293,8 +293,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
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
@@ -476,7 +476,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+	ruleset = landlock_get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
@@ -564,7 +564,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
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
2.54.0

