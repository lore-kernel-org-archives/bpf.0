Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583D3B38B8;
	Sat, 27 Jun 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571988; cv=none; b=Gul1IoWda/zAqtiwq8hv3P0LiM0D+y8Ls2qOAkI+PETVElLrfwjglObNYsnYXR/CCoj0gNH4n1C9dUMEI9qDKW5gOfrXiNi/qRqJgn5OUs1ZLYKQXNBv8bHcAsN3kOx+wF9rKJmccvXnt0yv9WHHWq7l2alrBrjK20uOy96AGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571988; c=relaxed/simple;
	bh=AlmAAGt55kjNEH/QcP+MS68+3t7mhjVtM/N8J7M2u/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff5HP0qwebHgoUZrdswLhTlFA2ch3HiBmVz07OAmdZnP2Yy5pEL5xS5hrfqJzXX0b1BsbCV4NHxvNKQ/rbvpy31685aFHDX7ApKK8o2BTAdDOkQA2hZgMhINf8m3iuNaMLABXi+OasgYgCGHkdixO+gvhjASCvZdQEhHvD1szPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB409mJzKHMLw;
	Sat, 27 Jun 2026 22:52:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5A1F14056E;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S12;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 10/12] bpf: Support attach and detach for SDT observer program
Date: Sat, 27 Jun 2026 22:51:44 +0000
Message-ID: <1b13b561aae721fec70107256228a77fbc0e8987.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr13uryrCFWkGr1UZF13Arb_yoW7tF4DpF
	1Yvr13AF4UXFW7WFyDJay8Za1Fv3Z8W34UKrW7Gwsa9ay5JrWvqF1jgryavryYkrWDC3Wf
	Jrs0vFWUK347WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIJ5rDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add support to attach SDT observer program by reusing the bpf trampoline
attach and detach mechanism. The trampoline is keyed by target program
fd and offset of the probe in the target program. Unlike normal tracing
program, the target function address is the jited address of the probe site,
and function prototype is resolved from prog->aux->sdt_probe.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h     |  9 ++++-
 kernel/bpf/syscall.c    | 85 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c |  4 ++
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 93c196f38b87..6548a2dd76da 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1270,6 +1270,12 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_INDIRECT		BIT(8)
 
+/* Trampoline is for an SDT probe site: arguments arrive in
+ * BPF registers recorded by the SDT macro at build time,
+ * described by btf_func_model.arg_regs[] instead of ABI order.
+ */
+#define BPF_TRAMP_F_SDT_PROBE		BIT(9)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
@@ -1393,7 +1399,8 @@ struct bpf_trampoline {
 	struct {
 		struct btf_func_model model;
 		void *addr;
-		bool ftrace_managed;
+		u8 ftrace_managed:1;
+		u8 sdt_probe_site:1;
 	} func;
 	/* if !NULL this is BPF_PROG_TYPE_EXT program that extends another BPF
 	 * program by replacing one of its functions. func.addr is the address
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8b2c73bb6c2a..53897ff1100f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3737,6 +3737,89 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
 	.fill_link_info = bpf_tracing_link_fill_link_info,
 };
 
+struct bpf_sdt_link {
+	struct bpf_tramp_link link;
+	struct bpf_trampoline *trampoline;
+};
+
+static void bpf_sdt_link_release(struct bpf_link *link)
+{
+	struct bpf_sdt_link *sdt_link = container_of(link, struct bpf_sdt_link, link.link);
+	struct bpf_prog *prog = sdt_link->link.link.prog;
+	struct bpf_prog *tgt_prog = prog->aux->dst_prog;
+
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&sdt_link->link.node, sdt_link->trampoline,
+						tgt_prog));
+	bpf_trampoline_put(sdt_link->trampoline);
+}
+
+static void bpf_sdt_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_sdt_link *sdt_link = container_of(link, struct bpf_sdt_link, link.link);
+
+	kfree(sdt_link);
+}
+
+static const struct bpf_link_ops bpf_sdt_link_lops = {
+	.release = bpf_sdt_link_release,
+	.dealloc = bpf_sdt_link_dealloc,
+};
+
+static int bpf_sdt_link_attach(struct bpf_prog *prog)
+{
+	struct bpf_sdt_probe_info *sdt = prog->aux->sdt_probe;
+	struct bpf_attach_target_info tgt_info = {};
+	struct bpf_link_primer primer;
+	struct bpf_sdt_link *sdt_link;
+	struct bpf_prog *tgt_prog = prog->aux->dst_prog;
+	u64 tr_key;
+	int i, err;
+
+	if (!sdt || !tgt_prog)
+		return -EINVAL;
+
+	sdt_link = kzalloc_obj(struct bpf_sdt_link, GFP_USER);
+	if (!sdt_link)
+		return -ENOMEM;
+
+	bpf_tramp_link_init(&sdt_link->link, BPF_LINK_TYPE_SDT, &bpf_sdt_link_lops, prog,
+			    BPF_TRACE_SDT, 0);
+	err = bpf_link_prime(&sdt_link->link.link, &primer);
+	if (err) {
+		kfree(sdt_link);
+		return err;
+	}
+
+	/* use orig_off to compute the key as orig_off is unique for each probe */
+	tr_key = bpf_trampoline_compute_key(tgt_prog, NULL, sdt->val.orig_off);
+	tgt_info.tgt_addr = sdt->probe_ip;
+	tgt_info.tgt_name = sdt->val.name;
+	tgt_info.fmodel.nr_args = sdt->val.nargs;
+	for (i = 0; i < sdt->val.nargs; i++) {
+		tgt_info.fmodel.arg_size[i] = 8;
+		tgt_info.fmodel.arg_regs[i] = sdt->val.arg_reg[i];
+	}
+
+	sdt_link->trampoline = bpf_trampoline_get(tr_key, &tgt_info);
+	if (!sdt_link->trampoline) {
+		err = -ENOMEM;
+		goto err_cleanup;
+	}
+	sdt_link->trampoline->func.sdt_probe_site = 1;
+
+	err = bpf_trampoline_link_prog(&sdt_link->link.node, sdt_link->trampoline, tgt_prog);
+	if (err)
+		goto err_put_tramp;
+
+	return bpf_link_settle(&primer);
+
+err_put_tramp:
+	bpf_trampoline_put(sdt_link->trampoline);
+err_cleanup:
+	bpf_link_cleanup(&primer);
+	return err;
+}
+
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
@@ -5945,6 +6028,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = cgroup_bpf_link_attach(attr, prog);
 		else if (is_tracing_multi(prog->expected_attach_type))
 			ret = bpf_tracing_multi_attach(prog, attr);
+		else if (prog->expected_attach_type == BPF_TRACE_SDT)
+			ret = bpf_sdt_link_attach(prog);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..68f87e7b901f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -691,6 +691,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
 	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
+	if (tr->func.sdt_probe_site)
+		tr->flags |= BPF_TRAMP_F_SDT_PROBE;
+
 	if (tnodes[BPF_TRAMP_FEXIT].nr_nodes ||
 	    tnodes[BPF_TRAMP_MODIFY_RETURN].nr_nodes) {
 		/* NOTE: BPF_TRAMP_F_RESTORE_REGS and BPF_TRAMP_F_SKIP_FRAME
@@ -784,6 +787,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_SDT:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
 		return BPF_TRAMP_MODIFY_RETURN;
-- 
2.47.3

