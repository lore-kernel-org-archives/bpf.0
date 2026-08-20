Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B337FF54
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238838; cv=none; b=Rk0cJKf635/26T25L9jHzSvdQpGkRDnuy55v8+t978LAsb6AlltU1oD2kxepnsfe2JLbCcZEOj+jwBDV9xYlG/Nx/7RajpgLfg99/ONYSleZn3o1Tf3UkbflfXMcYfrnPLfwt4O57cF7cS4zIfE5X2BliSKwfaGoYempnB60K/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238838; c=relaxed/simple;
	bh=wZ9rIfQEs/Sn9EXINdWNfVzSfbAPdmtQbudKOaN6UUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZHPmsA8GuLfY9nxuoMMO9f6Vz6lVJXBC+YkGzNITs9flqFlWU3NfGtNSVInUjYjoPdX/pmcrWuIBSgFuYCt2XBQMfe5Q1mhg5qIctl9n/3yjKCfpqk7hhWPdCUDLgyZYz6/vaGmob4iVSUiooDD7LiXVuTwr82P5BSNQ0UyfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTjiODBp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTjiODBp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cace91f112so23451945ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238836; x=1787843636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zq9BJSJTpGqEsUbNd3lkB4fbjkZt4kP+da3LlRPZq+0=;
        b=XTjiODBp5cXHuVIW+w9KD6IHNACbIby57CvEbhlBEnrrsnpcz9kTUbHMIxXleqOB8S
         AcFUfegppAwPCGTQhdk4/22XqKSGBxDCDX+W5xhkxNlsXcJd00K18QBVoPOXtdYj04ya
         jEMeqyejTZ2sHjYPNoe+3gXr8fkWXOiVONjGuS0WKQ1INWEY2/ohzaFKAUldP5JGRzsg
         CXf5Nq28t7TVouqhObSOdcv1XA96gwMClmlf6omQhEjwar1/k9V/SF0MjzxChB6ei+KG
         mYgH8qHfUJlm3OoAXtbpQsb4wmGS0jpUSEEzybPVBPjm427Q90GhfJwNcv7ja+M9SHHS
         YKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238836; x=1787843636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq9BJSJTpGqEsUbNd3lkB4fbjkZt4kP+da3LlRPZq+0=;
        b=V35kM7MexFt3I+lUpZ9XFzftK5DvPpvxqnjRh8zs8jOfHsNmHVU6sL1niFarkechI8
         Za/lSnPy+UFTUM47amPV1z2tanF+eTyOw1QoqObJ2gX3HKnMHCnJ9phqWgWKt0mbDqJ3
         eH8ASl+cUi3QF7TaVvvwfdsOlJUODmh26XAO1/khadYzARYn9jhI3SfQfuCmDZANtN5d
         SaKJDbHoJdU9tuHQB3b524edpotAAsXrlTwMn7NowIKRFM34yNMaALD12MaVk1uyTANW
         o5BWtk/JHpbtPyq4Xi9kd1Sk1DvnXN7isvZljY40OvHh6Si5ixQaxDsO4SSG9whxXgNZ
         MQIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBwa8VW1jhOY1rI3qBLL5Hc3rHuwnL+qBquI0ZKSdOBauimvjh2IFHtQmsZ4bB/8+vcmE=@vger.kernel.org
X-Gm-Message-State: AFuF++nJBrtOz9Qc97pLxQF4+VknRNiEnhY9R4/SW8FaVjDPm50MaDQ4
	gVrz8NfvAy2x4CfWb2M3Nc1NSA7GQtm/hhbdUDZaEd/i0Vh/FaK6eqGJ
X-Gm-Gg: AR+sD12uV97F5boqBcsWqEg7WdqaNuYu8kkakbAYiSrkCSNDCa+UpW8ABV42PXuMs72
	mL164cWFjl0yLl8mNcmibXeRWXNFsuh0ZHOF4X1Xg26HpXsgGd/aoO4JUzoesuq2FyKuEP85Jxt
	SrZlpGVNEYBOJFDUaBBQUARv+9oCpptdD67ooYDWC9mOsnc/afzINpmJsrSgGTMwO3T7qYXdAQv
	ttKZR1YChlqnR3wfGa1zguSsxi1HiMKY1h+TI445Yd5dFMSL1OhpoXgeuKIY6NYGgSs9d2gnnKQ
	7rOlyZvK0616rl4t5VpwSjWl13qhILIPiQ2ZWpI4wYXcLWVJ6SnWX66tauRSffU+bqFv59CTzR8
	ryEZ89o4O0PUv5erEVKmBrXgfyXbR+oXZEpZ2+w5smReKZEn1wjavHJFnZB0WO4B47zPMVS4pY/
	y1YnEp8DKAfPYhXAENNY8H8UPadznl7CRwzsb/7Vv8fE0wnXtNoYDWGKg=
X-Received: by 2002:a17:902:d2d0:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d601985763mr206602935ad.14.1787238836124;
        Thu, 20 Aug 2026 08:13:56 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3c1924sm8448605ad.67.2026.08.20.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:13:55 -0700 (PDT)
Date: Fri, 21 Aug 2026 00:13:48 +0900
From: Junseo Lim <zirajs7@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	Sechang Lim <rhkrqnwk98@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf v2] bpf: keep trampoline progs alive until image
 release
Message-ID: <aocYr198Tjeb_7Mh@omen-arch>
References: <20260820022831.18601-1-zirajs7@gmail.com>
 <14c836d6-8919-40f8-8559-bd6048c14316@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c836d6-8919-40f8-8559-bd6048c14316@linux.dev>

On Thu, Aug 20, 2026 at 05:26:18PM +0800, Leon Hwang wrote:
> 
> There was an existing fix [1]. Could you take a look at that fix?
> 
> [1]
> https://lore.kernel.org/bpf/20260819122252.1782790-1-florent.revest@linux.dev/
> 

Thanks for the pointer. This appears to be the same issue as my v1. I took
a look at Florent's patch, and I think its flexible-array approach is cleaner,
so I'm fine with that version going forward.

Thanks,
Junseo
