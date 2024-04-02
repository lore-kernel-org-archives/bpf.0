Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854839AD5
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042953; cv=none; b=u+p2rrkKpCAoCc3KY77m+hTTEC2pE3MJWo0jo1zFImh9PPUAmFBG4HOp1jEEpWdl+SSMLnUTWycapuNrK1+yp/wmXb6wRCcjRjU+FmrzYvDVjTBMgchNx9r1C0BoXZ3mJxMHSt4dHRYlqi0iv5NtFJzg3jVVr9bbBq3LafnZP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042953; c=relaxed/simple;
	bh=0HOjYlHvNBSRuUhYW0SajKudUNUlUHXhP8aC5/HHqRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OH3ftYLwAMFCc5pO0pTWKu2UrTCRbCg40+LlwHEoEhv/y+OdJ8oyj70qU1ZraMkHp8XFjjbh0l1gfxmbsRiYcUpXJtPpvCfmNnjlZ4A0pxZkUykW1h2Zu/kMuopBfr1YSBZmyeG3YTYD3WPZQGScTZlMjC2m4AXMNcmGmqqzAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V7zyf6DcFz4f3p1d
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 15:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 396AA1A01D2
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 15:29:07 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgDHNQnBswtmXEf_Iw--.62268S2;
	Tue, 02 Apr 2024 15:29:07 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Skip test when perf_event_open returns EOPNOTSUPP
Date: Tue,  2 Apr 2024 07:30:29 +0000
Message-Id: <20240402073029.1299085-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHNQnBswtmXEf_Iw--.62268S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4rArWfuryfAr1kWF18AFb_yoW5Jw1fpa
	97JwnFkrWxtr17t3WfAr4DXF4rKa1DXFWYkr1fGryrArs7Xr9xXF12ga15Jrn5WrZ3Z398
	Zw40qrs3uw4DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUoOJ5UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When testing send_signal and stacktrace_build_id_nmi using the riscv sbi
pmu driver without the sscofpmf extension or the riscv legacy pmu
driver, they encountered failures as follows:

    test_send_signal_common:FAIL:perf_event_open unexpected perf_event_open: actual -1 < expected 0
    #272/3   send_signal/send_signal_nmi:FAIL

    test_stacktrace_build_id_nmi:FAIL:perf_event_open err -1 errno 95
    #304     stacktrace_build_id_nmi:FAIL

The reason is that the above pmu driver or hardware does not support
sampling events, that is, PERF_PMU_CAP_NO_INTERRUPT is set to pmu
capabilities, and then perf_event_open returns EOPNOTSUPP. Since
PERF_PMU_CAP_NO_INTERRUPT is not only set in the riscv-related pmu
driver, it is better to skip testing when this capability is set.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c            | 2 +-
 .../testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index b15b343ebb6b..920aee41bd58 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -179,7 +179,7 @@ static void test_send_signal_nmi(bool signal_thread)
 	pmu_fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */,
 			 -1 /* cpu */, -1 /* group_fd */, 0 /* flags */);
 	if (pmu_fd == -1) {
-		if (errno == ENOENT) {
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
 			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
 			       __func__);
 			test__skip();
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index 5db9eec24b5b..0832fd787457 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -35,7 +35,7 @@ void test_stacktrace_build_id_nmi(void)
 	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
 			 0 /* cpu 0 */, -1 /* group id */,
 			 0 /* flags */);
-	if (pmu_fd < 0 && errno == ENOENT) {
+	if (pmu_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
 		printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
 		test__skip();
 		goto cleanup;
-- 
2.34.1

