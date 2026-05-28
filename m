Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746723F1ABA
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973845; cv=none; b=Thg9u68H1GQnhmPgEQUoQ+hTmd2/kGPZf3/Jj2FJ7XhapQE0l6gIAbG3wXi3WXfggQSAf6aQFat6RPFIzh3Nsmdm+7JKtNIhD6FoJ05ydzrGWXgr0Cj9WNSx8cR4hEGWgkhU+275oJS7UKxxifTOTeIOyzxMyK2KD2UCuHih/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973845; c=relaxed/simple;
	bh=3vm6bptRUoPJ0BqubllYsw5R6jTU9tG46Eq6kOki8BY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWkVH4aByhw4w+mLD/U+y7Qs8Xb/s+aBW4IL9Fc9sytL5B3XVSn7NPnJMLHPxA3iqdnUCxN6TDwMWE5VMQrYAfbHewmcmW9qJJShShkSfiVoheX2bybC3SMhU5rzsVMKz3hr+z/kfoq+lhrCspkMTYV9s3E/BWQ+1q1PjC3IQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzXm2Nl4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzXm2Nl4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so57469165e9.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973842; x=1780578642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ao6t/fCIiGiF4MwvYmNnn5lfP8QPZOM2rZFPbwCZ8Q0=;
        b=lzXm2Nl4fFw8X0/MYN/n7+t8cA6HHgbin+Aq/ABe2oKIWQtrl0P9fklvNjxADSMLms
         PWbnKuIPsM9/ZEf0bBwl2010jS/vDmI0SIfSjLYr8atfceLdGWNfSZw9q6lKLe9Mb6qP
         oedheLG12ssOPb/Flm06q0HIR50TrvBaNeANnMaLlFnHVGZyaw/cXd64vqiQgmr6RTBY
         RnQdjrcHbQD6SMQYnvRYgxRxKBJ7CqcqtzdqLLRrG8axIa+UWfgu+hm7NwYrZ+bV8Fbe
         0nQUPmdOxX6C1GklMlJnNNSf3jlPGtRTUzL9AWFEUXrpsi+gVDYOq8apBMpokUTucUzQ
         abOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973842; x=1780578642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao6t/fCIiGiF4MwvYmNnn5lfP8QPZOM2rZFPbwCZ8Q0=;
        b=hwrvCQuH9Ehb7wgWe0n0G7H3RhigRvL9IDenpZL0ISMlgyEIGAzzZwDiwZD9q2b4zn
         TGPdGyWWCL3Te/6BqjKDIlVi441JSA75SJx4CpoRqQulLC3pfLwpLQ1YdZYGy0z3vx8J
         9k6vl+0uSCh4+uDUgsqdk1nRts0V3ANWgzNF08nBAWD8oLkAzTlxSh7gwpwoexZNKhou
         41/ZhE55jtALSCmCmwQrt3wF1pkEBLHYZvEPp9vKCN/9crEVRecI7g2Yjk3U3i8DWPYA
         Bm2hQVNq5FHfPeNQVirymLDg7nSPKZXUrtvMNWtavytkt+STKibuA6Td2xUMyY9TV5Oi
         FaWQ==
X-Gm-Message-State: AOJu0YzHPo+4kBk+zqRRytVYvwhURIImQhwDnSgBTbm9sq2bOMzPJZ4G
	9pcAKW4+vfE3CjHUQmlKzxzjf8cTbjBk3qYBwD8SZuufEc64aiaoLFdBSvU5uw==
X-Gm-Gg: Acq92OHrPkaKYHLG8xOBRZVo2EwL2r25L2FzlvsLvU9iRdds9Y/UfR7B7H3eH6RM1+A
	g6loxqqhe053Zh+jbHX8Znvo9/j7BFgoiXvDKTay1s1fqG64cYNnR/1CLW4Um7bSnjiyl7qC3cj
	HYerabM5fVrhTNjcQQl8B3z7sAXa3lB535+nQZgJeNNZQ/7Ra6koVPTPfobMg7I1wBbvGw4Dh5d
	gzqEv0jACEv4R9MSarACKKmiGbEFNV5fvXNuw0IvNJowbf0rS5h10DjhH573SiNAj2I0IQBybo0
	SsYJyY7GeFt0DWOkU1lbNkoOD0TIuEzhB9ueX5T3JcNVLM0WAykj/xa18JP9U9bK+Uw/G1Ookmp
	exIsvHdjI1mJG1mJeGr4+Otsd2Yu3MeAfON4iI0pgbiorj2hFHay11qQjZvyDuKUYAySbrtfIK3
	uI/NutiXoZSeIoZpIrWVyb7sVj0A==
X-Received: by 2002:a05:600c:4fc1:b0:490:7227:100 with SMTP id 5b1f17b1804b1-49072aa14b3mr204899885e9.18.1779973841504;
        Thu, 28 May 2026 06:10:41 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908e0cf459sm21869105e9.5.2026.05.28.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:10:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:10:39 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv6 bpf-next 18/29] libbpf: Add bpf_link_create support for
 tracing_multi link
Message-ID: <ahg-z_VOGlpEePfu@krava>
References: <20260527113951.46265-19-jolsa@kernel.org>
 <20260527120906.1EFB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527120906.1EFB61F000E9@smtp.kernel.org>

On Wed, May 27, 2026 at 12:09:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch references new UAPI constants and struct members that are not defined in the corresponding UAPI headers.
> --
> 
> commit 950db3ba53901f76f22567de80577ef3f82cd57b
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Add bpf_link_create support for tracing_multi link
> 
> This commit adds bpf_link_create support for the tracing_multi link by handling
> the new attach types and extracting the tracing_multi options from the user
> provided bpf_link_create_opts struct.
> 
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 3cd7058023304..ff342972ca4a4 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -843,6 +843,15 @@ int bpf_link_create(int prog_fd, int target_fd,
> >  		if (!OPTS_ZEROED(opts, uprobe_multi))
> >  			return libbpf_err(-EINVAL);
> >  		break;
> > +	case BPF_TRACE_FENTRY_MULTI:
> > +	case BPF_TRACE_FEXIT_MULTI:
> > +	case BPF_TRACE_FSESSION_MULTI:
> > +		attr.link_create.tracing_multi.ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.ids, 0));
> 
> [Severity: Low]
> Will this compile without the corresponding UAPI header updates?
> 
> It appears the constants BPF_TRACE_FENTRY_MULTI, BPF_TRACE_FEXIT_MULTI, and
> BPF_TRACE_FSESSION_MULTI, as well as the tracing_multi struct in union
> bpf_attr, are not defined in the UAPI headers included in this patch.

it compiles at this changes, uapi changes are there from earlier change:
  bpf: Add support for tracing multi link

jirka

> 
> > +		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
> > +		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
> > +		if (!OPTS_ZEROED(opts, tracing_multi))
> > +			return libbpf_err(-EINVAL);
> > +		break;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260527113951.46265-19-jolsa@kernel.org?part=1
