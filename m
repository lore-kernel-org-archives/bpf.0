Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC123F5BEF
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004735; cv=none; b=Q19/qka1ncUr9IRnA9suQ/dGQIvAhQYem+gyb/+IMessb8DSTw4iRAWwKvIcw/GGCxPuCU/vTQ5EnOh+00MDv7KBs61Rvz4r/nMrt2fYVUN+ydtEXly/oEPcBKx9rgQk0xry9dF+NY+wNHLq6r24xabkxn6bMdyoN9/4XNLyk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004735; c=relaxed/simple;
	bh=u35Fy/c9miFYfgIAMw9Zs68VFVkBNddOXa7Gm6zG6Qs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YatGfKWxY+vIuo6f9JdIbGlygdbc0ASGWl71lL6ef2AtgMJvCXgoWltA0FYAAGXFjpRLYhM0j3+hXgIepTmZ84+kZnMa3nySEAS6NCi+f4UXmO5cheFz0BDFEcaF3mXy8uoqadjbhmQ0aW6IPkdkBzt+Cv4nD5C2F+zcWk6x7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/SgNqn5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/SgNqn5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fe377a217so1260377f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786004727; x=1786609527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mvEGOYhp2CQZEcmymy9RcBUGgQ1zyWQcWI1QHnYNDi4=;
        b=A/SgNqn5MrMnrzwkQmrGmIqBHX6pOS5ZTHVuTDX7cSam+mSSrFw9ftKQ/GeoLsjvw4
         kKUjwh+jOqnYlUOQaVmGQsA2SmCOZtzCn2wyR//zp3Axb+/sbYTQMfR2tmWLW5VoruHh
         bhQVuIDur72gPuwR0aL1r0AY8AfvQnhKYxKkX0aev+kvD7vtqzGDTIFJcKAzWKMLJU+1
         CuNUCFqr+Do50uQSlD0QkgUkjhA0ueMUvQVCQ6p3+WZSiLN4CR+Dx75N6HNly31QQDNU
         oWTTA1waAMAOUVCCCHZQEqXUMc45pWHOXvo+yb4dBIlAw4QDP/QZwcQMCVkshgXYsGlv
         P/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004727; x=1786609527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvEGOYhp2CQZEcmymy9RcBUGgQ1zyWQcWI1QHnYNDi4=;
        b=bWyEIfTPCA6mBMcQTq/BuzGdHeTuzxsFGn8Pr+bErYtKvZl25H5moIgKzoySiOimrU
         RCehkPY9uP28q2j2KGP/i2VbhzSNpxp/brFNAeHjueA1hDJqlp00AqoL/4qAXZAwl6WJ
         8I45BNLks6XJb6vyavZP572POlGpy+7MV/jeIjKjsKcHcaHg7Dwo0I8BD0vLIe7IzSEN
         7FzhLB7R1r6amxFnMNSARHVw85y8Y31cbzjNJaBOr/eadgxuNOuLMJv76/D9T9K8WSmv
         w4Se5E4tFu3OgAp6ExbMXVacPaX5BInMFxf5YJEcGYf3XJzHyPuhg2zzszFSdoQeDb0+
         ET+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqPPj2tMQI9dtyxruVX6XZsVLwPKHd+e5DiivetlakFf5xY9MU7v2DzZwP9EUL3oFaNPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhL7JB6+pDqkrsL7yTCXBo//jMLKSGPOh0XEeTROji0hXAerh8
	AbMWiUcLxKwsiOlaePcJ6aZT8PfGo8227GcpZuW1eaZQEmPPAnmFHsa3
