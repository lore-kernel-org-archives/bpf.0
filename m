Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531A1ADC97;
	Fri, 27 Feb 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184706; cv=none; b=OtrIciB/mWvilhNodxzuQh2i39OB8yJtc+WQBQ+KvKLi7N0ZAgzRzcJbAVEQL59d/EV8FyFySd3jScBN11qH7QBwXo6m5eqE/KY75vJtmTxnLZlULMYYLUh3zVykUsHLr91w1G560/04PETO8iHRVj38qrtQdyAXHQK9Q/kPOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184706; c=relaxed/simple;
	bh=HB87+9FYEmhHPM4cdXsCxHL/PQIiwRGNufQTxNZNI48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0MUZgqCWelBN8LXgQBNx+G8wBqvKB9T/vdVko8vJpQQLTtKeCej+5E0y3yQ8S/Q7CYK+8ZMui4BNKuclItmyeQHEDWfWKW3X8AFs9FfezyCse4G7yZR7bUbjwNNDpZrgqmfG4+XYADvUawjJbmkwK4ZWGAbxXd6yq6vDIne3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtHHmUTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtHHmUTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1D8C116C6;
	Fri, 27 Feb 2026 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772184706;
	bh=HB87+9FYEmhHPM4cdXsCxHL/PQIiwRGNufQTxNZNI48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dtHHmUTv7SiS81e6ilDUN0edZH2tY0ms5NhzM9JHveGh3TzMZaDEqZhOGq4lJxnlu
	 LJBcR4hqx/zXw0ID8o419/8+hl7cGUsn/7Cs0LvwzUxKXidZogm7K/10Q2UUB24qnA
	 jpJwFP9BQDYyZFHyV4Sy3NeaDIKktplID8iwybZzuP8X9mURxCCNK+tdcRTY6PpkO6
	 RpoVrG/DFJUDf38Vrfx8Wj7OrjU+btqk0xjmV4PgPqOMxOSPaB0uQx01sO8zlBw9WX
	 4aTSQ5sMxP8fpCBILiC+O/nPSik3MmEBUEsl/OcgyjM1gL0wqQWXx3qFv42xq3GUYE
	 R/cOWfJKOq16Q==
Message-ID: <8610334b-aa82-4fef-a9cf-41c0bfca4dbe@kernel.org>
Date: Fri, 27 Feb 2026 09:31:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: drop test_bpftool.sh
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260227-bpftool_feature-v1-1-a25860fd52fb@bootlin.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260227-bpftool_feature-v1-1-a25860fd52fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-02-27 09:08 UTC+0100 ~ "Alexis Lothoré (eBPF Foundation)"
<alexis.lothore@bootlin.com>
> The test_bpftool.sh script runs a python unittest script checking
> bpftool json output on different commands. As part of the ongoing effort
> to get rid of any standalone test, this script should either be
> converted to test_progs or removed.
> 
> As validating bpftool json output does not bring much value to the test
> base (and because it would need test_progs to bring in a json parser),
> remove the standalone test script.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Regarding the discussion on JSON: If you need to check bpftool's output
in other tests, it's probably OK to simply look at the plain output.
We've been discouraging people to parse the plain output because it's
not considered stable, but given that the tests and bpftool itself are
in the same repo we could always adjust any test that would break if we
changed something in the output.

Thanks for your work on this!
Quentin
