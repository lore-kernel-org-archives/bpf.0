Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2012376475
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310410; cv=none; b=VpjrMHiTa+6R+xV8P0wVftVqjSZXGW5vShHag20Xigad0h2VHp2gBIv9XKRHryo8HdQoc4gA4LMf5n7Sdei702+gA6rFSMUBNek+Ou6hI2J+dZtv1kn4QLEPnbW1kpxpYviuSBZTmuk3e+5tmv56z/s/zOppvm9m1+M564XM+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310410; c=relaxed/simple;
	bh=/tpdP0RFehBVzCKBM0Gq4mKyY6KMI+2hEiyNH9VGqYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBWP6uveTDqsGlC++7D4LSgphSrPaLl6xxhEhRrlcem/SIU/xL7SB5xcK7isyJQxml93AW/VtyFa3mBB56jITxQh61DdpQ6vUbSi9YqQhfcRkqM1qBqdFS6Tk596tXEX9C8VO7KudH3TIP6mC5DjAWjZDARfgwWfzb5I80IkSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXrAYHXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXrAYHXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BE61F000E9;
	Wed, 20 May 2026 20:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779310408;
	bh=FMAXYuuXd4dG03qGPIPh2vyOozU7rdr9verEu9HwVuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cXrAYHXKVh9Ibvwo+iFrzWNcPxN023DlgSLgJQMvvafPkKgAG/5sHRZUJ61Y8Qopc
	 tynT9zP1rQ3trg54vOUf6sSytPS4SDSobm564BPYnV3L5S7sRA4kn42zn82YDE447V
	 r0KnnSVAWiBtxgkDYfXHjPl/lp6D1Ei2CxJTB3guaLFY1L+p9JpiQTMfmOvVfO/YD4
	 55SRiMGyR363aL+Q+vmU3hYMoDHgNhJY4bOxpNePqBlZUPclJCkXBx/WHjJRA+AEXY
	 kK/YMMB56xonJ1CcOD+hm2VZpFZczcnllgwl1k0laanuzP5ZNE4vg1SSW2OSrCSKr9
	 h0t9oaR6nd0Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix zero batch_hash on CPU 0
 after batch_gen wraparound
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520203318.31939-1-meatuni001@gmail.com>
References: <20260520203318.31939-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 20:53:27 +0000
Message-Id: <20260520205327.E9BE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using a bitwise OR with 1 (`| 1`) to calculate `batch_hash` halv=
es the sequence entropy by producing identical hashes for consecutive execu=
tions.
--

commit 49a119687bbbdd80daaf459fad5761690fff9da3
Author: Muhammad Bilal <meatuni001@gmail.com>

selftests/bpf: Fix zero batch_hash on CPU 0 after batch_gen wraparound

This commit attempts to fix a rare zero batch_hash case on CPU 0 after
batch_gen wraparound by setting bit 0 before multiplying by
KNUTH_HASH_MULT. It modifies xdp_lb_bench.c to use a bitwise OR with 1.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/tes=
ting/selftests/bpf/progs/xdp_lb_bench.c
> index 13777b3dcac8c..816880c1cd5e0 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> @@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
>  		__u32 *saddr =3D data + saddr_off;
> =20
>  		batch_gen++;
> -		batch_hash =3D (batch_gen + bpf_get_smp_processor_id()) * KNUTH_HASH_M=
ULT;
> +		batch_hash =3D ((batch_gen + bpf_get_smp_processor_id()) | 1) * KNUTH_=
HASH_MULT;

[Severity: Medium]
Does applying a bitwise OR with 1 here halve the sequence entropy and
produce identical hashes for consecutive executions?

Since batch_gen is incremented sequentially, the sum of batch_gen and
the processor ID will alternate between even and odd values on a given CPU.
Applying a bitwise OR with 1 maps consecutive pairs to the exact same odd
number (for example, 2 | 1 =3D 3, and 3 | 1 =3D 3).

In the context of a cold LRU benchmark, reusing the same hash causes the
modified source address to perfectly match the previous run, leading to
artificial cache hits in half of the runs. This persistent collision rate
might degrade the benchmark's accuracy significantly more than the rare
wraparound to zero it tries to fix.

Would using a ternary operator like val ?: 1 avoid the zero case without
destroying sequence uniqueness?

>  		if ((void *)(saddr + 1) <=3D data_end)
>  			*saddr ^=3D batch_hash;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520203318.3193=
9-1-meatuni001@gmail.com?part=3D1
