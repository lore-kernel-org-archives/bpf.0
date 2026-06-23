Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B30395AE3;
	Tue, 23 Jun 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225551; cv=none; b=YarZSGOEaadyG0Yjvskts+alpmyaeTZC+hDvGE18FD9b/IHUWxIvL5DtpoBrXlS5ArV3Q6OMeekxo69uXWnnWHVl/irQSpqInObApu6mXpx2qJ+mxXVzs5r9V9gWQghwgEZQ2ts2vpY1k7m3kzM+rZUBVNSMVrGF8E1y6tSjPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225551; c=relaxed/simple;
	bh=TzACNddQ5TEQEyWSbfIt2z0l1PscuTuMebn0ZJeptR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gOEwlyHEZvmf2zwN4BDkkL9+N6DPfqnOW6UkxvSYmapgTmxn9JWnLWRyN9KpJjhQCjEOVhZxpPNVfni1VVKwwyneRgOGFphBZcEHqA5B48iU/N0iiw1wvfLax4VGoOxA4G0sTi4ssYKloIwkd2TMH7t2CB7XwUiUIZG/rjIfceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Tyy0e45K; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Tyy0e45K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=kGMuDCEzBXBnfsspPsVSaErTuPATwEoz6IFYrK+CMM8=; b=Tyy0e45KTxWjxBYib/8hlb0Tev
	vA1XVCxPwQYRTK6VuwUccK0pkXkCaXCJEjj5iafNUZLOFR89J5h47mR009FORgyl4NIcGV2wRjQsx
	S44lW6tV3Kqwl2aTyrR6FN2vAP9PAYyZEdRs6Jd3BmjygjQ5ri709DSFWmfSqF8RWS5z5Pj/wi6vd
	99vo9q7HTa6QiXOX9xCjzSrgtEoWPwPzFphlBlLLjjj/W4l9UXxEL3gDaVSpTT5O5k78n8UmCe2vo
	BTneAkh84ZGn0KbAzWqvmsTFjTIaygc1gmPCIKCXWm/o2kbba6IsFVdNrQDZwVtiKk4gAVn4GPJzK
	JP0rXLNA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc2H4-001ic7-2a;
	Tue, 23 Jun 2026 14:38:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Jun 2026 07:38:43 -0700
Subject: [PATCH] sched_ext: Print deprecation warnings only once
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
X-B4-Tracking: v=1; b=H4sIAHOaOmoC/x3MUQqAIBAFwKss7zvBTIK8SkSYrbU/FgoVSHcPm
 gNMReEsXOCoIvMlRY4ER21DCLtPGytZ4QhGm173plMlPPPtc5K0Kb1GOwRrjY8LGsKZOcrzb+P
 0vh9EJBTWXQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=leitao@debian.org;
 h=from:subject:message-id; bh=TzACNddQ5TEQEyWSbfIt2z0l1PscuTuMebn0ZJeptR8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOpp1hDCIqrDFGN47l61dAWMctxN5R+WYn/2Qb
 ZXXLtObrH6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajqadQAKCRA1o5Of/Hh3
 bQxOD/0UyZhJeorO+MxcCmbjzGsMVjA6nZ9JWmKA0zG5Y5RVEqdcMORmpX+h9rmeQd3Kse2B2kb
 bm+DWxbsUWh+Z2DPNq9qobj+wPz6uME75jk7e23Lt8m5brwAxJ29SClxwWriKSOnR9CS1ajLxN+
 0SF0LAtlY0ZPYLS6cC7I4DL3bcXkc/vhjo2D//EvUcFYY+LwMdQvAtyTWoF2YlMqMYyIZ7iyF3w
 XTybvE2sKyNMkmBL6Crzz4/urJmqiRJsDe/T2ND0gWrGHOisZFEZb6mRSdL9JysDmYUUXwjjLBj
 nXJgtJ/dq+lBwq1nB3MZjNOat63cq3nVV8OYGyH8eGOWDFpERKTGfg+4qFJkart4vt3qb3TR1Bs
 t4dU9Tt++zzAn8wr/unnmysqMIhyYyJt3WgpHiGtjKQXAiYJ/jJGeeZNDLMW4tcfajrQuEvaPRH
 9TsoHPDXN2uwtlqv4rA+L4+1Y2z5acis+6i6/fbyxCPPoLXHv+TDLXynSWaXkT22gUBCPVi1BPY
 zdh3Khn2eTr9TYhLL9wZ4BzqAF8RcA31eUepfotdGTUq9Vh5rzRwPRvgp6L08zB6eEhYvC6er/j
 2QIuneDlYSdKnUtK/solt/+OCxvhSxo2LPXbUTtK2JlvTxlrdghMx+n7/Ru2pQkfR3EAzwqoFGr
 OHCHMKQ9HYehL5w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
scheduler (re)load and flood the kernel log.

The slice/dsq_vtime notice is emitted from the BPF verifier's
btf_struct_access callback, which runs once per write access and is
re-evaluated as the verifier explores paths, so loading a single
scheduler can print it several times. The cpu_acquire/release notice is
printed on every scheduler enable.

Switch both to pr_warn_once() so each deprecation is reported a single
time, and add the missing newline to the slice/dsq_vtime message.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/sched/ext/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f648..708eb9024cb25 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6988,7 +6988,7 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	 * run past the BPF allocation. Skip for cid-form.
 	 */
 	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
-		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
+		pr_warn_once("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
 	/*
 	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
@@ -7806,7 +7806,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
 		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
 		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
-			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
+			pr_warn_once("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
 			return SCALAR_VALUE;
 		}
 

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260623-scx_warning-0df49c442afb

Best regards,
-- 
Breno Leitao <leitao@debian.org>

