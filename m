Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1312C1C84D0;
	Sat, 20 Jun 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.6.4.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968956; cv=none; b=kksnRggr3wY04YtHSyOgXIy0gvjqbW2/9u45p6TeLssvQH20/3/L63X6i1dWdvUcW7TGGo4W0hgVuGYqWZkHIwroWHcs4w42aL4t5ZQkzvVpHMTPNOGP7Vwv3gcKV4vNNilt3u4dmZAgf3cH97cEFBh1+S6x04U32OnvxZG55sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968956; c=relaxed/simple;
	bh=4p9m1msDK3bU97evrCsQ+r7S4l8iMW+v2i8aGdToC3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ig1Xzz0mn2ZCe1RkVLVo2ca8VO3aUi7tLBHS+sHEcVKb/grpXM5vIEbd3Wi2bsplnq0dtwqL4NsabK7W/6E9O9WeeVu1xFIQh4CDCyzgcw1mKpHhvfG+a/D7bY+njMZRhvSCwIaRLK2tOyF0Nau3IDkhyqbDvGxWkuA/J5DR8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=S/iMc0Yp; arc=none smtp.client-ip=101.6.4.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="S/iMc0Yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=teNqo3kD4fT6mrgdsjswaezWS+UsEK7JM6
	6SyQLcJZI=; b=S/iMc0YpNUy/Q3E0r8Dtbqck581pEBMvtQkmYPUKX8YsfGiGTC
	V5SImMeo90Nq6agn9+TBmgTNGsRkNoNNCccUSP2eJYkzF7ZJysF+PSx/3EWbKIAB
	rWfwNT+ivxrhB5aeqlzjwjgKyZ+qR293RWB1Jit+ozhYSRrvh9OMfwMXw=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQD3Q5EbrzZq3PmUAg--.8562S4;
	Sat, 20 Jun 2026 23:17:56 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover nullable RCU pointer use after unlock
Date: Sat, 20 Jun 2026 15:17:45 +0000
Message-Id: <ed2b303079d5955af859daaae94dfde5d29bd64d.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQD3Q5EbrzZq3PmUAg--.8562S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1UWFWxtryfXr4DGr13twb_yoW5Aw4Upa
	ykZ345tr1rWFnIvw17C3srWF4ruwnYq3yayw48Wwn7Cr1DJr1fX3yxKFyaqFn8G393Zwn8
	Za4SgwsxCr4UA3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_XrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRC1v3UUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add coverage for nullable BTF pointers that are read under
bpf_rcu_read_lock() and then used after bpf_rcu_read_unlock().

The unchecked skb->sk dereference should be rejected because the pointer
can still be NULL after it loses MEM_RCU trust. The matched control
performs an explicit NULL check after unlock and should keep loading
successfully.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  | 17 ++++++++++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       | 20 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index 246eb259c..be0317a47 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -72,6 +72,20 @@ static void test_rcuptr_acquire(void)
 	rcu_read_lock__destroy(skel);
 }
 
+static void test_rcuptr_null_check(void)
+{
+	struct rcu_read_lock *skel;
+
+	skel = rcu_read_lock__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.rcu_null_check_after_unlock, true);
+	ASSERT_OK(rcu_read_lock__load(skel), "skel_load");
+
+	rcu_read_lock__destroy(skel);
+}
+
 static const char * const inproper_region_tests[] = {
 	"miss_lock",
 	"no_lock",
@@ -113,6 +127,7 @@ static void test_inproper_region(void)
 static const char * const rcuptr_misuse_tests[] = {
 	"task_untrusted_rcuptr",
 	"cross_rcu_region",
+	"rcu_null_deref_after_unlock",
 };
 
 static void test_rcuptr_misuse(void)
@@ -150,6 +165,8 @@ void test_rcu_read_lock(void)
 		test_success();
 	if (test__start_subtest("rcuptr_acquire"))
 		test_rcuptr_acquire();
+	if (test__start_subtest("rcuptr_null_check"))
+		test_rcuptr_null_check();
 	if (test__start_subtest("negative_tests_inproper_region"))
 		test_inproper_region();
 	if (test__start_subtest("negative_tests_rcuptr_misuse"))
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index b4e073168..b78542706 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -372,6 +372,26 @@ int cross_rcu_region(void *ctx)
 	return 0;
 }
 
+SEC("?tp_btf/net_dev_queue")
+int BPF_PROG(rcu_null_check_after_unlock, struct sk_buff *skb)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+
+	if (!skb->sk)
+		return 0;
+	return skb->sk->__sk_common.skc_daddr;
+}
+
+SEC("?tp_btf/net_dev_queue")
+int BPF_PROG(rcu_null_deref_after_unlock, struct sk_buff *skb)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+
+	return skb->sk->__sk_common.skc_daddr;
+}
+
 __noinline
 static int static_subprog(void *ctx)
 {
-- 
2.34.1

