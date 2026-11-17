Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910745;
	b=lJPtPiZlBmh6oPHZ65kazPAecmNh79b9l4xRdvm0sfb0Qu/ugk9XugdIUxoXl/CTiANk
	 qZtJvomROCbjzrZLf2zlmCiGLpgSyjIB8oGTK1jLdGG8FGRfRT8C9KpLjQDLKJnVwHdh8
	 wcBdzD3Q7CVzNN2qP0oqy+mEtaqiaKFKuRWiYv3x/jC9rYqsPsPkNxKy1nyEc1ekVMHrG
	 SOpiiDd/Kj458JG4ckK0T45Jxu5zOLk0iX2NKUSjsHNw/O8J3IMVGpbzHlfrHV7xwzXuj
	 Adof1WaiKUUxFW43F8lnZZrGRTC7WSItmfD05tfg34kL7tlrTYFVCjrikg9R0qAQ0lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910745;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=nb6Y3qBz5md8bEdKSYVr1uCQAxRH1CiYfiJZ2O+ozgw=;
	b=D98WGgqcC375UKvxYtWRCLIr6AoWK30Py4mfvfjCcBu0zlOSr5ZEm2zpExMmS6UcGcdr
	 C+9BNOCFAfNqlcVguiLrej2L7t2rYmSO31TuzaBeiOXHyzm/gcBtorNieXjZzfsYxXzGo
	 zcZyGFTMh250RHrSjKc0PA2hg7j4qzrK5Lv5l45L9dgMSQed3Nvg7uU9Sbx1L+VS1Wv8R
	 YJd3IDPuca5X2U21tffVqjvPohsLjS3uPdB1HIP9bC5eCHNLi/wiW/eFAHPHNz8qaOwb9
	 FxznDj1dcBmSHqyhNqh+7IdVDRr8m3Iq5sJyGzxMD+BWHB2dGhm4AS0CKkeXrAjfGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=xaWcp5Pp;
	arc=none smtp.remote-ip=83.166.143.171
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98963606A33A
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98963606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=xaWcp5Pp
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLL91k7hzWVh;
	Tue, 17 Nov 2026 11:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910736;
	bh=nb6Y3qBz5md8bEdKSYVr1uCQAxRH1CiYfiJZ2O+ozgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xaWcp5PpJnfMZk8QtNBy5SgREAEo8OKPqQtqrQlAkAfQqJMtqzO3+yDfEhfGcpS/B
	 f55mw+OmjW5Z5/a5LtuAVUb2CREXTnGQk/cu4jpwmXLQjSH5Vys9bVCaq79JFHROjv
	 1PaV+vYKtkjT2G2k1fP+VlM7QcOW3999ttZQTL9A=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLL73kJhzV1D;
	Tue, 17 Nov 2026 11:18:55 +0100 (CET)
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
Subject: [PATCH v2 5/6] selinux: Use security_capable_lsm() for CAP_MAC_ADMIN checks
Date: Tue, 17 Nov 2026 11:18:42 +0100
Message-ID: <20261117101845.2523770-6-mic@digikod.net>
In-Reply-To: <20261117101845.2523770-1-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
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

has_cap_mac_admin() checks CAP_MAC_ADMIN with cap_capable() and then
with SELinux's own check, so that other stacked LSMs do not have to
authorize it (see commit db59000ab760 ("selinux: only invoke
capabilities and selinux for CAP_MAC_ADMIN checks")).  This also lets a
process in a Landlock domain that denies CAP_MAC_ADMIN get or set
security contexts unknown to the loaded policy.

Switch this check to security_capable_lsm(), as for AppArmor and Smack
in the previous commits.  The cred_has_capability() check is kept.

Cc: Günther Noack <gnoack@google.com>
Cc: Ondrej Mosnáček <omosnacek@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9950f89dfaa2..5d85bc06f4c5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3363,7 +3363,8 @@ static bool has_cap_mac_admin(bool audit)
 	const struct cred *cred = current_cred();
 	unsigned int opts = audit ? CAP_OPT_NONE : CAP_OPT_NOAUDIT;
 
-	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts))
+	if (security_capable_lsm(cred, &init_user_ns, CAP_MAC_ADMIN, opts,
+				 LSM_ID_SELINUX))
 		return false;
 	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true))
 		return false;
-- 
2.56.0

