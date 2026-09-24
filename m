Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED34A92CD;
	Thu, 24 Sep 2026 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268970; cv=none; b=RZAwxE0biQzJKHAx97f4oXfbOjW5BaAKDp+eAQLEpeUFwleRU3PT8uif5nI3tTateP74a3s0Iqf1e0JJ9TNwSTlPyU43Uu/gjFqW6mYE4zFFp8yR+/mlSdMuJS969BPSRZZyX+P41jejwpCxUVOhzBpV6/YUZtGJ1R/Gu9dr/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268970; c=relaxed/simple;
	bh=N2DG0BiIqN4Z4KstcnTQs/Ia9h4y5HC/0xR3sG2z3TU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bTXur9ytc9y7M7UpgqtclzoD2LcMNxlQs0lADnwWFCIx0ItwpIYcvY8wKyIXNsNAubkK/vYVvsL5daqLi49RxbyFtfbjK3rPi5MkLOtVpjHrnEx/RdFsFtX71zpohgRAJWnaIVxgEsmwDyElhcZaWMCHHqHCyQynKTtDMZi+5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4EPSlSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4EPSlSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A50C1F000FF;
	Thu, 24 Sep 2026 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268968;
	bh=EtGv/Woed2PtlGCqNiJSTuE9nJ7U+sWTorJY3VyAUn4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U4EPSlSSf5b8qdFznvlxHQbYnYWOdv2VUaJ2S25mj4+kYQ4Sch6LHULpga88Wbc8n
	 Qf36dZJtBR9tU9HQG3BtMhNi2tXk7A/UuFs0eByXEn1pVrmQfkukcHA7u6LEPEvlXu
	 EMWj8VVErlB9M8SBlgz3nBIynAhJoowdRHdxs376rGhLoENJWuKDeVB3f7sqqPqMwV
	 wRlyf1SbufBuz14eSWJ4ms9Im4Dwpn3pLWcn7/fHXuOKSFpt59CJD/TQZfcur0ZG60
	 gNkxc1chJCoBu70HSZ38SkY4LO+QGABirNYAiAQiteyaGjTg/cwuXVZMgn1ouR7/U5
	 y21RIn++Y1UTw==
Content-Type: multipart/mixed; boundary="===============7204283924686163016=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e6dac20d7badce84d1b4601f9551fca3235417ab3026173d4e9bd9e3348d42ed@mail.kernel.org>
In-Reply-To: <20260924160732.485650-2-skokovmaksimevg@gmail.com>
References: <20260924160732.485650-2-skokovmaksimevg@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Don't report an empty map when key iteration fails
From: bot+bpf-ci@kernel.org
To: skokovmaksimevg@gmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kuba@kernel.org,shuah@kernel.org,linux-kselftest@vger.kernel.org,skokovmaksimevg@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 16:56:06 +0000 (UTC)

--===============7204283924686163016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Don't report an empty map when key iteration fails

The subject says "Don't report an empty map", but when the map has BTF,
the elements array is opened before the loop and closed after it, so stdout
is still "[]". Only the line on stderr is new.

With -j the error object is printed inside that array:
[{"error":"can't get next key: ..."}]. Does the actual behavior match the
subject line?

>     map_dump() walks the map with bpf_map_get_next_key() and treats ENOENT
>     as the end of the map. Any other error ends the walk as well, but
>     silently: bpftool prints an empty dump, "[]" with BTF or "Found 0
>     elements" without, and only the exit status tells that the map was not
>     read at all.
>
>     This is what every local storage map (sk, inode, task and cgrp storage)
>     gets, since their map_get_next_key returns -ENOTSUPP. On a
>     BPF_MAP_TYPE_SK_STORAGE map holding storage for five TCP sockets:
>
>       # bpftool map dump pinned /sys/fs/bpf/tc/globals/cilium_lb4_reverse_sk_v2
>       []
>       # echo $?
>       244

The commit message uses "/sys/fs/bpf/tc/globals/cilium_lb4_reverse_sk_v2"
as an example. However, cilium_lb4_reverse_sk is an LRU hash in Cilium,
not sk_storage, and bpftool dumps it just fine. Where did this output come
from?

[ ... ]

>     Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")

The exit status was non-zero before and remains non-zero after. Should the
Fixes tag be dropped since this is not a fix?

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 20d59eab09a1..00e49ae05c08 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -883,8 +883,15 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	while (true) {
>  		err = bpf_map_get_next_key(fd, prev_key, key);
>  		if (err) {
> -			if (errno == ENOENT)
> +			int saved_errno = errno;
> +
> +			if (saved_errno == ENOENT) {
>  				err = 0;
> +				break;
> +			}
> +			p_err("can't get next key: %s%s", strerror(saved_errno),
> +			      saved_errno == 524 /* ENOTSUPP */ ?
> +			      " -- map type does not support iteration" : "");

The hint "map type does not support iteration" is only printed for
ENOTSUPP (524). However, other non-iterable map types return different
errors:

- Local storage and ringbuf return ENOTSUPP
- Bloom filter and arena return EOPNOTSUPP
- Queue and stack return EINVAL

Should the hint cover all non-iterable map types, not just those that
return ENOTSUPP?

>  			break;
>  		}
>  		if (!dump_map_elem(fd, key, value, info, btf, wtr,

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36027992199
--===============7204283924686163016==--
