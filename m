Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471792;
	b=SxCca6Yj79bQNVqNyo71l9VUCffh0ZtEeQ7hWJonZXcGcRKuSztMrbp0vsFrraDcIgTE
	 Bw8tArxjJk9635udJYsfW1eWTgXqne1OuwQtyuF5e/J/1FmdTx6E47srBASa74gZN+IAl
	 bsEU0XOcxm/YP0n4+jFR1oLuuJ5W05e11zImWZX/9tKFZypxGx5lZ8utwdvo1PUia9zI7
	 yUodVJb+JETdfwmea+IrmOivMVsqW5wSXuA5vry7fd4kgQ/NmyFp+c8oGZKQajJ3vIRdY
	 +nlIikKF+XpaalgSMJBG9z82eIhVJATrXwh0lvV5lad00/w9B3WkCtnto3pRf+XiUKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Vz58Cre/aXSIBNc6xkRmR7HEG/rtQyKHMhQgyqCK6QY=;
	b=AAdQ2pcT7hdvhuPvO+NYoVpXbKIa39mYbTV7SPiwyx3Iruo8LS+/BZSxbBZrJtWrEmN/
	 uwYfxpz5gwErIz3q6W/UmCQnXuYKmJNstmTK9klPz2uZ4kICjez5GDY/lLeRAJ3TAN44V
	 lFpqhos5eGRzf8WHgrtXCH8QhKLSnT6M6y/cMVA2iA7qwchVXQwwon4L0KMgiJHY3zG8B
	 j21KLwe2UoGPWRW4y/4UehzdBT7kbZrbnaSpGsDSW5QGvKltK/1sPjHZkE3t7J0rhahvM
	 +OIFFIJekZxeUqKmXfuIuLqQly5QnoclG6TdZEzZOi7XUkPLcdVwuZQVr2M9FzH5iCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLTOpMWJ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D8606A681
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC1D8606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLTOpMWJ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so32830395e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471789; x=1796076589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vz58Cre/aXSIBNc6xkRmR7HEG/rtQyKHMhQgyqCK6QY=;
        b=HLTOpMWJk38/ystWWFTF7kDJo03Nx/0EQqU7gU1AzYiAhqkOfXtEz0J7jRtoau8Gi1
         emkvpoMxiOH5a+Cw5eXud4Pkrow26A61n1gKW0ki1KbbdozKJX7EYAy1AqP76FccnU62
         tWqcvQSeVuS2T7LwXn4cbQTh8wqaAIsBGvEchHB9chtzRZSUA9jqPDSRWQJYRQVwSHPV
         QTJt/JLh4o4RBM5t2mlFIVsCmCRNlzWTHZw4gR1GOalV97ggx14xwaHr269HbkXb4tiJ
         FV+xs3dSiuDx244qqYRhVgkUifkcmB+/hUL/2JTRMVHltcQr3tpwIldPSjOBtvUdVQeR
         LnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471789; x=1796076589;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz58Cre/aXSIBNc6xkRmR7HEG/rtQyKHMhQgyqCK6QY=;
        b=Qlj62BohEHYJaCs3KxXWkpmHCPX7jhgsIHdtdz5cOYy6aZh7HwLpJYnjnBp1dSxnRQ
         qv3bB7wGd2ylqo39DYuHaIeZK3UAh7qPno2LiQEYNWS0yPVuf18R3I3ETvccuj/t8nUN
         Tn7iqLemnTVLGSYjvFU+npv0UOmPOcErQWnGVXkOeNL5nklnlImP6PtlkkWh+n6zl5Ua
         IepynWxLFNzjnpcemleaSPuTF0ftDURrpcyiNI1eplJQ2+WUEn9ALCSsye15alPY1+BK
         0C8yFT6X58qNr5P8F6+rgUo4xn4liaTHhfodfEF3Y4fe2e1T/ydxPtLS89zUbE4nODOx
         rTAw==
X-Forwarded-Encrypted: i=1; AL+hErEeKrRu/bNGXeBFlhhLOcbA6rATMgz6sgAX4ZPPO3GZd9QOsReNZQD7bXoB1huEOXcQ/co=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FLfQ6j3q7ZKS2wGBHi1QpVlAzBESX9pOI2iRHhJajuThtyEX1
	sHvb80R0hbXJsm/tOEleEY9x39A0m57Tk5OCBssIInYhPHOwIz+vFVbh
