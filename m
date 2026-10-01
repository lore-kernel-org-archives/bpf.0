Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E132989B5;
	Thu,  1 Oct 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870635; cv=none; b=mg4YOyUMTS+IyPXrFyyucS888wftD3wfoulzycm4+spO8X3MFQ3dF7NFUqivw4t+dvQ1EePJqkAJH0m2Jga50VPmdu+YWLEwkNOeDdTzhkikD9M9TLkNdjFylNGcEg6IQzpPCTRSesGy6WEmUpKqzbzRNjg9yk4LKDIDBGjHXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870635; c=relaxed/simple;
	bh=jxqrgUT4INjJUQL3kGuh73zIkvLPncZGDFt9GhPhUg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PWzegQCdFM8yNWTjeDpKfK8SX2Bl5s//8gUPjwNVQ42VhbYZu1TIC7vyS1BS2Epd5WjrHJ6oaSDxsRkNPd/76VeGsxq3YtFIhDdMdhL4LGGxNZKtzXJKk1w9hs2tnEKMxAkxnTauh5m6UL653oLF4TPvwvYYFu/xIaoPaBPq/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnhe6eUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnhe6eUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF11F000FF;
	Thu,  1 Oct 2026 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870633;
	bh=lhktJrkw7K1abu839nEgQ2Xb098Mk/CNcvP0MdyL1+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cnhe6eUCAD1+/KEi9OtcDggHj2aIASwe9nC0Xw9L3Gb0Gjj6sBBup6SMeozS2a6uu
	 o5hpsjUIgNIeQsXP3nI4xC1n1IBbIhWGoyIGq6qidOlnRdD6ilsLONk/1nghOus9ie
	 +FgjLLwMbSuPXmC6MMyumeOZhGzWoAy1OPZGljV3Qbz/SfLdm29a5R+h2kjya93IDy
	 1w9+q39P2g8y9WOIXuLj9aWwMUzxu+qEPOSTq4nEjZtG9CuhM0syb4N5M8T5LHrLmW
	 qrVEhqGiQhT8NxkT7nzT28PGbyTqz65m/NrAZJVGZKEm1eyIv/teVeHMxZtD1a+agX
	 XwCuuz2bzx2iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] tools/rv: Add selftest for rv bpf monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001152042.124445-15-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-15-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:03:53 +0000
Message-Id: <20261001160353.97BF11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/rv: catch-all regex bypasses exact monitor name valida=
tion if BPF uncompiled
- [Medium] selftests/rv: spurious failure due to missing check for BPF moni=
tor presence
--

commit 47b33f7df8aa5888f987d177930041a5edcca5ec
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Add selftest for rv bpf monitors

This commit adds selftest cases for the rv userspace tool BPF monitors. It
tests BPF monitor listing, functionality, traces, and reactors.

> diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/r=
v/tests/rv_list.t
> index 201af33a52ccc..3c94f2af21097 100644
> --- a/tools/verification/rv/tests/rv_list.t
> +++ b/tools/verification/rv/tests/rv_list.t
> @@ -17,13 +19,15 @@ check "verify list subcommand help" \
>  all_nested=3D$(grep : $RVDIR/available_monitors | cut -d: -f2 | paste -s=
 | sed 's/\t/\\|/g')
>  all_non_nested=3D$(grep -v : $RVDIR/available_monitors | cut -d: -f2 | p=
aste -s | sed 's/\t/\\|/g')
>  sched_monitors=3D$(grep sched: $RVDIR/available_monitors | cut -d: -f2 |=
 paste -s | sed 's/\t/\\|/g')
> +all_bpf=3D$(find "$RVTOOL/bpf_monitors" -name "*.o" -exec basename \{} .=
o \; | paste -s | sed 's/\t/\\|/g')
>  description_state=3D"[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
>  line_nested=3D" - \($all_nested\)${description_state}"
>  line_non_nested=3D"\($all_non_nested\)${description_state}"
> +line_bpf=3D"\($all_bpf\)${description_state}"
> =20
>  # List monitors and containers
>  check "list all monitors" \
> -	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\)$"
> +	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\|$line_bpf\)$"

[Severity: Medium]
If the BPF monitors are not compiled, all_bpf will be empty, making line_bpf
evaluate to "\(\)[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]".

When this is combined in the catch-all regex "^(...) $", does this accident=
ally
allow any line starting with a space to pass validation instead of strictly
enforcing the monitor names?

> diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv=
/tests/rv_mon.t
> index cbc346c74c71a..8e14471661c7d 100644
> --- a/tools/verification/rv/tests/rv_mon.t
> +++ b/tools/verification/rv/tests/rv_mon.t
> @@ -23,13 +24,34 @@ if [ -d $RVDIR/monitors/wwnr ]; then
>  check "invalid reactor name" \
>  	"$RV mon wwnr -r invalid" 1 "failed to set invalid reactor, is it avail=
able?"
> =20
> +check "invalid BPF reactor name" \
> +	"$RV mon nohz -r invalid" 1 "failed to set invalid reactor, is it avail=
able?"
> +
> +check "invalid BPF reactor name check available" \
> +	"$RV mon nohz -r invalid" 1 "available BPF reactors: nop [a-z]\+" \
> +	"available reactors:"

[Severity: Medium]
Since this check for the nohz BPF monitor is guarded only by the presence
of the wwnr in-kernel monitor, can it cause spurious failures if the BPF
monitors were not built but wwnr is present?

If nohz.o is missing, the command will fail with "monitor nohz does not exi=
st"
rather than the expected invalid reactor error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001152042.1244=
45-1-gmonaco@redhat.com?part=3D14
