Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE0CC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883752073F
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VoZr6uq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDKUb4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:31:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41978 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKUb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 16:31:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so8725218qta.8
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=zpR5pd8XijAC7wJ9vo+/MydLMlWvbfEE7VuBf9yHYA8=;
        b=VoZr6uq5tIKVmYrx4zQP6kWzfcLXwUi+dLAzobyu+/EAUGUzMpWu/XWigLgBmD+YxQ
         EMO0SFzVOOXSKwnzjTzsLOmipYwJwEq3y+91IyowqDljTWpAGeqZSzLo/suePog7ZTYM
         7kujfaFgXwarQn+zmUB2wuIS+8vXuiMWmxA3riK2QdGCrjb2ZJPijvNmS8N4oQoyEanZ
         FGofw42A9CYtYwIs6MGWJo4WzOZb8VTcTKwX+iyjGgrioy++esgS0mkYdfQK+iYvf/VT
         /aFDCnV4dodLFpgTM++x2GN0VuniKKxcxG/45ZJKIN838/YQHJaY+2em6+Y5Kql4X2TA
         aetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zpR5pd8XijAC7wJ9vo+/MydLMlWvbfEE7VuBf9yHYA8=;
        b=QMPlR7+PMSyFeftFOJDMmV/B5JFxlg6Z/gqOPrBuPOQlYraHkVdJx9EBZcf4uDRBW8
         PuGKgyQCl+KUwDGL59/48RhaNBNHQ/nfQKhVMHtFYxnd1gF43CiXIBWByLl0A0YQ+dJO
         aa0UZa+oIUel1EGkwUAsXgE1nx0jxpiOBPASGPza8hydAKDoptPMznn+UG5aoz9ZEYAk
         WhHLS1/s2lvBnsxbEWGj1c1NkD/KNXlTqfD66omSSHpCBZaDS6B29bnvSElUTheHrAco
         WEbh5WY5Sds/a/iFN4IghKOoUfMeFhPxK6WHzht4RyK6d+TOe0U2MXSH/UYEnW4a8/+p
         1IIQ==
X-Gm-Message-State: APjAAAUCpQWKxI7e7oHgLPLrRX3U2Ef6HsKVkYWkV50+vhm3m+KhfvPa
        cHBOKGwlRhiny5w86c+uKjvbzVn3sMY=
X-Google-Smtp-Source: APXvYqz6xrrBElKaVryy0GfHV7R1N8yBsg7IdQl0cx6gUZn3nLXUk9tnqA/hH17bpYmr7pcke5lM7Q==
X-Received: by 2002:a0c:ba2f:: with SMTP id w47mr41906812qvf.72.1555014715246;
        Thu, 11 Apr 2019 13:31:55 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x28sm27233749qtx.71.2019.04.11.13.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 13:31:55 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:31:51 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpftool: Exit early when it's not possible to
 dump a REUSEPORT_SOCKARRAY map
Message-ID: <20190411133151.260e0556@cakuba.netronome.com>
In-Reply-To: <20190411082700.26888-1-bpoirier@suse.com>
References: <20190411082700.26888-1-bpoirier@suse.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Apr 2019 17:27:00 +0900, Benjamin Poirier wrote:
> avoids outputting a series of
> 	value:
> 	No space left on device
> 
> The value itself is not wrong but bpf_fd_reuseport_array_lookup_elem() can
> only return it if the map was created with value_size = 8. There's nothing
> bpftool can do about it. Instead of repeating this error for every key in
> the map, print the error once, print an explanatory message and exit.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

> @@ -787,7 +787,16 @@ static int do_dump(int argc, char **argv)
>  				err = 0;
>  			break;
>  		}
> -		num_elems += dump_map_elem(fd, key, value, &info, btf, btf_wtr);
> +		err = dump_map_elem(fd, key, value, &info, btf, btf_wtr);
> +		/* bpf_fd_reuseport_array_lookup_elem() can only return a
> +		 * value if the map's value_size == 8
> +		 */
> +		if (info.type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
> +		    info.value_size != 8 && err == -ENOSPC) {
> +			p_err("cannot dump REUSEPORT_SOCKARRAY map with value_size != 8");
> +			goto exit_free;

Hmm... could it still be useful to walk the map to see the keys, even
if the kernel can't return meaningful values?

> +		}
> +		num_elems += err;
>  		prev_key = key;
>  	}
>  

