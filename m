Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1B4C81;
	Sat,  6 Jun 2026 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749763; cv=none; b=F5LkPLUmYrsVe22Rd/u3mXvTiEx7niEI7yY/PCOO2Y2M3SkPKwow8VfBHuqHPBwYAIIcuXrRIqEUX+eZMtfkH2TsWrqV0MXqSzDi69pYK2pzsYzBDwCfIaZdDSMRYDofklDiY9CJpgKwhUkfY7scYgSDSVep5N73Zd/0gAa5ejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749763; c=relaxed/simple;
	bh=+qYVoxDECGQz1+HA9VJqherxd/uK2vk1yWPg8JKP3os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNmoHegEybq7XnK0i01Lpt28XR6ZWbfebf4hD5thkht+j8LLIzosqf+x7yxDe7OmzfSonaQgO/LWuRiWh07b4bZre8UA+XPhEDtTvmfFHqwAZ0V3n2GmcCKqMgnBVxlUyCTG5LFEdT/mYSS83kzNIZh8t+t4uZxbPoNWvpZqV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQTqioLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQTqioLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6D71F00893;
	Sat,  6 Jun 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749762;
	bh=YGK6htKpdPxrTdcBr0wTqfu/3GUsE3N69O3f+UPlo/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQTqioLyqoSuFYqsQQNSEsdGBf5aU497IOFSlWrvOPshFUtmYrwBf+wmf/JPwWxVZ
	 QmErTnsg9ogJjyDKrxRRYIn50prQ678mTv2gj2O8ebjHe/Qp4VPUQA0pGlf9bAPlzT
	 W5avAnwoYcJsWuADGOtKIR4j2RMQjSpZlQ5SSz+BPXjYVgs18U5xUCCbxkNTlt8Bez
	 R1u9S3nakrhskRugZ5V0Xbac8Hdz88Dj0TxQ7L1TVArIb/JHsNxPYZxzuGjxTVdBdh
	 CUkM1ZMU4lKV42a5+9fuaAQs2yKGlElTL2olfDyKsZXHqZ3LZNTZkscPGBkJys5VVO
	 1RZ+Tq2voA4Vw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 16/29] bpf: Add support for tracing_multi link fdinfo
Date: Sat,  6 Jun 2026 14:39:41 +0200
Message-ID: <20260606123955.345967-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tracing_multi link fdinfo support with following output:

pos:    0
flags:  02000000
mnt_id: 19
ino:    3087
link_type:      tracing_multi
link_id:        9
prog_tag:       599ba0e317244f86
prog_id:        94
attach_type:    59
cnt:    10
obj-id   btf-id  cookie  func
1        91593   8       bpf_fentry_test1+0x4/0x10
1        91595   9       bpf_fentry_test2+0x4/0x10
1        91596   7       bpf_fentry_test3+0x4/0x20
1        91597   5       bpf_fentry_test4+0x4/0x20
1        91598   4       bpf_fentry_test5+0x4/0x20
1        91599   2       bpf_fentry_test6+0x4/0x20
1        91600   3       bpf_fentry_test7+0x4/0x10
1        91601   1       bpf_fentry_test8+0x4/0x10
1        91602   10      bpf_fentry_test9+0x4/0x10
1        91594   6       bpf_fentry_test10+0x4/0x10

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a0d688fffc5a..90432f0fc2a8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3665,9 +3665,39 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	kvfree(tr_link);
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
+					  struct seq_file *seq)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+	bool has_cookies = !!tr_link->cookies;
+
+	seq_printf(seq, "attach_type:\t%u\n", tr_link->link.attach_type);
+	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
+
+	seq_printf(seq, "%s\t %s\t %s\t %s\n", "obj-id", "btf-id", "cookie", "func");
+	for (int i = 0; i < tr_link->nodes_cnt; i++) {
+		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u32 btf_id, obj_id;
+
+		bpf_trampoline_unpack_key(mnode->trampoline->key, &obj_id, &btf_id);
+		seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
+			   obj_id, btf_id,
+			   has_cookies ? tr_link->cookies[i] : 0,
+			   (void *) mnode->trampoline->ip);
+
+		cond_resched();
+	}
+}
+#endif
+
 static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
 	.release = bpf_tracing_multi_link_release,
 	.dealloc_deferred = bpf_tracing_multi_link_dealloc,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_tracing_multi_show_fdinfo,
+#endif
 };
 
 static int ids_cmp_r(const void *pa, const void *pb, const void *priv __maybe_unused)
-- 
2.54.0

