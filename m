Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592946;
	b=gXRmBeOI4mO/Oj4OgGdbAq61h5/C3spsVVLC1JLfWO4pD1sy3GDcrW3kO8sZeBgdC+0p
	 aRC6iF4lHoDAH8w77Bs1oQ+5nAKy7KSd4KqOLmbD+N/8uiLQvOhze/g+6TFGLCxqtsFIT
	 2qTmmXI++oN1N28ezr7fNYrwABb10/AGw6LDQAlqdjoPmc0Fp4AC96ft9VPP8d7JEOiB1
	 EP3L+hCbzYernm4rEfTnakFQkR+66ZJeEgyaZevwFajPXyNlg5lg5l8qQa6NaPaEG+1WD
	 y+09aw7lg7GnABZBodv0hsjiVq5RJa2yLuUCQyBeO8KtbmjqeXckoDXIKfVTu4bWaVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wLpQg5QcAg89Cohrx6Yev6AjF1ehi1341b5g301iJZ8=;
	b=4ug7Db+dIM7g10xjaI52HLMhdYg4VchfK22H6GzWf5oXWS05xnrJPpbWQ920ujAxq5bc
	 Zwut7mwOBARNvUkNaOxZRtgVvXSyBRyX5nybDjVRbR62ifusjn8T3OMrE3Irrx2IiB8hd
	 /Re2gl9bEMyd5TLkVC3aVeSQW0oCuV5SbEX+/yPkX2ceXlYZH1uQvgrgxo6DqBN1kq/QB
	 2ftjII862WHwwOMO8rcSOFu14fqtMYSZWKqaoXKV00j3PSO4ephcMmaiFKP4jDObC0poD
	 5M/wsa9/NWA1l5/1jc4VWIIa39lawQeA69glMxDWizHv3QyYwwojGGehhGcWDtOmM4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XGeQHk8Z;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43705606B46F
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 18:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43705606B46F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XGeQHk8Z
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36e795af1d4so894197eec.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794592945; x=1795197745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLpQg5QcAg89Cohrx6Yev6AjF1ehi1341b5g301iJZ8=;
        b=XGeQHk8ZO1dp9XZamtxcj2r2j6j4skWEmXGyEXYr7dFlvJL27ZBmdlz+SyuNiXAgOR
         xbIByzYO6KX4Ix85QHA+VnOZ7ZNIS1dhSLTbTOLRiVhr/shYi35xXVExkPy6CafjrWqC
         LDo3azPLy8TyMTWYi23rBhcHcTHJVEHoMMIuCBtuAyQ3TMc8V0Biy3MSsFvdLvpZ0VaK
         OgFhg0GhA7RaQPUClsAgz8QbgKp17GLTXGZnZR9798o/5yPaBcxD4TijVEzFTYtlBqbq
         B+vJvlCv0+gMz0wgrmjPgXpJ/tEtOQKOSJTgJJl90FnvHv3pjUGh3xL4i08ELLz4G54c
         gkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592945; x=1795197745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLpQg5QcAg89Cohrx6Yev6AjF1ehi1341b5g301iJZ8=;
        b=mWhi1TGPHXRMuNcP8pwvZns+91crJ3BpOtoXW3h2xPuwklztC6UH6nyC7nS9zkiiDn
         xYxcWMQGWjPp71Yd2ilWPAwi8s0nE/swMeRw5T9W2oEmS8lg2fhHKXFj9zfuz4kf3VL/
         wlBKj6DCGyCIo4pRIRQHuqUFRp/ionktiEsZUnLQlXE/hB9uFvNCHBa3CXIFS7wMbANq
         HT/W6y2s1c7nF1FFvVu/sqL7Q/rOed+xb8TWtmS0XuIuCcLlDpHLMfJv/4I7isa3JQjk
         Yx5zwakYmYw+ixLsuAaTHSPQwBbdsrCB9bcmN9osPH+oMqnth6gI5mFTi1o/sXQKkneG
         OZNA==
X-Forwarded-Encrypted: i=1; AL+hErGRUw81HBCdH4OuY1Iu/kLk7OcqG/DCh0YsYj/NCBuZDuCf/b31RQR7ZDAwJZMl58CG0xA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bxlhcvjiyP7u42hG+1HBQb7RjJ+OdqOrYh8ZdDuSM6ict/Ves
	11n9FRBe//lOf8KRv66FVOwhZb7IJ4HDGXYhoOEuevrqnL8Y2fSDJXyW
