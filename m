Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F44D5A1;
	Tue, 15 Sep 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454896; cv=none; b=F1bv4ddmrgFJXkiG2qbgyOvILQHORlFl/LE0GW65OigLobIwM/IYjivCWzXO/OjLGqR2D90emuFo1EdT6oZaOxnAiH707vQTflKTdrz4N8ex8grGL1qWmuPSCRHAmUehEpA8xypMnRGIGihci4OlgE2DbSlTnzq/UzkAgm4MV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454896; c=relaxed/simple;
	bh=U8NfbSoYy/tpWZHORlXeskJmVfJ8O05Qkh/1lALDIWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmuA5/7Ln7a8qFtbCO/R21f5O/v4SPbNFLvgYgX6UvWc5hLWAI3ur8l6jDpgqPzmG9p6yIUsMczFmoUgevmcCI+BWUxwVgd6ZAxDLqwEmdbC4jDcG0BIhewYbrUNXNIZIPNPSvHHHEYmvi/Y1E8f3imd13WMqHytvX4g8RQetSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+CALVDK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBEb4hg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+CALVDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBEb4hg5"
Date: Tue, 15 Sep 2026 08:48:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789454893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym3++CRtPNrnJeb4S2Bn6k2IvZjc9db7pamxqlooqPY=;
	b=f+CALVDKV71TwR3TlkcmLGCMO9lWQOpdDbOdh+NlSdMEd6yoekI0luVIbRJagmeTppJC6P
	r3QjFIIbltyxDeF0ZN6mGdHAgi1C927oPVFHnD+mls5m9qXB1x2fE+oVozGfgbyiXEf9GM
	57+Zrj+0mBkOnb8Qnst+VdFDVG1TZbAJQbkvWQprYmf63PPNvRbxqsZkPhffIdyOutNEZC
	8i1bRRUgYQpZB1cxY+r6cyCxepEI58SXbUvb7CC+7P7TrJI7nB9b+Kg/rLLbCfbeBr5Qty
	24a7U8T94pb8RpN4W9LH7sTvvq5maKuP2XAyznNylJvBsa9+q1csD9eoNlBU6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789454893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym3++CRtPNrnJeb4S2Bn6k2IvZjc9db7pamxqlooqPY=;
	b=QBEb4hg51OpSgsAyrzJ0QDkSo9mFH+rL/E1+/22wkTi5AMfKnsPZMXDEqmgwUia5tLCGjN
	GUmCz5tOprTkvXBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Replace %pK output with 0
Message-ID: <20260915064811.MrdbYUsX@linutronix.de>
References: <20260911145011.kErTVDkS@linutronix.de>
 <DLFFP4P6CAA6.QLQ38A75G2IZ@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DLFFP4P6CAA6.QLQ38A75G2IZ@etsalapatis.com>

On 2026-09-14 23:39:22 [+0000], Emil Tsalapatis wrote:
> On Fri Sep 11, 2026 at 2:50 PM UTC, Sebastian Andrzej Siewior wrote:
> > Networking used to print the socket pointer with %p as output in the
> > /proc interface. This was later changed to %pK in order not to reveal
> > the actual pointer value. The output format has then been copied to bpf
> > tests which produce the same format including the %pK format modifier.
> >
> > Networking recently replaced the socket output with a plain 0 because
> > the socket pointer added no value to the output and the %pK should be
> > removed fom library handling. The format remained otherwise unchanged in
> > order not to break any tools which are parsing this information.
> >
> > This change removes the %pK modifier from bpf, following the change in
> > networking.
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> The bots are being overly picky bere, the tests pass fine and these are
> selftests anyway.

I would repost it with comment updated. I am just unsure about
README.rst part. Should that pointer about llvm 10 be removed (because
outdated) or kept as I have it? 

Sebastian
