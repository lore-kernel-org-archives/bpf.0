Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FB4E431C
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602706; cv=none; b=WOpcbs/1wbysXUoh3LPn1HnfGI1to9L67DuuZW53z0ZyrqX3JkLAnXPGT8X2te21jQfFD5XZ+Q9KRQsO9x3uilmO49kou9HP2jjXtSz5/G/MUDA8Nogl1R2s7hXdyd8fRqi+MbwIBjBlcn5bYNjSFr9QtRuD3+L5vw43756HhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602706; c=relaxed/simple;
	bh=tw4Yf+S8V1C9PXL0XZIDuI6sx2gh/c6t8tJcq2zDUSA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jUOBMjmypT2VqEtX+exyjAJ8c/VtwYM1eIHoO4pN13Dvx4xDPQoBzj/i/s733JHUOiFC1iwzE5zL8A0OOym68M+dMHlzgGw19MMft+lI5ibb6wksyuCVrRECwUWxBx1sRR9Zdz/2PSVqjs4WSo4rKYPYlmY5REpw5sXE0+3RE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ynKcmiA0; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ynKcmiA0"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so146887b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789602704; x=1790207504; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ygw1vx1YMoCKI9p6AoG1FePEm3NEfgLrfeWdiOdKnAE=;
        b=ynKcmiA0t7kMWXCxeG3+rwk9yalfvCTVvAYP7Omj7jjVvsEQBoEcMCRu56a/D+HOPu
         HeWI0ove7+ks/ZA6UnnctNLLz8StCfCjMhyn6lJKrXPC7+bCuU7o/yJurxFZh0+LtYre
         Zk73ZP1NSRlcKf4/J+8rvSfwLRLkib8lI0tebcRkuVYpkFFcDcO1guJrfI5vijhjaxOv
         ofFKZ1Gt1ornVnMjcSnw4HqKVfZF2JejfJSZOAPgR/gagtXC4W1LSD/53pb6gkJ3bUoW
         TGlY2JIKw57wMv2EHQjghon9So+wvVa9aUpxmQy8goacV4xluny7nxLUz2+s8GyBAGAA
         r2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602704; x=1790207504;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ygw1vx1YMoCKI9p6AoG1FePEm3NEfgLrfeWdiOdKnAE=;
        b=pMk+8Z4CxGAtMoI9y8lEsudl7NAJXHug+pqsRMtySjpWge5e4HnmeZ4BK0D5fkXo7X
         cwRZcBTspO9GZb6t5Eq42qfFsvgRT5AgZI3sAl8NtMHY+ex2xqMQKEkJwziPaSxIVSMc
         HqEhSzF3Hc0GfckVt87XIiE4WpDO0ZcPeMvNFYXlzpv3sCLtUJMpDlsEMAb0ApD1lNMp
         ACsTVzO86N+OarKz7lE+kmcKBF626AVsI8TSM5s/7K4V5XMBVuGK31NglUaJLTKSGGpE
         uipPMtHukWIXttjAsqnSxEofJIOfmccSC0ca6JS4T7ejprq/o6CCRzqJB92zAo72Db6F
         QC7g==
X-Forwarded-Encrypted: i=1; AKwUvBxX7BvIB2vFM7eH34bsZT9E8zEXC2qtDL9txnr0zpMjVLC+3kuyhGpF3ajTjAI/Eq+GOCE=@vger.kernel.org
X-Gm-Message-State: AFuF++mlfqy/lYcZKfRYN9vVXLHe5UVdcGf999aqR7j6Xfe6PUJOsuhS
	3tPC+xW4eeUCWlxpP7HpddK8MXd2Z1WJMWz9ozug37Sbym2m+diMSuAwjXFcr/CQZns=
X-Gm-Gg: AYBFou0C93q18I1z5gd+UGhJGV7Njip94BjhOzMCA/JyXQMf0DEJYPN92LOKUfCoweG
	m5wqdsZKEjH/AqmS6ih1ov8O369GVnq2bDUIuY1mo0NhMCS2Y9NsZ6H1niLwzmXWZxysMkTAuJZ
	KhgWC/zf63hUeUnSCN6+SBvtbWKx8r8S9itZK+A3qpganLCi3eNGZ5n6t93yWHrcqRTZFheIs1t
	9K6MDezUDp/trDxE5Y5OgFph/7cnCZ/5V/cuLXUlM0+PeHLbCJN1+Yk/iTPiESqgkQ7v+DucxsU
	h5q+1QVMfCCO841EluzfRn8Zp+BE2U1xJJhomBJ/n6oHI3ksBTzuGdQDN8jbXp9mUHaMbaoY96O
	/NllORCHwKLDeZ11+iP57OEHmtTITBUg5jitRzrM01/NOZOgWjYPitJrgFrj31aLEbza24Rw31p
	GhsiHucB0n90RsBGTWVgQxSBATiWxRpBYm14v9fUokrqOf+FlMw0AEzJlfWx5OVGajkGvHzss9p
	d5Y7fNTcMYpofyP7Y+x54oY+N4q
X-Received: by 2002:a05:6a00:ac2:b0:871:13f7:9c41 with SMTP id d2e1a72fcca58-87238f94fdcmr9462876b3a.14.1789602703850;
        Wed, 16 Sep 2026 16:51:43 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200c581fcsm1952912b3a.12.2026.09.16.16.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 16:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 23:51:41 +0000
