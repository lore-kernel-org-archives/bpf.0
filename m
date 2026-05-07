Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0231E84F
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178132; cv=none; b=IOR0s56LLtacMPWpFdYBQ5EE+pLHZBC0K5nc4XkZWVelTQ0wPwsOI4dw7pfTqyI1wM8Z7q1o9Wb2GmL4OG8G0OQhajkCZ2Re//XQvwMQl9GLP6jtd2UdHLxAc3b+ogbmXMxSmyZm1rarpwgbHxryqMKuTHaOl8Hp9Mwn18rb7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178132; c=relaxed/simple;
	bh=Bvh/8e/KvVDlrh92Jk+zibTGwctzsgCIIYtAsk9oZZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IrE8qcdyjM2wceyHOKb+vnoNnKEzitDK1G3mWEFrcooR/wVPwkjmm7jsWYEQU7ui7ErRTA3jiA12zf4YiVLRlKSkYORKIL1vJnGSWd3ptJY93fAI+zo/QRGytbBBpYU8Fk68dtO6swGkxhFLVV5RTqG8p5W/Y8hNGHHPigRc2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO+9T/PN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO+9T/PN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so7621015e9.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778178129; x=1778782929; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oY2DjVZ+rq4oFXUfzVAXJm5qdW7t2pnFtoLesF33FA=;
        b=cO+9T/PNU3uPJ+qF1IlRKsYLp08ViCdiQkFgP4k6LmVBcZXDIJh1AHyoILoRIWQSM7
         /egv/NZHVNaQpFmpmoa0oVZ9Thuq7233/4JCS4L4racEL/M9R6PNsJZuWE2UzNj69+kN
         3axr1xgVCHNpf/omeq238dEUfz5HfCmpiS3/JHKlZtd5tqiSHtlCysSAojvHRAz3gl2D
         IULnhfZ77Y854ainSYLKWUmt61uvCuVfsLOh/Wx9DcWLzQY9pQnddYH5GtsqRo9Ryf5K
         MvUWMci1zDn6opiytaRreJ4htsoK7XqrV/Mff/TSxD9Ih8XJarX5G3/Upi+nN613Uy+x
         HoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178129; x=1778782929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oY2DjVZ+rq4oFXUfzVAXJm5qdW7t2pnFtoLesF33FA=;
        b=SmKD6Kjzzn44X28hL2KcJBFRB+nZF/RL3USyqwcdy5JvjEZsN43yZ/nUbkx8vc+xr9
         WtOdeKxZaWUfa6+CpvryxngWYbhOoYy0j9lymBiumQ/w2DTJa20YPYPy80RFRGCWKpen
         7GaSthwSzBM3XWAOSTtpX0JEAhRz42NBkwy+Z6ttzKfTv9DcSUkdve1UEWHgW8W9RSku
         190GRXJhlY9N3d2sEanu1q2KKQeZZx+CG0JjIv9RrAUB+lzuu+eb238hOkfIyUR9bDSw
         ld37/LmJbbgG5AThBBYS959qTjur95B/OmPu3K8fEG+U0Bldge2BQwC+P+27O5deodNQ
         i+Mg==
X-Gm-Message-State: AOJu0Yzfwt+LAkyURDs9xkoEa3Lifexm+FlNOD1o2z73qeUOWLvzNM3m
	kowt4ywFITqDONN1FW4dwDdWZXkkHFLhg7GKzgPtoOdofSq8RMj3NEfPzTEPGw==
X-Gm-Gg: AeBDieuxcjDBANWcK9Vh1yLBIbm55FLE9MY3iChyMni0I3JV1yeCUDn+ibAk3HP8dbH
	yeVjz35lTjqp/gstxC8YlKuCws5Gi5nrxvoBzSiBNEW73T9kNYRhLkzcogSfh9mGXEfJodQiWp7
	FdU43fi4Im0XAxNTHetISZZgtgT/ftBghoo2ILei6Ajk4IPKMny9BZ6djRb9DPOXsZR/xbc5YtG
	cuuvE1dYPrkuQwGdO7/vOwq4PXt2HVIkwizaXxMAhomjWipuyRttrqAkpT+BOgWT/+SFIayzZEm
	tJS6nmqPLvz5z0FkZApRrVbQbvv4nLRRI53/tPxPt6JF76YhwYiAvKLGgiBhh85qv9WB5l+MFKd
	U/BXWbnxb5Lk2wsT08Nca2Ljnm6cwjf7tjEYvOjP2L7BzEgL9I4FWDlSVAK26lRw61LzU+qgYOE
	h1StifOImP4NdjxL+A6BMERO8QNDDlqZ1E3esPOHiBHgEBzRR0UDTvX8W4TCTELReN+WjE/VkeB
	fK/WGIv+01ZT/cKdrRFgrk9M0SUfUORZkJFUasauGvK3g6/XkkvAIyhPkZ7X9edy62MFvXWZVPW
	lcWZMAoc+800dNmNuhPHVFX9EE8DEWIY9ZIcjbLdsGfS7Ubvsg7m2g==
X-Received: by 2002:a05:600c:3548:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48e51e097a2mr147481585e9.1.1778178129302;
        Thu, 07 May 2026 11:22:09 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00eb99d23c3182f5c3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:eb99:d23c:3182:f5c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538bc9bdsm170565805e9.11.2026.05.07.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:22:08 -0700 (PDT)
Date: Thu, 7 May 2026 20:22:06 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf] bpf: Don't run arg-tracking analysis twice on main
 subprog
Message-ID: <e4d7b53d4963ef520541a782f5fc8108a168877c.1778176504.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because subprog 0, the main subprog, is considered a global function,
we end up running the arg-tracking dataflow analysis twice on it. That
results in slightly longer verification but mostly in more verbose
verifier logs. This patch fixes it by keeping only the iteration over
global subprogs.

When running over all of Cilium's programs with BPF_LOG_LEVEL2, this
reduces verbosity by ~20% on average.

Fixes: bf0c571f7feb6 ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/liveness.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 332e6e003f27..505250998f36 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1914,15 +1914,6 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 		return -ENOMEM;
 	}
 
-	instance = call_instance(env, NULL, 0, 0);
-	if (IS_ERR(instance)) {
-		err = PTR_ERR(instance);
-		goto out;
-	}
-	err = analyze_subprog(env, NULL, info, instance, callsites);
-	if (err)
-		goto out;
-
 	/*
 	 * Subprogs and callbacks that don't receive FP-derived arguments
 	 * cannot access ancestor stack frames, so they were skipped during
@@ -1934,6 +1925,8 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 	 * each subprog is analyzed before its callees, allowing the
 	 * recursive walk inside analyze_subprog() to naturally
 	 * reach nested callees that also lack FP-derived args.
+	 *
+	 * Note the main subprog is also analyzed as part of this loop.
 	 */
 	for (k = env->subprog_cnt - 1; k >= 0; k--) {
 		int sub = env->subprog_topo_order[k];
-- 
2.43.0

