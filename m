Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041A358D32
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080280; cv=none; b=cRp1JpSLgS5mVotYosSiHNKSjstu74CDPi249/IxEcg/ZukI/vHv745BeobakUMhA9YyJo+FgessxuPQASZfaqR5IaGuX11Gx4llfogSyzLLSZEZkgNNGrFU8wIqOZs0QFsXL2KEexwP23SlNJEjQDZvRucYeXR0g41rGQLn4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080280; c=relaxed/simple;
	bh=DNKI3SeCVbAWNfiehbspstRvodE6MgRI2cSszie5lXA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAQI5Ga1gkAOGVJrba4MUBba2FZ8ZuVGbR4/lRnW+MoK65IzT2HGL2xQ1swqePSv9XjSDP1rJm7i4hGh2ZadTZFzsGRSuS8ObdClT5p+AvNmTFYFSyjt6b0A2wx4tIr6fbeLI1pFV8g9fvG6XxRTfYDz7V7tnKzXyusG35CLM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngt9c6q3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngt9c6q3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4905529b933so69733275e9.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781080277; x=1781685077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEbnD3/XNv/9tQE895vM2cSQoRf1dBoy5thU9exe3hk=;
        b=Ngt9c6q3L8msVBQsEl8mt0VHp9XC7/Ysase0e00hVgYGVuKqXMLN+NpvzMIkbVreOz
         dN1kytGVcrNnDE0uj3bBnFl6ETEF5AeU+2PAb+ETdiz67Db8+LnJE3MWmrVWpow98GIm
         jOKVq1k1b3n2epG8+Al4lWBKpy7yPIXg7OlpEpnPo+xKupd6D+rrW2t2F5l8gjDBiOeJ
         PnqjBH7zNWd41HZrCRcGTmDzw4kqpLZlwk5zHMLBwiEc6QF66Yj05YD5APTENBxUYOv6
         8iqPzoD76Y7YvqKNsGTMuEGvRP2rYJCDG2Q1uyQ7uDUquD89T2v8BiL2oKNbTk/IXU2x
         1mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080277; x=1781685077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEbnD3/XNv/9tQE895vM2cSQoRf1dBoy5thU9exe3hk=;
        b=o+VTeTNDV/rNSbcgWuvgTn/w0MsxEfIio1pXVao/z3AxCyHxpNy5Fan4lrX73n+3PI
         lZ/ESzNsHCWsY5KMxH+v5EEIwYAnkc+vH9a7Dpr+4Vc7Q2MQ+Y4Qin0EExihy5ZLNyBI
         Yx+fN3FBtx2Mp5gRMM5bG6yEdBgUl/8bCNEj4YPk3vICygQsVpT3KZMRZx3I8bnrDZEW
         wTBeMwpstAmDGJgomX9Z1O6GymPjH7STRt1klJMgI/JhsgRI+3nrG2xK+GZQPr4gDgMj
         wKZQDUmaJk7umLVXDx0jBv0cWuxwxgsj5UiheynU2sMFyjd4KqyMGAOhKo3up54fB1rf
         AK7A==
X-Forwarded-Encrypted: i=1; AFNElJ9bmTOphbRVR3IKVuml0Z84p/vAer+2vaX/oipW4/ZKRneXwecculc685/hxYwSGokVRL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygDOBirv9vygRlH0AletpTqwhhtsPI1pFkU1+EVmXNA22uj1M6
	l1QDcFNNSjTVsuvxM+h4nuFlVoM4wKp612plPYnBcIfDgjSodZzaadTz
X-Gm-Gg: Acq92OEAmJT5yO5evqAWn0s2SdoDEnerrAd+Qr4YfCdUKmcNUPPFOi2Cb21L/IKydYf
	o8oq+f92E/zZfDMyNH0P5rEPU3bB+YBOgTBO8BBjVjTseL1mMDg3egeWKXvOGHoHiP5+UsUwE5P
	wJJ7pOtTaE+LxSy/SXKxgslUe/VEJOrVgq2or+V4plflQB4A1nCtnDF/dwxwWdgbmwnVvWZWY1b
	MPNFP7c4DEwyLdrVlQ0Ry8fKVpWYa4AxYBBHTBV8J0yG2DYNyF43fduAxGAvKMAvWr075mWwDIO
	fXDrjEbWX7RKRsuwadkEzOmDa9mqnlolCah3WHfBvFfpXTmK02EAgElGRoJ3XMwUH8qIlEvaDRl
	z2Hsdl3QWcb34L0RDbrpt/HBvsMWPE9Iwxz6CwIS16AZWnV9QKBMQ1aL5+H60etFCOGZjjuNmX/
	FlfSgYt4+KsSwiBI0mDzZvsQ==
X-Received: by 2002:a05:600c:8b70:b0:490:ae94:a7e6 with SMTP id 5b1f17b1804b1-490c25c20e0mr371947695e9.24.1781080277251;
        Wed, 10 Jun 2026 01:31:17 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm536994045e9.12.2026.06.10.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:31:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jun 2026 10:31:14 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
Message-ID: <aikg0kljumneVrkC@krava>
References: <20260609104244.588321-1-jolsa@kernel.org>
 <20260609104244.588321-3-jolsa@kernel.org>
 <DJ4Q7RSSY0IT.1IDOSQBEWUQ6I@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ4Q7RSSY0IT.1IDOSQBEWUQ6I@gmail.com>

On Tue, Jun 09, 2026 at 11:22:38AM -0700, Alexei Starovoitov wrote:
> On Tue Jun 9, 2026 at 3:42 AM PDT, Jiri Olsa wrote:
> >  	flags = attr->link_create.uprobe_multi.flags;
> > -	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> > +	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN|BPF_F_UPROBE_MULTI_PATH_FD))
> 
> In addition to what bots said, pls run checkpatch on above.
> It should complain of lack of ' '.

it complains only about a typo..

jirka


---
jolsa@krava:~/kernel$ ./scripts/checkpatch.pl 0002-bpf-Add-support-to-specify-uprobe_multi-target-via-f.patch 
WARNING: Possible repeated word: 'need'
#17: 
we need need to read the binary first to get probes offsets, so I'm

total: 0 errors, 1 warnings, 119 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0002-bpf-Add-support-to-specify-uprobe_multi-target-via-f.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
