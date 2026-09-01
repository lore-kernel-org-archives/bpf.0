Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735593A75A8
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236510; cv=none; b=anTimDIK8pEf1u3WjcEOkeCjtK0xnbTo830qbhXhjo3iHyqlythOJa6dnX3uSCS4iWpBPtVHQZt6Nz07xnewdAkkUPTwNo2kyqR21r73DZjEcEdv+AksQ31dsAQ2QXLI7SsXccAlRJVpH/bV7Hc47C0eACQChr4ULvlzYM6gabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236510; c=relaxed/simple;
	bh=EmcvMgWnU+eynTHcQrpUKhBCbJysQIL0DcglZ59zZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZ24TMewHWYuYc5J6EIE1OOmqQ1kWNPSliyce7KDawqntucQ6xuCh/BuJ59sd0lwDZeXxuoQcVyDC5j9e1eSg3u9iAPdJryZBf/mrtA4i+SRLqBbMX/pzIOnjUO6/HNbca1n5FnjHNHMsgAF6xp04aEUIbhtDL3mjtqUFyaQDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMMYmE4f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMMYmE4f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d71a50caa9so5427325ad.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788236509; x=1788841309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lc63gXB6sWM/VXbWlt8W410Sjt0Osog05aJqYWSF9g=;
        b=DMMYmE4fbmtlHT41IIe3iU1+FlAp3M2ukVQEr36G4DyjpMhwKHCMapDSNhUg25g/43
         KI7Hc7HGiOz1iwY7SiqhvIiPBUoVMakOrrSrZRENj2vp1EK1RUE0AIeUJJI5yctdMfFN
         /DouT2Fk4qm46Ohl5Py8AyzKmh/G1bwr5+n0s/T7GwrLwC7bzStwBx8U6itIakruOdRa
         i+sWP/Q2GNg/Q6ew0zJjnppqg9G6UGjw9B4nvlJh5ABmMmO9QxqPlgvrMH+Reo6xOq68
         ptv3fhtOq69mDH2wkQQHcCk73lo0O+9j3+gW9Imh1VB0pqXxAX8G0YBeZGbe2qqVmTAQ
         SK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788236509; x=1788841309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lc63gXB6sWM/VXbWlt8W410Sjt0Osog05aJqYWSF9g=;
        b=blYvR/qJppI7kHZEwKJLXMkONlDAd+SIzGUYadWiGBiWYdradF8hapuHh0VzkCKya/
         tCSdjzarnDQg3TOObCg8fif15bGnwGZjSHDzplBvMaCGsIBDV8jI9z6D39ctlefO7uKg
         ZEzYR7VQQPb37/A6TTmvM7I+VGhHzYcRejPugNDxd+C36Np5jxY1rJw+q9LnnUPND4fW
         f6+HF2DIY9cG5l2ZoWYQJnFVtLcjpH3IRSG9l/OfONxmlPTA8G5aMKxqy3ze/er+Bdfq
         +lLj9yiRHct/YTBGf0NKgIiiPAMlgbkQ2dELlPQNaYyO7hUA95tIUoeVSPssWb4eGCGF
         eHhw==
X-Gm-Message-State: AFuF++n7e0vVOEIyp8vD/Ko7V87at1Q/pzs4/FdwBoxWddS9mE8+E+M8
	aV+jNOuS8JzjC38wcy8yCvDCRyTQhV+BwVOf5tQabm6glfDyozye9GZgXy1/26OnVag=
X-Gm-Gg: AYBFou35KM40U6PYBVRadJaTT2aDazTS70KBZp3zfBfiBvurtOn0N/KFabA0rgVZr7d
	K8OgYrgyHKO92QxZlcPZS2XjKJckcNarvF0gEogdzmRKUbqk0PhtsOwsm+VFTA2DbIFg6sfVDbO
	cwJBQrxn9ES5dAAA/LzZGt8qRCjieX3q615xIajN7Yeyw1OCc+ojvkXgbHnPDKHbdb/R2gI0Bb2
	0R+xrqxCzV1ZAYDzJ6npqNuh2lO0zsHGqumBIPjzu/ZwLM12r2KWXsjsf8JHyJY5PGR9YFq1oNx
	tm0ipdFiIe7gi6RicqGPPgd/oklwumV4xrKZgRx8hWoRY30/hggaNA0Ml86ZTP1cd53I6UFKqld
	NRbonrhfFaSlKevtvo6kpIG3wN0B6+aL21awyB8Mxm8gCXRCjrBQ1/yNDTNMfTwBsLN4FPzLDGN
	aUvV+JwUUAS0QNoTN/jfOg/UfHInSmSdKqC7paPGRy2ZFQG7ARPbR78gDkJiIZ2NFRaappXa/UA
	09+bUIKI593fXq/xYC+ONhEXe8=
X-Received: by 2002:a17:903:26c3:b0:2d9:3bee:4f32 with SMTP id d9443c01a7336-2d93bee5194mr129021955ad.20.1788236508486;
        Mon, 31 Aug 2026 21:21:48 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598b8829sm45204685ad.73.2026.08.31.21.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 21:21:48 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: Hash lock addresses in rqspinlock violation reports
Date: Tue,  1 Sep 2026 12:21:08 +0800
Message-ID: <20260901042124.365620-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

bpf_prog_report_rqspinlock_violation() prints the attempted lock and
every held lock with %px, which expands to the raw pointer value.
The report lands in the program's BPF_STDERR stream, and that stream
is readable through BPF_PROG_STREAM_READ_BY_FD with no privilege
check on the read side: prog_stream_read() only validates the fd
with bpf_prog_get().

Any user with read access to the program fd (a shared fd, a BPF
token delegation, or an unprivileged child) can therefore read back
the raw kernel addresses of the rqspinlock objects, which are
dynamic allocations whose placement depends on KASLR and the slab
layout.  The verifier-facing log path gates pointer printing on
allow_ptr_leaks; the stream path has no equivalent gate.

Print the ptr_to_hashval() hash of each address instead, so the
report still allows correlating the attempted lock with the held
locks within a boot, without exposing the raw addresses.  Fall back
to printing 0 if hashing fails.

Fixes: ecec5b5743bf ("bpf: Report rqspinlock deadlocks/timeout to BPF stderr")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 kernel/bpf/rqspinlock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 111ec80ea958..5721dc1a9577 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/bug.h>
 #include <linux/bpf.h>
+#include <linux/string.h>
 #include <linux/err.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
@@ -673,6 +674,7 @@ __bpf_kfunc_start_defs();
 static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	unsigned long hashval;
 	struct bpf_stream_stage ss;
 	struct bpf_prog *prog;
 
@@ -681,10 +683,15 @@ static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bo
 		return;
 	bpf_stream_stage(ss, prog, BPF_STDERR, ({
 		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
-		bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
+		if (ptr_to_hashval(lock, &hashval))
+			hashval = 0;
+		bpf_stream_printk(ss, "Attempted lock   = 0x%08lx\n", hashval);
 		bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
-		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
-			bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++) {
+			if (ptr_to_hashval(rqh->locks[i], &hashval))
+				hashval = 0;
+			bpf_stream_printk(ss, "Held lock[%2d] = 0x%08lx\n", i, hashval);
+		}
 		bpf_stream_dump_stack(ss);
 	}));
 }
-- 
2.43.7

