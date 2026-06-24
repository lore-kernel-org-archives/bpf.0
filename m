Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63B3B47E2;
	Wed, 24 Jun 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293315; cv=none; b=KSSeL5jdylSsXc432m6fWJtih5L7hkvvgAfS4jF/a2Z/APeJGCrQR4wyGSph+dXa5x3fZKTdFFPXWAHNwdHdKQ1B0X/ps+OOV47Q843lUkmfEbMOJLxQ2yVi0XAiDZ8y9/fV/DigokDolRB17kiVZtG3ZMXUzM5sFnUOmSFaNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293315; c=relaxed/simple;
	bh=66af4jtR1ivMYaCroXmndu4LXkF04xDbWL+8wFZS4aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hwG3c5m8b5UEf0CdK41XJXyrLudofq29c92oXgXx6GX8pUADAWb0KKaSSr6iIMxM39qITxmFKx0p2MkWxiDMsd/9NVDRLBGKGm9f88XQd6TVaFo+XR/AOhQUO+15lPdGI4B2dwHf1uD+7PIVeKwiVtawyxJoPPiy64CmpR4TehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Hfaw+mKI; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Hfaw+mKI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=PHUJ0DhKQJLvQy2H4SuK9sKs0CUhgKdbb/J50pvlPqc=; b=Hfaw+mKInMq3c+vTj/vUZSlJQM
	K9W5RsWDsADXEsB2y9BpLeV/yP/SI4vKzy2lhREFdow+0S8AnQ6xHWwAypc1CHLHI8yyVsv0Xt1Su
	AHOXgXT4GpcS4Rke2ywSKvF/LboTO71NkPxlEM+v27zvQwubvKpUP66JDFGFhdxspRC6uFWKiTu4Y
	CWBqHL0yJm8nagTA46Oqh92ULZ/q0KM7r7EtCw6/aEySJiLlTZ3R41OLhjCCgUbnrhxtlqHd5Dkrl
	rRSUuA7FOSoW6tUHBXm2RfiP/g/zqBFqAjh4He5c463zWOtMn8enXe46bplABZTr3ZputMEpHN/V9
	lxEXcAbg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcJto-002KCs-2N;
	Wed, 24 Jun 2026 09:28:01 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 24 Jun 2026 02:27:43 -0700
Subject: [PATCH v2] sched_ext: Avoid flooding the log with deprecation
 warnings
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-scx_warning-v2-1-07d0d48b0d01@debian.org>
X-B4-Tracking: v=1; b=H4sIAA+jO2oC/23Muw7CIBQA0F8hdwYDSBrL5H+YxvDuXcBAgzUN/
 27s7HqGc0ALFUMDTQ6ooWPDkkETSQm41eQUGHrQBCSXE5/klTW3P9+mZsyJcR/V7JSSJlqgBF4
 1RNzP7bFQAiu2rdTPmXfx0/9PF0wwoWyU4haV9fPdB4smX0pNsIwxvn4wfTWnAAAA
X-Change-ID: 20260623-scx_warning-0df49c442afb
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=leitao@debian.org;
 h=from:subject:message-id; bh=66af4jtR1ivMYaCroXmndu4LXkF04xDbWL+8wFZS4aE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqO6Mb2qSCp8SaqaXn4fp4GTYl5OGK8x/GOwJyq
 w747KZ0u96JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajujGwAKCRA1o5Of/Hh3
 bc4dD/9tiDpM3ZcRzU5a2N3j4DsVC8V2G9AeUICWxEfRLXZUX7vG9ky6aTi6OwAKIv0q0JWfkYg
 rIr5xrHfLqirW92h1+2/lchwl7IFFnwyYlRXd3/zuaZTpQCO75IytUhQym4JBwueh9pK4Gb0v8x
 Sgx38jQC6WlmVmLt/tF2OuYt9+osRtiONtsJCTGAfSMtsEYSA6ZwRbbeBNgppALLcEL4xln4TAS
 u4+Iumr1qA31PvfaPnNbwJOLoFhz3SK3s9JQrIXnXeWFe5aqkOhRvJZcsOxp2W36IA7d3TPWJil
 AVEZWnWHsSy8m2XWNjrbVUBaNvBPMODVtEL2oGziSMtfGyBX2IKyl9qC/DjwFWIP+pjYUq5iMdA
 u+vy/y9+OOplqryVwyh9zo7f/jsAAZPDqnNpkytMm/pmDfSmTb1sZ6WegBs9q55pZwW6fGS+9tE
 J4Y00SAUpor0Z/zin8Nh6B74YkbLVQ0vUwk+S1dczB9XXiE8rZRN6T2K2gk2++IF4HKRTPk2Ioi
 0JxP5aZoFfsICRuXHvvU6je6ZQS2/SrBmx9joZY67MG+vrFuqfvaEDyz/hmqjs7XcLLnFAtNnSs
 ZLfecptyUMIRUHsGdXBBgGEmM8ubhyBNQAdlRGsAgjYW9311O2Bgb5bxP0IPRNyuRVH2eByUwYV
 RdX49yk1EpdJoxQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
scheduler (re)load and can flood the kernel log.

The slice/dsq_vtime notice is the worst offender: it is emitted from the
BPF verifier's btf_struct_access callback, which is re-evaluated as the
verifier explores program paths, so a single scheduler load can print it
many times -- hundreds of lines on some hosts, dozens within the same
second.

Switch both notices to pr_warn_ratelimited() so each deprecation is still
reported but bursts no longer spam the log, and add the missing newline
to the slice/dsq_vtime message.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Switch both deprecation notices from pr_warn_once() to
  pr_warn_ratelimited() (Christian, Andrea)
- Link to v1: https://lore.kernel.org/r/20260623-scx_warning-v1-1-14bf218f4bd9@debian.org
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f648..d62b93f48a854 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6988,7 +6988,7 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	 * run past the BPF allocation. Skip for cid-form.
 	 */
 	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
-		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
+		pr_warn_ratelimited("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
 	/*
 	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
@@ -7806,7 +7806,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
 		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
 		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
-			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
+			pr_warn_ratelimited("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
 			return SCALAR_VALUE;
 		}
 

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260623-scx_warning-0df49c442afb

Best regards,
-- 
Breno Leitao <leitao@debian.org>

