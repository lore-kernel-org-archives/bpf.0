Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B34480DC0
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497953; cv=none; b=fQwprHszXP58fdWjWf4u8NJ/ogqEmePdZE57wvax0cQelD2GyCqBXYdetdEVvCuz4LbZTgp+LOcBwBilgBJyrYsbrjBD93nAmex5iYuxSQ+0T6EU6JEeAT4VCpR9P3d+jJrr3J/PS4VtewtNwSG6bJqVAepag/38MvTJ0k02IKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497953; c=relaxed/simple;
	bh=qrblDqB4/8UTNvwsfuUvtB8MQ8mzMY7zUiDc+Mbzycs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eejECBJMR8h6ibBoJqlyfnJk/Ksn2V2Fb2Z5epY9WTiVWg1GlSzkMfMPRoBFgFe8Vw/gxAYz/2OijNb3W/ndWgCMLUzNEFvftjYofT7YzRC2bw/WzQT2CMlyJXgBG2RIsZFiutk1a+N/+eKtH29Qiwhe2AOtFqRraVvAqSCFY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQqEf4xo; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQqEf4xo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780497949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8qiNtbqWgHQYGAUM0S9VH2blx8YU6TzskWNL0hFkek=;
	b=MQqEf4xoFIcpXEy97BWN13L2YnJq7b8UasO2tv25zetxF3l6LgsOWuKg4Gdxk81+1BNx9G
	DQNdhbZTe7nxBDJG6xZXtZZ17mmAHdA8yaAMFsHR0rKUuYOAinvrhvrgSy+QMq9jKuPIW6
	jSgcqZC+f0TjB3mHeqY8UiAe0sIfBYc=
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
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/3] bpf: Check tail zero of bpf_map_info
Date: Wed,  3 Jun 2026 22:45:16 +0800
Message-ID: <20260603144518.67065-2-leon.hwang@linux.dev>
In-Reply-To: <20260603144518.67065-1-leon.hwang@linux.dev>
References: <20260603144518.67065-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since there're 4 bytes padding at the end of struct bpf_map_info, they
won't be checked by bpf_check_uarg_tail_zero().

pahole -C bpf_map_info ./vmlinux
struct bpf_map_info {
	...
	__u64                      hash __attribute__((__aligned__(8))); /*    88     8 */
	__u32                      hash_size;            /*    96     4 */

	/* size: 104, cachelines: 2, members: 18 */
	/* padding: 4 */
	/* forced alignments: 1 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

If a future kernel extension adds a new 4-byte field, older userspace
programs allocating this structure on the stack might inadvertently pass
uninitialized stack garbage into the new field, permanently breaking
backward compatibility. -- sashiko [1]

Fix it by changing sizeof(info) to
offsetofend(struct bpf_map_info, hash_size).

[1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/

Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 625a4366fe6d..1007fb7c87e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5400,10 +5400,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
 {
 	struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
 	struct bpf_map_info info;
-	u32 info_len = attr->info.info_len;
+	u32 info_len = attr->info.info_len, len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
+	len = offsetofend(struct bpf_map_info, hash_size);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
-- 
2.54.0

