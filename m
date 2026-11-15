Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775282;
	b=DoEKDwHY0GRCktfgrIBMsO+mbu1YqBY/RCMhIWxn+y7Uo1ZsL6hMirfneSG293MRlqqx
	 AwHujYoV4QMujAcVFth194B37P+e4jhCx0/1oHnL0T8p/9lh1U7kJ8/Q41xTqwjWpG04c
	 +JFlTHtS/n1hmKFS+yTsl3/othM3cRg4v+gQgb62o3IJm4OGfYwO6SXs9WUbvm91Hy19a
	 +v2uhMW7vmHUZhq7LCq0PNtwgxwShNTUq2CdJWmxZVtrEENtICcrewru0bwgp7GNe8Tzm
	 jEpK1sn+WqRU933p4Y6DfC/kSlL+oTKHrFw37Jid9gW/gGluPrCILfQCXUuKTwP/JRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775282;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=j6QuVQ/V2TjNZs/GRr+VDJl+cKN+8As7oM1LWfbxkn8=;
	b=WbN8BGDVeBztvkrnLr9ELUWVjUg/N192By3t9m8op3R9vS40XmecNzSmE5PaJN9DbhMl
	 v4DhtXRPAiAeuNv7i5KBTDsKUEEdC0o0WFfhxAgs+aJIyIFJT4lDfXBDZ0P5YtdEfzUqk
	 avILxD3CqbR9c3JdDVpfh8Nsa9V2pzDLjJEcHIAPRdy3QcAl+JACQk1WVCArzSnsLBl+V
	 92ztQ9cntZhS0V4CxBA1FStxnN1G8hEH2q0WJEW6aPUArbQMrb2iYIrdWaaeqgg/vhj3p
	 P8jYjE6SSKN0coDwmwp59aWAAJ8Avrei2GOrmVGbT5jRapy2fUYKZ6CtQCuXdrpJphQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=s801Uvc2;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A667606A323
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 20:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A667606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=s801Uvc2
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 85ABA14C2D6;
	Sun, 15 Nov 2026 21:41:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794775278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6QuVQ/V2TjNZs/GRr+VDJl+cKN+8As7oM1LWfbxkn8=;
	b=s801Uvc2OlaASbdIuKuHv01dopIOJmSEinpMlzaBoMv0NX/AhQTaWDlW5uO4A74jPrgNrG
	tB8dv6htrpzeqw/gNtTPMM2lMd+X4aacMaYERHGxXmNsbPdGOVR4QpSP1wiWTIpWLwHjr7
	QeJh83yTAceVRfOcdnYkzpmUADMqfMv9YmE9MfA26PNCd26fDFQR2xGTgfbikPuD59ExFH
	KLejwFHn1QCtp/W9sMced9IeWA+SES1Fntrj7etSTJYFJgt1syZct9fczqs7gH2HgyOiwi
	iNG31Xd8jMFbZ5s20RlWi61+n2R2t3WM0wbtO+KfMp4Lo+5dOkWY9OZFQy6XLQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8b842fb1;
	Sun, 15 Nov 2026 20:41:15 +0000 (UTC)
Date: Mon, 16 Nov 2026 05:41:00 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer
 libbpf
Message-ID: <avoY3KOmyKGifeau@codewreck.org>
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
 <sashiko-outbox-215783@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-215783@kernel.org>

sashiko-bot@kernel.org wrote on Sun, Nov 15, 2026 at 08:23:16PM +0000:
> > Link: https://github.com/NixOS/nixpkgs/pull/570639
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> [Severity: Low]
> Should this include a Fixes tag for the commit that introduced the strict
> swapped-endian header size check:
> 
>   Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")

Err, yeah, I guess that bug couldn't happen before support for
endianness was added, but it didn't work before either so meh :)
Feel free to add when applying if you think it helps.

> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 231b07203e3d2..8f3f942eda704 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -198,7 +198,7 @@ static int btf_parse_hdr(struct btf *btf)
> >  
> >  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
> >  		btf->swapped_endian = true;
> > -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> > +		if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {
> >  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
> >  				bswap_32(hdr->hdr_len));
> >  			return -ENOTSUP;
> 
> [Severity: Low]
> Can relaxing this check cause out-of-bounds reads and writes on
> btf->raw_data when parsing a malformed cross-endian BTF buffer with
> hdr->hdr_len > sizeof(*hdr)?
> 
> Previously, requiring hdr->hdr_len == sizeof(struct btf_header) together
> with btf->raw_size >= sizeof(struct btf_header) guaranteed hdr->hdr_len
> fit within btf->raw_size.  btf_parse_hdr() still computes meta_left from
> sizeof(*hdr) instead of hdr->hdr_len:
> 
> tools/lib/bpf/btf.c:btf_parse_hdr() {
> 	...
> 	meta_left = btf->raw_size - sizeof(*hdr);
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115200505.1494710-2-asmadeus@codewreck.org?part=1

sashiko apparently picked the v5.10 tag, but this bad sizeof was fixed
in commit c825f5fee19c ("libbpf: Fix BTF header parsing checks") and
isn't a problem as far as I can tell (that commit was backported to all
stable kernels, and header is properly used, after endianness swap)

Thanks,
-- 
Dominique Martinet | Asmadeus
