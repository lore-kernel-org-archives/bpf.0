Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B74C650A
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999082; cv=none; b=LXF0ZKKcXWd/OqWiz5YRWOIjXtNV+rXtTjUD/hm7dA6PCk83/nd05agbOyHUXVeT1qS14E7vsNwfHH+SC/8cqfeBR/n10FG0lcM59LZEwwYhNEoAg8VDW6odLv2Z9+RZQJysTPe0nXUS5oJsaHWzvx8MIlgqh7tnFJMMOery3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999082; c=relaxed/simple;
	bh=xTi5X0Kostwx223sHC3Xpd6yQzSJn2RaF7C4B4Dj/oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWFK0TA+7M4mHIJJ/uEv/01HxCjUcQMaP5JJLM4Tzdp+BoHjmzNEpxnIgQ0EPYw2Zrvf4dcqaZ9Z2WThDdMzP43RhwSk2EH1fxU8fM1w9zAAh14dUMX1jSXQ3607HRijZ5uWe8OWwcz5rI+0I5Cn7Mvz98vgGmtJgTBll2XUV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRCLhxaq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRCLhxaq"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8871ada1a26so11342867b3.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999078; x=1792603878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gZnKyp5IrwUbmqggAV40Lyz3JT4SFSg1pHZfiTPlNs=;
        b=TRCLhxaqxAzmJDbswhgambein7agh3hcpfWuI/TOyLMGIL/dxIo98M8ECxpZLN7hkx
         vTMFdbdoC2c0P7Ou66FeoRKulTvf9/b12HnLtFSI2/FtU+VK/gl3k0OGALIAWiko+2mF
         xRwlwY9ENuQJ1bFLmH4O7NmU6xzNROFPH6s3BdQbR4zqKJABX3w3Z8jElILq7ON50ecf
         ND3kskot6NIXNmNMAhjBgxMkCk5yezQcGFVlFW3CLRhiXByb34of9TEld2SYKv9We02j
         WJsBn5TGDk4nDu6OhGjCVedBA+ciVHGvDUIDWNejFGgFJPOzMVKnqCKtj+ldCRtZXYxT
         ap3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999078; x=1792603878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gZnKyp5IrwUbmqggAV40Lyz3JT4SFSg1pHZfiTPlNs=;
        b=aSrosDWyoiKpklID57Rwh91vMrXAMVd9j8o6VAIUKtB6r/DCKlhec7KgIoqQ0VQsqC
         HFdJAvopzp9qJLXcK6grtrKxpZ+r5fqFm4THZLl9JoG5l1+mlC1GhlwzZpRysLTyj6kY
         tHrAtT5foKOz09BB8CVLv4aXxeQcmv7aoOyDxjGglVsSGlwNsWriSQWPrPbHhe+mI7q2
         0Twzg6JJ2zBolnf/Jv2GY/yZcjRrBZ2xuHIfbXdiNqZaPERR70X8LiS25gDDwO2yRSLZ
         Id0pZWZXwUS1ZkAQWaHuv5Os68LyVUPJlJc3T4HLZgyOETsoU68gjs06IVM4RyuejxmF
         bhDA==
X-Gm-Message-State: AFq9FYLKAHB6MdwV4Yxg5pCTZXfqDbuAhueL2vNh41Pid8vWRP0wmo3f
	T1GCQC0c3jWIk9oWQ3BGlNEDuZSzByWjZLloksNvnCwq/hl0cgA4VqVR
X-Gm-Gg: AYBFou0EfWxHsHRTqU74H9fy+Ka6EfERKjOeAe2jUKxblH0m2kdSMlcolIgHuiI/Kh/
	QkI1S7nhBBeVX+QEv3l+uj2GOsgFrbuHvvrz2ekDj+FrUcYpkvqOlSh6TzcWgX/m1bBzRMbklLH
	553ZTfF8Pq+KwfXpdgLxlQhRZq4jMm01V1wqCN4bhNjtuVTb2XhG4zSp5DiJyGU/69OGTiibw/v
	NY9RwUhY/xG4AvANQIh4SF+iGC0MiVQ2LuwK9bs5UuAmZjMzkccxJyrPeVG25Od6ERb/tFMmAnm
	+EOiUYO4r0iQG1I2KwJ7xbQXA1qUKzvISuGYnCSZV740jlyyp1r/erqoTSJVy1N3++N8zDi3brv
	AljYWlhzzFuJU8ZDoAz6m2rX1jp098pTyDZOYFkOYyyk8wwoJSY3TOFMKnkRp2XreHVFbB8uIO7
	jrS/orkvVaSvA9f6z6jk0otl8a9iLrOOI/64IVxOJBz7aRIMMeMBSuCuZb75RZnGRt2tnrvVkwO
	w==
X-Received: by 2002:a05:690c:e3ce:b0:8b0:ab57:ebe8 with SMTP id 00721157ae682-8b0ab57f332mr28247347b3.27.1791999078149;
        Wed, 14 Oct 2026 10:31:18 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8784:7d62:1705:ef5f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a66262sm1277803d50.11.2026.10.14.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:31:17 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Test trusted-field invalidation on parent release
Date: Wed, 14 Oct 2026 13:30:39 -0400
Message-ID: <20261014173039.3666415-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014173039.3666415-1-utilityemal77@gmail.com>
References: <20261014173039.3666415-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walking file->f_inode out of an acquired file must not outlive
bpf_put_file(). Add a reject test where the inode is used as a trusted
argument after the file's reference is released and an accept test
where it is read before.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/progs/verifier_vfs_accept.c | 17 +++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index f519ba5f4ea2..d7e4fc658fea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -123,4 +123,21 @@ int BPF_PROG(trusted_field_used_in_rcu_cs, struct linux_binprm *bprm)
 	return 0;
 }
 
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(trusted_field_used_before_put)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	ino_t ino;
+
+	if (!file)
+		return 0;
+
+	ino = file->f_inode->i_ino;
+	bpf_put_file(file);
+	__sink(ino);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index b71ef8ac1798..c35cf9800f0f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -203,4 +203,23 @@ int BPF_PROG(trusted_field_escapes_rcu_cs, struct linux_binprm *bprm)
 	subprog_trusted_inode(inode);
 	return 0;
 }
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+int BPF_PROG(trusted_field_outlives_parent_reference)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct inode *inode;
+
+	if (!file)
+		return 0;
+
+	inode = file->f_inode;
+	bpf_put_file(file);
+
+	/* inode was pinned by file's reference and died with it. */
+	subprog_trusted_inode(inode);
+	return 0;
+}
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

