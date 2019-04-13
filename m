Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBDDC10F0E
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 00:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8E6218C3
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 00:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Z7l9rPgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDMAAi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:00:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38120 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDMAAi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 20:00:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so13273396qth.5
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=N4GmuTDoe65dFp19tOBH5wQJyKEfRuAjX2PCADY6J+w=;
        b=Z7l9rPgAiizOX7O/6LhCov7LIPMTgkjInObd4PW97Qzir1/sHjKa3vRdg8GsB062wE
         grtjFOBE4iTkS2k35UEAXcHk3ybMcfIzzcYTvShFAHQFct/y+gQpATAXPIRlvwQBBX8i
         6AhOD+yK0rsoabf4dOAzMPQlYxNoqfwav2o1mtQtnyU5zISkzxYzd3bHUw2rgsoqoiQO
         aQL+uTFaWOlndfmVVoqn3d5d/0lE+PbKjZg6izvvgEzWhDwk98p1+nie7wX/ZIDvB26l
         w9f+zDiOHcu7eD8PZnKuOQYOS7MpWkLydnX35e5HGef4VYZrgzC8nImrhnr4riBPPc8l
         4BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=N4GmuTDoe65dFp19tOBH5wQJyKEfRuAjX2PCADY6J+w=;
        b=XH+bqqbRsCZrLmjiuYVUBcamKnaszUZktYRtjV1eXS/n4WD0UIX+WKTfTf4avjLxZ8
         eRIvBhJxNVlfdPPuY35eRluiez1h1//VgjDii3Z+HLfz1Fl8Fa6GXO30y4blo5i4jxTF
         klRhmCB/CcwFJ/Vs8wYQEDruH2ldR+LksoOlA/04kK8L+xR+nESCeTgDDGPxUXcun3AE
         SrQbTk98OC+Umja68Y3k6+DBi5WwmASNhExxf1x8hEJ6S/U6NoR64btsG51O4HeywAhD
         PvUA9JzmNgxRFoCO+T0wZop6yhD+I9SaLDkAmkER5jEFEweahQMAHWOLOv3RBw4WnVIG
         YI5g==
X-Gm-Message-State: APjAAAX+A3bso4AaGmAT/2okbJiLizfatz03fMI5mLYZac+jqSXcNXex
        zSUGPRQRcF9sZwrXc6gADC7+Dg==
X-Google-Smtp-Source: APXvYqyM8PVM1jdiv+gU0dKFx7DstSnNpMtWIxlBhV8XqpJugTSybE1BV2QMkkgYE7HV726BAyj0EQ==
X-Received: by 2002:ac8:3186:: with SMTP id h6mr47704665qte.121.1555113637471;
        Fri, 12 Apr 2019 17:00:37 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n10sm34779873qta.86.2019.04.12.17.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 17:00:37 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:00:33 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 2/2] bpftool: Improve handling of ENOSPC on
 reuseport_array map dumps
Message-ID: <20190412170033.4249f5a7@cakuba.netronome.com>
In-Reply-To: <20190412030322.15494-2-bpoirier@suse.com>
References: <20190411082700.26888-1-bpoirier@suse.com>
        <20190412030322.15494-1-bpoirier@suse.com>
        <20190412030322.15494-2-bpoirier@suse.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 12 Apr 2019 12:03:22 +0900, Benjamin Poirier wrote:
> avoids outputting a series of
> 	value:
> 	No space left on device
> 
> The value itself is not wrong but bpf_fd_reuseport_array_lookup_elem() can
> only return it if the map was created with value_size = 8. There's nothing
> bpftool can do about it. Instead of repeating this error for every key in
> the map, print an explanatory warning and a specialized error.
> 
> example before:
> key: 00 00 00 00
> value:
> No space left on device
> key: 01 00 00 00
> value:
> No space left on device
> key: 02 00 00 00
> value:
> No space left on device
> Found 0 elements
> 
> example after:
> Warning: cannot read values from reuseport_sockarray map with value_size != 8
> key: 00 00 00 00  value: <cannot read>
> key: 01 00 00 00  value: <cannot read>
> key: 02 00 00 00  value: <cannot read>
> Found 0 elements
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  tools/bpf/bpftool/map.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 71840faaeab5..e6d72f777767 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -716,8 +716,12 @@ static int dump_map_elem(int fd, void *key, void *value,
>  	} else {
>  		const char *msg = NULL;
>  
> -		if (errno == ENOENT)
> +		if (lookup_errno == ENOENT) {
>  			msg = "<no entry>";
> +		} else if (lookup_errno == ENOSPC && map_info->type ==
> +			 BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
> +			msg = "<cannot read>";
> +		}

In addition to Quentin's nit please don't use the curly brackets for
single-line statements.

>  		print_entry_error(map_info, key,
>  				  msg ? : strerror(lookup_errno), !!msg);
> @@ -774,6 +778,11 @@ static int do_dump(int argc, char **argv)
>  			}
>  		}
>  
> +	if (info.type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
> +	    info.value_size != 8) {
> +		p_info("Warning: cannot read values from %s map with value_size != 8",
> +		       map_type_name[info.type]);
> +	}

Same here :)

>  	while (true) {
>  		err = bpf_map_get_next_key(fd, prev_key, key);
>  		if (err) {

