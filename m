Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D338B7B3
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036976; cv=none; b=KD5gBJS5qpkr/tXBY0NJ21/geFUnS0MEd4zUY49wymx8Jae5CKdH4bW193/pQR6MsI2/aTWTyFNEeTII218scW1C7ztqA7EOdqiNaFJJxRmuFsHnDkLloqA/Xja1dBRBnnPyIhlsDJvUQ8bJlnlQEf3PMqT1rdUs5/ibmbsLABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036976; c=relaxed/simple;
	bh=7NIJ0t8CspDEoHRAVde7jFctl3LQjsTMjjuVuCQ2ypg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcmai3y2UO/r2qKQXlPEougSOitLcVqaff7ZLy3eUMkZc7ioLfhvGtDIJQRTWxj+1Ou+m7xbRA5LqKDNaQqXtnMY6NLzM0d7TDiwZKaWcr6sV4LowoERaTDtKmIuZ1T5ZBfS7Nd9vsKULZs6vYkIbVk27KwWkWgWSnZhR8+lvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpr2gjPX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpr2gjPX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2531577a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775036975; x=1775641775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjARW9JIhX4SbNwhoTMuKjmX49coYZ0R3wKOwFPfGPw=;
        b=qpr2gjPXvbYB+KNMlAScGMm7m5AlK9BJ1HFMk1k4LlxSxvvH759IfMeJMcnAuIYqYJ
         r83Kl5PMjmOtPkmDWAdWwEOP1zop24AdW/0w3w9HhTeF0Vh0gHAF7R9VSIIP3K5WAb8/
         aOr0bhlEfUYUsHrATaVXr0V3ewW5bMU1DM09u0RNQ6AdtIBAZDf4fRY9iMYxX8KbdJA1
         muCDce7HgWzDI9+a2q7xJ56Gf3WZ3I4TfmJzUQNksoRSqGNdyTr5jI/6TAp9LiOQSQFN
         iXttpzNz/BImqi6RZ590bkPZJooN00GT6kUuDkxRdOk6C8Ltsm2pea+lvQQaQ65e0rCg
         fNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775036975; x=1775641775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjARW9JIhX4SbNwhoTMuKjmX49coYZ0R3wKOwFPfGPw=;
        b=iqjx2m0bF5cNz9wxAknbH8zAGCLjvRWy5UgKTNZhuacnPJ41CJZEqrTRwoDBku82VB
         5RfYJ8M/LGJFm2CM+jMVvnrRTLnsDD7GfWDrGEATHxRePL7/e64v0CH2feiAuV0D6nXM
         ozBLGGOQNMc0t+jdkChHB8NIX5QL3yFiW0HJZ4ARpCVPj3PVhSHC5S4v0NTj1mL95C/9
         b3G9QYz2EfK9Th3j0i+6+4U3GDTn2lx6pGdkS8+PIg7jo/GwMO0amKWf1Sjs5D924+U1
         WAVXeM6WRIuU5mXST4EQkpVvDJ2KhAp5GUE6J0LaZjuLpE3+NgQ6+/+C6gXEHogq4wtz
         bKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhwGXdwt8PToS90bE9oLsHyM+gk81D6Ma9NheM4qnqTsgyrO6PLMtp1hC3j6lslRjTcYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZKyzbhUd61gVeqj7LwiUNgwKu5YJByrvtyhN20P0hcTq8h8I
	v/Qbrwqko3wYl6qi96Af+OK6Sd+xWnfYQEFuDW5zkprnGbyKk+D8prnX
X-Gm-Gg: ATEYQzw/5UjKo+BGz8PcpjRwiEzG/lkatWCVuYBp89AK2HDZIqqAr0g6lU+YXxD5zQx
	sb+dBGhsEK2/eAgKcR1dBAj6gns3rGFGlPmL+kISVoln46AXQ23qn1zQu/LBVUyUA3Sj1I7ArKp
	bCh6mixALA41jy0XqdN65S0hnuD847CgBffBiKqrfj9tkmK/o6b+PaHqeB3AH520OLFizENn/Cq
	xGYBtSeo9MFv8rZT1NVbZVv5MkcdaVKUC/FNjqm4yrJdo6ABUX+yNY6s030wAcvgls76jrYPpzm
	Cp/GNUNoQa38LYCajXtinM5SZnURyATACZOC7dUvL6ZXEHut0KVCc2sbIgsysW/fF5gGdTnfvVR
	mK3tMWUy5O060qzQ3mCKiX9YKd5BdPC8wLeHZ/YZRapNnYHAd4ac0h6zxSzH0w080hTGiN8vzoD
	njBzj0Mi47+vvHZNVFLh2yJ1cbw1eJPSqg1Ox9wPU+
X-Received: by 2002:a17:90b:2683:b0:35b:9aaf:21c2 with SMTP id 98e67ed59e1d1-35dc6eea97dmr2908338a91.13.1775036974890;
        Wed, 01 Apr 2026 02:49:34 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe93661fsm4563786a91.11.2026.04.01.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:49:34 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:19:23 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev, 
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, eddyz87@gmail.com, martin.lau@linux.dev, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, leon.hwang@linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK
 feature probe.
Message-ID: <aczpO1G4sS5ecIDE@computer>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-3-varunrmallya@gmail.com>
 <acqOPsDCKHIrH1HT@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqOPsDCKHIrH1HT@krava>

On Mon, Mar 30, 2026 at 04:52:46PM +0200, Jiri Olsa wrote:
> > +
> > +	/* attaching to a valid symbol should succeed */
> > +	link_opts.kprobe_multi.syms = &sym;
> > +	link_opts.kprobe_multi.cnt = 1;
> 
> maybe we could set cnt > MAX_KPROBE_MULTI_CNT and check if the fail
> is E2BIG ? this could save some cycles, but haven't tried that
> 
> jirka
>
Thanks for the suggestion!
I tested this out on an older kernel (<5.8) to see if it fails with a different error
code and it did. On newer kernels it always fails with -E2BIG.
Implemented this in my latest version (which I will send out in a while).

> > +	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_KPROBE_MULTI, &link_opts);
> > +	err = -errno;
> > +	if (link_fd >= 0)
> > +		close(link_fd);
> > +	close(prog_fd);
> > +	/* if kprobe_multi is supported, link creation either succeeds or
> > +	 * fails with something other than -EINVAL due to permissions,
> > +	 */
> > +	return link_fd >= 0 || (err != -EINVAL);
> > +}
> > +
> 
> SNIP
