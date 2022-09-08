Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D4C6FA82
	for <bpf@archiver.kernel.org>; Thu,  8 Sep 2022 23:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIHXfT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiIHXeT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:34:19 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F24DF87;
        Thu,  8 Sep 2022 16:32:45 -0700 (PDT)
Message-ID: <e1648c86-7859-a7c8-4474-83c826cbb464@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662679963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4h5uiyu4BHhuzjh3Km5pgkaAIvVPhqtZf6why7EQlk=;
        b=kEaqdzjqESReT3otttYYbLEhVN7HPwqV9YPjY5ve1cHHuFC6qfVhsXBRoji79ojRpm0Bg4
        iokF23zioLIWgN22TkR0FedMnPrPUq/afjPUbPfBj7rb5yXIMNSWCzK9fnRUUdEuU3Iu/+
        n6u5RAsQ1VtLv0CgdF/0QjgH2iDwHrk=
Date:   Thu, 8 Sep 2022 16:32:39 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Ensure cgroup/connect{4,6}
 programs can bind unpriv ICMP ping
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <cover.1662678623.git.zhuyifei@google.com>
 <97288b66a44c984cb5514ca7390ca0cf9c30275f.1662678623.git.zhuyifei@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <97288b66a44c984cb5514ca7390ca0cf9c30275f.1662678623.git.zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/8/22 4:16 PM, YiFei Zhu wrote:
> +void test_connect_ping(void)
> +{
> +	struct connect_ping *skel;
> +	int cgroup_fd;
> +
> +	if (!ASSERT_OK(unshare(CLONE_NEWNET | CLONE_NEWNS), "unshare"))
> +		return;
> +
> +	/* overmount sysfs, and making original sysfs private so overmount
> +	 * does not propagate to other mntns.
> +	 */
> +	if (!ASSERT_OK(mount("none", "/sys", NULL, MS_PRIVATE, NULL),
> +		       "remount-private-sys"))
> +		return;
> +	if (!ASSERT_OK(mount("sysfs", "/sys", "sysfs", 0, NULL),
> +		       "mount-sys"))
> +		return;
> +	if (!ASSERT_OK(mount("bpffs", "/sys/fs/bpf", "bpf", 0, NULL),
> +		       "mount-bpf"))
> +		goto clean_mount;
> +
> +	if (!ASSERT_OK(system("ip link set dev lo up"), "lo-up"))
> +		goto clean_mount;
> +	if (!ASSERT_OK(system("ip addr add 1.1.1.1 dev lo"), "lo-addr-v4"))
> +		goto clean_mount;
> +	if (!ASSERT_OK(system("ip -6 addr add 2001:db8::1 dev lo"), "lo-addr-v6"))
> +		goto clean_mount;
> +	if (write_sysctl("/proc/sys/net/ipv4/ping_group_range", "0 0"))
> +		goto clean_mount;
> +
> +	cgroup_fd = test__join_cgroup("/connect_ping");
> +	if (!ASSERT_GE(cgroup_fd, 0, "cg-create"))
> +		goto clean_mount;
> +
> +	skel = connect_ping__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel-load"))
> +		goto close_cgroup;
> +	skel->links.connect_v4_prog =
> +		bpf_program__attach_cgroup(skel->progs.connect_v4_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.connect_v4_prog, "cg-attach-v4"))
> +		goto close_cgroup;

connect_ping__destroy() is also needed in this error path.

I had already mentioned that in v2.  I went back to v2 and noticed my 
editor some how merged my reply with the previous quoted line ">".  A 
similar thing happened in my recent replies also.  I hope it appears 
fine this time.

> +	skel->links.connect_v6_prog =
> +		bpf_program__attach_cgroup(skel->progs.connect_v6_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.connect_v6_prog, "cg-attach-v6"))
> +		goto close_cgroup;

Same here.
