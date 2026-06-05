Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B330DEA6
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696093; cv=none; b=j2xlKgyWFMNM99WMDzah8ZIlnf/sJskW6IByMuCbQgQMko73Ok07AQlDTpCHR2JnIL+hUBX+JZusWhFZMXhKVOehH1FGQXH+6eNxIzK+lAnI450ytKE/n1IaqjTTk0PCrz9CHYbO4oDEstOtuZQgejEQx0/FAP24AOsH88KSTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696093; c=relaxed/simple;
	bh=BYpjAtRPzh98AaTfkHIJzcuA4v1A26ns3/vqFvB0NdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONrYoFxjmp9G0CXWPeGKh++1CdkBmTc36X/+oLAaiAM7i4S5FnpP551erL0Ly2HWRygRyX+p9AaHznh/vWJI3McdIA7warHlbzLPTXeLLyQBnDx5qNDUoM7lIbuvycc8eZkGyriY/chTf3Kn8yoYdE+JmCzJJbbtkPF6hLJPNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUEYYH13; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUEYYH13"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso17810365ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696091; x=1781300891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hwfxyR3TaczFPiobb9s5yfYVHM9qFeamWh5WTd7gT4=;
        b=BUEYYH139wwSP/1wYU+S7tN2keLtQnPEasa/Xjz6RqwnJfLk/HArz3S8a1kQ/djXlH
         d/HaPJ6hk9h+7Q9G3MB82FuLoaYANABtPoXaTCNeP1mSSS+BmX0Q/zGaH3+4GwtvXmR7
         TKmxdltgZT78wTylRWfMvnZKE5sRC3kVbASujw31YZ/rJT45xEZXN+lP0MeIRyZtbsBW
         +gGctQ0/4ecSJtUnywFYKPjcgQYqJA6h9mgHmpeESmAHcVWUMhmJvJD1RiQlfSOkMIDO
         Ykk9RwFEKjLnkppbxnvFj30qTc4W6lGEFh1MamGURsAh2fe9ba1QN32fwXicYbuO4zSf
         ewTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696091; x=1781300891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hwfxyR3TaczFPiobb9s5yfYVHM9qFeamWh5WTd7gT4=;
        b=OpRO3gK7i1vZHnHJKrWlhUePcXI9Zww5X24iL82UII4gl9A9aXNpfBNrw0l2GhcJIS
         0W6oer88IYDJoAmVcbPC0hYRisRwYXxPmAFf1RS/2pMJ/Ktxgfl4pC24APFLDKfMilK/
         nmUuQgBHCKx4+d7mjRkxVpgJtx0H7HSJrhxQREOw2K28tyy+25XP3qDT5CC0aUDBhIKS
         cn6vo9ue4fx95ak9NL1OTtFAiuaPrMPbrPmiTY69kNDsPdyEr0FAh35JmO8dm2UDzRuX
         yo6mqnkpl//QftD/4zelX/923DikSuq0jqajZRvaVlij8/zleMxqUlP1ZSkQcLVDv5WL
         cOig==
X-Forwarded-Encrypted: i=1; AFNElJ8j8PrC2HVp8lmzLA+6fPtpEfPC0ZPr47wPM3loFZEZM8Hi5UJZdya1mA/yhojvOqnwgNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8FAJUAMOWles7Q0AnGTtihdipiP7gIQPiYEBRcJemnGa2nGM
	eo455Rk6gx2er9+YSbhAQuT8ZFcagh5+XhX3yMbyugb/uaNt4fafuZ/ovTYbPrAb
X-Gm-Gg: Acq92OHj7q7dqKk0yF38sDdoxX0yo5uLwsoBXxM2i0GO+ydN53s1KZAN+9+yHR0Vedg
	R3NadYldnFlLLPFpX94MWwfoE0N5Ud4BySLO/gnYfXEkkifLSibPeP5RorcHBwmpWwe/4oHK7oZ
	y6hHdmwvU2+AnT0P4PkUOfbSg2rVmDfMvrSQojBrTnFMBF/V5tyJDjzjDFtl82aiSmlqBRFXE4m
	2Y20drvta0uVxtGMm9N+Sqb473ch7lmue+1E/fgL0ktfhXXf+8dUYN+p5PNLoIUqIQx1sopcsuO
	A3fkWNzOuJuRsB0Y8FuW4Lvj0qSPwCEMp4tzjCtBGXrN3lWzcueRaN6ll3pERZ2fmw1twBmi2Bs
	go75VPIvFg1sA7KpJxjcrqK5pxAS3KAVLwNqzstyxq1l9m/rS5dN4xVnooiypJcMiRX8Pxh+iXL
	TESr6KEwj2956SoJqW6GYdCCN4fwh5FslL7OSmYevp4ohZSPwTZ54C3ONDcCd9u4+jBiNM29Y9
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id d9443c01a7336-2c1e7f92548mr63751155ad.24.1780696091201;
        Fri, 05 Jun 2026 14:48:11 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm101060345ad.20.2026.06.05.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:48:10 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork error path
Date: Fri,  5 Jun 2026 21:48:00 +0000
Message-ID: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_sw_sendmsg_locked() caches a pointer into the open record:

	rec    = ctx->open_rec;
	msg_pl = &rec->msg_plaintext;

and keeps using msg_pl after bpf_exec_tx_verdict(). When an attached
SK_MSG bpf program calls bpf_msg_apply_bytes(), tls_push_record() splits the
open record: the original record is encrypted, queued and freed by
tls_tx_records(), while ctx->open_rec is replaced by the split remainder.
If the bpf program also sets cork_bytes, bpf_exec_tx_verdict() then returns
-ENOSPC, and the error path dereferences the now-dangling msg_pl:

	else if (ctx->open_rec && ret == -ENOSPC) {
		if (msg_pl->cork_bytes) {	/* use-after-free */

  BUG: KASAN: slab-use-after-free in tls_sw_sendmsg+0x118d/0x16f0
  Read of size 4 at addr ffff88810a36f2ac by task syz.0.17/2056
  CPU: 1 UID: 0 PID: 2056 Comm: syz.0.17 Not tainted 7.1.0-rc6 #2
  Call Trace:
   tls_sw_sendmsg+0x118d/0x16f0
   __sock_sendmsg+0xe4/0x130
   __sys_sendto+0x2fe/0x3f0
   __x64_sys_sendto+0x7b/0x90
   do_syscall_64+0x14c/0x480
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 2056:
   tls_get_rec+0x7a/0x3d0
   tls_sw_sendmsg+0x3cd/0x16f0
   __sock_sendmsg+0xe4/0x130
   __sys_sendto+0x2fe/0x3f0

  Freed by task 2056:
   kfree+0x163/0x560
   tls_tx_records+0x2d6/0x380
   bpf_exec_tx_verdict+0x3de/0xd50
   tls_sw_sendmsg+0x10e9/0x16f0
   __sock_sendmsg+0xe4/0x130
   __sys_sendto+0x2fe/0x3f0

ctx->open_rec already points at the live record on this path, so re-fetch
msg_pl from it before use.

Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/tls/tls_sw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..39dee66cc99b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1165,6 +1165,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
 				else if (ctx->open_rec && ret == -ENOSPC) {
+					msg_pl = &ctx->open_rec->msg_plaintext;
 					if (msg_pl->cork_bytes) {
 						ret = 0;
 						goto send_end;
-- 
2.43.0

