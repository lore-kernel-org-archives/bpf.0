Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698808;
	b=fEpme8SW6TLB3Edk4GHWwiid5Y0nQGVSDJxpPEnh3/kk9V0OcVp+S1KalQo3cMBTeULH
	 JTLcSIfZvWSMRKpTGZaKVZ+l0FLZ1XnMEdSUdfUPfZfdpgwW7+Wzt+nAobTRmFoSKVM1O
	 PvAFxotdXmCs3KtvRx8C/Uo766M9CN2lz49wUmsEFuRZWSQblGR8u2xJ9rQpovJOdEFk9
	 iUjiyRFh0GUYnIy6PtavcXqnjQS/GZRacGcB7BOPjdjjtZ07lwrr4omnozk4DJNDMoXHm
	 sBUdfaU9jCdhsurbJDGYPiB9cBvuaHQWcNKY/p5XZasJ4L8i2wYZHBS8mYyZHG31lEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=daRFrpcIrlH42tetS90Eak1tlN3MgASpqpr5j9a3ui4=;
	b=vC+BfPq+NS5xWd3uql7WbQqjtNAKCrHNnjsu3E6zmT27aBm4C6A4ZylmguLdObXFN5LF
	 cneWSIYZFKqqBowwZcAiIHjOfnC0iPLLSfJDpvSbnwzsFEpInLR+r3BDKp0GFDTnZ5Qqd
	 biuviz1VyNSHnYrPQqHK+O6bSi/9cN87HvVJmSNlcKUuojsrgViYK95dWdC44Sv7PDxLD
	 uanHxAldyOopb0zZ+tbl7aInj0X8esjFICe4qqCLejrEgGCbLxkfVmmpffpc3QZsJWWY5
	 P+zM9dy2v0dk4ZP+7CIaLrT/r/2XaOX0FplXDoHW4o+pcywo23lFjC2f4lJmH7AiRcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxyvLAly;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AD606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F5AD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxyvLAly
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so5730941f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795698806; x=1796303606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daRFrpcIrlH42tetS90Eak1tlN3MgASpqpr5j9a3ui4=;
        b=mxyvLAlyUVE+0osyMFx67YYa0114KEwR80/ILtfHiAA06149BQAbxGOFGwWpKis++i
         vp/WieV9Or02ciaLI4k9Zs5qsmgIlb/CsH3RIO7OwoxKTisggAGnXAnlr2P19JR6e5UC
         cor3LpmMwQUU90h7Wap+H58UpLiodl+V6i9RHC1hNiym5ndproAqi0U8+aHpRyxlwuSE
         j7zj23IKUlSx0v9T+mNXDatA6LhXuIh4K0RhA/ay8rH9ONHZTZd2RTrWPft17ANAjRo7
         wIsSC+bNTK0oamz1+AGbArsgfr0c6o1rRyY0yl4Ir1n+pURb3OV0cGqdh7jdOQ1cgc3q
         kLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698806; x=1796303606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=daRFrpcIrlH42tetS90Eak1tlN3MgASpqpr5j9a3ui4=;
        b=Mjo9w7ardsgwGM4hdvGS40Jfyi4NUwbO3x1wdQyB05CL/Wbob+ONifLKBUdJ4KQC4s
         l+hHlsGlhT6ahH5LP8kD3rFxYLC0iCVPBtIduMI+GeAQaWqtYhtml6pRWGrA4v9yiEF/
         S7nvbRf4MSyMzmBMfEmY8FwxBvvuzP6RifyT2Lk28YPYeyjQuaUn+fAZDug/ZlOp17GR
         vI8/FuIxWzwb3jza2LuN5bRkMPJYM9A3SCkgRT/4ti5xq8oT2kbekAYyUyaK9zsssZlM
         ftlrGruAUwfZSmmMobUhNqHKTWSjxA2r+eOccYS/pM7z6m6MGsSQdrNRfHrLQFPsoPz9
         vh4Q==
X-Gm-Message-State: APuU4Z/s/hnGr9Uelt/9mXZU1c9rRM0wZqiNmKEe2BUlCbeuISc3cMMG
	TY7CkKmxguirDqkBzc2FdoGJ92sWxFITtmxnVgC1GQLYteNPDbyyEffRGIESSwQM
