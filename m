Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2153932D9
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018740; cv=none; b=nhTB5rmdwPtAICpW4gA9JGyRAfhqAdgnnBSIfKHoBaXIFf2eUK4w+NskTwYxFM2eQY32BvIpejukJg89pfdH2xM6YweT+khMl7TzsB9kHrbXVa/4efGuY2ouE59SsWVSLk5qwhY9jqe5V1CWYScBLL/5nhCGVP/Og8AnXEsZBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018740; c=relaxed/simple;
	bh=cLiYL9rGQYToozjHmCoO/++POUwLYi62770zyxP5zbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WybwAyYxBMcgXBqaWdx80/xOi0xnpJFpVWnKNPwp5qLtujGMAJVbcFOiygJigYuH29wPa44BfzCsVH8WUzd3ph/wrbn0fS9Yajb3xgSj1m+2CBWTVmBokCH1DanZDJrQjUyz96ttqjlp8mvJ1m8E20Q7Kpyn29Ghky2CvzWeCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6StEWer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6StEWer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE4F1F00893;
	Mon, 21 Sep 2026 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018739;
	bh=Ty/LszTCfWxgfSCNdrzpWzoUMPgzOPK0iDLaoKwiz5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6StEWerHDIp8rRQfJ1OiBu2hknimmJM4fO6UdipSfWzt4lcqfgoeLMCMweQSQW+w
	 qKIgoZKYUCPA/E0lLRbMX0l6IhLwVuqSAEdy9ayc7dSIG09M3VcyfJMh/5GnaZzo82
	 Ht4y26ZhfTawcpq61Ug75fg+0tzy415SxJWPLl5/HQ+noSf4tOPuyNkWSEUXnR22Yn
	 aIXv0xx8FbtoARJXs6QMhkoX4sAWTCmtVOWXVmwDLcNcCV4JRxdSeg6gETba6fdmLc
	 eiYmPz368iQo5rJ0aLghQHJLCtDGye+zGmos7KcqddukX2OUhb9bMnEtg7inypELIB
	 CHW9s56ub1ZNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/4] selftests/bpf: Add tests for
 bpf_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921191407.1742386-3-puranjay@kernel.org>
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:25:38 +0000
Message-Id: <20260921192538.EEE4F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: selftest sleepable_callback fails to properly test callback=
 restriction
--

commit 8dcd9155da335ebebbf25f7c26266814bb232e74
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add tests for bpf_call_rcu()
   =20
This commit adds selftests to cover bpf_call_rcu() functionality, checking
grace periods, callback re-arming, teardown handling, and negative tests
including verifier rejection of a sleepable callback.

> diff --git a/tools/testing/selftests/bpf/progs/call_rcu_fail.c b/tools/te=
sting/selftests/bpf/progs/call_rcu_fail.c
> new file mode 100644
> index 0000000000000..bf60a27731fb3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/call_rcu_fail.c

[ ... ]

> +SEC("syscall")
> +__failure __msg("sleepable helper bpf_copy_from_user") __msg("in non-sle=
epable prog")
> +int sleepable_callback(void *ctx)
> +{

[Severity: Medium]
Does SEC("syscall") cause this test to pass for the wrong reason?

Since the main program is marked as non-sleepable, the verifier will reject
the sleepable helper regardless of the callback context. Should this be
changed to SEC("syscall.s") so the main program is sleepable, which would
properly force the verifier to reject the helper purely because it is inside
the non-sleepable callback context?

> +	struct elem *e;
> +
> +	e =3D bpf_map_lookup_elem(&arr, &key);
> +	if (!e)
> +		return 0;
> +	bpf_call_rcu(&e->rh, &arr, sleepable_reclaim);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191407.1742=
386-1-puranjay@kernel.org?part=3D2
