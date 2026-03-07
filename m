Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9763603E4
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916669; cv=none; b=N6Y46pK4lnTvXEmKlbaG1l+LexCWQaLDqvuPLFZk7wiCy94mnkKrMa59pG/pqtZeHe94qM1osptI9027dTcrpFwfRh+xpvK6QCTARtPzrYfoKrUu8uts5nolKO+/hR6brbWFoXn1+eHNe2VXhpTgT72PztoYkAAXyJTuINbba1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916669; c=relaxed/simple;
	bh=Bf5K9Guvd+wyKKsJCc2nAC/L9eqTu/OMzi8p66l8bNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbiewSy1RaL5NOg9DrtILhlgcu/bmCwWbuOgZ8TNDr/oEeHdSMlOBpQ1c5zz4vRVoHEvRq6ee+lKgsiCxwteH1jVEmu/kbYkbSaB5oBzsmJrTEoxmLbFXvJpxL3V0AYQJelFYEbHGuuGNN8rm/xEyKqznNVXBc15EhESrXf09Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gJJyfyhE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gJJyfyhE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483703e4b08so101363785e9.1
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916667; x=1773521467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4CFOYszHIMIOTlHDrOmB+I++aqI79L6ODIfR/9Z+VQ=;
        b=gJJyfyhE7omqAXPsMZRHYmO+QTvJa57lsKLSCBsWFLHYZWQm1u09ZdWHEF5uJ0cxFZ
         CVKceoT+7+F8Gcg2J2thM8td3lmB5We0oaj+avfYKHDJ5UsZOW8Lld5Z0Y/VvnrsjzpO
         56onoGm8N6iCquxbmB/par/fbcHWeknRgh9/UKUJvLoCVryjakfU6aW+5txuL0vhh0XH
         ptKmOTBQVXZKGXU5XV7mRlbM6oG3azUPMnp0mY5oFXDZ4mgTyZ+Q9rc5ZxQYjpVav9Wm
         Pk6RbH+Rwa4Sqe0WCS3HWU05uASH/u0eK5QM8HTrrzwlYgUr92mJoSiD2sM6sMOE4Mo7
         fVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916667; x=1773521467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4CFOYszHIMIOTlHDrOmB+I++aqI79L6ODIfR/9Z+VQ=;
        b=dXpIxxemZTpBPnotirBd6kjkSe4p5dSME4nP2GJ+Ra/vPJMmKEQw+15K4Q3fZM1o7L
         QpidoFt3P5u7mjAyMv3wMSRkawHeAnOEJPpDXlCAj9imXoSh1kJNV2ogTbhJi+RU1+cd
         Fj6QMInDDyagwLZoMBGgjSCtJCAlFYqVX12Cs9vcavqGTxxaE7zwiW9FJWe3vtldIgpw
         TX+yDLN0UIFkRY59CRLrwtTsQNywLhRZcm9hNeqhJTQ+RJhO2AKSybce1LY5raSqKl90
         5vPCD4R74oMAaJwjaKxfIRkZQacwwNlGyHVJBo6+Fxvu7tlbR8GMjI2Lojx6cWEUf5jg
         aqHw==
X-Forwarded-Encrypted: i=1; AJvYcCViC5aEzgc8BqItiteBDL7eXCDr5X06IxI31kTyfmXqaMFLaUZbNMVw53791u9ebc2T9XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KWxM/nMJnbTLuiCkjpNOl8F3eolvfMgV0htlgpmnN1j9gfmZ
	bmQe4PQKPbYRH0PyQ1O2YquujKesg3TX+/2Yw3y9HSyL3ZdZZptsbsvEgaB9OSjH/wg=
