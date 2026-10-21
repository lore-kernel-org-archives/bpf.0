Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598195;
	b=zjvHmavTKGQ1qXYRwHaIYqTpH+xkJWh4BGds0NvWi4fwbXA3IAbBqJvXyy0RSM2CGXOn
	 1Qu3QMuJTR94aXZcJmv5GL90jLKWP8FR6KwlM0bp1czY1JCkE3BlVzZnEbXDsK8OQ5ltV
	 h0hMFJmNLghjKODS/1Z8nZ8rlPg4DI6o6LrDXv3jd38uOhbaN7lowoor8ULnqNkIA4TcE
	 ngogiw4By1IDFu1tlLcdi3UONEtYJATwo4ikveSL4bHDPE/yXUScbs3Dj1sfgXy7fslGb
	 FZ25ijbbeePBEoTAZw8UQO9rkrMF2lOqcsN/yicULADSOnfoSildfEc3wlGLvMm8Wjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FCnhV+lw46CyFDBN1UCX/mRnoUsaQyKF8bIYd93ewTk=;
	b=FV77hlsGZFrPkBOYRlcM0Wc5bkOQZ/PBMxaSUQdbFpv1zOnT6P8rTJ9BX6TbIteFTKHK
	 SBHL7Dl/mWnhN8dRLHEPPIf+VwClJMEWa2BhFOT3puF6sFhKNSE3UMDolJPpEOQYRRyWZ
	 1YSc20dacg9tcj4gEqtPTSEkXbnCS5BGYBNbLJ+AzjfItC9LuBhlPxPkrkcUmqZfIRuZN
	 oCpcVunoZcIEyzQDx4T9Hco4XnDl55bD0wY3SYDO/VRskSTC+ISByFokab9/AWTlrvVlX
	 MYlgEa/i6YRt3g6P/xlNu362yXPkgwHRFden9+aI1ZM2n0OSZG3ikRLfwLPFYC1plkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GrsZ2rDA;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFA606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CFA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GrsZ2rDA
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8246b13cbso6639325ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598195; x=1793202995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCnhV+lw46CyFDBN1UCX/mRnoUsaQyKF8bIYd93ewTk=;
        b=GrsZ2rDAGG0a0xgUAdwsNd41lp8UzTekV9p0VDqvOX9F0jLmUngcbCWBHVjXYazPwn
         BQtb3EHlwT47Vm5U/87fY62g07CqW9losqZzvjv78F0dYqX+95LsRv8qC5k/+GDtfCMF
         m4ZZmcWC/ukv4rkDZ8qgzSgyLDV4vzTq24He7LxfhUBgsvj4/P0kURtVvG0rjIDnn4ep
         84wu6387KnKZjYh642JQeT8N4km8ujQo0ZxdIQewLOFGZTiMYSAyZwcBvW8dFFURjMyX
         Z8erMmNi0s005H+cpppAESbIXGtBIzo1Oyrz1VXppyYYT49Up/wnsPDtgiQGnNxtFGXJ
         cC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598195; x=1793202995;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FCnhV+lw46CyFDBN1UCX/mRnoUsaQyKF8bIYd93ewTk=;
        b=k6NdDAVjDgDGoxJ0uS7OW7T6gCA/02ac7cO6MBWC/Zp2thLhWhevDpoAoupsf/wX3+
         SnT0Q1LVwdKfTjzvzrWi17TDiRQSSMM8evdDx28DsD6iVQXuYMb2n+vCsmfmzGHDU6aV
         yFSrV28CDdK6Yl1XRfrBdoUUcrjWJ66PUs7YDTAvmPFM2BrKHdylfvwyMOlO4jaDbMYi
         iMzlgJXrHFlIIaOTMlMqcClDJzy5B5Oy9WoqhjUuGhilzg3LfRuRdmS2hcHggfBuptlp
         15z2+jYbnwuBB6m6vOMZg6K6eCZvlOT/DlRypy5aPOLR+bdWTcMNB1PjuOXz1Y05/taY
         snbg==
