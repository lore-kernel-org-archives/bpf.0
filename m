Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5237DE8B
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592153; cv=none; b=RsQwkwmH7/MizzeOgrd2/6+9FXT6HgThbFGyQvzpT+w5qnZ5KMbgJ8FFG7ji02cza+lydhg2v9ZMeuvL7X3GER+npLlrgxDI96n0x5rrrVylnQu7+ECj+VQL1u7xmD1Ux4dr/yxXgqcG1zyQH4nLvzmLjFyTQZHKmDC4zavrV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592153; c=relaxed/simple;
	bh=1YZm9Km2g/4He2abMJUbVPzWzEAy6t/GkzsPI6yRllo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iwb7ic/6j9DGGJalBwEWRhvIizbADZBdpsnJiEYw6YvGtk9F/1Sn4ai4RQY/SGRS2JOeXrZl6bdy6jaeX4/CTNQrHgM0/aYGe3sz0i1INbzuc5pnbGbJNi27Ta5f3YHZTvq+rHjN/VTT0XSWZ63ls8Ts+/w68foyhjb18blYgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1hQoGnJ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1hQoGnJ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64eaf8aa893so4743701d50.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592151; x=1776196951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxZmDGuH+b1o7aqh0lLdFfHGJTB8lb/1qma6OWy6m8U=;
        b=A1hQoGnJAesUcu46FkkvREJrsSP0xdvxPZWVSTNQMtU+QBo2g2ipB80ZEfn6/DmDvM
         Ss8OT6KR/dFarp9R4VpnYk1MDCQRby5EdKwqmkbnci0tyJ600mg+ukUr+K24w9L88nvm
         z4h3xjBPycKhxntAnL64ShztpOeGpAkEoPcRCc849Quc2SjR5xSeGGJLA1tAYloTJdxT
         /+qFrAGOYNToFQH+Bq/8/d1HxyfLk3x36vGZNci1vjHYM7RnUVCc6AwIzpw1fgBs697Y
         X7EIO4TDmrtpFn27qsGAZAHkskmnnJeL2+nyISBp4XjW+NljueNapKnLdq197PFjf7aJ
         LIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592151; x=1776196951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxZmDGuH+b1o7aqh0lLdFfHGJTB8lb/1qma6OWy6m8U=;
        b=Dmx1bxHSpRmAaDcLl+1ileBl3+E8N9DTqY5y4uSS2PMQGVySBLNHSfpZuPu7EkidEA
         1WZRrap1f58tZ9LfD0dJnL2/+Wvom8MaFlI/QI4UyMwU59S6TmnHvAq+8GboGg3swtNV
         jJ/qR3IeSjt3bYmOCIvr/EKNfTPX/qhAAxLnCXASsAXdBDfI/jXIAeuvEaeJ8ZYpDJSS
         2Z5UarGNWsNtTsidCoUmKzx4f47ygDP5ab14yGyrULfty/VfkqN3OrdBPrReMh93Bouj
         uXRnqwoUzgipVkm1/WEE8io0wjMsO7L7HX4ouJxJFbGC3I5kWUDO3t/m7+TMTud5dWLk
         mOvA==
X-Forwarded-Encrypted: i=1; AJvYcCUz7BO+DnqEX1vuvVgsStHTVIXL3LQRv7887X37B9K9MvIKl2oYL4dShB5tY6q2WC3DPQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHVDFKMTqPQe6bCtW623BFUHBjmOSpFGbgCG4RY7nvb3emOBG
	f9gb21atEJtJLo+5dJjyt9TN9LfM4fD85PLksuuH56MhzBDpM/W97NMH
X-Gm-Gg: AeBDieuRPSdSD05lsC8ljhXEmHi9GDUxxSrBcbKtzNBwCLFVMK+5e7XcreS7Yixd5lz
	NK18F9jyvn05ECab5EmPK7he4Q6BD9Peyd2ZwE1tkAhl/VjHtqnJUb/LhiXMrw7xVGvX7G5hoCt
	wIQElRXU46P8f6b7Hajsls1r2UaMJ2UrTvqSxUyC2Wmis+KanBLEcow5dmEekaQkQre9/3WD7dT
	JPF49HSOHH6ca4JBKheSRiIFKHhl5dFOUzqv3pIb56GWMjnLOfGvkEtMwQWxp3PC3YPu2UKdQjk
	mUWqKyGn3XeUysWzv7p1O73YQ/yIq2GwXKtt7qP8/V45fxF1cnUBakj5xrgcgSvOga25yaOaA25
	KdTDpLE4erBb3hYmfg6DD0QnHDYLJn9LRMlVVzBn66cw0V3VBcZqx8SabwmellhBdNNucgKrwcZ
	I+Z+rXMErNxaJ9K0DQa5qy0bvDf9YKtUcZf2GEIyJ8axkjjozdIE1Tdc1G2d61HTFrjyiSi8Dp
X-Received: by 2002:a05:690e:c49:b0:650:77e5:84e5 with SMTP id 956f58d0204a3-65077e58678mr6105788d50.25.1775592150185;
        Tue, 07 Apr 2026 13:02:30 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:29 -0700 (PDT)
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
Subject: [RFC PATCH 09/20] bpf: syscall: Handle Landlock ruleset maps
Date: Tue,  7 Apr 2026 16:01:31 -0400
Message-ID: <20260407200157.3874806-10-utilityemal77@gmail.com>
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

Allow userspace to create maps of type BPF_MAP_TYPE_LANDLOCK_RULESET via
the bpf syscall. If CONFIG_SECURITY_LANDLOCK != y, these
programs will still be accepted by the verifier but return an error at
runtime.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..e885451b64a0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -48,7 +48,8 @@
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
-			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
+			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS || \
+			  (map)->map_type == BPF_MAP_TYPE_LANDLOCK_RULESET)
 #define IS_FD_PROG_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY)
 #define IS_FD_HASH(map) ((map)->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
 #define IS_FD_MAP(map) (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map) || \
@@ -1488,6 +1489,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
 	case BPF_MAP_TYPE_INSN_ARRAY:
+	case BPF_MAP_TYPE_LANDLOCK_RULESET:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
-- 
2.53.0

