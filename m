Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14E23D7DC
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761713; cv=none; b=rLnmpZp51eG6DS18T/+fmirUUbnfgpGfbKWPq5CWkb5nLibqXiCvopfsjyWkAQUBmVN69wZ3471dENYeW1VwN/Ds3yco15qXl32AB18HYKNrsi5vWrgVVPRb2PEfdmJxTT2BBPScpT1e0t8T6HiSZqzaPRpl3N/ZsxjLcXOcc6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761713; c=relaxed/simple;
	bh=sjxMVwhX0uLBHov6ZrI/F9F6hKN9maMgZUi2QG+mzw0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjrJiF4tw37frJMV8pgTd3cg8b0CsIMnL/mVLez2pboHq+RZpVy2phRc9aIwY856tWx/8WDoc27R7kmc/jWa/OGagHWTKESVVuGCWUXHeV8FsbIlsrUr9ufO4UwotF6Zp22wWSU6uoL7LHBSPIdpmBMJxsb/I+SqsYZp8X/EN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZ+2PMgW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ+2PMgW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48909558b3aso30572785e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761711; x=1777366511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/ItaIqrOxq/1z3/TSoevbCzM41LSY3UwDzcgqamzWo=;
        b=oZ+2PMgW8vTVun6efunbrxvU4siu45kGseNVz8WpvX7gkO6yTG/9TrDc7CWLSifuR9
         wxowo8liJNyvEHAmVB/LEkLh30RGrle2cXxrbLGnPzFLOXxGNQ9i9CN8DUKEv/ZEtLto
         5JqxwzFHPZwHbChPhJ42cylfl396HaQk4SWXd948G+/z4GVHlzpf8JcdwDGSfRfv3Nqb
         5X7jZypmKPDsi0iWOdzq6FWnBX+VwuHGDk6v5GPIrkrACQr327EdSUaInQbzyKkuKoFk
         BJwRbSvadJoIGbqU4MX2ViB+ytiONqKs9EoagpKZVfj5Kv0n1Q1ODHckXLci2sP9/DJ/
         99Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761711; x=1777366511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/ItaIqrOxq/1z3/TSoevbCzM41LSY3UwDzcgqamzWo=;
        b=getmSy1Yr1QRXrSsP12JA8AW9uWHrzAbXOMPiXk5IjJEtjDE3pf6Y0P/11k6coV3V3
         sqg7nIYBC7syDer/ggFYmyLTEgkDLM2Vn5wcwHb09FFeQjhHMQ8HuYb0ajzTiRSYibe3
         grPuMkVQC4KCnPynhtYbxcfDxdAPjA+WgbQT5i887Ok4XduU+z9AyMwIKNnON4xqYMc3
         arEZSPk4aUkpnCt749M2qU14kL8zgnOiIMnuc8QSGsEfFSpFaXFvxlAJyM/0PIHCKBUg
         G/LAOfJFi5YmZ25yTM174E8m1gRblyukHWlKNWDbZwq1ocAc11MZWaUrZE1WXOKsKCn6
         Ry6w==
X-Gm-Message-State: AOJu0YxGrO8cTPeas38OysW4si5RuxS5f56VMeDv2cPkw8uscFU9EvKN
	sme4kX6A47Ii/SetHfxY3BsrJs1bjSRp+iOs05xl0nzlGIn/xSy0wczYrJ3JnTuj
X-Gm-Gg: AeBDieuLBPWQlJkgt+uBMBtVhNI/hC+bI/C9hvK18lwG+Gu4Q/LzM/y7i/11/+MSqo2
	33kobct+HL5RBHfyzdZZuElWUR44Dz65TmHz0srjaccXmD+S25QcPWbwl4M4kiYp1zYVSUxY2CW
	yp5gWDBB68e7ApAeyz29rrxFX1jZssbq0ZXBHV8q9qF4qyEYEEAELzKpZxHm9ALps6OH/ERZmnV
	10mRzJYFZffHPo0zZ4vawhTqi3bIj+kslXqRIUUVuNYrRAQiAbxqmqExIrxwU1GFJwFS0by4xuB
	HEG6aDLEjZqhVi63PUdD9AuIgsjbRR878sgvVTr35PIx3H3bWp2P5p/eVUfNKTXYCH863MI4NsO
	B9cCti0b/9SZhgwg5ljd9tstp3sD1TeK/PICZxEHPduWcQAyrHdqDJtgrsleQM83o6ssHeDjGaA
	lDbvA5il8=
X-Received: by 2002:a05:600c:890c:b0:487:1108:48af with SMTP id 5b1f17b1804b1-488fb7389a6mr192146365e9.4.1776761710590;
        Tue, 21 Apr 2026 01:55:10 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm75178065e9.6.2026.04.21.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:08 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aec7bAbGlnEo3R1g@krava>
References: <20260417192502.194548-5-jolsa@kernel.org>
 <20260418035227.168AEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418035227.168AEC19424@smtp.kernel.org>

On Sat, Apr 18, 2026 at 03:52:26AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] False sharing in the shared mutex pool causes spurious `mutex_trylock` failures, leading to random `-EAGAIN` errors and trampoline state corruption.
> - [Medium] The `trampoline_locks` mutex pool is initialized in `late_initcall`, creating an uninitialized lock hazard for early boot BPF usage.
> --
> 
> Note: Due to system recitation restrictions, the standard inline-quoted
> patch format has been altered. The findings are summarized below in a
> free-form format without direct code quotes.
> 
> commit 8bee21cb8aa45a6b2275c87c16fbbd2fd1953e75
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Use mutex lock pool for bpf trampolines
> 
> This commit replaces the per-trampoline mutex with a 32-bucket static mutex
> pool. This allows upcoming tracing_multi features to lock all involved
> trampolines simultaneously without exceeding the maximum lock depth.
> 
> 
> In bpf_tramp_ftrace_ops_func(), mutex_trylock() is used on the selected
> trampoline pool lock to avoid deadlocks with direct_mutex. Because multiple
> trampolines now share the same lock, could this lead to spurious trylock
> failures if an unrelated trampoline happens to hash to the same bucket?
> 
> If the trylock fails, the function returns -EAGAIN. Does this mean
> concurrent ftrace or kprobe registrations might randomly fail due to false
> sharing?
> 
> Also, when the upcoming tracing_multi feature locks all 32 mutexes at once,
> wouldn't that deterministically abort any concurrent ftrace IPMODIFY
> registrations system-wide?
> 
> Finally, if this trylock failure happens during unregistration, could ftrace
> cleanup routines ignore the -EAGAIN, potentially leaving the
> BPF_TRAMP_F_SHARE_IPMODIFY flag permanently set and corrupting the
> trampoline state?

need to process this one bit more, perhaps we could offload the
BPF_TRAMP_F_SHARE_IPMODIFY unset update to defered work queue
in case the trylock fails.. or something else

in any case we need to make ipmodify and trampolines attach via multi
link mutually exclusive, because we can't just update such trampolines
with bpf_trampoline_update call

> 
> 
> Regarding the pool initialization, the new trampoline_locks array is
> initialized in init_trampolines(), which runs as a late_initcall.
> 
> Since the static array resides in the bss section and is only zero-initialized
> before this phase, what happens if early boot BPF components (like early BPF
> LSM policies) try to attach or modify a trampoline before late_initcall?
> 
> Will this result in calling mutex_lock() on an uninitialized mutex, leading
> to crashes or lockdep warnings when CONFIG_DEBUG_MUTEXES is enabled?

right, in that case we should register it earlier, will check

jirka
