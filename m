Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051574;
	b=fc8bfHIuxO/9hi6QXIjRI4x1+I2uqjYYlYSNvHhflP9lbXhe0Sd1Fh9+w5fDrkj2Fi8n
	 ikBmxbICYAMAl6ndzOixLVkZbHEp5xFe8SesuBoPa8t12wNIqrTIbcXIxjUOWLP0Pqngk
	 cqtTwZSuHQoLK8zMEsfHfEs6lsVw+uQx66UBqC/FZS/Vq0xcUOmHc8tREMbNOQJWrFqf0
	 OdFutg5gPbSvNeDvFXV/J5xAQFIQgX2gwMpDAeqinpK+FyCLC6V8lO97jCLB5oWV6YNSa
	 KLhfoys2LTlwg7SAGy2W/WirEOBhvcKDed0I7rp5MoLHK5DQJLD9sX+ZpnL+9wCqtQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oogWXdI71uSApWoisQtM4clnwhLv0Vs2bmtqChsuYec=;
	b=RCtlHm9pg6caW9Ps0uG7bJX1vRWy9josmiVu/VXu7J4+2IEgseRk0gmAZ+rBddHoSRGF
	 f+akup9B36eaenLwxZhKGBd1Xt2YAm7ZR6umw3d1/3VTio+tO+2R92Raf7iBtb1Q1jOBl
	 v8NRiJScm61Og0eCXgyzqGLfUl42QuYqLlEChjWFxqwQmUaqjROjPc1uwIWikYyqJO2fg
	 KIVfABrWxp/OjVslDENygSr+NaNUiWXQpVYRTZy7Oc0+5UEJyH6cNRIK2hqwtZPZseqWz
	 hyfbbBnkUWlPiClBMA7KsyyuvcompiSUZdE9tDB0SOf7HtkQ7WzmK+12eOyABo313Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sJPCAyGd;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFCF606A32A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFCF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sJPCAyGd
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so4489081a12.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051570; x=1793656370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oogWXdI71uSApWoisQtM4clnwhLv0Vs2bmtqChsuYec=;
        b=sJPCAyGdVEm2VhcvIBWqxKdB1ov+NEHAo0t+uGAM/0+qDIoJvuHm7nefnhKXLbxfZu
         kkzdd/4AnoA114yH/wBhWFkj4bhnTFD/5geQjiLBoAkwcMG8cTAN5yffgV7X8VZkSD6k
         UqJP6p4PAxwVl8yTZ/Y+9JixBhYbVYFxenEyF+y0YO2Y9TO0Q2mOae4aV4jUlpGMmFIH
         Y+Azcs1izJVTuxuoeh6BKO/iK8Vap0RGSadypMKvAjvOIsUEPKwpqHb793AvWJQkjEjp
         +fWxRFzb1QlgIgm+QlrlfCdAQHISYeGneT49/PFezT8s3UQeSh2Ep1POwSjeCezfL9SA
         lQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051570; x=1793656370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oogWXdI71uSApWoisQtM4clnwhLv0Vs2bmtqChsuYec=;
        b=XkqrGaRXXrrvrtgyUriSj9HYG+3hd7RHHAAtTsELJK+T1UJBhwv/80VK8UpJ9Bvux4
         BZS66qlAQwhd3OXNjWCKuHw+vO+3bHcuf6aQ0FOOneeEae7MlTSzD7LAi3IYZ45BLrsH
         cZ8ncLIWLrPgxsPeVaoHbh17KNzN1zWNm6g8sHAsX3cWckp7f+1qfPzj9eJxYC6VU9Ng
         A+5Oju9ph7xxFuntYhn5T8sjz5U3oEHm6nC2b5IydvRbEAazLSksOuBjCv+f6Er8G0vs
         cfWeJbNrZDIDRnW+r7X9DoJTTeomgUrS7b8qpF1UsfOjBlZMnSulKXiv3j4yDqRk3gq9
         6Hqg==
X-Forwarded-Encrypted: i=1; AKwUvBwBKFiHS2prp+6pmoPZRpiuL7uoSboIusAWyIxJlS/ZOT3OAK2Y1sdt6cAIJkXRYKhepks=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq7c4VrJLh70tPLvC/69QgK9YSO6r3lvF6fCNr90jCzKbHQ1Z2
	unbZiQ9b1vsFEiACr98onATSUp7w64dIpmpcj8p4pBcqbfjVoAd590f8YbCZa5lTJNtJ5X9A413
	dyjuU9vUNhb1fWjutLQaP+Q==
