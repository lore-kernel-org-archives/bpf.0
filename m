Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F313CCFC4
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032329; cv=none; b=hzsdtxcYs8lHFxP5cbPsSV6CMAwARjduovzpf4AwehwddSCDLMm6YMiVDeb2XoheMZcHp2ORphdCHEQobxPiperqCL1pRCxP/UdSPeN7lp1l6Vh8H6/SZDm3dOmSDf0nHMk+a9dz/JT9Gz/ubl7MV/R14nEWDc3p8944yv1rZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032329; c=relaxed/simple;
	bh=+M1GzHyW7gJgudBBznLhu6y63r1NCucH+dqtSspIMXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuJ3zAhyG0Q68N4rJMRvr4BqS1IGY9F2VibWM9/mmw9SdqVbbFmNcvhVLMsuiGjAmlhuZuV9xvqBBKV2WfN/4PFFHokvAyLMf1A8dg9Hy8YPWy+do/Qa3o+ahq5wd+RM8hSB6y8U/Re3s59QjxiJbRBEiPgGb84/HN3KYR8o3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=IyiuWIvl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="IyiuWIvl"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37d70036426so1802658a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783032325; x=1783637125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDtU2YibaniqMnLc/xn/Zbnq7zTtWrI58XmXirUM2qw=;
        b=IyiuWIvlgi2oTGMxssP4AG0+Rh1ESl1+U9ePSqhCf2zLSPR8tSqz3sK5KudbbBHXBl
         /FG0pJuVGTRD0s8PB389UIL086Y+8B4i/7oYuVALq5xS8uOqqeVPH4ERMKfkKY/OszzU
         dJZfPj71fW/RR85eMTvk/awF0TjiQnOIdyDLbs0MrjAvquX3g5lHUHWnJL3aQIMsJ2A8
         5iDj1g20c5zrMw3eHmj7lk1EMH3nIQxZtkbU/HgFoyD8bcA/ZYLqK/MIekHNPDys+HZZ
         AfNX8xBrrjuMXsaWJ8o5SDVHThAY7to5/qNvvuZp7HsOGdYVKxrrQtkZc2u7H0F1c+MT
         GDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032325; x=1783637125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDtU2YibaniqMnLc/xn/Zbnq7zTtWrI58XmXirUM2qw=;
        b=dMcJ2wnGZoR8V/7PgqKYU44bF3FVQSvQ1Mg/8uaolTRfynpBDWVKbANPaow0IXgSNr
         pqj8cgjCUuhf+eHCZGh6oBqHy2Ian9/rP5ChP9VlJhLyP2+wfAqYUfLORIq+7zczkjP9
         baEwSiRCpVwVZVT9mac/xrWmXh87TBdb6ocauqyqKRDeMREEWXw3WnRHvMIYRaUMH+lD
         IDnbCO4KkIzqqkppvYW1EIaH5ATX/a9L9kffIzhfkPtaWnLhIiweRrn8O+RShfX/Zt38
         5heAWYPd+mdsHk7PQomCqW7O0OPNFC3eDEY5E1VeGduZYLRJqGngmOh3pD/AAjCQIEW3
         OZ1g==
X-Forwarded-Encrypted: i=1; AHgh+Rp6D2iBbbGfWWAvXi5WM/0x2CQgYoOj2NVS4o1yYDPFNgx/r5wz0OLg0t9e10hS016HDt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXF2oadWaLrvi5mBCiIjA8gLV5MtfAgMH/tqdQYN8OpQsVYesg
	wyn0uoOib3rc1YcCIYhk5g5yqPZtsfhVQRUqtodZVxw4Ij97g6baX3+EA28Ft0CZbQ==
X-Gm-Gg: AfdE7cmH0ubc6MHW1kcQu/FhPtEdFjghE3IgJKpoweFfUddltQZsKTWrVQufkUpQmuH
	brNuVnEuVTyFGeB2tj6RnqTwK1FrMhYPlPaMjkCI+gO2jRh4Dy7W7vWOOC7l+A0jyd3wENxFWS2
	9TYkokD2yuso3EYAO7vyBx2Yq9CPOr/LYy4klFH9+jcgWlkuB4RZK8nhLKsBo0PMD0f7PE8CgHM
	HiMtWgKVahT41D7GpXh+IIEy3WBanVns6t6owxeoIUEz95etscXDSUc7l66JzV8WV+U4dfq7Rj2
	BVnyzTh5hSgP9TOjorbQcbZJ/RLla9gOnVGFz3CJURMrxlVawq6Z2MkdcSY3LNbnU5QLNGUyabs
	ixk+kXqhW0fdMsxfBPvKgpw3GvuFMDgjZ0VMAtzznArwVNVcsmboLce6tDKkGOHBT1IZbbodQf6
	KUk79uvi9LCZDQaRrRqQ==
X-Received: by 2002:a17:90b:3502:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-380ba80ebf3mr7702968a91.4.1783032324591;
        Thu, 02 Jul 2026 15:45:24 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1595e912sm10649247eec.31.2026.07.02.15.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:45:23 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	aditi.ghag@isovalent.com,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH bpf] bpf: reject mini-sockets in bpf_sock_destroy()
Date: Thu,  2 Jul 2026 22:45:19 +0000
Message-ID: <20260702224519.800135-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sock_destroy() casts its struct sock_common * argument to a full
struct sock and reads sk->sk_protocol. The BPF tcp iterator can pass a
TIME_WAIT or NEW_SYN_RECV mini-socket, which only embeds a sock_common
prefix. Unlike sk_prot (which aliases skc_prot inside sock_common),
sk_protocol lives beyond that prefix, so the read goes out of bounds of
the small tw_sock_TCP object (type confusion).

Reject non-full sockets with sk_fullsock() before touching any
full-sock field. sk_fullsock() only reads sk_state (in sock_common),
and these mini-sockets have no ->diag_destroy(), This matches the other
sock_common consumers in this file, e.g. bpf_skc_to_tcp_sock(), which 
already sk_fullsock() before reading sk_protocol.

  BUG: KASAN: slab-out-of-bounds in bpf_sock_destroy (net/core/filter.c:12673)
  Read of size 2 at addr ffff888013ffc71c by task exploit/143
  Call Trace:
   kasan_report (mm/kasan/report.c:595)
   bpf_sock_destroy (net/core/filter.c:12673)
   bpf_prog_8b5bd55c189cabc9_sock_destroy_tw+0x31/0x3e
   bpf_iter_run_prog (kernel/bpf/bpf_iter.c:697)
   bpf_iter_tcp_seq_show (net/ipv4/tcp_ipv4.c:3247)
   bpf_seq_read (kernel/bpf/bpf_iter.c:184)
   vfs_read (fs/read_write.c:572)
   ksys_read (fs/read_write.c:716)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  ...
  The buggy address belongs to the object at ffff888013ffc640
   which belongs to the cache tw_sock_TCP of size 256
  The buggy address is located 220 bytes inside of
   allocated 256-byte region [ffff888013ffc640, ffff888013ffc740)

Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 69ec1a4c0f9d..a0fcafb08b96 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12665,6 +12665,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 {
 	struct sock *sk = (struct sock *)sock;
 
+	if (!sk_fullsock(sk))
+		return -EOPNOTSUPP;
+
 	/* The locking semantics that allow for synchronous execution of the
 	 * destroy handlers are only supported for TCP and UDP.
 	 * Supporting protocols will need to acquire sock lock in the BPF context
-- 
2.43.0

