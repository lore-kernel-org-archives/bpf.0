Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537917;
	b=wvaK8+/WKGSQ3dFvFQ/1zkh05k+ZVRn7cYCx0mldoXRw0u5b/ea1Tqp/nKLtlh158yIP
	 eF5ffXdr6Zd5MqH3j+NWQdx+/liQ910182wMxRKgxQ6pLOFokFW8OyM/qEzlWOBCgUlw9
	 jQMUcBFCtnWly29aFNAV8nw506Ezr5xgA2i1u5ybHiJCwCutHtZHqT7jEaj4NPPcGxN0S
	 L0DzcyTvjSf7sZhCu7xeKrnaMt3NVRMjCzONehuePttmzitTzd3HS05ZYLnQPgzcDhbhs
	 K9jiEUJBBc2Gm28NjaYg2IVWgyon/49TI+OuGs54XsGb026rjb8C2Tqix+Vy6wg3CSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537917;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ZNRS+aNcC3GxLDLUHXzHnQ7KsB5yimJj/ZsiF0MBjLE=;
	b=GkkZlltO8px+9hnnb2TRqB0p9FPHT3tOSOtrw5PQT4dQloSzek+KD79ztz1jUhle8P3C
	 Q4VA06erLZmPHhOmhFjeitgwnrURoHodRvaxuVssRFdic7vN/Gd3ekCNgf2PNwdVmvtpn
	 JxA2XSMlSGmfys0cXRdRrVmvgfnamNvz7fPx/C79Lx/VbPT9FM4eI27Zs6YEoUkcF3zlR
	 8jcqTu9wUrV21FT+lQBzAN1gR87yNM7ddsTkLpDj5b7mVvQfvKG0MrjVz28oFgALDHdeb
	 jXnIkdscZFTRt7sQckDonzZ+s1iM/t01V6ImlVhf4gjup56PskwzycxcW63r/t9PVhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=c74LErmU;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD7606A33E;
	Fri, 13 Nov 2026 02:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4DD7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=c74LErmU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537893;
	bh=ZNRS+aNcC3GxLDLUHXzHnQ7KsB5yimJj/ZsiF0MBjLE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=c74LErmU32h+M7no/hBbm0rC3uv45ZxXoSkSPM5aA1XZ7vqwwWjXibOtdVjOwNyZX
	 T6d/yvL5YhkEmETWHBCH5vgdJM2737DTY6yg3Smss8u+8HhAWUFdHNTMPc3p6AXzwO
	 71UpPLXscx+rATWHdmSG8dvQYsIEcZKw8abJ//Rc=
