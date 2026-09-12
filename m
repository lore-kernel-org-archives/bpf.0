Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD73C1D43
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197236; cv=none; b=NN+dE1QHpfDVU/e9rBjGjCvSoFrG2BCAubtiUXf2npm1VGzYxUKiW9ZY1oA/cScNK7BsS6DPtKfvsj6y83IaoprpFNNvJbB14N9ADOLS0D2g9J/Ez779HnwjvXYt9dIbnQJps5r2MhDu8EZirdfvRLu2cLY26PA3vq75Pgy+668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197236; c=relaxed/simple;
	bh=F3MOECaxR3CJhTRes5N5fgMTP57ppQy59xIDCNNHQyE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a3MA8YOqJkuDAsPA/g16VELWVMEzV0dElRvwGK0QYGrXrxLMAxjLhSnES7dkeHB76nHkdLuW24SEaYY7+413tPTvLND4UT4MMIrXwriHRycKiZLqRUPTB57B/MlSc9Gd9g+//9aRe2qdlDTX1aVUjeMen3nKcaL1xtzdSLXeQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfeTesji; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3qNy96u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfeTesji";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3qNy96u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789197234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDLXH37HEbl6yRUp2dcCM+7uDlwa6YnDWzki8R5Rn8A=;
	b=EfeTesjiglVoCvHZCU0XFFGDGYpfcc4Q9oQMnSesRcFuB3SYneNexKndK1K0jiXi/GVV4L
	tBTfwi4g+5G4L3VRke+fEvDnWNMjgbqt9KNqCLdjV4l+bp6jzqOUsQLHFyuG15PY8ofneT
	SjnZ7Ih2k4NSIemke+dHxAShOfFik0E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Kz2JctNgPMK_QFWNadsWLw-1; Sat, 12 Sep 2026 03:13:52 -0400
X-MC-Unique: Kz2JctNgPMK_QFWNadsWLw-1
X-Mimecast-MFC-AGG-ID: Kz2JctNgPMK_QFWNadsWLw_1789197231
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e64b80b94so8774275e9.3
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789197231; x=1789802031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDLXH37HEbl6yRUp2dcCM+7uDlwa6YnDWzki8R5Rn8A=;
        b=W3qNy96usdq9RDx9sINpZh1lM2xN1V04t+qi5TQRmUcNrTz+PaYMkogWQQ88SlJc4f
         968364DFRAlRoMgcWgPJMXycPotfavazTqAUV82TW2Bis+/xDLv/yYpaBUIbRVXyxlQD
         5Z55r6QtgXBVb98N/BTaq1Xw7jqRwrpmzkATZr5BkJSec2T7e7cQWFE/BuePzFjZATca
         tT2+A9SIQh3Bw6hNWRdSMeh/v3LMgXtsUfCc2Pm3OjuOm+1ACO+wEw/mNlgBx9/KpDFL
         FIMrJesB35GRd3c1KJ96o0DRWVTpItLrTGwJsv6qMNv3LkeF8sik+ToZaJuEpJamrwJM
         o/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789197231; x=1789802031;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDLXH37HEbl6yRUp2dcCM+7uDlwa6YnDWzki8R5Rn8A=;
        b=YfB+Hm6GtUdsTOSpMDicbn54VNZ73ZQzY3W3inDy8rrPK1V7Fyh2OZoafzUIkGdTsM
         IPxnN9wQY19JFNEnj6AXlbF8PfTrjEOTtnAS/2fxImvIsyeWAYnZ0BRpGBbq4eY2KP9f
         CoIDLffqe1GqePwI62kbXuA1QCq6mJF0ihEP0UbGNeldCx08XtJ3uxIHPSMTtS5HOcuA
         y+ex96o1+pmFyFoPBnVbORNQCsoyntI58JbStD9F8IKc3FBj2mjgQsa0PPnty/1C8JzX
         RCkPMpOU4h7JfqbDoEju9iRHwOJkYE/51/+4cYIfi7aKJiHBQ7CdQ36Dk3WkgPGD97Wj
         r6kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxk5dG31E0Cu5lfO+o0SjTP/UbFW4AtmR0KfoU4J45536oUMj3hsrSiibjKUzxjtxeQMZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mET9hIev1ePci3X9HTcFiYriRiWgyJx48aZYZKHOT3Mj7bTVLP
	AE5Ohna3oIM+ftmM8EO3yTwCAz4YJ7pZ/wiFbjHxVNtxT10ZXyrHzehnP37AmIvHm6XrW7+Yzm3
	kRMyKoG4X+bajlmEXnlzWSwM/dh/anDvoSHG0BdGrQv3RerAxNTYRog==
X-Gm-Gg: AYBFou3aeeLWaasG8vm33g//+SkXvhIQigp4hKJvWyyV+ZkL9B5Cd6DQmpa+ylwFGIt
	9rXiMFl37ljxR2//iYnyYJfRfyRu2f4ckU8SnhvP4b3uSunXEIyf8oqDDqoOsYrls7nJwYYXEDe
	hzKCZlbRfcGRY9OJYxELO/Zu9+dj5pw7hVB9EOh711fyhTDcJI8ARspAQsqvAePxkb4MCZ6SgU6
	CUr51oxPV2Os9jcNzeebhA4Kek24yimsd08+9IOkXt25p3RijmaaYTLK5PWAfhmCkm60jKbGfm/
	0TS2PJMhoIw1du11AddZ5m9V63w/LQmhdK35cdg5sctxIetUGrgocsy5qsn1BQrDcLiVpla8Db8
	CvDxYEn7j0NEvHsT8XaX8zguKpw==
