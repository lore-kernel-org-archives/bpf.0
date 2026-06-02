Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F7378D77
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432622; cv=none; b=Db9k3E92urPUVK2GfQupGnTIibyXllHeREqu+z4YnhE7sDSeaTPwGAgVC66eRMECLJ5JJg/Hopn0cFBh4LjdI9MfCihq5SL8Rp+2vrb3Ky8R/ylmD5EiptgzKeCoU3AlNCIprl7p04djy3j1tNPi+XU1pxgDslWMOF4DVgYYh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432622; c=relaxed/simple;
	bh=QSbmAqd/sTZ3F0fvQA5IVDgSCR3fHbEcwZCfgBn+mJ4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtLDw9LZ25SMagZ4qG9JpLk7QiTJo2sF5pA9d9JwZSnXAkhSfDl8HzhR0fJZ5rti6tLnnC2Fpledtvb3kxMzbu5PJMbV88zpGoMNs+3iRkSS4HWW/mzy/YU/MzFdYcugRPUYQbSIAkIF4N3qR6SRkX6oUMTvHvHih+EHUHvmcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaCJYd4k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaCJYd4k"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so120960615e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780432619; x=1781037419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WXEdmdnIoR/6jbguXyziqGc/dq8TkPgdTmfXk5pzNE=;
        b=RaCJYd4kQQo6N7R5C92RpdRlPMKGRbzWFdd4/06HUcvBWhF1TWu3kiQggMeo5AG2W4
         y+rioj7Xeb8IYCjThsJmX82Xjo3LKA4xVD4+C4qBuClh3udamhZwernGANnlmEM57YUi
         ZavF85ix5Jbg3XnP/ptB3Jdx6L2MVhcC/ueawZ43sMYN7VAA7eBhtUXb0nRE7ugG4juu
         YnQHRckoTtFlLqD6p/cMChymZJbaR4yBlDy6jlLAYb2HUUXnzo+7U66Puw5Qnu2HxgT+
         GZCnVyrLlXTJAKerWx8U871JsrC4fPpokL9+S9UouYp4lhtEeJQ87BCzwaHcutRsjqF1
         kybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432619; x=1781037419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WXEdmdnIoR/6jbguXyziqGc/dq8TkPgdTmfXk5pzNE=;
        b=RNQmdn3k5OAHEqY3cV06FGiudX43tof7YUSpguJrO6gLAFGYx7IU8wzRaLcBEj78j0
         ak9ZVBhiTch2Oxoe5v0Dt/PDTfm6694AOfhdcxGoT0efqh8xcACNWVSNmrGs0GRAclwH
         eRgcwhgqFLDbbkwKgvATZYFnr/B0HNTPYaBBAoLLsegFdiB2+rt470A7b7O8Wa+CkCtN
         Di74XzcNu1yMEiN15vYjgAqabZhdPlS7U6lzrs0V8hjVkr8JEmk5088oY+3kNcHowa9r
         A+Q/XsUgjubE2Gd0OxIDLtqpdg82uCU+ycUKzS0pozi+0QngYfwS7lRQUx41P1D8amgn
         K+Qw==
X-Forwarded-Encrypted: i=1; AFNElJ9u22Ns9c/G+9pkmqjA8JiqwI/LeICaT8uq9DzSChWhL6pN3s8niTDXRcztEI1k2MJcqIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydsuDbtTgcM/4MrSKeW8v0FkAma7BTuobkH+DpyeiDNw7MO7M2
	9/mWTDKEsVYCeiRzdjVUCR4gEszYMm/Il/emaj7ixd1bk9vcXqME/oQp