Message-Id: <DLH57NI97844.2XBZUZV378XNE@etsalapatis.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Wait for links to come up in
 lwt_ip_encap
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <bastien.curutchet@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260916232407.764886-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260916232407.764886-1-alexei.starovoitov@gmail.com>

On Wed Sep 16, 2026 at 11:24 PM UTC, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> lwt_ip_encap creates three fresh netns with veth pairs across them and
> then immediately pings over IPv6. The peer ends of the first veth pair
> end up with the same ifindex in their respective netns, so linkwatch
> does not treat the carrier-on as urgent and may deliver NETDEV_CHANGE up
> to one second later. Until that happens addrconf considers the link not
> ready: no ff00::/8 multicast route and no link-local address are
> installed, and the neighbour solicitation for the next hop is dropped
> as a no-route packet. The NS retransmit a second later succeeds, but
> ping -W1 has already given up:
>
>   check_ping_ok:FAIL:ip netns exec ns-lwt-ip-encap-1-... ping -6 -c 1 -W1=
 -I veth1 fb04::1 > /dev/null unexpected error: 256 (errno 2)
>   lwt_ip_encap:FAIL:ping OK unexpected error: -1 (errno 2)
>   #226/1   lwt_ip_encap_ipv4/egress:FAIL
>
> This reproduces reliably when the test is run standalone on an idle
> system where setup completes well within a second. The original shell
> script had a "sleep 1 # reduce flakiness" after setup which was lost in
> the conversion to test_progs.
>
> Instead of sleeping, poll SIOCGIFFLAGS for IFF_RUNNING on all veths at
> the end of setup_network() so traffic is only sent once every link is
> operationally up.
>
> Fixes: f5e288943e2c ("selftests/bpf: Move test_lwt_ip_encap to test_progs=
")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tool=
s/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> index 39e8a3b8b6af..5c5560d45c5b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <net/if.h>
>  #include <netinet/in.h>
> +#include <sys/ioctl.h>
> =20
>  #include "network_helpers.h"
>  #include "test_progs.h"
> @@ -141,6 +143,54 @@ static int set_bottom_addr(const char *ns1, const ch=
ar *ns2, const char *ns3)
>  	return 1;
>  }
> =20
> +/*
> + * A veth whose peer sits in another netns with the same ifindex gets it=
s
> + * carrier-on handled as a non-urgent linkwatch event, i.e. up to 1s lat=
e.
> + * Until then IPv6 considers the link not ready (no ff00::/8 route, no
> + * link-local address) and silently drops neighbour solicitations, so wa=
it
> + * for all links to be operationally up (IFF_RUNNING) before sending tra=
ffic.
> + */
> +static int wait_for_oper_up(const char *ns, const char *dev)
> +{
> +	struct nstoken *nstoken;
> +	struct ifreq ifr =3D {};
> +	int i, fd, ret =3D -1;
> +
> +	nstoken =3D open_netns(ns);
> +	if (!ASSERT_OK_PTR(nstoken, "open ns"))
> +		return -1;
> +
> +	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
> +	if (!ASSERT_OK_FD(fd, "socket"))
> +		goto out;
> +
> +	strncpy(ifr.ifr_name, dev, IFNAMSIZ - 1);
> +	for (i =3D 0; i < 50; i++) {
> +		if (!ASSERT_OK(ioctl(fd, SIOCGIFFLAGS, &ifr), "SIOCGIFFLAGS"))
> +			break;
> +		if (ifr.ifr_flags & IFF_RUNNING) {
> +			ret =3D 0;
> +			break;
> +		}
> +		usleep(100000);
> +	}
> +	close(fd);
> +out:
> +	ASSERT_OK(ret, dev);
> +	close_netns(nstoken);
> +	return ret;
> +}
> +
> +static int wait_for_links(const char *ns1, const char *ns2, const char *=
ns3)
> +{
> +	if (wait_for_oper_up(ns1, "veth1") || wait_for_oper_up(ns1, "veth5") ||
> +	    wait_for_oper_up(ns2, "veth2") || wait_for_oper_up(ns2, "veth3") ||
> +	    wait_for_oper_up(ns2, "veth6") || wait_for_oper_up(ns2, "veth7") ||
> +	    wait_for_oper_up(ns3, "veth4") || wait_for_oper_up(ns3, "veth8"))
> +		return -1;
> +	return 0;
> +}
> +
>  static int configure_vrf(const char *ns1, const char *ns2)
>  {
>  	if (!ns1 || !ns2)
> @@ -304,6 +354,9 @@ static int setup_network(char *ns1, char *ns2, char *=
ns3, const char *vrf)
>  	if (!ASSERT_OK(configure_ns3(ns3), "configure ns3 routes"))
>  		goto fail;
> =20
> +	if (!ASSERT_OK(wait_for_links(ns1, ns2, ns3), "wait for links"))
> +		goto fail;
> +
>  	/* Link bottom route to the GRE tunnels */
>  	SYS(fail, "ip -n %s route add %s/32 dev veth5 via %s %s",
>  	    ns1, IP4_ADDR_GRE, IP4_ADDR_6, vrf);

