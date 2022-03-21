Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050C3C4332F
	for <bpf@archiver.kernel.org>; Mon, 21 Mar 2022 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiCUOeN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349965AbiCUOdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 10:33:19 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCB5F5F
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 07:31:52 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nWJ4X-0009mK-O1; Mon, 21 Mar 2022 15:31:49 +0100
Received: from [2a02:168:f656:0:d16a:7287:ccf0:4fff] (helo=localhost.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nWJ4X-0008tr-H0; Mon, 21 Mar 2022 15:31:49 +0100
Subject: Re: [PATCH bpf-next] bpftool: fix a bug in subskeleton code
 generation
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Delyan Kratunov <delyank@fb.com>
References: <20220320032009.3106133-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f469d022-7b3c-2181-0fea-6cf877f7c014@iogearbox.net>
Date:   Mon, 21 Mar 2022 15:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220320032009.3106133-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26488/Mon Mar 21 09:28:19 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/20/22 4:20 AM, Yonghong Song wrote:
> Compiled with clang by adding LLVM=1 both kernel and selftests/bpf
> build, I hit the following compilation error:
> 
> In file included from /.../tools/testing/selftests/bpf/prog_tests/subskeleton.c:6:
>    ./test_subskeleton_lib.subskel.h:168:6: error: variable 'err' is used uninitialized whenever
>        'if' condition is true [-Werror,-Wsometimes-uninitialized]
>            if (!s->progs)
>                ^~~~~~~~~
>    ./test_subskeleton_lib.subskel.h:181:11: note: uninitialized use occurs here
>            errno = -err;
>                     ^~~
>    ./test_subskeleton_lib.subskel.h:168:2: note: remove the 'if' if its condition is always false
>            if (!s->progs)
>            ^~~~~~~~~~~~~~
> 
> The compilation error is triggered by the following code
>          ...
>          int err;
> 
>          obj = (struct test_subskeleton_lib *)calloc(1, sizeof(*obj));
>          if (!obj) {
>                  errno = ENOMEM;
>                  goto err;
>          }
>          ...
> 
>    err:
>          test_subskeleton_lib__destroy(obj);
>          errno = -err;
>          ...
> in test_subskeleton_lib__open(). The 'err' is not initialized, yet it
> is used in 'errno = -err' later.
> 
> The fix is to remove 'errno = -err' since errno has been set properly
> in all incoming branches.

If we remove this one here in which locations is it missing then? Do these then
need an extra errno = -err statement before they goto err?

> Cc: Delyan Kratunov <delyank@fb.com>
> Fixes: 00389c58ffe9 ("00389c58ffe993782a8ba4bb5a34a102b1f6fe24")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   tools/bpf/bpftool/gen.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 96bd2b33ccf6..7ba7ff55d2ea 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1538,7 +1538,6 @@ static int do_subskeleton(int argc, char **argv)
>   			return obj;					    \n\
>   		err:							    \n\
>   			%1$s__destroy(obj);				    \n\
> -			errno = -err;					    \n\
>   			return NULL;					    \n\
>   		}							    \n\
>   									    \n\
> 

