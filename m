Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB32AE68
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770864315; cv=pass; b=FGcVRPcqjpQx1QbflZpVOh+b7Y5KOaL6zGcBkZ9NEtwIhIpwpllIB4DkK1TpkgyNGf5N52Hn10ZOsRBDYlpkaESM8sGz7sthd2gFSoNE6MUZd9PYPMS8x85/ifUmc2NmWoOldHjhBKkp8nlxoRO4dqSONX92dM6HN9mDy3bUpHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770864315; c=relaxed/simple;
	bh=+DkHmrZiY23ZsJd2P/9FLhVGhA84RVVt1eivuP62m8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEaku/A+IUC4gnrIhcjWG/3afOQdxXQIomDN3IauRIf2VHlxo1VbbHmW5nE6e3l4dU3eZQKpApoOupIP42tD5907vAjApTmhNQe93J/8qcgh3qN6xHHZaeBgZzVIxij93H2ZZwm58H1+EG3zjnQXFTfHZG7C5nROpjpZIwvEefk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4RwJ3eo; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4RwJ3eo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso23215005e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770864312; cv=none;
        d=google.com; s=arc-20240605;
        b=gNLzGpVLIDihG0BFvj2FabFeF6ZSBl1koxH3yVRgorrT3jiR22hdaKrzlNxn3Z7BVu
         Plen//tIBxDi34ZWMnogCRepLDJhMrPNhpnLOxXCIdFA/QHxYAgm/7WX5+uFRLwb1v1K
         SywHvzlM1VX0OdCUUNReg+HXgXDPPoj4Hkpn5Frit8VAqkqzHHKVD4JnutopuGl2CbOB
         FN8+Or2a0+o72gzaASyfwOh2yLde3W8WtqgQTAo6TU4qpNm8h6NWPDmCraZZdEpNkQzN
         qR5q9DyaJFvprTNDaxKUGhSNLkQVuG4lERVCCYZ0s76BPMPRhpAG3sZL+JHjCDuxDO3z
         AlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+DkHmrZiY23ZsJd2P/9FLhVGhA84RVVt1eivuP62m8Q=;
        fh=P9l4dTrCQgV/aSIOTcDTLYRs1eeNi4L04NlWri8aNiA=;
        b=kFJJM6VywsBI+dCf33TTo+mPHGtDuhRNrRVm6qcaphQ9Q2aNB1CWh4pbZKVUhrhdg4
         NJIZCqSjzSFTnbiZ4ox86U0A4T49+jUueEWAP7AmPSy1ntFed2APl84bK/LFGrH8OndK
         rm6AE2F9nx9Hv0qpSXTQq7ke1O3wqjcW7yYvsSjYD0zv7zq1onkqUPMMNrF4pvSC2CxJ
         3O35b1g8YAhkXKr7r7+L6fm6wtJMmBgxqJeJ6ThMDUFSCwQ6ib1C8a0WsudQRcX1W+zx
         R/8Xcx6cv3UsciAOtKRqRPMYYqIBTzGm3xAy4faHx4ZLMmqxV5s3sB513NQBJq7AdUI/
         nFLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770864312; x=1771469112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DkHmrZiY23ZsJd2P/9FLhVGhA84RVVt1eivuP62m8Q=;
        b=E4RwJ3eoOYB0vXk7E53m5RESiwtnScp/ol8ugQt8q+9ZaHiLfVk0VhZbpHcI6T47vA
         fXWJWiPnZt/8cz+YG0fc+hbzXbvTlffSrgJO5QdtaHDUY0NTtJy9pNWXZQOhjQtO8zJZ
         36TZo7nOUyjb61+zRWHSM6xFDcuadJHezIFzmESjItkodmTKlDDD/UJl1KJ8F/hak9LM
         o0qaVd9c591PVzAH4F9atpmY7iiJK9YGE9VfT8xxerI5QDQAPzWBUP9aDGG8at3nd+qi
         4hEikzY+w0atq7I0JzfUCgSPsLD3M2GfnJj2IEHCKGeJZsfAKljSLMQlOZAiMJ3UeYCK
         zXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770864312; x=1771469112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DkHmrZiY23ZsJd2P/9FLhVGhA84RVVt1eivuP62m8Q=;
        b=dPELojOE7qzRbwcFy4xKGjiucHNjy3zH3a1YIyHyW6xpktzfxNQzBAtU1/Yck9e5ZN
         370r3gxFOGMqIOyY5FPicFTCk25bb1kFtW1MyLCGkKAcA5TwJDfR/AxEkJ/TVaeSTsqx
         uPwuw0MHCjIxMRhqYOv1cAg1cS49YPQnz0zUhgKvek1pTO4Phm95PsygYsgmebjkvgdf
         SgChOEeF99r8RYUjKpEOWsAEQL84dvGSngdcTtpW2yNKLFkOLyyPP5EAxQ3pBqO5l1zD
         myHfFRzDxiJ3GDqgQqxDC2RfcMpzpUmYNDU+Y+B/Da4cif7sUJIPpL99ZZFSMwHcCbFF
         2cpQ==
X-Gm-Message-State: AOJu0YwzwrTRdJyoB+LU8SB02it5m8GDdK5m4jqX/xPwpz+ckdDwLajJ
	ywV00JnNZIO2f4KJ2Bx0NoSBavugf3Mnl1iCOfykJUPr8AXATsriY1RN3o4zDZ/hsCvBevMxFZV
	1txqbvfZUSvRYQBSQawlE7v9Ea3cGlW0=
X-Gm-Gg: AZuq6aIQGPtCNMN/AA90xW/HfuQgws1naX47XJv0s0YhGKJTTR7elsuQC19jOcP18np
	i3BehuifcDLKCjPNhcr2MsFqZJS7L7IOf9c64TQAYx+bFYGRge4ntryBEFoOF1P5YyNGVX/5c2o
	jxpNduMuOjarBdHv45GTcK/9bC6BWpaQJ/HZUYZgRqfb/YvDJJhwM7CeF1w9nclhnLO0vXoIkEC
	9t/gilDbKuGXJDtUxQOjsGPhm8O+U9TeVMSAaNqknx/0S4XumDrcajFEBCRUvyr9graTeBbNmXh
	maant3QZ7H4ofVQFe0ogLRlQ8UCj7bMVUcrYAucd1tst7LWDiTWt8MPEeLnS0vHv4+HjXTF1MQK
	+ltFtX2SXMYl9bf17c5+Y6T+vlQ==
X-Received: by 2002:a05:600c:19c6:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-48367165be0mr6658395e9.22.1770864312191; Wed, 11 Feb 2026
 18:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com> <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com>
In-Reply-To: <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 18:45:01 -0800
X-Gm-Features: AZwV_Qg45-b1wFILGTzQNsT_nE7R_uJoKLyIxfVMQ8bXUG0BBNPsMMGx8vjL0bU
Message-ID: <CAADnVQJqBqBaUZjQAGdchePKZMT5BMop8Sn1W5jmVOKUUdv0OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Use bpf_prog_clone() in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 4:45=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace veristat's per-program object re-opening with bpf_prog_clone().
>
> Previously, veristat opened a separate bpf_object for every program in a
> multi-program object file, iterated all programs to enable only the
> target one, and then loaded the entire object.
>
> Use bpf_object__prepare() once, then call bpf_prog_clone() for each
> program individually. This lets veristat load programs one at a time from
> a single prepared object.

Any performance numbers that prove that it makes a difference?
