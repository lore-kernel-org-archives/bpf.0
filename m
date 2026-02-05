Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2B32BF44
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323244; cv=none; b=XMObDbiD6ANHsgQNGVGobBQkabgh0PvQGAa+dxTC75BwNZq0d88gfv/lxqCdfaglWjivtw1ipm48K0PoM4WvsQn0Th1DJLt2/xL68CEZcei6zS7k00Tbhc2koq5n6cWxivYsWZLtTJOzyRd5kAeCH6ONipkLXVglsgEVCUrsSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323244; c=relaxed/simple;
	bh=/Pg3zJMJAxw2cKetZocCLln2GST1TQccC68mgrqFwoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6Le5MZHwHJ+/9XorfP5kDLeGDaUSEF7n7bdz41/hOL1oToO6cNIzLJCazwi0dCiwDeDOddT3GhvlbtBsOhnc94aw18hKKlcS802BuOGedSpy8UV4eVMBW36e+6bNWE+cu+e9g8OW1oSMfUy3FYjvfd4vRkKDCLuZKKZgjX+bnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEeGZekC; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEeGZekC"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso14382115e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323242; x=1770928042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybne09pfN8jB5zjYAMJp+qQlXwXcKMBu1tEQB0yCTSg=;
        b=NEeGZekC1srpBQLqYwesfX5AL7hG6k7Ev5BWQhKIaZyt5ysqYuj8AcGXtxUGlPF59l
         HhBtwhYf920K/GlJjnGgxZnooQMPKt1SEj6NGIpjuYbB5KfjK1U5l0MQi3SS3CWH9LAe
         5wvsv2UhRcz721ibPovRRIww60p8Fd3atKIn6PntcJmxumh5WCXRVVI4fCHQvEjVX7Q8
         BF0tIWkRKLznI1kxLBKAKXRU30d8NZw7rRJzhzxvRbImONWyrJgvU2ZfcA+iyFYQdcg7
         D8cBCizM740mMZ9AYNLxSkv9vxcoiNU6l352mkujgHl+nfN9RBOJfxxXiYeDqkO3crRS
         3jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323242; x=1770928042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybne09pfN8jB5zjYAMJp+qQlXwXcKMBu1tEQB0yCTSg=;
        b=KQUDJ6bWl8ZGMfemKwv0K5JOed98l9TxKRDvL5UlS7f5mk5SmQo/Z7P4hugq4YTRTu
         oF7QWSOgnEqctAOZLliGHtLl2H0IC02oJ9n/Qb4rds2YQM5fG223p+v4qy+f2QfHKjRc
         YV89wRKiNSTCnBnBPhlf9ufoSXuh+p9roCgwP7ZNwS4VWva1P6gpn80PDYdbCzGekq+0
         ubo9j7XzHrnDcTW70YNrsZrrQeiRHv+i6C8p0CmErfY9ydh2Jkfxa+PG/wiRTqJ62I3H
         PItxvmhO88wvRDfMae7FsT26wt/6ektUBQbB9Bbh+RfH2KjuKohct/kUuShLwQV+fw0Z
         kLsw==
X-Gm-Message-State: AOJu0YxZypjG7ISrP+Ypq/VN6TdFlCZOdFc9iJLFqA+h1XY1Y5n7aHvz
	7GkpzepsLXcXoKEGvU+HjVRlqPqcOW8J42M1zxQ/6SILHMBrFBLrIz1I
X-Gm-Gg: AZuq6aLsntekw3+8WJHXb7QiMqFEcVBByBbRh9axFFQF6Hj+fiTUqiee50OwhJmXr7H
	1oKKjUIU0rTudNQ03nIBoINx2SUYSk84ucGomJlw9m1NjZ+Gxi9+foX1s25BZnVXLxNLXSC7Eub
	Bx6AXz/PnqxYS5c6HrGP4euVFUbCMyKQJ5JK+phi2iqvRdoRyCCjuSHKPbmTfmPlgi5Wunxrfs9
	zatK/IvReCwz2hoXw46mqdNCRWsN3H9Xa0KdnMAnE+357FGTvysEd7xoWfxYNFYunMqvWB+nekQ
	ukKuI/B9ro5QKoQ29+ew09bHmintVnMO/VhcjPdc26kvwVV1xQxch/72pNI6Gg+VB7kz1/dUwDl
	/RDW4IX1SDjCB25udNi9wamWqbK783leXz/JJPUCdnld1OYAJ1BMzmTzLtApRoT1K8qZ/1bI=
X-Received: by 2002:a05:600c:4f81:b0:479:3a89:121d with SMTP id 5b1f17b1804b1-483209d06a9mr1367915e9.36.1770323241975;
        Thu, 05 Feb 2026 12:27:21 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a963sm67154755e9.9.2026.02.05.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:21 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:42 +0000
Subject: [PATCH RFC bpf-next 12/12] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-12-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=1782;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=CoDUZ9m6zOSfqCe+pry5a87DYfbWmnFLlvxphxuzm1g=;
 b=d6MCakptmrbH2kzAmKQPgsheR2qhivHG5y7dNmOWxUEvzbudPW/kzxm5gkLKslPpdpnr/pDpX
 11PyU06DMSwDuPngfVYaGdbkw3fZdNxPJxausB6aw7dnkNCL0ea7unY
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Make bpftool documentation aware of the resizable hash map.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1af3305ea2b2e396be9873483ef24877bc80b9e6..5daf3de5c7446a5b32328887ae7efcb2cbc36993 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -56,7 +56,7 @@ MAP COMMANDS
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
 |     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
-|     | **insn_array** }
+|     | **insn_array** | **rhash** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4ff62b63c84d3de1f95f540fe09e6..71a45d96617edbb85244260c05e572abb17369ea 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1478,7 +1478,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
-		"                 insn_array }\n"
+		"                 insn_array | rhash }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",

-- 
2.53.0

