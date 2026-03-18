Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA561392C34
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877840; cv=none; b=gOK68Id/pNkMdRlkNNKPCkhMh3R/YZqxT4++lAstnBMUXKzprxXXkhaM1fFXEK4RUfI5Bnw8zKmBV85TTCMUGxeC0EcmxqM8GjVyuUAi9WI3wEmu/13s3HkamuuUctowNZsQVARBOfxrzZjV+9Ym+j3S52ZaD8+A7EoKK6ZJjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877840; c=relaxed/simple;
	bh=8id2yCCwVJHe3dte98fQ6k5sP0jmBJlTbV3yLMS39sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0gZUXaqqGQ6xK/JtmmvwbyJtgXRR2Z7Xmruc7ITw+Mdi1dJH73pR1Y+4E5zovgH7Lc5Ig5MOEUhvGgPl4uaXAQAJ7IgtzTq25wApqCsyLED4Vfne5vjRSBg4QPp05/hfHXx6m32fLK+jnUx/IU+imR6azgV8br3bN3L/7RD9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS9YdwMl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS9YdwMl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486b96760easo4319325e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773877837; x=1774482637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbECXkBDqwVv+YupUd8JCpC6oKku2PAxGeKjUkgQMMA=;
        b=fS9YdwMlwQ4CH4GWR8G3QxHt0IQYOJ3goO9hKhANgBk0MzPQuiY/jDuOJJV7O6ROeh
         P367yIoyAvRONPmW4pJd7Wou1edW140JlafCaKw879SQdiR5hvmfZ0yBXrmnxz3DpYlU
         pN/tHdDYH/AGzKbw9YgDyBDb4jCpv47F8sWmNsbYNhk58VPrmmx66XsRyjktyJxoGlvn
         eU0noFfV+u7FGuZpoHR15S5UYhQqFNe25zYmZa11A3DjjYUlKLh78BKqmObu+gw8KQb2
         3TH7qZn1lWBhHaCWMBBTTLo1bdZAGGkxHBvcuWljxH9EVUv1KY83Vpcb0oKI5Q6eqPSs
         p3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877837; x=1774482637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbECXkBDqwVv+YupUd8JCpC6oKku2PAxGeKjUkgQMMA=;
        b=ouoELzE/rXmVYAc2a+/DqXHYEg9fWLtU3l/i1WZLF5kRNvgdmmjgdMrDXEEd0JKhxH
         0hgyhad3RNHE+OmMtU2gWc4xU/aM+0CD8OkdJy2oq2dM74yqz37y0k5ibEr03MNyAHn8
         SimGSaFwFjf6gbOa7Ltiq3zhTAKnk07P0fXxGZy/L7RmN3JnfLl5SWYusisKMTeZEv11
         2pKw9PhGM9Knvs/Q/JImpDk1uDnJ6R8SpLjwLvdcXDjHH6zyojVIfHYpbHZo2jMc6fNm
         lnPPOpW7IKLergaJ+Jz5RUOrvkqmRPazPyvvegkznn4L41D/gBo3P7ESR3UWBGZ8BEhU
         YxpQ==
X-Gm-Message-State: AOJu0YwOXr9eXHYRmhfuGMey4m9oAy90QEmWLIbS+bSXfmIPNoxqipgT
	UmaLg5mgZYv1Wp1+zUuLqWCcuqp/T8ZBjfHKuGNpkwlajrl51JS77KwE
X-Gm-Gg: ATEYQzyCX8tTw68F7hgvbWeg7h7iBZD1DHmq3KXVAOX+ZxVgXA4rb852jRdlOzoPWkE
	X/RCgxlcuXHVDpxwwKZsUAtaJOED5/NA/ohrzs1kEB5eearakivoIw9sXxpZjqkyP/hW8bJcxnt
	fHjpEdYhaabEoqZOAD5PmHMbNgFpuTmphAxUNaNncZaREMURs+LRdSF5xcLs2rM2+ZZa79/iavG
	dZeWAGHVJ5wYjG/Ho1NHTHQEyOs9VvqD9ZRWyaSMNam0/aVvXfPM/9sbpDeUkERf+jBAvEI06Md
	Jm1+e/hmNMzN1QZPYxTyy8CbZxQbyquDsPbRrKur6cUKpCL20XRxQ5sU5P1HGgY4zg9GtbWsT82
	DmreaEJw+bvq1jXR1o3J2+fEtW2MIgHYFIZzsH/cKFybXX9CrcxiJHRcYXqr/KStDv74Ofokjkh
	GsNnj5+2SMUWz2meUymg4WOov/aAN5j0J/1aSvrp5dsh3ZbFtayhWVgZf7hkm5XgBR9cNmg4PS7
	b1rRnLO61+91Of3iXLS9ue3IWEjMeilzMfXBL35mOtLRP1ja1RvkoMGcfjB04m6rrQobqqNuMf6
	kDF2v2K2oQzXjmfg7udAbQ==
X-Received: by 2002:a05:600c:4753:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-486f443848cmr83383705e9.2.1773877837109;
        Wed, 18 Mar 2026 16:50:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00820c1f4f9b3c7957.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:820c:1f4f:9b3c:7957])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4d10a20sm71389245e9.0.2026.03.18.16.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:50:36 -0700 (PDT)
Date: Thu, 19 Mar 2026 00:50:34 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
Message-ID: <abs6SmlOId9IVidk@mail.gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swmeukekw55emiwcduoq4jpjk6hwqk7nzxbcs4xgw4mir5ldd7@mqyinrubwmlo>

On Tue, Mar 17, 2026 at 02:14:48PM +0800, Shung-Hsi Yu wrote:
> On Fri, Mar 13, 2026 at 11:54:43PM +0100, Paul Chaignon wrote:
> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> > 
> > This patch fixes the invariant violation warnings. These warnings
> 
> Nit: I would say this patch fix the invariant violation (minus the
> warning part), warning are gone after this, but that because we have
> fixed the caused of the warning.

I wondered about the same when writing this :) I thought it best to not
claim too much and be specific to the invariant violation we currently
warn about as technically there could be others.

> 
> > happen after we refine ranges & tnum based on an incorrectly-detected
> > branch condition. For example, the branch is always true, but we miss
> > it in is_branch_taken; we then refine based on the branch being false
> > and end up with incoherent ranges (e.g. umax < umin).
> ...
> > Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitization")
> 
> Following the thought above, I am uncertain about the fixes tag here.
> Commit 5f99f312bd3b surface the invariant violation as warning, but
> invariant violation still happens before that, we just don't catch it.
> That actual root cause would probably go even further back, but probably
> would be too much of a hassle to figure out. Maybe drop the tag?

Yep, that has been a question even for the previous invariant violation
fixes I've sent. On one hand, what is usually being reported as the bug
is the unecessary warning. But on the other hand, as you say, the
warning just surfaces an existing bug which we are fixing.

> 
> Put it in another way. If a tool uses this fixes tag to determine where
> this fix needs to be applied in stable, it would determine it is only
> needed for anything v6.8+, when 5f99f312bd3b is merged. But this patch
> probably should was be applied to stable kernel before v6.8, because
> IIUC invariant violation likely also happens there.

Yes, that's definitely a good point. We probably don't even want to
backport this to stable kernels (at least not until we've built more
confidence via syzbot). We'll drop the tag.

> 
> > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> ...
