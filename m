Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A43161A2
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547249; cv=none; b=PFuQme3J84XxOhUiDLno5vCRCGDVKiUi68s3QxyxLbRmrF2KAEjsR8pgybKz277hT8cabXWY3hABDuuvCursH1DL/btEEUb12u+XExz054n0j9ojy4C9FtHPvoZUOR0GvJR69o8a6CnUe75gPO/RTMNo9Qo+UnXeo49oW96Q3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547249; c=relaxed/simple;
	bh=Wa6p04vZ+cxOCYibCFM/7mSGkBa99255cHiT5POOyto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p++YlvpgYVoILa5hR8wQ2+o6wcvSvq63wl047vbEtWtorcvDtAKvt1lFEeAHNDjhEC/FUMttpDNN/Yx8m+vZ8fMcs55aghkfFhYZbSAhpILHYUxFOIl1hGQA+IO3ivDE/bU2rsTwGonjy3PowrQu74K9AsW3KXnTg1FyBUcHSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjH0wvcJ; arc=none smtp.client-ip=95.215.58.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjH0wvcJ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Wa6p04vZ+cxOCYibCFM/7mSGkBa99255cHiT5POOyto=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787547244; v=1; x=1788152044;
 b=mjH0wvcJoUTKSiqGbWzDTznHXvBKqmyW4f/esrIucbV7vo4sj+HEd2r8DHHU+zpwG+eENTJ0
 clkJZ/xyV8zjS4AOMfW3B3Z+fP5DTecQdaxULmNnj2D7lCJ73Z/XfD8lalc9N2qlxLskDJ0iLwY
 xPyk0SgKAzmM8i7YhzAsE5Iw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id e4231617cf9bb9b9;
	Mon, 24 Aug 2026 04:54:04 +0000
X-Mizu-Trace-ID: e4231617cf9bb9b9
X-Migadu-Flow: FLOW_OUT
Message-ID: <195912a7-88db-408e-a6d4-6bcb29729998@linux.dev>
Date: Mon, 24 Aug 2026 12:53:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add xdp_shrink_frags
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 horms@kernel.org, martin.lau@linux.dev, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, kuniyu@google.com,
 liuhangbin@gmail.com, krikku@gmail.com, mkarsten@uwaterloo.ca,
 toke@redhat.com, lorenzo.bianconi@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com
References: <20260824030705.266049-2-jiayuan.chen@linux.dev>
 <f9fd871da7b91ccb4eb3f6bf4901981fd6b25a5f1f4b931caa42be24b5b28aa3@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <f9fd871da7b91ccb4eb3f6bf4901981fd6b25a5f1f4b931caa42be24b5b28aa3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/24/26 11:58 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
