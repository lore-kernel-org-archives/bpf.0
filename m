Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D538A73A
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753220; cv=none; b=ZFp0w6DFhJplCH7iuIHNxHAB6Yrr6JQ6+FKsKsS0GShxlFa4v+SAfNYTRxe1O5P+1fHfMzFiGA4xYr0DKPSqbKtEjmJTTLbrvXBAQRLO+dZWI4OR3+eIruSlImfOMxhoR0xhOc7ioNcoUPfWuZI20E/TbCLkXJaHbJJP+vN3oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753220; c=relaxed/simple;
	bh=n7AmzdovlqWr/0+XmtV9bpUYvTu+8BjfI6wQWox+ZD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBS+gXoba9TrQoRK9IL+yDMOBniL5WNQkty3gXJOwEyaSXxp8p5fp9b/+tQtxr4Hl4rn+xzZ86Xa9kAGfPtwjcZa4eaGgij5jFvRy4HgKMwHGzlEmV8DncceVl2dVTf2fVDqMuRPc1PH7sdQBrrlVaktn5y+ctQzIRXxtih4fhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpDwbHlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpDwbHlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9938C2BCB3;
	Thu, 14 May 2026 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778753219;
	bh=n7AmzdovlqWr/0+XmtV9bpUYvTu+8BjfI6wQWox+ZD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OpDwbHlAAa3nrfbcXTQ9SGhWNuPlDBHQfuM7LB/0pDaY8Ir3bbnebOLrFSzvOfXdJ
	 nh554iHw3s3elSAUgSdhObLgZYAe4HqveV/Q1uzo3lkTijoPbLzn09wRletBQfavZ2
	 eMC4aAP1JW1ZVn3kPR0EWlC6RYi6jnZriS67KGYKvymBp3IiQ4WY8VrCkS/2iYq/Cp
	 1DXlftVOI+2/Y2Z8hlI27HzQCeYWvhmVaTMSygnXLSCnRbaiu7yzn+wlieEXg3lHYw
	 mp9LxOjby5tMsj/e/gY0ddsAHJGqIAgfSb0V68+/Fzf6Dm1Pjrv33Q+gpGdTkMHK8b
	 5r5H20UYEXNOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] veristat: Report max stack depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <b3459e61c408daef30d82272f1eacc6399844896.1778689025.git.paul.chaignon@gmail.com>
References: <b3459e61c408daef30d82272f1eacc6399844896.1778689025.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 10:06:59 +0000
Message-Id: <20260514100659.C9938C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The MEMORY_PEAK statistic is silently truncated from the default=
 CSV output.
- [Medium] The commit message incorrectly claims that the max stack depth '=
is null for rejected programs', but the code outputs '0'.
--

commit 407a4af46d427010feeebda3a91736b7ef774219
Author: Paul Chaignon <paul.chaignon@gmail.com>

veristat: Report max stack depth

This patch adds a new "Max stack depth" field to the set of gathered statis=
tics.
It reports the maximum combined stack depth compared to the 512 bytes limit.

>     This patch adds a new "Max stack depth" field to the set of gathered
>     statistics. This field reports the maximum combined stack depth compa=
red
>     to the 512 bytes limit. It is null for rejected programs.

Is the last sentence accurate? The code appears to output 0 instead of "nul=
l"
for rejected programs.

When a program is rejected and the log stops early, MAX_STACK remains
zero-initialized. In prepare_value(), MAX_STACK falls back to outputting 0:

	case MAX_STACK:
	case SIZE:
	case JITED_SIZE:
	case MEMORY_PEAK:
		*val =3D s ? s->stats[id] : 0;
		break;

Furthermore, outputting "null" would fail in parse_stat_value() during repl=
ay
mode, as it strictly expects an integer.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 5c82950e6978e..9a2275d19ee1b 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c

[ ... ]

> @@ -795,7 +796,7 @@ static const struct stat_specs default_csv_output_spe=
c =3D {
>  		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
>  		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
>  		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
> -		STACK, MEMORY_PEAK,
> +		STACK, MAX_STACK, MEMORY_PEAK,
>  	},
>  };

Does this change truncate the MEMORY_PEAK statistic from the default CSV ou=
tput?

Looking at the full definition of default_csv_output_spec:

static const struct stat_specs default_csv_output_spec =3D {
	.spec_cnt =3D 15,
	.ids =3D {
		FILE_NAME, PROG_NAME, VERDICT, DURATION,
		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
		STACK, MAX_STACK, MEMORY_PEAK,
	},
};

With MAX_STACK added, there are now 16 elements in the ids array, but spec_=
cnt
remains hardcoded at 15. Because the formatting loops iterate strictly up to
spec_cnt, it seems the 16th element (MEMORY_PEAK) will be silently ignored,
causing a regression in the generated statistics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778689025.gi=
t.paul.chaignon@gmail.com?part=3D3
