Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01244D9FF
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524451; cv=none; b=gqh0XtVSvFQPMROB8BXG2KKJMzoNDdSng39O0ryZpOe9zJ7XMJRcY4/pYMYMxChFPsetzkCEHo2t6pFDnk5T/41SrftGDIv5A/Oh43d9dfZthRiJW46pT76mut7uz67bGXCBar6uEYBnplCIvpNFPBXTAzmJHU+80S5i5Ty9DiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524451; c=relaxed/simple;
	bh=5HCRl2x1viEyNkAD/Zm4AolqRu1YCoqTb4oMNH+XAkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WPSQhPRewt4ItHLUxQpdVrZFt1SiWCBPkL0dtru2UXIu4ZYVYdi63JcAJvspNzEQvHnt2SmbaRCth0of+cEDFtEoHWi0f5nI0m8MY3EG33T0tYA4vTVwrw1SQtgZPjjM/mkrRwtaqL4UBk1iC3fXs3WfD+U/y9hHFtAJSEAzrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyBrlIAf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyBrlIAf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6a9ffaf3eso2251973b3a.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710524449; x=1711129249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=48KHiiBIGucSlkCxyuE9gcyqU8jXsSRw/tV7Rve5Qs0=;
        b=RyBrlIAfYgmhp3UcrK+Sq8lL4JrJmpKcpYHPO0SHNYZtjQ+ZZUjELT/E5/lKioLuFD
         UVpKO90H/b7Dm+OXOXZcUxXB5S3FN4lEV06Ce7pkwogweLSteQgmsN57p8l4JrDajr/7
         M4iPTgWMdRF5GIuiky0Stt2Kgun4tP6BAK4+2LhG65qvKI5dwhMxak0vm3m5s9BTjV1B
         61+zgWvKumyhk9F2+iqyn1V1kV6OZLn8UVkQ02gUVs3jDV/fyXBI6KW1KNPj3rr6NtgW
         7gvN/rCNh3bI16p5GtVlEtFfVesEDr9JfR7NQ7rBIDWfU4ndtcI2PFKz/NlEL3lotDZP
         1JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524449; x=1711129249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48KHiiBIGucSlkCxyuE9gcyqU8jXsSRw/tV7Rve5Qs0=;
        b=M4lXXcJ51yqcXZZelMNshkfud4VwMvBQsbVdIDJN3K8SgFH3jj60vcR800xf8EoBwq
         kpT/tF1O/2Ll19njg7YdAOJpwJHHTiiMqZSQUt5lwmDhNvQCtjoueAKQaq4caHWCY57H
         OUOsggJUQRb+CyXxj000NctRMxOgzqGaPlJPg1lxAPcmDJpzMoztl0J4wrgzIm6QWQJ5
         D+LuxZnQKId8aDbAmOnbSk8V2YLPFTOnbjyYwTOclfhW6vNCnuB9wYqj8qJB3i3OANHR
         BslRC1E1dsQicoYcrkXR9Z4NngDwe6FjlyBMOZgKaQfIvnKzIxaNl3/txSY3oKVvoYG8
         rQVw==
X-Gm-Message-State: AOJu0YwFLbSKTnns6x7AHTN1X+7isusoKIfXIrnIr6z1fsqaJ8sveb4G
	8fbXXuTrk5xCY/813boe3IFBkXiGkL85FmIO0/zjCnnniK4w5u6UQicbDZlKwsE1YQ==
X-Google-Smtp-Source: AGHT+IFpe7r7WewlV5WqGwWS9beNX0I0LXtoPYI2Emv6EVTpv4fDD4jM7m/hJKkpsk32OyGQ28U4d4A=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3986:b0:6e6:9ad4:6131 with SMTP id
 fi6-20020a056a00398600b006e69ad46131mr254656pfb.4.1710524448954; Fri, 15 Mar
 2024 10:40:48 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:40:47 -0700
In-Reply-To: <20240315140726.22291-4-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315140726.22291-1-tushar.vyavahare@intel.com> <20240315140726.22291-4-tushar.vyavahare@intel.com>
Message-ID: <ZfSIH07rCk3mjjWc@google.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/xsk: implement get_hw_ring_size
 function to retrieve current and max interface size
From: Stanislav Fomichev <sdf@google.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="utf-8"

On 03/15, Tushar Vyavahare wrote:
> Introduce a new function called get_hw_size that retrieves both the
> current and maximum size of the interface and stores this information in
> the 'hw_ring' structure.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 32 ++++++++++++++++++++++++
>  tools/testing/selftests/bpf/xskxceiver.h |  8 ++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index eaa102c8098b..32005bfb9c9f 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -81,6 +81,8 @@
>  #include <linux/mman.h>
>  #include <linux/netdev.h>
>  #include <linux/bitmap.h>
> +#include <linux/sockios.h>
> +#include <linux/ethtool.h>
>  #include <arpa/inet.h>
>  #include <net/if.h>
>  #include <locale.h>
> @@ -95,6 +97,7 @@
>  #include <sys/socket.h>
>  #include <sys/time.h>
>  #include <sys/types.h>
> +#include <sys/ioctl.h>
>  #include <unistd.h>
>  
>  #include "xsk_xdp_progs.skel.h"
> @@ -409,6 +412,35 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  	}
>  }
>  
> +static int get_hw_ring_size(struct ifobject *ifobj)
> +{
> +	struct ethtool_ringparam ring_param = {0};
> +	struct ifreq ifr = {0};
> +	int sockfd;
> +
> +	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (sockfd < 0)
> +		return errno;
> +
> +	memcpy(ifr.ifr_name, ifobj->ifname, sizeof(ifr.ifr_name));
> +
> +	ring_param.cmd = ETHTOOL_GRINGPARAM;
> +	ifr.ifr_data = (char *)&ring_param;
> +
> +	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
> +		close(sockfd);
> +		return errno;

close(sockfd) can potentially override the errno. Also, return -errno to
match the other cases where errors are < 0.

> +	}
> +
> +	ifobj->ring.default_tx = ring_param.tx_pending;
> +	ifobj->ring.default_rx = ring_param.rx_pending;
> +	ifobj->ring.max_tx = ring_param.tx_max_pending;
> +	ifobj->ring.max_rx = ring_param.rx_max_pending;
> +
> +	close(sockfd);
> +	return 0;
> +}
> +
>  static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  			     struct ifobject *ifobj_rx)
>  {
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 425304e52f35..4f58b70fa781 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -114,6 +114,13 @@ struct pkt_stream {
>  	bool verbatim;
>  };
>  
> +struct hw_ring {
> +	u32 default_tx;
> +	u32 default_rx;
> +	u32 max_tx;
> +	u32 max_rx;
> +};
> +
>  struct ifobject;
>  struct test_spec;
>  typedef int (*validation_func_t)(struct ifobject *ifobj);
> @@ -130,6 +137,7 @@ struct ifobject {
>  	struct xsk_xdp_progs *xdp_progs;
>  	struct bpf_map *xskmap;
>  	struct bpf_program *xdp_prog;
> +	struct hw_ring ring;

Any reason not to store ethtool_ringparam directly here? No need to
introduce new hw_ring.
