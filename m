Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508218;
	b=XVbzhPlXRNCKz07flgu1JUlLJBus/W/fp11lxIPiTw3pGex6DyrOZ9+UqQFd7pN5DiBz
	 uqYmLglOlAlS0+T/dgKpkhvHrBzp/NmiyU6YR8Q3F/gLXo7hLgVOF394LUNeQcD4ZJt5l
	 TH5k34LcnvveHocsg2iik2L6IaPJzPg3gu/Vcpi1W8t4j2De56+9fk2GTO4OA6Yiaw1R9
	 6Ftr1ZV6dcjgnk5OuV7M1aynBznyNAckAVRNZ2rX/TTe17dt4GOHTsEtVJU+NVRU39K0u
	 e/bVF7nCJGBJqHze5EG6skV5/DuoFqliy+ENAMB5WiLG+KUAlo1wqfuQckoWOyEUZNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=laKttaaJBwo/m3r8kgxAVHc0DX2pc7Yi6eXEgKH97Ic=;
	b=w/O93bwFYQa/8WSY+nCdQoTSbbYJo4vrLbknyPj+q/da81uM6dj5UdjwiBujk1Y15kxh
	 NtxWTDkqNZfJ4uwDDP0hTTgnHVHkXejeEawSHMBUX6WYYLCq0UiUmGH1D4RaNdfkoOeH3
	 +8Mp8vF+OJD/ioiDpzZPMBhG7mcRF+MXIGWeOhhZxMd+/BRS0sbcPxox+isYryA86dy07
	 kMYVw92eAqe42snWC2O+7gGCL+u24isJHRj57myOq//OpecCX/Etr701DGOxUvc5me5mZ
	 4q4xuiwV0R5OjsGdNJtPLGumk+v5ZZPHu7ZQI+pJLRiyhIDBveee9TMp+mhXYrzhTuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ii0ttB8c;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759860A2616
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E759860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ii0ttB8c
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67583c777abso913588d50.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508217; x=1793113017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laKttaaJBwo/m3r8kgxAVHc0DX2pc7Yi6eXEgKH97Ic=;
        b=ii0ttB8cIcGzP9zV3ZREwiZ5ofLUSuRspo8x7HONnAj3oWU0jYjhkOa/v7vOCjs+Sr
         EnyqsV9KbaqLvrJRC4HwEgG/iOiSqyjJkxxeTzW57KuL4MoOm4QEbMTqRfMGZ/SftxQf
         d9kAZjd2Phz/oKZfH8XpVSQ6Gg8jeAJRiwp9dFyrimBqXAhLSWlPTWHr9lF4cDVjBAxv
         u9nIdUOXVNziD9y6GC4aJ3pqfja0SDZMDMaB6EJsRHhRE6KEa9w8MEishbqsEZCMXYWT
         xCdwGDPn5JumBc6ikxG0eQ/GYWUeyj5sKkF72ZxmJEnxWSS3GPbmcl+ceeJXnB/WL3Nl
         7Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508217; x=1793113017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=laKttaaJBwo/m3r8kgxAVHc0DX2pc7Yi6eXEgKH97Ic=;
        b=wAged5JMbBU+xmhMT9abgcP5GUcviUZT57YwrGTC1AAgVAmeWxzdFl1zry6HQ4IY53
         a4Zn3GbUzW/p/HmG6VieXXLZbYbwolggT+ncPfMozHQDJ1zUnpoByjBDQDp2bMSGubSo
         A/raGWIHJrssOPtBYHz/nVM0kgc5zgvLsR4n0lL1aaW/gRBaktm3CmeKW5RIHMdIfp0X
         SenR0bxXhPojWh3mS1PRuzxYPH8NNrdhsOnroPZPDaXkLv5U636wcVZ3C/asCk8G23n+
         innZnx3ta17ZbSWV6BxssAv6tmbftX+rsQeBLfCvyQmhG57iVkK7hDR7uxFE4i80McZt
         WcNA==
X-Forwarded-Encrypted: i=1; AKwUvBwEH+u35PG3voSkQGJfClGjiUeQOh0WeGxpd+ALxih2PUcr+EJ//UYGvCwBE+eLNE4+QEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+7gYw1UeNK8Sgzy9cgDbJKGbobh2zGuaepNu4kJS04HvliJ5v
	bRLg2239a2ue0dVEonr5TpPnqcTznE859nlbg7r7DZu1vDZKBqw4OcDy
