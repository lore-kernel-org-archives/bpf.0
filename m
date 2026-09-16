Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB73A255F;
	Wed, 16 Sep 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560832; cv=none; b=ExlgHIdOOcRj4oj86LIKPGhupQfskOcJ32eg3n/zSv0q8XfULCBx61AYj3kKNdAm0d89wwSy3nRRcalktpVZwqUOZn6NGf+Da5YWRHihTSdg2tr1Ja3/zlX1HMip3ZCKAlE2L20PrDxQZ/eblGryj8U5ifCcdZgpGnT5jIafxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560832; c=relaxed/simple;
	bh=Io2hUOD6hqZO/OjkL2UB4c7H08Ucupg1KlIeb5l/Sxw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XgqT94uxzMn/o/LUkkmogm0q3DENxjUUsepn7qfNP+vO9z/TJuKNjN+RgD6CYBLCFr0qiNBP14ZSUjmXVeU2sdimpOI7BGF9BJseHRQwR0w91tCFHc4EN9ZAiN3D+aagMUqI+hgQwO33p4wuM5EthnZVZYVfKVl98XLqFu6dgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emU5WY3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emU5WY3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA14C1F000FF;
	Wed, 16 Sep 2026 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560831;
	bh=EmihTUxWOhzMMR43/FTvMrxZCrgVc5Omn7ehoHC6bDg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=emU5WY3XbfqS0+H249whMs5lWqOVLFxZ/zeBHb2hAazRpWrbjxcjT1bLMjX0H3xUx
	 OViUSYBNbT+XPaq7wh4BQf2cGzee/MAIKx9vkET9FKVLynmSQpts76+JFlWbR7EeZ1
	 5AoymMM8rCLW/buq7QLd69AzPxWtiX6p7H23b3AvxNy3m2bj6Ghq3mENJiZTrMtAI5
	 XHCwKkSxWNEm5Odkh89CHXyKcEwChlrI+cwXCJmkUip5eY3orzyxXbyMYft3VxKNs/
	 tTW9LldoQThqUXV/MYO5xxM06QBkFEEnv3kQf4dALqyEMqjilLBMnAwq5SsDfSiWZ1
	 9m9dQXYeYQnMA==
Content-Type: multipart/mixed; boundary="===============8159076130196872201=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe92569462dc4decf36f4dcb3b45372fc0d42fb6842eda0d3396fa18ee32aa55@mail.kernel.org>
In-Reply-To: <20260916112554.413933-1-madhav.khoslaa@gmail.com>
References: <20260916112554.413933-1-madhav.khoslaa@gmail.com>
Subject: Re: [PATCH v2 bpf] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
From: bot+bpf-ci@kernel.org
To: madhav.khoslaa@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: alexis.lothore@bootlin.com,madhav.khoslaa@gmail.com,eddyz87@gmail.com,ihor.solodrai@linux.dev,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 12:13:49 +0000 (UTC)

--===============8159076130196872201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 75133119c04a3..878c9fc5c37ca 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -129,12 +129,23 @@ static __u16 csum_fold(__u32 csum)
>
>  static __wsum csum_partial(const void *buf, int len, __wsum sum)
>  {
> -	__u16 *p = (__u16 *)buf;
> +	const __u8 *p = buf;
>  	int num_u16 = len >> 1;
>  	int i;
>
>  	for (i = 0; i < num_u16; i++)
> -		sum += p[i];
> +		sum += ((const __u16 *)p)[i];
> +
> +	/*
> +	 * RFC 1071: an odd-length buffer's trailing byte is paired with
> +	 * a zero pad byte to form the final 16-bit word.
> +	 */
> +	if (len & 1) {
> +		__u16 tail = 0;
> +
> +		__builtin_memcpy(&tail, p + len - 1, 1);
> +		sum += tail;
> +	}
>
>  	return sum;
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
> index 80b153d3ddecf..421dfa6c4ea36 100644
> --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
> @@ -27,7 +27,7 @@
>  #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
>  #define MAX_SOURCE_PORTS 3
>  #define TEST_PACKETS_COUNT 10
> -#define TEST_PACKET_LEN 100
> +#define TEST_PACKET_LEN 99
>  #define TEST_PACKET_PATTERN 'a'
>  #define TEST_IPV4 "192.168.0.1/32"
>  #define TEST_IPV6 "100::a/128"

The commit message body includes:

>     v1 -> v2:
>     - comment style: opening /* on its own line, per BPF selftests style
>     - Retarget the Fixes tag to bcc00987bc56. commit f4504af68575
>       ("selftests/bpf: move ip checksum helper to network helpers") moved
>       the helper, but sizeof(iphdr) is always a multiple of 32 bit words /
>       4 Bytes (iph->ihl counts in 4-byte words), so the odd-length path
>       was never reachable through build_ip_csum(). csum_partial() first
>       gets called with a length that isn't guaranteed even in
>       bcc00987bc56, via build_udp_v4_csum()/build_udp_v6_csum().
>     - TEST_PACKET_LEN 100 -> 99 so an existing test catches this instead
>       of the bug staying unexercised

This isn't a bug, but could the 'v1 -> v2:' block move below the '---'
line so it stays out of the committed changelog? Documentation/process/
submitting-patches.rst asks for inter-version changelogs to go below the
'---' separator so they are dropped when the patch is applied. The
content itself is useful review material, especially the reasoning for
retargeting the Fixes tag.

The commit message also includes this test failure excerpt:

>     Without the fix and with TEST_PACKET_LEN=99, flow_dissector_classification
>     fails under vmtest.sh:
>
>         test_flow_dissector_classification:FAIL:test third port unexpected
>         test third port: actual 0 != expected 10
>         #137/6   flow_dissector_classification/ipv6:FAIL
>         #137     flow_dissector_classification:FAIL
>         Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED

This isn't a bug, but would it be clearer to paste the full failure
output or mark the elision? The summary line says six subtests failed
(1/6 FAILED) while only the ipv6 one is shown, and test_progs.c runs
three ASSERT_EQ calls per subtest ('test first port', 'test second port',
'test third port'), so 'test first port' would have failed too. And
'1/0 PASSED' reports one passing test, which cannot come from a run whose
only named test failed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35091050280
--===============8159076130196872201==--
