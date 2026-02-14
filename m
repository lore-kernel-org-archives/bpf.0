Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5891FF5E3
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771035087; cv=none; b=WPr05xN/aIIjpjYzYIG8nGFGBNo//IxYTSUgwdMo2bTlqJh6Hru01pfUXp9eeL/yjpDBBaoeS8RczKNS7y7W1n8+gqVqLjOd/uhI9FvZt7WLq8vmA2bu9ygS07P1izeKSktVLyVvfZBmJBHXi4BZFWUcbG/kcVNRr3Dga4PzcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771035087; c=relaxed/simple;
	bh=XWJbVx8/g9nz+gfyGCnlr7J3e2lfXTPQQ9zgnIgqcKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeY0JhCkxDCNDrWam3GbYkW/3M1EWOzLtt9G6vT2XjNOOZcsLck7mrF6WmjkXUhxoPEIaZwZxViFXSuFDEdtlSh6wXOp389aQZAu6LiDPv6dJXt6VThNK1GLJwg5H8D5dw/sudblt0jPmTm/LjoD2xd89AeALeptEYaRbRKeLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=JRaqSQ8S; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="JRaqSQ8S"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89505dd3e24so19092476d6.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771035085; x=1771639885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6hoqFbbkZR24Psz6qYY4d7ZvIbcd4U40kPLSEcQEkM=;
        b=JRaqSQ8Sio2vddRm56TpqmjyrIQmczEYq8QbFxI71GeI9EP8AuY45EsIenwnvn5c0o
         dWerEWV0i9Zv/wqa962H3Q9Gmc/2SJF9nXE3PGozvOkSkXd9SEYqcnNtot4TfwacS7vz
         zzvAEE/HXQjykzwnAty4u197REoqCxRkT4ACnckdqJEDTR0+DKM8aW0qVaAocx+45VA3
         0Gl5f3bpuR+nHajSxP0005ymfwsbKvcTpUKLs1LjdgUmzWbLq4m+4V2SUDuQiWGoGtRa
         K3R8xmDHCjg+s/wfQ4UVa21lD0/EDsVSB24fnuU6oGw4MEEly1tAn6hsWdfePbwrUg0o
         /icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771035085; x=1771639885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6hoqFbbkZR24Psz6qYY4d7ZvIbcd4U40kPLSEcQEkM=;
        b=IrkAZGbc7YwMxJLDHp0Z0hkLIuHiydCo1ntPr9glzoPJts+ecuuFe5r/5MGwSMweG6
         uSzAbL8P9bIvqSx955qk3Rlb/LGsmUitH2CMsi5ht1PnWOodT29X5hcTqz4SOa3pbb/y
         q4vt0bT3NJmva2ptcMamQlqvgWSnyzvpx+dy1coHE/7q0yRtqRwDT8GGNWoPQgOAgGCo
         1bJWNk65FPuxQzNEODWambFy1/9gUONuXspxUdRQBX+nbFTJm4yNSjdGrC+rblk/H1tc
         cNWl8EV90wLEtLKDzUux4wUpgynEG02lunPbJfYgK0JtIAFQ5f+ULyQ8A1ppISNYdC7R
         rwMA==
X-Gm-Message-State: AOJu0YxMEpLY7IZQQo7Vp8JQwb3pauVOrhfLE0mRpe9jVFot2P/HiuRw
	OzDr3SS4N1WEaXg3qVc0oRkQxn67zmCO5O4rJkeCuXJO47bCVPbMakh3lSjrM8SKm1m2BOfjYF0
	ua4XZT8s=
X-Gm-Gg: AZuq6aJsYANpUh/+XVr9ApdoPt0PxYyAoTmoGUhAP8A0jrDroNXc6ZnDVFB5AkcaBLu
	ouJRFytNeY2dkAGpBRevl9EpusRsNRaTIH9yar2fVCUBh+RN1iuJtlZ8bS4+YbWiBVWBSqDfk8T
	u7eBlHHiLRXmO5MTuJco1zKKc0S44cC2kFUcC+uKVsTASOKsZ88RHBlzAE1LdGVtYVJVNQnmiQW
	cBQ1lpp+8tOeqPs7laE+KccIltPERs8hOtKIiTtkqOL815l+QYsNqhe1lSM0tCsRSoN2UAltqmH
	WEMiOGTLbvgm8S/Q603xbM+KPatICQPi5Q+SbYCP21MlGF1WM60nl6YugtRx1cqopytuYXYVydZ
	gzYnd0qyLXdPQLUnzBUJxYk5obEasRIl3lpXYmus5OW+iqHCaONg1n0DofZgRtjnSTkeTJa7Nq1
	EcdGSofyeqib+WEwfHR3zIRRkd/1DAVVQm
X-Received: by 2002:ad4:5c6d:0:b0:895:d629:5083 with SMTP id 6a1803df08f44-897360f4997mr55817096d6.27.1771035085472;
        Fri, 13 Feb 2026 18:11:25 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdc050esm94582006d6.45.2026.02.13.18.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 18:11:24 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 1/2] libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
Date: Fri, 13 Feb 2026 21:10:12 -0500
Message-ID: <20260214021014.15670-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260214021014.15670-1-emil@etsalapatis.com>
References: <20260214021014.15670-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 728ff167910e uses a PROG_TYPE_TRACEPOINT BPF test program to
check whether the running kernel supports large LDIMM64 offsets. The
feature gate incorrectly assumes that the program will fail at
verification time with one of two messages, depending on whether the
feature is supported by the running kernel. However,
PROG_TYPE_TRACEPOINT programs may fail to load before verification even
starts, e.g., if the shell does not have the appropriate capabilities.
Use a BPF_PROG_TYPE_SOCKET_FILTER program for the feature gate instead.

Also fix two minor issues. First, ensure the log buffer for the test is
initialized: Failing program load before verification led to libbpf dumping
uninitialized data to stdout. Also, ensure that close() is only called
for program_fd in the probe if the program load actually succeeded. The
call was currently failing silently with -EBADF most of the time.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/features.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b65ab109e3ff..cf3937e08520 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -508,7 +508,7 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 
 static int probe_ldimm64_full_range_off(int token_fd)
 {
-	char log_buf[1024];
+	char log_buf[1024] = {};
 	int prog_fd, map_fd;
 	int ret;
 	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
@@ -536,14 +536,14 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	}
 	insns[0].imm = map_fd;
 
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
 	ret = -errno;
 
 	close(map_fd);
-	close(prog_fd);
 
 	if (prog_fd >= 0) {
 		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n", __func__);
+		close(prog_fd);
 		return -EINVAL;
 	}
 
-- 
2.49.0

