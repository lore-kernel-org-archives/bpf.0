Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7B37F8CA
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592160; cv=none; b=Q7GP6lOZHPK6SV6yiMsCNm+6uJfcfRF6aBsgHSKy7bDhtGdUyfR1znUgjtH78x0c2+5L2wWQwS0yjPLQRJ/soKJijc/50iGo/v0ZGb94LG2sM/F3R4+3t8tN7TafV7guMrFZEDEyXItWCOgqh9A7HS4+/jZjtOojQhzFl5FzVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592160; c=relaxed/simple;
	bh=DSsKfaRQj+ShpEKq89cF9lIvHEqhwKCyBQzodRo3jho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHncmvaXv1Zdck4wOyiqmpbcJTT99IEXRX+6x4Q7Po4XEOyTaM0dwl6bcNOBXIHBZ+Fuecc+p2dCb5BVdhLxFltR6cZ8jPQGODj74iQw9y4L+9M+zI9xTmcm53LubErHhADF+4HyTHZQvvZyV2E4Eb15fbHvevayTMYQo0H4kXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCpQj2Xi; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCpQj2Xi"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64edf260b49so468490d50.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592158; x=1776196958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3XHVr6+kc4SXGPEMnRFsQFJ4AUqQQgTn3Nba0UO5oM=;
        b=oCpQj2Xi3v4alHXJsI1HQrrty0UzVqEmuZ0wIqm93xb1W4aPpT2LWn3eUtNgEzzGet
         rhu2QM5O2F6UF+OKdlNxbELnnJrhkvIp+X9Zzp9aUDGcvSiJcoa4urp18MWf3N6w0Of/
         2r5pfkEsNpAi3VywbmcqBh+2XL/HdxtYgYoELjQIOMqcE2oZGeji1qfp4k2hmXYVhWIQ
         B/6AbN0U8DwrJFDzmkYcH8KKc8/lZQnKrK6sy0pE1M0vRsJ3PLwaldeTySlFuH1NxzX8
         JjfyhZSkYDRAF6sbcVf2n24KOkQTEjqapxYfDRV9VlZVzZJa9XOXkXdQ7ovKGKjloPam
         aX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592158; x=1776196958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c3XHVr6+kc4SXGPEMnRFsQFJ4AUqQQgTn3Nba0UO5oM=;
        b=pMDzpdwLPo9dmAL3wglvUnwMh7C89bb7f3bdbtwYSAKBf0XPPQJeAMUi4zEcnrg7/l
         gR0CMLeaUQPsR9rtD90C2y92x4q4q2zciiHKjCn3+knFQtMhreBTk+bO43qowBdEWbHx
         f9Mk0AKOG5CcyIY3ro7JalUONswLG7enwQidInLTzvvuVX41qhLEWa+huIKM4FaW9afP
         mOZGsKdkX33WtAxbpuApCPbg+cLfzw9pbQ3GkwePLvpEZoXfCRlC1fmY9SnQsf/wDnJq
         2hwLpycJ35tLhCIbMv8DkXeipYI2Ejz5z2Q9snX47xZxJxB00tHdU4hiYuoSUbM8mjfZ
         Yc4w==
X-Forwarded-Encrypted: i=1; AJvYcCW/inicTItXhkoXCfltbJ969HJy2c5Zj/bQ+3LvNlzFBMv1oz0gsOzdQffNanbWkDOMaBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzk8D5cXsjj0QQ384bPYUvAL2SKmUGKGILgc086eFGaNt/3o9r
	FO0vuQCPmx2kHdLNnsX31GcCD2HsDclAjb5I+BraSafE1KsWV/wuCpsX
X-Gm-Gg: AeBDiesBjbSTcEiTpMauISf9R4lpdKHxxMiIBDScj0b+T/L9csdCsUv7zx4WZtP/0uS
	FAOOTQrlVZr925Q5SvaLRFiYS2LE3otF2bulbmlfm/OT/42JSX58wa0JCYWuk9QjW+bqE/1emkv
	pmWguePzjRAmiW2c0iUI0iYk+cCHUKfp4ynfirhjpLuk84eIyTJJObae0gXaMhTL4zYsV0PsI6U
	YKxWpxaOzBCMpz9NBWbK9ZWWm8bBYI9qcabVdExTzy4DkIcPk7liXYfm9O83G+y6buwknMztpXv
	82olcJ1/EEgHV8xmRv5fD2uyHbwpxmRcgPjhxDOMy+nlzmT74gwC7tj5rZPYIOGtWicso7c8hnk
	THPHDip0erCaUEjVNKnmzY71iHlSDT/Z56nM6QBhFsIZByXmeeDKrgz4thTnGKJPsDhYjot5dIW
	DMiGkcSlhqh6MFYVYiheaqmT/BknXMcG4k+A831ZTrVlQ5r2Q5JEOOPS2w5GMpL/JwXF4mndoj
X-Received: by 2002:a05:690e:bc6:b0:64f:48ad:891 with SMTP id 956f58d0204a3-6503d735b3dmr17314508d50.10.1775592158131;
        Tue, 07 Apr 2026 13:02:38 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:37 -0700 (PDT)
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
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 12/20] selftests/landlock: Rename gettid wrapper for BPF reuse
Date: Tue,  7 Apr 2026 16:01:34 -0400
Message-ID: <20260407200157.3874806-13-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent a name conflict when importing the Landlock wrappers header from
the Landlock selftests into the bpf selftests by renaming the gettid
syscall wrapper.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/common.h   | 4 ++--
 tools/testing/selftests/landlock/wrappers.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index f6d6a6a99c52..5fe0158885e5 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -262,8 +262,8 @@ static void __maybe_unused set_unix_address(struct service_fixture *const srv,
 {
 	srv->unix_addr.sun_family = AF_UNIX;
 	sprintf(srv->unix_addr.sun_path,
-		"_selftests-landlock-abstract-unix-tid%d-index%d", sys_gettid(),
-		index);
+		"_selftests-landlock-abstract-unix-tid%d-index%d",
+		landlock_gettid(), index);
 	srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
 	srv->unix_addr.sun_path[0] = '\0';
 }
diff --git a/tools/testing/selftests/landlock/wrappers.h b/tools/testing/selftests/landlock/wrappers.h
index 65548323e45d..114b8c60630d 100644
--- a/tools/testing/selftests/landlock/wrappers.h
+++ b/tools/testing/selftests/landlock/wrappers.h
@@ -41,7 +41,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 }
 #endif
 
-static inline pid_t sys_gettid(void)
+static inline pid_t landlock_gettid(void)
 {
 	return syscall(__NR_gettid);
 }
-- 
2.53.0

