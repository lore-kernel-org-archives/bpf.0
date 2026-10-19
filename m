Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421716;
	b=23bMFOgtnP64xFTrYT8fOzfq87Td+tQ2Cq4MZhTDk/n5cy6b5II6e4bmx3E+D1eAs/iJ
	 h33MExCQ9rKBxLYHBdqcKMBNZLQTNahlQXPD8jLd+428KPBiCeftTA3u+X6pZoKD7thXk
	 hZaMc6m7r7Wz3Uq8xVr7yE18xUJT6WS8D5TQMdJ8xMJ1wHaBMGXMKE57Ufe99SjXK/1/p
	 3C7AZii7emSkwPyVkqmus1WNGYLqZi+opCPHZgdVDVVH80rxJTtGgGepjP+PHtHKZEHsy
	 Ig7gOsQWh2bAuaTBLZeKqGQprcn2O23MPJz2b7WWLvEyy3EDZ9OWkw0L+A+AJH3BhiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421716;
	h=Received:Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GGQDu3KpUoZE/p1c8fjAoWeH2M3H1CvP9vTMz0v9H0c=;
	b=cairlKnInfMpwvWqEp0ue+FxJCQOVF/y5AftyvCMXrQPHFAkcdH+2GihOH8KpYDTEgCI
	 GXVig5TJlusxPNtN1Luc1/Aceea+/ePKJM+8h3a5YRpfT4iXYYD/pYjWI0aFQDMHS8K1l
	 OUpoZp8Z0GqojnUsfxRBN7Mq8hweJkZwUJq/cZVcuHywaP9pgl+uG/X6ZwD/mMdncdky0
	 W2pMUTGfymw7UmZpc79KSMKlrnXGa4wUOWnFsdxaII3JviyP9PWOka5W6x6GAFNyNcXq4
	 0a9OX6HdQwuKh6SoWQ1NDy6i+xf0tZBTklgtxWmiYi00NhT43iWIvsvwX75SIQHcpKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/WZxcGZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9D606EFF9;
	Mon, 19 Oct 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/WZxcGZ
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01866513FF;
	Mon, 19 Oct 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421716; cv=none; b=PTmwy4xYTvIrLUb+zxZKAY5M0EDZu7rtd4myqWdCyaEVGS/40CAnhhqs8G+3sjK+KIzekM6ooQ/Z1BlewUcVJwcvRwV+NCd7uMWcFR5FvjoQRmNl+YPuYT7ltcXtZFt3ywlU+WH1ic2BTqq57ayvCIsCPMTqMhptyOfYBRM35yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421716; c=relaxed/simple;
	bh=yeJUiVE364TkyBT9KxNNYFIJYnduRzkfoILBp0l6keM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUEzAgiC/7qqJGN9msphzwb4GSSh6Sn5Qmk/4/hZRkGdU5pBfNLtmuTxmS/V+2lpc0QDxLYc0jx/ocQgngmp/vgB2rAK5JLA1YDZkLFumVZNbXJlkiSEKbuQOUGua7T+ePubZM7/+Yu4zcFcrc0Hq0lEwBFLcd40fJmQ3y8kjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/WZxcGZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE9B1F000C4;
	Mon, 19 Oct 2026 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421714;
	bh=GGQDu3KpUoZE/p1c8fjAoWeH2M3H1CvP9vTMz0v9H0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J/WZxcGZYXXM8Jg9S0jNEMAq/kdsDaU3s4HerB9xq/QAxe9LKLbN8RVpqlzIceM1x
	 x2pu4hX+wS8EwUUC9/57B7m4jyuM3/4GW5NsqReaV+162rJwDMRLjcZosTdHuZDzu4
	 psqYno6Rcb6zfHY7yoSfVzEFixfYGLO8/bcrDogPJ6GrCWd5R+VGnyncnWaZ5Qygup
	 rV2L5WKKgYKo1JDJuStx9JLzDBjWi+xodMTIgXG+x5cE/VU21KCJ2XtrvFvsBd9w7c
	 M120u8A26Eq/BIVjVjGQ9bCGDogpAdmlZ8TDb1qnMttEn/CirDw3rmyfRR1Zwi7E0Q
	 s/V3+aBAkHXCA==
Subject: Re: [PATCH net-next v6 5/5] selftests/net: Move the XDP feature test
 to drivers/net/hw
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Mon, 19 Oct 2026 14:55:12 +0000
Message-ID: <179242171266.3135.15973309239973345340@kernel.org>
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-5-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-5-7336e1282ca3@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch changes Remote.deploy() in
  tools/testing/selftests/drivers/net/lib/py/remote_ssh.py from…
- [Low] In dut_run()
  (tools/testing/selftests/drivers/net/hw/xdp_features.c line 490), the…

--

selftests/net: Move the XDP feature test to drivers/net/hw

This commit replaces the veth-based test_xdp_features.sh script in
selftests/bpf with a NetDrvEpEnv Python test under drivers/net/hw. The
xdp_features helper is now built there with the shared BPF rules. The
commit also changes Remote.deploy() to pass scp arguments as a list.

> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/drivers/net/hw/xdp_features.c
> similarity index 99%
> rename from tools/testing/selftests/bpf/xdp_features.c
> rename to tools/testing/selftests/drivers/net/hw/xdp_features.c
> index be4acb768e0a2..a0ec7000e444b 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_features.c

[ ... ]

> @@ -484,6 +485,7 @@ static int dut_run(struct xdp_features *skel)
>  			"Failed creating control socket on device %s\n", env.ifname);
>  		return -errno;
>  	}
> +	ksft_ready();
>  
>  	/* Allow remote startup and BPF loading on slow test machines. */

[Severity: Low]
This isn't a bug, but is this comment above the accept() retry loop in
dut_run() still accurate?

Nothing loads BPF while this loop waits. tester_run() on the remote side
only uses TCP, UDP and AF_PACKET sockets. On the DUT, main() already runs
xdp_features__open(), xdp_features__load() and xdp_features__attach()
before it calls dut_run().

The README added by this patch also says the remote helper "does not load
BPF".

The comment came in with the earlier series patch "selftests/bpf: Send XDP
feature probes with AF_PACKET". That patch took BPF out of the tester, so
the comment was already stale when it was added, and it stays stale here.

>  	ctrl_sockfd = -1;

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> index 924addde19a3e..5e2950a7c95fa 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> @@ -35,5 +35,5 @@ class Remote:
>          if not os.path.isabs(what):
>              what = os.path.abspath(self.dir_path + "/" + what)
>  
> -        cmd(f"scp {what} {self.name}:{file_name}")
> +        cmd(["scp", what, f"{self.name}:{file_name}"])

[Severity: Low]
This change looks like a standalone fix for the shared Remote.deploy()
helper. It isn't really part of moving the XDP feature test.

When cmd() gets a string with spaces, it splits it in
net/lib/py/utils.py:

    if shell is None and isinstance(comm, str) and ' ' in comm:
        comm = comm.split()

So a local path that contains spaces reaches scp as several arguments.
Existing callers already hit this, for example main() in
drivers/net/hw/csum.py:

    cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)

Would it make sense to split this out into its own patch with a Fixes: tag
for commit 1a20a9a0ddef ("selftests: drv-net: define endpoint structures"),
where the scp string was introduced? That would make the fix easier to find
and backport.

>          return file_name

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3%40gmail.com
