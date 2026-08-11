Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F631F3BA4
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446406; cv=none; b=ts4YtS2Iz/oDb6uGeBqMWv/daLc/6h+y67y62WetqhLrGEV1VE+Se/ceZZsF6/va8YCMyVsi5zYMiEAMb47E2kWowx3V4ccaZIjhgcngIPwO1jjBrCksLzXkgmyQwe/sH14eAG9FK2+xHYwHwHgLo3Ew9kj0iKUXXwN3d66n6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446406; c=relaxed/simple;
	bh=tukP0gFXkGjbkkO6Sate91Hwdk6oZ5TQM06hGsQvC+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+s3sxUafsSweHtS8Bb7b1pHL1ZFWAKyCWSB4dP9I8lxfr+IsNjiLlnvZr0osbGW0o6RUMB2bROTqPzF+o0eiEPd6J0s/831MDmKmuwx/CmmJt3XPx1hkOgdtL5dRuQx1lMUr7eFupSVOgSTr5YP1fvb13l9Rm7TbNqllZUf1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxtFFuBV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxtFFuBV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1600d040e4so132710466b.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786446401; x=1787051201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ncPBKBVNM6ovNcsCic32cHugMXoIYOhz070STPXc4TY=;
        b=PxtFFuBVzA94mCJ3JJ759NJiepI34WbXGkeLbqFaW7SIkE0SYvZzAEJdTw33amsc2q
         LUxSByhQxUvt2EnFnbM4ezb89uRIwnb0fZEwO/N1bY6doD+I8hqRErZnCj4tf9Ipw1gd
         2jxWYffv+nLchU+5A15QXk4yhnseUNksra+DF7eDGzhywISBNhhjEtQhvkLEWqzgkrgW
         C8IsJl22qBLJ8TzT0hPsyoyMVjL8j0eBpLzjftMOj/yqTlzUy0b1ofTJYmnJDSwOox6N
         /TR/C5373pAFSlJ3kW+c9uHzNnVOaDWEeDX2ZBN0ChTTJc957HCZHGcYGldW8IabYuZP
         uNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446401; x=1787051201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncPBKBVNM6ovNcsCic32cHugMXoIYOhz070STPXc4TY=;
        b=NiY/3ZWZZFZsEEdzJlRR2fYpgB+EWWnr/wDBcK/zco5hTixFmpl/zGiKlsN/J7EoRP
         V1THXcKuXY/C2Koe7SL6n5bNFFBvur6VTUMw3YbT1m/msddSk0diFjOwFRroxiagzJ1J
         pCcHbSpf90kP4HtZHKo8iQ35DFOsMQmMq+p2Lf6a8spOHZ4cNeAxp22OrAqBwCDC2DcL
         A5X2VHKfx9s0n12TXCjWT7Lk+lUB9thGQYIQre1J6Hz+xWjpHZCzny7GyByFhO/lPbPB
         qMe1QzCBFo7qSjTZuO4Rs33Af3vieUjL0YSRl/1D2bz2x/1bsL0IhYyCJpiqCA01/9+K
         WaSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4vL34aoxCMdbU43eEI9ZJqk+xv3QuKKatrqgv4DzIqA/1nBQF8m9n+DTLDWDeVrTqyvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu01mX6c7Pm03M64smxi5DdA/FbJGpjHHt50LRNcu4kxEoxTrk
	jppLXzbJWLefgLsIGCT26QnPZMJMR+l0M33izxmjLEUzAMG6EzAJqDS8
X-Gm-Gg: AR+sD13TzA3PQN8iWBetHJguaywoj1DLey699gYQFugF1I4WVx8lePCsyT+H83lgUgj
	YMQ08pEVy8eIYCC1e3UYhoDDjRN7KKq630fXE5RUAN5KxcAFxQKVbQAxj3s0hmFUtrva7QSl58/
	K79x8pmdwe2tvF7rwQe1dhNJTVva0OabGfiOO19/Q+4YXbsGa2u4bR8bpZaxGdqeiaankxfYrxz
	s/TQIqpG42RrbyrZvVzxqel7+E+6XD/dob+2BotY8zgijkf3oVb/dUtIHTwmeaLJgYRgr1HqaTn
	wB/mPixSrjEDyr0lssSLYZ1cX1qBejgF7LsNRaSoAUQWZecN+7X1yhgVgSsZ87sqiIfLT40ACxq
	O91+VIp3JYgAf4URLPvzypyTCMJIeKPdSu4mwo4NHlT1N2Td1PZ001cUvhw1kjlgDHGiOTkNwpH
	ZKP6aCfmhWh+YHKAnLQR8otShY78XAge+GTBiDMyoiTNl9XaH54CWC7smUNw==
X-Received: by 2002:a17:907:3e0e:b0:c19:5bf1:368e with SMTP id a640c23a62f3a-c20e5ed6832mr106791266b.13.1786446401261;
        Tue, 11 Aug 2026 04:06:41 -0700 (PDT)
Received: from krava ([173.38.220.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e414ddadsm37804266b.27.2026.08.11.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:06:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Aug 2026 13:06:39 +0200
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
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Fix trampoline image UAF on multi
 detach failure
Message-ID: <ansCPw7KqDWQ4s5N@krava>
References: <cover.1786412280.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1786412280.git.zhuhui@kylinos.cn>

On Tue, Aug 11, 2026 at 10:46:18AM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series fixes a UAF in bpf_trampoline_multi_attach_free() where
> old_image is freed while ftrace still calls into it, and makes
> bpf_trampoline_multi_detach() return void as suggested by Jiri Olsa.
> 
> Patch 1 fixes the UAF.  Patch 2 is an independent cleanup that
> changes the return type to void and drops the WARN_ON_ONCE at the
> call site.
> 
> Changelog:
> v5:
> According to the comments of bot+bpf-ci, split the single patch into
> two: the bug fix and the return-type cleanup.
> v4:
> According to the comments of bot+bpf-ci, add Fixes: and update comments
> of bpf_trampoline_multi_attach_free.
> v3:
> According to the comments of Jiri Olsa, drop patches 2/3 and the
> prog-side machinery.
> keep only the simplified image-side fix in
> bpf_trampoline_multi_attach_free() and make
> bpf_trampoline_multi_detach() return void.
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
> Hui Zhu (2):
>   bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
>   bpf: Make bpf_trampoline_multi_detach return void

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
