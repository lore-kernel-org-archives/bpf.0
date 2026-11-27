Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795823469;
	b=Abz7fjVyCi2BpCDSQKuG0W89+f8J9Sb+l7tLmb7kINzkmcRSRcv3eTW7huFYZV0F867o
	 r2HdZcjsthb6GUKM0weZfFF5JT1+pozVSZxhF+7iV4xUyTaRoaBK953MyjDvH7Xqk7emK
	 AD/riP6RnoHNiJevojb8GJduJ3bW/+QIspMwkd464/4kmyDnhtOdOFIREYwOexM5pjn9f
	 g5o0aImr8ccyKwfBRinMwcKnxI/c3rH8UYR5CsioOveVwF6eLjm7G4bFrH1xnjBqdBVC8
	 x5ASLya5Qi9purq4LZsXOscuA3pzspP27s/OuHL3Km4/GDQ0y4FYlPm7QaiU1tisAzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795823469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KVOmWfdqIYfeqYTgBunQD6m9OZ3k3UGq1oiUDE8grf0=;
	b=3tvL1qALH8GkXhbgJUd4smR7UnCO2er32hdJkxGe+rgNmbtRVgAFBL9LN0857jzQN2Z0
	 mUbFX9ZPb8J/OMHYO/8TOQFJLWM6xg7PnuVrxHOTLapS+Z4b3GOrDq2lezK0q29rE6LaX
	 NSUpwdhqqiZONMlooZlAMrZ6J8Jhb0fERy5TOjBChumMl16P4NAyDEIH38FJBm2slt1Ec
	 zYCvrxVrAKQxqn8r+NFiU+ytU8zkA5R796ImQVHl8kercxPjec9zZFr72doxFnYtuN9nx
	 /sJU9wtAoqk0ZscylRzRnSUrx0tnQFbbNBijcn6rXcvO4ZynUhRz3iCdv19c3eQc/hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsRBJCk3;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AE606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 23:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsRBJCk3
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f052ae3c86so46772175ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795823468; x=1796428268; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KVOmWfdqIYfeqYTgBunQD6m9OZ3k3UGq1oiUDE8grf0=;
        b=XsRBJCk3h37CLoNuGVplS9B3qcgNJLLmLUTqVwgmIkFkQhQglYtGNLfv3eAz6mMA8s
         IktkZErgR3mttJlLafpvgr8BqNKTdB5oYd8fn+76KRDjakGh/n4qJVwh4/nQxuG5kV0J
         l9XD4U7jXCtd+NPd9XbC65XqToOMCS5dDqyM+QGwuQX+v1WqNsTor7gtOT+yx9xp7tJU
         esjjwnrovNs+/J5O8oS6rh7r3VFuCWgn1y/vPY9Ip3dpV4zBgjqQGs2egNPqhyouKdLH
         wTedX2UL0RmoB9g6lwn0gSQUH1LWWyQThd3Ji9lsOotG0h17iWKzimw9hmz9LQHkCigN
         7k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795823468; x=1796428268;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KVOmWfdqIYfeqYTgBunQD6m9OZ3k3UGq1oiUDE8grf0=;
        b=WS3JTFObI4Otdp3g7TDRawDbNJW1HNGKBBW/uIzeC8M6qLrzkMoVdrVuMrFAhmpUqC
         mJtlEMsYvMZtpp+w79Wr+N87ifruBDCnWUwoKPc7gonqI60bSm3FxGXPbnsVn2J8/Zpo
         jzmIAdNs4D7sxK5HeRldVnd5l6TltxQk7usCnKLxnuS4KFvwObNURU5Uej+XhyaUk5z0
         muEeO1Af5zq0rZNVlajPwZaz7TZCr7dL360YjED35RYKPEy5MHGDot1esjpdRfIhxb3o
         brj+eAwVKZILgKH9wORi26p0Kao7hwZAZbebt9IWriYKBSEZk7EiA0nMnlcTqqqvI5Cp
         DXow==
X-Forwarded-Encrypted: i=1; AL+hErE9tEHiwa8xyZuqjg2QGAPmicbLC7EXm5ppFSgfYZNyACSJrbQdZK8r9pS3aAJf9SIiyhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cfz3UKyiaYumwpqyGLeEyR2nce3Pr+Ir8e4fA1jv5ma/UCV8o
	JOGDkXICp8GT6c5mooZPqxaP2OlW3/hJBVHStYMcQSk09BZZ4hCjeIo3
X-Gm-Gg: AZFdTZczu/I8jo3kkKSxuP4+zOK4Tad3rpODeqyP0M10p1F88e0uK/eN0vF848mCMNF
	j83NGbbYSqJnvwsZMBfAzezBxOYzwX7DwB6AG3c7QIDg+G3vmKO6ifFWuCbV3z7euaiJ/po3Q8+
	qeisiIEB9iXtDeB8cbySlybRtkAy8fVlqaB5heCLUAU7NiR/Tz/XB+3GuHxtg/RjfLLCchyTJq1
	8feaMRyDrxsRt0Ozup4nESdunsACHGBgDLEt8I+sl+m0Kwmc8mvSjOxgTZ1STtIzMjPu0iwFHlk
	ASOKLTpeXSis+GScC6DFUkfKmRvWq2KAvjuyk/o3JjK8atTA06aV5vud+I23TzmCfTXILC9YmSG
	zC3qejyOoXl330T2FJrmKVkewyFts3am20XTgfUCmGAChV3wBXN10d6uWIg2GRdF8i56iZ2nN66
	sx+ubhAzRJLYo6wlGH4CVMZl9kTdLVIEEOEIpzwlCXIs9MeOtmCysnSLT+ZhVzd/f7ZYZPlE0Cq
	qBEfjpVJ7Hyk+WMd56mLAGfsGIJSLDkOi8f6UKnxqzB/nypScESPZ9XjVhbikTk5xEJdleaCyWK
	ODWFtNXsh3Ea/wYHNr8nyE0fHzlbui0iau1wqen06BKoKtoDDEgpOOR2HT521DwECBIt3Gp0zsi
	iWEOOqxkmq8bEUHp2WK0t9ofGVGg9UqVYeA==
X-Received: by 2002:a17:903:230d:b0:2ed:29a5:7828 with SMTP id d9443c01a7336-2f03f1770c7mr274805035ad.11.1795823467843;
        Fri, 27 Nov 2026 15:51:07 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215e2sm128158155ad.63.2026.11.27.15.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 15:51:07 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 23:51:07 +0000
Message-Id: <DN6EAFMXZAIA.F3ZIJ8N3OJ3N@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <awmn-8pxvHphS_xZ@sirena.org.uk>
In-Reply-To: <awmn-8pxvHphS_xZ@sirena.org.uk>

On Fri Nov 27, 2026 at 3:55 PM UTC, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/verifier.c
>
> between commit:
>
>   02d3452bdd80c ("bpf: Set the run context for async callbacks")
>
> from the bpf tree and commit:
>
>   d83c595d9480e ("bpf: Put a barrier where no mask fits")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The resolution looks correct. Sorry for the trouble.
We're seeing more and more conflicts between bpf and bpf-next,
since the verifier in bpf-next is completely different.
We'll try to sync bpf/bpf-next trees faster,
so you don't have to deal with this non-trivial conflicts.

