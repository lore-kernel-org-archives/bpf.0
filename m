Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0C3BE14A
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407168; cv=none; b=OEeeqKq+UrV72AOx2TD7AfwwdJ0hI5MyojnTZt7SKzii+EaPF2v0wnKbNGYEisH/74CoR5E8D4s1OeEyDiNTat3fpzdichssB7ogAquYcqe66mneHWIm8no6unbKUjPG0zQ2UUQRhMvqyOHMDt7+V0bDegwwyvDyff2Pej51dSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407168; c=relaxed/simple;
	bh=mhdDcd6URVxpfo91I5Qyv3Eb0UvP2jLGecqvmCd3mrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMo8Xl+8Hf/Gr8TRG3b2KQfjdrTX6ZCUiNQkLa/eaYqV7lFz1CZKmwH1NDqSfPcy+e8jaqQsF4x24u2I6o8J9Fgb5lJCt6AOBzEMnxuK5Aj/40ErFf+wBsP1PsZ77D5Tfozyp+VCL4AzjRGa52p5YW1E4LVIzIhJ3hjSapiS8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dgJ02Vs/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dgJ02Vs/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b27c7451so2839835e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783407159; x=1784011959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfzRI5F82+Jj3jQo8VQaqjjU0jNv4SWrjulOFBbp/Nk=;
        b=dgJ02Vs/aRyieeeK5ePOM2d98uTWuFifBd+sPhhc8pihWuf+7J0agaZSMnoceFoNBo
         /7tV5CCHriCFZHuGMNeITuOuu+uAfAQYDRExfkSpQOIGhHfvRrIMsG+kZOIg3PV3QW/e
         mEc/TaVgEbmTnJBbUtGeynCpV2OedgqMKkhXmRiG8TgG3JQ4Xk23R4YlbSvJtVQGfTlS
         U37GazADHuElg3+f9HaCWIIkglJ2F1yvARnBMEaqjB4o9u6R8rzsbUvs4hRwcVPHoFFI
         a2a522l+yr+zCnUJCUWvpwkYgGyKSldIZdPMaJ8jPyeyxGaMvfPOIRvQuHSHQgk/VqZz
         jJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783407159; x=1784011959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfzRI5F82+Jj3jQo8VQaqjjU0jNv4SWrjulOFBbp/Nk=;
        b=JjPVVxFIL3LQaBPfbcuK/JLI7ngNJwuEIcxVl74eu6fsRLH46rrtiCWzzChOOe+yQ5
         vhjLyRLCuLsmmx9QejsF6YK4kOWLrb1sOFt4iUCrExZbOsG9xWqPcnzRiAZmzi/WQtrV
         kEEaMP9fwyFBakAs5oGkR6TuiHD4KWbI1d2mTxU8tVNAdMNYWrj8ygFDw03uxGDn3kVo
         cSU39S8PFrww1AGbzgnPTIV5aQeIbzioMAeW3IDSmfUPtNVPwBaOzDjubP5BXjfN9ij6
         tOSRLRCLdjlq0AwzKbBZ3WvECQUv8PyCU9IwbIx2zwtEr9TpGQM339F3aa2vzr1Qs1ss
         tgpA==
X-Gm-Message-State: AOJu0Yz724GRVJRDkj4cUWKg3gdqPI7EkUA58Zgmlo1icJe3vngthy0O
	+PAGCZLLvETmsgi522Q5FsN9LnxSe8CZ/XM34awnnrA9mdNIPpHiGSnqdjQlP7VI0Qk=
X-Gm-Gg: AfdE7clK3jp/qYSh3VElHaTPYYlPnlgHIHsFTHrL6WRuFA+EYYFZ+DM7Q9Qss0k3RPK
	DwpH0JppwFcPljVDeB+I64ekPGzeDPEZoUIZyIirrHMijIPuIc6QK3zDsfyBsyce+wIwH9T1x0q
	+OqqPdCFsaFJZLqCUkIDMZ34gVQ9D5PqU0TvI3VfDRLhrYKEnQ8uIx2BCGp5EenwEosm0uSX7xX
	iULg2tZI3gfbIXiucatuEofI8YKF16Wu93A2ABKsmMlEAgs4RByiFD1dccadZ2u1Bd7sySecJ+5
	zbOV2Ks1EqetxnNUCudDA+7q+Ek/RGsC+IwIiCm+jmwUKM4qiyoe7AWby3Azry5VNaF633eWCzB
	WsCgShMcu+Fg2BD4fi1GBJ+flo30Yr89HYYuwIPufu/fvIRdlLf4m+HWJ147S2bFJOoDF1IwUSB
	GBZqPUfQ0donp+SwAwHR2m21xs/T2cAkdP0LZO7wVEAwX3aQ==
X-Received: by 2002:a05:600c:2284:b0:493:ca5d:b9b3 with SMTP id 5b1f17b1804b1-493e1029736mr8337345e9.12.1783407159009;
        Mon, 06 Jul 2026 23:52:39 -0700 (PDT)
Received: from u94a (27-53-112-249.adsl.fetnet.net. [27.53.112.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e279sm6305125ad.45.2026.07.06.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:52:37 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:52:24 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Reject negative const offsets for buffer
 pointers
Message-ID: <akxwvAuGFIp76TFB@u94a>
References: <20260703035137.109608-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703035137.109608-1-sun.jian.kdev@gmail.com>

On Thu, Jul 02, 2026 at 08:51:37PM -0700, Sun Jian wrote:
[...]
> @@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> +	var_off = (s64)reg->var_off.value;
> +	if (check_add_overflow(var_off, (s64)off, &start)) {
> +		verbose(env,
> +			"%s invalid %s buffer access: off=%d, var_off=%lld\n",
> +			reg_arg_name(env, argno), buf_info, off, var_off);
> +		return -EACCES;
> +	}

Other pointer offset checks (check_mem_region_access and
adjust_ptr_min_max_vals) seem to check var_off against BPF_MAX_VAR_OFF,
and that `off` being >= 0. It would be great if the convention can be
kept for consistency, albeit being more conservative.

From a blind guess I would guess that compiler does not product a
pattern where `off` encoded in the instruction is negative but the net
overall offset is positive for PTR_TO_TP_BUFFER/PTR_TO_BUF, and
rejecting such pattern is fine.

  r6 = *(u64 *)(r1 + 0);
  r6 += 16;
  r0 = *(u64 *)(r6 - 8);

One more comment below.

> +
> +	if (start < 0) {
> +		verbose(env,
> +			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
> +			reg_arg_name(env, argno), buf_info, off, var_off);
> +		return -EACCES;
> +	}
> +
> +	if (start > U32_MAX || size < 0 ||
> +	    check_add_overflow((u32)start, (u32)size, access_end)) {
> +		verbose(env,
> +			"%s invalid %s buffer access: off=%lld, size=%d\n",
> +			reg_arg_name(env, argno), buf_info, start, size);
> +		return -EACCES;
> +	}

If we check that var_off is within BPF_MAX_VAR_OFF and that `off` is not
negative, then `var_off + off + size` should be guaranteed to not
overflow max_tp_access, since the maximum of `off` is S16_MAX and the
maximum of `size` is 8.

> +
>  	return 0;
>  }
[...]