X-Gm-Gg: AYBFou2U529MreSdW1TySPdB9i8p8mVp2DcwmPbscKtEt94KzNWy4m7OZVvCfUxPrJ4
	pkCg3TgSTx1E1cjoKB4P4ndH88RZuPrtN+0Ule9zU29iQ+bnAoQAb8acaH0+kCpP8CuhZySAq7V
	N3exfHXGBTh01v6iDgauXaMUeKEbbYYYorp4b6PE72xjCbl6T6Pcsa+gh9qgyyWruMuS1NBiqEV
	iWdqoS2S2PvOxUFLzhjgGQMHKCjDvuBdOqOyehYas95HOfF3rIFnX7eziC24Q/w2CN7OA77nr5M
	tZ74EIJGWcczdjr/309Hh0z6ZW9Fj9O8H5G276SISo1GX32wMjpb8ytbKMaaAn2YNRXfJt6f/oI
	ra+NUx8nY4UYGzVhRWrJL9YZluZZXvulIsJsOU4R7sst+PaikAaPvSm9a8vbjVb1+j3lehDXjVh
	kW7vu+lR+vV5YJlZko/ytDSHkIUAL0o70KRJhptx1LuShwKnfnkhRzbU6Wgiqh8ggHsvn7LIgML
	mqyo0dt/csxRSqBaRlg3KBYTJVqJtLFst8/jeRF6XJ36N4jzUv05VdwFYbgMb1FX0Z2d4ZyADvi
	Gt/DOA9z5vfn/SQ0Qdganbxh8Y/+1sTSFzG0INW/BBDUJfe962yOEawVsoAjTnKbq6WCby0=
X-Received: by 2002:a05:693c:60c1:b0:36a:2473:9b2f with SMTP id 5a478bee46e88-377e1af6414mr5950264eec.23.1794592945251;
        Fri, 13 Nov 2026 10:02:25 -0800 (PST)
Received: from localhost (218-35-178-218.cm.dynamic.apol.com.tw. [218.35.178.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm8621741eec.16.2026.11.13.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:02:24 -0800 (PST)
From: Kurt Lin <lylin1023@gmail.com>
To: Hui Zhu <zhuhui@kylinos.cn>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barry Song <baohua@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Lin <lylin1023@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Skip memcg_proactive_reclaim when data lands in shmem
Date: Sat, 14 Nov 2026 02:01:59 +0800
Message-ID: <20261113180159.602033-1-lylin1023@gmail.com>
X-Mailer: git-send-email 2.56.0
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

workload_dir() keeps the data file off tmpfs because shmem cannot be
reclaimed without swap. But statfs() only sees the top of a stacking
filesystem: with /tmp on overlayfs over tmpfs, as in virtme-ng guests,
the check passes and all 32 MiB are still charged as shmem. Whether the
test then passes depends on unrelated page cache in the cgroup; in a
full test_progs run it fails with:

  test_memcg_proactive_reclaim:FAIL:reclaimed unexpected reclaimed: actual 0 <= expected 0

Check memory.stat after writing the file and skip when most of the
data was charged as shmem.

An AI coding assistant (Claude) was used to find and analyze the
failure and to draft the fix and this changelog.

Fixes: 0f9b1e9ef584 ("selftests/bpf: Add bpf_proactive_reclaim test")
Signed-off-by: Kurt Lin <lylin1023@gmail.com>
---

Notes:
    Tested in a virtme-ng guest without swap: with /tmp on overlayfs over
    tmpfs the test now skips; on a disk-backed directory it passes.
    
    After writing 32 MiB, memory.stat shows shmem 32.0 MiB on overlayfs
    /tmp and on tmpfs, and 0.0 MiB on a disk-backed filesystem.

 .../bpf/prog_tests/memcg_proactive_reclaim.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
index c22dcfabe856..c03550676041 100644
--- a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
@@ -46,6 +46,28 @@ static const char *workload_dir(void)
 	return NULL;
 }
 
+/*
+ * statfs() only sees the top of a stacking filesystem. When /tmp is an
+ * overlayfs whose upper layer lives on tmpfs, as in virtme-ng guests, the
+ * check above passes but the written data still ends up as shmem. Ask the
+ * cgroup how the pages were actually charged.
+ */
+static bool charged_as_shmem(void)
+{
+	static char buf[8192];
+	unsigned long long shmem;
+	char *p;
+
+	if (read_cgroup_file(CG_PATH, "memory.stat", buf, sizeof(buf)))
+		return false;
+
+	p = strstr(buf, "\nshmem ");
+	if (!p || sscanf(p, "\nshmem %llu", &shmem) != 1)
+		return false;
+
+	return shmem >= FILE_SIZE / 2;
+}
+
 void test_memcg_proactive_reclaim(void)
 {
 	struct memcg_proactive_reclaim *skel = NULL;
@@ -99,6 +121,12 @@ void test_memcg_proactive_reclaim(void)
 	if (!ASSERT_OK(fsync(data_fd), "fsync"))
 		goto out;
 
+	if (charged_as_shmem()) {
+		printf("%s:SKIP: %s is backed by shmem\n", __func__, dir);
+		test__skip();
+		goto out;
+	}
+
 	args.cgroup_id = cgroup_id;
 	args.size = FILE_SIZE;
 	skel->bss->reclaimed = 0;

base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
-- 
2.56.0

