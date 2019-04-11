Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE43C282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD6321904
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Pkh91gcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDKLUH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:20:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39485 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKLUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 07:20:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so6827683wrn.6
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijgbhRucMxZTJRjq92yZSHzAVXXbU0/XRWoL+h4hS/w=;
        b=Pkh91gcQ8TNIRyRL0NG2IwaMt6bF8OEyMhaRHVc8Py1FMDn90XB9iuVyGHSkMreRfa
         RBIUcfTHN9E1DzW7hSginWZmQIbGoUaqxVL/jzw0qpRzKe6QJncxtmlgqLeppqXqFQyl
         U4Rr8+VRnuBmJSYAjWNrPmMsEXQO54TbJZ1s+LixAyDlTnw+ePUcjJugb62gmg+AeYGy
         RffB9ceZ2ykG3U3zN+q4qlb32BdHwaODD1y47x22pkB7cZy6dgyb8QV3FRqUjuQLXRrs
         Dl621puAznDpbPW4xfz1DTU/GR045IZ7Q9T4/AoOzfWytGIofC7QH8IEgHSq0jCQIYS0
         Za4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ijgbhRucMxZTJRjq92yZSHzAVXXbU0/XRWoL+h4hS/w=;
        b=AvBVuFTRClEzxF0jjuAyUgb60c5bcR2PhLTwqXcdYLqcU04uXSCVuh7pH89LpZZZ6H
         AJlAHQ+/+FmF96dwhc+gJ3Zi8dXJ8rh7eH90BE7dSEB+olfSv25Usm+NCzlYwdK2Z4OS
         jdzoZ9YKBLOgLmYXmyUxhgKdyKB2JbnuTXr4LzU7MqNddnJ/atckNDW9DvC3nZvlXLYW
         cPz7B2y51ycU5rltJSz3zMMkdGIzNDX6I4ObOoLj66yBivuCQHCn/4tpJfK4OmWfo84t
         qCdE0Ku3ukeC0t4+ajZ2Eo4NBit0Fjmh0OJ0meNXsU8/DFRcwD5eVXzLg1S6lj55oVCa
         I+QA==
X-Gm-Message-State: APjAAAVcRYg8gnKv+/war09jANv1stBSpbGpQQrZ1E4w1EeeOzTk2xwa
        nV1lnNnP5OzBbWleF080Md1bwLtJSpo=
X-Google-Smtp-Source: APXvYqyY7FjfdtTSh0a5GmEyu6YdevBy9edDJQOBMABop1wZn4XjSTdNrxtKV3VQ4V5j6YlIK3++Fg==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr10197816wrv.282.1554981604527;
        Thu, 11 Apr 2019 04:20:04 -0700 (PDT)
