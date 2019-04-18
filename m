Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C48C10F0E
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AA820869
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 20:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ6xJhbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfDRU7a (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:59:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35168 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbfDRU7a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 16:59:30 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so2165599ioh.2;
        Thu, 18 Apr 2019 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjCggV5L3KJjtWbzg45D+WGZDlYsAT7a8dpd4QOv72Q=;
        b=RZ6xJhbW0O/IFXEmGAc6gbKkRjDgAs6yP++TAwxaEquoWZsR/UUS8lzHttaW6rZ6+i
         OfMU22/tKO6dfGjzVhcChKugTj+pVPtsDAWd3XHh3XkL+ZpGndO8JZZ2rt8yS7PSXI40
         rXfKKofXvOr551mNeH91WC/P8s2OwluMGRZ+CZupwn6zuk1TKzzSeoqBun0pqaQuUW1N
         b+nYRbr6g5Frz0rK1OD0Rxn/WwKlyIS9VMveNnHdS2AZq51HgwoWoohk6moGp+nnQZlW
         RTda4Qm8HCw1CogtBjmB/ObdEK/d0iUKtPynntdu23ORKnwiVfbZpcgOR7HTcpN9uzIN
         0ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjCggV5L3KJjtWbzg45D+WGZDlYsAT7a8dpd4QOv72Q=;
        b=Vx6fOkDiXM46DHrQzz67iRW6q3oagZWU+k9f57o9tAxKLwaaZyG5R6YD5jfgpw92KV
         weMZ0v4hFDRSmNHE37Lci1UDn1CCdIf8OrTxjtJ+jQ/uOq1w4xYLvwwJGzh7AO1BNuTT
         J2ajtutYbX6OwtlQPLrkrM1FQ9nm+WUR03jI8bKsYzPtG8WwwoITd9RZn5WZgis4Tyi+
         6u9mTNsNGQ+H7497ZdILR2sYa3+X4f4Nhtkwh0u1lAIrjpaPpyfHtZLXj18PxkLBaZLu
         c4Iba542dKOzEO94pCNe0bvywfWCMsxIKFAyAv85swYDv3QXj/kENwg80+hVq+se8w7g
         ZxGQ==
X-Gm-Message-State: APjAAAXgvIL8bZCq4OGTN7yXhw36ypsPVwhP6Pul19tOzIkn/74L9MkJ
        AN7+HLV/OJBYYocT28YvTz0MWMTMpT/ieCw3q3I=
X-Google-Smtp-Source: APXvYqwftLVT0LzMezxYvXEiCXZQAd1lxlJi+DVXRlU/2GTs8PXizP64YDBOKuwT0TgotxG9Q6aFn7t1xJDGvye8Z7Y=
X-Received: by 2002:a6b:db19:: with SMTP id t25mr243220ioc.140.1555621169021;
 Thu, 18 Apr 2019 13:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <1555572070-30796-1-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1555572070-30796-1-git-send-email-magnus.karlsson@intel.com>
From:   Y Song <ys114321@gmail.com>
Date:   Thu, 18 Apr 2019 13:58:52 -0700
Message-ID: <CAH3MdRUgxSqvUdxdnx=ZTodNPXaPHP-4gaKicVQNMavePSeWqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: remove compile time warning from libbpf_util.h
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 12:23 AM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> Having a helpful compile time warning in libbpf_util.h is not a good
> idea since all warnings are treated as errors. Change this into a
> comment in the code instead.
>
> Fixes: b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Yonghong Song <yhs@fb.com>


> ---
>  tools/lib/bpf/libbpf_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> index 172b707e..da94c4c 100644
> --- a/tools/lib/bpf/libbpf_util.h
> +++ b/tools/lib/bpf/libbpf_util.h
> @@ -46,7 +46,7 @@ do {                          \
>  # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
>  # define libbpf_smp_rwmb() libbpf_smp_mb()
>  #else
> -# warning Architecture missing native barrier functions in libbpf_util.h.
> +/* Architecture missing native barrier functions. */
>  # define libbpf_smp_rmb() __sync_synchronize()
>  # define libbpf_smp_wmb() __sync_synchronize()
>  # define libbpf_smp_mb() __sync_synchronize()
> --
> 2.7.4
>
