Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148300;
	b=mVFnzI6JBwYnCx/tbk+Px19Wc9zB8U3HOdXahUiex1CV/l0x4ipGLWjQO25aC9oSdiLO
	 bEpLvR830n3fYWxn4Yi/sOdB0eA4LJLG0rg7wwxJE2XkhMTrWnnaDMZPbRK2h3Z+AP0dz
	 wtm6x2obk2zUdJUNs6EBMD93RJqrVENpU5IwyyTUKF574F8ICD0s1GUzp59xQ4cOp5dsP
	 rOrkf0xezmHVBK1TJByq2bCr6JLQHn/uMtPzVjDY2W/KEoi1R+JqwTmXTkE/lXqox9JH4
	 2US+naXidpjEJ/4fjusKD3x3DngBYC9b6t6rptSbzcvNl2fOsZarEB7rPDPRQ1Ie9TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=uFiQQLmNa4cjv5M4GHecIhC4YEKWlT1w13mO3JnRV+8=;
	b=G1E0OFWarJKJjt5yaVqK0vQ9xM/OWQoHxzHvUVcPbmNQyQVLpSF0t3O9bxl2cPtOirDJ
	 QiXHUzhH755V+d6SdyacAPvj/0dgGJ5ipeHFWHjBkN25xEaqMctl5s2eob8iE1j3J6TiR
	 uWT/kkk+n8z+14Dq2zD3moN37rb4i519PwO61uR4fwqhrUo8LgYxBk0KV03/BOcWhXoVG
	 Xat/4j30teLHyfKel0I2q01DFJlIj2xOUvDgRoXmZLkLRfTqmFM1CLwzs0bwUEWOThMoE
	 wbs59bXWvPGKT0zjLldCnpsxDhXxN5mjh4SBLT1OBsdbOSdWqJoSKhLo0Gphveoob8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EAOcxs8B;
	arc=none smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A0606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B41A0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EAOcxs8B
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df388215aso30962f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148298; x=1793753098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFiQQLmNa4cjv5M4GHecIhC4YEKWlT1w13mO3JnRV+8=;
        b=EAOcxs8BnHy5hjm/46jS5ZxiGNKoCK4tBaTwopQNbyP+RBo7QfA6J607umzOJCQ+/g
         9A9FRjzqQYTKPbsPq4zBpfognUQAct1bxi+Qiqka7AsXiwH3fgjprXZ7IEiBuSojeU63
         nCLFkzKO5Fyq6zHwpe2quEgmI/3qhtaCsI6sE8biaDPOrvIgYpluolygj8Rl9QS5pTFk
         BqQadGx7VWlDzevyJUxggvjCiXLl7LKBqGy1bGvmEBbRqLPRUnLSiiJYF8BAtCI3R+da
         EpY6xCydSmQRQodlfCDDhsLiRQph6oH7mvTrQQ1LOvQWmppjYdNv8UzuuoyufSIpnt6O
         Xf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148298; x=1793753098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uFiQQLmNa4cjv5M4GHecIhC4YEKWlT1w13mO3JnRV+8=;
        b=iuLoGKpNiZgxRq3G/A71XII2m/M+EvydIpjsnUQjLPNPv92/55RYN+FeDbb6NVvf2a
         HiOD0W1Fa25ZO4bTw5ybipu43d/DGuluBep/uAdf5d07igqGgcd+gTdIt/89JPSASDY4
         uGW7PawYHu29JlN34RA+Nt/DRTYJzTz97OISLStyj0oRmQHfMKGRCAGzLmYS1f7tz28/
         6zWWP9J2nm27ChRWXVzLSNewZQ2Rc7+7efaAy3stAo5naFd7gJNrZmq/ALMF5oYVX6jx
         oI9GrEh2hrU10KPOQg/XgUWOX8vu+zOjqlNj75u5lCNdAd598AdRBaI3kRoOdmBfhrqX
         R4/g==
X-Gm-Message-State: AFq9FYJAq8/gf5/IZtxurcTbGYgWoN+m61vIWogeL8u5sCojo89n66sy
	xhIvYdXkFn0DdOiDwYT4EkIE+DlHLncDC/pMXO/QMssckG57WrfAxTkDvpICSwmx
