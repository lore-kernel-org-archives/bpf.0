Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C288386C3C
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592175; cv=none; b=YXb2i/l5YbT1sj1M0JIlwSDDowWGBeEYpKihDyVaIQCrxTz5HRcFn6AQYs861lu8SpIw5ka/BjFqayCI3fcMlueNf0VMg6MX2IUM0IVvyvGPeDupksvwUHkF/orWCMV/S9JyVgsVHUp3GS4FXWSs+HDuQSrdygJ5d4OoWdhv6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592175; c=relaxed/simple;
	bh=vi5FjNFei0DMVU6UndsLw5X+Sug4/lpzBigVH5ACDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0AdJPRj8qulzUGRNAZsBz5WOnNh4T/yvAYnMSAAnbE1mS+P24fbfOEMYOMBSRIEM1C0WNIml7QV32Tr+KLyPqQ9QK3/Yoo8LP+zR7wP8ULKMNYu7grm6kF7jKsQEk+b1ySJLy13SkRTZbv4Q5/6EHZrrSoAeBaasMKGDTuZyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQD5IOG2; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQD5IOG2"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-650789b22e3so1728157d50.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592173; x=1776196973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67+cKnsUxsC8cUauaFfSWyXKAlrlKdFCay5MrA604yk=;
        b=FQD5IOG2tWX0D59HiO4K9pEDlYxhmVP4MpXfrNIQSwpTgJpi90+YdCCZixnUArZKcU
         L3wnhMNmFMRXeP+eMdZIimpxKcqGN7Za6dzqbYagzhJLsxNkkzN8Sq0qzpXA093l6Rmz
         5H5A6p1AgkNRnUMO0K1NhxEJl8LsFvmbILHHXH3LKTSJEl/jXjM+LS3cep+M+xtsDPzZ
         gfJEMffOVL0QVhSHcChaNnTKEF3SiDtCMugA2zOz6LxGvRRFIaFSE+C0+HMFfWWbX2K0
         e/B5aZeSOFOOREdPWldZSjSrSr5ICMbWE3KKG2qmR++ITiu/mZCA5hKiaYc2dzL3x32l
         QAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592173; x=1776196973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67+cKnsUxsC8cUauaFfSWyXKAlrlKdFCay5MrA604yk=;
        b=d35w6BR0l91N5HmLgsGzXJlWECDYLSvZBa9R7/08FFSBE50pP6RLrKIKb1p3vB2X9n
         hr8Q6hQQMXDMtDr4DAvUdxxTJAqhuVHcsMkMZSXa2W8LdhU6Wd8sPIGhgtbr9+BGq3Mx
         XVHlPnvBHJL8M7lXIImvWMN/yyz2RyTuKenng157TJF5hDE2TR7gdXYh2WOIWNGkE589
         YFOaN/eMRg6WmUaIcjnvsR9aT7JO0c/wzkxDIeHhDncABeobr3QoGN/8f+2RjnjgO0/S
         mvGstv4MrJ+zlY6QIjEdT/uZK/DkXuZBHjrKGAaH2lYCnUbHB2JyAdDqewNcDRM1xnUn
         9s5g==
X-Forwarded-Encrypted: i=1; AJvYcCX7kR0oi3sNmaG/oVEfLbcp6XghaF31Zv0l9tXizophTuoX30S+kt9ZBD97piKndoAF/J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FhIYB1F/K8L0gbx/8R8Vww/7ef4Sjn2D/GH9f+iYmLuPu2xx
	JPx9W/xPkf2OHVTSIJmi5k6cHuu+lrkKwGTSqARgsse5wD5chHLak5RV
X-Gm-Gg: AeBDietlu+vLAPGYsY9ZdHOycg+mGdChZhO3TzDd//1oCQmlGY0VYWruck9upbIdahi
	v0lNqiUrLReO5lLN1lDlDrxnFehS2jhVqdQPm5qHF5daTjhtLN1QBjDXzpeMPYqHxplXXenuzcb
	WUXI0Vtmv2b++gFCw2V74J11o0WQwCnW4u37JGxOCbKBwfPRghfJm8yo1j/0xv1yODbybtcCJmk
	5f1E1y3JFlKXTUCQO/k5PXqyVnA5lCfb5j0eeGLW8Rb3wgEexWV553kcILX/XjAOzNk6+ZxJZgT
	1FV/Uox+lrn4MEmDyuV+NTNRGkBhz0MVVeVJhdKhVqjyY7fSmtYaLrLn9Pa0XeuVuDhB5hYSNd+
	apnL240fLFqvr7dXPW/F0482tFm6dZY7CxFB8+tJpYsdhTKDtcqACz3sWHZcveyJQRcWxSsZDYR
	wAOFy2ePbvvH9uqKqcxmZ51q5/u/WthH2uN2mNWysdmiYayvfVuS6CBbdMvYb1RS/ZvqbL4pgP
X-Received: by 2002:a05:690e:11ca:b0:650:891d:e1a6 with SMTP id 956f58d0204a3-650891de307mr938379d50.51.1775592172595;
        Tue, 07 Apr 2026 13:02:52 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:52 -0700 (PDT)
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
Subject: [RFC PATCH 18/20] landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Tue,  7 Apr 2026 16:01:40 -0400
Message-ID: <20260407200157.3874806-19-utilityemal77@gmail.com>
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

Document the new LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag, and explain
how its designed primarily for BPF-side use cases for Landlock.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..82c88d75ef21 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -204,7 +204,8 @@ similar backwards compatibility check is needed for the restrict flags
 
     __u32 restrict_flags =
         LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
-        LANDLOCK_RESTRICT_SELF_TSYNC;
+        LANDLOCK_RESTRICT_SELF_TSYNC |
+        LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     switch (abi) {
     case 1 ... 6:
         /* Removes logging flags for ABI < 7 */
@@ -223,10 +224,18 @@ similar backwards compatibility check is needed for the restrict flags
          * children (and not for all threads, including parents and siblings).
          */
         restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
+        __attribute__((fallthrough));
+    case 8:
+    case 9:
+        /* Removes no_new_privs convenience flag for ABI < 10 */
+        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     }
 
 The next step is to restrict the current thread from gaining more privileges
-(e.g. through a SUID binary).  We now have a ruleset with the first rule
+(e.g. through a SUID binary).  When supported, this can be folded into
+``landlock_restrict_self()`` with ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS``;
+otherwise, user space must still call :manpage:`prctl(2)` explicitly.  We now
+have a ruleset with the first rule
 allowing read and execute access to ``/usr`` while denying all other handled
 accesses for the filesystem, and a second rule allowing HTTPS connections.
 
@@ -716,6 +725,15 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+No New Privs flag (ABI < 10)
+----------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to request
+``no_new_privs`` as part of ``landlock_restrict_self()`` by passing the
+``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag.  This lets user space request
+the prerequisite from the Landlock API itself, which is especially useful when
+the restriction is applied from an external context such as BPF.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0

