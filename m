Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948ED36C581;
	Mon, 10 Aug 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343434; cv=none; b=g5qrEIShVzbKYDJN4aWTzhL+KLa9AheccnrveHZ9W2Of2V/bCGIfCs43aKi8orQHxXfUw9Wcf/noSmf+s/S3B7yqMybm69osrtp/ETAzJOkssZch79cfmGfLQU7xSbV4M+L0a8CDbg0fwYtMcDo9V2FxA1gjv4cJ9i28HnRwahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343434; c=relaxed/simple;
	bh=60jnFqpb/LmHonOhuYmnGZSf8WD1ASP7uGW4zgaoVFU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tfUNk/4hy4PkSE2nCfRfVMDqA5EGsYWuK/dAhlvuwcHZ9hZnLAwmKjuJ6GZakTwW8C20rBn5tmoGPOQlQLtOTkE6j2Q+spSlcfA3PNO/i1R+sLWMKRLhDJy+xblRAUgjItM5rwfjKZr2UmQzQZemHisM0fybOH9Z5HaAkW8Tzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gweq0US7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gweq0US7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580BD1F000E9;
	Mon, 10 Aug 2026 06:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786343432;
	bh=jkxDNm7jv/YXMf4Ku9V00dGtBGq9McwrSnGQ/iRhy1Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gweq0US7H18EbMIGQSM/oUsey4vcHo9S2FgMZRYTybnHRSUUJ3wM1iz9zow6y6zdT
	 1vf9xi+rIqnfBA5LAN26SzlOx5ReKizwceGsP0mgBstYFCObnOMdHr0sGq4b8lUGpq
	 C2lTzOifjcrGpkaWuVN5MKb1BYoa2mMUemx0WUl3Npz12aHp7cycr+qYh4mUecIqOL
	 FsZp7VfgSF3WBOE4mWieivZsUA4UvCKHObC1PQQNKTuW1HkXtDZ4/4g68QqHI4b37T
	 87Wmr8CjeJA0qnVhBBAMC5sKPxS3HuDtplYeokGteSqlCagtKEyY0E88SXwqPdA+Ex
	 qPxV2dLj7YHAA==
Content-Type: multipart/mixed; boundary="===============2538369999496004894=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27e4d2dcac92f295b98dcc4678e3a87bc3cecb4e29c2c889077af9840c990cbe@mail.kernel.org>
In-Reply-To: <20260810050621.82035-4-jiayuan.chen@linux.dev>
References: <20260810050621.82035-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: xdp: test dev_xdp_install() rejects device-bound program
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,hawk@kernel.org,sdf@fomichev.me,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,krikku@gmail.com,skhawaja@google.com,mkarsten@uwaterloo.ca,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 06:30:31 +0000 (UTC)

--===============2538369999496004894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> index 7dd18c6d06c6..4a13f8ec4300 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <net/if.h>
> +#include <linux/if_link.h>
>  #include <test_progs.h>
>  #include <network_helpers.h>
>
>  #define LOCAL_NETNS "xdp_dev_bound_only_netns"
> +#define LINK_UPDATE_NETNS "xdp_dev_bound_only_lu_netns"
>
>  static int load_dummy_prog(char *name, __u32 ifindex, __u32 flags)
>  {
> @@ -59,3 +61,50 @@ void test_xdp_dev_bound_only_offdev(void)
>  	 */
>  	SYS_NOFAIL("ip netns del " LOCAL_NETNS);
>  }
> +
> +/* A device-bound program must not run on the XDP software path.
> + * dev_xdp_attach() rejected such programs, but bpf_xdp_link_update() reaches
> + * dev_xdp_install() directly and bypasses it, so the check has to live in
> + * dev_xdp_install(). Create a generic (SKB) XDP link with a normal program,
> + * then try to swap in a device-bound program via BPF_LINK_UPDATE.
> + */
> +void test_xdp_dev_bound_only_link_update(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, lopts, .flags = XDP_FLAGS_SKB_MODE);
> +	int base_fd = -1, devbound_fd = -1, link_fd = -1;
> +	struct nstoken *tok = NULL;
> +	__u32 ifindex;
> +	int err;
> +
> +	SYS(out, "ip netns add " LINK_UPDATE_NETNS);
> +	tok = open_netns(LINK_UPDATE_NETNS);
> +	if (!ASSERT_OK_PTR(tok, "open_netns"))
> +		goto out;
> +
> +	SYS(out, "ip link add eth42 type veth");

A subsystem pattern flags this as potentially concerning: the new test
hand-rolls the network-namespace lifecycle with SYS("ip netns add") plus
open_netns() here and close_netns()/SYS_NOFAIL("ip netns del") at the
teardown, but the BPF selftest framework already provides this as a
single pair netns_new(name, true) and netns_free(netns), declared at
tools/testing/selftests/bpf/test_progs.h and implemented at
tools/testing/selftests/bpf/test_progs.c.

The shared version additionally brings lo up and wires up traffic-monitor
start/stop for -m runs, neither of which the hand-rolled sequence does.
Both LINK_UPDATE_NETNS and the paired add/del strings are also duplicated
state that netns_new() would own.

The new function is a deliberate copy of the sibling
test_xdp_dev_bound_only_offdev() at lines 27-63 of the same file, which
uses exactly the same SYS/open_netns/close_netns/SYS_NOFAIL sequence,
and 28 other files under prog_tests/ create namespaces the same way
rather than via netns_new(). Keeping the two functions in one file
structurally symmetric has clear readability value.

The functional deltas (lo not brought up, no traffic monitor) do not
affect this test, which never sends traffic. Would you prefer
netns_new()/netns_free() here for consistency with the framework helpers,
or is the structural symmetry with the sibling function the better choice?

> +	ifindex = if_nametoindex("eth42");
> +	if (!ASSERT_NEQ(ifindex, 0, "if_nametoindex"))
> +		goto out;
> +
> +	devbound_fd = load_dummy_prog("devbound", ifindex, BPF_F_XDP_DEV_BOUND_ONLY);
> +	if (!ASSERT_GE(devbound_fd, 0, "load_dummy_prog devbound"))
> +		goto out;
> +
> +	base_fd = load_dummy_prog("base", 0, 0);
> +	if (!ASSERT_GE(base_fd, 0, "load_dummy_prog base"))
> +		goto out;
> +
> +	link_fd = bpf_link_create(base_fd, ifindex, BPF_XDP, &lopts);
> +	if (!ASSERT_GE(link_fd, 0, "bpf_link_create"))
> +		goto out;
> +
> +	err = bpf_link_update(link_fd, devbound_fd, NULL);
> +	ASSERT_EQ(err, -EINVAL, "link_update device-bound rejected");
> +
> +out:
> +	close(link_fd);
> +	close(base_fd);
> +	close(devbound_fd);
> +	close_netns(tok);
> +	SYS_NOFAIL("ip netns del " LINK_UPDATE_NETNS);
> +}

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31358779411
--===============2538369999496004894==--
