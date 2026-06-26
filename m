Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBF36EA8F
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518277; cv=none; b=OWW+IOOZyKbdwu9yDyG5SckFLQ4wA7c6E0eGqEk1qcVLBMvagy1d/vcN0WwoY+02xNeKwET3omwOo7NZ5BdX0qEQgWCopQAUNLOOPfzY99TrB5nlO8gC/WMZdscKL5m4CRSjE8jVY/EFxDUl4SriFuLWLe+6MRGUeHismNLhi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518277; c=relaxed/simple;
	bh=hFeplc/enNvnPb9Rl82/WYFsS4u5oShlnhKaQnQVE0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPelq0MkIOA4o0NMr6A4FkguDq2um5PUPyJ5kWqiyk9ACIo9/JhkhTj7BcJdyky6YICnKWTEfdvN83EIYeeYBQGdG7ehAWaE6qAblnVzftM7Yj7qNhTMYdrOddlzxL7JilU1XKh39O8gIxIdxwaIjHQJEw+Rl+0jOc/8WyBFxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tevjf60q; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tevjf60q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782518263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfrqvYoeP9nDaT7bHQJoiMGnbvBxNYoFZtpS5+qTyK4=;
	b=tevjf60qFDWZQySdc13/e/DZ4ENIqEzk8KEC3YSLU5+rUQg+f9+O7FmVf0r81PnqI7Dn43
	nfJ5EPZImEhPSNc8wCSIqR62Uy8zFVdVwCHXBQqrteQjqjB++9sjrhImE0ITLZgkvKsmYD
	uNer9yP0k1RFiCq3kAJDmmt/v+KO9iQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: ast@kernel.org,  daniel@iogearbox.net,  andrii@kernel.org,
  eddyz87@gmail.com,  memxor@gmail.com,  martin.lau@linux.dev,
  song@kernel.org,  yonghong.song@linux.dev,  jolsa@kernel.org,
  emil@etsalapatis.com,  corbet@lwn.net,  skhan@linuxfoundation.org,
  bpf@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/bpf: make it clear that kfuncs should be
 non-static
In-Reply-To: <20260626172026.7327-1-jp.kobryn@linux.dev> (JP Kobryn's message
	of "Fri, 26 Jun 2026 10:20:26 -0700")
References: <20260626172026.7327-1-jp.kobryn@linux.dev>
Date: Fri, 26 Jun 2026 16:57:35 -0700
Message-ID: <87y0g0dfdc.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

JP Kobryn <jp.kobryn@linux.dev> writes:

> The kfunc documentation mentions how the macro __bpf_kfunc prevents
> inlining for static functions. This makes it sound like static kfuncs are
> acceptable. Although static kfuncs may happen to work, it is by chance that
> the compiler chose not to rename these functions and BTF resolution still
> succeeds.
>
> Make it clear in the documentation why kfuncs should not be declared
> static. First, remove wording that makes it sound like static is ok. Then
> point out the external naming needed for BTF resolution. Finally point out
> that sparse may warn on unreferenced kfuncs and that this warning can be
> ignored.
>
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> ---
>  Documentation/bpf/kfuncs.rst | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 4c814ff6061e..1dbaff8d4805 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -276,19 +276,26 @@ This set encodes the BTF ID of each kfunc listed above, and encodes the flags
>  along with it. Ofcourse, it is also allowed to specify no flags.
>  
>  kfunc definitions should also always be annotated with the ``__bpf_kfunc``
> -macro. This prevents issues such as the compiler inlining the kfunc if it's a
> -static kernel function, or the function being elided in an LTO build as it's
> -not used in the rest of the kernel. Developers should not manually add
> -annotations to their kfunc to prevent these issues. If an annotation is
> -required to prevent such an issue with your kfunc, it is a bug and should be
> -added to the definition of the macro so that other kfuncs are similarly
> -protected. An example is given below::
> +macro. This prevents issues such as the compiler inlining the kfunc, or the
> +function being elided in an LTO build as it's not used in the rest of the
> +kernel. Developers should not manually add annotations to their kfunc to prevent
> +these issues. If an annotation is required to prevent such an issue with your
> +kfunc, it is a bug and should be added to the definition of the macro so that
> +other kfuncs are similarly protected. An example is given below::
>  
>          __bpf_kfunc struct task_struct *bpf_get_task_pid(s32 pid)
>          {
>          ...
>          }
>  
> +Note that kfuncs must not be declared ``static``. A kfunc can be called from a
> +BPF program ``*.c`` file outside the compilation unit that defines it, so its
> +externally visible name must remain available for BTF ID lookup. ``static``
> +linkage allows the compiler to rename the function, which can break this
> +BTF-based kfunc resolution. Further note that sparse may warn that an otherwise
> +unreferenced kfunc should be static. Such warnings should be ignored for kfunc
> +definitions.
> +
>  2.5.1 KF_ACQUIRE flag
>  ---------------------

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks
