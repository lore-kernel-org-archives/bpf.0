Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5623C819A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674833; cv=none; b=FUnt4K1Nbe3zQHNT3nBif+EiUj1swp0u3bgOS2eBDT6SJK+4u0jGSFLlklbFHw2OX/sbrfIWlVB/sGYz1r6Dp1635jEGxqWLKfVHXEo1r01J7Mg26WKnbbgnFyYg3XJ1Exno3RHY2uiLr3046xtv/LSRdph+u5fHOT8giThnhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674833; c=relaxed/simple;
	bh=N0NMDwecXTGo3+B3JAWMygZw1UUZ6OzfQiT7QBgnI/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYtjSKLR66BJT25CBr5Vn20+WTT3OSKEfM8lt+7frQ0EXlSil7rzeozBZIytmY1T4XNMdGfNHUC/xN9PZkGi+/74Pwz7wd+I2C/EzIrnAQeDcaebZwKOhW9Dn75SntfVsw/FduG0M2qhn2CubxRUZdb+JJuMJJdHlUh+SlyYpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=giQ78XHB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="giQ78XHB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780674829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I6KeKxzOta1ZBR0diw6dlq8OqECf/tpenQwEpWvgGA=;
	b=giQ78XHBqdY2ysvCvU8KP2UKHp5mx9wwOlaWRJjHM9dcEjaO5191kRaX+AjkstCzH++LC4
	Dld6XidknHaEsLBPNxRAXBg4WGCJ1U4t/T388cZEl71APBdNPeiP+IiFgferva35XS6a81
	ON6IJzvHA/UUyc+SrDTlfwvZdZQcQeY=
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
Subject: [PATCH bpf-next v3 2/3] bpf: Check tail zero of bpf_prog_info
Date: Fri,  5 Jun 2026 23:52:48 +0800
Message-ID: <20260605155249.20772-3-leon.hwang@linux.dev>
In-Reply-To: <20260605155249.20772-1-leon.hwang@linux.dev>
References: <20260605155249.20772-1-leon.hwang@linux.dev>
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

And, add "__u32 :32" to the tail of struct bpf_prog_info.

[1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/

Fixes: aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and fdinfo")
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/syscall.c           | 5 +++--
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e1730f449d9e..d5238df5e5eb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6712,6 +6712,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 :32;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 89f020a44fc9..c5d4ae957e87 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5121,10 +5121,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7caf667e86fe..3829db087449 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6712,6 +6712,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 :32;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.54.0

