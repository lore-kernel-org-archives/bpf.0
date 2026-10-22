Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634263;
	b=yYxyaWGIr6UTtoHoR1Wk9CoLyKugAFb5g/lqYriTgMkOwM4fYwM0uzzzKv/fhrklyDry
	 9c5N6hzQJFvrxbs74Ugbz/nwF3ea8dEzXnFBQRJM54GfE/Yd4ZASZ1IFgmY2eVhv/LKqG
	 QlsgcrZCXsR4PjW2dsQOm/TkYHiEiGtY/vOQo94A4sa/Bh2B/qVMPwNnLH2vPXroMlt3Z
	 /QW4mRFGFuMa1YOVwjlOCs3qCrCiPLEkZMUALtC7glEDolPdkicl3na6ZqHRnL/qEoM/G
	 ijWtqDqqjrzRLEBNAG5thQ+fJp4CyKYCv9fpxUiA3K4RPXOKteWcJPqciSiRKqk3O5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1YfAOVlMmaFO1m8awbcQvUypoDPfeD8mK+PEX0oRAyM=;
	b=1UnAvdLHB0P5Z5MPd27tXyKteFj1uep5ZrVhjY88tuzJEa8O2ROWiyKNNSDlGbdN0qCZ
	 d+FoVR01Ikv+oY19vPgUyiwlxPH0AnUSeJNp3poIPbfFfMj2EkVBJH6Fo3IPgVvyl1lcZ
	 swlL2o/nvwjbgUYNIVyS3Wn2hbfROtW/y6XuxWfXdUkTeDjsS7nhQ7bCYPAbJYqyq76IP
	 VUKgimowph+sGli7IF7+6u+zzDg+msDTv3XseM6r+KIOBI3M+GVSTxFAzPHXRYyh5W0l2
	 HVMWtrbVIXEAO9nNTEIfEg6ff1eFa5CRTfXAg4XzdHl+TXzkqPxT7oTwpSKYRm3Oxuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMifRPw7;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97451606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97451606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMifRPw7
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8fe8e343fso9014785ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634262; x=1793239062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YfAOVlMmaFO1m8awbcQvUypoDPfeD8mK+PEX0oRAyM=;
        b=QMifRPw74ATHweuZbPUqbEJKY4CbQGRNSsvn3yPOvskEWe71YJcI/zC4jQs+00oX7w
         AnfEnYnVX28dLRI44N3yfdkR61rnHMRP4lNoh2cSUyUUtPRruc1ZumwNqmtF4opAMb1K
         dFb0OkilKx4tuI2gsL1PUSXTuXHCGkJpRxzMXDY5Q97X6m6a6FwdHdyOfvPuIjU1OweG
         oKw+fYZgVxT1ENZeN6Lcprmt0I3Wyyvw7Fd7d2dCsxHovO4BrdnGaZ7NBtM6AUJ+YrTR
         03ldC4K4udelto6khrnvnMnHTt0BonrFcW5VNoCjJpVS1CTcvaFHocA//TqSOTId+e26
         jQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634262; x=1793239062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YfAOVlMmaFO1m8awbcQvUypoDPfeD8mK+PEX0oRAyM=;
        b=E/LpgnA0tbYsgHFdFewBd1otwL0dIJIIt01PjplPLDN8PnawQH8CX5smGKLQDztVbh
         nAf51ta7zqQFG5sgjXiWzJ4zLngajWvt55nM+Ok+UJBmuxsJ1pwkTtKq8uwmxdmkycW2
         N0VVHlnlD34W+3X6YZV+qxOXGXFCgrBqC6oDM0rjQtoV8lk8f/6PRFVp4BPOWROPYYVn
         MBXmBgf5sbtkekLtUF/tv4BXQ41Qro2J6WvIXsDQWe6j50v28bt1H9/V+rddL+IziqEi
         w+8r7KfEnG6nkHvvVA1HHVwDAzZhELt+h7q/iI/vLymeycbQQdJYlUf37ngnhAAGOr4A
         +ToQ==
X-Gm-Message-State: AFq9FYKA0cMT3F7hdkxfc5JYkeHWiON3NmVD1EZlxfFiq3DWA5YFE0U2
	hMidTgnpjF9ksFoiZkMizytyLDGAcD+jxHi2r8eKPECzP3r1EIUZdeHO9poHtg==
