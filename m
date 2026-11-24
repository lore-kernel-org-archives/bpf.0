Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795480138;
	b=Yu/1wJFla/Qszk56DFAIpJUzc+TohAqQ6LQF+RDzHaJvNQUmDT+ulqr1nTHjYMN6uosS
	 s5cZYDR2RdSplsRiigCG6VXDgm+wZXUqIJGP5SQHTxxEa1a2E93/eYNnPq7nXhaKn1DaG
	 9TExZEPvOl8SnR6wlcwUwXrfdZ6BXQgQlDVlOmMmpWBLixIjfOpzJ6FcpIHcrY0Xg2bPx
	 bRwMxjXIKQsgAX6R65ZjujvlgSDSC9UMsw/Seq9zkfQAce+nUX2kJu5vz6LbxMa7UIVTX
	 b07vRFR96zbOzPoTSNVDoHkkXqNZ+/XuQxC2v+D0nCeY7eDIyik1nB0AaqyL/mamGnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oLCx/q9pu3FSzaNem4RxhMxAkKgztUbWuB3sZpOVezk=;
	b=TyBgl1nn8g2J1nvO66r3m9rIXGwcESH9yubiz5DNNQQQMtnlce4GJcpCuNMNhGkRoAPe
	 3RUMPqKCZzX/9LiokGP8/BRRcFwcIXMTFdWRqSEm3T9vHFavOYMSx7oPcdzIQeon0/rub
	 Hc3xXl043WhrJARG/g8HU0FMh4G7g4CVKXATV1Tl6xUtEnLjDEco/CcKL95fTi16FJTRZ
	 S5kcBwWaWYeVmcIxdzXa4kA8OZFNxgvVHCepQhWYNnPB6MT0FlQn8tXyRFumIN9u0aAnU
	 2l6YIgfMDhh7FnsM3si90jVJGPNV1j1AZ8Q+fghSFI5HeWmys89l7bCVX8ACn8ViWNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCsa6pMD;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C6606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 612C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCsa6pMD
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a594d313a3so2637435b3a.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795480138; x=1796084938; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLCx/q9pu3FSzaNem4RxhMxAkKgztUbWuB3sZpOVezk=;
        b=LCsa6pMDNFdHNUgFLCa5jMM3nOxtZr3bqxFnnl+R71RLdsqjNfYWpwYzfyLgLq5bVi
         mhezJo6w8p0kDIDF9upVMAEodq4l+yPJ7AdwSMg/1+UytBE5jYGEb2Gh+I/iABa3J61Z
         j30nbsFKfIXdHqhY4QvGrW/x2fTGF45cnYH4DYfvz/yzWOCoBGUmmHZFU+dyrK9RTCxo
         xPwTcQJ2smsbGPhP33TG2QPfSoPkkWKDSBXxmJDwPYpdO3WGlhEo0B9BcrEEzvXLwIPw
         BZ+s/bYjWmAGNsIshtQGDlY4bbHL4+Lp1QSuQX6T5m/MXlNkccq8ZTrBaZTmiy9FnZDp
         haMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795480138; x=1796084938;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLCx/q9pu3FSzaNem4RxhMxAkKgztUbWuB3sZpOVezk=;
        b=IUaX0u5+E23ldX3AD8YiQqbaN+Kwz2dGI2SBb4xS2mKxyTsxc/lNPX5IAgDzoF0bpL
         Qx2f4CD0p2otNniDhCPIPCILvnuazJYoonbPX18QtkpMqXJfUlvKh8p4l2EnHy8yH1fi
         U6MmS1fUnPt0EFQSr7Y0JxjW7znTwivpIk6OOcnL/4OoD8I0rjese9OgrBFaEYdHqyak
         NENlh6x3OSEcA8Z1IpAFYzD0WRibqATxmHdfPEsJz0CgejpbzgqAnm4mCtjCUTX5jZBD
         07KzlKlekcec5hXlWwLKVheNcMLkchKw1PWP51sRJE0WovNWS+oi1trC2l3/8rjGJC5W
         oGdA==
