Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D2371CFF
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442093; cv=none; b=e+HTDEGT79yATcDGQsmoqBr2zueeZzSmqXVAeoV475u/rs/vAVjEA0XtrBqSljfk4F7tda0zwV6xA0On84lGslnrJIHf/n+Med4UCCYosNEZiCE+gX3CYY1t+qvdtAVPRiMtR6YbVRD+XcsCX3lXA81HYhFQGh3boBqWZ6SbDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442093; c=relaxed/simple;
	bh=51djxRjrezoI25mptBEaNWl08itMphJ1AAFPvSshInc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbmS9jUQdq3RPTeO2Hsa7jZ/Y0Wp1TGTZcZCAapPYBsiA+rw1lhs9YdcvV9QwE50A9U3gdNVhuXILWUbNSEtmwvtIJblqG5DqymmQt97jXkuG9Rup1QVAOR+Iuq/8YZuLWrC3885DpY8k7WWeeHtYqTEZFCHLdTztDWJUeeTgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt510l9H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt510l9H"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae4988e039so24787035ad.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773442091; x=1774046891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51djxRjrezoI25mptBEaNWl08itMphJ1AAFPvSshInc=;
        b=bt510l9HEzsfvSKowN2tdgYZMsXf9T+BXdc2o28Vnke3BoSjI8+jJ2ZQ4O9b/lCaNv
         fatoS1dYV+qFZZkZldxCqzllibAXFaENuTNiZAh1ZixL24VXRE5g2BJxrXCyJV8K77Lr
         8Tthl5oRoM8k1cyWueDddDn/IeIwdoUzwrO7Zv5Iov3kPO8O0DGEHUdyF/Fb735Op/M5
         3bJFhWoLUifpgMFnbajwTJYIF+zjkXNV6+Hwv6rshIe35Gr1MO4cZcCnNTITxqIX8gUM
         zlv6rWGyRunR6a/+yNKo9pj9cuqoVuCB1FQjlZoLZosuuvcLT3mKfNlOOZ6lXnthI3ms
         XlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442091; x=1774046891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51djxRjrezoI25mptBEaNWl08itMphJ1AAFPvSshInc=;
        b=cWrEBpWrA0NAt9qPl3PkT0uHY+DxdOCIwSKV5cPvsr0DbvTYUtEVRWBGHItVmWUJuA
         eP2EeZrT8flC7+x+HWYFlQPMnFvAuhTQiBWnXg2jqJD33LoIvZ9nIsbzeSporRoBfYGn
         zhdzD80oWkzVXbeYERJE1j4LurKV5HK5aE3WyP11eU21Zg1ZtwcCWb6cPdEKIdbj7tU/
         NQv7EDfFzK/J2Q5D+7Q3acjM3d4p5Iw6ttNLpB1tmtZo6fttrlrwHWvPBjkPPPYYN978
         2eDHeyRRZrd4d3JrwWrCt9tUqhodv+MabWrB6T9zKBtZqUj7hMx2zscpymYOYXL+t59/
         urvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2RAAGBGSVCTEUsLejOcqBkuoLWMmerodBoIUtGGCCZw7+rgEqFkdOpvD1Dzs+KaEKI54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIniptyUwol+uh4X7L/v8EZyM52JLNXIU1JNH22hOrHwm/2Dx7
	z0igzjXNi7y+UBNzkXUSzoMEtwhHjUw1FwptDg+7+3Hs+uzXFizhXC2z
X-Gm-Gg: ATEYQzz4TKycfU/+FNJib1Ta36afBodlcUnzNZSlb/RlLTz9J6ZwcqZwXdMys3fn+un
	BGgPVoPSdhUH0B77cf7J5FzpZ1bbfDNxs5mb0XSW7K355vO4kdpaC6Pjls4o/MGxmOJg4gg3aw8
	FMoXi3p/QMeT9/imM3ME1eWd6+YGT8G5fvKn2k15sOpyfewjHucy3ROrRKhTdsECbtYh4hAJd7D
	0DmqksPotdGouZ8834pw3PzLJq6Lez7KQOUkFTqUzWI7zAU69+Eu1iFCuhvkGo1UpQJi2YmsMHh
	hCmBlOLl4BOYVUB+8bKxiKjE61mRAcV93D9HrTQ17gnmDpFAXAiTboRIBMjdIvPQWlnhiC0Isd8
	KmX6okhvdU7HhWmit6/UaRrkFEPWCk3mTl8MFCKPfKaD3bVwYLeYCyjHXMXET8CHjJpi7u7mc0L
	omt/DfT4ksJbXI/n75sir3Nt3mNBmLyym0qs4tQuzJ/KcV2D1yK0o=
X-Received: by 2002:a17:902:f711:b0:2ae:5350:3a4e with SMTP id d9443c01a7336-2aeca5ddef0mr53866705ad.21.1773442091299;
        Fri, 13 Mar 2026 15:48:11 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8098ecsm38305465ad.64.2026.03.13.15.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:48:10 -0700 (PDT)
Message-ID: <fdbfa0ce1cf508a9dc082036125634bfcc06c8e9.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add tests for
 maybe_fork_scalars() OR vs AND handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Wade <danjwade95@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ameryhung@gmail.com, ast@kernel.org
Date: Fri, 13 Mar 2026 15:48:08 -0700
In-Reply-To: <20260313075318.11847-3-danjwade95@gmail.com>
References: <20260313075318.11847-1-danjwade95@gmail.com>
	 <20260313075318.11847-3-danjwade95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 18:53 +1100, Daniel Wade wrote:
> Add three test cases to verifier_bounds.c to verify that
> maybe_fork_scalars() correctly tracks register values for BPF_OR
> operations with constant source operands:
>=20
> 1. or_scalar_fork_rejects_oob: After ARSH 63 + OR 8, the pushed
> =C2=A0=C2=A0 path should have dst =3D 8. With value_size =3D 8, accessing
> =C2=A0=C2=A0 map_value + 8 is out of bounds and must be rejected.
>=20
> 2. and_scalar_fork_still_works: Regression test ensuring AND
> =C2=A0=C2=A0 forking continues to work. ARSH 63 + AND 4 produces pushed
> =C2=A0=C2=A0 dst =3D 0 and current dst =3D 4, both within value_size =3D =
8.
>=20
> 3. or_scalar_fork_allows_inbounds: After ARSH 63 + OR 4, the
> =C2=A0=C2=A0 pushed path has dst =3D 4, which is within value_size =3D 8
> =C2=A0=C2=A0 and should be accepted.
>=20
> These tests exercise the fix in the previous patch, which makes the
> pushed path re-execute the ALU instruction so it computes the correct
> result for BPF_OR.
>=20
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---

I think that test-cases 'and_scalar_fork_still_works' and
'or_scalar_fork_allows_inbounds' are somewhat redundant,
but given that [1] only added negative tests let's keep these.

[1] 9160335317cb ("selftests/bpf: Add tests for s>>=3D31 and s>>=3D63")

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
