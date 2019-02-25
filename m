Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD98CC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D0B2087C
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 11:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfBYLRo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:17:44 -0500
Received: from www62.your-server.de ([213.133.104.62]:43514 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfBYLRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 06:17:44 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyEGP-00028H-DT; Mon, 25 Feb 2019 12:17:37 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyEGP-0003UL-7Z; Mon, 25 Feb 2019 12:17:37 +0100
Subject: Re: [PATCH v2 bpf-next 4/4] tools/bpftool: recognize bpf_prog_info
 runtime and runcnt
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20190223174422.663270-1-ast@kernel.org>
 <20190223174422.663270-5-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cf8b7ffc-22f9-a095-7614-2d191ba53522@iogearbox.net>
Date:   Mon, 25 Feb 2019 12:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190223174422.663270-5-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25370/Sun Feb 24 14:23:00 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/23/2019 06:44 PM, Alexei Starovoitov wrote:
> $ bpftool p s
> 1: kprobe  tag a56587d488d216c9  gpl runtime 79786 runcnt 8
> 	loaded_at 2019-02-22T12:22:51-0800  uid 0
> 	xlated 352B  not jited  memlock 4096B
> 
> $ bpftool --json --pretty p s
> [{
>         "id": 1,
>         "type": "kprobe",
>         "tag": "a56587d488d216c9",
>         "gpl_compatible": true,
>         "run_time_ns": 79786,
>         "run_cnt": 8,
>         "loaded_at": 1550866971,
>         "uid": 0,
>         "bytes_xlated": 352,
>         "jited": false,
>         "bytes_memlock": 4096
>     }
> ]
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 4 +++-
>  tools/bpf/bpftool/prog.c                         | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 12bc1e2d4b46..d8b46a8f17e0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -171,7 +171,7 @@ EXAMPLES
>  
>  ::
>  
> -    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl
> +    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl runtime 81632 runcnt 10
>              loaded_at 2017-09-29T20:11:00+0000  uid 0
>              xlated 528B  jited 370B  memlock 4096B  map_ids 10
>  
> @@ -184,6 +184,8 @@ EXAMPLES
>              "type": "xdp",
>              "tag": "005a3d2123620c8b",
>              "gpl_compatible": true,
> +            "run_time_ns": 81632,
> +            "run_cnt": 10,
>              "loaded_at": 1506715860,
>              "uid": 0,
>              "bytes_xlated": 528,
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index db978c8d76a8..cdb6bd424340 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -214,6 +214,10 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
>  		     info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
>  
>  	jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
> +	if (info->runtime) {
> +		jsonw_uint_field(json_wtr, "run_time_ns", info->runtime);
> +		jsonw_uint_field(json_wtr, "run_cnt", info->runcnt);

Didn't Andrii mean to generally name these fields run_time_ns and run_cnt, so also
uapi aside from just changing bpftool output (why keeping these names not the same)?

> +	}
>  
>  	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
>  
> @@ -277,6 +281,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>  	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
>  	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
>  	printf("%s", info->gpl_compatible ? "  gpl" : "");
> +	if (info->runtime)
> +		printf(" runtime %lld runcnt %lld",
> +		       info->runtime, info->runcnt);
>  	printf("\n");
>  
>  	if (info->load_time) {
> 

