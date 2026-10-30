Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793390438;
	b=fEieOyykjiJOFmzYiFtwDKETNSw145CXnfKiEbEVpethMtmqwxlf1JEuVZc3691/D09D
	 MjBnH+jYRyWGB+YJKCR0tygQRpOhYac84RMoZxOSLVJpsm7pdqnE8CwD7wfYSumW7yfrH
	 Fxba3/1TMQbfbznKjH+Ql/DicDsS21NlbFRuTpfBz1fUKlYy+dZPOOJnHKbxqVGWz7zcR
	 vaMiLOyrTa/o1KIpbhR24bDJ6QvPaSdgDVte5PRJvTl4RVzRGnzOHHiHp3H1/FZqJGdoA
	 L5MqQSSJuN865PmNgbwZhYZMn9+pgGR1dEI4YM5s+JwiyZ3O9/GByatH0ESRghM4hHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=koi6Ef2+m/47DO3oWpvXEzAALU7rcqt7MfMFCA4IVN4=;
	b=F4hpwCdovIWt+sO8Wrpw4z0VfrSVMbP+uPa4LUGQB4GYr/abgq4heEOa7CPvhn46393X
	 1STQ9fquefka7FK7euxqdfsaUnZQsooCEfZFcTsRLJEX4wQSp67sj3myJUlHHWEJh30kV
	 SN1I8ymxXGQ1q5Pb1W+6Cw3edElJwDw1nX9Fx6z5QaF34GuVHs0bpDCKKEd0fr5QblSr1
	 XB/DPNWI1xYndM99pshW9IV+QEYoMlCe47v9CAU6k0cpT5k1BvVStOMS/Qk5xPYFfcOVB
	 MUJXH8AFvxDxeIf89Sv1CH3lEi4V4C0AHm9AoQ1aaVEbV2qcYZlZvR39uMKKKv6apfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eizHqomZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F27606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 20:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eizHqomZ
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-5179f3beaedso585390b6e.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793390437; cv=none;
        d=google.com; s=arc-20260327;
        b=AfZEXoAuOWTsCRC5IYXOwm60fe2DulNhY1jMdZ7WyfBNQAN65cFsmlDb+bUM1O3rw3
         wqw4D8/Yg7kZ+U3YLGLKa9OjGAdMF3IWjngxe0jpJJj4aZhjL2belSiNMXNYInsvzCAQ
         CwZaB80fhCXph8b4+ZGweroX97lbX1PXGTyFG5C8kGbE3fe4pnmMk8+3r+7ekI1kd5ZY
         O5Q4FCPOaR8wyJtTDqV+ojvFZudHyn7LPpdPTK1MNbyrYPZFpI77iy1e3vsRHNP+0FJw
         yfBSOFDFWBl4qK3b+xFBXbqts9Gba0JonWmK2pAsGYrqfpNcBNGh4l5K94E6F0G+x6BQ
         Asgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=koi6Ef2+m/47DO3oWpvXEzAALU7rcqt7MfMFCA4IVN4=;
        fh=MGjB7t8Muz4iOoq68+KujKMPI+lDWZmbw9YIJYXtaVQ=;
        b=k/aHmT28cs9agxjNbeOShTzzDFEj6VbOSgjs1nYawwpiWlO3DzUFD0XKtrX1mubE0V
         FNmhbbzfX8vqUZMnKCBpUTZ+1TBXGYc++asnCOJMJmudLRa8ujnE+9fU7264+Qw/uXiM
         CM+IO7h5fSpcOyTWySvP/LlhN9kwf3Lpu9ttAWnRaATS1nHalTE75x9vGRKMQZWaGJJ2
         ld2qD3iZhYAJzf4/EwBuuiRXXWDRyaBGBgg1hnaMVWJzxvDF5GbSas+STZ6xefDQajXU
         PrAh14DN+AUPPXeMhNWG7NE55xO2Z4JLkFrqVagIhAjk+w+Gn5j5yF90sHVp7eOoNY+r
         5gwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793390437; x=1793995237; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koi6Ef2+m/47DO3oWpvXEzAALU7rcqt7MfMFCA4IVN4=;
        b=eizHqomZcPAk+VJuKiB7sMfMyl9Cv599GUw4km9fAhGHa7nV5NmsJak0QtYqTKo/RG
         VTvlHSn/48q5QXNf+Zv+acbIwWbTX6UO6WE9h6nb31TJpUUxXjRW1R9OjZsWfDfH2nZp
         njOHAGvmnHb7uYC7QGiIDuSrKYsdEqIGFA7XeKo7uNonSEVpiN9qQtAf8LAUZqI822U2
         1+Mey+LnC2IYEpitCjdjdWp7a978wialJyKWm+/R5eBD5yfAYpfx2xbyfpCSG2kGU4sW
         mUMA7Uv4aU3wM2p3QJ52SbqUyFSZvgbdZEvNInNezZXv9BolWPsckQzn4cxVdXU8bm8G
         I3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390437; x=1793995237;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=koi6Ef2+m/47DO3oWpvXEzAALU7rcqt7MfMFCA4IVN4=;
        b=s013LqESTO6HhWKmkbANEBlvjRLrL39krA8+Pw/H0pJhckY4muJ0o/LR8uLtQOGMig
         lVkSDY8sxQGJgU5OGsdqUEHwYhhgmv1bNUp24UsCBzKRez8+mDuCojbS5KLTD1947kMY
         B16rSnpLlU66F9Fz1YHw3PY3wA9CHjlyhzVPz684tVqocnwdHQYu7zU9YxiZW6xnNR/p
         dY9/ONhgqE3UCDC8Sz4Ps9bcj46DgS51ywteGN6tE4E81WUyWtKjnmb7N+LsAm3mfJ9l
         OzWNKPMn7hhnKOSkaTALuQRd3TFAq6yTB2Q3GWAk5b6BIQZa4sh++MPlwwXPh765kZQo
         CuGQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3DBlT8FXRI01M6+Okgpf+Bh6N7KA+oD92EEsyIdLF2ulLtOLGgrvqlFKNzgj0e9dy0yk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/3LQ0bCyne/ezxcDLYF68DwutMqp366cU6x8X/7Q/YnG5ZElV
	nCgXRxxAGVSczWm05mMspiaab8Uq8zKbCUaVIS7INLEQVLcVRK0p9AFs5vyYa2nyz3c2XIAhtEf
	cI+JXO3IgMgSNWyQjVujDkjIK9qdgjHA=
