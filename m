Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924625B0BB
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792594; cv=none; b=ad5x7eLxgQ+POzxWfSTOK5MC2hmlZpAWT3jA0cJk4mMk1nGo6n/WSFsbSGsytVxONDEH7uZm4T3YSkEpa26M71DPOJSDYbTKNR50fhmxNeqD4F89yo7JMnviPD33QnRUWr1omYxeDrk9UCipkYLBneIug8fxvCzfDEnxH8viOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792594; c=relaxed/simple;
	bh=+UC/J4mZseLVnfTpUsrfN/3BZoQIqc6JgckMkIR6xKo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su/Nu+CsOXP8cxLLuVokvUXm9zBeAXJo7gAluQ/ugF4pPiLhIZdSfL02awLB103jRCKYiD6gLN6Jjp1ShKo9i0L3rX77z6pKGAEWMhPsQ3YJ3GK9i5kq5hdD7DtxQoNvo4WPVnNkgRtbCm/i8ckFg7EUJIJjhNfCo23E9NUcQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf0y4Eg1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf0y4Eg1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so12926755e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792592; x=1792397392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gkz/+OmzCSw+HJ2jcYbrpzh6qk68rQXutqqHMWV6Ok=;
        b=Bf0y4Eg1mGQFuKlgWlOYP7Ds9w87tUWrm/a6sk6KPEaJacn6z5RiupgJGRawiMTUDq
         Xv5H0YImvRGccTl12j2FAmDPJQjAzr6LkNiAVdY8IdEdc/IivDGqhmFBlf1UQOuRwe5y
         PB/tEZMZW79Kxp3egi7TQIAQiiP6LZjRY5QNCamObW0ErnwqJdXdoK//Vud8hkd1rb6D
         diYZOq7t6iATvuy5jiGGuACjLxkm0LEdVa+C/jtyVzOugkrQAh7vou6sPf88ocBqdyAL
         ZjpCWfWEtdIFK9mm7MVcxzMcxsdRb7ILKNMxyip+SL3q/YZBeOl2p3Yr++VzGHAKpsrm
         nJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792592; x=1792397392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gkz/+OmzCSw+HJ2jcYbrpzh6qk68rQXutqqHMWV6Ok=;
        b=OHX/lWW21u30PinMxoLSgo7DjFrPylZFwLKifc0ONTpkDYPiINpa1y3dzip2L4DzVy
         9yShqFIwODZSrZGcXLNO1ShQvLDe/3FrAcCdFGoX9O0oVYNcYXaDPF3VFLYu8gFnVh2x
         l+Lp3n5yO362TVQjoIjo+lnuT1y6liiPwDOKPKsCp0w0AzQGIGO0gRFgtwewOrzEluFt
         vtKjZDqxqXwYgMzJ4Gu/ztf1icycR6WmpTDwwj7FThWK/IMbsfRs34c2qNA6ULIwbpkz
         wfYfrYAPY3xusHAD5tSKjGF/joskiix1Zw9yCm5wuDgkTCJjOOgsSadXggqAw7IFTV6w
         9cSg==
X-Gm-Message-State: AFq9FYKd6RkXqyIbRtdN/pRH7VFJV8ADz+1PeSXQ7FAR4KxO04tgyl2X
	UjoNCljp/x9PtVMWu/Y+B+P/wpfJfwbemfLUglovK06wBOfgeEhF6Urt
X-Gm-Gg: AYBFou3qaHG8b446+10MwuqVUovyc2BJlmJF8EAXrAgVy3BpjQICISvOt2MP3A0QbCz
	Ti9La2f5kylSIOzzn0yGyXN7EaYSOoHNQ3q1lqZdbvYUy4mZ0oR2LiKHdo+lg83igVBoj97C10t
	CdQlVcqo3eHNkpABBD5nmJ4/R64T+o9bTLO2B/Np0gflVHqkSx79v4/Y0DgVeK1Jq3npjYy5FpF
	qQVILALOO1liQFG+Qzc4oyP/HvaRo2hz7MtHDE78MCIV529+sgSXyW6C6T983AOWbdmNP+Z9+/O
	F+74qy/0zQF3ZI7aamQhGCvwGWp/MOXLKUVHCXNFwL+pLYsoggfQ/qYeRYPbf472N/AabwzHtll
	MTgAghvOD4h6oS1FX5Np3q2caTqFxm5WZiLjStoA2UHVI7EGYrbcW7RsMJVrPEQKhb8tMY4OTvY
	b9a5yhHQDPtu25SpYAJKLqdL/ez/HF764dAr9k9weU3QWb
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr149973745e9.8.1791792591441;
        Mon, 12 Oct 2026 01:09:51 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9463230sm19742343f8f.1.2026.10.12.01.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:09:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Oct 2026 10:09:48 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next 0/2] bpf: Reject BTF ids with the same address
 in tracing_multi link
Message-ID: <asyVzPrdjWi0uYeI@krava>
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>

On Sun, Oct 11, 2026 at 04:48:34PM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> tracing_multi link accepts different BTF ids that resolve to the same
> address. The attach succeeds, the detach fails in ftrace and the kernel
> crashes in freed trampoline images.
> 'test_progs -t tracing_multi' hits it when the kernel is built with
> CONFIG_DEBUG_INFO_BTF_INLINE. Without it the ids of aliased functions do
> the same.
> 
> Patch 1 - the fix.
> Patch 2 - selftest.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

nice, fwiw:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> Alexei Starovoitov (2):
>   bpf: Reject BTF ids with the same address in tracing_multi link
>   selftests/bpf: Test tracing_multi link with BTF ids of the same
>     address
> 
>  include/linux/ftrace.h                        |  1 +
>  kernel/bpf/trampoline.c                       |  8 ++
>  kernel/trace/trace.h                          |  3 -
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 99 +++++++++++++++++++
>  4 files changed, 108 insertions(+), 3 deletions(-)
> 
> -- 
> 2.55.0
> 
> 
