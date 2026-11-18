Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973748;
	b=fdSWLomSZWHDkTlarWB4j86wtFiPxx0UtLwy5FkwPX2TrpONg62NYY9Blas3fToC500I
	 W2NN7a09MfndAJ/Nt0tddSsqlfkS7FAgVmfa9TJauKbGnOvzdfN+4DiYEy1mwXTcqGJ0o
	 mnlR82efPikoaRHdxlo4gNUg1flakOTgySNAPEguHnhwr92xohmmWM+b14gayVe/3rP3b
	 WqvvPiPBa0BsMvFfMHiV6o5O5IGLNzuSM1OFMZHzShreNUN9TC2ydmNEeGaqwj0MZMf/p
	 +KyjqPDgxNKO5IZncsvBHj5xz0zLyeUiOwQI1cxL00H5hhqtBPQZ2hCnQv4ICqCHFKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=IGZ1LY0R7muEviWN7fb4euvV9psptmj/QGERpFprukU=;
	b=MdAKfKQ1MbgmurTx/jmz74RqZUqcq8uRE6oxgX+3jIaFDjQUAhIA04dvK8tfTZY73dmu
	 rEjd57G19bKcXWpwQz0bjA4xWE9/IQ70xuUug2naAfLMtz4qNxkcj5ZMTcv1gcgCFcs7b
	 Z25U+gWehJiF9GOxBSLhcTdp4SkiQs6fOW3S18ZgqYuUMPJSngsMrsir3C+vGSPK5p/ZJ
	 pLnDzJo89tFHYLabJf55n7QLgMQAQmg5nTauHvK/qEHV67Eq+NW/LFzvLdNEZGmQ/iGNv
	 F0MQhQNHzbuuGkR29UaYp1ekDpIigO8rOSReVvd+1Z6yDFMGQnd4dUaL2S9TDoNsUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPeUg6R9;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB9606A325
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 03:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99FB9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPeUg6R9
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso241071a91.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794973747; x=1795578547; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IGZ1LY0R7muEviWN7fb4euvV9psptmj/QGERpFprukU=;
        b=mPeUg6R9421yjKq8HMJfXGFNR/USS3ajLsGgaBCPa0Q8VD7nlR8WjXM7Z0LUUEYO5b
         zlu1yzTVKPYq0F4/VffGAv7KubezEqz7lZxCe7VznHjTq9Mq7O8DAHujtwQm6COtW2aV
         9YR0hsFNVrx8akhxKC3YqjyEJq36tFpF+fweqCJy4jfb8exhV6O7P6Jd3zVYk1CSIuTy
         IBIfd4mp44R6kJ9u2l7R3+H3QHsKPE32fiClZIWvfmkwDo6U5Idx3aulU1TrFCWdoC4i
         nwST+zuFxDOdrUK2FjQ96XHNxlkLjyZnVV/eUhz51A1LJdz3gwQEWTXKHNraRj8ZXxuP
         ieSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794973747; x=1795578547;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGZ1LY0R7muEviWN7fb4euvV9psptmj/QGERpFprukU=;
        b=VkOEbahSrfBTEF/kmSz/cqgfjYuvYlXTpXiI/LwDaDMAQgZswvqR4JJAL7b+F3UjAY
         hP6me3Pe/jpKyMvqvXtsFrOf5+klMz0B4nSc7hjePJHtYPFldzlVUQmKL5r44zfgnJXC
         yjwmWVFMyn5F4r9qFCyogHBTozRfO0ZZofYdPzqBmxQe1F2CkqbV/KH8zwCmLg7vGApr
         GvMgbHz/OhUV8f4QCCqcYlbxWZ5BCQGn9f6h/HNHRBn/K2DouzZkkPnimQkvmmQ8BRZI
         lCe3eRrUJP4Wr2Kdx3BFra4i4VlkSAE5S5a4hGg9UL+KF2dA6MjiDiUMA91iLR666upL
         xEFw==
X-Forwarded-Encrypted: i=1; AL+hErHLVkfWllYop4+j4FcDeWxUk0Z22Hu31ZMYZvQqHdSkkSj4DBdKXrpgVoSUhGJaYcp+ikA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OqcVaJjcoThCBbua+SA59c9O2wk1Lh+VMcdU9x9HJZ7m8Hlop
	i5Iww581Xp7enpngk2RzRT6+0thXlJEso1OHE1V6hYCPU1pK2LdlS1B+