X-Gm-Gg: AZFdTZcpbwioGc3L9nV2taH/npI01n682TyGqNad1uSHYuQvO6FTxHYtE6i1JZKHYro
	8zZO1lmN02y5gBx2JOjpNzxvgU6WbCHbSi9Klc63V4RhfjStqftaVboSfjaHAmLqQCdNaAkR+0c
	/x3yN37dWM0eqe69W9NunzzhnibteMTwgbN4H43gYSnqpsDtG8lJvESXj4h2keIKrqI7q/mfCt/
	zcAI/MfZFt3pr1r7W375dHSN6zJGnuAxmlVWW0u8BG3ocsGVK9Ct+LJFFZlT9CqY8pVouDaPJtE
	Bem8qCW1LUbUzOh2zD/ClzjJ3qjTVVwG5kYssyWExnkoQqHu8i7yW52PSbLkkk0cImo0IYXjGrv
	h+WAm/YJtWXYNxoMNAwg6hit5BLXHCe8qkDBlHVOrJ4exaqjG3am0LLl2Ekwt0N2Ew300FFdbFg
	/8JVjaMWxlUKgytqvM5NFzZGwMm3qBG8VsSGikK3KdVUTUuYwv5tiwt/VoSU9njUHs66QhCbfOA
	+HRBEREdeDxI9W+lnZ5xyjrEeKoMNlTPBWQEKSXP0e3Ynn2gnOFHoRqB67bV/YCf58Ii7eA/rLm
	sYvzfSKT7Zoxz+lO
X-Received: by 2002:a05:600d:82d3:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4bb8880f0ebmr292245375e9.9.1795471789043;
        Mon, 23 Nov 2026 14:09:49 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm372260275e9.6.2026.11.23.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:09:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Nov 2026 23:09:46 +0100
To: sashiko-reviews@lists.linux.dev
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Add log support for tracing
 link_create
Message-ID: <awS5qgoIeSAheK-w@krava>
References: <20261123152743.19629-1-leon.hwang@linux.dev>
 <20261123152743.19629-2-leon.hwang@linux.dev>
 <sashiko-outbox-229589@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-229589@kernel.org>

On Mon, Nov 23, 2026 at 03:38:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: non-UAPI field name tgt_fd logged in
>   bpf_tracing_prog_attach()
> --
> 
> commit 476f541041ef9d87251f0598129c4def280d1320
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpf: Add log support for tracing link_create
> 
> This commit adds verifier log reporting to tracing BPF_LINK_CREATE for
> attach parameter validation, reattachment checks, and target compatibility
> checks in bpf_check_attach_target().
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index ec8e787929112..80504011403f6 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3677,7 +3677,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  				   int tgt_prog_fd,
> >  				   u32 btf_id,
> >  				   u64 bpf_cookie,
> > -				   enum bpf_attach_type attach_type)
> > +				   enum bpf_attach_type attach_type,
> > +				   struct bpf_verifier_log *log)
> >  {
> >  	struct bpf_link_primer link_primer;
> >  	struct bpf_prog *tgt_prog = NULL;
> > @@ -3714,6 +3715,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  	}
> >  
> >  	if (!!tgt_prog_fd != !!btf_id) {
> > +		bpf_log(log, "target_fd and target_btf_id must be both set or both unset.\n");
> >  		err = -EINVAL;
> >  		goto out_put_prog;
> >  	}
> > @@ -3726,12 +3728,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  		 * attach_tracing_prog flag is set.
> >  		 */
> >  		if (prog->type != BPF_PROG_TYPE_EXT) {
> > +			bpf_log(log, "target_fd is only allowed for freplace prog.\n");
> >  			err = -EINVAL;
> >  			goto out_put_prog;
> >  		}
> >  
> >  		tgt_prog = bpf_prog_get(tgt_prog_fd);
> >  		if (IS_ERR(tgt_prog)) {
> > +			bpf_log(log, "Invalid tgt_fd.\n");
> 
> [Severity: Low]
> As reported by Alexei Starovoitov on v2 [1], should this log "Invalid
> target_fd.\n" to match the link_create.target_fd UAPI field name used by
> the other log messages in bpf_tracing_prog_attach()?

with this fixed, the tracing_multi changes lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
