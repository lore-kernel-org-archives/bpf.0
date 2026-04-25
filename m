Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64502D780C
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152976; cv=none; b=oiwcPK9PV9zXWB4V2h22uvCG18628cSBuZENm+MsIzc1qk5+WYYpxPxro1L5nvu1K7PsyLyKaOiHigJKysWGZhDxd9DPny59VMyzK46CCAgv3OxtomA3vNa8KgT2gdz9KWmBn21DytCklkHPQ0QtgpPFjcmp7lj4xE7CsIPbJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152976; c=relaxed/simple;
	bh=Z0YzqWMlyuXEw5GI7qnAncDlHXyo54uD/vF5cUX9JJQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBF1vFDUTwOMext6mpwY2OBgcPmFTbYvnmKoL70PAl5akeUUYe3T1CA1Asdj55UyJTdTJaR8Sl7NhlGBzmlWYZ6GRPzqEIwHeqQB8+D1PWYDaD40PdxxrcoPbHVMDvQYY1wIbB2LIEb/0FWDPDQN/qv/WLH35Us67NewzGqCcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDKw+5Us; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDKw+5Us"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso4406468f8f.2
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777152972; x=1777757772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPvvuHT4BIje6LaVEfoufdvGdTAK6IPqsxqsTPk9OFQ=;
        b=XDKw+5UsGUM1q5N+tavwMff+RcGagMNeVLa5htTkpmDMNhR63EKoNKqxJBfnKoPeka
         wnxDKjxrPItmWVjnHur5Zy8ZGWbw8GJIHuaFQbUWNPi7p4GK+tzbrwbxNt4Tr6/cagaI
         qp0QugqSXYqKemmOlzqNpNxGVjZX0HSZPWWFDDztXHve/YKn1hLVfxkPRekmd2DZ+Xed
         pPOqPc3vqBCQGmACYjNr80FnsfvUhLKd/OEyOE+jWOlBJZL0NCohXbp+SwUFCUH7Xa0d
         LZFKqy9gMtTr/5GebtqNaKtH+p47thqQKktB3/Ix4j8xh/WsKDQZjD3/GLGchbxOVYFl
         5Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777152972; x=1777757772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPvvuHT4BIje6LaVEfoufdvGdTAK6IPqsxqsTPk9OFQ=;
        b=Z8UArYjWAEmqNOCrnXm1aTIl/xAeUMNaMRmjCKPOKkk2PuFijytUwm+33ztGBVIlmS
         nOtjyQfhH7/SkS0b5dt1yYMlHopmvsbm91EUMrg6rwAmsaI4jfxlczeNf9QmU4FsLNNy
         CEN9xENzhbP7OKUbmbVidWrAdrE+3/9N3vsjJFr0eEsT7CKb8tV0+s/2/yovei1fJZi5
         BHrsVUQ6oi6OWEHGHC8/h0M9EXs+r/r9wvAD7OOzOkRR/MZ5bzhjuuyjCOeSOxg2H5DL
         qyhR2plxyi4fNdMy59W1EfWTbZMSaF1KFPWmWsmH5heRa03GaeFNe1VtOlIqY3PVYFJu
         6H3w==
X-Gm-Message-State: AOJu0Yw50xlzpfLF+fAOyKYWrsbRvRIGLCkTtfwun7pGEh8kGS7xTOzs
	Zde28H/sHX8VL4/Uph7N9PTmEGD3IDwlGQTHRu75kK1ODt0RX+MCMDsY6Qd33lBN
