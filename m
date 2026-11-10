Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338271;
	b=Y0QqbP28LHULHFkHHIT+prxVEgoQLpLTHica05eeaBjYl7KfrNi7Jl6arJsZhoejuYAc
	 ro7lRjy5PMVQCRqOxBdIb+uCG7cA/cH+OnebzOREtMFNoxzL+w0NFUIjnPtQRCFCA6Afa
	 VErG3+wpwlEq96RTGI8q479fNuT4KGgcrmW1vjQdxqmnf7H1aLmFCWHxFpE/pYkpQKQmI
	 DREQ9BLYnKhpxsqG7irYe+A+Xh/NUfdGfA6s79E2lPJ2wIWM4DiqAreomHKIL8svBurIE
	 rRdDffW0fjNEE2JxS2Kt7mHrClp/nItcbYXqdN67wAqZa+Dcd5PUQMV4F8787gJj29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338271;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=l2pzgkTJvNlg/2b4CeykC6mg8NcSe99cz3KRZQyFyfM=;
	b=rRf8AQSJshLYiu+eM3HOtAzcfWEBnzg5jwlGIOUxApiVa7WabyjaXttaKUG9Do1dDNBW
	 s+rMR80X4t6ihMjJJlgAkoXkOv8WOehZF46pJB/g1daa0zfqmkdggGu8Vn4mioA7kNTSx
	 zx3ctPronF9s3c1nl6EPBCK3mO6yiPiplYQrW6kE5ro+1/iOPjFpzyOSl5zrpR525QDTk
	 z4HZz0FLJJW7fxpW83H8o1lh8KATFx5it9NSI+mg38pQbfg9RfypbP4NtS9VsyvGsWPLM
	 19KIA7n2ZaYOqeonG2bY5cusuO8JRoQkR52dTrkFVzCgI4CkoSDKMu1gmXVCG9v1blw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf3guXSH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A1606A320;
	Tue, 10 Nov 2026 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf3guXSH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA761F0089F;
	Tue, 10 Nov 2026 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338270;
	bh=l2pzgkTJvNlg/2b4CeykC6mg8NcSe99cz3KRZQyFyfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vf3guXSH7fnTrA/pBUpx1SOVUtBeS3GhNhH26y2eSMdUaeghvpri1SDlUUe5yOm50
	 W63tG6iuomnbweMlUCdN1TTcAeX4DKxWI5H199n+oY37V5RTij9drRu9RntY9FLzrd
	 is99LuRTOhHc2es3MLsm4r3WnDkTMq4066z+xSOJ5msA2AbavNXddsGFqjVCa93PAv
	 MsABYGPCUP7DEFjlc+1kEAr0S2/GreF6QtQb2CR66D+WAANgi3oZ07OX//5zU2jsd2
	 YFMESN1qtTlZy6rGxawa6Gj3RT2oK0wzM0vND9/cUSwHrxD6BjDN1+ej+XO+Z3crBV
	 5moh4StKV+dvQ==
Date: Tue, 10 Nov 2026 09:17:49 -1000
Message-ID: <a7610cb55d3f6172fc3f717116ee44cc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 liwanwu@kylinos.cn, devnexen@gmail.com, zhaomengmeng@kylinos.cn,
 emil@etsalapatis.com, yphbchou0911@gmail.com, mingo@redhat.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/9] tools/sched_ext: robustness fixes from cold review
In-Reply-To: <20261110125001.4167503-1-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Tao Cui (9):
>   tools/sched_ext: scx_flatcg: Reset the stats baseline on restart
>   tools/sched_ext: scx_flatcg: Validate the stats interval
>   tools/sched_ext: scx_pair: Don't abort when the dispatching cgroup
>     goes away
>   tools/sched_ext: scx_pair: Don't attach after an interrupted
>     initialization
>   tools/sched_ext: scx_pair: Reset pair_id on restart
>   tools/sched_ext: scx_qmap: Add the missing options to the usage
>     synopsis
>   tools/sched_ext: scx_qmap: Reset the hier stats baseline on restart
>   tools/sched_ext: scx_userland: Check dispatch buffer slots before
>     inserting
>   tools/sched_ext: scx_userland: Reject batch size 0

Applied 1, 5, 6, 7 and 8 to sched_ext/for-7.5, with a garbled sentence
in 8's description fixed. I'm skipping 2, 3, 4 and 9 as they don't
really make a meaningful difference.

Thanks.

--
tejun
