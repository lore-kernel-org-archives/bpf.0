Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542232;
	b=bW6F32ptaHLOUBza+5i4XbqQ4S6RJtK5Rl0Zf+LU3j55NmD6IYM2W3i6D9s93GR6sGtZ
	 3XpmxtDqTw6wbLOwNpw3QRCjqTGtSCZ6w/sb8q9DD/SUePuBWN7fV7Yvp0HuLmMIozNy6
	 hu3rsT5O2bVZ81bkXHV9PjDsoqVa5sI/cwvBZKGQsvJsvqE/IdU3aDMa3FNRNB3m1lynK
	 dwXcbRwzUZfQzxyNxDfWA/l7vZc/odmgCEZptmZW3LvF93qmWumjXJLTYTQrqDKuWxvKB
	 mSnkLb2drZn5JYOGOGKEpBRY/uw4GEnYmbPkACp0GmPrx9/bezVr+65VWinDgbdeaAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542232;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=dPhxcd6/BZYgx50DAMwodoQTThTXpPpE+XC7POngjKc=;
	b=Ud7kfaL8T7BOqnm9kJNmGcDBEexbGTeMXmK8RU1IDeS3RA/mXe6472sQIQyS5nUMViU/
	 xVEK/+vpB2Ug6JYc0EVJsrPZ5LxZI2/OpGeDg9Ltwii25Uf/mDLcJH7drSaTOMrW2D1Wz
	 eVntm7lDCj96Ed8wSASm2HEaNzR6bwvovvHfV0J8gtWRxOXfePga03QXmUAcVC2xWEOJj
	 MSNBdi1V1DFxT6Yp4E9KG75SWE2DznZ5tyJRrzYcWqtSzZwbdxh7A/WRGsNTJFAyPA3CK
	 Ow4b8pikXXPCjzGhAAe2tDtPut1GMNVPBnz3X1Fmk4Ih2WY8gYa5Zf8pqEkP0Y28tzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=tZW4o+wP;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BB606A32D;
	Fri, 13 Nov 2026 03:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1BB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=tZW4o+wP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794542206;
	bh=dPhxcd6/BZYgx50DAMwodoQTThTXpPpE+XC7POngjKc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=tZW4o+wP4u2aKyvmdv8OtQtI7wAI6PUv4Kl+nHnECdilJdzwgdFvlLZM0/1EyUDMo
	 PhEgKU+AMKfUJ14CndUAtIPC+jiPg73Fti7l+s4UCAahM7wUYqPnoUrzzd+EB1+PUq
	 E+/K2wNCBo790xw8ux9n5hIYPjE6Pxx3DdC2dQ/I=
X-QQ-mid: zesmtpip2t1794542205tbf655990
X-QQ-Originating-IP: e1SLVr7RTm7aupYw6jdBDKSKPKp3JMysT4SS655xl4c=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 11:56:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6820046291963919950
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL
Date: Fri, 13 Nov 2026 11:56:40 +0800
Message-Id: <20261113035640.948458-2-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
 <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: MVMn5D3ouL6CRs7SYK/eQvRARRNYnt+QewD2lzqvtDn3REqkJ18ZVb0o
	oACC/KUJSpl7Wh4Mfz/L/UDEYeX/ViPetGE0xoPZRkKOURX/c/zMbOryVhWrkHcrhCuilIq
	Vz/i7Wq7fN7Ll3WP7sZU2VEr9RvQ95Lm/DWFZg7vpp+eD6o/f+hOd20ftHbixafOiNo18i3
	BQnt2YCPNFShxJG6OY7ude53TgAvqAiXiO9FT0GQL9qT6K4k2sO17Hlw+dUwuKhuscJlHys
	K/A8cu8P6G2jRIPoxbaor5cNtKjB1loOvZo8UXOEcuc7sAexTD0GhR0TrzOBBnglFyDmN+6
	dHxBakKQDO4D23rH2CtAnYhoAUZ5nM7W6Xk5sYZj78rQVqDtODLHz8NFLYL2mhLMIYgfHQt
	oizyF5ND3fQiVElJDsuOHWwHVrXnY/M0+IeZurlXmWALk9izPVs0A+D0p4IRU2FfYFbhoMw
	pbDxM6QTsCUAOne/U5UiFoGrc16QaYA83nUz8lCUlaqB8D9fIzi8xgJc3TMxAqu79wABPcC
	lNWXcUbv/puS5ZBnwJ0uhD4LMip6i48ueSHJ+ckBNsUjF9J7UzbBZGEICfcBpMYO8tITrJN
	cYnBYpCiRNADS+pvWQD8YXNl1EZmNVjfWBMZGdPRl3LWcwte5d91ErxfXsiGyEmrTEeP0x3
	+Vk51N8sRWtXQpYH+7+skq9S2nRo/59AxeupyAurbLepXgOeI6Ksifh6z6gumQR1z3n6np8
	LIWg8ftbvvqPHvWVzulQB+auPyvDwVQTJSucac75V1fmeboxmsbPFwN8uYQXOHUwy+rioFj
	OccnBQKFJFwuoQi8/K/mToBlRQ3mVSAMt4RjUNo67FuAhx5hOz70xhx4OJ51yGQLJvE0fb0
	S2LausbvnCyK75VDiAit34EAH60WRF3ODJtRHCKZecM9AUUZZsB8UUg+3klOL3kHnNBGAm5
	PgztHvP/GfzcOMPv7/jALJOMg6+gWsYMT8Xq7bF4BFElF9GiiViz7M8vefLzZ7V4oZyYJ0O
	UogpF/6Cm+AZJN0em7ZEr3yzpIsqHg7rHlJ/Z8AUb/wdV/MU85VSgz3gvjRZMIp4uBz5hn7
	VxiStPrZkx7Dre0c6OxsKUaGKnxtP1iMDlvGdSWdZ82tQOxRD1RsftwZlwzWtWE6nlG9wd9
	65ha9X7WNSj/oDhYpvSvyMNAoA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

Co-developed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v3:
- Add T.J. Mercier's Co-developed-by and matching Signed-off-by.
- No code change.

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

