Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1C38424C
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468189; cv=none; b=EJz7aT7zWrM5DvrDhMO3DUMbw4jm3o74HrtW+cbSBJL6hadKJTGLvLB8OTaCUzel9uUtNHjE4YJ0OEL7v24+NgD9GunlbXqlOvV63Z6L4CR08N3q+q+CTFYB/92D91EbNiI9JfSavfzKxXzi4HKXa1RAFMuplJ4j11HBfBCCWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468189; c=relaxed/simple;
	bh=TduKdUdvpYsx+vKoLKDJFnx+p27z0gNvFZRpqUeStXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAKy6tXvqZyzTkI6iA+K9cha799ItyvBRTh4Ii5sUyeoj1Z2qii4IcOTpO5KGBX3MuSlxXLXsxSiJkxI64/7oX4d/xWLdqSxL0Xqe8AT4Le1DdjtJ1riXwB89lSf+7ErQZiKyzDi4x60N+nVy+m0z2JtPMNQmrwTXkE0Sdqy4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgA+Nroi; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgA+Nroi"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14129667240so3295578c88.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791468187; x=1792072987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7aqRldBbUb2LjnnslvdppdHBI9edzN43tyUFwloD4yA=;
        b=ZgA+NroivYLmwYCmihSkftwc+M9q9j5DC5gsVNeg0DpNXdiVN9DR42O2+aA0VH/imt
         T/xqkZCKnde2JPQtOjfXzvXB2b7R2c9CiJPls9zxJ3mlPQOjXDUsoDbPTr0m0duBuRUW
         I2hKOghtbmeCpvXZCpMvu4O+NOROV9z/J13Jx7cC7T4QLRF1PgEr/LkpW50Ebxy2lwt5
         BiMq1GII/+fpP52XRLZ55jQOzJPpRA2wCrpxLn8KPx444YDTjZc4/swFwi8NVZwhHVW/
         e32yzXZs1G6UKLxwDV6zsqK0YdJBNx2GR4kdunR9Vxy2meXheyIlLjuJaSWQy4jqODow
         rbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468187; x=1792072987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7aqRldBbUb2LjnnslvdppdHBI9edzN43tyUFwloD4yA=;
        b=FutxBcU3FEERKiPQsJ5rd/CmiY/WkPfusrUnattZsIU5vrG5k14sP2iUKQIH+FWK53
         U4+OqQpx4iF7DjNh9K00JYRoHCawFiGi8Nm9v8Reabp7fKG3toNfOv+0I2XYJtnqNlpv
         lR241u8Tz3l+KTHw4LE/tIfnBn743/XyfpiNNcsXJkHhNCIbPCU+wWZk6VefkjF+jspO
         m5R7ze8ECX48HVHYVYwpKXLalp9MLYWWp3u/vJFApTdfScZ3StviQHOg1p8fCHfqkd0g
         Dc71vaR4cvYRUdBcyTTsqoYXLxt/9N7xT/QV2I3tr0QXR5w0NQ2hf3kp06s+Okb3AUIS
         Qyqg==
X-Gm-Message-State: AFuF++lLwWqESXDjtomedH3oSQ+8L/VwPePO/+XK7nuBJxUDNjyOXpW6
	Q6uIlEaDQVYaZpMhEAuIcJa2RRi6KgkP4tm27fetnwftJpwan6sk7SES
X-Gm-Gg: AYBFou1e5L8gc9CsDOJ3OG58RA7Ku2DEYGuOEocH4y7S3UPY2rX/qh9j6Tj4f0rv662
	ggc9iwu5LUc0qIAFxNnJFBUuLxebVB656XDO5U/+cQrZyfITZonITNtUSEdjlU5cjjD313m7UH5
	i+MuKTkn/wh9hfI7ZKwMs+Jl4Floynl0I3Pa0rbTLZeJ3r5uYFsMMZ/kxT9JKu0LhsrNLD1vuDS
	QYkMsZUdSZAXzwmFW4JQ0KlMBSnQuDMHnzHvvBzl467FTtUXs1S4fS1gh1+L/x8AkirV2z2gyPg
	RAFGjRwoXOukDoyCZC6fH+x3Xkc5yfCKcalqSFn1hay3f30kcdR/xC7yAKwFof5xZscrq7gDrqF
	A3qeVrU3hn+ddRmSJWO28CsVnW0TJxEPd696gaqcA6mxJDvRCDJ9YAhKXOGdplaMUAJFFU5kS4F
	WXSXLI1jxPlxkN32L4gNs52TLtu8CP+PV99fSYSoe+TkGV1T0ifQuoypsvsB0UUuuAWxLJ6zCXI
	x3V
X-Received: by 2002:a05:701b:2514:b0:14a:5284:1bf5 with SMTP id a92af1059eb24-162043c7da1mr7015027c88.13.1791468186684;
        Thu, 08 Oct 2026 07:03:06 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616aa55195sm15973494c88.19.2026.10.08.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:03:06 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 08 Oct 2026 22:02:49 +0800
Subject: [PATCH bpf-next 1/2] selftests/bpf: Unmount the bpffs that
 cgroup_hierarchical_stats mounted
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-1-76b9a6d1be34@gmail.com>
References: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com>
In-Reply-To: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>, Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

setup_bpffs() mounts a bpffs on /sys/fs/bpf and records in mounted_bpffs
whether it did, so that cleanup_bpffs() unmounts only a bpffs that the
test mounted itself.

cleanup_bpffs() checks the flag the other way around. As mounting on
/sys/fs/bpf succeeds even when a bpffs is already there, the test never
unmounts the bpffs it mounted, and every run leaves another one stacked
on /sys/fs/bpf.

Unmount the bpffs only when setup_bpffs() mounted it.

Fixes: 88886309d2e8 ("selftests/bpf: add a selftest for cgroup hierarchical stats collection")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
index 3bd27d2ea668c..a93b16ed629e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
@@ -110,7 +110,7 @@ static void cleanup_bpffs(void)
 	ASSERT_OK(rmdir(BPFFS_ATTACH_COUNTERS), "rmdir "BPFFS_ATTACH_COUNTERS);
 
 	/* Unmount bpffs, if it wasn't already mounted when we started */
-	if (mounted_bpffs)
+	if (!mounted_bpffs)
 		return;
 
 	ASSERT_OK(umount(BPFFS_ROOT), "unmount bpffs");

-- 
2.43.0