X-Gm-Gg: Acq92OGDgScFjDiwk0+onhh4NtxBWR5GXjMxHOpBx9RoyqU5lApiAAYN41dF2tYmDwj
	1oZj3yhJXnd7bvgc2mU3aFr2TLj05y7Imr2WRyrpPCpibl3ubgPUlWWP16gbfeHLc49NtsIXF/f
	Wc+BcxMsI69A76BtHVXrZntHS15JfYd8O9GF6X/gC17lflwc0donhXtFFPa21H9ueBMSaHRLAVm
	z+R1q+naaPGyt8Qwi3+dRQRr19hFF5pfXE62tKAt1wfd4SE6WZPaW1XoVjjMtJ3KWaLjtiFTnds
	u5aknajnF6db6md557js5MoSIHir9tIfR+iX4dW8TZWQpmIzdV4MygIX1cm488W/BbW1Hd/YYZx
	zIE7Ae24vfgN3p4h+ug4gZ5ngETMFhzPzB6iF9lv5tndexG+SXDTMGBrWhs9WNNlg5sX4k25DAn
	QN9DYSMzQO3wFOUOri39sILw==
X-Received: by 2002:a05:600d:4452:20b0:490:b58a:dcbf with SMTP id 5b1f17b1804b1-490b5e763a4mr4324905e9.27.1780432618875;
        Tue, 02 Jun 2026 13:36:58 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm5383835e9.0.2026.06.02.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:36:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jun 2026 22:36:56 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 06/14] resolve_btfids: Discover kfuncs from
 BTF ID sets
Message-ID: <ah8-6CNIHPCJxAOM@krava>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-7-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601221805.821394-7-ihor.solodrai@linux.dev>

On Mon, Jun 01, 2026 at 03:17:57PM -0700, Ihor Solodrai wrote:
> collect_kfuncs() currently uses bpf_kfunc decl tags to identify the
> list of kfuncs. The decl tags are generated by pahole, which makes
> current implementation implicitly rely on those tags being generated.
> 
> The authoritative source, used by the the BPF verifier for kfunc
> registration, of functions being BPF kfuncs are
> BTF_KFUNCS_START()/END() declarations. These are BTF_ID_SET8 under the
> hood. Currently resolve_btfids reads kfunc flags from these sets, and
> populates them with BTF IDs.
> 
> Implement kfunc discovery from BTF_ID_SET8 symbols in resolve_btfids,
> removing the dependency on pahole's emmission of decl tags.
> 
> Walk BTF_ID_KIND_SET8 sets, and use the address-to-symbol index to
> look up set entry's BTF_ID symbol name (before .BTF_ids is patched),
> recording the paired flags directly. This makes find_kfunc_flags()
> helper unnecessary, so it's removed.
> 
> Kernel functions can appear in more than one set, which is legitimate,
> since kfunc sets are prog-type dependent in the kernel. So for btf2btf
> processing deduplicate kfuncs by BTF ID, accumulate (OR) the flags,
> and warn on flags mismatch to catch inconsistent declarations.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 122 ++++++++++++++------------------
>  1 file changed, 55 insertions(+), 67 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 43512af13148..d35a7b2460e8 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -970,6 +970,23 @@ static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
>  	struct kfunc *arr = ctx->kfuncs;
>  	u32 cap = ctx->max_kfuncs;
>  
> +	/*
> +	 * A kfunc can be listed in multiple BTF ID sets.
> +	 * In this case, dedup by btf_id and accumulate kfunc flags.
> +	 */
> +	for (u32 i = 0; i < ctx->nr_kfuncs; i++) {
> +		if (ctx->kfuncs[i].btf_id != kfunc->btf_id)
> +			continue;
> +
> +		if (ctx->kfuncs[i].flags != kfunc->flags) {
> +			pr_err("WARN: resolve_btfids: inconsistent flags for kfunc %s: 0x%x != 0x%x\n",
> +			       kfunc->name, ctx->kfuncs[i].flags, kfunc->flags);
> +			warnings++;
> +		}

hit few of those

WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_allocate_context: 0x5 != 0x25
WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_release_context: 0x2 != 0x22
WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_hw_request: 0x0 != 0x20
WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_hw_output_report: 0x0 != 0x20
WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_input_report: 0x0 != 0x20

I'd think flags like KF_SLEEPABLE might vary in different sets for the same kfunc,
IIUC you don't need to use KF_SLEEPABLE for syscall hook, because syscall programs
are already sleepable.. not sure there are other examples

jirka
