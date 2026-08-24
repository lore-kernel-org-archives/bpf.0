Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39927456
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597617; cv=none; b=fdt+YLv/9+0kgh6towC5nb7531crXWMrZmm7A7XkCYwt4Hads0Gpl6o9bBARHeCCSIn8b7Zp5GqlHgYwJACgcei9kGCgs7cK22fLDvbfMMlTl7HRaNnDNG0Qpx+6HqRpmJYtVvxRQiBjoISNg4aR1FJ53qNuqJVHf1YsCCE8s8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597617; c=relaxed/simple;
	bh=LdqnvWuIj3NGbdnqwYTMc4U8OdPydsRLFLcys0dLCxI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+PtcO7zGTgRoNtJv2yZL3LjUOcWsVSNwXGdbDEo0nSRWlqNaybQaJo4FuEAOXEMtXvTq3yDVeCCtad+C8q+Lukd0UCsWqIMgGjAvP8+U+E0aJDToUyo5ZdL5raD3AN1sJnp6ODZEduyQXa03ILvb6l6Qmq52zGy0PBwqqqqWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUwcEVET; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUwcEVET"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso31598915ad.3
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787597615; x=1788202415; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9kDWZWUs0zMLZ8+1wfa85G7xiX+jGXWvQzIkNtvlYbI=;
        b=TUwcEVET9nhw3Vrl+s1CsWRF++qLkhX7pxFs4A1H5/So5paG0m0Ba74XGrF65l4jf3
         Nj1uIqIuXyh+o0+YjFvTbeM6Sfswks2nRY9Y86ZyU2itqZIgOcd7nCWtazZ7Qhiwk9Bj
         gdfgDHCTzZYvIl9jondvQo4xy1kEjzzx5KzgszjFvrTueP5ZSUjJ6UREnZ69pGoYSorD
         iPc6cx4TUcyaj9K3gNbhrVbqcdXYiFdQoeotbEBQiVDR6HUCL1FKGliUxpqrimQurj4O
         TJG05B7TSZZ1I5yqEj49Nqv+niItzWs9jwoUmVjPbF0kgT9DlHg3kURcC2VcqqxkFgj2
         Ko6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787597615; x=1788202415;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9kDWZWUs0zMLZ8+1wfa85G7xiX+jGXWvQzIkNtvlYbI=;
        b=gL8+K2zIKz7aWS8938RrX/fJf0qSfUWt5sgDwPgYmXm17ah78xWKFjJEC5NpPXPC5a
         lVEiKpE7tV9Kc+QJ/AuH371e88f21GIemGFYA0nnDBroYgENFnUZMIXrfwx0Av+iOrOS
         kZ3MW9BBxMiH49mmtdU074CXG+at9MQb/xR1KenlBBqGLUb2XAzgI3QvoKYGnHhcsNIs
         soV3V5iAisyZPufBAixu1qwNG+2BWiaa45QiF9VP/BCx6528PEdUNjKYtf+HOehXZW+i
         9SCDDWwrDJ3DLEYxaU3kosLPQZ+z7NtCHVwyRQ3nKKKLOEweH95ZghmDfp4JAZ2wRsFM
         LmFw==
X-Forwarded-Encrypted: i=1; AHgh+RorOpg3yL9wkyk7zDz8oVW2uz2tDD36q+rFMrob+hQS0Hv6t4gaie9ZqXMLewRFUV6Qh5c=@vger.kernel.org
X-Gm-Message-State: AFuF++kYNZuuhWnfzhmwvyoDIqaYNLD/f/ivMD0NKmtLDk7V9W2atjri
	FsSVRmzMDFg+V4AVg60yx93o/Mpmi7sOV1DuWtbkwKRol0ZtA1tq1g9ek4adfbjGwiw=
X-Gm-Gg: AR+sD10RFG0kU9+T6fIhDBiHBWyeZqS+q4V/QgloeraMlsuR5VeynBVuhSah3E/4cDu
	WQc5xmM6h0Oyp3XJuiG0Wg6LhKcMqpIV8vtopIMrFtGw+x00k3j23iWVWUEujLc674DSConaZin
	C5EbNWvQcmUsEOXvvQRqICgp8g9u+Kow87rfQuheMqBAKraqofHb7L9ackH/VdW81htx+inMRBX
	2DxxVAs+Ud/USf2sG12guSBtS9Kh2Esxwgwhgs8jJVuPWMgtPTJ/FbLHGkWKPa9IyzXtte6ZE9D
	t6USV68a7VlyPQDgrY3ZHyyTay+XBqWtSOeFwS+5mbWL35OTm2xFvLNNORXeAl7tmGUwcb/Nxoz
	SRacjeGwbCwxJZto+z0J89Y+TtHb2dW02bKIx3gJmDgoboG15fcpUbeYqoyvaywarhKhcs0wVao
	LQaOtGC7TgL+7MRV7F8EvWhmUYmos9XamRo/1Lkk4L7yf6Rfiwcp6hkEtE/3SdK7AZe86wMf1uI
	lGUQ0JECxoVzPczgVeOzGT5sIH4o2+Y23GzAxLTsuc1OQ==
X-Received: by 2002:a17:903:1850:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d6dca57bebmr27628375ad.1.1787597615043;
        Mon, 24 Aug 2026 11:53:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0de2sm29723894eec.8.2026.08.24.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:53:34 -0700 (PDT)
Message-ID: <8ea12dd89709b03ea358780512ac24fd70b0e83b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: report placeholder tests as
 SKIP, not OK
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Date: Mon, 24 Aug 2026 11:53:33 -0700
In-Reply-To: <20260821201316.1059129-3-vineet.gupta@linux.dev>
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
	 <20260821201316.1059129-3-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-21 at 13:13 -0700, Vineet Gupta wrote:
> Several verifier test files wrap their contents in a feature gate and pro=
vide
> a one-line placeholder program in the #else arm, so the file still yields
> something when the toolchain or JIT cannot support the tested instruction=
s.
>=20
> However the placeholder is annotated __success, so it reports as a pass,
> whereas this is really a SKIP.
>=20
> >  #318/1   verifier_ldsx/cpuv4 is not supported by compiler or jit, ...:=
OK
> >  #318     verifier_ldsx:OK
>=20
> This causes skipped coverage to be overlooked: see the next patch where
> BPF_GCC builds miss a whole bunch of test due to clang only gate.
>=20
> Add a __skip("reason") annotation for a compile-time gate, and use it for=
 the
> placeholders.
>=20
> After this change, above tests reported as
>=20
> >  #318/1   verifier_ldsx/cpuv4 is not supported by compiler or jit, ...:=
SKIP
> >  #318     verifier_ldsx:SKIP
>=20
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Neat feature, thanks!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
