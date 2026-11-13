Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537957;
	b=IgIhEoDFAGwvewrerJeWvSuwOY0t4nB9BSPfLfubqzi81ErMj7catRW1coZ3DH20HgCu
	 HmWLRtgksWqXrQURdKe1a9HywvHm+nuJlu+IgNLlHd/yzBaW0PrNzfFUpoVb548MDvUq2
	 MnCUJAl2Ygwc90PTz9lzLTwwn4VEk96RWLg7kLgFuCD/NSJKbhT+gfebbLnMUJo+txhBZ
	 6U6bYzPVBj0QXhJkVhDtI3OJBrfwsUxDpxC3xjggKR8aDYsSHaWxX/SAQ466K1KRMALvm
	 tyGjF78/Xx8E4b849+32VS+D4qdU1CxF4B22rOM4GhPPnPz10NmWLm6PqolgzT2H4rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537957;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=gTK+CJUKCB9TjETxtk3SgMQ3mAsKhlysPlmQdHrNIo4=;
	b=5U9S7yOSTyNHdfqvfnul0561N18TnZ95rLBp8/z2z5PhLShF/cTRdXlC1rm8eVLZC6sH
	 tHO2+xQGTuLXdoOBE+dd/cYL8K+f5cZ7S6YhpOEkuDUAf0/0EdPGjczAlLWObnzdPnvmE
	 mi7+1Y4YMT52EtP9aMn/LHtz6/IkRZm3BxetkFLnX1wjPeXeS0akjeTYvyU8OKmEuqUjG
	 YQYBqhS6l51EfuvIr/gpLjs2JHTx+CqdiKT31O4Uuue6rCvrfc/3hY5HI15h9A7Oh0KBp
	 enhjiJ+KHrkemPIMxcAcF+iyUHvjgk1DbFhFQFHvHi0ypGznfwxUrWYitkzg5B5uAQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=c6em8vg6;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEB606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BEB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=c6em8vg6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537900;
	bh=gTK+CJUKCB9TjETxtk3SgMQ3mAsKhlysPlmQdHrNIo4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=c6em8vg6Hbr3R8VrHb19tSqkFBISBAqlWYv6mJItr/2l6+1udFQmwqAPhwGCJN5GP
	 wCq1GOL5INJ0Pi6S/uOHmYS0cyXJFyNA8Cd4DBtvkO+lHk793hZ15/aFs0Cgk0lB7p
	 ChGtbqEwjtDv/rsNJ5JyJS8X3NKVJdYwfdfquHJI=
X-QQ-mid: zesmtpip4t1794537898t5eebd4cc
X-QQ-Originating-IP: dD1y0njpFnaJcOMo/TXNzNhF8HdteDHggezH089V2S0=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:44:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9753415056096768044
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test that a drained css iterator keeps returning NULL
Date: Fri, 13 Nov 2026 10:44:53 +0800
Message-Id: <20261113024453.922726-2-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113024453.922726-1-k.chen@smail.nju.edu.cn>
References: <20261110125110.2935707-1-k.chen@smail.nju.edu.cn>
 <20261113024453.922726-1-k.chen@smail.nju.edu.cn>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Nkm5Fff6p/24dsNTPlqqjlt6DFFLLu39lHpbJK2cxLtMlL5E1iGxMDAM
	r2JN9tVhn3nJgHdIMjNAf8EJEq1uKctL/yuJCLTvvxypxSKmNxL02msfI2L/WVJk6M5/xIf
	U+VUJUwONb7gwyJZvbqqNVwso0xoDUkpT84Kfnx/JhiyDJxs7UGiNxIuz8UJWlv5vBUsnUs
	m/2uIKuZa9qQHm8KEjbz0rFrpzbwv56Fj6upe+EMljG5GEzPNU9iGO3+IgeTDDOmiv3l/XB
	+XiFMkdxRMT6rGn2eV/y99SJxOjiGqwtPWAs8B41hUGXFCKpKykIAlyGiYjR68iUefDH6Xx
	pMJ7K01RS2i6naLxfrPcDGafCNVs6F5XRgTje1RjtMTRVyai5i7dWIRCyUNqJd7nMXGZP0A
	HojVvQyM3lFWO42Q0xYYIiWa/bAXhmD5PCY+oeMJnC/lO9OV4pxT/N+J4wug2iAEoDwuPL0
	M/Eupx7yuWUWEhUjo2NQeab4zYMV0IauYexwW7eTrGtBhxSn12BlaqF7hQFFE6zAFa8q5I7
	xHepcJlRg9s/LtVNHiIyTP5+DfRlcwTmIkQzoDrEJK/f0dcnh1tplMTJXf9VN7oDXs0WUAW
	tvjpZKcc9ET/S+SnOodd1WJU/B5fMY1EBNVQC60AhOBXQXL2qIDImhUzr+zM5iyt68q5FjF
	y7AcY6B44CYggJwGt9isjHviFaX9sQSBjFUtzQx7VkdQNk6lMz3lPGath9uhuxYIt3tnHkF
	EixPW86LO8vckgvy0FQoUWED2TcmkWl/K86ckgQ9dAtowjj7avDZo9VCRpHAvhtoudIvrGH
	FILPWfS79RQ3ALQcEHcqbN/XDLXoaIbzrfZr8hzP3LxEAGVuwVH0iVCh4mhN1/8NrKLln+T
	q+pkgqPlpO4s/zfCe+mf+oH4O47aP4Fw54d7Crbn1cDo30/m3agE4SiSXT6brSHnXg3V4l/
	+N2VGohUB8l0y34ote7NUdMzp7bu6K/qOer2vmfaJpYF5FJGEQiMkymgqoBYkHdwGhEuVS0
	YSWZn55oAqYl0Tu/TijAUzhHNHg2I=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Add a syscall program that walks the current cgroup's css descendants,
