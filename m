Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856143C4B88;
	Tue, 23 Jun 2026 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199386; cv=none; b=LiIDLJfArxYlabvS/522jOUr9bNukQtXCEqb3oap7K7wK3p+7eBL+iATDJwJ6pfccvBBjCTI5Qrp+E5sdj8Ltx0n3UsaFtWwHo8fO1T2d0zA+wFNj1FQb4mZ0E3lQHUjumacjtYEvoezUWiR1LURWYgXuSHBaxwED5e3UA2/fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199386; c=relaxed/simple;
	bh=4T3uzMt3rkOH7V2EJeqPK7XLmprXjMpT2TN99S2fY+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ4W4/A+9d6eSo8J2Zl/IS1R7MyTlJHjeIQ8GSmH1k73c4GHBYRcYD5RDvsfB9ILomCuB8Hwf6niyFpsSpQLHHPXQ7300jiwamN+RktTuHI8mQiWfPMWN+30RVuivuwSe0CfubLonGUwEOUis4EO3D9eaEBPaxhBQM9nUHIJlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=W+zyr6Hx; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="W+zyr6Hx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782199369;
	bh=/Kquv8mhdGqyQSrQKIHTidr0g3+m3niLDWMAIbee1Nc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=W+zyr6Hxml7BBhnh6qQLHoefOGPqkNTNLLe3uXG7c15ha1qdGNUjoRudsn1D621bK
	 Od6zK31ZowaHG3JyzjLSviGmqRil2Qn45BcyQjakda5f2cyBT88HROhjz14T8rkKOj
	 AjJGpRFUj1LDX/L9A69yREBZpWA31QAG0eeIDo08=
X-QQ-mid: esmtpgz10t1782199354t39d64441
X-QQ-Originating-IP: 4C9Pgmk5kJz/j8i1R3fFvrUHDwMYsPGkG6qVcrUaJqc=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 15:22:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15727490912040929424
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
	jiayuan.chen@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH v3 2/2] tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
Date: Tue, 23 Jun 2026 15:22:20 +0800
Message-ID: <871EC84E76334A24+20260623072220.1421837-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260623072220.1421837-1-chenyichong@uniontech.com>
References: <20260623072220.1421837-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NFNrK8KlcSCRmB86nJJTTHo4r+xLjwD82JLK0nd5Pev4ksC4oF1mdD+t
	OSe55zU44upwNN2Tz61UPPU3JiOVuevBgG0mfVm7q2C/IsL3eEakS/A2keZJnKCsz+ZJfFv
	YOHhZopQyvT0OvHMLsTNgY0lfJNHg0rImHWiYMuT1nU7zqprSaMSRU8nXwttWaM5bs3y/mB
	4qUIRzdWGpj/pI4HB3U81S1F9XcVHTkXVwC8CNu8Bv05vj7xbEsZHrXuQmuZbPYrdYwBlDi
	rSvYRlFA6w9MI6MBR59vkv3RCDgKrKYdZx0Cy73Ef5VjTwqiSjBZ93uRmazjYKVxtclGm+b
	1LO61dyLmO7c3aKMp9AR2yVTCCTmcD1RnB7H/yLxTb/lUC87U6+tCtGPzQ844txJelTwM9o
	SXrVOz4eESqZWW2+nGzRvqv+wUPQoGlEvXe2ZjkzT4wVMUN1qsTC4YHmCI6aZhisLPAJ26n
	BB9sV0pkBfkEuRkFZaYzMNPJb+/aBzWusUbdxu+orLYED7NojgoTQN6BbfKxXdUEUWgij6u
	IXRGamuYW9TmwaIaKG0sCVu2bOW/iEh/qjZQc4IS7XiYYRIYthupIISCj5cWKP1+LHZz+7p
	FUZ/JiMaBq2mHlmZXIdzOD4LE2AYjF5yJOpkh2znYlh1dq4NBCad+bRm2LKRBM/KPZfXdHq
	Sk4Yco2K/YWzcLaWeIybJJDSMm9wKc4M+anaLBaa93hRmwbtjdueWl+pQMn6hl0wDnbMtbr
	Ndiso5AiE/f+7MMd3Lu3W+4AUC7DY2DF6NpeZei/55G96bMb1V/41QYQjvlZqhYlkZDy5Ci
	8S7Fwls89v2ywIMp6Rg1GCdZ7NXA47Gi652JhmnX4vZWB5dE0hdD6VPg7YVMbeZfWV9OYVh
	ZRvUU+dVb7aGJPcXA4wmva3geKa3yHM6KeBYx9CRyrakMaG+bf9qBIG1e1zWkglGlX5K/Ru
	iG8BrrgUUTOwW6FsouK9+Hm/SHm88ujyw4rMgEMDWCZkw/Lyu7EPgTY8VLTIV3W60qOU42T
	JyfX9oZC0QawCjpv9cxYvlCH+XxuQLO8lYIRFrIByRvXBitMeY81kQ0R9nH1btSnzb3g64k
	ZGXxAvHM/WijlKpwc6vel+8QGOHuAl7wH+b8qk5nYkz
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

struct_ops frees the global btf_vmlinux object.

In batch mode, a later struct_ops command can reuse stale state.

Reset the BTF pointer and cached map info state.

Fixes: 65c93628599d ("bpftool: Add struct_ops support")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/struct_ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index aa43dead249c..4dba7c96e5f6 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -21,6 +21,15 @@ static __u32 map_info_alloc_len;
 static struct btf *btf_vmlinux;
 static __s32 map_info_type_id;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+	map_info_type = NULL;
+	map_info_alloc_len = 0;
+	map_info_type_id = 0;
+}
+
 struct res {
 	unsigned int nr_maps;
 	unsigned int nr_errs;
@@ -642,7 +651,7 @@ int do_struct_ops(int argc, char **argv)
 
 	err = cmd_select(cmds, argc, argv, do_help);
 
-	btf__free(btf_vmlinux);
+	free_btf_vmlinux();
 
 	return err;
 }
-- 
2.51.0

