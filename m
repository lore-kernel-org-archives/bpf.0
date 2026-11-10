Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323966;
	b=dz6OAS1uyEhtBO5WdFgxPi79UMnYs7pmnbSF5pwxKdUpNtQE6eBZHche3wKD3pm/iwvK
	 swgFEFts2eFTXUOFpHwIFlFXmfUpPypi84TeDrwF4IEzsO8v6/zRNqDxeGnZFZkZ721xi
	 Zj0OJp73bkvNfAYvA4FyftdnLCK3b4ov381XTVf/f4ln3ciinMTiE0Wyh+Fh6yCiUIbVF
	 44+9aEbiuc4ev5LJ8bif6DtHHnL9y/zufVHQSK3pCTbyaApuJU2x4Ct6YfZVlHGOWfExY
	 f69dvchxhnqFcJX0ExNSZ+uCTXHnV6aReHbJgsRclXbrViKOI8Kou/BplYdc3U3JoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=76utIQtb/c4UmY3zEuM7/9SMI7MPnH174zMwNNzMA9k=;
	b=eJh5tgDPuOJDD441UuMGXI/d9isVT2HMsCfwY2hpx1i6YSP1Y4BUshynYlXB0S9rzIVo
	 vy1vmMJEGaB5eaHH91OsFBkw9YePnnWjdEzLzRpWw4SPzev8q3Px/90a7kumOVnpZuXzv
	 3nOpDn8dzJNn3m56fJQSUB8illr1fPk4QOQHObTC99/FeQr2lrLTk5+AvzyF65DciDAno
	 BfNZ2cNLWEJcF9dD9sHumjNuV0II6D9YyYrbliiu2mfPaM3TChDPHtLRb6Qdfl6RaNr9q
	 Mhi4oOcoEuOW9b1f1g3VTYgl+YbS/0Zv5n1cQr36SMrk0Ch81da8SUdn1FxfMV4T/eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FdODN4Vo;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB995606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB995606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FdODN4Vo
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1836350f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323964; x=1794928764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76utIQtb/c4UmY3zEuM7/9SMI7MPnH174zMwNNzMA9k=;
        b=FdODN4VoySq3EV04yTB7q7lsbUQzCNEumNvZUsLMYxkJWamaUfad4G2e9UnXuG7Vjb
         W6ljQA+IGHLq0oCv7DrDBuzWO0fTiCf4/MeKFK1jXESPHoIJrScQ+noZFp6/Zl0zVk3N
         JvlXRUGRiL1VPA65MLGjLIT8F1bpi3eanffM8xHaBE2HOH7/gBg0H0f6AppVxFodKr6z
         LxZVhxi/zm1GY5dn65B1w1v0P4jjpCJZecz+gSLKLfb7urQVHG78QTnXLhJnXO2c/Wfj
         oKU5vH2wR0UInC0hxULi4JBetHjed8U0vuAsibmr9wbH0+AbSEyKVtUt8ThLn/Z1p9mL
         YaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323964; x=1794928764;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76utIQtb/c4UmY3zEuM7/9SMI7MPnH174zMwNNzMA9k=;
        b=MrMGoZCi0FNEC3+giCFGJ2kIFHW2ZR1q53fgMCZiDiR9Xum3a9sVJAdijwdOd3L2yR
         f67xhBWhk0h61N3tgmRrL4u4h5xdNaneFcO4Uc3jHm0QJP8bUuEEiSvGZ+ej+HKu+oj2
         b1qieOWKdSGEoI0MyJdiF86jN98tNKldMXqqB82swO1zkwHRTFLnIUu6jZR6z1WLe8oj
         0t5PkJJhie3lM+GhOVOxOt8yCN4PWHTJ9eVlxesSqAVR3xKr8CLQiIF/ZFaapo+yfBHN
         sLkYM9l1s/u391PRNstkn5ufbltyjs1b4+82AQmu+or6L6XNWXRevBVgtYUqhX9SpVy6
         /pwg==