Received: from [172.20.1.104] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id u17sm8226656wmu.36.2019.04.11.04.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:20:03 -0700 (PDT)
To:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20190411082700.26888-1-bpoirier@suse.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 mQINBFnqRlsBEADfkCdH/bkkfjbglpUeGssNbYr/TD4aopXiDZ0dL2EwafFImsGOWmCIIva2
 MofTQHQ0tFbwY3Ir74exzU9X0aUqrtHirQHLkKeMwExgDxJYysYsZGfM5WfW7j8X4aVwYtfs
 AVRXxAOy6/bw1Mccq8ZMTYKhdCgS3BfC7qK+VYC4bhM2AOWxSQWlH5WKQaRbqGOVLyq8Jlxk
 2FGLThUsPRlXKz4nl+GabKCX6x3rioSuNoHoWdoPDKsRgYGbP9LKRRQy3ZeJha4x+apy8rAM
 jcGHppIrciyfH38+LdV1FVi6sCx8sRKX++ypQc3fa6O7d7mKLr6uy16xS9U7zauLu1FYLy2U
 N/F1c4F+bOlPMndxEzNc/XqMOM9JZu1XLluqbi2C6JWGy0IYfoyirddKpwzEtKIwiDBI08JJ
 Cv4jtTWKeX8pjTmstay0yWbe0sTINPh+iDw+ybMwgXhr4A/jZ1wcKmPCFOpb7U3JYC+ysD6m
 6+O/eOs21wVag/LnnMuOKHZa2oNsi6Zl0Cs6C7Vve87jtj+3xgeZ8NLvYyWrQhIHRu1tUeuf
 T8qdexDphTguMGJbA8iOrncHXjpxWhMWykIyN4TYrNwnyhqP9UgqRPLwJt5qB1FVfjfAlaPV
 sfsxuOEwvuIt19B/3pAP0nbevNymR3QpMPRl4m3zXCy+KPaSSQARAQABtC1RdWVudGluIE1v
 bm5ldCA8cXVlbnRpbi5tb25uZXRAbmV0cm9ub21lLmNvbT6JAj0EEwEIACcFAlnqRlsCGyMF
 CQlmAYAFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQNvcEyYwwfB7tChAAqFWG30+DG3Sx
 B7lfPaqs47oW98s5tTMprA+0QMqUX2lzHX7xWb5v8qCpuujdiII6RU0ZhwNKh/SMJ7rbYlxK
 qCOw54kMI+IU7UtWCej+Ps3LKyG54L5HkBpbdM8BLJJXZvnMqfNWx9tMISHkd/LwogvCMZrP
 TAFkPf286tZCIz0EtGY/v6YANpEXXrCzboWEiIccXRmbgBF4VK/frSveuS7OHKCu66VVbK7h
 kyTgBsbfyQi7R0Z6w6sgy+boe7E71DmCnBn57py5OocViHEXRgO/SR7uUK3lZZ5zy3+rWpX5
 nCCo0C1qZFxp65TWU6s8Xt0Jq+Fs7Kg/drI7b5/Z+TqJiZVrTfwTflqPRmiuJ8lPd+dvuflY
 JH0ftAWmN3sT7cTYH54+HBIo1vm5UDvKWatTNBmkwPh6d3cZGALZvwL6lo0KQHXZhCVdljdQ
 rwWdE25aCQkhKyaCFFuxr3moFR0KKLQxNykrVTJIRuBS8sCyxvWcZYB8tA5gQ/DqNKBdDrT8
 F9z2QvNE5LGhWDGddEU4nynm2bZXHYVs2uZfbdZpSY31cwVS/Arz13Dq+McMdeqC9J2wVcyL
 DJPLwAg18Dr5bwA8SXgILp0QcYWtdTVPl+0s82h+ckfYPOmkOLMgRmkbtqPhAD95vRD7wMnm
 ilTVmCi6+ND98YblbzL64YG5Ag0EWepGWwEQAM45/7CeXSDAnk5UMXPVqIxF8yCRzVe+UE0R
 QQsdNwBIVdpXvLxkVwmeu1I4aVvNt3Hp2eiZJjVndIzKtVEoyi5nMvgwMVs8ZKCgWuwYwBzU
 Vs9eKABnT0WilzH3gA5t9LuumekaZS7z8IfeBlZkGXEiaugnSAESkytBvHRRlQ8b1qnXha3g
 XtxyEqobKO2+dI0hq0CyUnGXT40Pe2woVPm50qD4HYZKzF5ltkl/PgRNHo4gfGq9D7dW2OlL
 5I9qp+zNYj1G1e/ytPWuFzYJVT30MvaKwaNdurBiLc9VlWXbp53R95elThbrhEfUqWbAZH7b
 ALWfAotD07AN1msGFCES7Zes2AfAHESI8UhVPfJcwLPlz/Rz7/K6zj5U6WvH6aj4OddQFvN/
 icvzlXna5HljDZ+kRkVtn+9zrTMEmgay8SDtWliyR8i7fvnHTLny5tRnE5lMNPRxO7wBwIWX
 TVCoBnnI62tnFdTDnZ6C3rOxVF6FxUJUAcn+cImb7Vs7M5uv8GufnXNUlsvsNS6kFTO8eOjh
 4fe5IYLzvX9uHeYkkjCNVeUH5NUsk4NGOhAeCS6gkLRA/3u507UqCPFvVXJYLSjifnr92irt
 0hXm89Ms5fyYeXppnO3l+UMKLkFUTu6T1BrDbZSiHXQoqrvU9b1mWF0CBM6aAYFGeDdIVe4x
 ABEBAAGJAiUEGAEIAA8FAlnqRlsCGwwFCQlmAYAACgkQNvcEyYwwfB4QwhAAqBTOgI9k8MoM
 gVA9SZj92vYet9gWOVa2Inj/HEjz37tztnywYVKRCRfCTG5VNRv1LOiCP1kIl/+crVHm8g78
 iYc5GgBKj9O9RvDm43NTDrH2uzz3n66SRJhXOHgcvaNE5ViOMABU+/pzlg34L/m4LA8SfwUG
 ducP39DPbF4J0OqpDmmAWNYyHh/aWf/hRBFkyM2VuizN9cOS641jrhTO/HlfTlYjIb4Ccu9Y
 S24xLj3kkhbFVnOUZh8celJ31T9GwCK69DXNwlDZdri4Bh0N8DtRfrhkHj9JRBAun5mdwF4m
 yLTMSs4Jwa7MaIwwb1h3d75Ws7oAmv7y0+RgZXbAk2XN32VM7emkKoPgOx6Q5o8giPRX8mpc
 PiYojrO4B4vaeKAmsmVer/Sb5y9EoD7+D7WygJu2bDrqOm7U7vOQybzZPBLqXYxl/F5vOobC
 5rQZgudR5bI8uQM0DpYb+Pwk3bMEUZQ4t497aq2vyMLRi483eqT0eG1QBE4O8dFNYdK5XUIz
 oHhplrRgXwPBSOkMMlLKu+FJsmYVFeLAJ81sfmFuTTliRb3Fl2Q27cEr7kNKlsz/t6vLSEN2
 j8x+tWD8x53SEOSn94g2AyJA9Txh2xBhWGuZ9CpBuXjtPrnRSd8xdrw36AL53goTt/NiLHUd
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: Re: [PATCH bpf-next] bpftool: Exit early when it's not possible to
 dump a REUSEPORT_SOCKARRAY map
