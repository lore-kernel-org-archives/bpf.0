Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96483DE450
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933666; cv=none; b=cwKMYjAmnl21iviIiZncgRrmmQPixp3cEnGMdqgsVliuMWfvrXD4pYbyDjYdnpgtNCZcoH2OcOSUIiqatc00CXocX2/cc7q2gt0gotlS2XxJb4qO7JVfp3Xdj1AayO5hegejJX3d845k43sTr4Ws/5+pyiKlZ1LPiV3/mZCQGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933666; c=relaxed/simple;
	bh=7Alr+b84YmA8dwYrW+JWo6hpo1G/eRkPw5O8+Py+Dow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppesi0CM907XTlbqx/2YznvagHFn2dZyYNLEWC3q+x8MaDTySlR1e/tkU3MFVo6bobBDPnAXv0//jYfGFICUHGN90ApgTlwrPt5W4zw6jBzA+VwuCDPuVu/I21FbE6LnV2y3dlKCX6cZ8QhpEIhMxoziw6mYKcWq7l3RBuuwz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnB6+TYo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnB6+TYo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824bcb2011bso370867b3a.3
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933664; x=1777538464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqLSOmOPVGWKUoYc265cigMlJk7MPx52K3EKiqiJqxM=;
        b=NnB6+TYoU+6XsM/zcx65Nilly7e4MxMWm9tZ6fuobT9PJoMJF7G2y4W9Q3TGF8xDoy
         uEeGM4GvlANMr7hjSMJky/ASp1wmJjSgQU0IZXAvFfNLAmkMENcXq/ro9mWKn35AxBQz
         PvRwHK3dA6uaq5tWqWC6fYQ/+TLe9ZbOLNSCwpAmBzSbyXvbHAmT7HCAnddXAkD3YXJj
         oiynw7ye/L23ofBsD8vg87o1ub0DnbEX1WUzaIB9CtezgXedF/XAwoKYrgmuE8jXZO89
         eK43yhA4oLDsn88r3Fcl5xP4qAPZBDBFN79MrBTVTFxlDl8KOlD7+ZzHZGYXLExp8g2R
         3ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933664; x=1777538464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqLSOmOPVGWKUoYc265cigMlJk7MPx52K3EKiqiJqxM=;
        b=o9un4ov51pCbclK5/EjMsqsBmrR6lhg42sZ0/CwbqEi94+6ZIDFdq86HJ/sFQ9nreu
         2L9GWmvyQiEn7ydxbi/WdbC9J/rqEViXasaoqra/IrcLuB/lvi9mwLjVYrYquoZjeoRO
         /7kSvZWcibcOmTTKuvby59EvSR73OpiOO3c+iDGSxfryJ8zMdnPu8o7RW31CgKGXXMLu
         8AmNwKJNHJuYI5ZtX13mmNOH3WMac4Q8cU6oecUtvUjzgJF1OaiqBSAFYAKiCyV9PVn5
         UxVGnhhgfRjbo4Lxld+Onex8T4LyO/ABVJnUbIo4aPZ4LbgLaQD6f2hoNvkEsVYtrEjV
         +ByQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1/di2ZkOqqaTGTp5Zg9COF7QT9geZHeu2dRXL+tG3iU4NOCQDmAHDx4SVkRFGBFrZ2lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCO1KgkuDBo0Uq6Nbyb5OyVbeCXeSNkjAtIuKiKzD0lQxrT7D
	M6iFK7YwnDnYlZPsX6+vW/Isc44bYKDqDrvur41zG0ZZHWoDTMm1Ls9Q
X-Gm-Gg: AeBDievS7Lk2F0dRBQ4Rqno5WRfwm4U/mPDXvzTzIjhQgvFlMapV039rlfuT8chjLSu
	Spu5C5+Ho8pwVZZHSIztSfvh02T+hYrA90r95D1MYygcHWHrmEWpRW80Qx537OcGrGpJv5nUDvY
	L38kqKdZ9kAsyvfLDBGJLTa/Or8nXYZh7BBdMLZfXsnlkWYyOMw1+WtyGHZuySezba3yd+rExBV
	JV9qRaIpwbCa8s6uWUILhE+4EBXhvcGPNf9GWmkMvSaUPzzNsyXSQovIGK0Bo426XHtE9BSfiP9
	qwGu0fE1Z+F9LlfhP7WvuTGC9DVaciicaEE/RkQbRNksSgFjyhI7QQk2LcTJ/Cqxua4mb1InppK
	TGV8r6R2NWa3tw46eq2fgz9+1ZhaY2aufqM70JKEJem98ZBcz1Hh+yKq8KM5lpbiqTL/zJJxMeT
	xUqP0YyghOuw2W59EHQWlaaoR9eHjV6EhJzkIqmA==