X-Gm-Gg: AeBDiesFcvBBCbcXck2GtuRHlTOQ32rtztvScEEOsFrUpE4OBUwq/RfAnPSkwEtq9os
	wx17LoU07RtESgvKC+dBLzzK3QWxhyD1v8LcZeVHkUKmwaEK85hDPn67RnkvDZT4HjdszbmETMY
	Jk2JiPc8oiVkt6WNUr5NFo3LpUWah83iuOjKW8k58H2+/Ub8c5vmnRALGgx996NfnynRXXcfjBB
	y8FF8DDVSmDc9n2WuZLPaEKMZsgRXaVa4zH3lBmdF7t09FxWwC2vimq2KbWrqpJUuQ8ztA3tWRh
	Q8Qcljfa17a69IsZmnrTkgQ/vnKhJrIQSL55gstsD7kRX+0I0OW0DCZKmvLw9De0xnrKUvX4fh0
	FQ4L7yi1EdCfnoLEIjDGkL35hGSOmK8O9vxf61XWanqz+jPp7eoOIZiZ3/PbcSuQPesGtQ1x/PV
	sw8KbucbfLxzEeqiPaE8U/kA==
X-Received: by 2002:a05:6000:2888:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-43fe3dc61e3mr57210523f8f.17.1777152971619;
        Sat, 25 Apr 2026 14:36:11 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm70515228f8f.0.2026.04.25.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 14:36:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 25 Apr 2026 23:36:09 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off
 unregister error
Message-ID: <ae0zyVXs6pi4Ip1x@krava>
References: <20260424153905.354922-1-jolsa@kernel.org>
 <20260424161232.1B14DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424161232.1B14DC19425@smtp.kernel.org>

On Fri, Apr 24, 2026 at 04:12:31PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Critical] Use-After-Free of BPF programs due to leaked trampoline image
> - [High] Permanent memory leak of trampoline executable image
> - [High] Use-After-Free of ftrace_ops and bpf_trampoline
> --
> 
> commit 3c4d55e24f28fa5f7f6dd937603366805532d1a4
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Do not release trampoline image in case off unregister error
> 
> If unregister_fentry fails we still have trampoline image attached
> to a function, so releasing it could trigger crash. Releasing the
> trampoline image only when the unregister succeeds.
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index f02254a21585fa..01082ecc5c4f5f 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -618,8 +618,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
> >  
> >  	if (total == 0) {
> >  		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
> > -		bpf_tramp_image_put(tr->cur_image);
> > -		tr->cur_image = NULL;
> > +		if (!err) {
> > +			bpf_tramp_image_put(tr->cur_image);
> > +			tr->cur_image = NULL;
> > +		}
> 
> If unregister_fentry() fails, the ftrace or fentry hook remains active because
> the image isn't put. Does the teardown path, like bpf_tracing_link_release(),
> still proceed to tear down the link and free the bpf_prog structures?
> 
> If the BPF programs are freed but the leaked JIT executable image is still
> attached and active, could subsequent calls to the hooked kernel function
> execute the trampoline image, dereference the hardcoded pointers, and execute
> freed BPF programs?
> 
> When unregister_fentry() fails and bpf_tramp_image_put() is skipped, does the
> error propagate up to the caller where bpf_trampoline_put() might eventually
> free the parent struct bpf_trampoline?
> 
> If the parent trampoline is destroyed without freeing tr->cur_image, does this
> leak the struct bpf_tramp_image and its associated JIT memory page?
> 
> Additionally, if unregister_fentry() fails for an ftrace-managed trampoline,
> tr->fops appears to remain registered in the ftrace subsystem.
> 
> If the link teardown ignores the error and unconditionally calls
> bpf_trampoline_put(tr), will direct_ops_free() free tr->fops and tr?
> 
> Could this leave the ftrace subsystem with dangling pointers in its internal
> tracking structures, potentially causing a use-after-free regression during
> subsequent ftrace operations?

ah right, released bpf_prog and bpf_trampoline will cause crash later,
maybe we could just inc bpf_prog ref and skip bpf_trampoline_put like
below for the tracing link release

jirka


---
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b1f0ba02f61..c609f15b146d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3505,9 +3505,12 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
+	if (WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
 						tr_link->trampoline,
-						tr_link->tgt_prog));
+						tr_link->tgt_prog))) {
+		bpf_prog_inc(tr_link->link.link.prog);
+		return;
+	}
 
 	bpf_trampoline_put(tr_link->trampoline);
 
