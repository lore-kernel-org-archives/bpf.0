Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692243822A0
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918298; cv=none; b=sfvW8HQe2OdZPX4XqVNbcBcr125gUmvRikR+wFtgYf0Ys721F2ynRYueK3J3pVC+rKBty1T3N43uzAQC9rZTC8e6jt/BPGStHszsYcWxiDaesF7yTf+X3M6uXekwl73mU9cjWHxeeG5WY+++rqyEmUlPXpkVQBvqBVJ0Pkxuikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918298; c=relaxed/simple;
	bh=1Bf8hEc28hXPuMHfJ5X9+M/T8gNJcK2S392R/vHPZnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9/jh3PVX2E9ewJ3HNNuFFKsqmB8FiPNGEIUg6ED3dBkZZ4v/KmcF17I/Pjl763qarEVx2Ifbf0zjv2huhYid4k7Xrto++e4wkpq7zoPE+O8HyES57Sy5ZkrD9qfqQSPOHvZ3BgWICqbBg4xwSPl5rWUGq+vD9TEz+GFylGQgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INJG7fmQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INJG7fmQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so10673235e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773918296; x=1774523096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4c37mbwDiETLi9rFX7FTGZ50jj9ijci/rDw/K+jJUg=;
        b=INJG7fmQ9XcVQ1GNpOKE+8YTOoE1uHV/MwPQw6Vw9IXFp+cYna4CIlvtQfFrO/9YdQ
         YW3OCZYeeuE3Y/457yCYbLgKy/wc1k4LR42bIt0frPSzbJUo1E2Iv7ZdSDfDQnrBWWsx
         SJO0qtMjAyiDZMFLSpaKrV05HZpQtXCYdT8e8pVWasT1sXnxs+6cw7LmzvUWxUaSYJZm
         5vKuxsJJqEBobS12jL+lZvvvEhaVjbhS50SZI9LdypTtjQ8h7GXj23g6ZFdNpPMsRGG4
         1F9n25MeMRMbISV/zEz+9tHNBFxOoaZTeON7Sf6PE1YJK7trMmdM7DRxgZLZewtI/Pbf
         ioeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918296; x=1774523096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4c37mbwDiETLi9rFX7FTGZ50jj9ijci/rDw/K+jJUg=;
        b=grSw47Liy6PqHAgxaoIS1Y63rhykamQOT0KT9zabHv2Q4axBatTfg0yUnw+jCXr6Bk
         4fYMY2EpPzW+KGzZ9M9e88zDbo648IzgzIulRERRyGCPtHrQvDry5+vvKIav/xSGVTAz
         QQaghm6wi19V1x4Dl7gCX96Nx9naWeY0bVs8U+0LDin/bMdjQF0w4dag55OlPSh25wz3
         NRWpILy6Z8GH2Ar30vQyvNCkHoW6iNaVdWLOuetw+PT2+3wGzAO/Nqd8YNXBn+LjI/+C
         ElU7UWcUjLapAqFTCUH3N/tt2rpw4N5H8le8jl7GEsteWDm9Wb+YifJ0n6/1P2nhBOos
         Y5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf8vVZMADPOcGNEaHvUrXcqUBa067QulIoYgA54qixneno/R8M7QHayvKeiok15CKtFrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNbJPoD6T3Olj8BpM8GFSbK5saa+qFziVJ3Fh8dlRpcyGsH2T
	d7sQWhwDuQSn7FjWK2wtLgLuZGylZdsTu2Xa/CwlYmaSkHW5XduJCMQa
X-Gm-Gg: ATEYQzwm4NDNizYTfAFDWTy0x8TK9W6KQXFRzjfCWYTF4b55sCMAPH7qNxjkWWCGiFs
	kIK/hNgV3y6amYNELhFrptStoT6P2DE3oaYV05ndTGkGs03S27IcTBvIUMdRbBKfoRM7G752eyF
	HnkggA9h5mdGCvl4JAOesB5DgVX61O6eLn7IHWM0qOt8Pwt+FrTGhNBKmswMpVYNYL17i8zPkFr
	lMtbZL5bwgRi1GCyFeCFFCjlZy7P/5pj+0BG8M6jHNMZ4Uq3tCW0yi8vh2bPK73xv5THPFAsEHD
	Mki+qYh3GBuiXw9feMj7I2V5ZCV07beKSJuVJW1l1MJn55L/McAyOTDRTxBj/SjVqXK1fWguocE
	EyU0cM4u5dcQllkKunPPc2rFPfeRp7yu3nCzc3mgO/ughcSwDCxeWOjHlAAYPLRxqsQjte4rkvr
	og/9XPS5XDgT95RB5FIaAJkfkGmDaG9eG/jwb/yW8Nv/xPdMl27NC0OiPUQsGbOKWcNaVxOy8vk
	kPCfutNeeDZ6ewk78cGWIRieHFPpuNB+7ba5dmDtgZcnH8cS66OAnnV6kftZJL3Rp6Xvu6mgg==
X-Received: by 2002:a05:600c:4685:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-486f456feb6mr116918225e9.30.1773918295491;
        Thu, 19 Mar 2026 04:04:55 -0700 (PDT)
Received: from mail.gmail.com (lfbn-ren-1-685-61.w81-53.abo.wanadoo.fr. [81.53.253.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb59678csm16217465e9.0.2026.03.19.04.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:04:54 -0700 (PDT)
Date: Thu, 19 Mar 2026 12:04:52 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	shuah@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
Message-ID: <abvYVE-CJcmRypCR@mail.gmail.com>
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
 <20260319040337.366375-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319040337.366375-1-sun.jian.kdev@gmail.com>

On Thu, Mar 19, 2026 at 12:03:37PM +0800, Sun Jian wrote:
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
> 
> It currently targets bpf_modify_return_test, which is also used by
> other selftests such as modify_return, get_func_ip_test, and
> get_func_args_test. When such tests run in parallel, they can contend
> for the same per-function trampoline quota and cause unexpected attach
> failures. This issue is currently masked by harness serialization.
> 
> Move trampoline_count to a dedicated bpf_testmod target and register it
> for fmod_ret attachment. This keeps the test semantics unchanged while
> isolating it from other selftests, so it no longer needs to run in
> serial mode. Remove the TODO comment as well.
> 
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -t modify_return -vv
>   ./test_progs -t get_func_ip_test -vv
>   ./test_progs -t get_func_args_test -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
> kprobe_multi_test -vv
>   20 runs of:
>     ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
> kprobe_multi_test
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> 
> v2:
> - rewrite the subject to describe the change
> - resend with the correct patch content

Please increment the version number when making these changes. Otherwise
it can be quite confusing to everyone. I believe this is the third
variant of your v2 on the mailing list.

> - resend as a reply to v1

That can also be a bit confusing as it will fold the email into existing
conversations. You can instead link to the previous version from the
changelogs.

[...]

Paul