X-Forwarded-Encrypted: i=1; AKwUvBwmsHahT+OJ3kJInQx8i2Mxr+JoKn1z9JjSwqmsqBx98FaZuRYu8DBEOxO+KSetHy22vh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEFUD6vbYU/fO9kYgu882KfUTiv0oncg3ZxvQ4cCJsLYQPHpNN
	LhujiPeyBZU3913zAt5YYKp7hICQvSK4xvMqoobAwAPqznP/XNNbB41opheNVJQn
X-Gm-Gg: AYBFou2Y7/S325Dequqw5Kj3eOmiOSPrGwgXq2jfq04HwYM1Eu+BQnYc+Jpc3Da1WAr
	3OD3IMgieJTrUtMabu5/f0LdoOvOFxEwMVK/n/WwnY4NIjH6mA1ijrEBHtZJmYOVuneJ4dpc0nZ
	fdXKai2BOpiSgQPitw5SPuoOK4PAO4L+TplYkOQNz4VyWWuy7VJz1VFr9wOlOqZ8wPaXXRmLLwR
	zF0i6QbHH+QTeueL1X+WaTBOhe0WO5Zo2tbM8M6vuz+BiOOCn33eZQ11RL3dehxJB+REmuLO4U/
	ZasPUKFn9l16xrUY682RgJEWrr5oaWYze4e0ZvORC6wcNKa4tlQ18DStP1dmPIBYFi2EsouK6Hd
	4JjW/O6eUlDI1HzN3GR6yPLCmutLKqNQe53S9xlAxEwpfqfl3JBUZtlStS3rPflnUUHMGapKSXw
	cKDGMsI3R47Dw9xSdRW1GmlUH8s+ezkXbdGldPN9LiqmE2Bcoa685p/Masb2Vv2wKtcwSxG+zaP
	d8ZP6o6n1FpHrX2pggJ5OOuMrKk2WozPMic9yFMAakSobp5GDW+VwSbNBnkT8Hy8hh9PY/ZufRW
	lUHvqtz8sN3m5BAUVSYA7/uyU9w9C/iAHxgh6UVy8sJvmyMVSigX/Uk+txw=
X-Received: by 2002:a17:902:ce86:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2ea43e179f9mr19372535ad.33.1792598194718;
        Wed, 21 Oct 2026 08:56:34 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4536ddsm13394895ad.43.2026.10.21.08.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:56:34 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for saved_data_ready in the verdict path
Date: Wed, 21 Oct 2026 23:56:29 +0800
Message-Id: <20261021155629.68813-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sk_psock_start_verdict() and sk_psock_stop_verdict() access
psock->saved_data_ready with plain loads and stores, while the sibling
sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
/ sock_map_unref() touch the same psock from another CPU without the
lock, so KCSAN reports the race:

  BUG: KCSAN: data-race in sock_map_link / sock_map_unref
  BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref

Use READ_ONCE() for the reads and WRITE_ONCE() for the writes, matching
the strp sibling.

Fixes: 2ef2b20cf4e0 ("net: annotate data-races around sk->sk_{data_ready,write_space}")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KCSAN); it
reported the race.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
CAP_BPF / the ability to update sockmap and attach verdict programs.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/skmsg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..0bfb8c4e7f36 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1260,10 +1260,10 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 {
-	if (psock->saved_data_ready)
+	if (READ_ONCE(psock->saved_data_ready))
 		return;
 
-	psock->saved_data_ready = sk->sk_data_ready;
+	WRITE_ONCE(psock->saved_data_ready, sk->sk_data_ready);
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
 	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
@@ -1273,9 +1273,9 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	psock_set_prog(&psock->progs.stream_verdict, NULL);
 	psock_set_prog(&psock->progs.skb_verdict, NULL);
 
-	if (!psock->saved_data_ready)
+	if (!READ_ONCE(psock->saved_data_ready))
 		return;
 
 	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
-	psock->saved_data_ready = NULL;
+	WRITE_ONCE(psock->saved_data_ready, NULL);
 }
