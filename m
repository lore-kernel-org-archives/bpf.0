Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6709EC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 08:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4F2206A3
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 08:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="P+l10IZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfDXIMu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:12:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDXIMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 04:12:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so23775148wrx.9
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MN5tsUCDhOQbbWXuOyczXN5c7bdLKqBenm7bH3PXVVU=;
        b=P+l10IZLbfcyIwpEI1DBzmdhyJP943S5nmIXrufC0HSbmtGOoE5PiMXU/oDLfTT32b
         i98WCacqP1zFhA5WZjMSqnHKBcHgDbmSvRrArhI9SgXsvpFfwc82kvDGOJjjp1mSnN18
         9CCLE06iVBNF5hR6OFd/ZWPX0VCvqjom1qyZoa0xyKlUf1hrnhtj4+hrX7/W+XqQh2/M
         iIZbKJpe4L75P8ulcfLmg3FLH3D5xUgGINZE/UZUnfRvdvGKXTl2uGCplJMR/UJ8QraV
         iBivlvPd5o2R13/zjyURyvBDvh6YRx4cpxYUtK3gTraVz0mC5bvYYE8qosPgyyVP9XPC
         YYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MN5tsUCDhOQbbWXuOyczXN5c7bdLKqBenm7bH3PXVVU=;
        b=NzpI3Fhr5Wwmdv5T38MV1u0z7L2VzsYkFYWN5Zl9j5LdlOAvoAIB463NXnwtiI48XT
         HQEqpg/82XJO5+t9Gq4Xhj6xx53LcigHtvpmIYOisdrcwNjS1H0/SpBWd9gNMhU41hr1
         Ad55xXZ/cSWGjCMZyjyO68fQ4pHuW0+1sVNFh0PD5pN/hYRq3WCo2DnRwti82Y/L0h/s
         WFQeAKzDxTGCUqaDMgb7uoYFzp2fUYGjBd9lBrMm6HGDB7KQT8iBmVjvS3bY5ZA4gRTP
         Z3DMADL8DJmhJiiSQMj956jF2MSYUMF1fyVIkzp59tDYGd5qlyzIpjDMUtdC+za6aPo2
         xYCw==
X-Gm-Message-State: APjAAAW5Bzv0l1bSGYKlRPuFGsXjxpH0XlJ17tA2JMV+g02HgOEaJXRD
        3JMVtl0EWgX6keAlJDRZSO08hBWFWw4=
X-Google-Smtp-Source: APXvYqyPgy9JbMo21u3Idg58NV9cRWp+KRHXfpq+E2cA1NLBjTipcgHTrEHwABNpoJ6DZgnSmVfgiQ==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr19864000wru.65.1556093568506;
        Wed, 24 Apr 2019 01:12:48 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id r196sm15527191wmf.22.2019.04.24.01.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 01:12:47 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] bpftool: show flow_dissector attachment
 status
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com
References: <20190423232200.101627-1-sdf@google.com>
 <20190423232200.101627-2-sdf@google.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <b0713532-87b8-bbba-ba65-dd8778a5ca59@netronome.com>
Date:   Wed, 24 Apr 2019 09:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423232200.101627-2-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-23 16:22 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> Right now there is no way to query whether BPF flow_dissector program
> is attached to a network namespace or not. In previous commit, I added
> support for querying that info, show it when doing `bpftool net`:
> 
> $ bpftool prog loadall ./bpf_flow.o \
> 	/sys/fs/bpf/flow type flow_dissector \
> 	pinmaps /sys/fs/bpf/flow
> $ bpftool prog
> 3: flow_dissector  name _dissect  tag 8c9e917b513dd5cc  gpl
>          loaded_at 2019-04-23T16:14:48-0700  uid 0
>          xlated 656B  jited 461B  memlock 4096B  map_ids 1,2
>          btf_id 1
> ...
> 
> $ bpftool net -j
> [{"xdp":[],"tc":[],"flow_dissector":[]}]
> 
> $ bpftool prog attach pinned \
> 	/sys/fs/bpf/flow/flow_dissector flow_dissector
> $ bpftool net -j
> [{"xdp":[],"tc":[],"flow_dissector":["id":3]}]
> 
> Doesn't show up in a different net namespace:
> $ ip netns add test
> $ ip netns exec test bpftool net -j
> [{"xdp":[],"tc":[],"flow_dissector":[]}]
> 
> Non-json output:
> $ bpftool net
> xdp:
> 
> tc:
> 
> flow_dissector:
> id 3
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/bpf/bpftool/net.c | 52 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index db0e7de49d49..afe0903201e2 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c

> @@ -48,6 +51,10 @@ struct bpf_filter_t {
>   	int		ifindex;
>   };
>   
> +struct bpf_attach_info {
> +	__u32 flow_dissector_id;
> +};
> +
>   static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
>   {
>   	struct bpf_netdev_t *netinfo = cookie;
> @@ -180,8 +187,43 @@ static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
>   	return 0;
>   }
>   
> +static int query_flow_dissector(struct bpf_attach_info *attach_info)
> +{
> +	__u32 prog_ids[1] = {0};
> +	__u32 prog_cnt = ARRAY_SIZE(prog_ids);
> +	__u32 attach_flags;
> +	int fd;
> +	int err;
> +
> +	fd = open("/proc/self/ns/net", O_RDONLY);
> +	if (fd < 0) {
> +		p_err("can't open /proc/self/ns/net: %d",
> +		      strerror(errno));
> +		return -1;
> +	}
> +	err = bpf_prog_query(fd, BPF_FLOW_DISSECTOR, 0,
> +			     &attach_flags, prog_ids, &prog_cnt);
> +	close(fd);
> +	if (err) {
> +		if (errno == EINVAL) {
> +			/* Older kernel's don't support querying
> +			 * flow dissector programs.
> +			 */
> +			return 0;

Hi Stanislav,

If we handle the "error" gracefully here, should we maybe reset errno to 
0 before returning? Batch mode, for example, stops processing commands 
when it sees that errno is set, but we probably want it to continue in 
the current case (commit 39c9f10639a3 addressed something similar for 
"bpftool cgroup tree").

> +		}
> +		p_err("can't query prog: %s", strerror(errno));
> +		return -1;
> +	}
> +
> +	if (prog_cnt == 1)
> +		attach_info->flow_dissector_id = prog_ids[0];
> +
> +	return 0;
> +}
> +
>   static int do_show(int argc, char **argv)
>   {
> +	struct bpf_attach_info attach_info = {};
>   	int i, sock, ret, filter_idx = -1;
>   	struct bpf_netdev_t dev_array;
>   	unsigned int nl_pid;