X-Gm-Gg: AYBFou0vhiag4UaB8ewQoYPLAnzH8G9YYOElbKjbi9/Ieaq8HRTVhdQ3eN6qLrhyoik
	84w8Q+zkvjckjrg8Gl4G9klFd8h/dHX96tc2Dwm0Hed2DIIWHJomvKpGu95OfwkVZ6+y4wuZfk0
	nd0XcMEy7ukSbJhQ/QLP4iDb2wClUMdH4u53/UyLGi8VG7EU+fbKYCqbAe2f1KO9gaKgtIMqQg+
	HEfGXB56D/OIsH1SC7sRY1Yjp9UMKs+Ue+iKr27E7rm34/6qysVUsMLn8cvXg0JsewaiGwaM/Jt
	c8Jrkou7pMPK0euui41CnWQiy5t+Wr4ngnNsmyTzmIy7b6BLx4tW3cRZKOYaTdYe4SrFy369KpG
	cuy1qEKq8f7DROE5J3t0WrxSfNvrRmTdPXbOZzQogOevAdB1rYO1DMmzT99ol6lT8IV2/LUc=
X-Received: by 2002:a05:6808:1825:b0:4cb:f21c:a795 with SMTP id
 5614622812f47-5640df3f277mr2290284b6e.29.1793390436781; Fri, 30 Oct 2026
 13:00:36 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030090913.76944-1-dennylin0707@gmail.com> <CAEf4BzaMDRa8xD1oR587P82MYKCYR61gyjgvjKySSnnqFb27pw@mail.gmail.com>
In-Reply-To: <CAEf4BzaMDRa8xD1oR587P82MYKCYR61gyjgvjKySSnnqFb27pw@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 30 Oct 2026 13:00:25 -0700
X-Gm-Features: AclHuK8Xu4GB5CxACievL5wSbOSvDys3jplk1ETr7iDyEDPp7WgT5OmNWiFCt30
Message-ID: <CAGEkeHcq7HeecPyTSYuHWMhCyOAbF7br+UjrFfLiQmgi6kTxhw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpftool: avoid sign extension in unsigned
 enum JSON dumps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: qmo@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> please drop RFC tag and report with Quentin's ack

Reposted as v2 with the RFC tag removed and Quentin's ack added.

For future bpftool fixes during the merge window, would you prefer
regular bpf-next patches or RFCs?

Thanks,
Hungyu