X-QQ-mid: zesmtpip2t1794537892t73d693ab
X-QQ-Originating-IP: U4Wq7VN+MGVGS+bkolTAg/SM1461UCICvelr9Ng9za4=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:44:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12874939872931774010
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tjmercier@google.com,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL
Date: Fri, 13 Nov 2026 10:44:47 +0800
Message-Id: <20261113024447.922683-2-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
 <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: MTOVcXjwdVbtqwCWgnwV8s3kvodko4jW1c8gWp75SOaXXhkj9WnS/NCq
	C4P2mUEbUoepGwsmAEkDZeZv5VzCDqRthaY98LLxML58+ETRkN9jycl0I6+GmTGPBiC+TPy
	k3fAqCNxamzn/Nhso+cOKCWTqzghhfarzoLclMCQTToAdp7nOt33+jif0ZkfJmTJfrgV9WD
	J1oVhuwxNetKNUIj5S5BAkB0ohhrcfDqoMcJp2Q8h0SJ3XojNOzZqJmTEVbSalwV2HYQ2rY
	EVzCQhY2A8DY529R8hMC9wE0E7SVwLBoluvGDLOJjQTIiWdUWT+mIgNUCdjn04sXZSuMe8y
	ZbtPFIUmKGJTt3YrIqC0P7+jJl37G1qYRKNiZvyfs0TVKk1mrVu5FPeJLBzz/tlADRcMLvJ
	F292VynE1czVj1MJaxk1l3c0u0LRUCxZ6FAxRdiOnDJ0AddKcyu/5UQYMOMcbKvSI77QcIW
	1yEoI6uXRuTq+vrtLl/pfT8I4GKDp1y4WRNR3nU0sZq3kOntQr2Oa0eWnAtK81INS6j1IEy
	3AMFjNfjwS4mZaIDH5py6NgVHGkjyx/DDJmgsBpuyOpUTi4mDDnvB4hJYUqYqUA6zYbldxY
	et+ip3phjq+rZxtKdRw0+BCUefzYO/WJfJUYjUeh4v/dWNY9aWCBVCNu157yTZVmBwCke5d
	E7LPZWIPjwT+kpqWjISnoY3r/3A0Dk4Te+syUn+vGaRZQXJgGwo8Roz0NJcStECZF5P14Zq
	OcMjZeALi9IVnYkMf6Nc8ch5wYVLL9MCMeksNWlA/DIg41MR7AjhUUoj2WzBZw3W4WUPZc3
	MsXBoa5ffpmff/k3R//WY9CQxYevu5flIqo5ZBXM0iXUbWTvzCRpWf11jPuHEsrpZfoBduq
	fzG261f1pRpDCtns9CvoQmDPGkb5L95Sj8Q/i5epE0W14CKhFBYvygzZMAGtaSyroXjtBQe
	9FOv3BokyE+5WAnk74iKHzMEk6MtXymXSGL6yWXKHm/BTfAnv9BO5sgD8sWwPc2YSExek9b
	7x7G54fjIGZbGaYEgI5dF6wgdXQsW2At662UX7Bxga4Z/WcOe0PQPJXFkwisPxehuEJM1nG
	/K967jRQSHC
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The BPF iterator docs in bpf_iterators.rst specify that the next
function of an open-coded iterator should keep returning NULL after it
has been returned once.

Add a subtest that checks this for the dmabuf iterator.  It drains an
iterator, calls bpf_iter_dmabuf_next() once more and checks that the
result is NULL.  The dma-bufs the test creates keep the list from being
empty, so an iterator that starts over would return one of them.

The existing open_coded subtest uses bpf_for_each(), which stops at the
first NULL and never calls next() on a drained iterator.

The selftest was originally posted by T.J. Mercier in the v1 thread:

Link: https://lore.kernel.org/bpf/CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08KhWE+qJ0J=XGMA@mail.gmail.com/

Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- New in v2; T.J. Mercier's selftest, credited in the commit message.

 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
index 1a5dc1adae73..c1f81b5dccdc 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel, int m
 	} while (bpf_map_get_next_key(map_fd, key, key));
 }
 
+static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_iter *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, fd;
+
+	fd = bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	/* The test buffers exist, so a restarted iteration would find one */
+	ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
+}
+
 void test_dmabuf_iter(void)
 {
 	struct dmabuf_iter *skel = NULL;
@@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
 	}
 	if (test__start_subtest("open_coded"))
 		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
+	if (test__start_subtest("next_after_drain"))
+		subtest_dmabuf_iter_check_next_after_drain(skel);
 
 destroy:
 	destroy_test_buffers();
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
index 9cbb7442646e..d5421b75c39c 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
 
 	return 0;
 }
+
+/* Result of a bpf_iter_dmabuf_next() call after the iterator was drained */
+__u64 next_after_drain = -1;
+
+SEC("syscall")
+int iter_dmabuf_next_after_drain(const void *ctx)
+{
+	struct bpf_iter_dmabuf it;
+
+	bpf_iter_dmabuf_new(&it);
+	while (bpf_iter_dmabuf_next(&it))
+		;
+
+	/* Store the raw value; the verifier would remove a branch on it */
+	next_after_drain = (__u64)bpf_iter_dmabuf_next(&it);
+	bpf_iter_dmabuf_destroy(&it);
+
+	return 0;
+}
-- 
2.34.1

