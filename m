Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307E1891A9
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770893; cv=none; b=B+5xCWAxxjRKTysTgYkUMWfVmvXDEMR9QKWj2CwCld2lNg16RsOUVFDp8ZLQIM5q65/oqufm+Im+kvIyeRFAl9VmP4LaK6ZPJTH5RpdrFTMeGcebeSXndL/yLHmbsrA1M2Rg01Ha7dQseknXL6J3365E7HEV1AuX1m6Bz1WxE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770893; c=relaxed/simple;
	bh=+bH73aJ3MyPjFrvzIB/+/ugrO+546xKFstMAtYnTweU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsaoT3E8HOTdvSArhAOvdkh1QkKyi87/lQ6USteTUdTcFiswumTVbkTvvAlrK1cDTrv+IH8aTJnzDxZ/bIEit7QBHhKC2OiUzH45osogoDX5oTeZ9PGhH1I2RQUAmVEjJMqgXKaX/as7iJYJRZGiix+4hUWQQHE54hUXrcQUAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqLArUfJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqLArUfJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483487335c2so32315345e9.2
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770891; x=1772375691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTMNTS1qQhHkRpmgMXkfEEo8IFcYCASTF6Iye1Ocd30=;
        b=IqLArUfJAurOarVcd7KB2D/oLLuDZXurwsTwO8+vFAAhEV65XLFCMXgwr/KHMlQjj8
         WYzdw6bb2OGkRH64jgX6yLP6c00NNNhwXuaMOoW8J8KDXJZWhTWPl7mArUzvriZGU6xI
         kKLAaU+HIP2vSEvcBg01wVdXPXOkh47QRas+916jfbo5ei6XgisIL8rIndbLB4uRUuel
         HSzP4qZGRih7e01J6pMem1pd4AcZZDBH0t1QO9WFFmyKOF0I5HhcvMDlBZ5Iy3jCdQYY
         uT6v8ml70WZMoUdae2REePRUfDZvdyDH9xTg1Q1GIE7rhpY9rcMeL5yigxy6K7jLRc3r
         6/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770891; x=1772375691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTMNTS1qQhHkRpmgMXkfEEo8IFcYCASTF6Iye1Ocd30=;
        b=YDLzoHBRjYil+ikJvxsng+KrXp5NGXZbaZ7Dd4HRp08z1hQY1+wdwjNlfW/wtDb7Ao
         ojcKnXHZHWi9CLdvOD4AqUtnCSNbSvztvrcNeqrwZV3WfycenOTQLzKbBL3WrYYPAqDk
         xVOVIyk1Sjaf8fGvKBPOSEVKLTLG0wxMIKB/IEpQPVZFKO24TtRw7jkrItPT5VVvnEWF
         LlLmrefezCgfs+P9dnO5YMlllu5tpd/wLW4Dt3lLFaeBVllY0G9unO7nyYAd3EIat39K
         ftu4kyq4WIxDYsQpxHQ5avNloys24a7Aw7yoJDixnkROLa91VncyCVKzGKpGXud3cPO2
         VpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVv1HdLQXmBW+Nvwd7G+PWOxGltSMSlo4xD8dstuBn2s3F/E5VLmc7vu/QL0jhMPcPg01Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDykH2p89hmhJKEl1xbeOQd9E7+PVRtaolbj4dfiw3P4EFBS0p
	zXvZ8bFbJIKf5eB26THkKlzavYw9dmHR2IMyBSHAsH7s7oIWT/1mfiDm
X-Gm-Gg: AZuq6aJz/mMfLvwm7+GPJUM0hwlCFCz18sNQItq6/loBJBmUD9BRrUPg0U9CHZkXz/x
	K33qLsub2bEmNoRAh9nK4XpXa8AMxJxWeCFaLEUXM569fztaV1bwc3aVHFw75KAHHUdyDPsdWiK
	bWSgpPRCjL0m0kJnmx/gdMuQf8AoPbNqOFAKZHZ1g6QOIDTrFXXXmntTDPEFCltqgt8ZEEodwNQ
	uP6UDqLpnieGbBJoApVSZC7If2+/n16S2/MVDtKuwAExM2GIqAbdlmcqr6QvImFijcp32lIE0hy
	YbjI23YUhmW1MY1jd76J0tQxBZtYuSkWVKwIm090JZpzghc262736Dl0OJoEcHvv/21w4wRtyPo
	KHmi9zygVvdxiPCNRNOCVbcwcw0+8Jovgm1WxTabXDhvTlo0qB/QWrIdPu2mq9F3Nf39+mMrL
X-Received: by 2002:a05:600c:3f14:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-483a95e2563mr81396575e9.22.1771770890606;
        Sun, 22 Feb 2026 06:34:50 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm12473187f8f.6.2026.02.22.06.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:34:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:34:48 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 04/17] bpf: Add struct bpf_tramp_node object
Message-ID: <aZsUCATlgtjVsK_b@krava>
References: <20260220100649.628307-5-jolsa@kernel.org>
 <eceabbf86e0765a807e9edad56c44f0abbc218c79fa6bfb97ba480f64ef2a53b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eceabbf86e0765a807e9edad56c44f0abbc218c79fa6bfb97ba480f64ef2a53b@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:58:00AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
> > +struct bpf_tramp_node {
> > +	struct bpf_link *link;
> > +	struct hlist_node tramp_hlist;
> > +	u64 cookie;
> > +};
> 
> During the RFC review, Andrii Nakryiko suggested that instead of
> co-locating a prog/link pointer in bpf_tramp_node, the JIT functions
> like invoke_bpf_prog() could accept the prog pointer as a separate
> argument, keeping bpf_tramp_node to just {tramp_hlist, cookie}:
> 
> https://lore.kernel.org/bpf/CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com/
> 
> The RFC had `struct bpf_prog *prog` in bpf_tramp_node and this v1
> changed it to `struct bpf_link *link`, which still co-locates the
> path to the program inside the node.  Was the refactoring to pass
> prog separately to invoke_bpf_prog() considered and ruled out, or
> is that planned for a follow-up?

yep, I ended up with different change and mentioned it in the cover letter,
I'm open to discus different solution if it's needed

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181
> 
> AI-authorship-score: low
> AI-authorship-explanation: Mechanical refactoring with lore history dating back to 2021, consistent with the author's known kernel development style and iterative review process.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Unaddressed RFC review comment from maintainer about struct design; not a code bug but a design concern about co-locating link pointer in bpf_tramp_node.

