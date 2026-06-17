Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84A3806B0;
	Wed, 17 Jun 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686907; cv=none; b=htBzMe97HSNmXmE1c9I0B86rc3qK1mBQdiJt2BG77Y6sFb38R/mSS17y9l6/WIoJ7aYHE4vsNC0o3MH0zR4fk0wStz+uyDzzbL1SflrvC9zCJRhCft47DEW/WplLJ4VChm0A/e5i99+bZnqZnE4uZpFXXEhBo+7lbpY3GB28GMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686907; c=relaxed/simple;
	bh=+cUEx/4nC8if+p2TEByB7beE86sydJey7waA5ZPFHMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5uoVX4Cok2KbGFN7xanCFrdd0sWokPo7HYC1/Ftapt4wA4dPeBfD7REo5AcIwVSXAA0DCPExga1PeM0tClzOSC3/oiHPWHZhYoDMPTxAPHePrKUs0DAFZcB96eqtoS79XM3dYws6u7frKa+Oq18/wL/2Ht708RSUwG3kQvQp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lyBb/BD8; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lyBb/BD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781686886;
	bh=lC4QGp+UmxNg9LSB5P56oG/6FYbTf4hSTwsbH8IMmkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lyBb/BD857on0nG0v2OwbeGqKhfEnE+XxIIMEIpTQdr3xxADl6hLRiOoXP082JA70
	 4aTqKzNhxIu3bFT5IVgGfhfqPp+12NrjlbsgS50OTqa5PeKHeGm+SjdmEo0ifd7Bvo
	 lZzP4Q2HCncnjkM5fqaV6ogF9dLZa/6SDvOuKdPw=
X-QQ-mid: esmtpsz21t1781686882t3bed5a0c
X-QQ-Originating-IP: 88P24GbtHUbVU1LThAswkmHOtutJQfwOAYDd5pHG3Wo=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 17:01:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10453321506301856924
EX-QQ-RecipientCnt: 14
From: Yichong Chen <chenyichong@uniontech.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH] tools/bpf/bpftool: Fix vmlinux BTF leak in cgroup commands
Date: Wed, 17 Jun 2026 17:01:17 +0800
Message-ID: <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NyPaQtJYQgeo9GkaKnHVRsMpdfr1sMrMcuQKrNkj+6NsxmWyBbxuX8e0
	fK7829JtCm17xh7IlJibUICgEs7crKMosDerjJXAE7+OFsvMyT15nAdC2512n+i0m6URjXh
	jHw3oM+/vuaO+5lNlXBOzOevP3ejmHcHrgyZq1SCSafeqzPxXp4mKYVwNedZ/y3BJn7rfYa
	xiSZ4YCYA/e+xaqyHJ6G6bHfYAwEllfqEvSZOwX7YpPtufI9Kf98x11ujQs//l5Artqwopp
	+SHMggNdyRM2gWsNEsPh7kILVdUo2NC3WZYmOXphUb4oi5mYWfcJWCtv8w8FJlj7nnoqQgE
	A6VLsoXvY8/8TbkZpqq8NtLHtKJHJTmmeNL6uldNs0UxYUDtgzM6G/mCQcYhlHxLy2AJh7i
	z44+RXn7ewZonuBwFdHIA+0jOQocpNtPm97AS9EiTGlxrSDyzAJdSIF3FO7ozNZPprbXsWC
	O9G9auZ0g82sDpEu3oJjbl6FfEgfE38ne4Tm9NRgwpHoxpx9vLMkAaX884HH29FR6VWf24J
	bzL2NXHGcN21aiCN16zv0xO+Awm+Y2MAfjd3GcGE7YGh8/0yQpT0zazDMUfOJ2nlXaHsfO+
	P2bX9rNW1PAL4eT5ktwShiiCOagrArntX+eVBrWigPe9oyfOjmQ75xYWOV5/9rTHfP+5puA
	Vhe6JGchaM1XsLk2m38hC2jd1Y/SniIgZ1ExqxGEantNeZUMtfcPBZ2smLSIdd9GDMjp67p
	K5Qjhx0GAH0jdXwFYmoMf1vHVnrQN4CUZbffTQY4ShpY2zqNylUl9tFmZ9Y6cpb03bUmuhz
	BRiKcyqJ5qCtckzEWmEsV+O2WU2KvB4uRePFiFoSl94qfour+WpbnGGOe67VmI/bWTwIlDv
	cV40Wz7DC8vWhw/W/BjbeNaSE6k3NhSCf/8JOzYpHj9U/xbJ+SRt45T/qOTK+7l0gnerTU5
	MQLVg4ULVLmn1yPFoAkRAzV4sxmTTSDStCA4k6kfu4K1c35Z8S/3ocAf71vwH5UKJcMixlL
	BsWi/GAZnGzfuG6jq97ECrDiGy5wMmyrPNlrJKDv3FNujYnAGN
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

bpftool cgroup show and tree call libbpf_find_kernel_btf() to
resolve attach_btf names, but never release the returned BTF object.

For cgroup tree, do_show_tree_fn() is called once for each cgroup
visited by nftw(). When more than one cgroup has attached programs,
each callback overwrites btf_vmlinux with a new object and loses the
previous allocation.

Load vmlinux BTF only once during a tree walk and release it when
cgroup show or tree completes. Reset btf_vmlinux_id at the same time
so batch mode starts with clean state.

Fixes: 596f5fb2ea2a ("bpftool: implement cgroup tree for BPF_LSM_CGROUP")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/cgroup.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index ec356deb27c9..ce69d1e5468e 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -78,6 +78,13 @@ static unsigned int query_flags;
 static struct btf *btf_vmlinux;
 static __u32 btf_vmlinux_id;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+	btf_vmlinux_id = 0;
+}
+
 static enum bpf_attach_type parse_attach_type(const char *str)
 {
 	const char *attach_type_str;
@@ -388,6 +395,8 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
+	free_btf_vmlinux();
+
 exit_cgroup:
 	close(cgroup_fd);
 exit:
@@ -437,7 +446,9 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 		printf("%s\n", fpath);
 	}
 
-	btf_vmlinux = libbpf_find_kernel_btf();
+	if (!btf_vmlinux)
+		btf_vmlinux = libbpf_find_kernel_btf();
+
 	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++)
 		show_bpf_progs(cgroup_fd, cgroup_attach_types[i], ftw->level);
 
@@ -540,6 +551,7 @@ static int do_show_tree(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
+	free_btf_vmlinux();
 	free(cgroup_alloced);
 
 	return ret;
-- 
2.51.0

