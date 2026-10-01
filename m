Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D449BD7F
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839630; cv=pass; b=EPWZJOEgiN9npuUW24fczvloN9vnWusu3CY/c8xIgBSby99Muy0ZYBsCbAdBZ6yDxA5bJ0HxVwCXE6+9wzEWl5+drHKBNfikE3oArlG6pfA/wLkpjm9zqUSHQD/VObU1fhPW0LPudM7oA4K/2H+cWw2xbUVBnnkAQcG54u3z1aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839630; c=relaxed/simple;
	bh=biVIvnJC4/P4AVR1F2UpjNszpTG0JkiyU7fYdPIN3og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OOBpMN5D+LdUStWa0ZbIPddT/ZuRvqfASSe37n+ItWzGodPs+ByCmlJczZqiX0SUpwfFxyFbatfluKAHEIu+OfJE//z/Xuc5P5lM3McThdVcQEZGV13QImge2Fl9YbzGZe0FDbB42iHugVFx84bIQk0BVqXJREDHP46m4P0XfkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=D9eMvZiS; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="D9eMvZiS"
ARC-Seal: i=1; a=rsa-sha256; t=1790839544; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=L5ypmqBbxKqz+wE/u6HF2Zi49yWmt6hBLvTJVNpY618ls5mweYtl3w96waD53uboz/ZCY5SiIdGGZtXss/GpaRDO/GUx/dc6pQuu/6ZO2Wnarwl3FgL0+DsHegxoWuQEC8+N9CB7ATNs+ILHTlulrvsOVVIDnx8U8SZhctdIsNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1790839544; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w3jY4VRf5Tz9+LHd6FAgbNc02qFjC/75Au3u3Bm2AZg=; 
	b=Y1wBgL99Q+T0GDJfRnK8mfaJS2O8bS2gXkqMWACNyRFnew37SCJIwdTVp05rfvuXxESGNNrG5Y2/EIYo2v+bbnPRzbEBnziBQLRjm6EzHZTSKd0zH4ygzstmDdRAKuPbZO1YKnyF/hDtlGpGbzZRXtGGDAR4OjoAlnf9Ixbhtp8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790839543;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=w3jY4VRf5Tz9+LHd6FAgbNc02qFjC/75Au3u3Bm2AZg=;
	b=D9eMvZiSP+d2GA4hYpala/0QL1EbtVVD8rMT/KsmijDuVLjADx6jDP62TxDYqBV2
	XMEvmzDWMVb9Xzfudwv4RrI+9vmfUkZRYR9eL2shBP9uG7MNT7WRC1wAkcYU+yMLFL+
	BZXCtRugmBWC0THAYhUPUBLbb8M5QN+lP63xatUU=
Received: by smtp.zoho.in with SMTPS id 1790839541773762.9315005522958;
	Thu, 1 Oct 2026 12:55:41 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	puranjay@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [PATCH bpf-next v2 0/2] bpf: Fix bpf_send_signal_task() from kernel thread context
Date: Thu,  1 Oct 2026 12:54:47 +0530
Message-Id: <20261001072449.1377267-1-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

bpf_send_signal_task() returns -EPERM whenever the calling context is a
kernel thread, even when the signal is for a different task. The
cause is the nmi_uaccess_okay() check in bpf_send_signal_common(),
which is a statement about current and not about the target task.

Patch 1 removes the check, as the signal path does no user memory
access and the check has nothing to guard there.

Patch 2 adds a selftest that sends a signal to a user task from
tp_btf/workqueue_execute_start, where current is always a kworker.
Without patch 1, this test fails on x86.

v1 -> v2:
- Rebase onto current bpf-next.
- Add this cover letter (v1 was sent without one)
- Remove nmi_uaccess_okay() check (as per Andrii)
- Fixed a stale comment above checks in bpf_send_signal_common()
- Gate send_signal_kworker on a new kworker_test global that only this
  test sets. (Sashiko AI review)
- Put /* of a multi line comment on its own line (Sashiko AI review)

v1: https://lore.kernel.org/bpf/20260902150439.692725-1-adi.sharma@zohomail.in/

Aditya Sharma (2):
  bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()
  selftests/bpf: Test bpf_send_signal_task() from kernel thread context

 kernel/trace/bpf_trace.c                      |   9 +-
 .../selftests/bpf/prog_tests/send_signal.c    | 106 ++++++++++++++++++
 .../bpf/progs/test_send_signal_kern.c         |  29 +++++
 3 files changed, 138 insertions(+), 6 deletions(-)


base-commit: 61c1e63c9b651a77b1e24208b9361965c69959e6
-- 
2.34.1