X-Gm-Message-State: APuU4Z+Efo4QORuQwZQoECIUvh+L4dwkKtW+mW9lsOtNYKgCjh0MvMG0
	hNdTuYxSJepG4cEurssFhsDvYecToJOOcvm8GgbEsE8ZbtBbnGzxgvof
X-Gm-Gg: AZFdTZfkOlzp4dOO/53wQFjYDmk8mnrHrH8EKRenR3DBear+txcdj2snc/NktUmgOes
	xXGa1Kl8+vdFVwrDZA4libwUjFcDD/yfE6Px2Q9BWUGPmjf3OzQ8+v00D+6QjgAHgo2p30l6Cpg
	3fVTPqbaOohJ5LeKwYYmBW6tK6mFRfUQUFK4bvOAktbpAMSQ/fuQ5yVAYmFHMb4bxYQ49u/bC/u
	K2ObZEO0OZ1bqSj7EJFSDAlfbP4QWTMAZJEvaBcuPqNsIPEl48JA+ELWhyrsMfUWvr6jzG1eRZy
	VOAleRLfn/ieChaeMPKgmGfuFawf/zXDwdXCfrs3mljizT+qqspFhCSRpyNfaDsQbLUAyNu0NUO
	rGTky1lM+lSVyK4aBFLUS3hV/mNB3PAGDhC59Oxb3kV6CUinSq83du6ukN041tJxLJgo/wfl1aU
	DOooeuuQBQV6kw1Gxa2mx/XazRsAJbfJNMQVhQf7S+b/MgfMxkSyE9H0sM7ePyMu9Ujg4VTjnUf
	Y58PLBmMbF+Pe5pwzLMlSCYa7fK6AqTgHQxSzAj14VWHXfCO0ezfgj8LqSzJ9JjMZmptKdyBsPo
	MKSYCviwaCSOA7XkyLymFIwhA6QTtVPF1J77CpcNUYbSSaVWu2ZhfW8G3NrWZinyjUpCLimK0s/
	co+nh47fs/ZEYESmkD/RpwZuQ7G3fE0t9/g==
X-Received: by 2002:a05:6a00:4605:b0:880:fe7b:bc56 with SMTP id d2e1a72fcca58-8c87d32ad6fmr12749794b3a.50.1795480137448;
        Mon, 23 Nov 2026 16:28:57 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87334890csm6407283b3a.33.2026.11.23.16.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:28:56 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 00:28:56 +0000
Message-Id: <DN30L7T6638S.3GDFKZBDTI1CN@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Matt Bobrowski" <matt@bobrowski.net>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range()
 return void
In-Reply-To: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
References: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 19, 2026 at 08:28 PM Jose Fernandez (Anthropic) <jose.fernandez@linux.dev> wrote:
> and make the function return void, so resolve_btfids no longer tags
> it and no fmod_ret program can attach to it.

Applied, but that closes one function. By the rules in fmodret.c the verifier,
helpers and kfuncs get tags too. A skip is worse there:

  target                 error    after the skip
  ---------------------  -------  ----------------------------------------
  bpf_find_subprog()     -ENOENT  jit_subprogs(): func[-2]->bpf_func
  bpf_iter_task_new()    -EINVAL  no kit->pos = NULL. bpf_iter_task_next()
                                  derefs what the prog left on its stack
  bpf_dynptr_from_mem()  -EINVAL  no bpf_dynptr_set_null(). The prog picks
                                  dst->data for bpf_dynptr_write()

We cannot make them all void.
Should we teach resolve_btfid to filter out all code in kernel/bpf/verifier.o
and/or funcs with "bpf_" prefix? and/or funcs that take 'bpf_*' types ?
btf_*() looks ok to stay as fmodretable.

