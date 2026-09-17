Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72F33E37A
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682409; cv=none; b=ScIIL+NR9L1PAEa6wrr1o22d38f6Aza0M2B6Kn2uPVBsJjhKGGwuyMnp6UikEM8eYh8NjMaY/i7/MGPqng+iUTn7jmNc84xoOajzbmQTwTctkA3kSCDb/k/VHMfgUNe+5y20A7ELy54PDXALZ+OLH9vOg0cyTnrFhAQJYxfd6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682409; c=relaxed/simple;
	bh=OsSazUJ8wLWbeIBeRpfjevFAuqgoHWsmtVfDnURblJA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWxYPgM3wgVHqzByYWiahFtpVdXmm2UM+AaYkehtj+rXfnO/+L6ATuc2XmWxb+ACXxRyc7ZODgC6XEIKtKNB4Voz1DWGqXGrFCNvb1MxsMOpaPUARKWt1htwCYuecEKs85jR+bmPd1CpDbXvd3htQ2KVwGjUiqn+f09K6UuEJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq4nZJbH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq4nZJbH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so627015e9.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682405; x=1790287205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ExB0mrGIuQbQ1DaTBOid2T3+dFxJKCVDJzhrHmXOhJs=;
        b=Oq4nZJbH9bhXC1pS5FV4jPkzltbnA2OSKQ/njQa6HVrLGSSNgS/5GawZ/UifvKkPgQ
         ds3tRk5ge0kgjmyBU7WHin/k5KNkCcvBSkstZhAALzU7DIhDeoqtRALW9qvSJrAw0YMJ
         i//Ah4zJpoB6qExigrUeD4FCaQPgby+pMCllYYx2Edhx5+RUKtsRbBcACnEkoiLQf2E8
         d4G8B9blLk2UafKP/SvIi0RdanU2ThfPbeFgOX9+Dn63EHfThdCfNhkIqk16Uoz4vFs3
         8diLpx6DBNfVj+jcKkZ3jF7sIm2tRdsZQhcK6c+UbgEZjIk+8j4XVkoIIBV7/THfm3RX
         3UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682405; x=1790287205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExB0mrGIuQbQ1DaTBOid2T3+dFxJKCVDJzhrHmXOhJs=;
        b=hgz8ff3fy6FmiGRQ5nseR9ViN1IIDvcoRJRbbtj09RyvEqJOjNgNdmAlT8Exs/1HE+
         hZnXwJmh5S9pKAXM65aX5/ouKE5/qLZlGE0pGvp5B6mFE2HI5LwiSTE9KHpMKYW3Dxmb
         Agd806nogXmDAfnSnkcrJKKaLPUVuQdJFiwjweHmyj3wOmRQAvv7ExW/c/bQajwXw1TX
         TzRb1VSo5htJePIvdvCTVtZ+iKMnh34ZxXUVvo0LUnFZrfJhnfPzAZ9JTL5tHBgK2c8h
         WsuYBECxnWKPqtfGWfOzBGdSw3vtqshqplHOvXWFDXote99q6hR/LOH5JexHVS88VNgv
         hQew==
X-Forwarded-Encrypted: i=1; AKwUvBx6YonptM6Cri8QTocgf5W3S/+td6OA7KB6g2LN9gUwpb69sdp33gjEW53rjdQ6J6nf01s=@vger.kernel.org
X-Gm-Message-State: AFuF++lywLR02CLHOyWZsRCGQW7W2OKo+H8iJuesJxcJ24adXT/JXqnX
	EAmWMWX/z28OPYfEoCGxcsJ+CbvcQT38z7uqHykPWwz0lP2Ii0jgQjZ+
X-Gm-Gg: AYBFou07BADyrI8gWhYrKrY+TTHVZAs2UO/QDC/zp5i+CRkc09iifplJ0QyIRZQ+MKy
	ZxcEnKgIg/sCH52mGcuW+6VJIsKX5UBVtzrcFE2F8WLCXBL5FMXcD7Ru+05YW60Fn54teb19Ll3
	r4tI9tB+WrBcTMrW570SspVlBLR8sTtpXzOQ2pYHewTXm2IxkcAnHPb5fhFAXd75Mc9Bc+IQpQe
	aHEwQJmJ7487YRXnXEmcGdarrTltYZtdtoxSXs7o0akZS/Umht4Oy92DiDEpE0X+tbz4mfRECRw
	zBYLAFl0XXTbFnQI15NiowQkdhaqcKTN6u9n9rDxNpYOBEDUfrWlHWHwnU65zVZU8zYY6q9glsk
	JGVcNg0HiyYUb0uJ0MZM9TUZJ+lun5EGC+I5PGPgzDtgIs3dRfVbC5hXo+RkpW5kI0MgOdqidao
	rTo4alGm27uPyOajACbKdX8zQM2K5yK5VFr/hMmWjuBkDElzW+5vpfNlCuMQ==
X-Received: by 2002:a05:600c:1986:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49fc56cb2f7mr5876475e9.8.1789682405271;
        Thu, 17 Sep 2026 15:00:05 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd232d5bsm105577075e9.12.2026.09.17.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:00:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 18 Sep 2026 00:00:02 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, daniel@iogearbox.net, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
Message-ID: <aqxi4p_xlBTSOtTf@krava>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <aqsTCF4uGmN5SlZD@krava>
 <0db440b3-f39c-41ee-bc77-4e3d2ef2b95a@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db440b3-f39c-41ee-bc77-4e3d2ef2b95a@oracle.com>

On Thu, Sep 17, 2026 at 09:27:42AM +0100, Alan Maguire wrote:
> 
> 
> On 16/09/2026 23:07, Jiri Olsa wrote:
> > 
> > On Wed, Sep 16, 2026 at 08:41:16AM +0100, Alan Maguire wrote:
> >> In raw mode ensure we can dump new BTF kinds in normal/json format.
> >> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
> >> const value of 0x2a and a dereference of r10 + 0x20:
> >> 
> >>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
> >>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
> >> 
> >> LOC_PROTOs render the associated values of each of their
> >> LOC_PARAMs for easier readability:
> >> 
> >>   [14] LOC_PROTO '(anon)' vlen=2
> >>   	type_id=12 value='r1'
> >>   	type_id=13 value='*(r2 + 0x10)'
> > 
> > nit, AFAICT these are dwarf's registers numbers? could we output arch's register names?
> >
> 
> thanks for taking a look Jiri! You're right they are DWARF register numbers alright;
> the problem is to render them as arch register names we'd need to maintain per-arch
> tables in bpftool, which seems like the wrong place to host those. I'd suggest instead

is it that bad? I guess it's just simple fixed table

not sure how useful that output is with dwarf registers, you'll need to convert
it to arch regs anyway to make some sense of it.. we could save some tokens ;-)

jirka

> we augment pfunct [1] to support this; it already has an option to display inline expansions
> from DWARF, so having a BTF-based expansion of inline sites there seems like it would
> be a more natural fit, what do you think? Thanks!
> 
> Alan
> 
> [1] https://github.com/acmel/dwarves/blob/master/man-pages/pfunct.1
> 
>  
> > jirka
> > 
> 