X-Gm-Gg: AYBFou0jlvw7iNMgYvQ7FPDtGVstsgC2I4yT1S5FXm3qzrR+c34JEDXkz5Gn/ulJuEn
	OYryE+1hFaLoC919HUHearccnFtTzbBZHspU7SVKMz1WnjRCS9+NRgd0yRl1yYjcwN4OuF889+t
	Yse+xgm1dpNYw62b1GbBaosgBwo2sTsN9vRhzV1/3ePZ2OsShFbt/7oEN7wAz1wVis5/KRSqi6N
	WwUYATEJrM+DPKLibpTYpYsnYCrWcBWADgpERGIUsbVuT1TSWAKTslfylvC7+1yhAMmSeV+goC1
	6UeI8RROIcDZByeoSoEfaz2sW0Fjo/MMzIzkZ19p18MDPUL19gIJuCcinKDu06GEjFV8hL3kQwr
	TRr3CdZxu5J+MoVCsplRFc8jBc99Gt3y1iheJ5C/zavORqDk9RHXY0dU34mwOe1gLBo9NKt9o9N
	wimwM/6hOiSqhZK27s5CHKKJTA0O4WXmiNqPXyX+Opfq8GLYHzD0CrP5tkuAGQfZ+FOB8NyOZtO
	LqNCx364Q==
X-Received: by 2002:a05:690e:1918:b0:679:9b73:bfab with SMTP id 956f58d0204a3-679fc08c394mr899178d50.43.1792508217007;
        Tue, 20 Oct 2026 07:56:57 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:56 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Test iterator element invalidation on destroy
Date: Tue, 20 Oct 2026 10:50:59 -0400
Message-ID: <20261020145059.2146170-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020145059.2146170-1-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save a task_vma element and a trusted field walked out of it across
bpf_iter_task_vma_destroy() and check that both uses are rejected, and
that the existing operations already allowed before destroy are accepted.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/progs/iters_task_failure.c  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index 566a1d3dffea..f9c149b4a2d5 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -14,6 +14,74 @@ void bpf_cgroup_release(struct cgroup *p) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
+__weak int subprog_trusted_file(struct file *file __arg_trusted)
+{
+	return file->f_inode->i_ino;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int iter_task_vma_use_after_destroy(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma it;
+	struct vm_area_struct *vma;
+	unsigned long start;
+
+	bpf_iter_task_vma_new(&it, task, 0);
+	vma = bpf_iter_task_vma_next(&it);
+	if (!vma) {
+		bpf_iter_task_vma_destroy(&it);
+		return 0;
+	}
+	bpf_iter_task_vma_destroy(&it);
+
+	/* The vma snapshot lives in the iterator and died with it. */
+	start = vma->vm_start;
+	return start;
+}
+
+SEC("?raw_tp")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+int iter_task_vma_file_after_destroy(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma it;
+	struct vm_area_struct *vma;
+	struct file *file;
+
+	bpf_iter_task_vma_new(&it, task, 0);
+	vma = bpf_iter_task_vma_next(&it);
+	file = vma ? vma->vm_file : NULL;
+	if (!file) {
+		bpf_iter_task_vma_destroy(&it);
+		return 0;
+	}
+	bpf_iter_task_vma_destroy(&it);
+
+	/* vm_file was pinned through the vma by the iterator. */
+	return subprog_trusted_file(file);
+}
+
+SEC("?raw_tp")
+__success
+int iter_task_vma_file_before_destroy(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma it;
+	struct vm_area_struct *vma;
+	struct file *file;
+	int ret = 0;
+
+	bpf_iter_task_vma_new(&it, task, 0);
+	vma = bpf_iter_task_vma_next(&it);
+	file = vma ? vma->vm_file : NULL;
+	if (file)
+		ret = subprog_trusted_file(file);
+	bpf_iter_task_vma_destroy(&it);
+	return ret;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("kernel func bpf_iter_task_new requires RCU critical section protection")
 int BPF_PROG(iter_tasks_without_lock)
-- 
2.55.0