X-Gm-Gg: AYBFou2Jr5479t6DZFiA7wjZcHGbEiuNtcIG9aazSZ+StsOgsOrZeywJ1oHqHyzUeOs
	/u8Zq0EtKjeTxUIdc6r22CK5iy9kalBmYDxMS6QVbJTySHHyOjg8wgU3FecY42FcurxqZRwLYj8
	YDjUz+foQVBi602HIz+tY4WxkykWXCjCqFkShzwtwMNIwhksEe1Hjy+XAyAtLP0DGxYcjAlDwKg
	K4i6qpJsYBKAqzra1f8GR65hpBhC+cv0HWuGO3nwrOwAvTcaNGb3aHXoUD0QTmGTKtxsYfT/aJk
	mkOJgMzfRDUjJ8XfoCqIe91jgr/+1k1+hBJ0moG3Ai1/u23/+j2HwTte3A+890O/ab6e9XLDE2V
	fCYe66lu16cx9iRrhLz5oSWcF1A0dXQkUDQtxu6vlDy3jP5iIJNxxOq3Fnmlzlr/CTsL+1Ciadj
	v0rdbmV71cDc1S76lu42qP9c2ZlVzawNG3ZillWL68XvZJ+UuKcS2+hQ4R1hNWTPGHKwwf/2WbP
	hV4/A2nJiYZGN2M+r+2uVVkyA2odZpdPwn+ODLfo4XLZKjzwjdTyrb1919h+/t1dETFh8w1szTn
	CyM5IudjDYq4G12bw0OclmR7hW6FZsBAMSA/f0IHFWSI+zyxmgoApHRBdiJkULS8OnfPXWfDVEN
	hxUB6UPja3e/wblajIRomMq9W
X-Received: by 2002:a17:902:e74c:b0:2dd:c0ff:e72b with SMTP id d9443c01a7336-2ea4404e987mr25918265ad.61.1792634261828;
        Wed, 21 Oct 2026 18:57:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4af4dasm17474295ad.75.2026.10.21.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized probe can't be written
Date: Thu, 22 Oct 2026 01:57:07 +0000
Message-ID: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

__arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
uprobe_write() fails, and user space can make it fail:
- -EINTR from get_user_pages_remote() when current is being killed.
- -ENOMEM when COW can't be broken, since memcg is at its limit.
- -EINVAL from __update_ref_ctr() when the process cleared the semaphore
  of SDT probe.

Kill the processes that call probed nop10. It warns in 8 of 8 runs:

  WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0x3a0
   uprobe_notify_resume+0x1c3/0x4c0
   exit_to_user_mode_loop+0x63/0x4e0
   exc_int3+0x1f3/0x250

The next patch calls set_orig_insn() from fork(). Kill the processes that
fork and keep mmap_lock busy, while a trace event on nop10 is enabled and
disabled. The kernel with the next two patches and without this one warns
in 3 of 3 runs. The whole series in 0 of 3:

  WARNING: arch/x86/kernel/uprobes.c:1161 at set_orig_insn+0x161/0x170
   register_one_mm+0x154/0x180
   uprobe_dup_mmap+0x61/0xb0
   dup_mmap+0x149/0x9f0

The callers handle the error. arch_uprobe_optimize() marks uprobe as not
optimizable and byte 0 stays a breakpoint. set_orig_insn() returns
the error. Drop both WARNs.

This depends on the previous patch. Without it WARN was the only sign of
the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/kernel/uprobes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 62bbe41c6466..33c35bf07801 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1170,11 +1170,8 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		int ret = is_optimized(vma->vm_mm, vaddr);
 		if (ret < 0)
 			return ret;
-		if (ret) {
-			ret = swbp_unoptimize(auprobe, vma, vaddr);
-			WARN_ON_ONCE(ret);
-			return ret;
-		}
+		if (ret)
+			return swbp_unoptimize(auprobe, vma, vaddr);
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
 				   false /* is_register */);
@@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
 	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
-	if (WARN_ON_ONCE(ret) && new_mapping)
+	if (ret && new_mapping)
 		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
 	return ret;
 }
-- 
2.55.0

