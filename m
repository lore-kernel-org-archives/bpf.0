Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482F8472
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791008270; cv=none; b=TbY3NBPha6EuTnh4u3F4Z3HiVyZz8h1TF2IaMU92bBXVOSy+F73kduzhByffJJhYNihmZ/SVZMESmcr0OT3f+b06b7YlDqViQPSp8wCRJI3XWNyKFAxpHqyKSUkMCO8mAdTOgyrn7c1jwm88LpjoR2RCa87+NEdZHY2NF2g3Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791008270; c=relaxed/simple;
	bh=Cn3gxRbdQGSoHGFt/R4ctEUU1BHG04emF26Eenc075Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1fc7A3jTXViVStgjrtOypfmvPhEeuDzTXbA6xZxABW6wgj3FkERmb+Liy2HGS+OKyTwqqKsZAXrNAtJ5Ol8bubVYt1Edh+nK41SDOauabOAeON9zv/F95vJRzWJyCeTD5S0ILS3PyVBWAVmDAvPTkmA9AKUad0BOojmhGGIWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qocXrE2I; arc=none smtp.client-ip=91.218.175.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qocXrE2I"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cn3gxRbdQGSoHGFt/R4ctEUU1BHG04emF26Eenc075Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791008265; v=1; x=1791613065;
 b=qocXrE2IeNzKqrHFNa0PMIX9q7RzxiuBBKvJfbRUQSDEGw3ZUqZ3wxlT6vuDWvUVYlSP4BZZ
 v8Ie/uDNmeZBwR653ueiy6+uA0/rCSulGvreIbvbGBf1zhTH7SbpTG+8b7M3WLlssFHCT7hYP14
 /NcGzz03xa/JIUBVfbZ4NGIk=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 86151182d8391d4f;
	Sat, 03 Oct 2026 06:17:45 +0000
X-Mizu-Trace-ID: 86151182d8391d4f
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 14:17:37 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] netlink: specs: rt-route: describe
 seg6-local attrs
Message-ID: <asCeAciYgnEBZNab@fedora>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-6-4106c21b9ee7@kylinos.cn>
 <20261001015133.E361A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001015133.E361A1F000FF@smtp.kernel.org>

On Thu, Oct 01, 2026 at 01:51:33AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] netlink: incorrect type: flags causes uAPI mismatch for seg6-local-flv-ops
> - [Low] netlink: yaml naming convention violation in seg6-local-flv-ops name-prefix
> - [Low] netlink: missing doc properties on new major yaml spec additions
> --
> 
> commit 1d8d137d71e90b2ea51b5a3ae23d03831ee06b0b
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> netlink: specs: rt-route: describe seg6-local attrs
> 
> This commit adds SEG6 local actions enums and seg6-local-flv-ops flags to the
> rt-route Netlink specification. It also replaces binary attributes with nested
> seg6-local-bpf, seg6-local-cnt, and seg6-local-flv definitions.
> 
> > diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> > index afec0375661f5..0260fca398d2c 100644
> > --- a/Documentation/netlink/specs/rt-route.yaml
> > +++ b/Documentation/netlink/specs/rt-route.yaml
> > @@ -116,6 +116,45 @@ definitions:
> >        - rpl
> >        - ioam6
> >        - xfrm
> > +  -
> > +    name: seg6-local-actions
> > +    type: enum
> 
> [Severity: Low]
> Does this new major property need a doc field? The Netlink subsystem
> guidelines recommend that each major property should carry a doc entry to
> explain its purpose.
> 
> [ ... ]
> 
> > +  -
> > +    name: seg6-local-flv-ops
> > +    type: flags
> > +    name-prefix: seg6_local_flv_op-
> 
> [Severity: High]
> Can using type: flags here cause a uAPI mismatch with the kernel?

Right, I forgot the change the type and name prefix.

> 
> The kernel uAPI defines these operations as sequential values (for example,
> SEG6_LOCAL_FLV_OP_USD is 3). When type: flags is used, the YNL code
> generator will emit bitmasks (1, 2, 4, 8), resulting in
> SEG6_LOCAL_FLV_OP_USD being incorrectly defined as 8 in the generated
> headers.
> 
> Would it be safer to use type: enum to ensure the generated values match
> the existing kernel constants?
> 
> [Severity: Low]
> Also, could the name-prefix use dashes instead of underscores? The naming
> convention for YAML specs specifies that names should contain dashes, as
> the code generator handles converting them to underscores for the C code.

Yes, I will fix it.

Thanks
Hangbin
> 
> [Severity: Low]
> Additionally, should seg6-local-flv-ops include a doc property?

