Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D844A49B4
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360423; cv=none; b=E6dGiGkUwN3RDiDapX0SdPf3OCkQT9RpdUlW6oyUsVisMsqGCd9f7AIEYqBC9LzHKLBpPoPclmeKVFEKfIVs0uuFiCRlaszi/TN1clFYCpq4221EoHvbQX4kcy7XMqse+ld8IW3zSTIeThUtiGkKrnMIsvpqHnUdsVggzEWYEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360423; c=relaxed/simple;
	bh=qaNpQ47O+nMx6JKMW9SpqDFRpcNJ2e0ML7m7iqV9m5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaK1hS/HN7ehscpMVV4/D4+MS9BrTAmBynZwf9AZmh/lyQReXYDw4k2eUsvZJOYfAP8Vj6KJdIVakjrbUzUtOrCYBjx1MouZC57TdzuzxnOe9oFpm+ETTcCtP9GksfqixBlVtL5wvO6FlnXjPq9ZFVaRzgnz91Ydqtds35vUVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzatcWYu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzatcWYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ra0Ky6mXltAUt+LZScMYM+TpmdGUEEaSHVLD1V4U5Ys=;
	b=MzatcWYunFfXU34BeysT6LVXM4ukw+zVmwGrfTaRM8Zi5uINJMuKs+ywsVjM3hcPLQMiG9
	gV5eXNMyYPIizxk1tCJ/n3r5gez1UTTxuNRx2z78IlsnqJ0TZFlv+xqYO6eB5rIGtVtHmN
	F8YSnFmm4TtOFO4Ah8msaQIB6HPT/wg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-kRo0eReMMROZVka9N9pl2w-1; Wed,
 02 Sep 2026 10:46:53 -0400
X-MC-Unique: kRo0eReMMROZVka9N9pl2w-1
X-Mimecast-MFC-AGG-ID: kRo0eReMMROZVka9N9pl2w_1788360408
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D6671953976;
	Wed,  2 Sep 2026 14:46:47 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B08421800642;
	Wed,  2 Sep 2026 14:46:35 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2 12/13] um: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:45 -0300
Message-ID: <db5c792376cd0da372e2a6a7f2da3dcce97d151b.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <cover.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/um/kernel/ptrace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 7da0a5223aa6..bdc1b18bb342 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -123,11 +123,7 @@ static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
  */
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	audit_syscall_entry(UPT_SYSCALL_NR(&regs->regs),
-			    UPT_SYSCALL_ARG1(&regs->regs),
-			    UPT_SYSCALL_ARG2(&regs->regs),
-			    UPT_SYSCALL_ARG3(&regs->regs),
-			    UPT_SYSCALL_ARG4(&regs->regs));
+	audit_syscall_entry(UPT_SYSCALL_NR(&regs->regs), regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
-- 
2.55.0

