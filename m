Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70681724
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777111537; cv=none; b=fZiHGcOkjDNPlPdNneJfZK8saqPxM+r/33L6WgT2Qlkfb2dk+FhdZRhzMpdFSHNQr8XYMAjlAtjTSdV/Bl5INpIj7VzasvqpwkLf0SMAxbYNvOgcMHWTQzBzJLsA7QbPz8HyDuPO2rHVfXHQoFzXzY3bNwzEjldM8NV6iapVIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777111537; c=relaxed/simple;
	bh=H4i+qjDbtsY0gtULD4aCyhciblR4iddKRexwvN4xbms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKEIP07AWrXWtP+tMEzXVCHzjKI4ssTiWjr82q58X6jrZGxLHB1Z2MoDLutycqP4ZqsdlAAOBF9mvdFHOxCJUzLk1cqPEBUzuVvlnqOCci3ZUsj8B+Eohx8oRsYl5FLghgvL75L8oSFcuhwUNjVxnPd5sPvuve8qosVMkjCujOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs0r90cn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs0r90cn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2589c26e3so81495835ad.1
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777111536; x=1777716336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4i+qjDbtsY0gtULD4aCyhciblR4iddKRexwvN4xbms=;
        b=Fs0r90cnrVRc+de0iTCSn5+I0nrzrasNulgn0gSeqK1pYnAnzmJO0rDaSUh8tLh6Rx
         i9dCAEpKJvWT45Zqjo0yb98DGaqUeX4NYLoITLGoIgEUGX9i3QenHVTNrpgq5r4OhhcQ
         q1/5jtQSwgoQjh4UxqwqV4bjmwWjY+XNHKg6k/FaLIdffBNe0hJynLwlAm+BQ1uS4q4D
         fQAY4Np7VW+trohAwX2bkQ7FXGG4N/S1wnGyd8FoKMViUGe1WVTqzryhUYylBeCsbeD5
         7LNeSQmoSuj60ZOWooOQeysfvGyHc4mRCxIFYrNB0eXUJS6Wuc69d2XLgB1HwwcE9MCJ
         WbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777111536; x=1777716336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4i+qjDbtsY0gtULD4aCyhciblR4iddKRexwvN4xbms=;
        b=Jm66nDb/Dui7CuFqwknDTJaji63Guf87xHHPhUzUcxrhK4ojwuONL14E8MsMxzHwje
         s7Lm9k5q2QKCDFm61WNBSUvcMbrKClzsqIYTXJ7/L6PxsAY1BP8cYxip049ucAJlxgV6
         eC+xh1jzHzPwnZk/C6NKL0+Uah6CWcTVAVcLYWOkOzo1tbezS+7IBdlwJjus8007JiIv
         b9WJnEQFSUUecfg5HgSMlfAXAXI3AuY4EVWl9YxRPg8qFqaIJ7yfgBc5Wlru7OdXM/RC
         uKbaHQxy7AUQs4dIh4sxavDP4p616bNSc8kJpcPgnXuIKf4WKxLFldva5agnxC+D9J4T
         aLWw==
X-Gm-Message-State: AOJu0Yxwe8nxYpYwxarxq0uoQ8pJ6ds42b+Lp67aTxmbYkyNWzVQ1IZq
	o0YXRG9AsULlFsWSQLC3Ef61G6CiiwJBxIrAcLRUjivLrv3pctZMkCXqv1o86Z+3
X-Gm-Gg: AeBDievPt55AVQN0m7mGgydy5pWsdGG6160dXiUaFPsIk8VjtRVkYuks4CbGK0emvlF
	OcJn0gLBPbIbHmu+TV0WoDH4LPzYe+g4ZyvlA1TtLug6LyCoDmLSJvATLoeH4lHr/FxWhmwZ9kj
	OKCRueZfuq0kzs9vJ5J+E0FMsd4pjsUz793l9S6AbRuSLQMgsSpQKGlswW1OBH72hGnxA3krcYd
	mxHMDxHyNE9bePO4EO9V/pC4VmpXTe+mKVwy5VTOdzI0U2jRSwnqeOVgl9JweelIhleZXVsc+rO
	tZszT+EXlakB4QxeLZh8/yIMhv+M5wZoSYYXa9oH3QYfqHMd7fgMc1T9kmPvi+NCWaDYD4nBBQo
	bnUl0e2WxKQRr85RssFQZ/ONxerj6e6msnuOisLXiki+hQ781IE7hfILcllzyzo+8MSohDQM0T0
	6DOCqLHC+LcgfxzDoqhLIn7e7kepjZAUndhofUWzML+15QBtfmc20Z933iYp7LCg==
X-Received: by 2002:a17:902:b702:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2b5f9f7d029mr264641425ad.23.1777111535914;
        Sat, 25 Apr 2026 03:05:35 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20ae4sm310764795ad.61.2026.04.25.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:05:35 -0700 (PDT)
Message-ID: <e0d8a24cbc3fd21cc361b93a3b25c9b412bc8c6a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com
Date: Sat, 25 Apr 2026 03:05:32 -0700
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 15:52 -0700, Eduard Zingerman wrote:
> This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> verifier by a pair of circular numbers (cnums): one for 64-bit domain
> and another for 32-bit domain. Each cnum represents a range as a
> single arc on the circular number line, from which signed and unsigned
> bounds are derived on demand. See also wrapped intervals
> representation as in [1].
>=20
> The use of such representation simplifies arithmetic and conditions
> handling in verifier.c and allows to express 32 <-> 64 bit deductions
> in a more mathematically rigorous way.
>=20
> [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf

Uh-oh. range_within() needs an update.

[...]
