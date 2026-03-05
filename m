Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD934C9AF
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719369; cv=none; b=ULcneF7tZkIkB0Gv86QXevrmHpqPAjiQ2Bes4ILARF/BLlcuHlql6hLNZk3fyncRhzhVWJ6mapE0bTQD2tFlEafv5oBNrjrvSiZF6UyZyLDOj2mKO9FcI1nU5wGT4zsqfpTISsWYxnjQojfi1RLHS4HPis5M/LelvZkmfEJQVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719369; c=relaxed/simple;
	bh=Z34mdtr1b/ICs/c64EQSK4zTp2yDbOBYmoxjVqtaA8I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtuCRkPI5FHNg5DWpAeqgfJrdPa4Q+GGjMQkXBFOjFD3CXRRmwIg8/vJh1jRd9KqlqlF2Q7vYUtycjz9ZCIHFws6IAVuAqKN7i8tKmpPZuBFikZTmunymHEZx2YdiFBNB/HVBx1WU7FEiuJeeNdHqpnh8RDTrYFo9FuD53WRk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gutkv2/o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gutkv2/o"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso5185149f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719365; x=1773324165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKxSvraDpoad+84dRp1TpOG4toWpwmDod5+UGYBJ7P8=;
        b=gutkv2/oaetcQvQMiO7Hgy8gZJQ43kXaIcRljvMYfkZcRn7DHOT0nYcaciVjcV/bh/
         vFj6MzU5Jj0TCZ4/bVRCLbEV4lIe51nc5nRN2JCaAZwVWJwNH56R6cAiNiClAyMMbCf3
         NLrsHbTaGYiiIFKiepAg1kzCtKURAm01QeA25O5pEMigd5WtdKQsIScvG9pIRyzA7r/n
         aRZqVPyUsuVcma52fWYx01IwzSoAipoEzuv2/WS6tkw0lHQA5fcIwtqEc1Q0uW/RDhop
         fW54rqAlXrfjfuCr4eg3nODTO4juKE/N4pDF0S/momvmsha2FJr/4vxjuMWF3ZtA5rSC
         GwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719365; x=1773324165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKxSvraDpoad+84dRp1TpOG4toWpwmDod5+UGYBJ7P8=;
        b=WfgFgZslzKalAi2W/phv4k3+cRRBJ7bluTSNSt3mEFisv5VX/R9/Re/dmGRny+4l7f
         dGr8bLMFrV8Mg5vbbOv3aEZzkK0sVoRxfA5CXb/OAMo6afPB0SJdt9QQZSv0Lqsoscxr
         5oy102hMKcsHGEvT8QfLgDP19zdsKLVDPDSVNZJ52ycdgC8sbptHb5B7dhruRY66Q5BG
         2XlDChXz1i0iOnvFOQQijIdxi2BLvGuSfTHfn3uxiuhJ6XzfhQX6XYBHXe7bCjaqrYBC
         LB1FKFxoFEOAj3hfCKR+TaCvo482nDuwzGEagoqcCwQCTqBN8JnW192TfW5T4SaWywdv
         friQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpBcx5NAz4sJpmyi4UI/4YS6mQ6cnfKmm76qOWud3pBDbHUHGYKJY84TDvKRdweftnxN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxpr1VAeQKFtuafUX7WwMr2PgFrmzrigkT8MZ3odYklK0/ur2B
	I/DCfioDeE680jLcv46GLLGMYJ1AzYZeKnaw63ATtbqZIjOxt6o1T2aK
X-Gm-Gg: ATEYQzwviI2/dziyuVtKz9o+yYLqgfe6ITLQfZg2Gy8tnYLxjxO0I38L1/q0ipfP5P8
	nzkfJKnGgBJj7OKijBelsRTNSDXMr2poVBk3gMRpOxZzu66PREHBuJGOEMjFPb48BB9g+ScIF36
	b3oKhjq/Xesy9VBZKaUvWT0j84NQoGhjawXcpdjOIYJYFGuFsU6UeVvrfdSFhk0v/nwI41t1TIR
	mjOtUhEAM2RRSJpEN1YVcTVcNRwx+QgjZxwBhH2MiCrpzhLgAmXhIP6GgtnpCIKEjl5llOStKMa
	gv4HDi0XS5syYQ881fGfpcoKoCqyVUk5IXLBqZRyyTmxtyq8oSo7WpTz32LHWhmJnkgkszpu9vy
	wqiwTnGZ1oAYE61/iALhcJRCBvRMASbKS3CUbVQN2M0VUmh0NHOWfPwPL4PkpQo9anO2IauiM
X-Received: by 2002:a05:6000:1788:b0:439:af81:1b2f with SMTP id ffacd0b85a97d-439c80154b9mr10514645f8f.46.1772719365461;
        Thu, 05 Mar 2026 06:02:45 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b34b6252sm34213852f8f.10.2026.03.05.06.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:43 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 15/23] libbpf: Add support to create tracing
 multi link
Message-ID: <aamNA4bW5on1jD2c@krava>
References: <20260304222141.497203-16-jolsa@kernel.org>
 <625b9bd61d08db7a0cdff51817fe64752c1901d360d73455b609516a0b611d3d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625b9bd61d08db7a0cdff51817fe64752c1901d360d73455b609516a0b611d3d@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:25PM +0000, bot+bpf-ci@kernel.org wrote:
> > The provided <pattern> is used as 'pattern' argument in
> > bpf_program__attach_kprobe_multi_opts function.
> 
> The function referenced here should be
> bpf_program__attach_tracing_multi, not
> bpf_program__attach_kprobe_multi_opts. This was noted in v1
> review.

I'm refering to bpf_program__attach_kprobe_multi_opts intentionaly

> 
> > - bpf_program__attach_kprobe_multi_opts must either have
> >   pattern with module spec or BTF ids from the module
> 
> Same here, should be bpf_program__attach_tracing_multi.

yep, that's typo, thnx

> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > +struct bpf_link *
> > +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> > +				  const struct bpf_tracing_multi_opts *opts)
> > +{
> > +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> > +	__u32 *ids, *free_ids = NULL;
> > +	__u64 *cookies;
> > +	int prog_fd, link_fd, err, cnt;
> > +	struct bpf_link *link;
> > +
> > +	cnt = OPTS_GET(opts, cnt, 0);
> > +	ids = OPTS_GET(opts, ids, NULL);
> > +	cookies = OPTS_GET(opts, cookies, NULL);
> 
> Should this function validate opts with OPTS_VALID() before
> calling OPTS_GET()? The comparable
> bpf_program__attach_kprobe_multi_opts() does:
> 
>     if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
>         return libbpf_err_ptr(-EINVAL);
> 
> Without OPTS_VALID(), a caller passing opts with sz=0 would have
> ids, cookies and cnt silently ignored rather than getting -EINVAL
> back.

yep, should be there, will fix, thnx

jirka
