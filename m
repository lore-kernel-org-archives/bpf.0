Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624219CCF5
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882375; cv=none; b=BZd4mZNoWxEGeHywtJIwv1fBdyWOb4IA8t1m1QRHhPkXrepk2IZ2ftXPM1OxJ9eQhEKNwMCVjkvyv0cTEtE47w9aJYRdobousWaz9JKK578V2xyuh34SDmXc/AsedKYcpmIxQWdfOsiZbu8gXbgWSrxKhJoQx/Oy51rUTXCSD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882375; c=relaxed/simple;
	bh=MEl0s8Q0in108sE0Z3YfPp8CXOtINBYAh9+o/64iYUA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZoZ64YhohXGSrvYB+Qhi5f4lhPI28raO6aycNZTzs93Hs7fS16RH6jmm9aXbk12hRkoZDbXfqDafs+xCy5Z9NZt5gcUrbgkTXY58Acgf7/pnNKKUUYmJAm77MYqknrbIVpra7OOuNq9TaTKh9pMWjyJVwZ+AZZw+xdJarxfr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWDqpmfv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWDqpmfv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so38819995e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882371; x=1775487171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Penii6oSJ1CSfljsWTX2ByzVu4f6h5M+tq1akpJN/dY=;
        b=sWDqpmfv82IKdtez6B2CczUTfE+wb97Ug/qXBFdtNoVv4cMCdEtGIbjfSGSrJ2n1dW
         zspAUY1V4WsvzVQt16P7gwTdGDLK7lphN0tfz8o86/b89SR31HuwOSA4IOz+Y+R1u2xn
         03B8EOQeR6Km2DvRR9g4aIQconhEScpUVOYFN9fiYhaSQ1E8E/XQMcHH+btyBYN55FAe
         MkkjKx7ycsLsiSnAdTDb0IbQd7mZmY6+/tiLJuihQOVckvwfXIzTdBYQ5h/YW3ncpOdW
         oeZoSjG9LXEjr9UWJSrxvmNJ5U7b2GhRhecSRZuHGhgpmpeXdOEIVWws0Rg80ybNRxNU
         wPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882371; x=1775487171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Penii6oSJ1CSfljsWTX2ByzVu4f6h5M+tq1akpJN/dY=;
        b=LLafUPUZMT6o8khuMS2T6x3NG/6FnlK6zf4A6fH1kCA+g/C2Nv4rl63Tz87UUvwC/N
         Aw9S5TNNikheSCNOy6vqX+UIYrpxFfqIhDy6jeM/Gs1kmAxGHT1etUeIRQnElgdgGiJf
         OQfzbvoFYcbADYX84DEp6f/JGAR7LkcYa/NDYiP4sELGhWrWxECIBg4NOvye8sfzuH/f
         VawvNjEn6Ihg2bDl2SwBBe2OQ79lP4hywWSZyEnjLA0Q69d2hpclpwJN3QiRIU3MTSsB
         l5VtZJK0wuCa/0Zv2DtvOZwY3p47aGbCnurtw4L8JW0pRD2vQzNLvJ7nyYH6XctSYh82
         OFiw==
X-Forwarded-Encrypted: i=1; AJvYcCVaFi9vxsN7pvMylqW4B+BAucB96amT1jiLH4vVZBVHJ3LPSRb4U7h2RryL49Qo0uLpYlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKS8nYKhH6HNKTym1VGafKzxQalYGGD5h73KVuFiK/qKv9IGX
	3zlkQ9ggqkl9DTs8dJ+DYz7V4ABimONrHuC41cOPJxsuWJRc59v7Ue+8
X-Gm-Gg: ATEYQzyrEj6Z7umkJ6rWn8hLYF5OxLd4Jg5gPLbm/Tj3sPGop654pp6fd8PMfJZiCpn
	n5rPfKNtw8XPD3SGfOr+eO8eMiMPEDbcJMCVuzOCI9aWpDjUIt3o2dtDKeunLxDIMCZvMUQH80+
	mwx50JQzPU0sPU5B2q3KN2mTNJv3kRhBPwqnYVDU3BbUmbJjr0hAW02TZb9cvbrZyYAC6aBxS2b
	id+TVaBuiRo2zbSskrA5e7fQS1cxDYTmUOBUKFu0I1PDtEOfFxipw8b5JWHpzNB37pYV/rk/e57
	EwBekl9KBas+zp8EBUt7BAFdz0RUscEUBbuLjNNMdYTvFH3DiOiMHVyswHKyTea0/T30ycPbSQ/
	CLat7XhA1sC2DoxIPtQOL5Q5vIVRciNLPYar3Qfzcy6J2dc9C6w1VDuOQ7oj/RTg6RFfHoyJyf4
	aup078zhZxJspXldbB047ZiKB2w/9n6XO0qrqW14/29rP34CHsLTqWQ9IQlQ==
X-Received: by 2002:a05:600c:16ca:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-48731faed9cmr86124445e9.30.1774882370548;
        Mon, 30 Mar 2026 07:52:50 -0700 (PDT)
Received: from krava (cust-west-par-46-193-1-135.cust.wifirst.net. [46.193.1.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48737a73062sm42467515e9.34.2026.03.30.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:52:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 16:52:46 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev,
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com,
	martin.lau@linux.dev, menglong8.dong@gmail.com, puranjay@kernel.org,
	bjorn@kernel.org, leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK
 feature probe.
Message-ID: <acqOPsDCKHIrH1HT@krava>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-3-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330110019.549079-3-varunrmallya@gmail.com>

On Mon, Mar 30, 2026 at 04:30:18PM +0530, Varun R Mallya wrote:
> Add FEAT_KPROBE_MULTI_LINK, similar to UPROBE_MULTI_LINK
> by loading and creating a link for a small BPF program with
> BPF_TRACE_KPROBE_MULTI as the expected attach type, and
> then checking the success of the operation.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  tools/lib/bpf/features.c        | 37 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index adcad221c601..13227c9ea69d 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -424,6 +424,40 @@ static int probe_uprobe_multi_link(int token_fd)
>  	return link_fd < 0 && err == -EINVAL;
>  }
>  
> +static int probe_kprobe_multi_link(int token_fd)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> +		    .expected_attach_type = BPF_TRACE_KPROBE_MULTI,
> +		    .token_fd = token_fd,
> +		    .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int prog_fd, link_fd, err;
> +	const char *sym = "bpf_map_lookup_elem"; /* stable, always present */
> +
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> +				insns, ARRAY_SIZE(insns), &load_opts);
> +	if (prog_fd < 0)
> +		return -errno;
> +
> +	/* attaching to a valid symbol should succeed */
> +	link_opts.kprobe_multi.syms = &sym;
> +	link_opts.kprobe_multi.cnt = 1;

maybe we could set cnt > MAX_KPROBE_MULTI_CNT and check if the fail
is E2BIG ? this could save some cycles, but haven't tried that

jirka

> +	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_KPROBE_MULTI, &link_opts);
> +	err = -errno;
> +	if (link_fd >= 0)
> +		close(link_fd);
> +	close(prog_fd);
> +	/* if kprobe_multi is supported, link creation either succeeds or
> +	 * fails with something other than -EINVAL due to permissions,
> +	 */
> +	return link_fd >= 0 || (err != -EINVAL);
> +}
> +

SNIP
