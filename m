Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CB3644A4
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695778; cv=none; b=jnNdopjbyl8Z14mPGvw6IhPodKH5L8uzXNTF/d3X0ztaysYoM2Gz0p/Wd0UxBPgRSYh/Hlx5vjHbcUTcL7qS4cmEX/TLZmwnSmbsSxgjEOLKEbt9F1TWPmRKy/68hfqoitUvL2UvTWM8R/HAG0/8k/8ivvE5opVWdbybXe62xqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695778; c=relaxed/simple;
	bh=OA4bOPES/QxE18UADiEgPG2TNThQsMS9DAeThPzDc7k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aosYrzo1HbhVIG9WWY6nHRmJOxb7A+nZO7fvt1fBuIOgJeAAjOOHFppPMneXiZT+KzXyrJFtQDdUtAOuxmR072Pd998KxOBwkcVU981YmBDSF0L+/etBNYbDG8T/mmcGCZ9Y0Q1HI2KbKibSaXjrh+TpI4TDR4i+HuEojMmDVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWtvYO8i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWtvYO8i"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso42847575e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695776; x=1774300576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/kGgTmWR76vGODikeUVpePXIA4/UzKwJYC7CVcZZqQ=;
        b=UWtvYO8iOgOTaj/G1hRopzvI7ObTyzyLyLVvLjeJiSS92eUOlfxzOQBfizP0/0A8Vz
         8IK6bvCCqEUCXJdIQ94WX/Z00RMPWPDEYHfADreBuvnXBYJXM1vg7l6msslLQIvgzakK
         nrcxBtqn2N9FNLIOfRgP9FeeHsHKzCwhmULs9GPw7Sb/ax65hcoi9Dd7OpmOkbwkMlMi
         UhoD6fnphiv5nYQnYMtoPB1cYgUy+HjNdn1boVLRzmzLTb9yBbXEYZFiXfOjOoX4MhjM
         L/IZOTiPZlOpSUBqgozSQJ6wsZTVSSFOvo5KAvVmBRXRF5Xe95QGQA1L3cZqjme8obLZ
         59AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695776; x=1774300576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/kGgTmWR76vGODikeUVpePXIA4/UzKwJYC7CVcZZqQ=;
        b=mu8rTU4ci25GpaOOMBJW+AdLkPzRh3f1VKQamtI7vUPHyPvmemiRxxglF62iBWmnsN
         tV6B/kMSznS7x5e+htx1W1qA8Nkzp5W6Kg4NEgjam88VewIbJunQJHcYU/hBgaqIXYUH
         q8AN+wDGvznKWWVLt9G/bkyNZnDLPjMeyzx43UWNvbMxbRBl2dkEeSd2zDkPSQbZQqPg
         DJmi4b5VsNoSmFAvZ+A71nDwe2fFf4kVpeYLBN1yisbdLtjvVBQ0ght04ElrDPpGLfDe
         j1oF3dX3QYLn9kf79iyNNfhF7CHvaKuQWvsYbL3I+UY6wTZsQ7NNrTxK5WIv8Kn8Dk05
         Ry1A==
X-Forwarded-Encrypted: i=1; AJvYcCWeSWSgBGX5aHQvnTtqx++YRjRyT3UC7fVL1kz8DJJFgQZbdY9NB5cv+Lwo8p2SoeAINsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+y8eZtXohpv7CVCw63/txHeG/Yew8m5/nsGXaP017xrOLYI+
	g10tuSZdu2wPfZPjWAjV0LZ9tOceVcvcW9FfnqbVCioYlJRDDN/hOumw
X-Gm-Gg: ATEYQzzRucy96S6ISDvSyERV0jwB8WID1aqtTWD8y6OGX9tJL70fWM5bMAz+l19vJTw
	epJ3ucC+/5Lg7ju7AvyHwTk3D3LRtffwnbenmTph0BEqN7ge6aY9Y+rH7WCJiwa0rS9K6HB+8ob
	O7QuadqlsSC2bcL7EmE2anZwQooOfWpYE8rsZsoyPaNkvqRBfE8iFBnPBzrhm61xp40jMOqPCCh
	RoSQwROMyivYG7EzE/zCFe+ZC2GHsvZkhAwOdXcCjI1bVZXzdcgO1LjMQgyMZOPzR7C85/Tge5i
	Qw6rn89shRWIpG66IF6SaDm7MEjaJ8HEk4AviwmSBXvHfLpgdQexFwDgMPCkjmFETo8/+jv//VH
	qNNotsaGRWaU25ldkxxcaAYNDgjwa80WoIc/+MzEI9oyKZQ/WwdtQQTz6ymXv/pks9cA5Z7bR04
	WPR05vOlPAmqI=
X-Received: by 2002:a05:600c:4fc6:b0:485:365f:b4e7 with SMTP id 5b1f17b1804b1-485566d2c9dmr244798025e9.14.1773695775483;
        Mon, 16 Mar 2026 14:16:15 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c387sm23228205e9.8.2026.03.16.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:16:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Mar 2026 22:16:13 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 14/24] libbpf: Add bpf_link_create support for
 tracing_multi link
Message-ID: <abhzHZb2rep9222R@krava>
References: <20260316075138.465430-15-jolsa@kernel.org>
 <a34d2de2bc6db3cad91a50bb298bd687fa6ffa8701a14d6e7a07a29e7c34ffc1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34d2de2bc6db3cad91a50bb298bd687fa6ffa8701a14d6e7a07a29e7c34ffc1@mail.kernel.org>

On Mon, Mar 16, 2026 at 08:35:10AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -454,6 +454,11 @@ struct bpf_link_create_opts {
> >  			__u64 expected_revision;
> >  		} cgroup;
> > +		struct {
> > +			__u32 *ids;
> > +			__u64 *cookies;
> > +			__u32 cnt;
> > +		} tracing_multi;
> >  	};
> 
> Should the ids and cookies pointers be const-qualified here?
> Every other multi-attach member in this union uses const for
> its pointer fields, for example in kprobe_multi:
> 
>     const char **syms;
>     const unsigned long *addrs;
>     const __u64 *cookies;
> 
> and in uprobe_multi:
> 
>     const unsigned long *offsets;
>     const unsigned long *ref_ctr_offsets;
>     const __u64 *cookies;
> 
> These arrays are input-only (passed straight through to the
> kernel via ptr_to_u64), so marking them const would be
> consistent with the existing convention and would avoid
> compiler warnings for callers passing const arrays.

yep, will make it const

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558

