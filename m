Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5C1E49F
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719359; cv=none; b=C7BlK8zDQcNtyeXGrljHp9LwAGXMK2SGyCCgXVFp34JQaWG5+f3X954KUig3XNc1womGKGSb7kSNGqdfAlXT/J0ZCJAmZkp9i6nju+pWB8oYfnxamq7ooXTRWNBCT1ll+5YczcP0H2FZVyDXAJSLL3cxehySCQqFedTbiwO2zW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719359; c=relaxed/simple;
	bh=Ayo/m5In2cWheRUhEbZDNxmSZ0S2YqNXJ1TgcWeRLfU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz16gRE13XGKXlZ2F9idrR9De/sg5LBUaF7XbUsXpxjgOrlFRiOvKAmaGH0HP4eCsa8YXex/6MW5KH4ivH8ZMJSgLPV5gGGCRiDweN5vCw73mDSwe1K88U4ZLJpWlkrsMa59uPFyRDg/pFii7TlPftTbkO6cKJBRgofVY5x/TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhZEc9/w; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhZEc9/w"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9362ddbee2so1106608166b.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719356; x=1773324156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFJ/di+J1DTWnmpzI1g7AxF+qp7wWfEyM6qRiUSBeHc=;
        b=JhZEc9/wtllKtK5tivjsJxcC0qDTslZ11vEAW+qzNZ0SaXka8W4WbZejMWi0+ki5dr
         NQ/cqLdYWN8EbxiiBt5QMEFowSDgvGid77/YvqizK5/aGJ1RZEqRKPUlKWQ+R8WXyS+o
         cspBPvIGdSF68i6gBOk9/abBQ9vLZjjp2g543Hv0VYvxiLEnIrEicIubdh9G27QVmT/N
         yecm1Il9NY9ufbn+6RtVXDat7vqtgj4/Dc3wmHX0y9Z/qnMrxZJHtbi85uC2X4An627d
         nyDuwrwP4deUZOEobHgHwZgqDwwLGyIS+uhtiqcZMimFOjzsUxH1e3sG04Ie7woSFYiw
         fBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719356; x=1773324156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFJ/di+J1DTWnmpzI1g7AxF+qp7wWfEyM6qRiUSBeHc=;
        b=jDvrIWFs8BMoL6liy/mEoLA8p9Xtsbo+UZNumRO3NOO8Xc6jLBzlcDay4VDHb8vSne
         7aVG2tq37bQmqwhJsYvkNNpFBS1ERljHZ8NV1pxpCogxb4yyimGibArASUS7AkFx+tKL
         rxMKiVcfN5+ZXyQoFa5Q+LP2V4D36x10ITjasBvLX/lVKVRzOmduXLajEqXcqQru+HlY
         PPYEfrdN4v9Apk4oEe9s5mTm+SdzA108tD44UHLR+d3uNSe1ynIiWmgSrvnToGOmdfRZ
         slMXT/0fMbnP0ZPJAx8ZoYOLeU+iDacsDGfVM6Njw0sQ1q/aVPOz2FMZhaDhE3X/pkpS
         OBZw==
X-Forwarded-Encrypted: i=1; AJvYcCWP4LpUChG2dzRFs9v7BkmMhHPDTGqAVPDu7+HTCRcV2eqy0gkLEqDeqBA5kk7au26ibdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlejH8xY2SaAyfwhUrX2WZTPbdu2xrz3XiRD/XuTsSWOf6NwNB
	xXStABFCL7JZhZydRVe7ATcae+m3EJbTrC3npflx9mlnzR/UpAqmlqrr
X-Gm-Gg: ATEYQzzdi5DNjgjLQGI7iepvcLTg5Lbq+NCyyen6lrkaIgC60TaFrosL1L1zSjj8/4q
	wqeuDVrZLnQUUCBfs0VmsLnLCLOOm/k4u1LwEiuX8a8jan49hiWM8vJWzYviyb/4ikI9t02RLjc
	C4kvQB0U8V51buoLlxfFW+MsNlRSoaDh5FFPRgrWKGZ55O8TCCZdE+iy2XX9WmUNNGLBGwMRlrH
	0H69eH/6xv2CwqhmiGqBD/K3QHUYO8iiHneMAO9Ut/adl0xsL0k7BAiMbM0JijuE15FJ8sTgz8H
	YTMDqaJbwCH7LKl91Ywp0FfaEPvCjGW15xxAyhuJQqbaCuCp4FrK3tmpZgNJZw9E1dv47lXyQ5E
	dhclMvHYrRfrgN4voqlCekhFaOnFcLMwvijmhp7YIcs3nZcRN8uemsO10J2JmEDT1C2AvtonW
X-Received: by 2002:a17:907:70a:b0:b8f:a729:2393 with SMTP id a640c23a62f3a-b93f14787d5mr364919866b.40.1772719343352;
        Thu, 05 Mar 2026 06:02:23 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439af926c53sm44322342f8f.8.2026.03.05.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:20 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 08/23] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <aamM7Ny7W-dhpuwe@krava>
References: <20260304222141.497203-9-jolsa@kernel.org>
 <bb15f21a9af1489fe2cee94afb78dd423be2a7a77b3dee5ed8b286dcef45f034@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb15f21a9af1489fe2cee94afb78dd423be2a7a77b3dee5ed8b286dcef45f034@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index e2f4a15886b0..c42bf16b6807 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > +int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> > +{
> > +	struct bpf_tracing_multi_node *mnode;
> > +	struct fentry_multi_data data = {};
> > +	int i, cnt = link->nodes_cnt;
> > +
> > +	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +
> > +	if (!data.unreg || !data.modify) {
> > +		free_ftrace_hash(data.unreg);
> > +		return -ENOMEM;
> > +	}
> 
> If data.unreg allocation fails but data.modify succeeds, only
> free_ftrace_hash(data.unreg) is called (which is a no-op on NULL).
> Wouldn't data.modify be leaked in that case?
> 
> The attach function handles this correctly by using
> free_fentry_multi_data() which frees all three hashes. Could the
> detach error path also free data.modify?

should call free_fentry_multi_data, will fix, thnx

jirka
