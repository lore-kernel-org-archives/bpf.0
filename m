Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9213EC2EB
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247989; cv=none; b=aZdjUbiAhHziO/yAyamMnx6+mlzDUGoJTfoya7f9CZYVqg00bcAKvOE9jf8mfkVZfji+8kf05b9KP0lXbqDVkpWxBidYd5jToL0ywsZzJHTmBG3lsZlSAxfa+Uk3cNpI/2MZlzY5NvkJY3SF6iWIEWcoM2ahY5ERJ+IkemY6ptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247989; c=relaxed/simple;
	bh=MITDOAia5eJhfjXhLrqLbCq+ZSfqGPMEtPD8YXKKS4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pkJ/ONxZnXtXy0aleYXgio4+R1q7xmT4jMgZ9F8xWR++YqyMUAqhogp8riZ7YYOyaARYHHTwK7BADbetMbfNMUNjZMTliW3/UG17cPqMX+QB/1LdXrTUzJx5YmPmHiHS/hNC+YQaEOBfahf/j0y4R/VsSPAW+C8t0RJl396L/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP7TF7ae; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP7TF7ae"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3660b84347dso1106157a91.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247987; x=1778852787; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MITDOAia5eJhfjXhLrqLbCq+ZSfqGPMEtPD8YXKKS4I=;
        b=gP7TF7aej3JdJePfZs7xw9Z6LA7ZrfRq8RBYSgmkEuqe5fiJdypTYPP7M6GXfk2smu
         XJCn3sIXQ+zzqie+QHbc3IEEM+XY+ccZOEz58uIVvRxKH6SoaIbF6IlsPRenNlh2DxDt
         LQVuge26zdERTQkfWYGUuiTprIDH8vN+2Mqh2uDwZ/cBFjMuUlj6tGS6MKPBfM8QQfju
         LLcQpjQYWNOezFWXSETYkhkg4ofkQ16imuEASvLH0sbcRceDJNAMeiqv1Xcr58XULd+C
         YdCHJDCThAp3uhtYac7Ouj62v0bP77SAvpp+li5xm1lM6IVKXVU26cosKBo3NuXybiXa
         U50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247987; x=1778852787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MITDOAia5eJhfjXhLrqLbCq+ZSfqGPMEtPD8YXKKS4I=;
        b=UMzKVHfPRfbYQIDgYjjUwZ4XUyYRa1rTSBDgMuMm4+83Jl7+E9xhYnYfoTi44RKuKP
         pq/ru0kEUwZCpij4gjgjqsMf305u+Tw5FnyUKrmkO8scYbPsSVtU1BmMMUb/JAaiLGGF
         7MCQJoBEyxrp0cf/f4SCeQZwIZgbQqQEg+b/kEAZqJrOAMD/OSg6AKY9DvMOtYc7y0Px
         h7rkP/DqiTToj6bdg7Aw/ExfIPSZjN9KjlDavpTk+CQReLLCKxuBr08/tj6GWydUiEvS
         7Qf3SkRNBDdLOEtmB5zRnzoNg4XbY68U4Vi5tJy0oSfOH55NMdx01UvhZ53YoBZwS/5V
         TN3A==
X-Gm-Message-State: AOJu0YyxXjCv4QBujsZOM56jrQYmsmTyt6L0v8b/UWENIeg9FBm2/z5S
	IGj2HyJSNsUOH75gDkBZMhHTCPWcyM+XGaFCZP08YKOPrDzlpAGPMIi1
