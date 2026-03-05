Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD021771B
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719300; cv=none; b=GAztfpF77Md2du4iri8MNw1Zgsno+8S+RfjZbZ617WtSb7jgpCmH0o4T2MlGsMaml7ehExXlyCXelHacoNylWLKtOo4UuHTGduhPAjbdptP7K4OYnkycaSFCp56WhMjolMla9audFavaG5O/IcK9eDbWOMwOuq3yLlZobAI1vdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719300; c=relaxed/simple;
	bh=+30yiLCRKCaT7AiCG1LUhJlbqL+3pTt+h7boXDH8K6I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6MyFM+OkqX6nCmTQxHcQshDC+QUH6YDPL/xR0YoHAA3LZLH/++H3egZuN/ykWYi1twSHRcNO14JsmBYm9mHg1zJ9T7H2gRq9wxT6ard3z5jeFd2+Q4Efx1hqQEUIdpG2kjGnMh6ATAnPc/zwlmpZBGRzcd1SDkro5CEwIwpKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsjBdErV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsjBdErV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48375f1defeso60915615e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719298; x=1773324098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URJ4mr13CHs0XGdHNp/cTfn6rBGk2NbDJqmtLd5hK2s=;
        b=JsjBdErV/MbI/E/+d5+eI5Dt2wvma6U0zjwS9BL/wb/xCkIWNtzM9vLfpnhujKYcYM
         K7O3QF9vpY63g1QuPjkcq+T2cNVaTGGVSJCoTBNM3Jm5f2dMJHPcpanJGdPNYXbn2u0X
         MrqKjfvhkLTnKXZlsVx0cj0m7w7c7EEcajd2jiSks8J/5qROX1s3ZiEgB/sxzFt+i6s6
         uMk99R3k4NeYKEH6fteA0lFQTWrs46InNgIOMqHUljsR1NYBfEnto8KFPUUI80NdscN2
         xRalhlUJnaEP6JaIjIHeSFEwUIF1D1Mb/L6TiTWo5rDtFdkUTG0fqVoDY8y/AbEaDDXO
         Dp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719298; x=1773324098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URJ4mr13CHs0XGdHNp/cTfn6rBGk2NbDJqmtLd5hK2s=;
        b=MSQNvxLg6K4hPJfRwaNxExW7HvVWeHkpeaqPdd+I5tC4IX4LApuBIrzd6ppXRrp7Eh
         HIc10JSoAWVvzJQD18CTTZi3W6C8LyTPeYntpZOMTAUGlYN1azfYxAlw2RmwvROLJjgp
         GKoBYc8y8VuQqe5Y8KziEuZ2l7h/ahW9NjsJk6EYbtEw11XwHbgOJFxCg4r5Id1Lp29v
         Vc1dTf6UMyc4/4f9JVjHsdor7tB73W+Ahf06zNz4RsalsBtI3meJdvvL+JzdpLKogJST
         JV07lklpTNyhf9yr4tX3OApPPyUizDQRWvi+nFBjJywWxAOlQXYAW0Tky/WqoB5hi2ZT
         bc3A==
X-Forwarded-Encrypted: i=1; AJvYcCULYnTtMY2pIgNDG8AKsWUpgp0BU8VewnVvc31KwQqt78TgaX4RQC0orbCLCJp7SWc/ubY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOqzDdfw+Y0hxrw4XDXV0nuaGNPU/MQdQ8h9uHcs0uHxi0nIn
	TNEi3P3PzQMGlb2q/wKCYATUnS3BlGCxaCDkRbboaMbc5fn80pA3E+8c
X-Gm-Gg: ATEYQzw8kNILSzIOEYgjN8g1f/kPicxIDrKjDMjrM3kW7iISzB2hcntYcG/TmCorg+i
	2BsryBwsGb1s4/J4q1ULo79Iq0ORhiLRUGB0PGy7ba+uRx1RecR2muMvUEj8tGwMBGYjvbMwUiX
	d/A0umrQutdKTmANx1B3pzwCY2UfJKFddnBlh6PI1gRYGR6UQTTs0PKFkl5g2ifLJiTzQ5WPOtl
	Zu8j0wkC4brgRuaTKYGmgXn6BbNwB6pA4+9/OlgZQzvL664U4/k0lEnC/dlZSHVmzFDqJJusJRM
	B+ZHdL9OLiE8yWNjv0NWRnJs7xUn6cqCEL8Kt8evzmnnmiSax+zklJiY3L3g1KBcV2lCVT2cJW2
	FS5JV/vY9vqHi5fnqP9jPgalRc7uuwK+0TQR1/eWgwOE8tPNNafXKEp8VOJfR/g9w5yh6OQlv
X-Received: by 2002:a05:600c:45c6:b0:483:c12b:fe4b with SMTP id 5b1f17b1804b1-4851984953emr97181465e9.9.1772719297394;
        Thu, 05 Mar 2026 06:01:37 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad2b26dsm43352905e9.31.2026.03.05.06.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:01:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:01:34 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 12/23] bpf: Add support for tracing_multi link
 fdinfo
Message-ID: <aamMvvzUJTl50J81@krava>
References: <20260304222141.497203-13-jolsa@kernel.org>
 <77554f42f56834088eca284c1a787f51e4402907c616f8194942c82530a9ce6b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77554f42f56834088eca284c1a787f51e4402907c616f8194942c82530a9ce6b@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:26PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +	seq_printf(seq, "%18s %10s %s\n", "cookie", "BTF-id", "func");
> > +	for (int i = 0; i < tr_link->nodes_cnt; i++) {
> > +		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
> > +		u32 btf_id;
> > +
> > +		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &btf_id);
> > +		seq_printf(seq, "%18llx %10u %pS\n",
> > +			   has_cookies ? tr_link->cookies[i] : 0,
> > +			   btf_id, (void *) mnode->trampoline->ip);
>                           ^^^^
> 
> Should this be %18llu instead of %18llx?  Every other BPF link fdinfo
> displays cookies as decimal:
> 
> bpf_kprobe_multi_show_fdinfo():
>     seq_printf(seq, "%llu\t %pS\n",
>                has_cookies ? kmulti_link->cookies[i] : 0, ...);
> 
> bpf_uprobe_multi_show_fdinfo():
>     seq_printf(seq, "%llu\t %#llx\t %#lx\n",
>                umulti_link->uprobes[i].cookie, ...);
> 
> bpf_tracing_link_show_fdinfo():
>     seq_printf(seq, ... "cookie:\t%llu\n", ...);
> 
> With %llx, a cookie value like 255 would print as "ff" here but "255"
> in every other BPF link fdinfo.  The hex output also lacks a 0x prefix,
> making it ambiguous whether values like "10" are decimal or hex.

yep, should be consistent, will make it decimal, thnx

jirka

> 
> > +	}
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038

