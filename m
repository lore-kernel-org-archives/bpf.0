Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA492DAFAF;
	Fri,  2 Oct 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790918083; cv=none; b=lmWdzZCi4f8ySmjRToigzU981M/nPiQICFBunfDSOipAiYQwt2EyTKM9imFDLEL+JF92aLF07NEO1NopMf2WxXPMVrUvC65UwkARr7YUel5GmO5WNTgx84n4Lg8Bj+fd4GmxsbZ6WGYsNwq0uOVT1g6ZdE/FsoS0k8kTT9lbF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790918083; c=relaxed/simple;
	bh=D92WhrZH+54cjQPN+K8ltIeWhFkD/it2q9JkQccXjjQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bxbleta7Oqy59nksxVnKslgS3fxFuGPYnX1TA7yJfQxfH37MCFtWm9EPbOWP2Muv5rtg2i83E7ExXhwgomW0aZQaRJq55i1RXqKyGZFMLJpLuNoVRSInFKE9/1lyKoz6dKGjxBemq3AN7FuozMN1p/EsWzlnYNeeeoBwhEE3LhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxa3in1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxa3in1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA3B1F000FF;
	Fri,  2 Oct 2026 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790918081;
	bh=ZTPYABB2u4qxTYVrhofxTi+nKWD1avZUblAo3JWd1fA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bxa3in1PDTIc9CtlCSc//T2TREVtKt53RDb2K2dmzUUofLbGS3BBPrcfI3wvZCHgK
	 R703RSR6Alq4uXKpQqh69KSmoyFRNJG/ZSHdeaSib6AXHqCGNFk+16GyMqXeFEQItz
	 XgF18r7u6VlMu7oygdwcHjTB8r4v8xwIYEJULwm3e5EO3pbUiA310L1jIx2AA5dG01
	 o2p6ZAe1nRw3UzmSq7rNfZI5ksZNba8seInXyF5S6gl12iejdXrITno/CQWmrcqFvJ
	 hx87SVQhGNsfXpV+umqu31RRYqLiJu+f+YlVD35qUWF0Rf0duiatjUZvOrgweYisLd
	 OryKoC95ySoAQ==
Content-Type: multipart/mixed; boundary="===============3278906847704703613=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa827bb60ac91fb2860c3307b5942aee2bf0810b21dbbc297aac5f61fb102627@mail.kernel.org>
In-Reply-To: <20261002042201.3483076-1-anilkaushikwireless@gmail.com>
References: <20261002042201.3483076-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add XDP test for per-flow LRU_HASH window updates
From: bot+bpf-ci@kernel.org
To: anilkaushikwireless@gmail.com,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org
Cc: sdf@fomichev.me,ihor.solodrai@linux.dev,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,anilkaushikwireless@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 05:14:40 +0000 (UTC)

--===============3278906847704703613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: add XDP test for per-flow LRU_HASH window updates

TL;DR:
- Test issue: wrap subtest uses identical packet lengths, so it can't detect a
  wrong post-wrap index
- trunc subtest sends a non-IPv4 frame, so it likely never reaches the
  truncation checks

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
> new file mode 100644
> index 000000000000..55175c2165ec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
> @@ -0,0 +1,168 @@

[ ... ]

> +static void test_one_and_wrap(void)
> +{
> +	struct xdp_lru_window_state st;
> +	struct xdp_lru_window_key key;
> +	int i, n;
> +
> +	reset_map();
> +	if (inject(1, DST_PORT))
> +		return;
> +	fill_key(&key, DST_PORT);
> +	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup"))
> +		return;
> +	ASSERT_EQ(st.seq, 1, "seq");
> +	ASSERT_EQ(st.pkt_len[0], sizeof(struct ipv4_packet), "len0");
> +
> +	n = AGGREGATION_WINDOW + 5;
> +	if (inject(n - 1, DST_PORT))
> +		return;
> +	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup wrap"))
> +		return;
> +	ASSERT_EQ(st.seq, n, "seq wrap");
> +	for (i = 0; i < AGGREGATION_WINDOW; i++)
> +		ASSERT_EQ(st.pkt_len[i], sizeof(struct ipv4_packet), "slot");
> +}

Can the final "slot" loop detect a wrong post-wrap write?

Every packet sent by inject() is the same pkt_v4 copy, so every write stores
sizeof(struct ipv4_packet) (54).  After the first 50 packets, slots 0..49
already hold 54, and packets 51..55 write 54 into slots 0..4 again.  The
loop therefore checks nothing that was not already true before the index
wrapped.

The "seq wrap" check only shows the program did not take the
"idx >= AGGREGATION_WINDOW" early return.  A miscompiled modulo that
produced a wrong but in-range index would still pass.

The commit message says this subtest checks that "the bounded array wraps".
Would it make sense to send the post-wrap packets with a different length
(run_pkt() accepts any len >= ETH_HLEN, and the program records
data_end - data), then check that slots 0..4 hold the new length while
slots 5..49 keep the old one?

[ ... ]

> +static void test_trunc(void)
> +{
> +	struct xdp_lru_window_state before, after;
> +	struct xdp_lru_window_key key, next;
> +	unsigned char short_pkt[sizeof(struct ethhdr)] = {};
> +	int err, retval;
> +
> +	reset_map();
> +	err = run_pkt(short_pkt, sizeof(short_pkt), &retval);
> +	if (err)
> +		return;
> +	ASSERT_EQ(retval, XDP_PASS, "trunc retval");
> +	err = bpf_map_get_next_key(map_fd, NULL, &next);
> +	ASSERT_EQ(err, -ENOENT, "trunc no insert");

Does this subtest reach any of the program's truncation checks?

short_pkt is 14 zero bytes, so eth->h_proto is 0.  In
progs/xdp_lru_window.c the program passes the Ethernet bounds check and then
returns at:

    if (eth->h_proto != bpf_htons(ETH_P_IP))
            return XDP_PASS;

The IPv4 length check ((void *)(iph + 1) > data_end) and the TCP length
check ((void *)(th + 1) > data_end) never run, here or in any other
subtest.

The "trunc no insert" and "trunc no mutate" assertions would pass the same
way for a full-length non-IPv4 frame, so this exercises the ethertype
filter rather than truncated-packet handling.  The commit message describes
this subtest as checking that "a short (parse-failing) packet neither
inserts a new entry nor mutates an existing one".

Should short_pkt have h_proto set to htons(ETH_P_IP) so the IPv4 length check
is reached?  To also reach the TCP header check, a truncated copy of pkt_v4
of sizeof(struct ethhdr) + sizeof(struct iphdr) bytes could be sent.
bpf_prog_test_run_xdp() only requires data_size_in >= ETH_HLEN, so both
sizes are accepted.

> +
> +	if (inject(1, DST_PORT))
> +		return;
> +	fill_key(&key, DST_PORT);
> +	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &before), "setup"))
> +		return;
> +	if (run_pkt(short_pkt, sizeof(short_pkt), &retval))
> +		return;
> +	ASSERT_EQ(retval, XDP_PASS, "trunc2 retval");
> +	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &after), "after"))
> +		return;
> +	ASSERT_EQ(after.seq, before.seq, "trunc no mutate");
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36965595251
--===============3278906847704703613==--
