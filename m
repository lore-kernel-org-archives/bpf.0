Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDB38CFE1
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685618; cv=none; b=iNCBGOolkS37VqAKX+oNQH3EI8Y589mzv5CyysVN8BnPZbOikpjsImz/cWTUMAm+aEmBySRBfwPE05Ov+WztgB4GZoG6H/tl/cSxQQEUBHeLuzYl4XX1i+LjyrkY3Ywmmpperjc2X1eo6tAqBSWzbqnqjTquV23ojy7pWwE20h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685618; c=relaxed/simple;
	bh=AXfXChZrE/u5AGveTn9O3Au9gGQCslusfmdQGvQhdcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuzcbjYFGuLSbWtGcVBD3IK5aacv6KOELUdTw/D0FoYt++kKOxfVy3g0TifSRa05Xng9TKnOUA71FHsBwdLMGErHucduWYHq3B6jWKZ06tE3Db+rXpHwn0dvM+HBHEdmL7U5+qncuVMGohoATvrjz5AXNm0+UFMouZn+QC8/pjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qs4MKe0m; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qs4MKe0m"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b936331786dso879232466b.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778685615; x=1779290415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdF+2d6NpV3PDWOr7PsDZMiK+EcjYF0L2JEntACtpPc=;
        b=Qs4MKe0mNpu4yOOp6tN9iHf34uS911jkZkOXBSKKeb4xjHstyOGbfIb7SRoIIXjrcc
         oKpU3vnqKd+GGIpRHaCHDEH1iJRBLmEk5BibCITWqXa+E4erPV8OsegueXcsCvJyAcva
         GH/Iy3HosJDbTxJ4kg18WwfYvtJL7g7+EvsqY1DcbBZopJaBpkhH9RpyWN9bjkvcuFK7
         6y5Ov52VZ+TFdqmmt+8I/eYYdLkrvWkW7Sw4xPeR8fzJJV9Vb3uCUpCWSPK3RNmUKUeQ
         mD+PJXDhIYvWyM8Hodm5NP0XnLdlEMN4IJjTqkClOtqfpVEQcan/F6EZVPAIANxPr7rI
         7nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685615; x=1779290415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdF+2d6NpV3PDWOr7PsDZMiK+EcjYF0L2JEntACtpPc=;
        b=Ew9o28Y8n8UY5dXjqQElie2USrjog7vJ/iw2TXICSQIejyogNCSbCMu7BoTGJHIh1p
         6fGb8bnI55LHQTD20IjXT9iYztJ8p8n6SnbqHuGzkPXlECMsi2k6aVlkoNFrAW43EdC6
         uoSNrnvZwueFpmgYtKvCMhgT81na3t/jhRf7wqikvSL873a0KUGwstrEkaKhtaiKCEpi
         RJNkkP2br3L3MGmCexyljvkh+4iTuSAbIigvKUeNy85jXLd2jfQOo27raKaP35zHW9Ik
         DdoW6O20blUkkc+2HjPVUWBqBvXUkggNCUpjvIoS0Ow1zHz4IcaQk3+7H4j9tXLBeYHK
         rRFQ==
X-Gm-Message-State: AOJu0YytZ0cjYLhk04OSiF5p5mnizXrxmQIkjqTIedh2qApD0rzbLmsp
	W9L1pfTZSXTZ+WKrOWWMtmQN8I2OlNPfHk0gRmiYVoWdWORGfO/6WhMw8p7CllGH4/w=
X-Gm-Gg: Acq92OHjWVWkJlz7S5M3iqmZcmaB29nwbqz4wpvIZjTGVh2DUsyUnJuhzX0lIH7Xa8a
	qQAXyo+RPNoFQ6/jCNnL/GSQODmNTSFrwzDER5dk460Ho2VUBNkXr1EN4A7bKdjFezicZu0Jks3
	6HhSnBezNIhKhZF5Pc+LpbYt7xOvt1i142IRXKvSbWIre4mMZwzLzW+Iv02sOES/HXHjfDautpV
	E48/x6mE/WEH/D2MgeGUl+1rLQogeb6bjTkwh/Kv+0rtxOiTwH6foURERBhiwrucJi3jZcvKwHh
	tHj27RvteeuBdwRvXEiKLEs/lpB9baap2MZPWez8oPgrz26rMvLeR0Nw2E61m0nb8zh6DOQkpuv
	oUuvmwXmqLWNRFAm+ixg7jisGI7Ga8YBkcWOIOZc6+Evbr0gY2dq6ybu/pvYeF1n3WoA8ONVMFt
	NfHpbzARQOxjtc0Egt
X-Received: by 2002:a17:907:1c8d:b0:bd4:72c8:140b with SMTP id a640c23a62f3a-bd472c830b6mr129588966b.10.1778685615400;
        Wed, 13 May 2026 08:20:15 -0700 (PDT)
Received: from 2NNP224 ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac09c856asm855323966b.14.2026.05.13.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:20:15 -0700 (PDT)
Date: Wed, 13 May 2026 17:20:12 +0200
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Override EXTRA_LDFLAGS for
 static builds
Message-ID: <5kxaobdtanyqtvvz4scjxqmgqn5lqecredccs2ac4ju74yoxyk@plc7wc2fhd5c>
References: <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>

On Wed, May 13, 2026 at 01:24:37PM +0200, Paul Chaignon wrote:
> When running vmtest.sh with static linking, the bpftool_map_access
> selftests fail. These selftests are calling the bpftool binary in
> tools/sbin/ directly, which results in the following error:
> 
>     error while loading shared libraries: libLLVM.so.21.1:
>       cannot open shared object file: No such file or directory
> 
> To fix this, we need to also build bpftool statically. That can be done
> by setting EXTRA_LDFLAGS=-static.
> 
> Fixes: 2d96bbdfd3b5 ("selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

That seems to do the trick.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
