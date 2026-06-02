Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F72EAD1B
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382569; cv=none; b=E9GafBaLiyX4kKMDzC60KsRlxt73RblzdYnUQv8Je1Z+eZeqi7ugQ4fvxYR+1/Pp1bPWtuVjcfppXLiRENe96AuhYumEVaHlrXO4yzn9pVOptDXhhdZ5cYCREqhhDNmAQKs/OaQX9v3kDBssEnr4WRw5P55mcchzOpdyGW/wctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382569; c=relaxed/simple;
	bh=qE///xx7EQlY0uI+1+xH8GZBQ0wprBOgoD0QacK7mPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHoN0K4yxxspOdA0gGFioT5ysHZ2u+taGRTngA4Femvfgl1kKLsuUCwWi8VkFWiw6yAtECVdERv5NfrsAgxi/p1At5EhreOUFffKQJC+8NTGFJxTtTKKsrVAYQjOCpfNIG0spWeWe90WE0m/K9u9juFazpar+nYy7GJ2w7hxrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5c3jx1K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5c3jx1K"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eeba68948so3676110f8f.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780382566; x=1780987366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2N/m1TM4Ju0vSdiUK1Hy2gxsTSd/KSb52qvXdhc7mG0=;
        b=E5c3jx1KDznGM/xQCCeuWsjY4ltjgWWwMQMR6WqY4ouqMxfYDFjIBa1nhXEhsWdeZD
         9WsOws/fVK+/V+oj/2ix/11XjFR2rwCoTikBDid1RTcHiPH8h5cAS2ZMJ41sE4QCLNiL
         RlueKdatJ9Qyz6Cz1xDSX4ATUq2KVPoj/Irc2ImVRNhqg9hzYk8Vl5zHbzDy3yREG+sL
         f2S898wQ7xO4IffaDH7yDS/wyEpldPJ2Hapy8wF8kza/rdPzraY1e8HUZKvBMjgd1C6l
         UHC0Ak3EDVz9mvvSxCKSecG6cBF43WhUSZuPMylTXTBO7Qiqtu/EyRjRyrmCcVvxuaNh
         ePEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780382566; x=1780987366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N/m1TM4Ju0vSdiUK1Hy2gxsTSd/KSb52qvXdhc7mG0=;
        b=X624UpT+QayxFxPlEJ0+/4RbxxQ3VIw5rhWYMpVXM9lZirEY2dx6nl5l/8EUhvVHbF
         MYhCrPEB4xEszaonPWB0wGeoJq2Xx99mZfmDQr+urIjxFlQgm3dfFskaIA8b7UI0w4sm
         eeCTrL+JL5XMgL7b9O4rxtC7s5wxkCSnt00bxRq+G4gIffSKqzAUzFvz3dHWCegLBf3T
         XCgGk5vhkOn1ViljkXmTlGlqcPY/LX90cKvOgj5jwZUiz7OScVqTWTffsMOchFySZt52
         43+X/SesglW4DMAayVlactx0DO1TsrDgYvcpUbwNv1OctWx7Q2ocL+mjC5/K+NUZt9g0
         06tg==
X-Forwarded-Encrypted: i=1; AFNElJ+6BK+6FmFpZmM9djX/VhulK8vK/gv8M/CQMBVOzsTeN7PsjAVUAxJj2UDuzAc5hNLh7Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfk87ClZIrqVHltV2wL5TLRboIB/FM2QHUBrMoA+2RIS88hp0q
	ie9wQnzJsivdxroJuXGI8HnRiDVWHIP4562RknX8Q2Pqkp6JqaVNIAWs/rZabdUgFlo=
X-Gm-Gg: Acq92OFBJj9bjwjyUNnLQCvJkoXYTqtik+QIJ0pteqQgLYFoFL+DTFhRslZIHqkHFJ/
	794D/SU/bzZlZIpU2RMpf3ZzEtsComRIBc8ohg0nqPfnIdqsk8UcWb2z+amxzzlrPQpCPpD7cT0
	GGmSdskEtwXEhnnhxqPKriUOJuHC7Zf6KNBSJVDM5Iu9iz4rmCIURlNyLtRxtkT6gYxaiK/wG/z
	j0Z8t5bt2zoZJdJb0R7Mn2C0GnYT6CaAML6pBkH3FvQLtgaNlK6kJ6Lrr7VYMPUR1QI8oaJRrZq
	I6IPwdV1DVFmQTwtH23TNEWW5bEVKh2cHcw1cJqSFi9YEcL+Vj9kqNAt+yVOemGi35Z33tfjmGA
	hn59fDIiTEBdFYPe0tF9eEQXuktvdabF5gbqJksQRA1c+lus+SLk2FC7Vw0aaoyaPT30i+pooze
	QaMd1RFFQoN78R4qE7xFZhv75tQozOAN1q9kkgKpFDLpgwd12AO7Dgc8jVKdtH905Y7Vckcrxx8
	Fd7
X-Received: by 2002:a05:600c:a55:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490b0717e7dmr51100485e9.32.1780382566124;
        Mon, 01 Jun 2026 23:42:46 -0700 (PDT)
Received: from u94a (218-164-49-131.dynamic-ip.hinet.net. [218.164.49.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fdf0asm121897245ad.26.2026.06.01.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:42:45 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:42:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah56iBM2P_9hF3_L@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5pf25fhVH9WuU-@u94a>

On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
...
> On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > Hi BPF maintainers,
> > 
> > This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> > The series is intended to fix a verifier state-pruning issue where an
> > impossible scalar path can be kept while the real success path is pruned.
> > 
> > This is a verifier scalar range-tracking issue, not a helper-specific
> > issue.
> > The visible failure is that the verifier can prune the real success
> > continuation, which should not be skipped, and keep only an impossible one.
> ...
> 
> This sounds somewhat similar to the issue fixed in "backport of iterator
> and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
> to test on the latest stable 6.6.y as well at see if you can reproduce
> the issue there?
...

My mistake, the reproducer you had doesn't use iterator or callback, so
probably not fixed in stable 6.6. I'll take a better look at this later
this week.

> 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
> 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