X-Received: from pjbml16.prod.google.com ([2002:a17:90b:3610:b0:3ab:54fb:2a3d])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:56ce:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3adeaae618emr6704272a91.10.1793051570356;
 Mon, 26 Oct 2026 14:52:50 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:19 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-4-jthoughton@google.com>
Subject: [RFC PATCH 03/10] bpf: Fail sleepable user copy helpers when
 current->mm is NULL
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Sleepable BPF programs can run on behalf of a kernel thread, or of a
task that has already gone through exit_mm(). For example, bpf_wq
callbacks always run from a kworker, bpf_task_work callbacks queued
late enough run from exit_task_work(), and lsm.s or fentry.s programs
may be attached to functions called during exit_files(),
exit_task_work() or from kernel threads (e.g. security_file_release()
from a kworker running delayed_fput()).

In such contexts, bpf_copy_from_user(), bpf_copy_from_user_str() and
bpf_copy_from_user{,_str}_dynptr() (when reading from the current task)
call copy_from_user() or strncpy_from_user() without an mm. That access
does not reliably fail: the user half of the address space belongs to
whatever mm happens to be lazily loaded, if any, so the program may read
another task's memory.

As there is no user memory to read from in this case, fail with -EFAULT
without attempting the access.

Fixes: 07be4c4a3e7a ("bpf: Add bpf_copy_from_user() helper.")
Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Signed-off-by: James Houghton <jthoughton@google.com>
---
Tested with a small bpf_wq reproducer: a SEC("syscall") program arms a
bpf_wq whose callback (which runs in a kworker) calls
bpf_copy_from_user() on an address in the loader. With the uaccess check
from later in this series but without this patch, that triggers the new
WARN from bpf_copy_from_user(); with this patch, the helper returns
-EFAULT without warning. I can turn this into a selftest under
tools/testing/selftests/bpf if that's useful.
---
 kernel/bpf/helpers.c     | 11 +++++++++--
 kernel/trace/bpf_trace.c |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 712dca5a2c5b..c4aa8bcaf2bd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -659,7 +659,11 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
 	   const void __user *, user_ptr)
 {
-	int ret = copy_from_user(dst, user_ptr, size);
+	int ret = -EFAULT;
+
+	/* Sleepable programs may run without an mm, e.g. on kernel threads. */
+	if (likely(current->mm))
+		ret = copy_from_user(dst, user_ptr, size);
 
 	if (unlikely(ret)) {
 		memset(dst, 0, size);
@@ -3642,7 +3646,10 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	if (unlikely(!dst__sz))
 		return 0;
 
-	ret = strncpy_from_user(dst, unsafe_ptr__ign, dst__sz - 1);
+	if (unlikely(!current->mm))
+		ret = -EFAULT;
+	else
+		ret = strncpy_from_user(dst, unsafe_ptr__ign, dst__sz - 1);
 	if (ret < 0) {
 		if (flags & BPF_F_PAD_ZEROS)
 			memset((char *)dst, 0, dst__sz);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 88c3b5b513ab..793fb3dce5f1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3556,6 +3556,8 @@ static __always_inline int copy_user_data_sleepable(void *dst, const void *unsaf
 	int ret;
 
 	if (!tsk) { /* Read from the current task */
+		if (unlikely(!current->mm))
+			return -EFAULT;
 		ret = copy_from_user(dst, (const void __user *)unsafe_src, size);
 		if (ret)
 			return -EFAULT;
@@ -3590,6 +3592,8 @@ static __always_inline int copy_user_str_sleepable(void *dst, const void *unsafe
 
 	if (tsk) {
 		ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_src, dst, size, 0);
+	} else if (unlikely(!current->mm)) {
+		ret = -EFAULT;
 	} else {
 		ret = strncpy_from_user(dst, (const void __user *)unsafe_src, size - 1);
 		/* strncpy_from_user does not guarantee NUL termination */
-- 
2.56.0.307.g5fe7bd680c-goog

