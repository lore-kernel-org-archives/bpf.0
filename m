Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601770;
	b=Xn6ek9PVNqpGbmCUhYI/DT3LuEa3Az0jtDnw3v7NIzWST6B2XI9p6M+x9dXs3PT96Lg0
	 FyjBayNt8X1pa7pr+WsPIJPxcNnfQCHjYdaA7xXFOO3G5ptL/+IaJBL9gAwr9qavh23lX
	 kYtJ3iZV/jMF8vTamjkf1MQf81LA+upvAisnQczYaE84aP7bWvcbw3xVQx4ZGoxVPtd5c
	 rUSYkuKZPcznERotw8JoxXzdj39jBvX3OPfLUnqDn9c8lM9geWx7/DeJsRNJJGkhW7yJI
	 9c2t6VZsRbf9vKcpL4auikq/7oIeFefRQ8+T36wXxPGZQpHhpPvYSN02LGuisufnU3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e4jmZWky7hVm1k8FDlf/p1uedI0muHl4WyEIYXBo6YQ=;
	b=hEg3v066IkjOVT6elUYw+npQAMjC3SZTK4CJ6GTe2iL8Up024nUU3aIELFWQnJg8tkvI
	 bl9xkoJeOC2BxJculF6NgbvbNIh6nJ4nPcTlJXWpuiLnbr5YeJ9dC+nuH2171A/By2Udw
	 vX++WoPthe9P1HfAYYcOr3LAJMgfShiq0wtPcCxRiBsG55dXNnZ8gUulHTz2VhoYC3sUK
	 VEfzzNJ2VCFqhSdZ3M4ZF61FHj75TU751TzlLq/yqk3R7f5Z9HzS3Asuq8of2cx4XpOBc
	 UPKDdfvEDwEqjeWLPlfywj/1GmhbQX+5O12Pxw94XzS31kDbhlicJ+ZgDMsfdwj71Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q/Z0MBoO";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981D606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E981D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q/Z0MBoO
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso14684145ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601769; x=1794206569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4jmZWky7hVm1k8FDlf/p1uedI0muHl4WyEIYXBo6YQ=;
        b=q/Z0MBoOiQ0BWd57rz3HG5qyBBeRUyU8TAHiqwbf28zQCgBrWUCZrLxlA2YC8MLZu7
         sTRtfYMRcAud+lvX+VnDqoAOppKHYyhb9ME6saYSEi3/pwBPpwcgvTJq8Sbo5Tl/29MX
         XBM70BoL37rwBjfRsZlreopHZLPWy2VBA023y4Bq3WiFGJTk8RVhVtrjX3vsh+S0JKrg
         oUNzcr+Xbh4JFOSvwIv/2UAIeej6hJRlBF1Ni8dSLG/cMzl406sJn77dy1alocm6ptWl
         JpkTaPEJequMERuVByKWtY184eDl10hoZryTVJxBB/xWLYhrUWVc9yRrr1akH1iG8KQa
         Ae3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601769; x=1794206569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4jmZWky7hVm1k8FDlf/p1uedI0muHl4WyEIYXBo6YQ=;
        b=HGv4SN2gtkxZP5u0ZMe0MwDZxEBFeJUvR6lq+TRyl54ntkdqBtCRfXFdrn720BJj0V
         Ty1jUDJSKpgownITZC3VX9XW90ZgmNh4ar1FV9xefJ3yMyk1+BsEhlhLrjhC6scrtDS1
         mrcD5WO6ldR+128Et+mU7u2m6lbJUS50G1QVZxpfeV58X36ET/m0iwiI/8ac10Po9pfm
         seeXth6H2ILKPfkxGpgi+AzpGeRlKv5sYXNyWfI857buuDj6AYdrorpyO97zuCivdvlC
         6HROy3qocKC0iUeoA+nZ/SrRCw11oR6N3H5HOY3HB7JjvZc6FK9phAcPk2xIN2HlEYyZ
         Rg8g==
X-Gm-Message-State: APuU4Z+d//1oXyGDrhZ6LKtyTkw0e7Xi9YEVgFKqb3h2b1ghaZhvhh8j
	FUvlxLtSjgcrtXBgoGLXvpuDx2LcvhtCZgYTZBpUJBfHVd7dCsQCNtVwSmhHVg==
X-Gm-Gg: AYBFou2FVEa8DJXTM+goXFrrGQSVfp3x+LkSHQI11W1RzNN4ZjU+Sv0OkXE8BIfRQZC
	S2b1gTtkkFT6q3o8LLltEvon1z8X3bM8nA2cuZBe6raE25T1fuuZeLBJgng83GuE8Z5D1MV26iH
	YC5Xe/6CFaizoA9lJtfLZ6eZ7nDZncjEVaaUaQqMhqNUAZVoNMMYPU4Ed9VxsRsevZHg6Ah7H0E
	7Uw4+LiwpP//P3S+AgbHWMUADK0frxZL6J545wj810DsG4vKdS7fh1dHmSV5JQTg00ifPBDBHCr
	GmY20WHpXiVFWaiPfxOAWahil1sFCQHyaZIlfBycP6hHxGemYmqB2j7SOoslFW8umL+tTTSqYMt
	oWdIbJBISoAGfVZjkaBoXjazWR+LNYc/mR1R3RxrBXZ+QzDkDUqCMw777rcWDFNZJqhez0r0r3c
	46ayrpzhc06tnJM1pDlNPGhifwA+qNHMvD2gheZaqUOhjUXNSzAW3+WV4w0pAz5spbcmuZli0BW
	xafO56IAxzOhOc5/ufgVp/BVNcM5FCmru0cKfkWUbNePsL5SzLXluCs7Q3KEPzuoUW8f+S4phHI
	ffWTQe2DYtfN1zQEo2A/qzp8DxCZ0MMLl6FfLI9wTeEswHXzwARV6uI7Vuq7+K5zv+wkih5pEXh
	pCggF02X3KK+8GUTx+xFhBrNotoMuD4IOZWP0mqDR8HYhmmQGHDKL5mrtPZeNsasZ5Z+bx71n5w
	==
