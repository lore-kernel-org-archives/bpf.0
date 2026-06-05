Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FA1C695
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622996; cv=none; b=IqQUGXTnLQe9GCNKK578btlhHUQNaeNHbB4871wxiMR/dYCvPT17E0/vJQrTkT8fHnXRv9X7lR09+SglsOzlWFgo5aDQRsOmW1F2qM3/argNvuACJGr5Z2pj6Su8A07vhN3s5mc+zJLo8/YknP6Mwa2gzAzO382twe7mTS1P/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622996; c=relaxed/simple;
	bh=YKmllrWaSmYsL4IaBLOvWmpUXRvOPAOLT+u/THSBB+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzAFR3JfhevC1BHbHOctgZMDnLVM7p/80O8zvWbC5ZUA+dv8BUvUojH5PLyiZUOEOKA866/DvUH9eHRkDRdqTSSBlq+CoDIb5cYpxb2GmBcZzSo9i0UiSnL5252fUXV5WgiskhyH1VJuHLVV1eW+Ha2/SPtxmUop9n+ksDF4N+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+vitJCg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+vitJCg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8584e80bd3so578267a12.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780622990; x=1781227790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQWEjwaD6ayUqvAs37UMwrhcgTQN1s7ArIN5zCVLscY=;
        b=o+vitJCgI5e/XGUk32kqhH4y/VTXsfUZIWZKlssfLUsyjceRXrlveXkHTCIDAqMklA
         6C3+cwKEdz3WcmZip1cJoBaI2ujgublJ//lGB9U5JoGxzPiMmBf1tTGMnrTFJgTLuJUZ
         9wUGbOeRFhLQOIp11EkGw4jfY++Nf7zKmbB7dYceNSzMXloXL8rKwSJP1mfXfKZFsvkH
         Q5ynEQEQKRKwvr7uLGcDGwNQLMIds6Wnter6q4k+GmjQcAtnDugCLms/9uve47HhA3Xq
         ztvr3MKahtgfkUsD2aJMS+viaRJIbLeMWaTSs9ieuDHUlawKH6cUHXRjr8uA+0qivwyC
         K9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780622990; x=1781227790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQWEjwaD6ayUqvAs37UMwrhcgTQN1s7ArIN5zCVLscY=;
        b=pw9gGoPFQFTgsZf0cL0yQYHzsauHpNmcYkY187xymfdSQ9pKQp3Ns5sQ8q68lA+gFV
         JbMms7iZn9EcJf6Yi4fibAm8KOrEzR8CvXYJlE6jYPVujd4euuYY3CDPmSb2pPQEYnDb
         eVserLqmQJsdKljckfgXrdY3Yn2N6+we43CNLgd5iPV9gDm7X+4EJ8efAPgSmp2tMx3X
         SFztHnRhyJ2nGzrc/52xdKYa+fBFx0eUIuALavfpkBe/0sx6nLHQMstF/OMX1uT95e1j
         jYMf5ESnVQNjBiLYPtGt+n1bFF9UyQC9s/0QWuKL8KsLBJkssMYiKaMRSP85P6OYuTfy
         o43g==
X-Forwarded-Encrypted: i=1; AFNElJ+6SM/GtwTze3wqzqCPES6EDXSpQhgWNID8h0dIxmEz36lZE4B8ppyN+oVS+pfiHN+ZKrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FQ29zwjzeAkzq6KhmUVlsozeuKDrDGI+vWUWzDyPzYhw2cBL
	RRpLd1IqZAFpP9gvSEYCaD78qy2D10yXx5JXWo+7CJrq0z+hNFgL4rLqPLa2TZQZ
X-Gm-Gg: Acq92OEfia4EadBu7UqMFJZVgfQfYrBzNjeG5O8MCyf16Kkt4VK6ABi+mM4iKSFNBDG
	3i82ZHnkyD8hBZ7vbNzbRpBQsBz9iAUaNDzMgMCjGpIflhHGv2+5nYy8KNdpMHLVQZmTHtzA/Zr
	4FKV4ba2cH/05+HPMGVDvqxiy08bmzjUID34Sa9AcYGThgGptKiyPiu4N1Llhi1jKn7K00hAvrz
	a0rHqbD9LEsDGer7pmyrw+abzT3yYPF+QDxUQNI4r8FO+6bTtwdSm+6rZ10eCbbcNjaV9i/VVcA
	RJRCCeH95KHePE6R75DIZCIEQ4rw6etYq4sCGwFeSBiaSF+WAhWKVk7IuiingBGszHOQvpe07FJ
	6rsjnbmPSRsSmo0FYshs3K3OoZ9NQgfRByZh90nTUU0wUvqHqp+Qy1yTZk1bRiYpPz7tta+A3aP
	fyFY4YhELKr41sxgFLKF0ZeEg6pbEWuF0NVGba1P3pKUvdHciiVQYFS41lEJPKitByybEIie9v
X-Received: by 2002:a05:6300:197:b0:3b4:7880:10c9 with SMTP id adf61e73a8af0-3b4cd0a20d9mr1597912637.43.1780622990326;
        Thu, 04 Jun 2026 18:29:50 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm7648388b3a.42.2026.06.04.18.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:29:49 -0700 (PDT)
Message-ID: <a171bbc6235a3ae7cf75b95a1e9888b97f2734eb.camel@gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for kfunc
 implicit arg injection
From: Eduard Zingerman <eddyz87@gmail.com>
To: chenyuan_fl@163.com, yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, ihor.solodrai@linux.dev, 	jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, 	martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org
Date: Thu, 04 Jun 2026 18:29:46 -0700
In-Reply-To: <20260602093836.2632714-3-chenyuan_fl@163.com>
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
	 <20260602093836.2632714-1-chenyuan_fl@163.com>
	 <20260602093836.2632714-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-02 at 17:38 +0800, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>=20
> The preceding patch fixes a silent fallthrough in check_kfunc_args()
> that could cause the verifier to skip bpf_prog_aux injection for
> KF_IMPLICIT_ARGS kfuncs when module BTF is inconsistent with vmlinux
> (e.g. pahole 1.30 breaking distilled base dedup).
>=20
> Add a positive regression test that verifies the injection path works
> correctly under normal conditions (pahole 1.31+).=C2=A0 The test contamin=
ates
> BPF R2 with a magic value 0xDEAD via inline assembly before calling a
> KF_IMPLICIT_ARGS kfunc associated with a struct_ops map.=C2=A0 The kfunc
> validates that the kernel overwrote R2 with the real bpf_prog_aux
> pointer rather than leaving the stale value.
>=20
> The specific pahole 1.30 BTF mismatch scenario cannot be tested with
> CI (which uses pahole 1.31), but this test ensures the injection
> mechanism remains correct and does not regress.
>=20
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---

I think that such test makes sense, it allows to verify if implicit
struct bpf_prog_aux parameter works as expected when kfunc is defined
in a module.

However, I'd suggest to hijack bpf_testmod.c:bpf_kfunc_implicit_arg()
and verify a field like aux->name. Hence making sure that bpf_prog_aux
is passed correctly. E.g.:

  int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
  {
	if (strcmp(aux->name, "...expected name...") =3D=3D 0 && a > 0)
		return a;
	return -EINVAL;
  }

Thus keeping the changes to a minimum.

[...]
