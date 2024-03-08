Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4622EE5
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860130; cv=none; b=gJPJ/LfI7SCUxHPsgtq1XaNnQDh3uU2uis5YYPTiHh5qyumtFAoeWqI+HCeJMliuWFJobcaKOkVx/GwKBu2xapaZLjXWybgQA4rCenlEjBHiztVhIPIA8iFtUaj3yny78WaVlDnsd9gv5BsDN7fEZEb2iw/Im4YYDvvxUUGgHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860130; c=relaxed/simple;
	bh=ffjjIayai5tg69x31nDL004HLHKJsxxL7JQG7lYF5P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mv7nuGpOxKyIK218GJ7/EHrNCbgPj2T68YOs9m72u6mQycGX0xvDwFonx3HM47wShjuKttXCTpwIyxmAKLahcyI6k7MBq2H1IzIrn5h4lOK6lvFqmAim3dpCSCYfl4cY2C7JpMbFaPUKZa1Lw7E3O3+St9BsLqmawy0M88RQz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbQifHdo; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbQifHdo"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21e45ece781so263062fac.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860128; x=1710464928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82vZnxRJEZksxOTJNBwPOOHeDn+cA1sXhnKMXtW6pFk=;
        b=KbQifHdomvNglU6yI0P/pJV2N6PO4echKVB17qOItbQSY5qxC1xSFPKOs5HkJNCP9x
         HbnRhwkz7irUOCsEex7jxJD8ZpZ8VowUXf+2PfFZOzRb3zJzuv9dLcaehlmO3CDh/luw
         CBeVgMeBIRufc9u+K6FFTNx9Ya735vv+vfwTcCK0jS+4xF36DRgxMSi5nMIg2kSiK3sC
         mvR96sf8Ggwwq9wvGlqq7YtUGKbcleqrrAjwOwKhOTQvPlC6Tgrtc6ZT9hxUA45w6I2m
         INSNMxMKlwkQysWTM/5NfiJNGHlLRGjsFsZHgsyWeSMyXlNC61Z7/H2cvAy9udSO5MaW
         aNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860128; x=1710464928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82vZnxRJEZksxOTJNBwPOOHeDn+cA1sXhnKMXtW6pFk=;
        b=myjIVIAsFGHPi6hQKylJIWz7KTNCvnkhLQ4FMTM8MW7KWqpeKzC+kThCOvHo0mkizD
         lgCcPke+Z+1IEvyHFM+Qd9wem/ypiDR9/9MzvQhxT+tiub0BbIHy1F86Nh+PfoNfuUro
         ChMwNQ4us3WUbhInK9ySPZHgGoiHeI1Cs9WK8o7e3HhqNv9RQGSHaLQPT+MjRpHdPJ8J
         HwzOZcrzMqkPxv/cwQtRnLesLIh0vH3QLF57rTcegWyMs3xuNMw/+ctBXk8+tbMmyfJU
         Uf51i1JYFroyIMRoqn/jCXn0mpHjMaACXx+7SSQ5+mF2D743/DFaxlPWoLzVWFqKD93B
         ZIEg==
X-Gm-Message-State: AOJu0YykO1yMhCuluwT8Bn8VaAJCkyrPCE/kRrz751rcCiLazD5Ik4rC
	WeJ+Zk7QQPyYLBbhhrsyb/ciyR7XkJVwTGh17OLIjvOqtH1J3Ci2oCHIWZsY
X-Google-Smtp-Source: AGHT+IE9LcecZjYwM9XUozGoy2neA8EIUF8XweFFCrPSrAUddEDrV64m9mFgKcBpQzfDFa2QcLOECA==
X-Received: by 2002:a05:6870:d612:b0:221:6e57:ec3b with SMTP id a18-20020a056870d61200b002216e57ec3bmr1653785oaq.54.1709860128064;
        Thu, 07 Mar 2024 17:08:48 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id bd9-20020a056a00278900b006e60c07f551sm8433145pfb.200.2024.03.07.17.08.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 09/14] bpftool: Recognize arena map type
Date: Thu,  7 Mar 2024 17:08:07 -0800
Message-Id: <20240308010812.89848-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Teach bpftool to recognize arena map type.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 3b7ba037af95..9d6a314dfd7a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,7 @@ MAP COMMANDS
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|		| **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** }
+|		| **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index f98f7bbea2b1..b89bd792c1d5 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1463,7 +1463,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.43.0

