Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74202116F4
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007757; cv=none; b=HD90TkDCik7dNJD4aYyrziQ+N+Lnna6TH4XuwKpeNXSNAey3HJadQPnrLmSqlStIExvnJ/7VlKPEDFVQ3e0oyO1POphJpnzJ2HXYFM0BpTgZL86c/RyMCP3gY+sqg6WPu2BW8qfIRagMiGVxkEWqDScvduLlmrOEkiyoIA7nnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007757; c=relaxed/simple;
	bh=iE5YvsGaZa62Fr0WKxwCtuZ273hJWROf5R2ZB0PdpHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FUsTwiCGHePDwtD0AGfl2nqSKkIl9E1yJVsKLDKhj8JmSVYTiJ6HXoJaybLWztlwh326XphIl/mnv+s/xcsYCbCsFBmrl+vhXtBHHWLuPTBw1l+rolieujuFV7emDfZVpJSzzJwO2NACYZ3KWvU4pGr/M5AkEi9qMcu97fepmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzriHka/; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzriHka/"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732e6a123so1656853c88.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771007755; x=1771612555; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ip28NUBihR0P+nqlQtgDHB0dK1uJATUd7oRLcW8yJE=;
        b=VzriHka/NUEztKAeg6CzFzhw16FQOeWz3wkT0KqFmQpkjv9qLFBcsfX77JxEkLAgkS
         axwk+Rdig3FJAEGsBdaFM+ph6JBynu5ma9oaIGWoJ2R9uE/DQ3uSdRGGOnmOneJlaY0d
         ScFzSsi56q2eh/AhbeqWt5gK93iVBJtwPOAbvkqSb97IapNFnUaOH+WrYX7VpJDetaJ1
         K+xxESCAoD7qEoR+pS4i82+eSotXv6WOaux5pWGt4UTZ2EBrei41FPTguk+KqWRO4DgK
         GFlDe6xV0Fd2rqQgwoctzxAs/QB29BGPxYoT8+8/tyE+29srsgryJiB5Eulh5zL6KlMu
         5Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771007755; x=1771612555;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ip28NUBihR0P+nqlQtgDHB0dK1uJATUd7oRLcW8yJE=;
        b=m592ACWTNTy9kNI0obBuwBqCF48+yzL1PsZLQDYM50XdQqSNoSbR1aNXBlDLVpAaNH
         HqnP7BT6wbMBd2G1kCBxv2QFK1kVS3/ZjTB2ISAB0SzwPLfsQm2c3P5QAnsMFm03lKB3
         B45LqBYTFYvuXazoc2O6VenvGzCjT9UvD8pfXpJOgxfC8de+25FjrYx/RiCPHUSMvtNo
         mDqO3L68ewaR3We6XBKuC/R4qOrRrNovRWC3OWmSOrL8DY8jpnTYRbHNWI3aenemZpRW
         xMuY2T9Njo5PejbjU11qSD2Dw5xmIFlgRPfw8q66Xk+SbdOnLpfdjzNpXxzmj9iaaA01
         Sgug==
X-Forwarded-Encrypted: i=1; AJvYcCVN9YyK1s77C7Pi4ruRpWNn6T/xxluy77uTvuT7uQzMitStwFkcQFMFPJrDz/CfeAU0FPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMduKw9NnCatsy78eCq82Gfbowf2rH7B0vIY7Cknm50hfpX1k
	pKEeJSzxa/OZLn9cJQX6jqf+F6Ug437S8hIV8kbku2BSI1bvkacOwCiz
X-Gm-Gg: AZuq6aJlWdFML8Hg2efaOXzRDq/tOXcyQtiiwHuXF0NctV/yYacUxD504wxFYER/1dN
	nxoPCss9IZZAINp5ElBkATF9/XP9w/nQoXbB5ykC3UU/Iz4nY7rPn8EPuljBWfkoOA8zTPEWduh
	LBZ3ghUcoZqghvCBpoSiaj5X535EuIuOH6Ecpqhch8hCKoA3QWImGr4e0aI6Y/NfUfSXCowHdGN
	3kPDiEwAzeak02/zvFkVCSkNK7ed6dZzxYjjDDR+421HlnqOey8SE339nZQT4uEsulF65Lsg4oG
	90c+AiMHp/gkCxopR7iBsBqVJDJLqma1W/luPpzoVJk6HztfLf2bk63qo2/JawVLe++u3hBevn1
	eS0u6iqDleDQPIpt69pJzUYZfXpUhd71XLGk6c1JBXGMq30wO0LQtT/2DUa/ZKHz5zNvzpJZhYY
	Ax/YCvXvJCjZKTfQNQZ7gedCyAJngCrtIxIClF8K6wTBga/315Yy9CtBkCCkiTLeP9zBzMsSqPg
	WmZWbHv
X-Received: by 2002:a05:7022:458f:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-1273ade0790mr1375782c88.18.1771007754939;
        Fri, 13 Feb 2026 10:35:54 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:8da8:cd8b:c759:e11f? ([2620:10d:c090:500::2:357a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6fe357sm8178678c88.16.2026.02.13.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:35:54 -0800 (PST)
Message-ID: <a09239b03eea1a97fe4347e4441702d1880e73c3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace
 ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Fri, 13 Feb 2026 10:35:53 -0800
In-Reply-To: <a629ea64-b1ba-45c9-bd56-433f09d32abc@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <4150f31f020710932def63e2857ebab1e311b597.camel@gmail.com>
	 <d80a723b-6fe5-4dfc-8a9c-20fdb37b5341@linux.dev>
	 <f73c28386eedc3ad462906041a4962e3465b1a1e.camel@gmail.com>
	 <a629ea64-b1ba-45c9-bd56-433f09d32abc@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-13 at 10:29 -0800, Ihor Solodrai wrote:

[...]

> I kinda have a switch like that [1]:
>=20
> 	if [[ -n "${SELFTESTS_BPF_ASAN:-}" ]]; then
> 		SELF_OPTS+=3D(SAN_CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-pointe=
r")
> 	[...]
>=20
> Any ideas how to make this obvious in CI logs?
> I could set -x in the script executing the make, but it may be noisy stil=
l.
>=20
> [1] https://github.com/libbpf/ci/blob/selftests-asan/build-selftests/buil=
d_selftests.sh#L50-L51

I'd just add one more knob to the selftests makefile, e.g.:

  ifdef ASAN
    SAN_CFLAGS:=3D"-fsanitize=3Daddress -fno-omit-frame-pointer"
  endif

And use it from CI as well.
