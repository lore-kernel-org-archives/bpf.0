Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2E2D73A0
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200079; cv=none; b=HFA2DcbWgfcHPXI3MihNQsHNvt2Bbe4xG/xCU2Q6c6aQl/kJtaEgpjh3q06AZ0rCH9PlGhWtDhyumEIkkgevrCTc2EkpVaBoW2/4YF+fWYb8yXXaFlJgh4yZyUx+0oHEXQDiVUS9bzf90CnbvLBEamzHHPY1CvmQL2M/crVrTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200079; c=relaxed/simple;
	bh=fybVEtCas+7DMsFNUiwkqaOZclGA+uKG6xT1qFhkCLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lt24aYLRtwtAg/45neX4Cwjibol7VjXppZGGYonm5BmgEXNZXs0VjM5cCiMuRwBZlNwWs4+0EST1eGf97/fFqyKSmRblf0QXe58ehzxhDvuuHkxwA0bs9bLrx0397lzzfvNTnlhEfsG2vnFJ5B4GVzfgBME7/4ySozLcayWLpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2/SKNUr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2/SKNUr"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so241327a12.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200077; x=1792804877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BXXtFQVJAY0RHO2SY4ciAs6hnS36rdIEF3aYK67XVQ=;
        b=l2/SKNUrlD0orOJWsvC+LPvBIXDMc2/5Z7F6z1H6qOqWFXFIbpXK+1zYWU3tf8GxOX
         TycWC4ip/+LABwLy54Paw8X4F/RQRYE/usXwhohwD0XKEnVaP7gU6rgHs3zDcvbh5tT+
         BTCYC6CnBEonlqaUbXML3E07zaXnkUICopyH1LxwnuDksOWWtNB3XTDJCeBTbhzPCI+i
         igFImxmrY/Z6Irv9hnolgUMO/zV1yIIGQ+D2PdbZWFcTVAFz84l7KRSoSQmC2hDqalem
         1RE11FR1YhTJJWAS2N8cqnAxuSNaCpzEoQAe/PbhroVOPTMx6wAT/0SSqdT+xc4gr9KS
         dgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200077; x=1792804877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BXXtFQVJAY0RHO2SY4ciAs6hnS36rdIEF3aYK67XVQ=;
        b=1lSWM0/uEyfDvyh6xwtiZuc45HoOjjUFNRZ7+Pt0thEpXREoZ0c1G/hc2aC3ggCeLJ
         zjJwy9qCfIOL5wOJ/X08x2IONgzdtZ97FPDuqI4z2g4RC1W4ODCceJaYqf7SXRyouYJP
         JWYNwDIAdc29wcC1iOJ+0hyXReLZOxh5iLyWHaIjm3azmjQko7uIPS5CgqpzhfSvjwtU
         9YhEWtslYgoiaQ8ak9JWejUP2sZKO92QyWIRLC8wWtIwPbbyxN0kMFKU3YERKOf2bvC9
         gNyt5elQBPjToBjTJ9ioQ0JqYC4ZKHHjQlwj9NKoPwDI55lPVYr1n8MM+1ZnACHTeqqt
         iydQ==
X-Gm-Message-State: AFq9FYLcQwMAZul8A/m3jHhXYOJiTAqxiwm2gF5tzbPFkq9uG7pd9jfw
	+cfu9EkwD3uz4tqB4AiVCweVtyNeQH/hSZ/wbvD2RLC5bah5sV425kPl/unffdPC
X-Gm-Gg: AYBFou2OLtMzCDQZn4Iw9ZHbcgPbmdcbsP6V/JV0el3xcjfeBr1o++1pgeTkgbnMvTy
	1FQeLGOxSLBKSfFjMWOM5ZfZiXgMBwnBzpnoRCw3QK3gXLNrF2DSN60vRjToAc9Aga7OXHf62G3
	QxPtqm1cxKloKQlyPCVCkqulO0HsgNS2Z48Qepw40o5iy3Es7DoFsKqpsrXLzwsepr+8Oe7IsrD
	dU3uq+i/RoXrLT6pMMnYgNwUFUNNN56zcTKJI89MyBL8qlFmup6lCgT2G3uzsgOaU33d2d4vAfu
	UhMqZlN53/h2BBmBli3GSxDwd1QR7UlIrIOTZnnIkAChwOKS+SZoYmG/hkjOBEDzo3kMoLvAEbF
	IG2jnRsXfpT+fliREUtql11G+48PL184n698JvSFRbzQK9MeVAmT9IJwnzxdI6e7gcc1GoysuA1
	vgA3tlUZ78kcxkwElrEL0SKOhzJbtBHgzkVr2XRzjusg73xlbA4zKGa+ESNOT7WY60Hc0qvrH4+
	bHf0nFZz8p+B0lg6FltlpYbHJw3FQT9jMqRujNBsW0t/FmhxZJnU2acIIt/TQDwtOgx/3xCaI2z
	VEpCpcrHdmgxaRbZ44+lu/yoDto2BiwjyjO0SrjT7jY=
X-Received: by 2002:a17:90b:28cc:b0:3ac:a11a:7c8d with SMTP id 98e67ed59e1d1-3acef542f93mr1219976a91.59.1792200076490;
        Fri, 16 Oct 2026 18:21:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549b6171sm1733046a12.14.2026.10.16.18.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 05/38] bpf: reject sleepable programs for task_vma iterator
