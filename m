Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B672741B5
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379338; cv=none; b=Zogl0NF+Aa3DZFURkGPg/jJPuR74L2WolxosSjRvNlOoDIjBgR/KXCnMsOeWJJ5tE7feIK/21QJrcLUnjVYv/qcfjRgvPiryD0KU7TuRshoTp14XbSc3a2QTn0/kOK4V75hwvIt6fMixwII/+82Zk2wr/o9+tuCYaZmjXkU9n+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379338; c=relaxed/simple;
	bh=1YkQ1xknk3HXPo2U6IC2skc9hdqA4WxM02nBDF9vNoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZM6/0LAiar+9Wy99doj8XxSyEM/3wDnTaaX8swxlmPfg9Jv2fjlnMe1WRe7webgdtCEs8YT/tJGE99a/12KWGsP+ZZ9ad9++u3cL9lFeqi5vDLoSwpeiZuOos9uyFPrSUvgOy9GYwOn/tidp14shfGYJkpAZY21+YUwrzXhedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHOMC/8/; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHOMC/8/"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271257ae53so5103228c88.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 17:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771379336; x=1771984136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xs2eo3fi6sWBx7GfJK+0RFL6Et71ppgQ7nK94o1qrG8=;
        b=NHOMC/8/pmqYNAZceAkWeY9z48c0FFTwTGdqIz6lh/+Akad1+huCUi5RYrsirV3EqC
         ASoxBe6JD0sMHJhqt6OT3vXkPd9wsnTKJ2r+Bp2FEo+wvk+TXCZQWReMgA2j+6pPmsmr
         Ik5P/HvegSPUk1YPtt5i7/gENOMvgc7XKlprDUe85RFe/+LuYH9yovcvCDEfS3o4Napf
         JkcpTyfQJUap1SB/MaTflukQaikuHRFj7OSV7f1bq336KRpCv/33US8Rm+bHom4aDpji
         upSAxGZs+49bMmiCGCouONQoVjVa2QgYSYSCt1DturZ2KAin6I7gHqZPf16wsHbLZGgu
         TCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771379336; x=1771984136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs2eo3fi6sWBx7GfJK+0RFL6Et71ppgQ7nK94o1qrG8=;
        b=r2Gu6nu3LSlfqQDKVbOqUpnwBKaJFatjMnDOTynor+O5loBy+c3Hfh1RLCcvEm/GsL
         uHXuhGpg3GOEj6KcmWQviBFV1l/mFABV/qjz7JdBz02WMy+OFyoajJ4W36HNHJWEfwgI
         08Iu5IjP/Fj2oAwzM2Huv/Bj6BFPn/tCXD3MavoywgVr6BSGveHKS4Cos2NUrttwkIMb
         PTFqBpsjjTIXygLEjPANtKrNV7SChzJMZc1RvTWCF/cDFHLjq5XgmjutOZxXLs1OIvze
         /AzAfzcJObCkgEQHMhmt9rvYWnX9AoX4utZyXoYVlCWaZMbbKE8kSS8XRM/ZhR6k+tvj
         ubFA==
X-Forwarded-Encrypted: i=1; AJvYcCVUWKXIdnqEBPLkKAbBB2+JS0F/uDMhYmYh2w6F+3hAC25C35wvGjyBtuMxmqrSuwzP/aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3tO9CL9cO/LPCZ2sy4K4cYG1TLfKIf53aJAlMtSaTqczcvuK
	EdcC00mdMFRosN+XqvusACSwxUP2ltyHeiOemT07GXA4w0TIBJ8JEgFrEo4qb6aO
X-Gm-Gg: AZuq6aJYbIM3LiOQ5YapiXXtZDpEb3D9f2W3nVrZy6oufh6rGzc4Rx7kL7BwgaZjJRM
	wkkWlW6zQra9Hlht7OBRbjaAL5t7QQRcvJySiJsTvnob36pnwPqDKoUYRasP2l+/Bb4qq84O+Fg
	5K+LqFDXaXKB67FoAX/oXardrV+l+W/1H4HVwq8EMPiuUYoXqzMvJkgdURaVaEUms9Ph/n3N5Zl
	1tTtBUv5aSCDBRJ6tVql5PX9lF8GS5BP4RFa6WDqsMwZeMEKifdjloH35F4kb1TzYv4IzEpXAmo
	G2sidIOz2HuvDjUnbpHfUCVCPKwxxFKNX8unvKOUiqyH4kjpc2QpNisfNPSi7hdV01VdEFsh4oq
	S7poNZ0SVGgi+DVOPRS50ZtfLnqWafQ15yQ0iu89EemyF/0VvItWB/6TYkABEwgeT2kcoS6w7lO
	CBV+cPiSdmYcX305iXfPfmOIPQucVVsilkbIzimT9yc6mQugtJ9VHTVInkDQ3ic7GfFKUmoBL7z
	YPZnIY=
X-Received: by 2002:a05:701a:c94e:b0:127:1b8f:aa02 with SMTP id a92af1059eb24-12759a653f4mr129033c88.28.1771379336298;
        Tue, 17 Feb 2026 17:48:56 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ea8a:2651:c8f:99eb? ([2620:10d:c090:500::3:3a6d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cba118sm20594390c88.12.2026.02.17.17.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 17:48:55 -0800 (PST)
Message-ID: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
 support for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, 	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
Date: Tue, 17 Feb 2026 17:48:53 -0800
In-Reply-To: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
References: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 09:13 +1100, Slava Imameev wrote:

[...]

> The verifier assigns SCALAR type to single-level pointers (void*, int*).

So, the simplest change for pointers to pointers would be as below, right?

  --- a/kernel/bpf/btf.c
  +++ b/kernel/bpf/btf.c
  @@ -6906,7 +6906,8 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
           * If it's a pointer to void, it's the same as scalar from the ve=
rifier
           * safety POV. Either way, no futher pointer walking is allowed.
           */
  -       if (is_void_or_int_ptr(btf, t))
  +       if (is_void_or_int_ptr(btf, t) || !is_ptr_to_struct(btf, t))
                  return true;

          /* this is a pointer to another type */

Except that loaded value would be marked as scalar() and one would
need to cast it using e.g. bpf_core_cast() to obtain an untrusted
pointer.

> For multi-level pointers, I selected PTR_TO_MEM to enable memory access
> through a single load instruction for the first level of dereference,
> with subsequent dereferences becoming SCALAR. This design eliminates
> helper call for parameter dereference, replacing it with a load
> instruction (e.g., void* ptr =3D *pptr).

If going this route instead, is there a technical reason to limit this
logic to multi-level pointers? Applying same rules to `int *` and
alike seem more consistent.

[...]