X-Received: by 2002:a05:6a20:72a3:b0:39f:6343:c6e6 with SMTP id adf61e73a8af0-3a08d8fb92fmr16074773637.7.1776933663905;
        Thu, 23 Apr 2026 01:41:03 -0700 (PDT)
Received: from LAP-0337.. ([182.176.170.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701b1a3sm14714948a12.19.2026.04.23.01.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:41:03 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
To: asml.silence@gmail.com
Cc: axboe@kernel.dk,
	bpf@vger.kernel.org,
	elirazamumtaz@gmail.com,
	io-uring@vger.kernel.org,
	krisman@suse.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] io_uring: fix missing submitter_task ownership check in bpf_io_reg()
Date: Thu, 23 Apr 2026 13:40:24 +0500
Message-ID: <20260423084024.31721-1-elirazamumtaz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e49d1391-b06f-4d60-98ff-0f034f2ed9e9@gmail.com>
References: <e49d1391-b06f-4d60-98ff-0f034f2ed9e9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 4/22/26 10:20 PM, Gabriel Krisman Bertazi wrote:
> How is this a protection?  I thought ctx->submitter_task is about
> IORING_SETUP_SINGLE_ISSUER. there is no permission or capability over
> it against other processes.

You are correct.  submitter_task is a SINGLE_ISSUER mechanism, not a
cross-process security boundary.  The "parallel path" framing in the
commit message was inaccurate.

The code confirms it - submitter_task is only assigned under
IORING_SETUP_SINGLE_ISSUER, either at ring creation [1]:

    if (ctx->flags & IORING_SETUP_SINGLE_ISSUER
        && !(ctx->flags & IORING_SETUP_R_DISABLED))
        ctx->submitter_task = get_task_struct(current);

or deferred to IORING_REGISTER_ENABLE_RINGS [2]:

    if (ctx->flags & IORING_SETUP_SINGLE_ISSUER) {
        ctx->submitter_task = get_task_struct(current);

The check at [3] I cited returns -EEXIST to prevent a second process from
registering on a SINGLE_ISSUER ring - it has the effect of blocking
cross-process access but that is not its purpose.

The commit message's Requires: line was also incomplete:
IORING_SETUP_R_DISABLED is a prerequisite but was omitted.  Without
R_DISABLED, submitter_task is assigned to the ring creator immediately
at [1], so the attacker who creates the ring already satisfies
submitter_task == current - no timing window exists and the attack is
impossible regardless of whether the check is present.

> I'd argue this is a non-issue.  If you have CAP_PERFMON, you are able to
> mess with the process in many ways beyond this.  Otherwise, how a
> process would be able to get the fd in the first place?

On CAP_PERFMON I'd push back slightly: it is narrow (BPF program loading,
perf monitoring) and does not grant ptrace, arbitrary file write, or
process control.  The BPF struct_ops path is specifically what
CAP_PERFMON enables here, not a general process manipulation capability.

But the fd acquisition question is the real barrier, and on that point
you, Jens, and Pavel are all correct.  As Pavel noted, any application
that accepts a ring fd from an untrusted source and calls ENABLE_RINGS on
it is already catastrophically broken - the BPF vector is just one of
many things an attacker could do in that scenario.  There is no realistic
path to get a privileged process into that state without it already being
compromised by other means.

The fix itself closes a genuine asymmetry - bpf_io_reg() is the only
registration path without this guard. I can resubmit with an elaborated 
commit message, if Pavel thinks it's worth applying.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/io_uring/io_uring.c?id=bea8d77e45a8b77f2beca1affc9aa7ed28f39b17#n3053
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/io_uring/register.c?id=bea8d77e45a8b77f2beca1affc9aa7ed28f39b17#n282
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/io_uring/register.c?id=bea8d77e45a8b77f2beca1affc9aa7ed28f39b17#n733

Ali Raza