X-Received: by 2002:a17:902:ea03:b0:2e6:943:39de with SMTP id d9443c01a7336-2eb3643ef53mr93249365ad.30.1793601769121;
        Sun, 01 Nov 2026 22:42:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052d7csm22450005ad.8.2026.11.01.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:42:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 2/2] selftests/bpf: Run arena_mmap serially and test MAP_FIXED addresses
Date: Mon,  2 Nov 2026 06:42:31 +0000
Message-ID: <20261102064231.2153879-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
References: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Each arena reserves 4 GiB of vmalloc space. The KASAN shadow of arenas from
parallel tests can exhaust the memory of a CI VM. Thus commit a14f9ba080c1
("selftests/bpf: Run arena tests serially") made arena_* and libarena*
serial. Do the same for arena_mmap, which the commit below added later.

Add four subtests for "bpf: Don't move a MAP_FIXED address in
arena_get_unmapped_area()". Test that mmap() with MAP_FIXED or
MAP_FIXED_NOREPLACE fails with EINVAL if the range crosses a 4 GiB
boundary. Test that mmap() with MAP_FIXED also fails for a range that wraps
and for a map_extra range that ends above TASK_SIZE. Today
arena_map_alloc() accepts such a map_extra. map_extra_last_pages also
passes if the kernel refuses the map, because no task can map this range.

The arch code gets a range before the arena code tests it for a crossing.
For the last two ranges LoongArch returns -EINVAL, and powerpc with the
hash MMU returns -ENOMEM. There the two subtests do not reach that test. On
the other architectures with arenas, the arena code returns -EINVAL or
__get_unmapped_area() returns -ENOMEM. Thus the two subtests accept both
errnos. All these errors occur before mmap() changes a mapping.

Two other changes of that patch have no subtest. With MAP_FIXED the arch
code gets len and not 2 * len. A 64-bit task on x86, arm64 or riscv does
not see this. LoongArch, s390 and powerpc with the hash MMU compare the end
of the range with different limits. In arena_mmap the unsigned ret changes
only the errno of map_extra_last_pages, which accepts both.

Fixes: 14d3e5bf9ffe ("selftests/bpf: Test the length and the address of an arena mmap()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_mmap.c     | 36 +++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mmap.c b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
index 2babc9ecf182..f55d950720f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
@@ -5,9 +5,12 @@
 
 #define ARENA_PAGES 8
 
-static void test_refused(int pages, int flags, int err)
+/* err == 0: the range ends above TASK_SIZE. EINVAL or ENOMEM, this depends on the arch */
+static void test_refused(__u64 map_extra, __u64 addr, int pages, int flags, int err)
 {
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_MMAPABLE,
+		    .map_extra = map_extra);
 	void *area;
 	int fd;
 
@@ -16,22 +19,35 @@ static void test_refused(int pages, int flags, int err)
 		test__skip();
 		return;
 	}
+	/* No task can map this range, so the kernel can also refuse the map. */
+	if (fd < 0 && map_extra)
+		return;
 	if (!ASSERT_GE(fd, 0, "bpf_map_create"))
 		return;
 
-	area = mmap(NULL, pages * getpagesize(), PROT_READ | PROT_WRITE,
-		    MAP_SHARED | flags, fd, 0);
-	if (ASSERT_EQ(area, MAP_FAILED, "mmap"))
-		ASSERT_EQ(errno, err, "errno");
-	else
+	area = mmap((void *)(unsigned long)addr, pages * getpagesize(),
+		    PROT_READ | PROT_WRITE, MAP_SHARED | flags, fd, 0);
+	if (!ASSERT_EQ(area, MAP_FAILED, "mmap"))
 		munmap(area, pages * getpagesize());
+	else if (err || errno != ENOMEM)
+		ASSERT_EQ(errno, err ?: EINVAL, "errno");
 	close(fd);
 }
 
-void test_arena_mmap(void)
+void serial_test_arena_mmap(void)
 {
+	__u64 page = getpagesize(), last = -(ARENA_PAGES * page);
+
 	if (test__start_subtest("long"))
-		test_refused(ARENA_PAGES + 1, 0, E2BIG);
+		test_refused(0, 0, ARENA_PAGES + 1, 0, E2BIG);
 	if (test__start_subtest("address_0"))
-		test_refused(ARENA_PAGES, MAP_FIXED, EINVAL);
+		test_refused(0, 0, ARENA_PAGES, MAP_FIXED, EINVAL);
+	if (test__start_subtest("crosses_4g"))
+		test_refused(0, (1ULL << 32) - page, ARENA_PAGES, MAP_FIXED, EINVAL);
+	if (test__start_subtest("crosses_4g_noreplace"))
+		test_refused(0, (1ULL << 32) - page, ARENA_PAGES, MAP_FIXED_NOREPLACE, EINVAL);
+	if (test__start_subtest("wraps"))
+		test_refused(0, -page, ARENA_PAGES, MAP_FIXED, 0);
+	if (test__start_subtest("map_extra_last_pages"))
+		test_refused(last, last, ARENA_PAGES, MAP_FIXED, 0);
 }
-- 
2.55.0

