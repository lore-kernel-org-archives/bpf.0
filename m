Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44E386552
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941551; cv=none; b=LPPi5ZJWudqxJTmNSB7kq1+l5TVJZUKXcmaicnlwOCZULHSNKatD4Pb4QGem8bqgDQZax9a2GX/zfpVguDkR+6O72LdcIfUpqqXKB7/6xUolDkLgNy2kOb6Obk7XercJhQOs/PayAj9HCy0HpqCED5UQ8CB4PZpP2Fzx6T8kq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941551; c=relaxed/simple;
	bh=wq1Cu8bZXdxkc1IEjaOXG3kJSBniOcazTJJjusnkaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz7XIGixFnK4vZl4YNWr72PiZkWpj0WAQYfWfcCMX7EUJBUm7fuaZx9+Vy8uU07WxIkj9hfojp/brlKqIdsjAQTVvpp1vfdufei1oe2SQtT5ss3S+DwHQwB5BmiCM5RH+wJKAiIyzDOnQWfubzfkaUIzykMwc6Cd/SS7bM8sIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKZK9V5H; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKZK9V5H"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so3778508a91.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776941549; x=1777546349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeNLLevQh3pBYAO6lXAZTdw0TrOMFI6h3YnGdTBUiYQ=;
        b=VKZK9V5Huo+WB4bmsS98C4hhHBTVcwFG6ZDszYozrLtqKuVfduLVPRd9ofWjILbXMr
         5U2PlE6wfxBwoAQaSEU/X2gXrYS9/sX+QzSD4F9vUBfyjrJl81Bg8OslOWBTGsgWT06X
         VOUK0MHzf7qmyAxGtVO4ybuuG30h2hwy5NdRh5mp8sGSCSkfeOABoEp4mubaQZSCCjJk
         GJYUNgs0ALTH3stfrB7iN6JRMjw6jRzkHiTHKits2ObZaM95KzukWxDzjvSA9ZDmjmMF
         wLAKlsVKb1QtUfsGgsalRjgGzW3ZMWPtGeTibqoFNsTz2Upl/WWsLTjLJ4FHXaQ/DSGn
         VgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941549; x=1777546349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeNLLevQh3pBYAO6lXAZTdw0TrOMFI6h3YnGdTBUiYQ=;
        b=mQZaWJepOsjHk1ljZxLl195fE1vt2x/tjqAcSLNR5lPlnzjM7j6NDeKGvTK1j/TD38
         a9uB6Q6NCm6ASNHD6Z/5asJzGHW3PIWx89lIQz2vdGKewGieZsZFGCs/9v0XxMs8nS/h
         mFRLTGCNT/G/6jNCJyaqoLHi68HJiOU6Z0w9djZBVfWLUi2cZ08xmnqS/dkLFP5WEssm
         TAmRa4uHznmYA7Y6H1B2un4hbc9BT8T8i9HMZyXtfKBIdHGzfKHIq/iCGSwIi6eg1uuO
         aAKHUAZZw3iEB/TfPt6GWSF6FVtBkyPvFqg5mS76R5QUiYakKSg0K4OH+g82wxSmTx7o
         tTjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BvdYEF4RbYtHYjitooTV5o9ZrFg1jQ18qOqV1NqDLQomK5dz4wJl4y+Ru5t3UnCINJk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHhH3yYTCfKGSFJgr0HT7CQpESUxjqLoSSIs4hkgodTyfJWTi
	3uPvAlr+Z84dBhL8zQCB9kySA3QdervZjQGDSlhhi8PCy//L4pPfN2I4
X-Gm-Gg: AeBDievyFEVc3Q5ZlS0Z88wWlCTrz/VyxH7Aw0Os3wFnWley0E7xGgcQvwV1xSvqRdY
	uxDTwYVsAZy8TNf+LucSG4/Sf3IpQOtAZinI7WPdfXNYpOh/YhKME8g85+bvkhklYb440wllP3F
	HOBwNLdL9jU0ibzyv445nuLUTTgyF1lfWq+3L1ChL4gB4+wntsYD8AIF4zGyGdMx+Kj+tjnpEB3
	ZrvorS5VDbKcGg7rKb5KxO4lXjY+J91bn3yU94Osoi6d6ITVGIV6FRztM73woS2GeVlHLJeJdFI
	ia7AGbaT8yu+of+/cCsNPeCGt8IfdVLjOv4IjaC0e7enAyNCy3sfNIhes8TCYVQgdSITCqzcOlf
	rtJWV/kdRiozkscVISVaJjPw1kU0GT37LXYJ8XvziW+2NtqE/WgiLTgtmzYDR/Z060lqJyMi4hc
	er/SI60+n1bUX/DrVUaFZkDYko+dPU/3A0BV1phioNRqjby76f92wMv8r6RjT0bqbWbDqdPXSYo
	dgNtETnkLwe8Kvx
X-Received: by 2002:a17:90b:5544:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-361403dfee7mr25650866a91.7.1776941549066;
        Thu, 23 Apr 2026 03:52:29 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614189343esm19666810a91.6.2026.04.23.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:52:28 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:52:24 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] selftests/sched_ext: Include common.bpf.h to avoid build
 failure
Message-ID: <20260423184955.G2144@cchengyang.duckdns.org>
References: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>

Hi Zhao,

On Thu, Apr 23, 2026 at 06:42:35PM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> In scx-cid patchsets, sched_ext selftest failed to build with following
> error:
> 
> non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
> 17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> |      ^
> tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> |             ^
> non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
> 26 |         scx_bpf_kick_cpu(0, 0);
> |         ~~~~~~~~~~~~~~~~     ^
> tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> 
> The root cause is on scx core part, but we can avoid this by including
> common.bpf.h and remove scx_bpf_kick_cpu() to make it more robust, just
> like the usage in other xx.bpf.c.
> 
> Link: https://lore.kernel.org/sched-ext/20260421071945.3110084-1-tj@kernel.org/
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Tested-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Thanks for the fix, LGTM!

> ---
>  tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> index 9f16d39255e7..0d6fcc8e5eb6 100644
> --- a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> +++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> @@ -9,12 +9,7 @@
>   * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
>   */
>  
> -#include <vmlinux.h>
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
> -
> -/* SCX kfunc from scx_kfunc_ids_any set */
> -void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> +#include <scx/common.bpf.h>
>  
>  SEC("struct_ops/ssthresh")
>  __u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)
> 
> ---
> base-commit: eff158514a85c1b81966667a880dd8bcd29bbbd1
> change-id: 20260423-b4-selftest-fix-d87cdda6185e
> 
> Best regards,
> --  
> Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 

-- 
Cheers,
Cheng-Yang
