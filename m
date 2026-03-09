Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A43ACEEC
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064125; cv=none; b=J685dzuwZuxHPFi1A3pDsuL3zcecbCtiifu9EDAsBeTfBoAtSZqqYKQazo8gK37xvw4NPaLWJLtOJyLYiSKIlFD2lvGPzjJaMSOJ8ZtbFGQed3zLNgmkKIz90WE+9FdPNGVfU/ulnBGW206PPRH1w1IePBOmLjWt+Ghx4pP7GEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064125; c=relaxed/simple;
	bh=HNqbIilc1SreZBFw3ha7FsIJ1bqCnco0lllRZkFOyHw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8x0WkE3EGVC+VI+eRH+QItRzGUHbaItUyOuJ0vbb6isIu4N9gGr512nJU+3dk2ep160MaQwdeFzL/yCr+7wK7OoEhEZJKvUUm6KE6FhjBa65RXneydlr7/gId6wjQXEYYiC/xqUqQCjcqfDvvecO7RUuwJmcUqCs5CFKMtgUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK9xYz87; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK9xYz87"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so135125505e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773064122; x=1773668922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HwbPRzrYRb3DSmMn3EZSpDSHTZpU4kRzz1hnRHszBWA=;
        b=PK9xYz875w0psGPkZrxMreQRAONntUP8+LtaDnU3dx4+IxEypHHxhA6Xzosaosste4
         r51vDQ2Kta0GkpeMdjtw2SkUtcuTPzNN6+YfuMFAJZ7saLG56Vg505I1LJhhBYiO329T
         uQK+3iVDepmIzYN+R2g1UulIbvk63wLYt4a0Q7/woBGgMnTEK9NzTwFkhmqclpbx9tEM
         9mcD4yQeX5gshsKX0BZ/9D7K7Cm2GM0t4v3KVNucomqamd+6JtQ1nuEhFhTvgBQdxr9e
         8coeMz7XeH7CoMLf48vfFMS7kugkixmxSU5H08J1FYbgE79X/o+20FT1U57riTUti7c/
         5PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773064122; x=1773668922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwbPRzrYRb3DSmMn3EZSpDSHTZpU4kRzz1hnRHszBWA=;
        b=Cq9/11y1f5IcMCORCx7zFYa1+1foLAQe6w7RhXCJlFPVZBSWPckWRTWZLoZlBu8Ku4
         3UsqLh/pBosLqcvRMih2B6WkY/WRABD8qbHQ/NR/spZUhXw1w0nB0ynAYoKR115zXPJZ
         yR+J+OayFeRWfL8Ta0croyDLTUZGIfHeHDpoiuc3gi5NBLqNs9bFN+hHSaimOEbcJYJ8
         Wz3Ai8HRRN4a+A8uBRdBSh9pHavlpZDi7GlMx5/xTEY9qbRt6qWCtNutixvaZ3FB+fYA
         FW0NMik8H97/wg886dK0CQ4kQOFi/4UnkA7m6jg1iKUZ34Ng2ob1AFj6b6a3uQb/0FG7
         QLhQ==
X-Gm-Message-State: AOJu0YyDOOG+cQTVJa2TMcN5nT1R7WZER8BnnPiq+gQf897Cn5kPwXFm
	GfzuAxdeJezc3ve3/6QIHaA6bjhmb0th3FdTMWxWqfHd1+cQVvUPltAn
X-Gm-Gg: ATEYQzzZ0fFNH2QwPYJypEtXdnxYiCD/jwJEARg7JRzv5BTc4juT961c9TSzV/qxXc6
	14Ig9Ht5fNIWsWqFMCYClEeMUh4EAJtNtugjBIWm3q7Nsq/ZrpHv0dC5kRdARZzEoo3B2uhHqI+
	ETk85ZPw6nClGdobpwZEmOilSb79ukpe1IdcfRrXXCFow8SE0jJzHBjISud71XB1XZa0OBVNNDq
	ItG/qyj0NX0FcgTxZnJD6RdrpB96M8jdczm7CgckqaGYkaOtL7M2vJnD2IbX3nJexKYGAyyp3RQ
	EDq3dMh+adhcJ1SwJHLYTOIR9vnrfxCTDUYaG54EQde28pZcGnZuNxY7lkDfpWk04Oz3o3Lqs1k
	qtLACGk9OVT/nqFXej3QPzdqjKsMItfu4haqk3UXW3YEGttB2jwU5BRZcvhHr1jUgkw2LNPjLxs
	bGnp905nTpABO5NIzHezohHbWt
X-Received: by 2002:a05:600c:8209:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-4853aa1a8a8mr64487045e9.7.1773064121724;
        Mon, 09 Mar 2026 06:48:41 -0700 (PDT)
Received: from krava ([2a00:102a:5007:2415:42f:f06b:ba32:35b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48531818b5asm85106915e9.3.2026.03.09.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:48:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Mar 2026 14:48:38 +0100
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/3] Always allow sleepable and fmod_ret
 programs on syscalls
Message-ID: <aa7PtlrkyHznFo-c@krava>
References: <cover.1773055375.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773055375.git.vmalik@redhat.com>

On Mon, Mar 09, 2026 at 12:23:55PM +0100, Viktor Malik wrote:
> Both sleepable and fmod_ret programs are only allowed on selected
> functions. For convenience, the error injection list was originally
> used.
> 
> When error injection is disabled, that list is empty and sleepable
> tracing programs, as well as fmod_ret programs, are effectively
> unavailable.
> 
> This patch series addresses the issue by at least enabling sleepable and
> fmod_ret programs on syscalls, if error injection is disabled. More
> details on why syscalls are used can be found in [1].
> 
> [1] https://lore.kernel.org/bpf/CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com/
> 
> Changes in v3:
> - Handle LoongArch (Leon)
> - Add Kumar's and Leon's acks

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Changes in v2:
> - Check "sys_" prefix instead of "sys" for powerpc syscalls (AI review)
> - Add link to the original discussion (Kumar)
> - Add explanation why arch syscall prefixes are hard-coded (Leon)
> 
> Viktor Malik (3):
>   bpf: Always allow sleepable programs on syscalls
>   bpf: Always allow fmod_ret programs on syscalls
>   selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
> 
>  kernel/bpf/verifier.c                         | 85 ++++++++++++++++---
>  .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
>  .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
>  3 files changed, 74 insertions(+), 17 deletions(-)
> 
> -- 
> 2.53.0
> 