X-Gm-Gg: AZFdTZf32lVpgKbiP196QfOj6Qlwg5gMk8bsW+J8V8GvN4l+vFBO3VFpNqrDZ5XD1WB
	juTXxXnOXVofl106r47kXjKESBsRPDCaSi8+l1RE6VTiGWsSw7fK8Cja/WQTGEw9kbU63/akV28
	f1BCzZ53g0nD3TZD4RVJDPHzrse28v/Ba+QGcJUi3BcSlFj04pn9POHlY84MktyWm9XucwGVRck
	WF8k4VEsgoK36Xl+1+070nr127mL82dQYK2uUR4CBTiMDAsexjxob2B9RHclDRKBTH9L6OUdROB
	Zl2lRh4DjK5OW4Gxt+t/w+hWz/gR0615QjZad/8Gch48z3+GPqcrAVwaftGHPZ9KR5s1UGriqUq
	mXzbGx9/QCD9CHqyUCDj8Tm1XkE80rCyh+B/dbZbOjN/cLuR69k1u8jYbHZfNw6LUOnJmljPhPZ
	ES9QSEseNpEcTnLXpO9P6q+BT/34aUvJeYiCnOSdyDIyc6K/FurNJ1QFmzn4l7iadNJbh3e0VWE
	UArFxv1im1dTTTk2G1MzWLrpv+SWakXf8ZUSBM/KwFvVv69u72zd4YhcI9KwmPGhbm3qy3+hiba
	nAabH9OUvQvafjP5OBU3QydsGN2PHBcDqe82TlUc6L65MNYTPuVIahpq/v5V+9j7twP6E2K8cJB
	EMS7zJEm4xbmY49O9kTnTqOQb3sWLGyDUeQE=
X-Received: by 2002:a17:90b:384b:b0:3b3:be94:8ddc with SMTP id 98e67ed59e1d1-3b3d074d683mr1339461a91.12.1794973746755;
        Tue, 17 Nov 2026 19:49:06 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62930a5sm5279125ad.66.2026.11.17.19.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 19:49:05 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 03:49:05 +0000
Message-Id: <DMY136RTAL9Q.2WQSZ57W1YLV2@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kurt Lin" <lylin1023@gmail.com>, "Hui Zhu" <hui.zhu@linux.dev>, "Hui
 Zhu" <zhuhui@kylinos.cn>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Barry Song" <baohua@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fall back when
 memcg_proactive_reclaim data lands in shmem
In-Reply-To: <20261117170704.1146730-1-lylin1023@gmail.com>
References: <20261117170704.1146730-1-lylin1023@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 09:07 AM Kurt Lin <lylin1023@gmail.com> wrote:
> After writing the file, check memory.stat and move on to the next
> candidate directory if most of the data was charged as shmem; skip only
> when none is left. Give each candidate its own cgroup so that stale
> stats from a previous attempt cannot interfere, and poll memory.stat
> until the write shows up, as reading it does not force a stats flush.
> Fail the test if memory.stat cannot be read or never shows the write.

This is overkill.

>     To exercise the polling, FILE_SIZE was temporarily cut to 2 MiB in a
>     128-vCPU guest, which keeps the write below the flush threshold.

So the test with 32 MiB didn't hit it.
Pls don't add code just because a bot said so.

Here is what I mean. I didn't compile it:

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
index c76a7eb..334bfa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
@@ -53,8 +53,12 @@ static int alloc_pagecache(size_t size)
 	fd = open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
 	if (fd < 0)
 		return errno == EOPNOTSUPP ? -EOPNOTSUPP : -1;
-	/* tmpfs hands out shmem pages, which are not reclaimable without swap */
-	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC) {
+	/*
+	 * tmpfs hands out shmem pages, which are not reclaimable without swap.
+	 * overlayfs hides the type of its upper layer, which can be tmpfs.
+	 */
+	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC ||
+	    stfs.f_type == OVERLAYFS_SUPER_MAGIC) {
 		close(fd);
 		return -EOPNOTSUPP;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
index c22dcfa..2ba0791 100644
--- a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
@@ -30,7 +30,8 @@ struct reclaim_args {
  * being available, and a read-only mount cannot host the file at all (EROFS
  * applies to root too). /tmp is tmpfs on many systems, and test_progs is
  * routinely run from a tmpfs working directory, so both candidates need the
- * check.
+ * check. overlayfs hides the type of its upper layer, which is tmpfs for /tmp
+ * in virtme-ng guests.
  */
 static const char *workload_dir(void)
 {
@@ -40,7 +41,8 @@ static const char *workload_dir(void)

 	for (i = 0; i < ARRAY_SIZE(dirs); i++)
 		if (!statfs(dirs[i], &st) && st.f_type != TMPFS_MAGIC &&
-		    st.f_type != RAMFS_MAGIC && !access(dirs[i], W_OK))
+		    st.f_type != RAMFS_MAGIC &&
+		    st.f_type != OVERLAYFS_SUPER_MAGIC && !access(dirs[i], W_OK))
 			return dirs[i];

 	return NULL;

pw-bot: cr
