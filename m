Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15D4CF462
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792283978; cv=none; b=OgvXDmWDIgnp0RuOwox/al6EfRBSFpzS9gzAmLk8opaLNOavr+OMcznGhpEo0zSelCkAkuKVOOLfupLD8hl4+FkEi6xqm9+KyXnB0RgeFEziNXt91TZXcoA8HgIj7tm60HxkMSTaVVlZ8e2xwT+Rb0KUp83exyq1gjS1OkpuMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792283978; c=relaxed/simple;
	bh=17jvRmZBNnCl47JZ4PPW7VGtVpPr+tXsZAopNeXWy8g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=LBx2TnzBub4A9uFu748VGn5v+8wcH21+jpsrZZJPZipl70WR1Ax1n/JscWulFNqXOx6NUZroe5geqZgB8gVH7u2jvWkACsxW+j9nJH0tkoJ5jBcL6CRzBRmGGPIihMbRKevxqUk7oT2cqz6LcPGS/BndXT+I7jtlsIw/HfZAapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmo4Dn19; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmo4Dn19"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3c37877so645616a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792283976; x=1792888776; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=17jvRmZBNnCl47JZ4PPW7VGtVpPr+tXsZAopNeXWy8g=;
        b=Cmo4Dn19cytcEOaH2PSu9aPIrniI50UyM0l3T4WYI4uQBMNvvPI3CFHAAU4sgRtJBT
         yI5YG8XnAdAp9YYU40VD5k1J9N7SxZh9WkHXRfY9FmQ6lAlemIj+Gr9IDuHyqbGcI4g4
         dOz1PlM108kLuKMAnjByl4gJuG7fbO+ZK0YYScp5280SrcwZHJ8/VKLikRPTBHQ7UxKd
         aZyuUCPfRlJq2sJQpsHvxakZIVn26Ped0mCCssPvsygnUK2h7aGI/iqxcx17851qxlxU
         wrBnAD6LOP22dWwVPm/biXexSkablRTbajb+MFAYLpkp0JKOZFVPI3gGcqfPm1L80wL8
         Y8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792283976; x=1792888776;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17jvRmZBNnCl47JZ4PPW7VGtVpPr+tXsZAopNeXWy8g=;
        b=wocRYFdxSnv2GTlhaA5UDgCB2845NLknh6rixF/Z0/7buwcvL/6EL7u5Jk17g7p5xa
         ivU2mcTXiMOB8nLfAX4O2GmDnhaKtt20BXBMVr3cX6q6KgA3+lBHr9/X5drG3MKRIf5h
         JHdOiadI1PFfHRdLLfnFyZRNYHA9FbaRPnOcKi2rHhRq5YUVVyNdU/2dAfAP+dZBpbXn
         y529H0R2nFqfnfuMWJ8XT2FgbQ6K77bxrzeJ5Hpu1j2udOVTiLa+qj4rqkmaBV3iVQ9m
         c/mxYMjrB585Nm+KOxZ20N5NNEf34mV8MNYxLNukxxXUA/BS1d1BgZt+5DvHBBpsuvsL
         /GhA==
X-Forwarded-Encrypted: i=1; AKwUvBzkZhM3tQz0IPZc7T2x5k/MrFY8KJYzdCs6EHZubysvk/GOta9HpESNWazrXLprjyJcO5Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFIWzDRsp4FUCWismgWehqYCmYSmEyywKgry3kZ8HG7nocNkbj
	N+D7vwKk99ABTLJdMyM8fjEVz1ChwoNYrfGKiWsMFKtwvtfFZwZtwiw9
X-Gm-Gg: AYBFou1oEY2jqdrtQKn7K42jkpmicGtUJDI38xDtkqs8yt/Esw4ikEhfCY+KtjcL8PX
	QDZSdzuIkAHUx2l/LznPDbNoQToHy7LgKIObhtjRpPsJUMxU+9olZSS7R/XXmJx6QMnazMomlu0
	8yIOPFGcskpvxSvzJYhrxirmnQ5p/LYq3OXL4dEaT78WAM3C2t5Xo8xqPdMy8983XPNrJT/ktfV
	eArI8bUWhEZZ/oOx1irj2jqqjj4A06uQdJfWZy6mZKfojE4TcjITBAy32P+LF90V248VLRT5Iyq
	t9thAxc9KAKNtJJHiUhH3TVzo8NaZk6rLfkl+qei4Swfp3ipsr9E8yF8i54kCKA/WjOJ0q76jBf
	PpuaY41b6jG9iTuNZphSbHbOaeV+rxGGUJKoiOnKEYGqqE+4JmFvfys+mHp1k5t5EAJfqPaXROn
	YSuyHTgWW1LplZY5fGNAqqXxJG0uuilV80J+WJIp1kLzqunmXzJVPc/sNR5DXfAAV6aTXlGYAMf
	iqxuzsWF4NF4LFY7F5eT0u71Cz6ZOwmDKXPwia71PxgLw4n75lS4hYL23/wKU24LX3ZxcBxVS2S
	yZk=
X-Received: by 2002:a17:90b:1cc5:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3aceefc6164mr3175867a91.13.1792283976186;
        Sat, 17 Oct 2026 17:39:36 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm14753771a91.8.2026.10.17.17.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 17:39:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 00:39:35 +0000
Message-Id: <DM7JN7JVMJFG.18LKSE7N5TVFR@gmail.com>
Cc: <andrii@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <josef@toxicpanda.com>, <mason@kernel.org>,
 <memxor@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 26/43] bpf: Don't take an extension for an
 iterator program
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tyrone Wu" <tkwu@pm.me>
In-Reply-To: <20261017220550.1661-1-tkwu@pm.me>
References: <20261017220550.1661-1-tkwu@pm.me>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 03:06 PM Tyrone Wu <tkwu@pm.me> wrote:
> Hi, I originally reported this issue a few weeks ago

Sorry, I missed that report. Both issues in there are real.

> I'm hoping for EXT to still support ITER progs for my
> usecase, so rejecting all extensions seems extreme.

It never worked though. As you found the load fails unless the func
is named bpf_iter_<target>, and then it's taken for the function of
that target. The patch only closes that hole.

> Could `bpf_iter_prog_supported()` instead have the `tinfo` search loop be
> applied on the `prog->aux->dst_prog`/`tgt_prog`, and
> `bpf_prog_ctx_arg_info_init` on the original `prog`?

That's a start, but not enough.
bpf_iter_get_func_proto() goes by attach_btf_id as well.
The iter link checks max_rdonly_access and max_rdwr_access of the iter prog
against the map. The extension has its own and nobody looks at them.

At the end it's a feature, not a fix.
Send a patch and please explain the use case.