X-Gm-Gg: ATEYQzx64LPdWqXbDsrN7+mnsi4NXiwC7V+LfQrGWCfjqAwVOX+gbbSlpS3Xws4mF/Y
	/Zi4i5py4UW0hgEvicuI3yuwoSoZWeGjFok/LhoPTURvy4/M8lagcJDU4Xv7baujNzZ/SRtNmJU
	R3QjZkE3mMVXHn2sjwjvQbgEI5u2kKU/i0JQUOVeuDuQ/V3v+5WKMDi0zHnl15fO3qCDevTQmVv
	VXD2Pkj/M5q+9dRzC/NyvZoHeVkF+OBDNgaktdb8BjOgTaVCURYVRZTB8kwl6S0+T0Lkt6FJcqu
	EKLwwatElO/FVvPB4cZVv8Jn2TvJMUzStetB2NhnIem6AbbnWBmychuQU1oDAqGX6S4UTeyMJwM
	J9E77OLqenldCLYfOfOGNkCXLKLm8v30M8tbVkuKb5x7rpbQwtp5tlkWRKm3Xb5LFiynYpW+TeM
	VMoBhUKsj4Rw==
X-Received: by 2002:a05:600c:a30f:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-4851ee9a529mr146672705e9.11.1772916666606;
        Sat, 07 Mar 2026 12:51:06 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe891ca1esm5735271137.4.2026.03.07.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:05 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 07 Mar 2026 17:50:53 -0300
Subject: [PATCH net v4 1/4] ipv6: move the disable_ipv6_mod knob to core
 code
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-net-nd_tbl_fixes-v4-1-e2677e85628c@suse.com>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=2327;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=VUwLjPvoellOz/Idggb+FMpUF6XQP2WLQN/6ZAj5ess=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOL8kA4Qc6fShFm8SSTXdDzsjABAPF8xRLLKNE8cDJPugPSoxrouOQBc5bdkio2v/bKVwILILuH
 hL2sS77g8Pww=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

From: Jakub Kicinski <kuba@kernel.org>

From: Jakub Kicinski <kuba@kernel.org>

Make sure disable_ipv6_mod itself is not part of the IPv6 module,
in case core code wants to refer to it. We will remove support
for IPv6=m soon, this change helps make fixes we commit before
that less messy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ipv6.h | 7 ++++++-
 net/ipv4/af_inet.c   | 6 ++++++
 net/ipv6/af_inet6.c  | 8 --------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 443053a76dcf..a7421382a916 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -333,7 +333,12 @@ struct tcp6_timewait_sock {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
-bool ipv6_mod_enabled(void);
+extern int disable_ipv6_mod;
+
+static inline bool ipv6_mod_enabled(void)
+{
+	return disable_ipv6_mod == 0;
+}
 
 static inline struct ipv6_pinfo *inet6_sk(const struct sock *__sk)
 {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8036e76aa1e4..c7731e300a44 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -124,6 +124,12 @@
 
 #include <trace/events/sock.h>
 
+/* Keep the definition of IPv6 disable here for now, to avoid annoying linker
+ * issues in case IPv6=m
+ */
+int disable_ipv6_mod;
+EXPORT_SYMBOL(disable_ipv6_mod);
+
 /* The inetsw table contains everything that inet_create needs to
  * build a new socket.
  */
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 23cc9b4cb2f1..4cbd45b68088 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -86,8 +86,6 @@ struct ipv6_params ipv6_defaults = {
 	.autoconf = 1,
 };
 
-static int disable_ipv6_mod;
-
 module_param_named(disable, disable_ipv6_mod, int, 0444);
 MODULE_PARM_DESC(disable, "Disable IPv6 module such that it is non-functional");
 
@@ -97,12 +95,6 @@ MODULE_PARM_DESC(disable_ipv6, "Disable IPv6 on all interfaces");
 module_param_named(autoconf, ipv6_defaults.autoconf, int, 0444);
 MODULE_PARM_DESC(autoconf, "Enable IPv6 address autoconfiguration on all interfaces");
 
-bool ipv6_mod_enabled(void)
-{
-	return disable_ipv6_mod == 0;
-}
-EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
-
 static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
 {
 	const int offset = sk->sk_prot->ipv6_pinfo_offset;

-- 
2.53.0

