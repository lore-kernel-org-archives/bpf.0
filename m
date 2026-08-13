Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8E499F1A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640688; cv=none; b=gmeYsFhbSK1yVyVQ4ZoF5dG7KOkjV62F49btucB5eny/E2dViZyg9DMpXSc7UjkYMcJDtZK8TgXMCqsDWE+ZCZaIeg+ooY/t4rR2gaevcB8/VAbvttetgtJc05i6A5gpTSElEFcdV6bJfeZJwnsrr4nOU+Q3QQOtCeRIsPte/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640688; c=relaxed/simple;
	bh=P4bEV+TSyucsB+oOwDWR+Lt2K4iI4VujhWz5lQywp/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA4tH3PjjsiQTf3xj9mNcTaXcJkVVV3nIPeoQWdDW7g2rtf0DzZOR3C4B4+LJ2HYb0XA0IRsxhv+NaocQsnmpKEhU9upy/GqPJFrM+UfyFLjORm2deFd9uK1mrECXrRRbv/Njy+RiAhPSTLNtqPoRdRgq3OxGTncPZtkIDXxqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhKwydfb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhKwydfb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIpmsX6WtXNHFCRHtGccortX+Ir4DIAT5TQlZZyNQeo=;
	b=RhKwydfbvAFhRNRi95idrfktDuwiYidMtUPhGI0cQ+g6Crb7vC0Mv8IQab1ifEtuxdMaYY
	4f5La900TLRul1PZYlko0GF8uULL7KOtnbXrNYNoAq9IRPBLYZgn4FxHwfG6+XvBLnS0W1
	gcBq0oQnCQaCMggFAXq8+iMUuKdzdB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-6MwurZx8OlqzEe_HJiXJUg-1; Thu,
 13 Aug 2026 13:04:43 -0400
X-MC-Unique: 6MwurZx8OlqzEe_HJiXJUg-1
X-Mimecast-MFC-AGG-ID: 6MwurZx8OlqzEe_HJiXJUg_1786640677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9356195609D;
	Thu, 13 Aug 2026 17:04:35 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B0A8195DF9A;
	Thu, 13 Aug 2026 17:04:22 +0000 (UTC)
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
Subject: [PATCH 04/13] arm64: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:54 -0300
Message-ID: <84e977166dfd72c8c5b53a54e86e149e7ed60672.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (regs[4], regs[5]) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/arm64/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4d08598e2891..093c20bff38a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2427,7 +2427,8 @@ int syscall_trace_enter(struct pt_regs *regs)
 		trace_sys_enter(regs, regs->syscallno);
 
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
+			    regs->regs[2], regs->regs[3],
+			    regs->regs[4], regs->regs[5]);
 
 	return regs->syscallno;
 }
-- 
2.55.0

