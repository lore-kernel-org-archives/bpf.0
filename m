Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED74248A0
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085507; cv=none; b=NdS5n/4I/revS/XMEKn1mSNqh7gzlpoP5Q3+P6j6gnP2Qf/7nmCqoJX7dVhiv842ms+Tg2U2XXiq2bWnKzavrh9uxPF82rOxF+2uwwngO3mx5pmkTH4od0Ve5nZDsXEZu6itAoV134CM+MiG8AFbaoJh2808E8dELXHlifRzyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085507; c=relaxed/simple;
	bh=Hb/p6C/ug3uEiSS4DEcoyFX6xul2M1nRpaD8Sd5SDgk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AfrMq50rCHoLHv4xPATPciyzwfiD6M4UalvvCXKVs9GmPkVJKMqyWihECKgaP/1BrEfbfGB9lcoZh6hOWFifbqeDTMboom5jaReexbwxjBDJLTb7q4ZGGijgaZPVk0CS2MmAFXRjjnGZ+q+dStixDOwj22MIXaV/siPFelpwBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbaHQY6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbaHQY6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6F61F000C4;
	Thu, 15 Oct 2026 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085495;
	bh=ZdVkPN3EeAUw7dzhmCA7DI/opUNDbKVSTD/stefKomk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbaHQY6tV78JeBxoqmyh0mR3UJZMqpBQOJ2yYUFCEUG1Y/TvWHCUJBrfuVuxwNVtp
	 zznscw8xN1PnwBULBEb7cqQ8YAVeoFXaS4ODvAsYCcRn8suWGbdxtO/tyvzBC2mmiY
	 1MXieYyCNIWxnveYj0MtAhO4eY+QSKDBF9ClxJ1GzRmOmNKP+khHjrsotj3BxQ6RkH
	 uzkhETNYXjw1YopRqDCBHLwGj/KaKLRagBcUZ0DK7UiY4q/+cTNsyqnXEtQ1BjEkMz
	 qlLqdDKwnw95L+PhO/S2uNCR6ROZVr5KnWIohNHA+7Alc3x9rNLz1cmx49xQlQhppA
	 qaN1zMeONgp5g==
Message-ID: <sashiko-outbox-173255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add JIT cBPF-related
 instruction tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015171917.599025-2-daniel@iogearbox.net>
References: <20261015171917.599025-1-daniel@iogearbox.net>
 <20261015171917.599025-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:31:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation
--

commit 50137381f50b5ae9fe8e8ed91abe51bac3560048
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add JIT cBPF-related instruction tests

The classic BPF cases of the removed test_bpf module ran their programs
on a hand-built skb. Run them as socket filters instead via jit_insns_cbpf
test suite. This covers all previous test_bpf cases as well as a few corner
cases beyond that.

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c b/to=
ols/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c
> new file mode 100644
> index 0000000000000..5471c06605fe3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns_cbpf.c
[ ... ]
> +	{
> +		.descr =3D "tcpdump complex",
> +		.insns =3D INSNS(
> +			/* tcpdump -nei eth0 'tcp port 22 and (((ip[2:2] -
> +			 * ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) !=3D 0) and
> +			 * (len > 115 or len < 30000000000)' -d
> +			 */
> +			BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),

[Severity: Low]
This isn't a bug, but could we format this multi-line comment in the cases
array to match the preferred BPF subsystem style? The BPF subsystem expects
the opening /* to be on its own line, with the text starting on the next
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015171917.5990=
25-1-daniel@iogearbox.net?part=3D2
