Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA983346BE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233604; cv=none; b=Rl+oqpJYyyw02z7yyAoz+YKCd4+KGdLp5wzrBXAt3wO4iAo4EXzfWnvpJacwnIE3dFGsEPciU2L+Yg9Zqt9Yzi035QRDl9FFUJ6z9cIscMregyWj7J1mU/L7G53TgviZ/RDgXkVPeMIbKQ+hxo8ZURfX3G+ARaUpHjlOBm5T2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233604; c=relaxed/simple;
	bh=pR2VM/wyNF4fUcANHV2LHURbgA4sGXgjZT0CoXCSGmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrjK7nnfd67c/YY/GLlWznrAZl5JGZ8kjXEjGM/Vb15qdso/YXDrHL6ueOVFJqp2qWVEZOyq5mK7YBspgBmOF/grhBeTG71YFnIECegPEqLzdDuiqTxJGZbhMdIlPWy/9iDMjTUd+CNtTXnLmlWrLqBtKSe3OWAkq43t2hbffFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OF62RIIi; arc=none smtp.client-ip=91.218.175.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OF62RIIi"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pR2VM/wyNF4fUcANHV2LHURbgA4sGXgjZT0CoXCSGmc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790233596; v=1; x=1790838396;
 b=OF62RIIi99kthlPD+vju2rS+qgMdgAE+H0TZWgH7D5AyQwEbADFnMNMNkB6poX2M1T/Ycycj
 aIe0VlQhm3yIk2h/t0w3JpelHTz3ewQyKyXC4GEnNlvEt496gQiuuV2IQmvP0kxlHxgJxsRRZhs
 8SWKubGsMAzcC6cmWOVRJo+o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8d74c66461d80915;
	Thu, 24 Sep 2026 07:06:36 +0000
X-Mizu-Trace-ID: 8d74c66461d80915
X-Migadu-Flow: FLOW_OUT
Message-ID: <99f01c64-cc16-4ab8-8bb5-c8eaa6cd6e77@linux.dev>
Date: Thu, 24 Sep 2026 15:06:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Verify is_extended with
 multiple freplace links
To: chenyuan_fl@163.com, alexei.starovoitov@gmail.com, ast@kernel.org,
 leon.hwang@linux.dev
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, john.fastabend@gmail.com, song@kernel.org,
 ihor.solodrai@linux.dev, Yuan Chen <chenyuan@kylinos.cn>
References: <20260924023737.1140521-1-chenyuan_fl@163.com>
 <20260924023737.1140521-3-chenyuan_fl@163.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260924023737.1140521-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/9/26 10:37, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Extend tc_bpf2bpf with two freplace links, one on entry_tc and one on
> subprog_tc, and detach the one on the entry: while subprog_tc is still
> extended, updating entry_tc into a prog_array map must keep failing
> with -EBUSY, and succeed again once the last link detaches.  The test
> asserts the rejection instead of running the prog, as the update
> succeeds and the prog loops unbounded on an unfixed kernel.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/tailcalls.c      | 74 +++++++++++++++++++
>  .../bpf/progs/tailcall_freplace_multi.c       | 27 +++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index c5c9d6c359bb..aefb46778307 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -6,6 +6,7 @@
>  #include "tailcall_bpf2bpf_hierarchy2.skel.h"
>  #include "tailcall_bpf2bpf_hierarchy3.skel.h"
>  #include "tailcall_freplace.skel.h"
> +#include "tailcall_freplace_multi.skel.h"
>  #include "tc_bpf2bpf.skel.h"
>  #include "tailcall_fail.skel.h"
>  #include "tailcall_cgrp_storage_owner.skel.h"
> @@ -1655,6 +1656,77 @@ static void test_tailcall_bpf2bpf_freplace(void)
>  	tc_bpf2bpf__destroy(tc_skel);
>  }
>  
> +static void test_tailcall_freplace_multi(void)
> +{
> +	struct tailcall_freplace_multi *freplace_skel = NULL;
> +	struct bpf_link *link_subprog = NULL, *link_entry = NULL;
> +	struct tc_bpf2bpf *tc_skel = NULL;
> +	int tc_prog_fd, map_fd, key = 0, err;


Pls keep the above lines with inverted Christmas tree style.

And, drop '= NULL' for tc_skel, because tc_skel is the first variable to
be initialized.

Thanks,
Leon

> +
> +	tc_skel = tc_bpf2bpf__open_and_load();
> +	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
> +		return;
> [...]