X-Forwarded-Encrypted: i=1; AL+hErF06tUIqsqE5v5KAkUhvlOmEjSImTatGQhV2Q1l8nizf2j5qswetPMb92RPcmh1XlziCRM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wo8NRls3tv7IgnoNpFNYv5cbD5Nx24WSOjhLOkf2oKrZd1wpX
	5fwYUICbK3O3e5wzQ2Ihh9uC28vewiUSgFZoOphPdUp7d/RIB2Zy/b87
X-Gm-Gg: AYBFou3Fg92bYcW+7+57jkBIZCZeZiwHh2cjoxkp3YrORjkMKAbCW4FD71uw39iGmHa
	0PIheQD3a5iG0yzJw/hgA9tbIFnRKbzL6BGum6Qu5667T3X1NG33mHxBbLTBb6YNqxa4m7TvTi/
	9amsuIlz5wascVqMj1yGBIHPKG/qqCT8nVfON2GOBE3+bzS8uHHv19FIr3fRdaQGZPGViPZEwNf
	6MA5sg8U5vRtBzK4/Vfumo3wOYaXWcBb5lj7Le93A5MsfXYsr/Jz2Ydsv/TlYbeOeXhHKacmv8l
	VJwjK49iMbKNtlufWsERtiDlAVKzEFdQcbYdi2HB1LxZQ314OgvfTNhe4YD6/Qt+oFlxai8WJtQ
	ViyJSa5fuSu1GcCW9eyJ53VLnpPOcbAyy9rqA9Qz5TqJU+MUrHOjAJrsfwPnVNjyKTUWhpK/pcF
	k8+pPrpEi3tXt3QU+SqkMQImLLrePK1C3e8D6JNoeulEVq4+ddWyCvI8kNbEApQh771BUf8xptQ
	qpw1XhvSmLYc5C6z4Kf0N0VDktmQpHeDaGRi0tpTigiV4Bs7KMaac5F5QEaadysHXvu7vlsp88C
	vJOarzpjDt2DzaH5mh9qppqU9+lsv7BJLbTFZA==
X-Received: by 2002:a05:6000:2689:b0:492:20e0:f666 with SMTP id ffacd0b85a97d-49828b4d6a4mr6282685f8f.0.1794323963892;
        Tue, 10 Nov 2026 07:19:23 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm5971615f8f.57.2026.11.10.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:19:23 -0800 (PST)
Date: Tue, 10 Nov 2026 15:30:53 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v2 bpf-next 18/18] bpftool: List and show fmod_ret targets
Message-ID: <avM4rbE4M1NTiOn4@mail.gmail.com>
References: <20261109170550.141443-19-a.s.protopopov@gmail.com>
 <342114bded17116917aae775b31c3c68a484d0c3e49e1b27c74131a6ba236ca7@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342114bded17116917aae775b31c3c68a484d0c3e49e1b27c74131a6ba236ca7@mail.kernel.org>

On 26/11/09 05:42PM, bot+bpf-ci@kernel.org wrote:
> > bpftool: List and show fmod_ret targets
> 
> TL;DR: Nit only: bpftool.rst adds fmodret to the OBJECT list without a
> matching *FMODRET-COMMANDS* line like the other objects have; suggests adding
> one.
> 
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
> > index f38ae5c40439..2c64c22a5026 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool.rst
> > @@ -21,7 +21,7 @@ SYNOPSIS
> >  **bpftool** **version**
> >  
> >  *OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
> > -**btf** | **gen** | **struct_ops** | **iter** }
> > +**btf** | **gen** | **struct_ops** | **iter** | **fmodret** }
> 
> This isn't a bug, but fmodret is added to the OBJECT list without a
> matching *FMODRET-COMMANDS* line.  Every other object in that list has
> one (*MAP-COMMANDS*, *PROG-COMMANDS*, ... *ITER-COMMANDS*), as set up by
> commit 6585abea98ae ("bpftool: man: Add missing top level docs").
> 
> Should a line like this be added after *ITER-COMMANDS*?
> 
>   *FMODRET-COMMANDS* := { **list** | **show** | **help** }
> 

Yes, thanks, will add

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554