X-Gm-Gg: Acq92OHUtHLhy+3YINPVq2SGKwhP/6jrKEq+DAF/kT43zd8IL/1+/RRqGwyyV/JWzJ9
	rmUzMk7HN5Jdlp/P85v9gNULWm16faB6G39gF3yZzk4bma7DDia3rsn91o54W4n1BMvwTufBiGq
	fgsEPQPKKQ1WNHRFPHiWcDOZSwMpIoNibtSBGahNeL21v40Ie6BRkN85fIykCqOW7pxk6N+8IOg
	aOZ4ECar9g6ABBdS7qA1427neMOOpjMyTShiXzGmHT6sMo4eqF3QeLu23Re8Sgc7YphzZUZ1S4w
	JTO+fFufraltREU4meqMYiNSu+Ktk+xsVVt9QlShO1ahowxJqsMtG1mdHEWJmTszoI6QOVgykrI
	lvi84e/8s+d2deYfqNaPUdFs4VqkzAvUPFl1K6NA1ECyZu7eoWuCZRgcXLw18qjY25F2CbTfzUf
	DoG0frYwOpTZeA2zz93bYoSAU57Any0nwNam1CgpTp1wkEcvByLxw=
X-Received: by 2002:a17:90b:164d:b0:366:346a:6891 with SMTP id 98e67ed59e1d1-366346a6cf8mr5235008a91.16.1778247987050;
        Fri, 08 May 2026 06:46:27 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da5d5fcsm2318316a91.5.2026.05.08.06.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:46:26 -0700 (PDT)
Message-ID: <639f1b0f97330c98668c00244c0a7bae19e30e3c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/14] bpf: change logging scheme for live
 stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Fri, 08 May 2026 06:46:23 -0700
In-Reply-To: <af0gXEqD3FPFYZDj@mail.gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
	 <20260410-patch-set-v4-10-5d4eecb343db@gmail.com>
	 <af0gXEqD3FPFYZDj@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 01:29 +0200, Paul Chaignon wrote:
> On Fri, Apr 10, 2026 at 01:56:01PM -0700, Eduard Zingerman wrote:
> > Instead of breadcrumbs like:
> >=20
> > =C2=A0 (d2,cs15) frame 0 insn 18 +live -16
> > =C2=A0 (d2,cs15) frame 0 insn 17 +live -16
> >=20
> > Print final accumulated stack use/def data per-func_instance
> > per-instruction. printed func_instance's are ordered by callsite and
> > depth. For example:
>=20
> Hi Eduard,
>=20
> Sorry to revive an old thread.
>=20
> We've started running a kernel with this patchset in Cilium's CI and
> noticed a big increase of log verbosity for BPF_LOG_LEVEL2. To get an
> idea, a full dump of all (uncompressed) verifier logs for our
> tested programs used to take ~8.4G. With this patchset, it now takes
> 15G. [1] helps a bit to reduce it, but still only getting to 12G.
>=20
> The increase seems to come from print_subprog_arg_access(), which prints
> full functions with the results of the fixed-point analysis, from
> print_instances(), which prints full functions with the use/def slots,
> and to a lesser extent from compute_subprog_args(), which prints the
> fixed-point iterations.

Hi Paul,

Do you have a break-down? I'd expect most of the log to come from
arg_track_log(), as it visits instructions multiple times
(although, convergence might take only a few iterations).
If it is a significant chunk, I think we can drop it completely.

As for print_subprog_arg_access() and print_instances(), as you
suggest the output can be combined, such that the full function is
printed only once per call depth. This combined print-out can also
include results of registers liveness analysis.
=20
> I'm wondering if maybe there are other opportunities to reduce
> verbosity here (besides [1]). Maybe we don't need to print the
> fixed-point iterations if we're already printing the results? Or maybe
> we could put the more detailed liveness-related logs behind
> BPF_LOG_LEVEL3 or BPF_LOG_LIVENESS?

Had this been a normal compiler or jit engine, I'd vote for
BPF_LOG_LIVENESS log channel, I'm not sure what our stance regarding
user visible ABI here.

Regarding BPF_LOG_LEVEL3, I think that the original idea behind
BPF_LOG_LEVEL2 is that it would serve as a "debug log" that regular
users won't need to consume. What is the motivation behind collecting
level 2 log on your CI? Is it to infer clues regarding programs
hitting 1M instructions limit?

[...]
