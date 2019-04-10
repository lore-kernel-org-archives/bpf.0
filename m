Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75424C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 07:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408EF206B7
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 07:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDJH6J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:58:09 -0400
Received: from www62.your-server.de ([213.133.104.62]:46064 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfDJH6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 03:58:08 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hE87T-00057e-7F; Wed, 10 Apr 2019 09:58:07 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hE87S-000JPd-UK; Wed, 10 Apr 2019 09:58:07 +0200
Subject: Re: [PATCH bpf-next] [tools/bpf] fix a few ubsan warning
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@fb.com>, kernel-team@fb.com
References: <20190410003741.1855113-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <48f2792a-e0fa-305e-ff5f-cfe45dbfe82d@iogearbox.net>
Date:   Wed, 10 Apr 2019 09:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190410003741.1855113-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/10/2019 02:37 AM, Yonghong Song wrote:
> The issue is reported at https://github.com/libbpf/libbpf/issues/28.
> 
> Basically, per C standard, for
>   void *memcpy(void *dest, const void *src, size_t n)
> if "dest" or "src" is NULL, regardless of whether "n" is 0 or not,
> the result of memcpy is undefined. clang ubsan reported three such
> instances in bpf.c with the following pattern:
>   memcpy(dest, 0, 0).
> 
> Although in practice, no known compiler will cause issues when
> copy size is 0. Let us still fix the issue to silence ubsan
> warnings.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied, thanks. I fixed up $SUBJECT while applying to add a subsystem prefix.

> ---
>  tools/lib/bpf/bpf.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index a1db869a6fda..78f2400dd2d1 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -79,7 +79,6 @@ static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
>  
>  int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
>  {
> -	__u32 name_len = create_attr->name ? strlen(create_attr->name) : 0;
>  	union bpf_attr attr;
>  
>  	memset(&attr, '\0', sizeof(attr));
> @@ -89,8 +88,9 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
>  	attr.value_size = create_attr->value_size;
>  	attr.max_entries = create_attr->max_entries;
>  	attr.map_flags = create_attr->map_flags;
> -	memcpy(attr.map_name, create_attr->name,
> -	       min(name_len, BPF_OBJ_NAME_LEN - 1));
> +	if (create_attr->name)
> +		memcpy(attr.map_name, create_attr->name,
> +		       min(strlen(create_attr->name), BPF_OBJ_NAME_LEN - 1));

Any reason we don't simplify this to use strncpy() for all these occurrences?

Thanks,
Daniel