X-Gm-Gg: AYBFou0rTlxoKS5awVG46UbUpEs4QKhTPMjNuIfiHdDJ1FG2z2Assiv7Y/nY5P+KPFp
	W6mB2EWSFcSryUSWQWrfKLim0/JkQHM6rtzjFEAxmiSOuZXKjFDgyCsbxR2/CMgDws1ITeTq3zD
	Lf/m/nHT9mFAeGYJG7PRsUUFA3Qvh8/F7MYdl/ddOm5rW9Z3lA77xvPxSBzkXoHiU08dOJbH2/2
	6MQ3F83PinJCtqDAQN6P/eETSlawjtwXCEh8JHgHs+GO8aj23+Fe3CQaRNIR/IPm0evly/SlWQ5
	UYTlz4jb93CY1UBcio+V4doAcBZr64MBH6ELXpM1CRFDnnzQMubW4hEjTNv6GzL7fCFt99eWpc1
	SBkENFVF9/dnAABjLik/G9Y/r/Tk3Ybfk8XpSKc3eEbIOLX/Ucam3oDPDOnmRPbcEcJRBeKwq3D
	cvUoDULRfLtJcFEgUx5iv3n+qCrbz4ImBOgLU71uNd9Y/5vt1k08+Wgp+RTJm3iO/oFjJiJuA6d
	PqydAEi55+tLVtE7FXvnXDQuOyByJ2zapIbV4jhB5+Wcsvp8dcNfUpo1inkZ3op7tGY8POvEG5f
	QjDWtzo0cO0BlNkEGjXtc8nbl7xuMbRhwN+vz61jYhvzIXUUYGsWO9CZbJSPqG6qJMIb8WfzLpw
	EW35RFKh60/Galxoh4ho=
X-Received: by 2002:a05:6000:40d9:b0:48d:efcb:1fea with SMTP id ffacd0b85a97d-48e5d233da0mr2907249f8f.0.1793148297985;
        Tue, 27 Oct 2026 17:44:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm24584392f8f.43.2026.10.27.17.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 05/11] bpf: Let the callback of bpf_loop unwind
Date: Wed, 28 Oct 2026 01:44:42 +0100
Message-ID: <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404; i=memxor@gmail.com; h=from:subject:message-id; bh=PrhauKrEI3KQjegHAixXV35C7nfq1jyvd7Ono43JjgY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh4zPOubxe1zmnn1eVjai//+ZomWFhbPjKyzWPV2v1K eomPJzdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcOMrwP23XTum2WyJrp2XP mPbprEiG8etlWgGmfLO3iBzmYXKZJ8jwh/9RaiabUv8Ed+9f0ksuHD+0UFI9LIt55XM96YYaida H7AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The loop holds nothing, so the pad only leaves, with the r0 of the
callback. The inlined loop has its pad already, so the verifier lets the
callback of bpf_loop() unwind from here on.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_iter.c | 10 ++++++++--
 kernel/bpf/verifier.c |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f0b29a170935..efd23c973115 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -5,6 +5,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf_unwind.h>
 #include <linux/rcupdate_trace.h>
 
 struct bpf_iter_target_info {
@@ -749,7 +750,7 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
+BPF_CALL_x(4, noinline, bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 	   u64, flags)
 {
 	bpf_callback_t callback = (bpf_callback_t)callback_fn;
@@ -766,13 +767,18 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 		return -E2BIG;
 
 	for (i = 0; i < nr_loops; i++) {
-		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
+		bpf_call_cb(callback, i, callback_ctx, 0, 0, 0, ret, unwound);
 		/* return value: 0 - continue, 1 - stop and return */
 		if (ret)
 			return i + 1;
 	}
 
 	return i;
+
+unwound:
+	/* The callback left with unwind_exit: the loop is over, and so is the helper */
+	bpf_unwind_leave();
+	return ret;
 }
 
 const struct bpf_func_proto bpf_loop_proto = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ac9dbe082181..4b4d8479fa87 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11402,10 +11402,15 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 	return err;
 }
 
-/* The helper calls its callback with a pad, see bpf_call_cb(). None yet. */
+/* The helper calls its callback with a pad, see bpf_call_cb() */
 static bool helper_has_cb_pad(enum bpf_func_id func_id)
 {
-	return false;
+	switch (func_id) {
+	case BPF_FUNC_loop:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /* The kfunc calls its callback with a pad. None yet. */
-- 
2.53.0

