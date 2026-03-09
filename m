Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C22EA754
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773033907; cv=none; b=jfsFgr9BUwxKENzf8BDP+LbgtxLe7w3FbeL7hj3y0EcXRrGtwxmkPWpFhaUnFULHIOtDxaJuOHN+2adaMnjAYJkXyZIW3kKA6LcUyFmpUB3rX9l0FR1ZU7p9yu6jBletIdH3Awv47c/480JZrWoZ8xBe1CsrjpxE969/dt+3k9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773033907; c=relaxed/simple;
	bh=Rq7fk2Wb1neS4cIsV+4CjgCIDV6Ocu/h+EqdosjrsmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATiUTlutRn6GwS41LubnW+OClnwwQXcAXb3hURDTE4SrlA5qh8gnoqmcBD4SFbuJN/WHpHq3y7fVjWJeBnxPOeKNjjq/t24utbrgW8m6P4Ml7fuKX4jtYYOsSe0HIbx+K56pC3gGYCpEwjfM4eBKZRRxC9f6rlT6bmidhOVy96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t5iYVTf+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t5iYVTf+"
Date: Mon, 9 Mar 2026 13:24:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773033893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCxf8WJldqF9AYHYcS6wvWb3Jsp2NNe7NjAYZGBTdLQ=;
	b=t5iYVTf+l/WR9yJECzxC6iX4FSmA4VejLdndR4cXZ+HyVSvZEvVXSUFVJyjJRrzphMqCIa
	LAwYcInDLNrQ6lRug7tF3G/gR/pAeNkxkqsV1Cd4sVmFct+TpO4Nw1OwDne+Fn4DSAbIwM
	p2qaXkVu7r83lYk4Ia7DZjdRfI7Shx4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: livepatch_trampoline: skip
 when prerequisites are missing
Message-ID: <azvnapx6gnaz237pni5hc5zgmp46gqbmsrogki3owttpv35b3x@s2rakjknh3l4>
References: <20260309033712.728133-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309033712.728133-1-sun.jian.kdev@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 09, 2026 at 11:37:12AM +0800, Sun Jian wrote:
[...]
>  .../bpf/prog_tests/livepatch_trampoline.c     | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> index 72aa5376c30e..b306a4070513 100644
> --- a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> +++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> @@ -2,9 +2,13 @@
>  /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>  
>  #include <test_progs.h>
> +#include <errno.h>

NIT: #include <errno.h> is unnecessary — it's already pulled in by test_progs.h.

Other than that, the patch looks good to me.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> +#include <unistd.h>
>  #include "testing_helpers.h"
>  #include "livepatch_trampoline.skel.h"
>  
> +#define LIVEPATCH_ENABLED_PATH "/sys/kernel/livepatch/livepatch_sample/enabled"
> +
>  static int load_livepatch(void)
>  {
>  	char path[4096];
> @@ -19,7 +23,8 @@ static int load_livepatch(void)
>  static void unload_livepatch(void)
>  {
>  	/* Disable the livepatch before unloading the module */
> -	system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
> +	if (!access(LIVEPATCH_ENABLED_PATH, F_OK))
> +		system("echo 0 > " LIVEPATCH_ENABLED_PATH);
>  
>  	unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
>  }
> @@ -81,9 +86,22 @@ static void __test_livepatch_trampoline(bool fexit_first)
>  void test_livepatch_trampoline(void)
>  {
>  	int retry_cnt = 0;
> +	int err;
> +
> +	/* Skip if kernel was built without CONFIG_LIVEPATCH */
> +	if (access("/sys/kernel/livepatch", F_OK)) {
> +		test__skip();
> +		return;
> +	}
>  
>  retry:
> -	if (load_livepatch()) {
> +	err = load_livepatch();
> +	if (err) {
> +		if (err == -ENOENT) {
> +			test__skip();
> +			return;
> +		}
> +
>  		if (retry_cnt) {
>  			ASSERT_OK(1, "load_livepatch");
>  			goto out;
> 
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> -- 
> 2.43.0
> 