Message-ID: <240116cf-0e74-e9fb-5100-00965c578e72@netronome.com>
Date:   Thu, 11 Apr 2019 12:20:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411082700.26888-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-11 17:27 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
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
> ---
> 
> Note that this will lead to a merge conflict if the patch "bpftool: Fix
> errno variable usage" is merged in the bpf branch:
> 
> <<<<<<< HEAD
>                 if (lookup_errno == ENOENT)
> =======
>                 if (errno == ENOENT) {
>>>>>>>> bpf-next
> 
> The resolution should be trivial:
>                 if (lookup_errno == ENOENT) {
> 
>  tools/bpf/bpftool/map.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e96903078991..bb648e42923c 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -684,7 +684,6 @@ static int dump_map_elem(int fd, void *key, void *value,
>  			 struct bpf_map_info *map_info, struct btf *btf,
>  			 json_writer_t *btf_wtr)
>  {
> -	int num_elems = 0;
>  	int lookup_errno;
>  
>  	if (!bpf_map_lookup_elem(fd, key, value)) {
> @@ -702,9 +701,8 @@ static int dump_map_elem(int fd, void *key, void *value,
>  			} else {
>  				print_entry_plain(map_info, key, value);
>  			}
> -			num_elems++;
>  		}
> -		return num_elems;
> +		return 1;
>  	}
>  
>  	/* lookup error handling */
> @@ -722,11 +720,13 @@ static int dump_map_elem(int fd, void *key, void *value,
>  		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
>  		jsonw_end_object(json_wtr);
>  	} else {
> -		if (errno == ENOENT)
> +		if (errno == ENOENT) {
>  			print_entry_plain(map_info, key, NULL);
> -		else
> +		} else {
>  			print_entry_error(map_info, key,
>  					  strerror(lookup_errno));
> +			return -lookup_errno;

Hi, thanks! One comment: if we return -lookup_errno here...

> +		}
>  	}
>  
>  	return 0;
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
> +		}
> +		num_elems += err;

... I think we can have a negative err value here (if we're not in the
case of reuseport_sockarray with wrong map size)? In that case, the
function could print something like "Found -1 elements"?

So maybe update num_elems only if err is positive? Although I'd like
even better if we could somehow find a way to move this error handling
along with the rest of it in dump_map_elem(), and avoid making that
function return either a number of elements or an error depending on the
result from the lookup.

Best regards,
Quentin