X-Received: by 2002:a05:600c:4692:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49e619ad0e1mr160450825e9.11.1789197231468;
        Sat, 12 Sep 2026 00:13:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49e619ad0e1mr160450365e9.11.1789197231095;
        Sat, 12 Sep 2026 00:13:51 -0700 (PDT)
Received: from ehlo.thunderbird.net (air210.wispotter.com. [212.2.212.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6499d57bsm169819125e9.3.2026.09.12.00.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 00:13:50 -0700 (PDT)
Date: Sat, 12 Sep 2026 07:13:48 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Set need-resched flags before tracing
In-Reply-To: <20260911213300.1305763-1-arighi@nvidia.com>
References: <20260911213300.1305763-1-arighi@nvidia.com>
Message-ID: <71619AD0-A163-40DA-94B1-39052E808DDC@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 11 settembre 2026 21:33:00 UTC, Andrea Righi <arighi@nvidia=2Ecom> ha s=
critto:
>sched_set_need_resched_tp is emitted before the corresponding thread
>flag is set=2E This allows a BPF tracepoint program to recursively invoke
>the same tracepoint while leaving its RCU read-side critical section=2E
>
>If rcu_read_unlock_special() must defer a quiescent state while
>preemption or interrupts are disabled, it calls
>set_need_resched_current()=2E Since TIF_NEED_RESCHED is still clear, this
>emits the tracepoint again and repeats until the kernel stack overflows:
>
>  __trace_set_need_resched()
>    bpf_trace_run3()
>      rcu_read_unlock_migrate()
>        rcu_read_unlock_special()
>          set_need_resched_current()
>            set_tsk_need_resched()
>              __trace_set_need_resched()
>
>Set the thread flag before emitting the tracepoint in both
>set_tsk_need_resched() and __resched_curr()=2E For a remote reschedule,
>retain the result of set_nr_and_not_polling() so that tracing remains
>ahead of IPI delivery while still observing the updated flag=2E
>
>Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
>Signed-off-by: Andrea Righi <arighi@nvidia=2Ecom>
>---

Hi Andrea,

Isn't this mostly what was done in [1]? I wonder if that patch was just fo=
rgotten=2E

There was a discussion that apparently didn't go anywhere, but it doesn't =
look like a blocker for the change to me=2E

Thanks,
Gabriele

[1] - https://lore=2Ekernel=2Eorg/lkml/20260627081657=2E499781-1-rhkrqnwk9=
8@gmail=2Ecom

> include/linux/sched=2Eh | 5 ++++-
> kernel/sched/core=2Ec   | 7 +++++--
> 2 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/sched=2Eh b/include/linux/sched=2Eh
>index 59f6366fdf501=2E=2E6003dcd080e6c 100644
>--- a/include/linux/sched=2Eh
>+++ b/include/linux/sched=2Eh
>@@ -2105,8 +2105,11 @@ static inline int test_tsk_thread_flag(struct task=
_struct *tsk, int flag)
> static inline void set_tsk_need_resched(struct task_struct *tsk)
> {
> 	if (tracepoint_enabled(sched_set_need_resched_tp) &&
>-	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
>+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED)) {
>+		set_tsk_thread_flag(tsk, TIF_NEED_RESCHED);
> 		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
>+		return;
>+	}
> 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> }
>=20
>diff --git a/kernel/sched/core=2Ec b/kernel/sched/core=2Ec
>index 91f059a556950=2E=2Eaed403fd2f82e 100644
>--- a/kernel/sched/core=2Ec
>+++ b/kernel/sched/core=2Ec
>@@ -1196,6 +1196,7 @@ static void __resched_curr(struct rq *rq, int tif)
> {
> 	struct task_struct *curr =3D rq->curr;
> 	struct thread_info *cti =3D task_thread_info(curr);
>+	bool send_ipi;
> 	int cpu;
>=20
> 	lockdep_assert_rq_held(rq);
>@@ -1212,15 +1213,17 @@ static void __resched_curr(struct rq *rq, int tif=
)
>=20
> 	cpu =3D cpu_of(rq);
>=20
>-	trace_sched_set_need_resched_tp(curr, cpu, tif);
> 	if (cpu =3D=3D smp_processor_id()) {
> 		set_ti_thread_flag(cti, tif);
> 		if (tif =3D=3D TIF_NEED_RESCHED)
> 			set_preempt_need_resched();
>+		trace_sched_set_need_resched_tp(curr, cpu, tif);
> 		return;
> 	}
>=20
>-	if (set_nr_and_not_polling(cti, tif)) {
>+	send_ipi =3D set_nr_and_not_polling(cti, tif);
>+	trace_sched_set_need_resched_tp(curr, cpu, tif);
>+	if (send_ipi) {
> 		if (tif =3D=3D TIF_NEED_RESCHED)
> 			smp_send_reschedule(cpu);
> 	} else {

