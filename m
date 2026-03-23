Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DB36E498
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253724; cv=none; b=PTmAufEocJkYnL6j/jqmxF8VL2gbcJuKJXwHQETMDeelz7c2UGswF8pItjWv+qePUIBmbptA9ylFWBC4dNCtNy6iGsRflciYQcdmPR6ZbRs7qSbeXzYLahsfsmDbrnb2qeu9U5pRX10P8Ex15ZRM1iYT7cNHF4o+ifN7+O0W2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253724; c=relaxed/simple;
	bh=a7UBLPO2IA/40WWYNK3kcXsG2/5lp6pTQOT/8NWNWFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVJPrZCjphZFborNS8SyLEUNgGZ2VzNKY+HWxlt7nEWOrNDL1cCd68DazWRKCu+28LtntXvH5v98tHSIQiJHW06D/9VWOfx93cPo09gBzujDbGo76cwhEBY17o5gqu4G/QoFCpgxw2iC394kQeFaoiQ3IKgvFIDM5QstVAA+mOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DH6Qddos; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DH6Qddos"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so18023835e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 01:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774253720; x=1774858520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seKn2ieXdQz/Ia+l69xJrCg9qqskhUaP7X3/5L1r0mY=;
        b=DH6QddosawYG6AzVjmjiKZxdeYX5Ly6SRVubGBdaMqYHZdmlWndEpp3xP90zmUitbG
         lBgRiJXCIi2f9R9d82g2NfIb8urKs1eP6IujbDVh5Y70eNfAksFNNfbmq3PvVNW7m9gx
         RUJ9Y1SF/Uq4UP4Bg5AM5mVZaFlos5dHILvuM5xuHymJUL6a+eRR25GZ2m7vGyJ2947o
         dewCmyHZg4YVnuRFbXbEBShr4Jfu/k5cxPLTVL1z6WTUUtRU3noxqi71cKXhobSvwJ+4
         wqjGSFrbZPbwfqf6kk9P+v4m2+8HMyjy1kA17z1jv++DWate1bZGDUeVw7QUGwBrrjBP
         Sekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253720; x=1774858520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seKn2ieXdQz/Ia+l69xJrCg9qqskhUaP7X3/5L1r0mY=;
        b=Xx2T4zBTLHbCMKSDnZDaZmji3uizErqP9skomyRvXHbZ9JD9PMc3zcBlLc/iU0ei7k
         Xg0R2tCwjEIK4CSKFmpsvgN48o1m10Tz8G1xs071KazoqmzvppMsNP4Eb85p7iqyDsR6
         WK/tWUnIUVuMiL0J2PvgKJaTNUkAeUV89AOU51HRzyrFBsoaO9Wv3A5/fa4o5nAJ/oxI
         vgbHyq6ABfzpt5OR6K1h8Ho5cwifoTdoeNHCgSa7ZAMC96/IlNFeestbHW3evAUncHxL
         Nnhb/cgL6W7fkFBFAlCZFzipa2Zps8lIRZNLRqMEUNPgfnKjg1l7QF5IcejaJFD/NNGe
         uT6w==
X-Gm-Message-State: AOJu0YxNa624+f5FsKCrn+ybbxzQNAhtDrjdUzjgZUG3owbSCuBGd4yW
	77Sxd6uoUpqymjgYhwUPTMyRnqshsx4wtCJ4q4xRuPrjXF5F/4a3N7eg+f4wQ9+3/wE=
X-Gm-Gg: ATEYQzxD48GDyhzZq0JH9X2ZmA/KN5sYh7KabhQtPOQsJXNsS2IcpDw0lLhHdKlwxfc
	jhZykko9r/ZExJcnenYozYylCl4DkVxKiEjqzyxk3x79VnmvwwJtnOBao/1kQDw6a+ctGZjytrg
	qJtdQt9l2Sgv4Tj89CJu8AEz2y236YqXY47+CdcrPWMtwDsT5an3+TRQbkB9M7bGLrU87NGl4Sp
	F3fJd4Ea43VMFRFkgrsbZIsmJZeEN1eMlYJiKWPrEBf4I3zNMD/lkztYU2fAYQ8cBg7zo3ehXak
	Qp/EBvZ2XuyCyDLQIf3gUvNU3JLpYaAPL/RWuC9lvStU9iV6xvU5+3evxFCgwsMpxDSh6qJmGjI
	p0B7WGH6QSo9hPXOXMdCnG9f5KakPMltTCExuysw5/NhmvlorCysoVACQEMh0VsCIesbsCNi6SJ
	jpKpgZFqy1oc+lqbmrdw==
X-Received: by 2002:a05:600c:4ecd:b0:486:fc61:541f with SMTP id 5b1f17b1804b1-486fee2e5b4mr147990075e9.29.1774253720483;
        Mon, 23 Mar 2026 01:15:20 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:239:b1f1:37bf:4abb:cbeb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369e41csm104007585ad.74.2026.03.23.01.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:15:19 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:15:13 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
Message-ID: <yb5dtmxx272flmotqcit36vcjnpu2fnly2s7yk652lqifeecoo@hhxpy4vghkap>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>

On Fri, Mar 20, 2026 at 05:49:09PM +0100, Paul Chaignon wrote:
> In a subsequent patch, the regs_refine_cond_op and reg_bounds_sync
> functions will be called in is_branch_taken instead of reg_set_min_max,
> to simulate each branch's outcome. Since they will run before we branch
> out, these two functions will need to work on temporary registers for
> the two branches.
> 
> This refactoring patch prepares for that change, by introducing the
> temporary registers on bpf_verifier_env and using them in
> reg_set_min_max.
> 
> This change also allows us to save one fake_reg slot as we don't need to
> allocate an additional temporary buffer in case of a BPF_K condition.
> 
> Finally, you may notice that this patch removes the check for
> "false_reg1 == false_reg2" in reg_set_min_max. That check was introduced
> in commit d43ad9da8052 ("bpf: Skip bounds adjustment for conditional
> jumps on same scalar register") to avoid an invariant violation. Given
> that "env->false_reg1 == env->false_reg2" doesn't make sense and
> invariant violations are addressed in a subsequent commit, this patch
> just removes the check.
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

LGTM. Cleanup around the (to-be-removed) reg_set_min_max() looks nice.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

...
