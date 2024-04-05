Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB59171E42
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338867; cv=none; b=qgwoDcJdQ26CCtqGRdgZHR9TBPMRKzqE4Vr4mWShLPHiumqe1AQsM+ubC79Hn/j43eMrCVUUJIxPoZgIxyqecvbnk5m5BhzEInvRGFlX6Hwgb/2qViQw9+FVX6+V35PMSuAXz9eAbvcywOLK5pTQ7jcT/VAa916BerPIvEh2z0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338867; c=relaxed/simple;
	bh=eb3Mxd4smQYpRn84An2igz/2wzzVEUxm9Kf9/d6HxjY=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=ZOQtREMNwC9o1bXhQ3P8dkUR3i37XLpTCwHkkbpEg9TM6RJgCJLsGrcm1vRPezAeLOM9o5hPpXm1M5as6qh/+pS2GZfrtA4Zt5KxyHHqQ1TICl7qfLhb4kHW602o6LI1AqpwT9PhTKBb+NzfrAQlwSr+oau0fIPRoAfk7ogNSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=EqNX3gHP; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=EqNX3gHP; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="EqNX3gHP";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="EqNX3gHP"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A49F4C1840CA
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712338864; bh=eb3Mxd4smQYpRn84An2igz/2wzzVEUxm9Kf9/d6HxjY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=EqNX3gHPAn44256JIpqOAY70fRPUyllTzqlC6np2xktoCRAIA/MVChm25iKu1rkFt
	 R78ILrDjhPt/IX3ocFP8a+RldVdPXB7bNlrf6xVZhymOh9cOwRMB/jl845Z+u3ZgID
	 lYRLjXciIzc2ZdQGZP1Gq7zSCqCHHxa71Wo8LR2s=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Apr  5 10:41:04 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 74E76C180B5B;
	Fri,  5 Apr 2024 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712338864; bh=eb3Mxd4smQYpRn84An2igz/2wzzVEUxm9Kf9/d6HxjY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=EqNX3gHPAn44256JIpqOAY70fRPUyllTzqlC6np2xktoCRAIA/MVChm25iKu1rkFt
	 R78ILrDjhPt/IX3ocFP8a+RldVdPXB7bNlrf6xVZhymOh9cOwRMB/jl845Z+u3ZgID
	 lYRLjXciIzc2ZdQGZP1Gq7zSCqCHHxa71Wo8LR2s=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C1C9FC180B5A
 for <bpf@ietfa.amsl.com>; Fri,  5 Apr 2024 10:41:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.649
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVzgJa-YgUOV for <bpf@ietfa.amsl.com>;
 Fri,  5 Apr 2024 10:41:00 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D20CEC169431
 for <bpf@ietf.org>; Fri,  5 Apr 2024 10:41:00 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id
 ca18e2360f4ac-7d4418bfd53so63644939f.2
 for <bpf@ietf.org>; Fri, 05 Apr 2024 10:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712338860; x=1712943660;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VV4/WsIw0bjyvw7kkAcl0orY+3uhEqN5npfbyUmFwcA=;
 b=nxbvwda/jNk/fYZgR23poRXhcs/5gnM+5IdIKqcdPIS59rDfv8+dQthhC5UWynjIWm
 0UHwBUpJI9oq9KN8v4e6rsIF3QQrT+CNIzK6VyaSVXt43LuUJHJOjWMjPb3D9t8j9WY/
 FplGFtp0Py7XUytLYNxzgF0hbzY0+E/ZZVT7b8F/ihWr9PbkUdu/HNaDWWSAeesdEAWz
 EU6+OV11jaE3HDMfpQ2GR5geQRxOnuxWl9W/DI2JKejiirCFd2lLiROZ2LNQobSb98M8
 EEXULjl51TnUs6+oG/iAphCQjr9+yp0ibnq5mQxnTLxTFROV5lYe5D4NGLSn1rh88ZNa
 z7KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg9kpKSnaS4vPXXu+hUwKCJ9FrRTPwtPxjjZwp/KctH5KMZfz6lAk7xuLFM+p5n/8PbAfp41CGmE2tcq0=
X-Gm-Message-State: AOJu0YzfeZJ62wbQmTAeHXc+y11ZZE+37FGfSaao+2YPhJUWKc+a0LPY
 b/e4MPw3USt19pfHh3HjqX/hLRFiyJPQDGnGCD0q/VmVqAARroTM
X-Google-Smtp-Source: AGHT+IF+ljzQYwGcrc35Ddph03ruUQB0OlgeOO0DesC8YfCHNSyuudE6WE4/sWGSULHY01CzSg3uSA==
X-Received: by 2002:a05:6602:884:b0:7d0:c0e2:d0d3 with SMTP id
 f4-20020a056602088400b007d0c0e2d0d3mr2292565ioz.19.1712338860019; 
 Fri, 05 Apr 2024 10:41:00 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a056602340800b007d5c94c4b9csm35499ioz.25.2024.04.05.10.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 10:40:59 -0700 (PDT)
Date: Fri, 5 Apr 2024 12:40:57 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240405174057.GA19691@maniforge>
References: <20240405155245.3618-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240405155245.3618-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/euqP-PF1F-zOatKQe8bdaANHTtA>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Editorial nits in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============6610193770008589137=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240405174057.s2B73vv5sAbnr0e6w5NMGsdpPnLW-Fy-bLyD0KgKXaM@z>


--===============6610193770008589137==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+YnSGq4SeLXWNs7r"
Content-Disposition: inline


--+YnSGq4SeLXWNs7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 08:52:45AM -0700, Dave Thaler wrote:
> This patch addresses a number of editorial nits including
> spelling, punctuation, grammar, and wording consistency issues
> in instruction-set.rst.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

LG, thanks

Acked-by: David Vernet <void@manifault.com>

--+YnSGq4SeLXWNs7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZhA3qQAKCRBZ5LhpZcTz
ZBsPAP9dp9lzNrQOY0PZvp9K/Td5Gzq5gkkQzhz2Zll/lYgJhwEAm8WRmoxzevQn
3nLXwfuI+Hk0j5dM6ZB9nUljchTrEgU=
=v+fi
-----END PGP SIGNATURE-----

--+YnSGq4SeLXWNs7r--


--===============6610193770008589137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============6610193770008589137==--

