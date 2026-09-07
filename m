Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA223033EB;
	Mon,  7 Sep 2026 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747699; cv=none; b=MwJPB5EDkFtExF9dripFxCmkCip6B37qNf4OXv7X+AHfN41io/MnsnQXcZE5s6cbjIZvqp1IL/wT4EPkfzTB/CWuDxB4Xl3K3e8+zmUolVzM9uQgIciDyIF5/dTxsatdf/aMYOCR3/5+BpiPz22M4rvGlKBFQ7TwZeApK8X0F5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747699; c=relaxed/simple;
	bh=JWMRTlyGKFZQ6J1Jgo16pLLOsGnC+Gt7LnlNDGGAWPo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r8/9dfW1fT0BIj6niCYtDyfOTH+fqM4YNHbK+N2kf8UqAUoqOxJX31HEzvmIMTTcEgRDAqBENg5v79Y92kFg5OM38nReSMN2lNgLm4nViEd2c/5wKQJ01xIwb6U+M8a2h+pQVY1HYCVvXvPiWLjFdR4SUkAd3bkopftug2qxXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hiyz0JEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hiyz0JEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08D41F00A3A;
	Mon,  7 Sep 2026 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747698;
	bh=U4AEzfvaa2QuYNAdVonKpbE0ZtJtH45xv00XCXaFvo0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hiyz0JEhIbSHebJAVG2+XM5v4yc8Tiln8zw3ufgTf+ga95b43xy1nfC8r++grf9oJ
	 XZFpt8BXxaLOmYv7L3tQVE+421YnW8RvRK8pcI2qqunhBnsSBzFOAP5FMCB8fz2lbT
	 dQhkfTdYTnClp+SJzEV1SmRbepyE4B5pNaZBwn4bYo31jUCADJOHS3VihLobbkxZ8N
	 qFbHMtxTT968evl3ze55YSFow8eXFVcE4M1lPq54uA02qY2o39QqQ6GG27VIBWpbIN
	 rDA/q11Wc0DX3mFEWwKXn2Cog0PiFE32jhLmgifIHS14QbpkEEo7w24WOFpBcpaWFI
	 OOMk6qchi9Vkw==
Content-Type: multipart/mixed; boundary="===============9035755968384135438=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97cc13b58bb198fedee2dd3d6d68ba5222dac4021162dbdb17ab364b72d60ba8@mail.kernel.org>
In-Reply-To: <178874362960.1415955.8995787346446727387.batch-v2-2@tychen.cc>
References: <178874362960.1415955.8995787346446727387.batch-v2-2@tychen.cc>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check bpftool batch map dump contents
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:21:37 +0000 (UTC)

--===============9035755968384135438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> new file mode 100644
> index 000000000000..b4216ed778ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

[ ... ]

> +static void expected_record(char *record, const struct dump_case *test,
> +			    unsigned int index, bool json)
> +{
> +	__u32 key = index, value = index * 37 + 11;
> +	unsigned char short_key = index;
> +	char key_hex[64], value_hex[64], formatted[96];
> +
> +	hex_bytes(key_hex, test->key_size == 1 ? (void *)&short_key : &key,
> +		  test->key_size, json);
> +	hex_bytes(value_hex, &value, test->value_size, json);

[ ... ]

> +static void run_dump_case(const struct dump_case *test)
> +{

[ ... ]

> +	for (i = 0; i < test->count; i++) {
> +		__u32 key = i, value = i * 37 + 11;
> +		unsigned char short_key = i;
> +		void *key_ptr = test->key_size == 1 ? (void *)&short_key : &key;
> +
> +		if (!ASSERT_OK(bpf_map_update_elem(fd, key_ptr, &value, BPF_ANY),
> +			       "map_update"))
> +			goto out;
> +	}

This isn't a bug, but the key/value derivation appears in both
expected_record() and run_dump_case() with the same formula (index * 37
+ 11) and the same short_key narrowing logic. Would it be worth having
a single small helper that derives the key pointer and value for an
index, so the insert side and expectation side cannot drift apart?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34074207177
--===============9035755968384135438==--
