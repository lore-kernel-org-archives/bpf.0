Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF2344DAA
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007758; cv=none; b=pRK2c0QCiDrLQQsdfvbXPY5vg+ulFYX7zA/bbJTOkzFcUGnWJkn0V72vBRRZguLDWSaby+dEeRXW7+jlDoz9wy7iKTL/n+Qqx5jaY8RTUfVwxP8cBIkFkNQlOVZEQGlrN36PBvPosBvCufrimen27FqkQSkSL5DL5HBflrZMqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007758; c=relaxed/simple;
	bh=z+s1HjJSt6mJsNzFnUqUWm+u7DFxieksUZXRU+5Fx88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsFzyllheXkmchw5djP5trgSPIcpfviuBk3BTwN2GLxj/XB7mZ2ktebuRPh/sC3DIIQeKYhwDrL4Q7NOk3tz4M6/VBsczvGaN1bOPbwLuOTGFzdvUCwFm56LFvIAcTmtnokdY3kujXWzTlEqcUKoY6F3Y4hKRJVwYaNnluunoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjwozHrZ; arc=none smtp.client-ip=91.218.175.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjwozHrZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z+s1HjJSt6mJsNzFnUqUWm+u7DFxieksUZXRU+5Fx88=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791007753; v=1; x=1791612553;
 b=kjwozHrZxqAGBc+vF4B6egF2YdXJ6qh74THrOcpJl99YWI7Ep45/Od1O6SFrb1iG+zFKxP6E
 GO4misD10zBCcNTdd3rz1zdVFEijjpf2ORIuafvYq/iI7Sj2qDbLMTNNr/xohFyovkAWIssIJ2H
 XV140CpGNVhsg9DKfVBY8d+0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 590d76db49ba2a4e;
	Sat, 03 Oct 2026 06:09:13 +0000
X-Mizu-Trace-ID: 590d76db49ba2a4e
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 14:09:06 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netlink: specs: rt-route: describe lwt
 BPF program options
Message-ID: <asCcAgEz7gzg34Dy@fedora>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-5-4106c21b9ee7@kylinos.cn>
 <20261001015135.488BE1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001015135.488BE1F00899@smtp.kernel.org>

On Thu, Oct 01, 2026 at 01:51:34AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] netlink: missing max-len validation constraint for string attribute
> --
> 
> commit f56da32d0f53d2458e2f20c65435e7f6e11b64a4
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> netlink: specs: rt-route: describe lwt BPF program options
> 
> This patch replaces binary BPF attributes with a nested lwt-bpf-prog to
> support lwt bpf prog options in the rt-route netlink specification.
> 
> > diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> > index 7649797602eb7..afec0375661f5 100644
> > --- a/Documentation/netlink/specs/rt-route.yaml
> > +++ b/Documentation/netlink/specs/rt-route.yaml
> [ ... ]
> > @@ -621,6 +624,16 @@ attribute-sets:
> >        -
> >          name: hwid
> >          type: u8
> > +  -
> > +    name: lwt-bpf-prog
> > +    name-prefix: lwt-bpf-prog-
> > +    attributes:
> > +      -
> > +        name: fd
> > +        type: u32
> > +      -
> > +        name: name
> > +        type: string
> 
> [Severity: Low]
> Does this string attribute need a maximum length validation constraint?
> 
> The kernel's LWT_BPF_PROG_NAME policy restricts the length to MAX_PROG_NAME
> (which is 256). For netlink string specifications, this usually means adding
> a checks section with max-len: 255.

Why we should use 255 here? The bpf_encap_nlsize() alloc size
nla_total_size(MAX_PROG_NAME).

Hangbin
> 
> Without this declarative constraint, the generated userspace tooling will not
> restrict the string length prior to constructing the netlink message, forcing
> the kernel to reject over-sized strings. This bypasses client-side validation.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn?part=5