>> new file mode 100644
>> index 000000000000..f3d8a84a6dc9
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
>> @@ -0,0 +1,163 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include <network_helpers.h>
>> +#include <linux/if_tun.h>
>> +#include <linux/if_ether.h>
>> +#include <sys/uio.h>
>> +#include <net/if.h>
>> +#include <arpa/inet.h>
>> +#include "xdp_shrink_frags.skel.h"
>> +
>> +/*
>> + * A generic-XDP program that shrinks into the frags frees a page_pool frag.
>> + * skb-backed XDP first cow's the nonlinear skb into page_pool memory
>> + * (skb_cow_data_for_xdp() for generic XDP, skb_pp_cow_data() for veth), but
>> + * the shared rxq is registered as MEM_TYPE_PAGE_SHARED, so a buggy kernel
>> + * frees the frag with page_frag_free() -> "Bad page state ... page_pool leak".
>> + */
>> +
>> +#define TAP_NAME	"xdp_shrink0"
>> +#define TAP_NETNS	"xdp_shrink_tap"
>> +
>> +#define VETH_LOCAL	"xdp_shrinkA"
>> +#define VETH_PEER	"xdp_shrinkB"
>> +#define VETH_NETNS	"xdp_shrink_veth"
>> +#define VETH_LOCAL_IP	"10.9.9.1"
>> +#define VETH_PEER_IP	"10.9.9.2"
>> +
>> +static int create_tap_napi_frags(const char *ifname)
>> +{
>> +	struct ifreq ifr = {
>> +		.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_NAPI | IFF_NAPI_FRAGS,
>> +	};
>> +	int fd, err;
>> +
>> +	strscpy(ifr.ifr_name, ifname);
>> +
>> +	fd = open("/dev/net/tun", O_RDWR);
>> +	if (fd < 0)
>> +		return -1;
> A subsystem pattern flags this as potentially concerning:
> create_tap_napi_frags() collapses every failure into -1 and discards
> errno, so the caller's ASSERT_GE(tap_fd, 0, "create_tap") becomes a hard
> test failure with no diagnostic.
>
> Two concrete cases where this would happen: /dev/net/tun missing
> (CONFIG_TUN not built or the node absent) gives ENOENT/ENODEV, and
> TUNSETIFF with IFF_NAPI_FRAGS rejected with EPERM when CAP_NET_ADMIN is
> not held in the initial user namespace. Both of these should skip the test
> with a reason rather than fail it. At minimum, would keeping errno make the
> failure diagnosable?


flow_dissector.c's create_tap() (which this is modeled on) does exactly 
the same and doesn't even close the fd on the ioctl failure.

so I'd rather keep the parity than diverge here.

>
>> +
>> +	err = ioctl(fd, TUNSETIFF, &ifr);
>> +	if (err) {
>> +		close(fd);
>> +		return -1;
>> +	}
>> +
>> +	return fd;
>> +}
>> +
>> +/*
>> + * Similar to flow_dissector.c: writev() an IFF_NAPI_FRAGS tap to build a
>> + * nonlinear skb (sized for 4K pages, like xdp_adjust_tail.c) that tun runs
>> + * through do_xdp_generic().
>> + */
>> +static void test_tun(struct xdp_shrink_frags *skel)
>> +{
>> +	__u8 head[74], frag1[2048], frag2[2048];
>> +	struct ethhdr *eth = (void *)head;
>> +	int tap_fd = -1, ifindex, err;
>> +	struct netns_obj *ns = NULL;
>> +	struct iovec iov[3];
>> +	ssize_t n;
>> +
>> +	ns = netns_new(TAP_NETNS, true);
>> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
>> +		return;
>> +
>> +	tap_fd = create_tap_napi_frags(TAP_NAME);
>> +	if (!ASSERT_GE(tap_fd, 0, "create_tap"))
>> +		goto out;
>> +
>> +	SYS(out, "ip link set dev " TAP_NAME " up");
>> +
>> +	ifindex = if_nametoindex(TAP_NAME);
>> +	if (!ASSERT_GT(ifindex, 0, "if_nametoindex"))
>> +		goto out;
>> +
>> +	skel->bss->shrink_ran = 0;
>> +
>> +	err = bpf_xdp_attach(ifindex, bpf_program__fd(skel->progs.xdp_shrink),
>> +			     0, NULL);
>> +	if (!ASSERT_OK(err, "bpf_xdp_attach"))
>> +		goto out;
>> +
>> +	memset(head, 0, sizeof(head));
>> +	memset(frag1, 0x41, sizeof(frag1));
>> +	memset(frag2, 0x42, sizeof(frag2));
>> +	eth->h_proto = htons(ETH_P_IP);
>> +
>> +	iov[0].iov_base = head;  iov[0].iov_len = sizeof(head);
>> +	iov[1].iov_base = frag1; iov[1].iov_len = sizeof(frag1);
>> +	iov[2].iov_base = frag2; iov[2].iov_len = sizeof(frag2);
>> +
>> +	n = writev(tap_fd, iov, ARRAY_SIZE(iov));
>> +	ASSERT_EQ(n, sizeof(head) + sizeof(frag1) + sizeof(frag2), "writev");
>> +
>> +	usleep(100 * 1000);
>> +	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");
> Does this test actually exercise the page_pool frag release it is written
> for? The frame sizes (74 + 2048 + 2048 = 4170 bytes) are picked for 4K
> pages, but skb_pp_cow_data() puts up to SKB_WITH_OVERHEAD(PAGE_SIZE -
> headroom) bytes in the linear head.
>
> On 4K pages with XDP_PACKET_HEADROOM (256), that's ~3520 bytes in the
> head, so the 4170-byte packet gets frags.
>
> But on 64K pages, the threshold becomes ~64960 bytes, so the entire
> 4170-byte packet ends up linear and bpf_xdp_adjust_tail(-3000) never
> reaches bpf_xdp_shrink_data() - it just moves data_end and returns 0.
> shrink_ran still gets incremented, so the ASSERT_GT() passes whether or
> not the fix from the preceding commit is applied.
>
> selftests/bpf ships config.ppc64el and config.aarch64, and the existing
> xdp_adjust_tail.c that the sizing comments cite explicitly branches on
> getpagesize() == 65536. Would gating on getpagesize() or asserting
> something that only holds when a whole frag was released (packet length or
> a frag count observed from the program) make the test discriminate a fixed
> kernel from a buggy one on 64K-page systems?


On 64K it just passes as a no-op and never false-fails, and the 
analogous in-tree test test_xdp_adjust_frags_tail_shrink() also hardcodes 4K

and runs unconditionally, so this keeps parity with it (and BPF CI runs 
4K-page kernels anyway).

>> +
>> +	bpf_xdp_detach(ifindex, 0, NULL);
> [ ... ]
>
>> +/*
>> + * A large ping builds a nonlinear skb that veth cow's into its page_pool
>> + * (sized for 4K pages, like xdp_adjust_tail.c) before running the program.
>> + */
>> +static void test_veth(struct xdp_shrink_frags *skel)
>> +{
>> +	int ifindex, err;
>> +
>> +	SYS(out, "ip netns add " VETH_NETNS);
>> +	SYS(out_ns, "ip link add %s mtu 8000 type veth peer name %s mtu 8000",
>> +	    VETH_LOCAL, VETH_PEER);
> A subsystem pattern flags this as potentially concerning: test_veth
> hand-rolls namespace management with `ip netns add` / `ip netns del`
> instead of the shared netns_new()/netns_free() helpers that test_tun uses
> 50 lines earlier in the same file.
>
> It also only puts the peer into a namespace - the local end xdp_shrinkA
> and its address 10.9.9.1/24 are created in whatever namespace test_progs
> is running in (normally the host), so the test mutates the caller's
> network configuration. The cleanup is best-effort SYS_NOFAIL, leaving the
> device and address behind if the process dies between setup and teardown.
> Fixed device/netns names also mean two concurrent test_progs workers
> collide.
>
> prog_tests/test_xdp_veth.c in the same directory keeps even the "local"
> side inside a dedicated ns0 namespace for exactly this reason, and appends
> the TID to the name. Would wrapping test_veth in netns_new() for a local
> namespace and creating both ends inside it make the netns teardown remove
> the veth pair, the address and the XDP program together?


  Sounds reasonable. I'll wrap test_veth in netns_new() and create both 
veth ends inside it, like test_tun does.


>
>> +	SYS(out_link, "ip link set " VETH_PEER " netns " VETH_NETNS);
>> +	SYS(out_link, "ip addr add " VETH_LOCAL_IP "/24 dev " VETH_LOCAL);
>> +	SYS(out_link, "ip link set " VETH_LOCAL " up");
>> +	SYS(out_link, "ip -n " VETH_NETNS " addr add " VETH_PEER_IP "/24 dev " VETH_PEER);
>> +	SYS(out_link, "ip -n " VETH_NETNS " link set " VETH_PEER " up");
>> +
>> +	ifindex = if_nametoindex(VETH_LOCAL);
>> +	if (!ASSERT_GT(ifindex, 0, "if_nametoindex"))
>> +		goto out_link;
>> +
>> +	skel->bss->shrink_ran = 0;
>> +
>> +	err = bpf_xdp_attach(ifindex, bpf_program__fd(skel->progs.xdp_shrink),
>> +			     0, NULL);
>> +	if (!ASSERT_OK(err, "bpf_xdp_attach"))
>> +		goto out_link;
>> +
>> +	SYS_NOFAIL("ip netns exec " VETH_NETNS
>> +		   " ping -q -s 5000 -c 3 -W 1 " VETH_LOCAL_IP);
>> +
>> +	ASSERT_GT(skel->bss->shrink_ran, 0, "xdp_prog_ran");
> This test has the same page-size dependency as test_tun above. The `ping
> -s 5000` produces ~5042 bytes on the wire, which is below the ~64960-byte
> linear threshold on 64K-page kernels, so veth_convert_skb_to_xdp_buff()
> sees nr_frags == 0 and bpf_xdp_adjust_tail() never enters
> bpf_xdp_shrink_data().


Same as the tun one: no false-fail on 64K, and CI is 4K.


>> +
>> +	bpf_xdp_detach(ifindex, 0, NULL);
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
>> new file mode 100644
>> index 000000000000..62e3791ac81d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/xdp_shrink_frags.c
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +
>> +int shrink_ran;
>> +
>> +SEC("xdp.frags")
>> +int xdp_shrink(struct xdp_md *ctx)
>> +{
>> +	/*
>> +	 * The program is loaded with BPF_F_XDP_HAS_FRAGS (xdp.frags), so a
>> +	 * nonlinear skb entering generic XDP is cow'd into page_pool memory
>> +	 * before we run. Shrinking the tail far enough releases at least one
>> +	 * whole frag, which must be returned to its page_pool. Count only a
>> +	 * successful shrink so a too-small frame (e.g. ARP) does not satisfy
>> +	 * the test.
>> +	 */
> Does this comment accurately describe what the test guarantees? "Shrinking
> the tail far enough releases at least one whole frag" only holds if the
> cow'd skb has frags at all.
>
> skb_pp_cow_data() puts up to SKB_WITH_OVERHEAD(PAGE_SIZE - headroom) bytes
> in the linear head:
>
> net/core/skbuff.c:skb_pp_cow_data() {
>      max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
>      size = min_t(u32, skb->len, max_head_size);
>      ...
>      for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++)
> }
>
> With PAGE_SIZE == 65536 and headroom == XDP_PACKET_HEADROOM (256),
> max_head_size is ~64960 bytes. The test's frame sizes are 4170 bytes (tun)
> and ~5042 bytes (veth), so on a 64K-page kernel there are zero frags and
> bpf_xdp_adjust_tail() still returns 0 without calling bpf_xdp_shrink_data().


On the 4K pages the test targets (like the other frags tests) it does 
have frags,

so the comment holds for what the test actually runs.


> Two smaller mismatches in the same comment block and in the prog_tests
> header comment:
>    - This program is attached on both the generic-XDP (tun) and veth paths,
>      but the comment only describes "a nonlinear skb entering generic XDP".

The file header already says it covers both generic XDP and veth;

the prog comment just uses the generic path as the example and the cow 
behaviour is identical.

>    - The prog_tests header says "skb_cow_data_for_xdp() for generic XDP,
>      skb_pp_cow_data() for veth", which reads as two different mechanisms.
>      But skb_cow_data_for_xdp() is just a wrapper that calls
>      skb_pp_cow_data(), and the veth call site is
>      veth_convert_skb_to_xdp_buff() - both paths end up in skb_pp_cow_data().


Those are the actual call sites (generic goes through 
skb_cow_data_for_xdp(), veth calls skb_pp_cow_data()

directly from veth_convert_skb_to_xdp_buff()), so naming both is 
accurate rather than two different mechanisms.

>
>> +	if (bpf_xdp_adjust_tail(ctx, -3000) == 0)
>> +		__sync_fetch_and_add(&shrink_ran, 1);
>> +	return XDP_PASS;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32686145995