Date: Sat, 17 Oct 2026 01:20:25 +0000
Message-ID: <20261017012058.355787-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A sleepable "iter.s/task_vma" program can be attached, but its ->show()
callback runs with the mmap_lock of the iterated mm held for read. As soon
as the program runs, bpf_iter_run_prog() calls might_fault(), and any
bpf_copy_from_user() or bpf_copy_from_user_task() it does may really fault
or take mmap_lock again. With lockdep this is reported as recursive
locking of mmap_lock. Without lockdep, a fault on the reader's own mm, or
access_process_vm() on the iterated mm, has to take mmap_lock for read
again. If a writer queued up in the meantime that blocks behind the
writer, which in turn waits for the read lock the iterator already holds,
and the read() hangs:

    reader (iter.s/task_vma)        other thread of the same mm
    task_vma_seq_get_next()
      mmap_read_lock(mm)
                                    mmap_write_lock(mm)  <- waits
    bpf prog: copy_from_user()
      page fault
        mmap_read_lock(mm)          <- queued behind the writer

The reader waits killable, so the hang lasts until it gets a fatal signal.

bpf_iter_link_attach() allows sleepable programs for the targets that set
BPF_ITER_RESCHED, and task_vma sets it because cond_resched() between VMAs
is fine with mmap_lock held. Rescheduling between objects and running a
sleepable program inside ->show() are different properties, though, and
task_vma only has the first one. The open-coded task_vma iterator does not
have this problem since it hands out a snapshot of the VMA and holds no
lock when it returns to the program.

The vma handed to the program is only stable under mmap_lock, so the lock
can't be dropped around ->show(). Add a feature flag BPF_ITER_NOSLEEP for
targets which can't run sleepable programs although they can reschedule,
and set it for task_vma.

The check at attach time is not enough. BPF_LINK_UPDATE replaces the
program of a link, and bpf_iter_link_replace() only compares the type, the
attach type and the BTF id of the two programs, which are the same for a
sleepable and a non-sleepable one. Do the check there as well. That also
closes this way around the existing rule: so far a sleepable program could
be put on a link of a target that doesn't set BPF_ITER_RESCHED, like the
hash map element iterator, which runs it under rcu_read_lock().

BPF_LINK_CREATE of a sleepable program for the task_vma target, and
BPF_LINK_UPDATE to one, now fail with -EINVAL, also for programs that
don't touch user memory and have been working since sleepable iterator
programs exist. The programs can still be loaded. They have to be
loaded as non-sleepable programs, or use the open-coded iterator.

Fixes: b77fb25dcb34 ("bpf: Add support for bpf iterator programs to use sleepable helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h    |  3 ++-
 kernel/bpf/bpf_iter.c  | 17 ++++++++++++++---
 kernel/bpf/task_iter.c |  6 +++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..46d325aa178e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3137,7 +3137,8 @@ typedef const struct bpf_func_proto *
 			     const struct bpf_prog *prog);
 
 enum bpf_iter_feature {
-	BPF_ITER_RESCHED	= BIT(0),
+	BPF_ITER_RESCHED	= BIT(0),	/* may cond_resched() between objects */
+	BPF_ITER_NOSLEEP	= BIT(1),	/* ->show() can't run sleepable progs */
 };
 
 #define BPF_ITER_CTX_ARG_MAX 2
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b40eb404adab..fc3a75684ef7 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -72,6 +72,15 @@ static inline bool bpf_iter_target_support_resched(const struct bpf_iter_target_
 	return tinfo->reg_info->feature & BPF_ITER_RESCHED;
 }
 
+/* Only allow sleepable program for resched-able iterator that can run one */
+static bool bpf_iter_target_support_prog(const struct bpf_iter_target_info *tinfo,
+					 const struct bpf_prog *prog)
+{
+	return !prog->sleepable ||
+	       (bpf_iter_target_support_resched(tinfo) &&
+		!(tinfo->reg_info->feature & BPF_ITER_NOSLEEP));
+}
+
 static bool bpf_iter_support_resched(struct seq_file *seq)
 {
 	struct bpf_iter_priv_data *iter_priv;
@@ -409,6 +418,8 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 				 struct bpf_prog *new_prog,
 				 struct bpf_prog *old_prog)
 {
+	struct bpf_iter_link *iter_link =
+		container_of(link, struct bpf_iter_link, link);
 	int ret = 0;
 
 	mutex_lock(&link_mutex);
@@ -419,7 +430,8 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 
 	if (link->prog->type != new_prog->type ||
 	    link->prog->expected_attach_type != new_prog->expected_attach_type ||
-	    link->prog->aux->attach_btf_id != new_prog->aux->attach_btf_id) {
+	    link->prog->aux->attach_btf_id != new_prog->aux->attach_btf_id ||
+	    !bpf_iter_target_support_prog(iter_link->tinfo, new_prog)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -544,8 +556,7 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	if (!tinfo)
 		return -ENOENT;
 
-	/* Only allow sleepable program for resched-able iterator */
-	if (prog->sleepable && !bpf_iter_target_support_resched(tinfo))
+	if (!bpf_iter_target_support_prog(tinfo, prog))
 		return -EINVAL;
 
 	link = kzalloc_obj(*link, GFP_USER | __GFP_NOWARN);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 13e1aabe6f88..cf2bf388e181 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -737,7 +737,11 @@ static const struct bpf_iter_seq_info task_vma_seq_info = {
 static struct bpf_iter_reg task_vma_reg_info = {
 	.target			= "task_vma",
 	.attach_target		= bpf_iter_attach_task,
-	.feature		= BPF_ITER_RESCHED,
+	/*
+	 * ->show() runs with the mmap_lock of the iterated mm held, which a
+	 * sleepable program takes again when it faults on user memory.
+	 */
+	.feature		= BPF_ITER_RESCHED | BPF_ITER_NOSLEEP,
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__task_vma, task),
-- 
2.55.0

