Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83524332623
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383695; cv=none; b=tuFaYxRBZjRul48WNwLS6mmAD5cEbhVOF10D1kVUh02IywkHaQgEy+bCkS6/Wm/UzQt2r0A8Yyojj0s4p5FTgvsiSZ3Na0/s8I5duo6cWi+BbV0McoE37KSe98bOpA+F3IyMLgAqSycpuKIBBha3twWj2oijz3vN2t/cySNEnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383695; c=relaxed/simple;
	bh=YekaUXXUymXZs/3g2Vp+S0NZBc707UWzjqqiXrrBWgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1toIE52QjJJqxzkgMrMTkYgSyizi6Z3gziuy5Umbdg/1lXOyI5ziwmMfCTi5jKOxyQhJRHEua1n5FZO9Z/eB6m7AUHRLunQSb7MzHQhCVif5P1PNNt4bxG4wGRa2bXXvCfSPfF34L8iQyGs0Pgyu8XJwK0TiO/ACKHMYg+l+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ruc37CfH; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruc37CfH"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0bb213b16so10279328eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383694; x=1774988494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YekaUXXUymXZs/3g2Vp+S0NZBc707UWzjqqiXrrBWgU=;
        b=Ruc37CfHS+B/+pv/hj0IEwYVhZcTJF25K97i2ijyp8k8T9wgtOHEJWnhGA6LPFioKB
         5ApXWklgKgV3osabwatO7QT/FkFdJw5JXH9gzmfPHPv+7992PyU4seEQsuxiqmm6O3Ny
         ozGbPB3w/MTOHQ7qKzOtVkayWp3vWo5xg+SWH7kLpPJxXZjJGXmgc9J+kzgEg0m9pNu+
         uhOCmBEAGSsXwAh+EQSXcYeoPOLCipDYV2ljD6A/z7iBgmqzpf2dAWVmIRx0KRd3fJ+j
         rcFsBooHKMuL7kaVk1z0tZLBuQLMHJ839PuTmWLa11xePpcRHP6Wjff642o7z3nhp6wp
         mbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383694; x=1774988494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YekaUXXUymXZs/3g2Vp+S0NZBc707UWzjqqiXrrBWgU=;
        b=rRjYNyAqLANFAWEifIiUP1INRS4Tjw7nbGXJM4LGbiRpeBBj+CnERL84Z16V9Fz8ur
         OmwDoITVmT8nJ5Iv6DUQ9CbMQ31lDGeYRrY0xk7s1i39EJO8TqjIaJxyMTmOMiGDt9mX
         JqHhwwMpf4kt5cya8WFNpnsV85JwX1i+ySry6dEGqzBOC/M3upHFw+joYQj2tmlWG1as
         BJ5ty0cLHOkGBnHWUCXFh/Op8R7lTuInO/WePQEO82u0+wZxBd/ds3WVntjdB5I7Mf2p
         QJzpt/3CdK7jYtaKeYnXaztsuhjStuCjniH1KcQyJ2bE7fpGwHhZDhiauWJiS66QVdaG
         RIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWbPIGFNVDFBDHYb7NehPFMKQInBcX7rc8qKb/2PS1YzvoUktsOLCoQVEhJshVhLVVEno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqSHSat1GiNkQAa7WmulBOrdZLVBu/cgc54Fsb+FaJWjaejVy
	VsKFHHCZxeun/+3tbR47NoNV6Ip8ciG/3HZlbK4slIYZTR67ViSae8Z4
X-Gm-Gg: ATEYQzzi0KPbnT6dB3eQcKQQJmK8nvQ9ovnWLRItXfjCOZgD/mG7EuaCCwNPoB4ouRf
	C5J0KzTq4EAErpLoVU3rAcQ2S1TW4/RcTFFoTclXzd4siAKRBU97DzKspx+Q29smkdZDP7GmXpe
	KXdzhbIf1xOzwcLqhQwMXNklEr3GZ44eFeB0f1r6hwuyBGOqmvlNKTfNNMIid9vRcVF9aAm8ggr
	S3dPGNb01x0zRfxDsXW96cCq6o4HMnRjFRpHxc5nhNd65icL0vfLIam8t+edWZxEefvioPkrjZ1
	ARAoJRfCDwIeryJTwQzdGhGh/u4bgT6WkMpg/8+CP2BP5cEEdlF4a7F6vdy+Q4avP0mVkOk6PgH
	ARHbp/D8D6xQASw0rgTqbYRaIoKZW4l6XB/RMYzL9+thbb91PmyxPb2HkAFDAoiS5zE96EIGoX2
	fTnjx+Al/BT+2bN2iH2kJ0uRMP1YOIMkmSJWE39veM2hoD91Bi8PBB55CCDprlrhOU1gbCAsWev
	5R8Pw==
X-Received: by 2002:a05:7301:4e0b:b0:2c1:4b1d:a472 with SMTP id 5a478bee46e88-2c15d3fb1e1mr395106eec.29.1774383693468;
        Tue, 24 Mar 2026 13:21:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2ce04asm16295986eec.21.2026.03.24.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:21:32 -0700 (PDT)
Message-ID: <1de9261a98d6e4041ad2e99c745fd6be0831a492.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Support pointer param types via
 SCALAR_VALUE for trampolines
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
Date: Tue, 24 Mar 2026 13:21:29 -0700
In-Reply-To: <20260314082127.7939-2-slava.imameev@crowdstrike.com>
References: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
	 <20260314082127.7939-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-14 at 19:21 +1100, Slava Imameev wrote:
> Add BPF verifier support for single- and multi-level pointer
> parameters and return values in BPF trampolines by treating these
> parameters as SCALAR_VALUE.
>=20
> This extends the existing support for int and void pointers that are
> already treated as SCALAR_VALUE.
>=20
> This provides consistent logic for single and multi-level pointers:
> if a type is treated as SCALAR for a single-level pointer, the same
> applies to multi-level pointers. The exception is pointer-to-struct,
> which is currently PTR_TO_BTF_ID for single-level but treated as
> scalar for multi-level pointers since the verifier lacks context
> to infer the size of target memory regions.
>=20
> Safety is ensured by existing BTF verification, which rejects invalid
> pointer types at the BTF verification stage.
>=20
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
