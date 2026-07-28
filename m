Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94347A862
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281301; cv=none; b=HQ7TwKUjMTQVcBYWsjQ0yt8Z1wLBKwXx0jX6trgFLdu3UBww20xMaNY0KY4h5jv012mBfO2fYgH3Ur/40qcw5dRmOM3trkiF70uUceBJoVA3CuXdvmn3e4e9o8U+L8h61AT+W9lZDYg2fumVGex8XTF2OLKHNdOFaUvSQ63qg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281301; c=relaxed/simple;
	bh=WE2RMSzRPf7DDQZEcwS0yv0zbdw93XAGK3ydReqc3KQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ga/6gNpcZEcWY+ZSSrZnDYJhd7KObW2K3u/dJDAA87HuhVDKjYLrBt2Ulge9Fgxa8cy7hgKl2lkGbVcvL9uXeWqeHREBgdKs3Zu+pPGujEi4TAinAB+Cf/GZKAjcZ0b6NhDYjpynm+MveYRPFDzE8MjoiGOQszZOGLuxmZu1hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0pMjS1W; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0pMjS1W"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e7109321dso210214a91.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785281300; x=1785886100; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EDTWcg9smDGyOPZ/CcGP4ZShZmqvB9amjqwO/70m1hU=;
        b=g0pMjS1WkJ5pfn6uQmWmg0DXduBMetGdSkVAzeqiThW7xCimEG8fU/w8LUX78ZzIgC
         TgObBLclekCZMbGY3z/PR8xJlemfbuL47+aee82l5f0eAKAdYIWQuDQP369TrdbJRrV2
         xFAsGbu89tgDakDeCh3axVMtBmXGa9DxE2SPZJLggi44JpQLB396G8fB8PHp0h9Fv9mC
         pghIplB8mWBYwwQf1Ey2d6aRaldG8vPj21zALz5lC8LVtMdsUKPsYQIaTLF/k9zFgZ3c
         cPwSteTadltwpH1dK79q9quCMldvrQi+RhlnvZ9y60ww3zlxdRqpNKBONxrfxj2WXkD5
         9n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281300; x=1785886100;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDTWcg9smDGyOPZ/CcGP4ZShZmqvB9amjqwO/70m1hU=;
        b=huVSNjJP3A6hbOyDtA63dsqCwEu70riNc6CiFTC/78YimIi/FxUuUfu7Ev0hM4Vgvj
         zfUzJWdPbOarpx/whiW6IHtAoQc60vJB+TUPNdaoCQvEt74tO8pmrIDhjPUyics8vzWd
         YBvnyNYToWLYUbUgwaaTxo6cdQ0ls/w68ulf/0ehsQGj3CDr8QeT4ILPme4TAaOTdCzz
         i/3Y+aZIMRB9lpjKMQYU+QuzsssTh0mMjf73sHV/GAJI9+a9TT02l1JjNSsbU6Mz4GiN
         ZPPTszzOFHs7JR+aojkkaJQsnPMIncaiMD7Nz8uvQlzbZUHCLnzBhk9yLfZAFMgD92l/
         mz0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoAynnHV7OzPd6ArAFqWeqoBN10jH6W9HuEFGcKzvlAgx7zhE/tVO049cvYyNOBjsaIMIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJuV0B0jLs826wm6ntYyB4andovqMNNUTIs45QCGdB4ZFdlD9
	1pbGkgaWACZLzMH+6fx13SaksDwTZe2BzDP31oh0jQeVB0Xh3Wepvqsu
X-Gm-Gg: AR+sD12g/SEy/PhdXKwkDzKIR79GXqei44pp2L38/8pWJyjC42ianhUOatpwhiiZdSe
	r0LmFQjUTCKU4JC5NE6HmLqATf/QUJCNP9mgko9AvlPIzzvud8uWb1TDfpsgn/STNUtKUctNlWz
	xFjREaT6qEVOCR9dfADlzR9kgoQL9i/AubWrKO6KbghWdRYaTFfC+bhe2q9WPEZpoUDuE+ursrg
	59tqPmSj6cJteTtzV8oy81C1DyAWgDAcGG2qEnE26NAeigHiI1VC9gxvu658C7VoP5OZoRM9r0U
	wTgBFkeUOlkIIAI9ds+HpVEVnc+cOeX+5RZddZNTCblLF1y1HebK+OVqena5NCQWSP3uwRgCPgt
	0thAv4p4TdxhcT0KZ5ofdjB7LbRRvxt4mduCTsO77/2Cgy/Mz9Gp7jUHe3hnAYbFUJ9gSZFN2pr
	JBHyC4f8IchSXD3oJEHyvxl45a0PGY2SbQv5KfmwHjasUZFXoVxk43NBBixqN9mOdbYU+JUTyIZ
	yWueDZsmM4P9dXXUbQIEWjCyZ4gINIZCBzcwisNpwCXaj2We02Mtwh/
X-Received: by 2002:a17:90b:3a8d:b0:387:e0db:bc30 with SMTP id 98e67ed59e1d1-38f6a457c3bmr4202203a91.38.1785281299593;
        Tue, 28 Jul 2026 16:28:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a358:4bd1:35cd:2e45? ([2620:10d:c090:500::5:ff91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670dcsm2851374eec.7.2026.07.28.16.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:28:19 -0700 (PDT)
Message-ID: <7b46b97ab3380a657fed02d1f730d0cd7b484137.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic
 ensure_mem() to grow arrays
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 16:28:17 -0700
In-Reply-To: <20260722233518.778854-2-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> push_*() helpers in resolve_btfids contain copy-pasted array growth
> logic.  Factor it out into ensure_mem() - a simplified variant of
> libbpf_ensure_mem(), and use it in the helpers.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
