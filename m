Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1636F8EB
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053022; cv=none; b=LarMEiGoeb6oAc4mDXq3NPyU400vVks0kpmdu0/c+76wvxmE3iBCD1hZ4gznpL8jE+//T5XQlHaUXTGZpbgXgJd+yL2ndrf0U6i+2rlGfzWjwXy13vAhHeKM1J+0DW0ZLd4XSsS5mhicfTSWWYCZAo02lN7a69nopmXiivHNXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053022; c=relaxed/simple;
	bh=y4Z/Chbl8d1fW8FeQ7mLZsT8Hhkc5v336Kn293SDZZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkHupCqXP3kLzQJ5SZdQ7OSTzcZQxC2wfGnL/jocUAA7vyaH1E0eCLfBOZ+7gfjOESb+kZAW5nMN5L2N2VWRWg+JguMwSkuxwY/jzP9lIEfPyLrZTsUpsIyMbz6QS1Shr223M+TCz3SQw3nNqjiN/aWKlXgOlPS9WgKLlU307Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOZnn2rs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOZnn2rs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845385adf4cso1569902b3a.0
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782053020; x=1782657820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdV1fV0Fid/R2q9Vczf4SGtHhC3UkfiLS8XxvVVRGDM=;
        b=eOZnn2rs4WyGTVJWlz4pcHsKfd4vCu2zoFY0Khii+cQM8InNGlMbbY4m02ZiOaJ1f1
         XbGF/8D5ZE4jQTJvohk3w8yA2Gpvw+vSVecz3ZRSbrneTachoKZSHw7VvlO4Q99k9m7z
         D43Vj7tEOc3Qx+R7Hvz+IPutFjM4hQnisQ7+rGuTzze+YG0deS4MoaQhsPxBQ/UeXJOc
         tOP+zMWdpMNpTpA+zjwgEbPDZpRb/xMau4d8aXcqO5jC+1tseGhbNG8Gw77yEnY8Z/xW
         VEoPRyGt8T5atp6At/yKMJwyVJfMyNQRCEh7I4hMzSQXrFX3HQI3UpSKfgvtUslq+p91
         A99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782053020; x=1782657820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdV1fV0Fid/R2q9Vczf4SGtHhC3UkfiLS8XxvVVRGDM=;
        b=UwjqKyRXuh+azZSSC/OQTdPQCYmv+/ryuoLXi6vojrl4yqqEEk8Fhzo4z4+IxtJn6A
         m5IgRyuhqeAUS/4aXRqEOzb9hkjVqVubdqShz5kA7yx9LAe+H/XZ5Mc+QIEOzTBdERdE
         SDL9Ds4DdmR6uEaZ91EI65WcK45Keoi2kORNhuP1UXIYyzS8n5Wr5ii+/B44LtftZtN6
         QWmPlKZO3jY0PyW61CApdsxw8QBo/aneZnrm0YMOhvFthkzm5/R6hrmOxiTOBcOIGlaf
         /kMlDIEeznptanf+QPqqCpezPwAt3bQ5APYv17/fv6ZIXnk4V3RjuRhb3gtYypFTdqc/
         rP0g==
X-Forwarded-Encrypted: i=1; AFNElJ+nbYNBwCxU0ymPvi+PvYd9JiKyBaAEEIZxDVmjL3t1tvqczTYV9BgL07rjprI5hLxjurU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJ2I3SKIAkw+m4f6KkO0QXcM2FtCZqmYO+1ihL3U8castyYPr
	El0wf3eFo0VgtnACUB8Uks2ESlJqpU9VvfrkR2QwoilWsvei8YnDtnlQ
X-Gm-Gg: AfdE7ck5GXgAIL7r14yuh989o3gqDj2KklD62j62q+0AFuQdqPlruqlCBoEX1Ng+zzR
	F5t/Vl3kd19PfYOdsyszAjpGLU8+43d2M/QdgprHHVduQIvS6IAtPHrmquFpQ6kepJ1wTJ5DVsa
	bxESf8pzMlGlKZmCnNAaWAHGzrDYTS9a4hN+sKoMwF4WwClcfPUSZWkE6sPbUM6U/5wXBKkjq3x
	b1fbe6Oce0EbGpeV0+Q93cuCdEvKUIl7ZcDT7C84OAhkJuxTAuws+mH1W22txPkYc/cPDFvb9Ph
	VRe2zzzoke0tGrd+gCgYQGbtBRWzqhpBKWgjaO7ioDZYugtRDgGpq2YyD42wHzuoqlawn9tQeUZ
	jjGiKWc69GPC8+333qzk9Poncuv5lHH1BmB+IrGSPiWw8qnGnNGS79bf+1E/EiolorA4cFv1U/2
	7AP/0evcwO8rLX1lTbPoCJWkYJ5qtT
X-Received: by 2002:a05:6a00:1d97:b0:838:c01a:7a50 with SMTP id d2e1a72fcca58-845508a70c9mr10966516b3a.30.1782053019778;
        Sun, 21 Jun 2026 07:43:39 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7687csm4963254b3a.35.2026.06.21.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:43:39 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next 3/3] riscv, bpf: Remove BPF exceptions from BPF CI denylist
Date: Sun, 21 Jun 2026 20:12:59 +0530
Message-ID: <20260621144259.288135-4-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621144259.288135-1-varunrmallya@gmail.com>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes BPF exceptions from riscv64 denylist on
BPF selftests since support for exceptions has been added now.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.riscv64 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
index 4fc4dfdde293..9268351ce4c1 100644
--- a/tools/testing/selftests/bpf/DENYLIST.riscv64
+++ b/tools/testing/selftests/bpf/DENYLIST.riscv64
@@ -1,3 +1,2 @@
 # riscv64 deny list for BPF CI and local vmtest
-exceptions					# JIT does not support exceptions
 tailcalls/tailcall_bpf2bpf*			# JIT does not support mixing bpf2bpf and tailcalls
-- 
2.54.0

