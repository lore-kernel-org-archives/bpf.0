Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812338655C
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592172; cv=none; b=YnjzJw7d/krNb2q5fJKXVwz5RCDeMHhGCHtU1aAHrPkDsf+THCEXPGs2V0pdpFSqi6XA/UyvbHwD63QmwckcPQXH9QyRUpQh3ZZPFvlqEk2H2a2XPENgQJY+srexnltnbcGcSZC+7nl+NOERIAFP8Xd/8PD/V+ebVB2cAsLmTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592172; c=relaxed/simple;
	bh=XHuhaYzURLOJm9gSsZkdpKJOAK5ycNWjARx3XgxPE/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHLhth4k120PsuCClccSjA1j3FxsuvyWIrz+wYVq9xQcxyyx7+IiWtorLebnpq15+pfG/4olSSBG+6gQx1QfXTH9Bz7gOEJa7MpUgpX3CG1Bn9BVTBiUeCfEJFzuKtueZMLyKw6X9KC987D9a76mpYSUduxrbvgEzEkgRAIMxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmaOt22z; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmaOt22z"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6501c9903edso5526373d50.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592170; x=1776196970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN3rsYPwNB7hPZYQqrXuOahpMQZ8TstAANGpzM3WXKE=;
        b=rmaOt22zeE9CbIilAHym9/X5Te8R/qxYL6w7nQlOQkmvBjRLN0w5xZ8iFCSdtD/n/x
         nNKdupK/g1PGuxTXvzJQM29vchPaIsn9b4Cc0G8tovyTKj9kG+tPEMI87kPNbTRk1roa
         JJ2lttoUpU3lsQjverDyNwwxfYG57nWK5YrbKeHeZ9SQTTWPimzXsrDP8dzfeKGgx5Vq
         me1nZeH6u3OAsT4fL1XIvHbxnvsbKpl6MZkcS7BYqQQyrE8u/PPOS8CUUSIztPmv1xCT
         OU9/T+hLbO5OopzhEyZpC5CZGjr+Q5RnTvkLpYuKnXiuX6/1nniNnePSvZoJ5guo578k
         4lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592170; x=1776196970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mN3rsYPwNB7hPZYQqrXuOahpMQZ8TstAANGpzM3WXKE=;
        b=YKFT/kBIyk8Y5quc+f/bEcY7UwrSjwjh1wld6gASlJ5M80SGLGM+8letDyZkU0neZK
         OqQREGKNfSzc5dQvchcCnCPvo9yE3CfIzF0jdDaSOhLzgecycb8N559IUszsZLRRLfUG
         e2Lsqv7sjL8fedrlemlR3vH6AIlZ348DmodhLevnf6+SmserMff2mxmfagX61/n34z/H
         S0MEfHYJqcpJ0+zVKjQPoPal1Wsntc9i2nMv4c4e904dN1wvH//WAgPE5m2aFN7YbXmP
         YAlLlbrv6kuwMy06mBwv0uKceKo/uWg1hkyxN1rHvLIl8oVHIDslCiMXqT9lDHch4bVq
         REPA==
X-Forwarded-Encrypted: i=1; AJvYcCUNxk1HLcf172QRkNRI437kvUfn1Fiq2z33M97S8nOBa3lwgCHOi8Mvf3m7CGjVNxPKr7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EMUyaj5gcRagN8ksSXWl6uw4iXQb2n971vVp1u2EkPFzztiN
	DNOwn4jxIYEgUiNm0AVOW5KSIOAofYxU/iS0oRu04kkifDNQyJovjiGt
X-Gm-Gg: AeBDiev2zSTL/WWN/eW3QSe5HfixiueJEoBa5vGsh0qJ58LgLEhuJvjiSI/V+npKlxP
	kjZVXyaqcs07yuFA1pJeRDbEw+J7m09Dtdzrb4PdgzWjvRkQfu+o4p50E+2NEQUxX8rzWNRYPnb
	ck3EEwH8+jfZ9CZKzH5MoivpmmdruxFB8kGu0OWb2fsyD0jevJ1Q4KWc/VUUR3DaFe3P0yZ4EU2
	7e7AMnHHrp3LawKxlVXuX/U5xbaELP6DodabzLHBhKw2k0RYKiZp9nnKa8dsiyqlFW5suoq/qzI
	fQQeK0lr8VFwirR5M0V0oPsPy8p2cIhNwfFwUwW8lOTeEK1IZhGaAR8DfMFSf+26dNr9ZxkFIT+
	moJEnrceIEx1EPx7h7bF+fs3zsGyY5ExVYn40MHXuQ5wl8ay5UA06kvXFw22/Qv4faOdADX7/7U
	eR8EzDyHT2iCmtBtgPwoXik/2WPHqJC8KszGZ9t/GD47vuWeF1fJ11byT5+7yAfrlLayOhYWQw
X-Received: by 2002:a05:690e:1409:b0:650:8923:5640 with SMTP id 956f58d0204a3-65089235e7amr877472d50.64.1775592169697;
        Tue, 07 Apr 2026 13:02:49 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:49 -0700 (PDT)
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
Subject: [RFC PATCH 17/20] tools: bpftool: Add documentation for landlock_ruleset
Date: Tue,  7 Apr 2026 16:01:39 -0400
Message-ID: <20260407200157.3874806-18-utilityemal77@gmail.com>
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

Add BPF_MAP_TYPE_LANDLOCK_RULESET to bpftool listing.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1af3305ea2b2..48bf6ee36fa4 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -56,7 +56,7 @@ MAP COMMANDS
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
 |     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
-|     | **insn_array** }
+|     | **landlock_ruleset** | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..0fe391a3ce73 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1478,7 +1478,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
-		"                 insn_array }\n"
+		"                 insn_array | landlock_ruleset }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.53.0

