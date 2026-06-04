Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530631A55E
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585551; cv=none; b=IvKaA2d2ekQ5F9J/H1pVU00LYGsqlIICfICTvHTbQRGIQlC2xGWwA0XIMk9N6q5cibtGWTmJ3i/0iMON3+DNoaNQ70yx1CpBGjDYgcgzRvEftDTYhsIA5QBR7Ul4A/zf8S006KZ1+E8RMmevcgJJyGAjwLfe4AgEwbaDJzydVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585551; c=relaxed/simple;
	bh=wlQ5x8dSF1J8/MWUD61qF9vPDOGbwB90oG5UbESi4eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyTvxIjxlKsdj8s02QvCfGU2/8nOZVAhcB+3plnRGuSji0g7+cKy5BhKQBa/LDsOHGn42skGluo/yLZrAB/mKGNSW9NByAfsDSvfqq9YwGIbXHMmkQuUBNFQqNmRsjFziGz154PxRxtjrvnLtS7VBgC/b5ePFBvRCQ2mzDCKV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qkIGHWuL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qkIGHWuL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780585548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcExdXGWFg882mqgHkmP35ZC5fLdpc+f8+br0xZGCsI=;
	b=qkIGHWuL2lNixjZMb8gNJpLuN1IgJ1EypHMce5HaQ6Bw3viYER+UYszWnrLE0jI6PakzNw
	FS+bAg4AlZTZJ5ee1UU5/EXsM1LvtEBJOlaxcUvpXjYM1h+2OCNLkEts1qccdi6zvWKaWV
	nn+9zdEQff/DbppHbBpAcVpnbkfewrs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/3] bpf: Check tail zero of bpf_prog_info
Date: Thu,  4 Jun 2026 23:05:04 +0800
Message-ID: <20260604150505.99129-3-leon.hwang@linux.dev>
In-Reply-To: <20260604150505.99129-1-leon.hwang@linux.dev>
References: <20260604150505.99129-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since there're 4 bytes padding at the end of struct bpf_prog_info, they
won't be checked by bpf_check_uarg_tail_zero().

pahole -C bpf_prog_info ./vmlinux
struct bpf_prog_info {
	...
	__u32                      attach_btf_obj_id;    /*   220     4 */
	__u32                      attach_btf_id;        /*   224     4 */

	/* size: 232, cachelines: 4, members: 38 */
	/* sum members: 224 */
	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 31 bits */
	/* padding: 4 */
	/* forced alignments: 9 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

If a future kernel extension adds a new 4-byte field, older userspace
programs allocating this structure on the stack might inadvertently pass
uninitialized stack garbage into the new field, permanently breaking
backward compatibility. -- sashiko [1]

Fix it by changing sizeof(info) to
offsetofend(struct bpf_prog_info, attach_btf_id).

[1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/

Fixes: aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and fdinfo")
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1007fb7c87e9..0c86a70d31c1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5115,10 +5115,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	u32 info_len = attr->info.info_len;
 	struct bpf_prog_kstats stats;
 	char __user *uinsns;
-	u32 ulen;
+	u32 ulen, len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
+	len = offsetofend(struct bpf_prog_info, attach_btf_id);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
-- 
2.54.0

