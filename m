Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9132D6E6C
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143491; cv=pass; b=Br5/SKCA2vhskKvM85t3k17DRRrZsT6EWC9L5Q7Dvp6rgPPBb6vSKQl5xkFSSiYP7Ug1KEHk5OLV2/t+ZC6ZTJO8gcSIU54cJCe/GuWaM28/K5A81x4wIsbNPDjlyouRCBcu15I/lTYT2nOiVhfmLOLHczyoPVydeYPrsnpxN7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143491; c=relaxed/simple;
	bh=iY5LqCI1AO9guNI4PtSt9FM3/7YEJJCDxmhlmHedFnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZbL9d7ZB0O8kGakQ//IHJC11vQZUMP+qaDa9olmNechH0VWtZONxCCGA6mDkFfE+mV8vuu1RuQNZ2Re1qkHGXRScJRGLKzUZAC/J+jGUK49bxbhDZypA2pejxgv+y/w31A/K/2M4cnYpRJBgUOVZNC9colV5KwY0hOXCv763SOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=GmRIftV5; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="GmRIftV5"
ARC-Seal: i=1; a=rsa-sha256; t=1787143441; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=G7JMsmLounAgasN09JbCn09qY1VElQQGT9ZCxUXA7k3BpyFmxL0GVoTOqVJeCyn1/+urdnBq+znTx9buVD90ePRjQwnfs3vWwpFs4P8alQs0wi9Ui7IzDFxizzuF4DU7ZNAEPh9gXtaUbFEqMhf1xpVQLL1o06jcQtH4F90x/NY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1787143441; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OW5KVsbLhJUGM2X+akMg7O9ipNctix45pkzL/Es2T60=; 
	b=a/t2IBI8QOejOA1DwHswODqO+QSz9kMyx9NXObJyZ9nL84oSvGQJQYKic/FrgI9ZQJiI9dHLo8s5cf0FNRsco+oK22W5OzFE12Dn01m331XIW8XLvrY3rRd9ifK7IkLznTuN2FyKCQ4qzHpQEVYB62peBIQEo4xItBe4hqaGnq8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787143441;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=OW5KVsbLhJUGM2X+akMg7O9ipNctix45pkzL/Es2T60=;
	b=GmRIftV5HwR5CZfMRtNRDssKxwWrHSH52ufA/xm/OTrAvUQ7cCf3uRRT+cll74sy
	svrmHi1GA4wjm5HXzD7MquXCt0PUWE8pafwChNbn5Tn/wtgC3/CmgbgHyaMpi3h+oE3
	cBDc8IxhJ+9qJS+9yN3guOM3To2W2II9VhBy8KFE=
Received: by mx.zoho.in with SMTPS id 1787143439516761.6116959013347;
	Wed, 19 Aug 2026 18:13:59 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: bpf@vger.kernel.org,
	song@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	puranjay@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org
Subject: bpf: Is the nmi_uaccess_okay() check needed for bpf_send_signal_task()?
Date: Wed, 19 Aug 2026 18:13:24 +0530
Message-Id: <20260819124324.43162-1-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

I hit this from a bpf_timer callback that signals a userspace task: the
signal was not delivered some of the time. It turned out that
bpf_send_signal_task() was returning -EPERM depending on which task the
softirq happened to interrupt, and the source is this check in
bpf_send_signal_common():

bpf_trace.c:872:	if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
bpf_trace.c:873:		return -EPERM;
bpf_trace.c:874:	if (unlikely(!nmi_uaccess_okay()))
bpf_trace.c:875:		return -EPERM;

Is the nmi_uaccess_okay() check necessary in the bpf_send_signal_task()
case?

When commit 6280cf7 ("bpf: Implement bpf_send_signal_task() kfunc")
made the function take a task, the PF_KTHREAD and is_global_init()
started testing task, while nmi_uaccess_okay() kept testing current.

As far as I can tell the path here does no user memory access, so
there is nothing for the check to guard.

Also, it compiles to true outside x86 (include/asm-generic/tlb.h:26),
so if it were necessary here the kfunc would be broken on every other
architecture.

Thus, whether a signal can be sent depends on the caller's context,
rather than the task it is to be sent to. And at the bpf_timer callback,
we never know deterministically whether the signal would go through,
or it would get rejected here.

A quick reproducibility test by Claude Opus 5 (the issue I was facing
from the timer callback context was not reproducible deterministically):

SEC("tp_btf/workqueue_execute_start")   /* current is a kworker   */
SEC("tp_btf/sys_enter")                 /* current is a user task */

static __always_inline int probe(void)
{
struct task_struct *t;
int ret;

t = bpf_task_from_pid(target_pid);
if (!t)
  return -ESRCH;
/* sig == 0: permission check only, nothing is delivered */
ret = bpf_send_signal_task(t, 0, PIDTYPE_TGID, 0);
bpf_task_release(t);
return ret;
}

On bpf-next commit f79066c7 (selftests/bpf: Add tests for a store
on a fault prone qdisc pointer), x86_64 under qemu:

bpf_send_signal_task() from kworker context : -1  (-EPERM)
bpf_send_signal_task() from syscall context :  0

Same result on v6.18.29, x86_64, bare metal.

I may be missing the reason for it to be there as well. If this check
is intentional, what is it protecting in the _task case?

Thanks,
Aditya Sharma
