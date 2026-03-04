Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472633A2554;
	Wed,  4 Mar 2026 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620471; cv=none; b=tZ6ZR6/tgISiAUuEHJ+UbpfAfEXAwkaFUoOXyhEv41ruPyaT+TL8azDNYYKLy0htk+8bF+viEM2LzNSCZSsSfZpSbriIQ5cRuLir4uEXPgbw25lFAfgthT/kkmoM2BDUqwMKua4KFrmNHMep03Xh3lQCHbHo8k4bi4r7HS5b8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620471; c=relaxed/simple;
	bh=BchV9tgwhQ1C7uqCgKnhewSo8nKCzaaMLBh8ajYJQyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihHcAjf/W19vfJrOSNwJ5aTNbQ3vntYzTvrTjbqCMHf9TGww3I4w35RXPJbeULALIoOBKQesEpS3kPBPK0jGoPxsJ7VkY/HYr6WjIF0wtGLbIxO2pZavys0ODMqljazMcCAe+uEbeMHzVMsPPl2Glql9vcJDvZ1J4mdoCcEfKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neawUVPs; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neawUVPs"
Message-ID: <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772620456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWNia4y10bqjN6HPGAzDBrD60vXyvc5C3ZJR9DKS+jI=;
	b=neawUVPsgfqZ5AyFpvB5bNZpbCBnPVFj99NEZg89NCMBmiszeypNRHUfJm8FCCeqUAUfou
	8Q6W2H2klVufKB0iWUhMmCmbRZMLTCRPbrdXPJnxVC4k+TCWRZHxuePyCWsTeKw9vKue/T
	sy5GuOVmnl6GS5wnUVd80GzJEJ8EU5U=
Date: Wed, 4 Mar 2026 18:33:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
Content-Language: en-US
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 posk@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-3-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260304094429.168521-3-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/3/26 17:44, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
>  tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
> 

Unnecessary to create new files.

Move the adding test to verifier_lwt.c. prog_tests/verifier.c will run
the test.

Thanks,
Leon

> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_misc.c b/tools/testing/selftests/bpf/prog_tests/lwt_misc.c
> new file mode 100644
> index 000000000000..6940fca38512
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_misc.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "lwt_misc.skel.h"
> +
> +void test_lwt_misc(void)
> +{
> +	RUN_TESTS(lwt_misc);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/lwt_misc.c b/tools/testing/selftests/bpf/progs/lwt_misc.c
> new file mode 100644
> index 000000000000..aa638a4f2922
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lwt_misc.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("lwt_xmit")
> +__success __retval(0)
> +int test_missing_dst_call_bpf_lwt_xmit_push_encap(struct __sk_buff *skb)
> +{
> +	struct iphdr iph;
> +
> +	__builtin_memset(&iph, 0, sizeof(struct iphdr));
> +	iph.ihl = 5;
> +	iph.version = 4;
> +
> +	bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &iph, sizeof(struct iphdr));
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

