Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037E4F7CC3;
	Mon, 21 Sep 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015934; cv=none; b=D2O9xQRQgFKWcE9YJOgq97A/CaI6tdZKCVS0ZlMz7bZmi3/Jfya9DthnkCbYZclV11RsbD7KcpM1u2hIgpviS66WBqhnuxbmHRTZD2/9SY9B9HVGhz/fw7MoFONbdHWxYsVs6aOIiOCIFhvOq6Vgq/h5xvEr3x7xDleoSS0cU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015934; c=relaxed/simple;
	bh=Noyd0EEusqu/CDY+RbelqvDQP/JFOUXCXQES3sWWJRo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EsIFfKBXVcffaUeZFsac+QA7uiV1QNTWYL0uT3LbWq02CtixtZzZgA/ubhlHecBkEsDDb/QoItpsbIucj8EKP5LoW9WzI6PU8u0SJgCXmh4iuBfoRrWjsFFEbsW8I2uG/JjzhsBxZofgBn4R9QiG7ch4l8GT58QJX+c3+Scz4f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEVufFPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEVufFPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D61F00893;
	Mon, 21 Sep 2026 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015932;
	bh=LUWbowlO4gNIdL6pMhwXxrI74zwlVy2nH6gzhML1bVY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cEVufFPphb7+oazOn5cIrLCU2rikqFCHwFGWySQB/MY0opTlmppEv8LvYt4hBT/Mb
	 KqmLSBdOGankhEsgUbmXlEznxo1Ec+u6qdfvqaTVwLXGvfRFNQxHyesMR9er1n3ltk
	 hT0HX2HGDzWO4ULn++1t3TSdDuk7U/mulPEKYxLN0Yhdtt1BJOCUOOsQN+me2umvKZ
	 tG3K1xk5liym9lDg5yBkVevL8AcCk5vmhFUoSzRiQmLWp5wjZK92DEIM0UfEfWNONv
	 Hrf2lHihzglE6XA9VXX06VF56Hq/z7Nw5gdTSTj8x5qXECL6UkgEtXp5FSWojxE6a8
	 x7F+/9XsQJ8Dw==
Content-Type: multipart/mixed; boundary="===============8806451118917275112=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5864c45ca5b86f0009ccba65489985cbff9e7e210bf9822aa4875fc027aec12a@mail.kernel.org>
In-Reply-To: <20260921173910.90847-3-bestswngs@gmail.com>
References: <20260921173910.90847-3-bestswngs@gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: cover stale CB after LWT IP encapsulation
From: bot+bpf-ci@kernel.org
To: bestswngs@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,xmei5@asu.edu,bestswngs@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 18:38:49 +0000 (UTC)

--===============8806451118917275112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> index 5c5560d45c5b4..ef90dd8d4b87c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c

[ ... ]

> @@ -739,3 +739,48 @@ void test_lwt_ip_encap_vxlan_ipv6(void)
>  {
>  	lwt_ip_encap_vxlan(IPV6_ENCAP);
>  }
> +
> +void test_lwt_ip_encap_stale_cb(void)
> +{

[ ... ]

> +	SYS_NOFAIL("ip netns exec %s ping -q -R -c 1 -W 1 -I veth1 %s >/dev/null 2>&1",
> +		   ns1, IP4_ADDR_DST);
> +	ASSERT_TRUE(skel->bss->stale_cb_seen, "stale_cb_seen");
> +	ASSERT_TRUE(skel->bss->stale_cb_cleared, "stale_cb_cleared");

Could the test confirm that the probe packet actually carries an IP option?

Looking at ip_rcv_core() in net/ipv4/ip_input.c, IPCB(skb) is zeroed
unconditionally on receive:

  memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));

The opt.optlen and opt.rr fields are only written by ip_rcv_options(),
which ip_rcv_finish_core() calls only when the IP header has options:

  if (iph->ihl > 5) {
      drop_reason = ip_rcv_options(skb, dev);

If ping -R does not place a Record Route option on the wire (a ping
implementation that accepts but ignores -R, an option stripped en route,
or a non-iputils ping), the inner header has ihl == 5, IPCB(skb)->opt
stays all-zero through the LWT run, and the fentry hook records
stale_cb_cleared = true whether or not bpf_lwt_reset_cb() exists.

The stale_cb_seen flag still becomes true, because the ICMP_TIME_EXCEEDED
is produced by the TTL-one outer header the BPF program prepends and does
not depend on options at all, so neither assertion catches the missing
precondition and the test silently stops guarding the fix.

Could a pre-encapsulation check record whether opt.optlen was non-zero,
so the test fails loudly when the probe packet is not what it expects?
For example, an fentry or fexit on bpf_lwt_push_ip_encap that reads
IPCB(skb)->opt.optlen before the reset, then asserts that value was
non-zero.

> +
> +out:
> +	test_lwt_ip_encap__destroy(skel);
> +	SYS_NOFAIL("ip netns del %s", ns1);
> +	SYS_NOFAIL("ip netns del %s", ns2);
> +	SYS_NOFAIL("ip netns del %s", ns3);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35634260486
--===============8806451118917275112==--