drains the iterator and calls bpf_iter_css_next() once more.  Store the
raw result in a global so the verifier cannot fold the call to zero.

The test holds an RCU read lock and releases the cgroup reference taken by
bpf_cgroup_from_id().  The user-space test checks that the constructor
succeeded, that at least one css was drained, and that the extra next()
returned NULL.

Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- New selftest in v2.

 .../selftests/bpf/prog_tests/css_iter.c       | 35 +++++++++++++
 tools/testing/selftests/bpf/progs/css_iter.c  | 49 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/css_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/css_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/css_iter.c b/tools/testing/selftests/bpf/prog_tests/css_iter.c
new file mode 100644
index 000000000000..9bf8f056d3cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/css_iter.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include "css_iter.skel.h"
+
+static void test_css_iter_next_after_drain(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct css_iter *skel;
+	int err, fd;
+
+	skel = css_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "css_iter__open_and_load"))
+		return;
+
+	fd = bpf_program__fd(skel->progs.iter_css_next_after_drain);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto out;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto out;
+
+	ASSERT_OK(skel->bss->new_ret, "new_ret");
+	ASSERT_GT(skel->bss->css_count, 0, "css_count");
+	ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
+
+out:
+	css_iter__destroy(skel);
+}
+
+void test_css_iter(void)
+{
+	if (test__start_subtest("next_after_drain"))
+		test_css_iter_next_after_drain();
+}
diff --git a/tools/testing/selftests/bpf/progs/css_iter.c b/tools/testing/selftests/bpf/progs/css_iter.c
new file mode 100644
index 000000000000..2ebac638bf78
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/css_iter.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* Result of a bpf_iter_css_next() call after the iterator was drained */
+__u64 next_after_drain = -1;
+int new_ret;
+__u64 css_count;
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("syscall")
+int iter_css_next_after_drain(const void *ctx)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *pos;
+	struct bpf_iter_css it;
+
+	if (!cgrp) {
+		new_ret = -1;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	new_ret = bpf_iter_css_new(&it, &cgrp->self,
+				   BPF_CGROUP_ITER_DESCENDANTS_PRE);
+	if (new_ret)
+		goto out_destroy;
+
+	while ((pos = bpf_iter_css_next(&it)))
+		css_count++;
+
+	/* Store the raw value; the verifier would remove a branch on it */
+	next_after_drain = (__u64)bpf_iter_css_next(&it);
+
+out_destroy:
+	/* The destructor is called even when the constructor failed. */
+	bpf_iter_css_destroy(&it);
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.34.1

