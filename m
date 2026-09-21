Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B5276050;
	Mon, 21 Sep 2026 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979653; cv=none; b=YTM7cVQDkO7GwXZfItFeOkUlMCrcRVvIaFFsXhHE5xd15RsExVtw0L9VHGuhNAfaHQKrPwH3ROTmGyD2nPoUahJuZnBq/5crsvTn8JTRuiLnv021KTx++bgMa27h76JNauyJmwfnVhA8oW4f0vkcbOjyElq5hcK1ud2nCTjXdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979653; c=relaxed/simple;
	bh=BJB5YjnPkcweXsnQDBv6q/1S+2TwSbJHb1CDmMRH2+Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jECQiUfoBpoq621Im18ckHYrcSNSyi/qOS+jYY3nCp4Brw028h13N24Gb4kw+AGrWPK4zlBxtb18j9QR12maCc2xOVkw+Vi4aHIWlZN5TsAsZkoip+SzA4zE9qD28To4w+U+sYg0eJDyIHOm1aBAke8MMl+NMolcfdEOZi6nSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNDa6LOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNDa6LOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48BB1F000FF;
	Mon, 21 Sep 2026 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979651;
	bh=Q6Nq+2uf6v4Q9W25BC/CBfPrAcVMinAMeS39+vHdmFE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GNDa6LOMJwhSyLJaB5gZ3k54KVl9uxM+Sl8FBD5TtYHH9RX+AWl9TqkMB+kzFolrc
	 9Mgx5U89MAeEO3jjdslo1zP1iio7fJFIGdjfh4O8wq2dIHTCsr9UadwONOoWEzQHkw
	 aVfVv7bPkiA//ByCr4RRQ/HHMzIALNiYK2AkrxunLcMyqnuIXDQyCVuqx+irkpiXue
	 MAs5NItNxNONC6qK9rlabVLOnYP/6Z4z3mmWkuxmBXnegU0jXeUDCAQXd4AxE+IDv1
	 4idVVSajLwRAmDte3yBVcdN9fjFCXgthgGzX1TlinLI8Y8pXyTdZDGu9Gb+jCcpCeZ
	 m/9ik/XAQcaIg==
Content-Type: multipart/mixed; boundary="===============4734919722786265112=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07cc03481993aa986fbaf7c95f59c54eb287975225e04fef488bde60e5a3ad64@mail.kernel.org>
In-Reply-To: <20260921073556.99421-2-hi@tychen.cc>
References: <20260921073556.99421-2-hi@tychen.cc>
Subject: Re: [PATCH bpf-next v5 1/2] bpftool: Read ring buffer maps with event_pipe
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 08:34:09 +0000 (UTC)

--===============4734919722786265112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512ebae..c9e8761e4ef2a 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool

[ ... ]

> @@ -50,12 +50,19 @@ _bpftool_get_map_ids()
>          command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
>  }
>
> -# Takes map type and adds matching map ids to the list of suggestions.
> -_bpftool_get_map_ids_for_type()
> +# Takes map types and prints a pattern matching their JSON type fields.
> +_bpftool_build_type_pattern()
>  {
> -    local type="$1"
> +    local IFS='|'
> +    printf '"type": "(%s)"\n' "$*"
> +}
> +
> +# Takes map types and adds matching map ids to the list of suggestions.
> +_bpftool_get_map_ids_for_types()
> +{
> +    local types=$(_bpftool_build_type_pattern "$@")
>      COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
> -        command grep -C2 "$type" | \
> +        command grep -C2 -E "$types" | \
>          command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
>  }

This isn't a bug, but the switch from a bare substring grep to an
anchored '"type": "..."' match also tightens the existing
stack/queue/struct_ops completions. For example, 'bpftool map peek id'
previously matched "type": "stack_trace" because it contained the
substring 'stack', so stack_trace map IDs were suggested; they no longer
are. Maps whose name contained 'stack' or 'queue' were likewise picked
up via the -C2 window and no longer are.

The tightening is well motivated for the new ringbuf call (it keeps
user_ringbuf out of the event_pipe suggestions), and every type string
used is an exact libbpf map_type_name[] entry, so nothing is wrongly
excluded. Would it be worth a line in the changelog about this behavior
change to unrelated completions, or splitting the anchoring out from the
ringbuf support?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35575071830
--===============4734919722786265112==--
