Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126C1EEF8
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974743; cv=none; b=AgSI7YrKoWmRzMcADhZeN+slKysPTWLfhwD7eUN9tALTKoBuSM5VNTHRAr2v6Mb59aQ1xdlPSevb8WwB5D8G7lU+YTRcjZqyb7YipCJmbPspBGeyGaFuVKtKfzDIDPxt2yZ7lZEmdR9Ioo6lgptyZrnBC0yDhpwvTMBAptJgxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974743; c=relaxed/simple;
	bh=sxRq7ZanfhkyquZato8lNdw8fEX5fe8y7pDyXJytn0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Hl75lSkvJCXdXxX0+vkZ2dPzwvaCjdSmaEJWBtsWB6XFS3ZZ10rOd2iGYQu+/fBclP6K7akOMMkqf4EAU3Y8ZMeKxP/sPtJKbFxiIO6ao9MaEvXAxV5KeEoGQMhDKn6fw65MYxx3alG+ubYmeLmoZRTNhZN/UE8pDWPxNCna/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V7Vkt1wbJz4f3mJJ
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 20:32:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9346A1A0199
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 20:32:14 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBHCaFOqQpmNsBrIg--.61394S2;
	Mon, 01 Apr 2024 20:32:14 +0800 (CST)
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
Subject: [PATCH bpf-next] selftests/bpf: Skip test when perf_event_open returns EOPNOTSUPP
Date: Mon,  1 Apr 2024 12:33:36 +0000
Message-Id: <20240401123336.1124715-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHCaFOqQpmNsBrIg--.61394S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1xAw1fCF4kWFWrur1Dtrb_yoW8ZrW3p3
	97J34jkF1IvF13t3WxAFW7Xr4fKan8XFWjkr18tr1rAr4rJr9xXF12ga15Xrn3urZ3Za98
	Z3yIqrn3uw4DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
	-UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

For the bpf selftest, the semantics of perf_event_open returning ENOENT
and EOPNOTSUPP imply that continuing the test is meaningless. Let’s skip
test when perf_event_open returns EOPNOTSUPP, which has already been
skipped in other test cases.

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

