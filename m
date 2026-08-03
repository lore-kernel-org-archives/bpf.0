Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7648432BD6;
	Mon,  3 Aug 2026 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781888; cv=none; b=oWHJyhHK7Ilq39PqE9PCvnDEkdeP/4efWO3SBvkcW3IYhX3I2aWveOF+v+krH/uogVi38Kcz/OV2QrIu8aaYE/zlbBydj1bEHCgoSEZSq3GxWVo5MordsKO4lqJgIuFKjWciJtmshD3QB2N9fSFGY6lY3Wh6gDYGrSbjz04y+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781888; c=relaxed/simple;
	bh=ORmrjWH6PYG89lW3BxSPLQ3W/1WLUC9v8LP+zDsaYsY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Aa1GHTbEcRd+36xljeWogqzFxWYJ1306sEB50N7hgaTraqh8viJEe1sB6rPriRvJnIqZvjJtqKxGlkjT9CXH6fBkzEZDYyGHQ4yeBKrSoeAYb+RUX21LPf1usXHlOTluf+ojIgh0hbsLkVeDSc2vIcDBjvQmQpy/pCTXAyaqloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNRVmRH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNRVmRH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ADE1F00A3A;
	Mon,  3 Aug 2026 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781887;
	bh=5xtlVD0klhuaHx6l0gKPmqIZkjnFcL+17TAbXpxQWtc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nNRVmRH5yMSPdYKFAfQN52QFxQELFbNEvRheJvpafgLfUEpa8opeDsiyCjrSkCKQA
	 L5v0j+WWosvrJwLnYFlhqYLg/aMTkrw1qOKD5KGLIA9JUsoIAkj96taOngCrnjvS9f
	 BiNmDjixj1wYi9B6sAabxuHBxTFhbi5O1VJc/CH3RjTtu0qv5rDbE9404MI+iCRmfb
	 +fb1ZaMP7+z/jMv+g1v3GqMF+8HB6MkHpn8rMHP8xxP3+YrwoZkpIgH7+/G65u7eLf
	 TAa4nGrZ9KUeNTpZD2gsRnVJjicN6zLwYUWDhKdX1R5VehgOSrTh6Xdb7nqupdABG4
	 hV9wbF+KRq8rg==
Content-Type: multipart/mixed; boundary="===============7125088897932189663=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d96174316041032ba75e8b9901245772bd4aad2873b795fd71df038bf909763@mail.kernel.org>
In-Reply-To: <20260803170251.1898102-5-vineet.gupta@linux.dev>
References: <20260803170251.1898102-5-vineet.gupta@linux.dev>
Subject: Re: [bpf-next 4/4] selftests/bpf: vmtest.sh: preserve command quoting when running in the VM
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com,andrii@kernel.org,ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 18:31:26 +0000 (UTC)

--===============7125088897932189663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 9ca8022853933..6a3d026d76bd6 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -428,8 +428,17 @@ main()
>
>  	if [[ $# -eq 0  && "${debug_shell}" == "no" ]]; then
>  		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
> -	else
> -		command="$@"
> +	elif [[ $# -gt 0 ]]; then
> +		# Quote each argument so the command survives into the guest: the
> +		# host expands ${command} into the generated init script, which
> +		# the guest bash then parses as shell source. Without the %q
> +		# escapes an argument with a space or a glob (e.g. -a 'verifier_*')
> +		# is re-split and expanded against /root/bpf there.
> +		#
> +		# Skip this when there is no command: printf '%q ' would still
> +		# apply the format once and emit '', which is not the empty
> +		# command that -s (debug shell) expects.
> +		command=$(printf '%q ' "$@")
>  	fi
>
>  	local kconfig_file="${OUTPUT_DIR}/latest.config"

The commit message states:

>     Note this makes the trailing command strictly an argv rather than a shell
>     snippet: passing it pre-quoted as one word, e.g.
>
>             vmtest.sh -- "./test_progs -t foo"
>
>     no longer works, and neither does embedding guest-side shell syntax such
>     as ';' or a redirection. Neither form is documented - usage() and
>     README.rst both show the command unquoted - and 'sh -c ...' still works.

Is the claim about README.rst accurate? Looking at
tools/testing/selftests/bpf/README.rst lines 106-115, there is a
documented vmtest.sh invocation whose trailing command is explicitly
quoted:

  $ PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
    tools/testing/selftests/bpf/vmtest.sh \
    -l <path of local rootfs image> -- \
    ./test_progs -d \
        \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 | ... | tr -s '\n' ',' )\"

The `\"` are escaped in the user's host shell, so vmtest.sh's main()
receives argv[3] as the literal 10-character string `",exceptions,"`
including the double quotes.

Under the old `command="$@"`, the guest bash's second parse of the init
script performed quote removal on those literal quotes, so test_progs
received `-d ,exceptions,`. That is exactly what the `\"` in the recipe
are for: they survive the host and are consumed by the guest.

With `command=$(printf '%q ' "$@")` the quotes are escaped
(`\",exceptions,\"`) and reach the binary verbatim, so test_progs now
receives `-d ",exceptions,"`.

Downstream that argument goes to parse_arg() ARG_TEST_NAME_GLOB_DENYLIST
-> parse_test_list() (tools/testing/selftests/bpf/testing_helpers.c),
which strtok_r()s on ',' and hands each field to insert_test() with
is_glob_pattern=true. So the filter list becomes three globs instead of
one: ["] [exceptions] ["], two of which can never match a test name in
glob_match() (test_progs.c).

For DENYLIST.riscv64 as it stands today the damage is confined to those
two junk filters, because the file's first line is a comment and
therefore reduces to an empty leading field.

The same recipe applied to a denylist file whose first line is a real
entry silently drops that entry. With DENYLIST.asan-shaped input:

  OLD guest -> test_progs -d [*arena*,task_local_data,uprobe_multi_test,]
    filters: [*arena*] [task_local_data] [uprobe_multi_test]
  NEW guest -> test_progs -d ["*arena*,task_local_data,uprobe_multi_test,"]
    filters: ["*arena*] [task_local_data] [uprobe_multi_test] ["]

`"*arena*` matches nothing, so the *arena* tests are no longer denied
and run anyway, a silent loss of denylist coverage rather than an error.

Should the commit message be corrected to acknowledge that README.rst
does document a quoted invocation that breaks with this change, and
should README.rst lines 109-115 be updated in the same patch to remove
the now-harmful `\"`?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30836252778
--===============7125088897932189663==--
