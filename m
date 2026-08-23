Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B953839A1
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787450491; cv=none; b=uHBk5b0HRbsoh2hoA/1qYmit2MADH8fef63703LTqxmN9MItSuewhJ6FhIwyGWc9/vtnMQAe/PW4HE5MtKqhAZaPer+cCSS3Xpbwdq4kmeT/IJhJJ8ZgUUvEVeO7BM7gNz7UPHjPCLxj9Go8bYrpEu1O8UUByokqK797zu0ZTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787450491; c=relaxed/simple;
	bh=zNR2uLnTTO4cN5DQOcDYR4GsLyycos1Zjr/xkHN+0KY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SWD3BfeGFVyzPqKIEHnyXyqLgh1rbMQuuEbCr75miImtHW0Jk8mp4h4pDPRihavTJvcIpICaCEgEIUBdlcnHE0az/7FcIQCxKmv5noz6Z6UCzfyPy40NHs2PE9bTUhr7zcrxC51tSBzfksw2aYfNV0KSDMOBihfPJsvZ9Yb98As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm085hVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm085hVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E1B1F000E9;
	Sun, 23 Aug 2026 02:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787450490;
	bh=AUl19IYe5FN+8YSThSE7pv93tQsXU3vIXZmLOtXE+Do=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hm085hVEac8sF4+eW3mpNP+ulUGITnMgWUj1Ng+Kje0SfPV3cSwAxKFHyu/MSgsMK
	 yqXoawV0MrxkznxyF8RjefDXH/RTaxPhiGwKPTSTqxEcdQENdz5vZG7vd5owWexerW
	 EdiXbrr0x55tOvcH4A+aJijfm121qDRydx378ZkA8ulvTySnArhD3vhHZIS3FpmKJ0
	 ZlMxrbn4cryAfj/31WqSdvUUGX9BZjwP3fUPr2W8R1DYqyQP49VJJRZM6Zd+4HByKB
	 2AFc92iZhvPpnZK+B9OFpIcSoAtbBUf1aBl3sbIanREVRzcL5xtW4U1kAillbvHDeh
	 YRl8NAnsS1b4A==
Content-Type: multipart/mixed; boundary="===============4294135402285717675=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d1eb79c6c2de68738723ff5cb54145edd635c03c053c4cb5f8a299f6eb34b96@mail.kernel.org>
In-Reply-To: <20260823010900.1730708-8-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-8-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v6 7/9] selftests/bpf: extract BPF skeleton generation into a helper script
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 02:01:29 +0000 (UTC)

--===============4294135402285717675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testing/selftests/bpf/gen_bpf_skel.sh
> new file mode 100755
> index 000000000000..a752cb78c139
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
> @@ -0,0 +1,93 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

[ ... ]

> +# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH).
> +# On failure all outputs and intermediates are removed and the script
> +# exits non-zero; permissive-mode skipping is the caller's business
> +# (see skip_on_fail in the Makefile).
> +
> +set -u
> +
> +bpftool=${BPFTOOL:-bpftool}
> +name='' skel='' subskel=''
> +lskel=0 sign=0

[ ... ]

> +base=${skel%.skel.h}
> +base=${base%.lskel.h}
> +t1=$base.${infix}1.o
> +t2=$base.${infix}2.o
> +t3=$base.${infix}3.o
> +
> +fail() {
> +	rm -f "$skel" ${subskel:+"$subskel"} "$t1" "$t2" "$t3"
> +	exit 1
> +}
> +
> +"$bpftool" gen object "$t1" "$@" || fail
> +"$bpftool" gen object "$t2" "$t1" || fail
> +"$bpftool" gen object "$t3" "$t2" || fail
> +if ! cmp -s "$t2" "$t3"; then
> +	echo "$0: bpftool gen object is not deterministic for $skel" >&2
> +	fail
> +fi
> +
> +args=()
> +if [ "$sign" -eq 1 ]; then
> +	args+=(-S -k "${PRIVATE_KEY:?}" -i "${VERIFICATION_CERT:?}")
> +fi

The script's header comment promises that all outputs and intermediates
are removed on failure. Does this hold when PRIVATE_KEY or
VERIFICATION_CERT is unset?

The :? expansion terminates the shell immediately and the fail() cleanup
never runs, leaving t1, t2, and t3 behind. This isn't reachable from the
Makefile - which always exports both variables - but it breaks the
contract for direct invocations. Something like this at the top would
catch both up front:

if [ "$sign" -eq 1 ] && { [ -z "${PRIVATE_KEY-}" ] || [ -z "${VERIFICATION_CERT-}" ]; }; then
	echo "$0: --sign requires PRIVATE_KEY and VERIFICATION_CERT" >&2
	exit 1
fi

[ ... ]

> The distinct linked/llinked intermediate infixes are kept but derived
> inside the script: tests listed in LSKELS_EXTRA generate both a
> .skel.h and a .lskel.h from the same .bpf.o, and distinct intermediate
> names are what keeps parallel builds from racing.

The changelog says the intermediate names are "kept" and closes with
"behavior is unchanged", but the intermediate file stem changed for three
of the four rules.

The script derives the stem from the output header:

    base=${skel%.skel.h}
    base=${base%.lskel.h}
    t1=$base.${infix}1.o

The pre-image derived it from the input object for SKELS, LSKELS and
LSKELS_SIGNED, e.g. "$(<:.o=.linked1.o)" where $< is out/foo.bpf.o, so:

    SKELS:         out/foo.bpf.linked1.o   -> out/foo.linked1.o
    LSKELS:        out/foo.bpf.llinked1.o  -> out/foo.llinked1.o
    LSKELS_SIGNED: out/foo.bpf.llinked1.o  -> out/foo.llinked1.o
    SKELS_LINKED:  out/foo.linked1.o       -> unchanged

The infixes themselves are indeed preserved. I found no functional
consequence - no stem collision, nothing references the *.linked[123].o
names, and EXTRA_CLEAN's *.o glob covers both spellings.

Should the changelog note the change, since it specifically discusses
these names and the anti-racing property that depends on them?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32610372822
--===============4294135402285717675==--
