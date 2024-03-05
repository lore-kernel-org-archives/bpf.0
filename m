Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3E535C7
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632315; cv=none; b=ebonzbdKjQYQfXBtCEiyznVHlXlxYt+FN2vni1MjIzKs+SaC67aw3ujNZMLKJw7spkxYL9siWm1cdl9rv+LWfllbokiUq+f05nzMAir2ZdzJ3cjWAfHaxxT6aAGFKUGmtBpEVe+H9JR/2FWLhU1s2fLcppVAqlvDaCejN19uGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632315; c=relaxed/simple;
	bh=zuUynSQVFO9P21F/X99jANAMr9IKvzGBCpv/lIWuje8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KxQeEx/ERlK51o7cE7D7UHpxs5LnEZemsPT4Wox3pGtfYnFTuY9H7kHLlujSP/LmRZnt84d/nOFl2p8fBZxCsTDIXbrdcw0Mq5hh0CwNIjB8qbuI0Vf6KJMGo8e+CJVlqVUDTp42RM+HsNMo7VlmuDgN0FU5nkyfabC2gpV0+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ejzNpwzM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ejzNpwzM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/7vUL0qjp3IXpGEGAsTCaauvXdH6xZKvC3aMd0AkdJc=; b=ejzNpwzMXePFxvO9SKuT8keios
	X6JcquYUgCwKTCjgeMyAuAFeS528nXQyqVF9/ck2BsTn0lxihoXyNdcZ8YQHIIWij39H49hRoNbsr
	Li0AjFBGHJBdC9Iv8WVKJDdz4qQP8Nb/3v3eFM654VCH3//Y3rp63zHLNuesrBCvgm/3mwUZ56LwB
	DQmWDp6MuWlc0KClUfwrHKHn5C75Ka3yOPY9T2kK2mhDjNR3ggDw0dwJFYSJMsyuyfjF4bQI2HQD2
	mdCRAFI47fup23ZKjZ9O9r+bbGdIcrqL/hHjMU/SXHHxN0x75L39GW1zU/kYI6PLxTLU3CKi0n8xh
	yDC4WWhA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rhRSg-000Kle-HH; Tue, 05 Mar 2024 10:51:50 +0100
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rhRSg-0001VM-01;
	Tue, 05 Mar 2024 10:51:50 +0100
Subject: Re: [PATCH bpf-next v3 07/15] selftests/bpf: test autocreate behavior
 for struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
References: <20240304225156.24765-1-eddyz87@gmail.com>
 <20240304225156.24765-8-eddyz87@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6c4a8146-d152-028f-f2c6-0ace7c77ccd3@iogearbox.net>
Date: Tue, 5 Mar 2024 10:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240304225156.24765-8-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)

On 3/4/24 11:51 PM, Eduard Zingerman wrote:
> Check that bpf_map__set_autocreate() can be used to disable automatic
> creation for struct_ops maps.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   .../bpf/prog_tests/struct_ops_autocreate.c    | 76 +++++++++++++++++++
>   .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
>   2 files changed, 118 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> new file mode 100644
> index 000000000000..883f938d518c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "struct_ops_autocreate.skel.h"
> +
> +static void cant_load_full_object(void)
> +{
> +	struct struct_ops_autocreate *skel;
> +	char *log;
> +	int err;
> +
> +	skel = struct_ops_autocreate__open();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
> +		return;
> +
> +	if (start_libbpf_log_capture())
> +		goto cleanup;

nit: This cleanup path triggers freeing of uninitialized log pointer.

> +	/* The testmod_2 map BTF type (struct bpf_testmod_ops___v2) doesn't
> +	 * match the BTF of the actual struct bpf_testmod_ops defined in the
> +	 * kernel, so we should fail to load it if we don't disable autocreate
> +	 * for that map.
> +	 */
> +	err = struct_ops_autocreate__load(skel);
> +	log = stop_libbpf_log_capture();
> +	if (!ASSERT_ERR(err, "struct_ops_autocreate__load"))
> +		goto cleanup;
> +
> +	ASSERT_HAS_SUBSTR(log, "libbpf: struct_ops init_kern", "init_kern message");
> +	ASSERT_EQ(err, -ENOTSUP, "errno should be ENOTSUP");
> +
> +cleanup:
> +	free(log);
> +	struct_ops_autocreate__destroy(skel);
> +}
