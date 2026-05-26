Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6A35B653
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830921; cv=none; b=rLMyGN0r0cWpG0j0GmPirynxsP3axSLEFzWAY3rX4d2kAzS2WBemJGccUpRJQSZgHraUXpLYU//ebtRWPDRwfnPeteg7oPdGv4h+vQcCXfZJ/fH95WevTFO/QFCM0513FUTS8Uv8flYQYErUkoTeKutpi6GF/+sPALNy6rdi6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830921; c=relaxed/simple;
	bh=e6NSWn/tpiq6nXX2EK4sOlqZ+GnkFkt31tX7hMXssFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZtysggh4Rfue0Ysj1gWGy7SUwVVA9UzIeTWrEoFPrCprSdBaVrZVTWCLKfFaR9F3d67//cYF/9WcEW29W5mlnO5MiNcxxMa21vB75l33CAUi52yG/1m3syJXR6paIZweqS/X2ojWtY4EISVi17wvanY15OlkQuB6Qxj5mMGiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BePPDwDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BePPDwDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1053C1F000E9;
	Tue, 26 May 2026 21:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830920;
	bh=8mE027cUWWzoAhci92Xz3g/mO1fL4M12xaY5Q7W1dkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BePPDwDZBPh9ZOexuev3yO4rtcqkRrGAxYHPjxyRqZ+8NPmsiP4ffzx5zSMoGdhQN
	 xubpwme5xL4F903KqgblSbeELD6C1IoVJ7whYlCqxwXsvP93FeaQI4Oh1ukJcwPZ7q
	 6irDfO8BeBigtzpMzZH3RkDD9GG+uhqPeqeojj9pEzAYCIKjD2mPFGa+J00dIDniz7
	 chHrDcs4pA/4ilWhzZ+TF0/Mry1to45OEUA39gw0SFXL1tKK+0Ktj1HET7Rh4cotM8
	 tEIC9EbjGNqLH8c2qoGDZkF8yQtQMJ7lmCi5nsNbnNAuz61JXp++A88qcJvcIx3Tc7
	 FHeWjmnSpPKrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 06/13] libbpf: Change has_nop_combo to work on top of
 nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526205840.173790-7-jolsa@kernel.org>
References: <20260526205840.173790-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:28:39 +0000
Message-Id: <20260526212840.1053C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch invalidly replaces `nop5` optimization support with `nop=
10`, which cannot be optimized by the kernel, breaks backward compatibility=
 for existing binaries, and causes selftest failures.
--

commit df13b5dc7675e7ea56d8d1775d22295b93e92ab0
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Change has_nop_combo to work on top of nop10

This commit updates the USDT nop combo detection to expect a 10-byte nop
instead of a 5-byte nop. It updates has_nop_combo() to match the new byte
sequence.

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52a..484a4354e82ba 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
[ ... ]
> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, =
const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] =3D {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] =3D {
> +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	};
> -	unsigned char buf[6];
> +	unsigned char buf[11];
> =20
> -	if (pread(fd, buf, 6, off) !=3D 6)
> +	if (pread(fd, buf, 11, off) !=3D 11)
>  		return false;
> -	return memcmp(buf, nop_combo, 6) =3D=3D 0;
> +	return memcmp(buf, nop_combo, 11) =3D=3D 0;
>  }

[Severity: High]
Does replacing the 5-byte nop detection with a 10-byte nop detection break =
the
kernel's uprobe optimization logic?

Looking at the kernel's can_optimize() in arch/x86/kernel/uprobes.c, it
strictly requires the replaced instruction to be exactly 5 bytes. A 10-byte
instruction fails this length check, causing the kernel to silently abort
optimization and fall back to an unoptimized int3 probe.

Additionally, replacing this entirely rather than supplementing it means
libbpf no longer recognizes the nop5 combo in existing binaries. This causes
existing USDTs to fall back to unoptimized probes and breaks BPF selftests
that expect the +1 offset applied.

Finally, if the kernel ever updated can_optimize() to allow 10-byte nops,
sys_uprobe() currently hardcodes a return adjustment of regs->ip +=3D 5.
Returning +5 bytes into a 10-byte instruction would resume execution in the
middle of the nop sequence, which could cause an application crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526205840.1737=
90-7-jolsa@kernel.org?part=3D1
