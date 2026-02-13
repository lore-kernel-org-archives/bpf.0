Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4F38F9C
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770944541; cv=none; b=tGZaEjT16gVqjZTqlRjMrBVMWamMep2TjvRhjJOAGEFMx8zkGylu4hBKzJzOS546gwKHWpTq6HcsW+ejT2XgvdTlX2UlmE/noZjvVRTWt3ja4ygkBNr/0+OwmsLtO1VO7c3rN5xrQTa/uxRrWf11uNiosxow0E/8PmakDE1kghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770944541; c=relaxed/simple;
	bh=j1F5XSN3lkDYKGZDuJf7DcWfqWZ8TmJGRD6fex8R4iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSWsJBC5AZ5nhdIYcLCW1sjQrafEJtyGJ/mcXDzwaaylzL9F3gnWD3dMyocXc/9Grt2PlYmneO8e5//yh6eWTMKkaXARHi4Axp9YaU3VwmxY96h76c6n67iYzABR+pgNcdadvgpD2ENHMYlkHV9mYPT79vRk1yzWyxNpdmkk6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpGllkY2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpGllkY2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aad1bb5058so4064555ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 17:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770944540; x=1771549340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1F5XSN3lkDYKGZDuJf7DcWfqWZ8TmJGRD6fex8R4iw=;
        b=OpGllkY2yr00Yupb5MuqDdu7x13obtJjfiUtywz1sc5Z+mp/++3ie+SvIzV81TgOac
         ADo6BeemZvL4lzopNgDYUyx/3Q8bV88EZLefbSMxkLYHgBu/Dn/U9DFxpUTxTKNKkI7t
         r8uRDOx9Co4wfjLIfNU4BV8pA1hju+1UNVgKIPF6C6VJ5sQLVtS61ZV59u4wBAluIwq5
         5UKfGjn9WGaHkEudpGvc8hG/3l+MG6sqzItBD+qZa1xq6Df1wfbgCPvRIY3CFaB3JYxY
         ft6c6cR4UpiBy2txpiCeaU8R386D1UDdH7znXrGSXDaohd2NIr3zcAEkVmkvdYDji8Oz
         Niww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770944540; x=1771549340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1F5XSN3lkDYKGZDuJf7DcWfqWZ8TmJGRD6fex8R4iw=;
        b=hxllPYROy9+OcKxeqzg41ZIQbYzzCogDmbM+KVjQ2ugB6WSI4oXkus+4dOrw8kL2zn
         RESzcgGhL3F/TV3Gu7BToXCLLL58SjuN2mrLnAa0erKmAFN+WOdkz1scERXOFU+uJH3s
         zp25oBWnBkTSj0hV1/0eK9gHgmPcvb8HicGaM07L6R2K4zOApairPMkZtZi785njqy+z
         FPMAS1akCqHqj/bYhyyetFLrrB3tJujP4trRvznuzTrl/ZkhE83c2ZNpB6oBWVUdUPMr
         vcHMK1ekHb9eGc0xZyvFPvRUvtOnzA4UxdDZ70aK/ULwR9ud+cgA1SbjOdRChSq5S99v
         nCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlObHC+R5mbjfsR1twcF0zjd/w5Z8wO3gj/DjiP2msLNjmlV0THZFXPiA3xwMffIGPnvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkL7VrLKVtBmzLPSz3rdYntXgzTiRxlzOxXWs9yK1uszX2np2y
	2f/gVoIgiPL9mHraL07fdKe2bIySg7rko/eqqD9+5Pa+J7XIyLgu7Q+x
X-Gm-Gg: AZuq6aKSwBi88zkdlf/8yj1q3RN6qESrQ99f3EmcVmkZsuQoYVkNxfOXpgzxIMdhqyR
	Q4+o2OvBw+g/e6s1o/FGjS6BLb9naMkiP1BSfSueoGcqCosWRKbb2lv/HLz6mJ0JLAnAuQdnJHk
	7fJDcQjdKvmsZ5t4k+PowAK1oBjG3HHpqYbLHAsRB2JnOaGd8nfV6MpZLpQPxu4gfX3OO0HsbDD
	A8OnWtHgTFbFRSfaERNF89N1bYq9OvLWtDGyNJiovw2/YYhrwkLJ5tGbdhm2hf0+MQRa+trxWcg
	wWYUn1Du9o213Fds75BiD/x+OL7ZxTLyPaMgTYnmUm++xeJyAOO2tEgF0vo3xUy7NOJN7aPetCv
	KL1EWOTotbeshupJkgiYlI16NjyQTgp9Mj5h1rosfE55FrDy+lXaXt+vHxYi9V1dRgN9hzSOOsw
	CRWkQs01d1Vh7AVURUTqfVFaV/gbENRLUbFgr9blb17Z89LxxUQCk=
X-Received: by 2002:a17:903:1b28:b0:2a9:6059:6e12 with SMTP id d9443c01a7336-2ab5059a974mr1166655ad.38.1770944539738;
        Thu, 12 Feb 2026 17:02:19 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2997a4b4sm62740835ad.65.2026.02.12.17.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:02:19 -0800 (PST)
Message-ID: <7cac89a4ab989e3b245a1789b423ef69c2cf07f1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/14] selftests/bpf: Fix array bounds
 warning in jit_disasm_helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 17:02:16 -0800
In-Reply-To: <20260212011356.3266753-13-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <20260212011356.3266753-13-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> Compiler cannot infer upper bound for labels.cnt and warns about
> potential buffer overflow in snprintf. Add an explicit bounds
> check (... && i < MAX_LOCAL_LABELS) in the loop condition to fix the
> warning.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

This annoying false positive strikes again :(

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
