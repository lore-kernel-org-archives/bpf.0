Received: from mail-ed2-f27.google.com (mail-ed2-f27.google.com [74.125.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBA3B774B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197642; cv=pass; b=i2IJ9Ve4ZDQATFjuqVwwciSbMTGEBjvSbokjdsIgOJGoLfCznbwX7lVIRsKyItywU2tA/GBDFe0wCnA79H91Q6PMY1uh++QCuKUmQx5NkyRFhJU8Wt4b6BRk9tUzY3/a0hos78IM7dQei8sabMJ1g+Is+ObkWBjOQsL97hezzG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197642; c=relaxed/simple;
	bh=Dem5nK4pGkIGesk25ZB1fjJQVbSK5tclia2Nf7cl28o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+/HuV/8zljA301GeXBygRaXZlMgRG2c7uoGW4Qfrju2GdKNwmp8P11oIkAYgqpsD51Z3IGqK3drjl2h+sM20gL6PiR6WgctSASsRU61Egarg/KPlawemuSj2JtWKwijMUuFJ0Yl7eC5R4Ocuf667veKqB53wsXxQoVG2/e9TrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bCAAER4d; arc=pass smtp.client-ip=74.125.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bCAAER4d"
Received: by mail-ed2-f27.google.com with SMTP id 4fb4d7f45d1cf-6aa135d6e97so2199366a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790197634; cv=none;
        d=google.com; s=arc-20260327;
        b=HAvFy92jxX3qIZp/bSPueWkOqVa5eYWA+9JlIkMUSIIupu+9Sngl+EtTqWMl4sE7I4
         souvJ90f1qqVu3uzFWktCKBv6QjmXGzOYTWHtI4KYIfypI048grt0eE649pNiSUkPdft
         QI0nAkrAe6S5NDokT05lTA75tjzn+ZdKtVnV0qx+68/hgEtI5412PnVi0hPoSC2LcCaG
         qDJO1508kYqBEcZnf1Bt3bL4gEFhnptQz99K4JpcipEn1sDr3sUyVHMqnOm+mxdhwVTc
         ENM72ZQfBQWJsWmWgyEVoZB6zji4sY4VlRfRKNH/S69+Bi1sGPdJSIP5CiS5viUtyLTX
         AuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qY60ZsRG5qhxIjnmQPWdSglWYuMq5BNKrqrKyqL2BrY=;
        fh=kD+RZbhRP5DkHBlaZv40B/BZRjmvZzEYtxdZIh8F0o4=;
        b=Ess93azBqEyPmegADCDH3g4cD/9EKRw80E6JMFR5iBIT42HXQjCOBh0jxU69+oBwmw
         TY1aD6apIYr7MkOFjJ944a6AsWy2vhWwZJcggxw1s+j0Lw/CDpgbdeevS6q+YfD5W+WK
         Ebi0PI5THdEQGTvoNln1x4xXAIDOXFIJdZzwzZwFAUboQ+tCN35nM6Eq95nFZJm4Wngb
         N72HEd+eLSoTROAx8dG+ZbTxx0dS/vK3LBdlenMP9pBc1TMqFS2cccHH297Skh+q1gbc
         L3d5cuHRHUgpw41bqV/TD7OkmMfKxsoPYV+vvhMVddwt2JIppuPIeceXJ8Bs4DieCE6e
         kkUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790197634; x=1790802434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qY60ZsRG5qhxIjnmQPWdSglWYuMq5BNKrqrKyqL2BrY=;
        b=bCAAER4dg/jSHIRYOR7qihHD5nLu4t8dN4m1ecxYAHyO7f4hoSN3Rwa0u2JpsmBed6
         Nfl7OD7nzJ6fUxPdpjhSarOIk2r28j+ePUwNO+SxZmTF5Xb9C4kCeUFVSvcOC1Pr+644
         eQC/gHgBT9+/rf7xPKrLpkSG/FH+Uchaeyzq/V/EYc7KkdYqXCNLlTVV+GmAmLdS+8/I
         VArVHIzRXVKUXJYNhVjCVpvJt7zP6wIecXWzJOLMEpJOBmWEjJ8d8qbRicf4Pm2O8yPH
         I0kFWN+OE+/H0e0Ux8ctPPVQKxpw6i6z0TTFTKiBT+CGlNlRuMrtzhmdYi4nVGJ+4DEy
         4P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197634; x=1790802434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qY60ZsRG5qhxIjnmQPWdSglWYuMq5BNKrqrKyqL2BrY=;
        b=C9i+4s+u6slT13yVLFSE6J1V6Lq2N0FR960+yjOvwm4G+7COixf6q66cXoRUK4dIiz
         zsyMWpVnFpv9Fpdn2IqwGgTe1QpNYC5FkqXpJEthYbzLH3seLHEn2FBVxdVRqZOgRXBL
         CWSSHV+wnpZxDm5Bn0JUuRSMUjCOVMGCh7RIm2MBFAtv3byFH5MQ6XTbvzhr69ERbfGi
         KPlfDDkXPP3T3xkGBjf28Ql2UanxBQ9Wjl2Cw6XGnkMXjHXJ70y1T8yu3Q/bnX5sUEWz
         fk3/1ZF3PKuITu2PnZFsUTOhqc1NGN65CFgCHK27ulVoNZuOEQmNaTG5pQqCGF+t9Z3F
         sdFw==
X-Forwarded-Encrypted: i=1; AKwUvBxBJT3ECDpnrqq81RgMRgbqx95Z/n0UXj7aT/a3xaFagAb3EG6wcPSeVglvULtFSvWmzC4=@vger.kernel.org
X-Gm-Message-State: AFuF++ntFoUHtEYuAK0JYptRr5nnLEP67QCaRlrnw3eBgvoytgzp5qIu
	p4Wa6XO/ksxwNVXRFVYM9xYXW6eHmCrcbJWWiYKSxVcNGc9caQ3hFKO1+yTYlXFLS/rxukJP4x1
	5cEtooZ8zQU+WzSc1oeI+VT9Yk+Os2hY6hOsUlDeH
X-Gm-Gg: AYBFou3B6Ww99quiip/lNUdUaZfRl4HDwEfyNHEZVaEcDiHhLSGzTOLC6dZt9g++voG
	G93SyeIpQ1vvk1J9KYBQ9HFfMfVrF1o4hhJSsC6Ghe647kOFInWEJ0eIMlVMQOieoWV3+x08Z5W
	vmKnB8ayhsy+cuo4pGVPp07MFIVAhRmXyt9veqHjIIo2emgz3KcnTTRf0FpheL7JcNdUSqConWd
	j08rhyZDPJca/sllHt5lqk2RKDPlTFM/7xwYdyWP1nnyAnCbo+famZAL3WrtL4lIwG/L6T+A1ZD
	ZvRifbfSnR0FBZhtBnNu5Q7Z6aJjYd/qQ5kZzXLQlpBXyQnz2fkSgosjLeOHvuTFqyNnCLrAAL8
	ARIakq3J1m8k=
X-Received: by 2002:a05:6402:388f:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6aac8f10129mr413713a12.11.1790197634286; Wed, 23 Sep 2026
 14:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com> <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
In-Reply-To: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 17:07:00 -0400
X-Gm-Features: AclHuK979p08Ta0TyW85fwx2_KJpKtB3aJaWYoJNW4H4ynPYtF25vr6stPl_yEU
Message-ID: <CAHC9VhQzW_tCCLyMwkuFhoJhiyC2XSsUyQF19+Ag8X1=J75qUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: David Windsor <dwindsor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:14=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> This implementation was chosen due to its immediate mergeability (it
> only touches security/bpf) ...

Ooops, I hit send on my reply to you too soon.

It's worth mentioning that sometimes maintainer objections/NACKs can
cross subsystem boundaries.  You may not have followed it, but a while
ago a LSM was proposed that implemented BPF program load access
controls and it was successfully NACK'd by the BPF devs, despite it
not touching any BPF code.  An argument was made that the proposed LSM
manipulated internal BPF state (there were arguments on both sides of
that topic), similar to what the proposed BPF kfunc is doing with the
LSM framework.

Hopefully we won't have a repeat situation here, but it is worth
knowing that code location alone doesn't necessarily equate to
"immediate mergeability" based on recent history.

--=20
paul-moore.com
