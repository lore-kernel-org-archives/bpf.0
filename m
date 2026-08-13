Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D23E16AE
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660875; cv=none; b=SD1iqzSEYPNK9Uikg5gJhySVR1eeta/J6y2nNI22o4zNscvdN/2qz3fcdsGMu5NWume3/A1xJkG4IQeECibQr6xUR65bjD0+aiUX138H7XAqyOV6DrhrZoaqacY78Dw8SuF5pMadNFkQK6MftUqGmi9jrHoS0riFiIQbmIxXIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660875; c=relaxed/simple;
	bh=m5N2ca/SuAGENM32u030PBp//aJVxcGGnjBTT7gq3JU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PkXcFD+LE1A2+qLJDceXmkGIrFKEHiYdz+v9Qxx9/IQizpoJhxaNhXCr4U3QSGHbvK46wtzug7tXM383PRl18Ae1TfRo2KOX453DEoWfgVs65lCnV+ZFrf8rRW+OXYWAoI/ND/QLOPgevd7q5ry3vqoaQeew5TyWIqjP1epOBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6hbYDyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6hbYDyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA991F000E9;
	Thu, 13 Aug 2026 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660874;
	bh=RPu9YMb7nPj8L8a30Bfyx69sw6ju4rw/qnvs2vQLdQA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=k6hbYDyE48nLMh+0dQPbCFWllSCvQMB0pkPz9BcndWSH5oVxQAv0H2a6tS/03nuCu
	 Xtt0q7EbM+hlfqQVltkcSwY45UcDltrCXyExgJZfToE1DCKGExvxc4g1xdmG9CHzrf
	 sC9jr+soQ9F1Cyiddb2Rmx2Q7wN8dCq+UUEZDiPhxTSWv73eak+xKjMScTMkTwxwe3
	 SW/New34v+d/Z657xHOZc66O3IoCCE+s+RNhPyBZIv7elbhSg0osuq4nSmgd4TxUUj
	 UU6MziR3962LZw1OEQA5YHU7XRWCID2Tjdrj0zQ5MCSXCJ8TCSQo7gxke78A8wYHJ0
	 CWXMjeq1t6oZg==
Content-Type: multipart/mixed; boundary="===============4575484891590226305=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21ab42ec09540abb9ae0f130095ac5bab6d59b2254467f6dfdc193de31f53c17@mail.kernel.org>
In-Reply-To: <20260813213558.3103179-1-andrii@kernel.org>
References: <20260813213558.3103179-1-andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 22:41:13 +0000 (UTC)

--===============4575484891590226305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 0717c3442da506b8360051a6f87406ecc25dde4c
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Thu Aug 13 14:35:58 2026 -0700
>
>     selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap
>
>     lwt_ip_encap hardcodes the ping6 binary for its IPv6 pings. iputils
>     merged ping6 into ping long ago and distros have started dropping the
>     compat symlink -- Arch's iputils 20250605 ships only arping, clockdiff,
>     ping and tracepath. There, every lwt_ip_encap subtest fails:
>
>       check_ping_ok:FAIL:ip netns exec ns-lwt-ip-encap-1-0101330 ping6 -c 1 \
>         -W1 -I veth1 fb04::1 > /dev/null unexpected error: 256 (errno 2)
>       #217/1   lwt_ip_encap_ipv4/egress:FAIL

The sentence "every lwt_ip_encap subtest fails" isn't quite accurate.
Looking at test_lwt_ip_encap_vxlan_ipv4() in the patched code, it calls
lwt_ip_encap_vxlan(IPV4_ENCAP), which only ever runs the IPv4 arm:

    if (ipv4_encap)
            SYS(out, "ip netns exec %s ping -c 1 -W1 %s", ns1, IP4_ADDR_DST);
    else
            SYS(out, "ip netns exec %s %s -c 1 -W1 %s", ns1,
                ping_command(AF_INET6), IP6_ADDR_DST);

This path never touches ping6 or ping_command(), so the
test_lwt_ip_encap_vxlan_ipv4 subtest passes on a ping6-less host both
before and after this patch.

The other 9 subtests do fail: lwt_ip_encap_ipv4/{egress,ingress},
lwt_ip_encap_ipv6/{egress,ingress}, lwt_ip_encap_vrf_ipv4/{egress,ingress},
lwt_ip_encap_vrf_ipv6/{egress,ingress}, and lwt_ip_encap_vxlan_ipv6.

Would it be more accurate to say "every subtest that pings over IPv6 fails"
so the reproducer description matches the code behavior?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31747915907
--===============4575484891590226305==--