X-Gm-Gg: AR+sD12w+VYSqRd2L9T1n9f/t9ASJAi/5riMFi5UtXuF73K9bIjG/O0vGokhdaZiI6+
	86lv0sADr0jgSXkozKff3nHM2G7Iz+Ra6frAahE4hPL64fBl3SvUpVzyNjwxWWtoe86VxX9x+ZE
	WzB1YWMoBygnQWf9fXEGuVqGkcGHgTqU47ci4GyBCWBy4hIUxsdva0rh5710rMOByHHs5ME0TjR
	hYXcyzlHfrg4wLYffzfQo5WM3RMvI2zENot5FSag1kdsk8y2daLDvTImenzKJHrzxv6UubauJL9
	NlO7id3XdCn9W5gDMtapuoe+Jw4QZ+ujGlA1+YVVE/7TbCR0K8oJuN6K3JX22Q3Is5x+tSCgwBg
	z3U8Ngdd4IBP1jcO8YgT+Uiy4C0qcV0T7QMA/TR5myWhzi5A3GtlLbSojVXGNaLfu0bHHfEby9N
	cyG0nwOG8oFAYV5s+QRo6qI5+Dh5L1UncsAYHDFFv/1fX5GV7PjN5xgvDiLgLSNNif6p0ahX0=
X-Received: by 2002:a05:600c:a45:b0:495:6478:2dbc with SMTP id 5b1f17b1804b1-4994e73cc5cmr165920225e9.6.1786004727128;
        Thu, 06 Aug 2026 01:25:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421934asm45858475e9.5.2026.08.06.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:25:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Aug 2026 10:25:24 +0200
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Fix UAF in
 bpf_trampoline_multi_attach/detach on update failure
Message-ID: <anRE9L9HgOIYVCtj@krava>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785902527.git.zhuhui@kylinos.cn>

On Wed, Aug 05, 2026 at 12:04:05PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series fixes several use-after-free issues in the BPF trampoline
> multi-attach/detach error paths, where ftrace direct-call updates can
> fail and leave ftrace pointing at freed memory.

hi,
I need to stare at it bit more, but tbh I'm not sure the benefit of
preventing hypothetical crash is worth the extra complexity on the
detach side

IIUC we can't reproduce this error without instrumenting the code, right?

jirka


> 
> Patch 1 addresses two UAF scenarios in bpf_trampoline_multi_detach():
> the single-point unlink failure path (old_image == cur_image) and the
> batch ftrace update failure path. A new pinned_prog field in struct
> bpf_tramp_image keeps the bpf_prog alive while ftrace may still
> reference its image. bpf_trampoline_multi_detach() is made to return
> void, since callers cannot usefully react to failures, and
> bpf_trampoline_put() is taught to leak the trampoline when cur_image
> was left behind by a rollback, so ftrace keeps a valid target.
> 
> Patch 2 fixes a similar UAF in bpf_trampoline_multi_attach() rollback:
> when the register-path undo fails, ftrace still calls into cur_image,
> so the prog is pinned on cur_image instead of being rolled back.
> 
> Patch 3 fixes the common __bpf_trampoline_unlink_prog() path, covering
> both multi (bpf_trampoline_multi_detach) and non-multi
> (bpf_tracing_link_release, bpf_shim_tramp_link_release) callers.
> 
> Hui Zhu (3):
>   bpf: Fix UAF in bpf_trampoline_multi_detach on update failure
>   bpf: Fix prog UAF in bpf_trampoline_multi_attach() register-path
>     rollback
>   bpf: Fix prog UAF in __bpf_trampoline_unlink_prog() on update failure
> 
>  include/linux/bpf.h      |  20 +++--
>  kernel/bpf/trampoline.c  | 183 +++++++++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |   2 +-
>  3 files changed, 183 insertions(+), 22 deletions(-)
> 
> Changelog:
> v2:
> Folded v1's two detach patches into patch 1.
> According to the comments of Jiri Olsa, Pin the prog (pinned_prog) on
> cur_image so it stays alive while ftrace may still call into it.
> Make bpf_trampoline_multi_detach() return void.
> Fix the same UAF in standard (non-multi) trampolines.
> According to the comments of sashiko, Fix the prog UAF in
> bpf_trampoline_multi_attach() rollback.
> Leak the trampoline in bpf_trampoline_put() when cur_image is left
> by a rollback.
> 
> -- 
> 2.53.0
> 