X-Gm-Gg: AZFdTZcOgcHtCusSaOKcEz6fIUrdExdEqskNj6q5QG7vRRCDMIhoCcPndQBQvESTVVL
	Ve8sG95Bw12oStjeCq+tUm01swhmsIgozVnZtQ5w3axS9yspnQxsOIymOEWIJggI93Spc/jlBW2
	9GwYghoiU8CYWk4qzkiK+9F4undi/mfC4xNs2i++FsVnM7ZRUieQjc8SHw+IWTai4gCb5NS+PRG
	EFBUZYcQt/Kvz8NFQQtzSJDUKMsgrosT20XqZdyKq3jnHoswyZZqalyy6cDHh6SjyHbqAhWz+UT
	lKnoRUKf7kaKXB3xLsemPwgMqnOR+oa0pl2jbbfAN1pR9pjn1rCvsFb5LT6EymFIUYOxgZoLIVX
	yUr8fIBS9XzwaDqpcX7UlPbPSImFtbh3mpDhpJV6Ha1ylWM8a/s9J92c+xWAoa4oDrX5bdxnske
	YRkOIFdZ/HivQvSK1G49DXLZeEUBA/1yoWAXKeuoqci3lOpXkypgDGgi5GwjrVkWtR/Gc8Q/5zd
	kUmemoH21e2irg821cPEg5NQXSAoA6FaWGEeMEpbgHb4O7mwbwoaJuZEFpsra0foYwH4DU0znFf
	yE/A6l7BaGO/cFvNCCBmskJ5nV2UlZYm4tkozPIr4Fx2xbpBD8qljLPYmJVw23IyM3Ig285GVso
	y
X-Received: by 2002:a05:6000:41d2:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-4abb0c5d65amr39924027f8f.18.1795698805751;
        Thu, 26 Nov 2026 05:13:25 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm41679091f8f.58.2026.11.26.05.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:13:25 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: test task storage memory accounting
Date: Thu, 26 Nov 2026 13:13:18 +0000
Message-ID: <20261126131318.470837-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126131318.470837-1-mahe.tardy@gmail.com>
References: <20261126131318.470837-1-mahe.tardy@gmail.com>
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

This tests that the memory increase as we add elements to a
task_storage. Copy the map_memlock() helper from arena_mem_usage.c.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 5b2b56cc3a4f..1415782ad72f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -495,6 +495,65 @@ static void test_uptr_map_failure(const char *map_name, int expected_errno)
 	uptr_map_failure__destroy(skel);
 }

+static long map_memlock(int map_fd)
+{
+	char path[64], line[128];
+	long memlock = -1;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", map_fd);
+	f = fopen(path, "r");
+	if (!ASSERT_OK_PTR(f, "open_fdinfo"))
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "memlock:\t%ld", &memlock) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_NEQ(memlock, -1, "parse_memlock");
+	return memlock;
+}
+
+static void test_memory_usage(void)
+{
+	struct task_local_storage_exit_creds *skel;
+	struct bpf_program *prog;
+	int map_fd, task_fd = -1;
+	long baseline;
+	u64 value = 12;
+
+	skel = task_local_storage_exit_creds__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* Just load the map */
+	bpf_object__for_each_program(prog, skel->obj) {
+		if (!ASSERT_OK(bpf_program__set_autoload(prog, false), "disable_autoload"))
+			goto out;
+	}
+
+	if (!ASSERT_OK(task_local_storage_exit_creds__load(skel), "skel_load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.task_storage);
+	baseline = map_memlock(map_fd);
+	if (!ASSERT_GE(baseline, 0, "baseline_greater_zero"))
+		goto out;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_OK_FD(task_fd, "task_fd"))
+		goto out;
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &task_fd, &value, BPF_NOEXIST), "update_map"))
+		goto out;
+
+	ASSERT_GT(map_memlock(map_fd), baseline, "memory_increase");
+out:
+	if (task_fd >= 0)
+		close(task_fd);
+	task_local_storage_exit_creds__destroy(skel);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -521,5 +580,7 @@ void test_task_local_storage(void)
 		test_uptr_map_failure("empty_uptr_map", EINVAL);
 	if (test__start_subtest("uptr_map_failure_kstruct"))
 		test_uptr_map_failure("kstruct_uptr_map", EINVAL);
+	if (test__start_subtest("memory_usage"))
+		test_memory_usage();
 	RUN_TESTS(uptr_failure);
 }
--
2.43.0

