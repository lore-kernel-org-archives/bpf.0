Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC43209F43;
	Tue, 10 Feb 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746100; cv=none; b=D+dDu9QXHwAzYJpoCcgR4bxLobALuPaC1E7KFMmLzJfOxxvRrOoZ33InIX7zYTTMXm++D5l2pFui+OguAZ6DvYu4xqeCiB46/uisndGtBhGXCm4jspkYIFuDG7XWy2p1Wba0duuzaV2ouHHXGp2qgZ5LLLiXtaIPWf6+roaIkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746100; c=relaxed/simple;
	bh=1LMuUcwE1wyJRGlh8WvdZKXrTG99TlMZf6rQ/9HEioY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ikVKQMHT+UY0O6BllmruGDylNadj1eQqLmyf1t7KeUQy8/6ZIkFKaWzVRWxOGcJfgof8AJF1GoAKd7976BwLLOUTaVvshRwl28vvzL7rYBormWl8WVn0hUsX5XetDde7ykox5n28HHHJqvKn1EnYPjorfPODleu4gODjSgBuWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjpSXJC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjpSXJC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B82C116C6;
	Tue, 10 Feb 2026 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746100;
	bh=1LMuUcwE1wyJRGlh8WvdZKXrTG99TlMZf6rQ/9HEioY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rjpSXJC1JmdOiDmWcR4D9NYq0bDPcFfqRldKoNI0qo5lSCr2gCHBonjiRmEve4b9I
	 izaJSEMN6WOKT4o2P/VuRs/ThZvqbLEfUHeXRDPcxXFh14rsi+3BvuEuS+i1mf0zEl
	 5rIgZWUPJpHs34mxL71ktuBrNB5EhQw3pWSHgwZoV6BMmAwV5HlRjiVxMZxuOdqXTu
	 yk3XDXot+mqftV5JR38GqFOyayAYVJn6fK/fbw9M2MxCqEGtE79g+yHECytKILajTH
	 LVwCWBlEFKGrB3pJPmtrsCuOPh5aQtFNKBDnRIz0r/D4ikuNLTy0a69KB05DN5VHnS
	 32N1Gt9gURdgg==
Content-Type: multipart/mixed; boundary="===============0303600655882961055=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd3b3afa8e6e8b17cf8ee8b20afd776ee37341ecefedfc1e921a8171bae29cee@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-5-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-5-e5d55caa0541@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 17:54:59 +0000 (UTC)

--===============0303600655882961055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

This isn't a bug, but there's a typo in the subject line - "xdp_hw_metadat"
should be "xdp_hw_metadata".

> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c

[ ... ]

> +	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
> +		print_rx_cksum(meta->ip_summed, meta->cksum_meta);
> +	else
> +		printf("No rx_chsum, err=%d\n", meta->rx_cksum_err);
                    ^^^^^^^^

Should "rx_chsum" be "rx_checksum"?  The other error messages in this
function use the full field names: "rx_hash", "rx_timestamp",
"rx_vlan_tci".

> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c

[ ... ]

> +	err = bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed,
> +					   &meta->cksum_meta);

The file declares extern __ksym for the other XDP metadata kfuncs:

    extern int bpf_xdp_metadata_rx_timestamp(...) __ksym;
    extern int bpf_xdp_metadata_rx_hash(...) __ksym;
    extern int bpf_xdp_metadata_rx_vlan_tag(...) __ksym;

Should bpf_xdp_metadata_rx_checksum have a matching extern declaration
for consistency?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The presence of typos and natural integration with existing kernel patterns suggest human authorship; no AI-like patterns detected.
issues-found: 3
issue-severity-score: low
issue-severity-explanation: Three minor issues found in test code: two typos (commit subject, error message) and a missing extern declaration for consistency.

--===============0303600655882961055==--
