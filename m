Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612774;
	b=juq7YeBXpP1DouJCG3qCGawOU77Ad23SpKQ5U/zZTVaC8/TITMtxAIqDmp0aY91wiTLm
	 GPGg2qY3nHG0r3LnAgXw/LLL98/gO6sRxny/gnRlBQ/WL1oNpbmvmICQKT3iapD6IdGod
	 ktijqHwlKtRaHKxh4/+gb7dQS25q35m/DSihpxQnszjBn5F0ZW8jGDi8onqDYoH3WZSWE
	 MB9Seyb1IORhyvO0dQZookkLnVPBdVrAxZTVJEQlYcRtvtNK+zVuvmneccU7NDYUUqsbm
	 KxX20JsAw/DTjuWBrR7P/pjpTBQbXdmoCYTeXstGo50bG02o5qXwebyxb4zox5+Ml8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EWw7/1YfSaPjxjkdMidM2fyIbOFoLaRyXIcCuxnA6p0=;
	b=D2zZ46VpZX1mE+z1A92NPdS7wocPVA1hTvKUaaFXyA7J+ZFzbU7qsiAfzdFmi/ZZuK5W
	 MSvBCNcJZTaAvt/XGDhOXlnXkUkrbn6zoduTCRSK/DIFvO/Wl1cRAKNrpI2ECYgrIelVH
	 DXC+fzdwdeI+0BprlRn3Hyhegtb6AKRc8nrEVNiywkj1GIOp07Zf2uIJG9ERusa0y22vN
	 xcAagOCojDg2w1fnXulp9bYywE9WxaWEj8zUW+jhhi3idq5evOYojPwQ5WtcJTpV63Zh4
	 DndtqsVIqfd1HjTfyf0d297npJVVzdh+tmRktkQMfNzFuhpqnUcNzJPkukWdpmWcQXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D19F/osa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB7606A319;
	Wed, 21 Oct 2026 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D19F/osa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEA01F000C3;
	Wed, 21 Oct 2026 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612773;
	bh=EWw7/1YfSaPjxjkdMidM2fyIbOFoLaRyXIcCuxnA6p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D19F/osaO8u6rZpi8wEpsQY0Bxt3uJCEzTCt6jyFTXnzEcQdm8QxKSysS4Uy+Ofa1
	 ztaK2BP11cc7vmO11Hk+NKpsPN3gRTX6Hb2+ZbN7bKKYQENYCm9n8nmz1Uh+aacjyG
	 Gssw9rIx4ANuA7R5wDd2DLe4/eMGOgsek+ZDlSU2QFgUmPhc9cCBMz2LiIAEL++5Le
	 Zlo+vEt6mmCIwrThAsCyMQMSTgzkylLPNgPrOFHv0Mp2vJE25nZAaH2bLyThvMnscP
	 ROCM5JEtW/asy4vQXOB76rK9K1dxgcRL950iv9ceMHsuqrsMYV01CCr4CRPdb6s/aP
	 t/kXI2xa8AvRQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 8/9] selftests/bpf: Add faultable user page writes test
Date: Wed, 21 Oct 2026 21:57:57 +0200
Message-ID: <20261021195759.119421-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
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

Exercise fault-enabled writes into an allocated user page
and verify the written data.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_page.c      | 25 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_page.c |  7 ++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_page.c b/tools/testing/selftests/bpf/prog_tests/user_page.c
index 1b5dff2c8ff6..74ce52d726ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_page.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_page.c
@@ -11,6 +11,7 @@ enum {
 	USER_PAGE_ALLOC = 1,
 	USER_PAGE_EXEC = 2,
 	USER_PAGE_EXEC_ONLY = 3,
+	USER_PAGE_WRITE = 4,
 };
 
 static noinline void user_page_trigger(void)
@@ -186,6 +187,28 @@ static void test_partial_exec(struct user_page *skel)
 		munmap((void *)addr, page_size * 3);
 }
 
+static void test_faultable_write(struct user_page *skel)
+{
+	static const char expected[] = "fault-enabled BPF write";
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		return;
+
+	skel->bss->user_addr = addr;
+	skel->bss->action = USER_PAGE_WRITE;
+	user_page_trigger();
+	if (!ASSERT_EQ(skel->bss->write_ret, 0, "write_ret"))
+		goto out;
+
+	ASSERT_EQ(memcmp((void *)addr, expected, sizeof(expected)), 0, "written_data");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
 void test_user_page(void)
 {
 	struct user_page *skel;
@@ -208,6 +231,8 @@ void test_user_page(void)
 		test_execute_user_page(skel);
 	if (test__start_subtest("partial_exec"))
 		test_partial_exec(skel);
+	if (test__start_subtest("faultable_write"))
+		test_faultable_write(skel);
 
 out:
 	user_page__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_page.c b/tools/testing/selftests/bpf/progs/user_page.c
index 38f6fcb89bc6..a855b0b46350 100644
--- a/tools/testing/selftests/bpf/progs/user_page.c
+++ b/tools/testing/selftests/bpf/progs/user_page.c
@@ -11,6 +11,7 @@ char _license[] SEC("license") = "GPL";
 #define USER_PAGE_ALLOC 1
 #define USER_PAGE_EXEC 2
 #define USER_PAGE_EXEC_ONLY 3
+#define USER_PAGE_WRITE 4
 
 int monitored_pid;
 int action;
@@ -19,6 +20,8 @@ long exec_addr;
 unsigned long nr_pages;
 int write_ret;
 int exec_ret;
+
+static const char data[] = "fault-enabled BPF write";
 static const unsigned char insns[] = {
 	0xf3, 0x0f, 0x1e, 0xfa, /* endbr64 */
 	0xb8, 42, 0, 0, 0, 0xc3, /* mov $42, %eax; ret */
@@ -43,6 +46,10 @@ int user_page_test(struct pt_regs *ctx)
 	case USER_PAGE_EXEC_ONLY:
 		exec_ret = bpf_user_page_exec(exec_addr);
 		break;
+	case USER_PAGE_WRITE:
+		write_ret = bpf_probe_write_user_faultable((void *)user_addr, data,
+							   sizeof(data));
+		break;
 	}
 
 	return 0;
-- 
2.54.0

