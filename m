Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A25944F
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659126; cv=none; b=hw+WZwwR77oQ5XCkPeR4CzLzTEgz6jCbnNa9fE5YJk/+73C0kI3XDmk9NKiMHKKnfEz3Sdgc+0I4SsUDLKnQf8gA82/adp/Qlqqd2/JCEd/CQzv9ZP0685mdd+TkmF4fJYtvfyA+gSUTqYG+IC0tDGcsBMR8RryXw9D7mY26r6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659126; c=relaxed/simple;
	bh=qegcaTYASJXxjZduhlajq69TlD7l//GSAOQqcdWON48=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmQF/hIbpZMVXQ22Hbp5wvAHQICcrl/k/GUg/hWqnhe8iWAg7Q3HPeok5n1aQohFpRiiHqHJm9RHdFkDLVTxxf6eo3zh0fGP6BK/gA5jhJBomY+arkhCGEvEawm62idGVbTRtVLbWfOqfqBuTAXUIGvSU8rzEMk6jg4HPAFMb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC69E9ZP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC69E9ZP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412dda84216so23024725e9.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709659123; x=1710263923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppv+ubCeK0oIOoJRu/fPYMKHFFHnbHon905gHBRskxw=;
        b=gC69E9ZPug1MXYzHvYpjaYrHH4mnq8MSsDN6Vj1va684s5Ec5H4Zg2Jr+/ry4MpaOz
         jtTnmucztLQcFf1QDPpUHoZ35925rW+F84mRZoPpTCA0Z4aYWcZFk9bFFJMkhhbUxVSu
         acFvbYXUti6Kf1fzWIK0ukO5UELIXU2sgYK7k/PR7xgq/fvQ5UdlJgru2gYkFdqCY6mq
         s2aBLkd9f6QDMrQ+z4doce7iZD6BYpeGHxd4jtc435J0u6GCxPGdUGA6mdmk486RgErg
         ngtijkBuDPPH/xHhNqs4DcXp2G8hWruCSrOFDolwtPGT2zrv+ST8zR6Hj+fv4PkZ3Z1f
         fsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659123; x=1710263923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppv+ubCeK0oIOoJRu/fPYMKHFFHnbHon905gHBRskxw=;
        b=gZHdezUNYO+EzgA2+YVamCy/VyYxJe0KnrRpQ1gVvjz0np6UHkr2e6IFWfTnbCUHOD
         3Hp2U2BJ4/LiGlQR68BTwTTg6iocSvmvZnpI/l7OgmVB+3dRo5sx6va7EEYQqAxzaPS9
         EhVwLzR/vGTDYrhParxNAwWDbsoTxhGFYNq7JXzJHWucfgnkpTBhFuW7OKQqq3+DEWJx
         TX31xTi5G8L+Mrt0d9EC8phq57aYWACjNSRGUQ5T04nho2sIxIw/CvYS+BTKRVGc2GIf
         6LzkdEaBT86T6hRclzXJxOsLv2NKBzRVuGJ8lH8+1vtQV7iicm3+GRPHuEIPa+85+M4k
         /+ug==
X-Forwarded-Encrypted: i=1; AJvYcCUG1UT/mLc+WGGWiRcydFXLtVqo+guLZwR8YzlPWBoL1CkEK4vRKXhX9hnPoeQwats3UCUXe75i8HI3xEGCH8bQCn59
X-Gm-Message-State: AOJu0YyWp+4i1xWIiSZvV+duk8+vco0AfoXwbwO78xAkMTcD1zBnV1Sg
	DdIMgUSiT2hABHNln9j/fPvXs24pW0zcmdt+nMPkOsuQCNTwTLFo
X-Google-Smtp-Source: AGHT+IG5KgCPwEiRw3sQE6234hknMeCLfGz1cg4mbg6x13wWV0HTVO2Fl9MmbE6Qx6pKVxiJatYEgQ==
X-Received: by 2002:a05:600c:5121:b0:412:dc89:20bf with SMTP id o33-20020a05600c512100b00412dc8920bfmr5585519wms.31.1709659123343;
        Tue, 05 Mar 2024 09:18:43 -0800 (PST)
Received: from krava ([83.240.61.14])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b00412f016a151sm1092970wmq.9.2024.03.05.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:18:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Mar 2024 18:18:41 +0100
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <ZedT8S-GjNOry5LZ@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>

On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
> 
> 
> 
> On 2/29/24 06:39, Jiri Olsa wrote:
> > One of uprobe pain points is having slow execution that involves
> > two traps in worst case scenario or single trap if the original
> > instruction can be emulated. For return uprobes there's one extra
> > trap on top of that.
> > 
> > My current idea on how to make this faster is to follow the optimized
> > kprobes and replace the normal uprobe trap instruction with jump to
> > user space trampoline that:
> > 
> >    - executes syscall to call uprobe consumers callbacks
> >    - executes original instructions
> >    - jumps back to continue with the original code
> > 
> > There are of course corner cases where above will have trouble or
> > won't work completely, like:
> > 
> >    - executing original instructions in the trampoline is tricky wrt
> >      rip relative addressing
> > 
> >    - some instructions we can't move to trampoline at all
> > 
> >    - the uprobe address is on page boundary so the jump instruction to
> >      trampoline would span across 2 pages, hence the page replace won't
> >      be atomic, which might cause issues
> > 
> >    - ... ? many others I'm sure
> > 
> > Still with all the limitations I think we could be able to speed up
> > some amount of the uprobes, which seems worth doing.
> 
> Just a random idea related to this.
> Could we also run jit code of bpf programs in the user space to collect
> information instead of going back to the kernel every time?

sorry for late reply, do you mean like ubpf? the scope of this change
is to speed up the generic uprobe, ebpf is just one of the consumers

jirka


> These jit code should not be able to access helpers or kfuncs, but they
> still can collect and aggregate data, store data in bpf maps, and change
> behavior of user space programs.
> 
> > 
> > I'd like to have the discussion on the topic and get some agreement
> > or directions on how this should be done.
> > 
