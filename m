Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342660;
	b=WmaLMxUTgibGsKOzCIxn15Vf1pY88EPoBTXD8tDpTbeIBaYnbtSYYakd3FX3YMl0rem+
	 eB0N0hRfOEWgY3sr/ffGYTB6ItSgnL28A5TslfqehaEHrhBJZOdXL/7Nzmbf4ywzgzEaG
	 UpxU/SxNRuWz6OWtaxx0E8zzn0oepCMkgNKcriFneit+wRo3OTFf5lmDOOcOKUkjVpdW4
	 xqRhq6mxf4w4MxwusO/XRVCqII2kJECvIC1q+ulYJYnTefYhoGhzSQf+mNBv1Uh7tCQLm
	 062Hu8tT/jhq1RdxP9hEB6eJ1/adhk0rRAbVEQu1dF3Ada4NwI8GttLjt9t0v1FXJHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342660;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=xyJt/IA562jYSqS9g8xyRoMMlRr+/oArZPwne7/nZrs=;
	b=HJ1UtlvcK4EUhNJZd8Na1i02jFNaQsKyKCmi+saMQKdqYMN1doLryFIwGwY/jV4Uwf2e
	 y14A0asYYOASaHhOU+Of0PrnyFSiakCuhUrmw/ZhEGevV/h3UTe4Xq/T227biabvmQ1MI
	 83fpNIDZZORB+R05/l6849YbExfqCXGOU44GmWXBMjNTLmhHsHiN1TLWTOoNtYBkIhUbx
	 NqRPt0fxgCVSAhUmjTqlcNCx7qg0w5XZSTpyZWSxxg1YlwGBP4Qv4BPGi+El+jjZTp7Lq
	 pJI5wI2ZtFEvXFMKxf0lDSc2AQ8TyEqdSH5kFfNTC1iwt7GLwKfN/X4HV0Cf/SX5N7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=RkE1Cx9q;
	arc=none smtp.remote-ip=45.157.188.13
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8A607252C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E8A607252C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=RkE1Cx9q
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJFS1k6pzGDf;
	Tue, 10 Nov 2026 21:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342651;
	bh=xyJt/IA562jYSqS9g8xyRoMMlRr+/oArZPwne7/nZrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkE1Cx9qAQvpLdQzufswkGl40o1xzLZO7MgdBSyik5rHM8qNAiJPlA8vGIBKwww83
	 LihVFyDjCuxZMjCA7a9IlSXv1N1WxZe5d74TNG5vf5RQAc6wqA6j9pylHHNVdyS67t
	 YS/A735saKW0Di89c3fbbOx50xtBb6wBqs5HuEiI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJFQ52LqzyHT;
	Tue, 10 Nov 2026 21:30:50 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jmorris@namei.org>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 3/6] apparmor: Use security_capable_lsm() for policy capabilities
Date: Tue, 10 Nov 2026 21:30:37 +0100
Message-ID: <20261110203042.2410140-4-mic@digikod.net>
In-Reply-To: <20261110203042.2410140-1-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

AppArmor checks CAP_MAC_ADMIN for policy management and CAP_MAC_OVERRIDE
for unconfined stacking with cap_capable() instead of capable(), so that
other stacked LSMs do not have to authorize them.  This also lets a
process in a Landlock domain that denies CAP_MAC_ADMIN manage AppArmor
policy, and one that denies CAP_MAC_OVERRIDE avoid the stacking
restriction on unconfined profile changes.

Commit 31ec99e13346 ("apparmor: switch to apparmor to internal capable
check for policy management") made this choice for CAP_MAC_ADMIN.

Switch these checks to security_capable_lsm(), which keeps this choice
for LSMs that only implement the capable hook.  policy_ns_capable()
still makes its own aa_capable() check.  Update the comments that
described these checks.

Cc: Georgia Garcia <georgia.garcia@canonical.com>
Cc: Günther Noack <gnoack@google.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/apparmor/domain.c | 9 +++++----
 security/apparmor/policy.c | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index af9e8431e3ea..d2c111783457 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -884,11 +884,12 @@ static bool is_profile_priv_restricted_to_stack(const struct cred *subj_cred,
 {
 	if (profile_unconfined(profile) && profile == profile->ns->unconfined &&
 	    aa_unprivileged_unconfined_restricted &&
-	    /* cap_capable returns false (0) if true, hence true here means
-	     * doesn't have capability and the stack will be restricted
+	    /* security_capable_lsm() returns 0 if CAP_MAC_OVERRIDE is granted,
+	     * otherwise the stack will be restricted
 	     */
-	    cap_capable(current_cred(), &init_user_ns, CAP_MAC_OVERRIDE,
-			CAP_OPT_NOAUDIT))
+	    security_capable_lsm(current_cred(), &init_user_ns,
+				 CAP_MAC_OVERRIDE, CAP_OPT_NOAUDIT,
+				 LSM_ID_APPARMOR))
 		return true;
 	return false;
 }
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 63f7821b4dff..ba162d921805 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -876,8 +876,8 @@ static int audit_policy(struct aa_label *subj_label, const char *op,
 	return error;
 }
 
-/* don't call out to other LSMs in the stack for apparmor policy admin
- * permissions
+/* don't ask other LSMs' capable hooks about apparmor policy admin
+ * permissions, only LSMs restricting capability use through capable_lsm
  */
 static int policy_ns_capable(const struct cred *subj_cred,
 			     struct aa_label *label,
@@ -886,7 +886,8 @@ static int policy_ns_capable(const struct cred *subj_cred,
 	int err;
 
 	/* check for MAC_ADMIN cap in cred */
-	err = cap_capable(subj_cred, userns, cap, CAP_OPT_NONE);
+	err = security_capable_lsm(subj_cred, userns, cap, CAP_OPT_NONE,
+				   LSM_ID_APPARMOR);
 	if (!err)
 		err = aa_capable(subj_cred, label, cap, CAP_OPT_NONE);
 
-- 
2.56.0

