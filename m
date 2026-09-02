Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB73769F0
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361544; cv=pass; b=F9nrZG2uekvGNrjiw5njams55R/ERcawR2LC2tx7Lf4qQIIlyZn/CPSJlzY7L9sW3eADB4ugOGHNChWGyBn/FaRsMlEWctYF9kCG9M9qxLkXB6rrW0rYMH0VCNW0k3SP/yJBK60YXEJ4RZWNPND3Ik934+kwQbNhBorIjthMfyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361544; c=relaxed/simple;
	bh=9vfrAX9QdLP02MpXYNzlfMqiNAX3CvZqO//ZbrSGtIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cbyy7ipHFB4E7pGiCMOFl6UDEbXmAzph/5WPcakqdCbD2T317RdAHqdDoDDYbXMqr6mtOrjPOR+axqFO95innjUVBLvQ35RmpyoVZ4aZe0mAG64DbEmUZgnjfy23KSxp4XNLYygj+kA1iPq3IQ6JLoO1vDZhFEob9ZxsIgOpwE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=lFWMtWrv; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="lFWMtWrv"
ARC-Seal: i=1; a=rsa-sha256; t=1788361491; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Q+SEHYTnfXW9s9C26rAwpgKyHSAsjp3U3W1ws026kfr3NxCutcmWvTm/mHBd5sHomb8v+3s8F6R1FsMDx+lZW0J6proHFcI4jN6K6umvavu1yQeuwjym9b3++bUBHa99wfqlrnm6+osaX1SXLKqKnoBLndNboV+GSJl5oCbASyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1788361491; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PZzMPScsXWSlSAae9UgIPeUp1UVPBl3vjq+5BFJ+UeY=; 
	b=VEF4KyEO3vwen7mRn96+tFXmnIC2HA5kbVIQj/kY1AwOWtWNqAsdqUtXyKig+M3r19Kf2UFfTZQND1UPdEPE3enG4Avvo/Qfuzr9x3jo1VnHcZVdy9mbSArMT3+RjYvU25kPgDJfqJf+A4FHN6ilN2MK920d54HV4UiP7oGHqbo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788361491;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=PZzMPScsXWSlSAae9UgIPeUp1UVPBl3vjq+5BFJ+UeY=;
	b=lFWMtWrvbTMxoZu1pqDhq3xuHNpdEI1Tf/JKy58TPx/aXILu96qhTVrNSW759/TR
	6iv2IEDni1ksKMZsFRGWO0DNkpi59A+znmlAZF+W3KA9ZVLwxa9bwp2XJKUvAP7gVSx
	bGnAq8V1bfNhdD+F+W3x29b5/9EJ220z2DzRBfu0=
Received: by mx.zoho.in with SMTPS id 1788361489769715.4053413254559;
	Wed, 2 Sep 2026 20:34:49 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	shuah@kernel.org,
	puranjay@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [PATCH bpf-next 1/2] bpf: Only check nmi_uaccess_okay() when signalling current
Date: Wed,  2 Sep 2026 20:34:38 +0530
Message-Id: <20260902150439.692725-1-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

nmi_uaccess_okay() takes no task argument and is a statement about
current. When commit 6280cf718db0 ("bpf: Implement bpf_send_signal_task()
kfunc") made the PF_KTHREAD/PF_EXITING and is_global_init() test the
supplied task, nmi_uaccess_okay() was left testing current.

As a result bpf_send_signal_task() returns -EPERM whenever the
calling context happens to be a kernel thread, regardless of which task
the signal is aimed at. The same call with the same target succeeds or
fails depending only on what the CPU was running:

  bpf_send_signal_task() from tp_btf/workqueue_execute_start : -EPERM
  bpf_send_signal_task() from tp_btf/sys_enter               : 0

This was originally hit from a bpf_timer callback, where the failure
is intermittent because a softirq runs on whichever task it
interrupted. The rejection is x86-only, as nmi_uaccess_okay() is
defined as true in include/asm-generic/tlb.h elsewhere.

Only apply the check when the signal is sent to current, where the
predicate is meaningful. bpf_send_signal() and bpf_send_signal_thread()
assign task = current, so their behaviour is unchanged.

Fixes: 6280cf718db0 ("bpf: Implement bpf_send_signal_task() kfunc")
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/20260819124324.43162-1-adi.sharma@zohomail.in/T/#u

Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 kernel/trace/bpf_trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..f7a41f222599 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -871,7 +871,10 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 	 */
 	if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
-	if (unlikely(!nmi_uaccess_okay()))
+	/* Since nmi_uaccess_okay() is only for the current
+	 * task, check if task is current.
+	 */
+	if (task == current && unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 	/* Task should not be pid=1 to avoid kernel panic. */
 	if (unlikely(is_global_init(task)))

base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.34.1

