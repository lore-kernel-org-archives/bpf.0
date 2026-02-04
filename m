Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93412FD7A0
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178124; cv=none; b=eon6CT6PVGEF8Cgvbcu5uK5KRJNT+cA3qVIkZ6SRO5HPAu62c3dtdnR/RllwbeKKSyD+zNZtsBH9cj3P+PK+rH7+blSY1CC6Un1Zl5KhC9/l5DgvEUotS4Z/rcCLyeHAH04UR+G+l+UKFQk+pG6LweTjj5ktGpJwDSCAYYvgdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178124; c=relaxed/simple;
	bh=EHbKQIVTqeIGKON9OiE4YL4MYDfTp8GxMi8M6dRx8yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g66KajYckZi8LycRiQnN89PTXPWqAfILPoZR6CNlY6BunHUklMNL8iHmfz7CNuxN/sGZ4jMtkSPsApJnt7O2/niWgcbaYiYbmY+ITrA6paQZGfnaoTy1AXRBoBKJDcEUhcHwWWOhLotNWRqtHsc9N7UjrelrVAcewwm82Duvh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbjyZq/w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbjyZq/w"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823c56765fdso2297964b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 20:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770178119; x=1770782919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neOpCYQFngkvhjSRp8EQNNDXnkfKVHtTaKJiutiskcU=;
        b=hbjyZq/wBTAMlyg/B1BdwpEK7+jsbzCvx4pl7G8ud+tmmQXvmradc2J15hYdcbiTfC
         El0k9W+HvTL7ZrPC4B7K2fjLYADMJkDYB5bLGiAmJpbl5kSbiYT/E2IsKqEhPIhSUYui
         5r+9rDwPM0arrhtD2SGn8quek4Q1tRoKYVpUQwKkSzrYwBXwsPDT6gs/6tpq0Eknagvi
         rBZ4+Tiyd1IBCqaz+ctIMxDzGz18zMiCbU2amJXUgWP+/W+47XcUSLVYn5LCrJr+eRNV
         gFHC4LL/F+kaBCJXEKKXWs2XKweXN67lettW2aCRTjz51NFI7GHKt7xPt2/szX7crfmh
         CTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178119; x=1770782919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neOpCYQFngkvhjSRp8EQNNDXnkfKVHtTaKJiutiskcU=;
        b=GhPJ/8hAkf/BQ3ENDGJua8jxX4QagXq6CE9cJrjgIpenD1KKclVCCc21dgFYSUyZA5
         ID0rlwmb5sbQn2jIHf5/7zDIVh03bPbFRRPiKxUTjTHcDH9H4z1fCkkkRxnViga63qe5
         2EegegLT+A07szy3EO4TD1UL2SRoWKbw5XekBdEmk9duI+qa3RAxB5cHCqeUZ4bLrlSX
         nFwziwjZHg1aBSGO0NBrvu/JXgPklPfiHDgOpI7qQxz+eRfIV+FgtJkv3gpUVdmmjhvr
         DFja0OX5yvkWTYHQP5MASBaogsfBSE55+Np72Uc0eDIV75LgEz9KIzALSVwfxFw4/GT8
         oKTA==
X-Gm-Message-State: AOJu0Yx07u4R33MzE7VukteN/2TSxd+wqDbslbaidaiJPyTCKk89gVIB
	mDAI5N9Qu7GUtayib5Erb0FQQwzmnvEjNG8+BTFKCn2iKiRa4hWFjHhyhnQXIg==
X-Gm-Gg: AZuq6aIYwD+rZ/B5ba5jGd9bzEBOLMaxpCdyRxDAxn4y2bUbv0GVNbBZw+bDbGTXmdr
	FotyNyqPiYuGqTENW4fa/sab9u9m/PbBWY2CjiPmqFyCoFeFcWvAlsMSF7fkRvqOOWrdFS/hXCx
	9w6clwQnPbclPgdywMzHHG4Z18FjlM7WgDee1Uiqmh4smmmEDgwW2v8z/uzLIVnsuIwVfV2jLdn
	ERBhHK/yS9L8AQdEafi5NweQKkV5Vv5Tplm3iEX/fNFZQgpRFt1XLsxsOCjKlwvGWwxXaHubUsQ
	RK1RlB1G+bGu08hQFuz0/3OEpxGM39puADIO6qAaJJm6FRaX4nKtDMZMTa6NBsPJzrPrWlmWo3I
	FMy8Ey2hyPTyRSraAvoEGVXazXhwKEMbNjf5c1cE4rtau+5VtzlegEYHIBkOdVX4SYekK6tRVtt
	I+zpScSTGoaw5o5v02WRsOumCn63PqL4pLTKBPhHjyybLJSJt9tWbWE406C+2F/RSuApKiGze21
	LHk3Skt/l4Y7XAwCcotGXTnrQzjmSiThAKPLGOnYnso2T+tlA==
X-Received: by 2002:a05:6a00:2d27:b0:821:8ea4:480e with SMTP id d2e1a72fcca58-8241c19cff1mr1651199b3a.10.1770178118597;
        Tue, 03 Feb 2026 20:08:38 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d434ec8sm863776b3a.42.2026.02.03.20.08.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 20:08:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v2 bpf-next 1/4] bpf: Tighten conditions when timer/wq can be called synchronously
Date: Tue,  3 Feb 2026 20:08:30 -0800
Message-ID: <20260204040834.22263-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
References: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Though hrtimer_start/cancel() inlines all of the smaller helpers in
hrtimer.c and only call timerqueue_add/del() from lib/timerqueue.c where
everything is not traceable and not kprobe-able (because all files in
lib/ are not traceable), there are tracepoints within hrtimer that are
called with locks held. Therefore prevent the deadlock by tightening
conditions when timer/wq can be called synchronously.
hrtimer/wq are using raw_spin_lock_irqsave(), so irqs_disabled() is enough.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d4aedac14a60..0517e9a8fc7c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1430,8 +1430,6 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
 static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
 				 u64 nsec, u32 timer_mode)
 {
-	WARN_ON_ONCE(!in_hardirq());
-
 	struct bpf_async_cmd *cmd = kmalloc_nolock(sizeof(*cmd), 0, NUMA_NO_NODE);
 
 	if (!cmd) {
@@ -1473,6 +1471,11 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
+static bool defer_timer_wq_op(void)
+{
+	return in_hardirq() || irqs_disabled();
+}
+
 BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
@@ -1500,7 +1503,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, fla
 	if (!refcount_inc_not_zero(&t->cb.refcnt))
 		return -ENOENT;
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 		bpf_async_refcount_put(&t->cb);
 		return 0;
@@ -1524,7 +1527,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 	bool inc = false;
 	int ret = 0;
 
-	if (in_hardirq())
+	if (defer_timer_wq_op())
 		return -EOPNOTSUPP;
 
 	t = READ_ONCE(async->timer);
@@ -1650,7 +1653,7 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 	 * refcnt. Either synchronously or asynchronously in irq_work.
 	 */
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		bpf_async_process_op(cb, BPF_ASYNC_CANCEL, 0, 0);
 	} else {
 		(void)bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
@@ -3161,7 +3164,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	if (!refcount_inc_not_zero(&w->cb.refcnt))
 		return -ENOENT;
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		schedule_work(&w->work);
 		bpf_async_refcount_put(&w->cb);
 		return 0;
@@ -4461,7 +4464,7 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	if (!refcount_inc_not_zero(&cb->refcnt))
 		return -ENOENT;
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
 
 		ret = hrtimer_try_to_cancel(&t->timer);
-- 
2.47.3

