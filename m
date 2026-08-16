Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF23CFF5E
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862124; cv=none; b=CtsSSLLMoYI5N4abbNRWdwx7/Or+FqMe7d7alSnt3KU/fqYbNJ8IpaQrKLgqO0xWEuiaPhVXDwz2NmWZEwGQTPFjHUsxrX5rVtwMQWTHM7aQZdbXAmsihF0VwluSgvmcMJkgzrnYGGDTkBx6Fg6e7wzCn01xNnKu11qbiD7mk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862124; c=relaxed/simple;
	bh=umpycgPVKUVkDlsLaR+i3dWZ40QXSKAyiFa02iT9g0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rcWty/WdD8xe2mMvsVyrjIbXGDtEb74DEQAcupQxyZKRsQllV1rVdF9eENLWjURwV9hOdlT0nurG9a6+9MRkw/ZkB98HgiusgNC4c83njWfO8JAR+haBIIMNeNHzwdQeVN7UlZAYuv0Q5GgyS29LigynJuBMMslZ9R5dbBUpNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajaVSwpP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajaVSwpP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d5655cc850so5414745ad.3
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786862122; x=1787466922; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=umpycgPVKUVkDlsLaR+i3dWZ40QXSKAyiFa02iT9g0I=;
        b=ajaVSwpPD6KW0tum+19EV75SBXzJEEDx50Th7qxxuxvGvm21KpwAKPnfmIUBfq1Xlb
         60JqhW0n4paTDbeyufscj3dc98QSKkLhAN9xVLl9JYBQqP87qNzaTtQ2iReBhKxhjhAf
         DNS9rpiKkgB6r76lO6k+jrRgBHlnONzTSVUu/fHawL7WJeZiuoq2hc83oYaNjEDA3CPp
         idWI7pmPd4GpMc7v7dDQFUYl+zK1Kdp5bTRtYSi54LoVIo3PG4L6VAovhmYvuCLbsA92
         oYPic9qyJgZcVEJaHJYdwWcqpA/KoFEG7mirLpCZz3QOrfcx8NfCSpI3AGeYF4aSWDPC
         Dp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862122; x=1787466922;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umpycgPVKUVkDlsLaR+i3dWZ40QXSKAyiFa02iT9g0I=;
        b=OQ2MuHJZgeeZl/Ue2VzBE0aeJmBInRlYqXehLZ9/F0tsiA9TDJwmZNqYO1q2ICzOYm
         Yugp/6P+GcFuAkVQRe6FMxrS9d+9cXp48In+LlhAK+BCsNH5oRG30al2yvFIKcUTb9IN
         020FX1Vn3TWllgeB+ziEj+eUUb3Fo4G/gjISQKp0LuXqZDlbh1TZv6ovYns7ONg0v7jq
         LQzR05a6IX4NoKmkSOsJ4SYheVLir5gtRi00wjE+QJ8shPyaBupm6QAtClOSiyZ0PMI/
         RlB8TuobcHiWJQxTexR9ha2a65iaW8mYAuwJrmgeaDovJpSRW09LWwGnQgNJNhJuLyPX
         z79A==
X-Forwarded-Encrypted: i=1; AHgh+RpmKW2PIcN6mPaTJHdmNY0yftPZFBYid6z7DKo9llByQeI5LTWbF++22ud54NhV9Q6h5x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxifj7/72U1O4P2NJ8SLZOFAw9dmb1YjOuP/Xn9cZ0KNsZOoVY/
	S6Ba3Bf8XO+WDDJvPZmE6Fu4AwLgWblp5S1d8+cC7+M+ciGhKHvpsi7j
X-Gm-Gg: AR+sD1162Qfs14FhNlbQns63WOs2tOgFKxpyyyEiCjv3Mz/xqkBeorfOi7yc4wKhgsS
	0aIvk1ME9ett1y4tQkYhf5R6GOls985vrb608Ed/pdMP1b7TMP5GLqMEwU5zQmABPkBOMzu/mb5
	D7lfMU5Jdlzis+fxEWi7MG9COKyDdhz76EsmfuZvNrqoUeT19HHOl/MuhjgCpcCeE7kX1VbnhUA
	A67uDOHxjme61wqsQAo5kqU4JhJaWwjDoCBs0YEc+N8OlXw2aLvYoxkyEZwxJEqfz6UpnQ7qZP3
	2alSXa0/NW304D/6yqxpQU0jcgfxE4gI7wE1FkCdtijEqY+2QzBx3CwuREAOdMAAt3BDqsjkQ9i
	yzShhaZ1a2YFtV3DcqJKk7fNbe1pSOQllOMINXdV1RCn2m/1sNQDMN/tcuHGsJlZ0qLRKqNhGdm
	rAxOjYmYqGcutnOznQvsexwomL3SN+bzs1EWdkI6YPNeHf3QCSXLsvJe71mth6AUhI1njpsgN+x
	MjzkDcFxJkglwR5Dw==
X-Received: by 2002:a17:90b:224a:b0:38f:837e:fc5d with SMTP id 98e67ed59e1d1-3933b786507mr17122181a91.3.1786862122277;
        Sat, 15 Aug 2026 23:35:22 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531ecac9dsm689195a91.15.2026.08.15.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:35:21 -0700 (PDT)
Message-ID: <5ec46455e31b4472fe23f25ceb1cd2d595c00f18.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/14] selftests/bpf: Test verifier
 stack-read diagnostic attribution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:35:19 -0700
In-Reply-To: <20260816015746.2632990-3-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> Verifier diagnostics distinguish uninitialized stack bytes from opaque
> dynptr, iterator, and IRQ-flag state, and identify variable-offset atomic
> stack accesses without changing the existing verbose messages.
>=20
> Add output assertions to the existing dynptr and iterator rejection
> cases. Add a direct IRQ-flag read and a variable-offset atomic stack
> access to cover the other classifications. Retain an assertion for the
> legacy helper-worded verbose message in the atomic test.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
