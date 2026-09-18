Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F55421233
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722696; cv=none; b=TmO0DVjsFL6GVTt8ruA+cWjzW7vSRAKBjSu/a2kzinV252sOGJOBOAAdpuYcHiKMBBMldCQ+a8IUlALJSW31c5b42klDfAxrXtriDYnKbMKZVUUavIq/7j+dDcYGw4+fSjc+h7rxf43s//8ZkiIxiMltjNJPbTZD28qQrvtkfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722696; c=relaxed/simple;
	bh=FiRsDZdzGXAipkwSasDiwYJgNjGQw/oWZmESPlkGMAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvhtG5dt4cwpy6H3u6MMHLsDyPpqUI0Pjot1bchtBoDBxP8AWbiHuiUerqhsEyMFAt/zKgzSNtadaICQ5RPy28aDIZTk/528bqtlDvxSIrPsuWtpU7rnki+HL3TMU5KPjYCIfU+0HITwUS0UbW/J4z/nWbvjdHc13zezp1YiDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2rE5pUD; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2rE5pUD"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso7012285e9.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722692; x=1790327492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=T2rE5pUDUz9gW62Q9CEtdygORMnmqJzD+vHMPUpMBghWky+98FjqdE0KI+JQxBKuwZ
         AdzaGmZgbDdEcQWiqzLzysFYe3CmHlGVJ1/kCNXCdAR7eA4+2cxfuI9EQg+XiW1kX6oe
         qQ0AkGX2fK3h1e997cDE4Byemv5PbRoQwb5mIo0gnZyfduvu5n0bg49w8iXtLHEyVjPa
         9Dq8lisDk2bGiygJF/V7MG5Vv/b0jvkiEDOT+jXjVR9z4Gv2mUl2w6hujT+ZvkAPygnT
         t5qTDbk5BW4e+QbbL66WuTJuAuKaRrSPAqM50+bTDzD/KITm5W3bXJf9kXEm543AQMTK
         RK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722692; x=1790327492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=xngGbbt0NlkaahJ+pauktUz7dyV3b4/vydZlUQ9JwswWvghzDM8bI3dGPcSIGtvxjR
         1Vf4j1WsMkZp01Ju2Jslsi2TjtLSyt0sNI2M0MYwOna/sap33ApZvzRDlOI+ODqSeiOD
         cvLEQUspXldaCQ7Fw04EgFWQaYilr3haMoCOD8dyXH+oQgl5dnFJf1Cgvkg0hhsi31pW
         pOvNTPMUwyxMgkJ5dMHx0/eUCDHdVKmI2dWgkpgsO6m62FQ20WWz7MindMRVpAIb/gdm
         OV37p3ImXn6wIVo/LemuhaFbq9qK7jI3A7DCLuF/+O/IQsTa45M5BSWdJaHorbGDcpFr
         d+0Q==
X-Gm-Message-State: AFuF++k8EroVDqKhQ3vTs9x6xlP5EHtIuald3dDpDq6BT6GPg/aG15Yz
	ao60xaPEHtrddYOijkIxlCR/Sip8F1ZqPmBbxD+C+wrMDk9i1oMIs0MVPEL0M8cB
X-Gm-Gg: AYBFou2BIWode9qq39y7h/2Ya8/sIB/UAsdJxuO3vSZ7Us3mrfvP9HYL6vxIlQwttJc
	VYT4/YZXlo73aWfPcOluWzp4ofL1RqNpjEoNSCQHPEu7wTvxqvCNzg1OPXz3RJ7/a0ovUgR+w/1
	dzISGDccQxN8LhGbD8tkeKhWYbaojwdqCIsuVHnVIADLNywHp5Jsr2UVSlUWirHokobkazgXrmL
	lF2UbEfAxQKivhAmP6nV25Oa+Z9f+uHwNoXef37Er3rdp/rO8JPZLufjzCR7WzjNeNr/yVFgZDb
	mhgn3ClrFa+eWbar1gG3BencU/x3kUz0u/J4JA83DtfhlIUDoi+1wR2Trx736U9JHd90RVOupGG
	rFZDfYsiUyYcd5X4rU7P+jBx9gLZ45rJiAGQDUidZ1WwtQMzLArwr9pmpIBmMP//qkxUZB5cACL
	MuhRBw5cM0IuXML2hfR3s+gmY5kC7VezH/UX4qzzpn3qOF350ZMVU7fwDYBFwLfLH0T+R7k29la
	fOdU18LZ+KuTQko
X-Received: by 2002:a05:600c:3b0a:b0:49f:bd3c:bc20 with SMTP id 5b1f17b1804b1-49fc573b7a2mr19145175e9.27.1789722691708;
        Fri, 18 Sep 2026 02:11:31 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:31 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v8 4/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Fri, 18 Sep 2026 12:10:57 +0300
Message-ID: <20260918091058.297740-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check.

The field is either NULL or points to a live mm_struct whenever BPF can
access a linux_binprm. On successful exec, exec_mmap() installs the new
address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
error path clears the field before mmdrop(), and free_bprm() clears it
before mmput(), as ensured by an earlier patch in this series.

Update the existing LSM selftest to check bprm->mm for NULL before
dereferencing it, as required for trusted-or-null pointers.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-by: Matt Bobrowski <matt@bobrowski.net>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..3539a768b921 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5997,6 +5997,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6051,6 +6055,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 7de173daf27b..7441d66c080c 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -113,6 +113,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct inner_map *inner_map;
+	struct mm_struct *mm;
 	char args[64];
 	__u32 key = 0;
 	__u64 *value;
@@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 		bprm_count++;
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
-	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
+	mm = bprm->mm;
+	if (mm)
+		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);
 
 	value = bpf_map_lookup_elem(&array, &key);
 	if (value)
-- 
2.55.0

