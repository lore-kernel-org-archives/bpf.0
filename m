Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE524052B9;
	Wed, 12 Aug 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526592; cv=none; b=eD9mgCqssTJ6AStTGot9AfUQSCXreRfblvUB4UnXiYXiAeIz5eV0OB5JequEnNBAFIYjJvZ2B7drCv+nI6yWENvEhuTg1UtW9d2pb6z/OdJWDGEPIfG5OqI1UHiDf6XIFpGTDPxfo9TGFUbtKiwfOh7jRZE/XgqEl3pXOY3DSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526592; c=relaxed/simple;
	bh=L3nmNn+E6VxPzB8IRO9dvxmo5dUgB+VDjaKQkUj65W8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RFsd3IBVlYRaexJyvFZWtzV796/SaxnoF8psNED/YXTB993dXIK2xSkenRZEkH+xjxg0flaM+Y4sizecpPC/EiOtTId0owEkyP6vHRmOdmXoHcGuneD1htqexrS39lb6KIwDYuqcZbJXeM6y+UblwHeKa614EFZi7eCloQrY/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUv8ClAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUv8ClAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB341F00A3A;
	Wed, 12 Aug 2026 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786526590;
	bh=Vo4CjjJSBvposNw5hRn/JM84sD+qeFuxfOBnCtUreS8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UUv8ClAe2mTyv4LLejjPS2VnVh8aBBmfGdqVdLR1f0u28NFJSAearsh70uk6tszwx
	 1Le4WK5R4FDowAba7C80gMdjPJLV7jyHxk2F7d6LSEMkQKqMxVnokSCnoeepfoY0N0
	 ylejpIsKWQCWF3geoVFqTzdRUqTiDdd89NZ/EqWclwvoXQT4eciibSKWjgu6WbsznJ
	 4KFz8p3cGT4of94acq4Axf0Fk69kZId1+INJjRty0g5yLQQcPm1AuF0/iMOMuJzsDc
	 DHSbwj3PY8OzUlYPrqsqMCVlW0BJDLtoQM3z9XGru4ocqj4Vo6xiPBTWCHscqBcQpo
	 P/ib3vjpJQEEw==
Content-Type: multipart/mixed; boundary="===============1147786569287872982=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <544a8c2ce4a5a02b0223715d012a2ce8a15bab2c2c53ad76c9645a83048b0d87@mail.kernel.org>
In-Reply-To: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com>
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT processes
From: bot+bpf-ci@kernel.org
To: bochaolucky@gmail.com,andrii@kernel.org,eddyz87@gmail.com
Cc: ihor.solodrai@linux.dev,jiayuan.chen@linux.dev,lorenzo@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,bochaolucky@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 09:23:09 +0000 (UTC)

--===============1147786569287872982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c0..35ce0d4e2418 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh

[ ... ]

> +terminate_dut_server() {
> +	[ -z "$dut_pid" ] && return
> +
> +	# Use the shell job instead of a PID which may have been reused.
> +	if [ "$(jobs -pr %% 2> /dev/null)" = "$dut_pid" ]; then
> +		kill -KILL %% 2> /dev/null || true
> +	fi
> +
> +	wait "$dut_pid" 2> /dev/null || true
> +	dut_pid=""
> +}
> +
>  cleanup() {
> -	ip link del v1 2> /dev/null
> -	ip netns del ${NS} 2> /dev/null
> -	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
> +	terminate_dut_server
> +	ip link del v1 2> /dev/null || true
> +	ip netns del "${NS}" 2> /dev/null || true
>  }

Jiayuan Chen asked about removing the pidof dependency in v1: "It looks like
part of the motivation here is dropping the pidof dependency? I don't think
that's worth optimizing. Selftests already require a bunch of tools from
non-essential packages (ip, ss and ethtool in this very script)". Does the
removal of pidof serve another purpose beyond reducing dependencies, such as
fixing the concurrent test interference described in the commit message? If
the primary goal is fixing the race condition rather than removing a
dependency, it might be worth clarifying the motivation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31579454720
--===============1147786569287872982==--
