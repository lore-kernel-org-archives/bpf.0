Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE569335067
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753811; cv=none; b=MLF3w24BzAxwlT3FmqYiENstJ5pRMUtr8O5tBlvl3BXqpQok2He2dHG5hVqirqj5CdU8LdpS4+MBsHKWWWM41C9KEZ1S+MjUkT9c95o/aOVEcJZ9RpAJ9NpJKqZfmZe9j3O0fUjtj1BgsZmqfALmu/QUB5SMwxFu3H3j3Qip5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753811; c=relaxed/simple;
	bh=7GOUddWnwknp4gXk9w3eytdpEaLQ5CEzjDSjkOMazjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mup8YCGyktXEh4xxg9xZEjB29ZVipTv6tfCeeLON3VPfsqYzZk0BhZwiZoHPlxdCtTUq3TKXdu6U0jMtMNmyTzhHqFEffPnb8V/DrphLtM6NTB/x55HL+ACv6xTZX7k2HD8mHgUfxFirjSIzBULC6efuNQzUveSZgPxYZZkYcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARtOQ2h9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARtOQ2h9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso770064a91.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753807; x=1790358607; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7GOUddWnwknp4gXk9w3eytdpEaLQ5CEzjDSjkOMazjg=;
        b=ARtOQ2h92T/ucKxkkAbEqfKyjvhga3nmdLFV9HaBmZ+iD8HcsApQFhT1H7Ixf5RgwM
         vqSzR899vpdVecy8CBe9oBZ7b17mAGhqI2uZK5CEqPKdUgi6SR3Qmi3wke/tIj71nGes
         XXQ09xtyZp+mqfSVq6AMagjfpYT9z8ZAgw1t+o1Wp7FS4gjm57te0t9uIeXceqkZvn1+
         gvUP5dn8LUTqP8A0+Y3RnEGWFI/SOFYbv+z71I3rCFyOnPZkSYRmLQpRhYaT/wqCDoqa
         +MZImIbquni23USR5J9tUkpcJq3kkE0CAODWMqNK8d7GCdaIwS7xN4fhNv7ESqEBwhDO
         43vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753807; x=1790358607;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7GOUddWnwknp4gXk9w3eytdpEaLQ5CEzjDSjkOMazjg=;
        b=f5pNyAupGLXlfCGv/xUhdTAq5DIPWypzcgOfTz0GDUpbNiFrm4FQsscQWBFSuA/bec
         zpq4MCzxBJDTBlqfxsZ6iUbfuWuqhD46dcWuByKnt6eB2CdRd5Y1rf0/czIT9DsKvLzb
         HYwNQXrUGfivtA8IYug54DCwWnTCe2XgHhrOJMsxXh/yVB3hG25Ob7TVz6XG8zprAtpP
         uENswSY5EAPiAgknsdzFCgqvvP5ENl3uHnxRpWI3Bnnr2JIB//VW12x5OCq4MllNtbTM
         PCmkghnuWBYCBQqpb/Mbe8b9eiu6m1OIqoFdk/NT+YOCTOKx937w0JcwGxtumbnOit/h
         XVAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzPKnPu/tvdSFLVAsx82R157QVS1T3BZUS3hbq+kYOIAHgApAx/ZLhnma8h5WbzFVhd9w=@vger.kernel.org
X-Gm-Message-State: AFuF++kFazgTV/mTEFB9pUiuBn1crnF39GZl2umupB4mGhCObq5zABmm
	HnZ5w1c1+ebmDkKtyEH4xjXAHy992Ti6fxqlBKC9RJe1lGgL7yPyZD3NvSGaUbLX
X-Gm-Gg: AYBFou2q/fvGi8r0OXnHuViPDRqKd2k6RyGpTMA03u6BmhAOONEgg6zoCbdrBc+wHCx
	Y02w86tsD9vEt+Q6XOn4489N92hPMoxBhOWywa5ZLDNzGA1tfhTCurD0O0BjV+OtU0EBCY02GvE
	Prjakp2FrorLaGj9hGwncF4mViklSFnrSo5t8h9c85L0G/bpn62QSFy8hiOydyl7e6azR/zAGq3
	dFzhpYnoYoUYpM35SEYSPqi6EZH0SwvOQRhA7FKKsAzTYR2wEcbTAE4YR7TZNJVryIqLeC6W6V5
	DFhfs6UcOgfCsHlGCgaBU88riPv9taFeGZo6YNGAEFmokK+8VtkBhy3VAWBL99S/W1M29SxSuWj
	yCE7u8flTIyWLbkfQ6O0btqUNJ9VQWiFETWZ+yG9uLybBsdlwot3MIlNNSIsIUoDvJFQnmPXVkp
	rnMcA88GHcI3DNDqVTVuj/JYEm2V34thNdRFurzleRu2r56csdndvDK4HhUFUfYAgjnitsjU2y2
	Xkf3BbyaFsn5FXSMgslvvpox27dXI+d3UtHkSEnIpg03VCE2UmxHgz7HQ==
X-Received: by 2002:a17:90b:39ab:b0:39e:34d6:7eb5 with SMTP id 98e67ed59e1d1-39e54b85746mr6840889a91.9.1789753807324;
        Fri, 18 Sep 2026 10:50:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e563e3e3dsm1692377a91.3.2026.09.18.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:50:06 -0700 (PDT)
Message-ID: <0382b5c8e673d44797136a4043cf02d28b6720a1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Fix generic __uninit kfunc output
 buffers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, Amery Hung <ameryhung@gmail.com>,
 kkd@meta.com, 	kernel-team@meta.com
Date: Fri, 18 Sep 2026 10:50:04 -0700
In-Reply-To: <20260918052906.12226-6-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
	 <20260918052906.12226-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 07:28 +0200, Kumar Kartikeya Dwivedi wrote:
> Stack liveness treats __uninit kfunc arguments as writes. Even with
> write-only access checks, ordinary clobber handling leaves poisoned stack
> bytes poisoned after the call, so the output cannot be read.
>=20
> Reuse the helper output descriptor for generic kfunc buffers. Record the
> output after resolving its memory type, and initialize its stack bytes
> only after all arguments have been checked. This prevents an output from
> making an aliased, uninitialized input appear valid.
>=20
> Track the output by its ABI argument slot, since a kfunc pointer may be
> passed on the stack or follow a multi-slot by-value argument. Keep the
> single-output restriction in prototype validation; multiple-output
> tracking is a separate extension.
>=20
> Document that output buffers must be fully initialized on every return
> path, including error returns and padding.
>=20
> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Reported-by: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/bpf/86d966ec88bbf27d21b2bb4e18c8aa00@kernel=
.org
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
