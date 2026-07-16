Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C643F0BD
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245543; cv=none; b=Hk0b/faBc7higrGNchnc68N7lyvE6HvHSgOrYYSa8Df6K8fVpMsOz+b1nW37FnzOauFqPoM8JP7bPPuQABf/OEl3AGL+i5EKMu2ago0C6pKLoJ27w5Qe8iuTrgz1WQPTsAXnlqVjcfmF2I+DxTqtTwf2YwGomipP+6VMI1BWTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245543; c=relaxed/simple;
	bh=OsS/Dfwg3jHL5guMGLwWn8R0960tb1GgVPgmASLXEjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XELpI6zDBv7Ed84mLHsltw1EoBbOlCO4iY8kDt3eK+8fRLNyONADiYqM0qSX4q8W+0Em7vXjrZfzKWRmYzX0SGmcZpHzsdimVGn5wqW8r++isBYXu2SSMeEx3G1JzENqXleyHhM6uEWCUYr8klpEaQWkZDwUuyVMcSkgXxnGvtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QT+2r2eU; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QT+2r2eU"
Message-ID: <0ffd26d2-a5f1-4c4c-9f4a-13809f9eb94e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784245538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1becnpJbME6g8mWYjTGk3H2Tf/gdpN9cMbFfUAFNEc=;
	b=QT+2r2eUlrKbh7EsQ7YEuChC149sWmAjDSC+Mft3mSfACYm7TY25vvncoAKOtjrKZuCY/V
	rCBvOI6tFVTAWBrxqC9R/8+UpIDNyFXvIK+Hs9IbP76OkiGSc9lI5lT9qhctyFNv6eNpAy
	prLOcu2RK7afl7oY/Wtg51iuqYcsc4I=
Date: Thu, 16 Jul 2026 16:45:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/resolve_btfids: fix OUTPUT leakage from kselftest
 causing corrupted build paths
To: Jiangshan Yi <yijiangshan@kylinos.cn>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, paul.chaignon@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 13667453960@163.com
References: <20260716085733.1761196-1-yijiangshan@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260716085733.1761196-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/16/26 1:57 AM, Jiangshan Yi wrote:
> When building kselftest-all, the kselftest Makefile passes OUTPUT as a
> command-line variable to each test directory:
> 
>   tools/testing/selftests/Makefile:
>     $(MAKE) OUTPUT=$$BUILD/$$TARGET -C $$TARGET
> 
> GNU Make automatically exports command-line variables to all sub-makes.
> This OUTPUT propagates through the entire build chain:
> 
>   kselftest/mm (OUTPUT=.../selftests/mm)
>     -> gen_mods_dir -> page_frag (kernel module build)
>       -> tools/bpf/resolve_btfids (host tool dependency)
> 
> The resolve_btfids Makefile uses a conditional assignment:
> 
>   OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> 
> However, ?= cannot override a variable inherited from a parent build's
> command line or environment.  The inherited OUTPUT points to the wrong
> directory (the mm selftest directory) and lacks a trailing slash.
> 
> The tools/build Makefile.build system concatenates $(OUTPUT) with
> filenames without a separating slash in its pattern rules:
> 
>   $(OUTPUT)%.o: %.c FORCE
> 
> When OUTPUT lacks a trailing '/', this produces corrupted paths such
> as ".../selftests/mmmain.o" instead of ".../selftests/mm/main.o".
> Meanwhile, the resolve_btfids Makefile itself uses $(OUTPUT)/filename
> (with an explicit slash), so the HOSTLD step produces the file at a
> different path than where the LINK step looks for it:
> 
>   HOSTLD produces: .../selftests/mmresolve_btfids-in.o  (no slash)
>   LINK looks for:  .../selftests/mm/resolve_btfids-in.o  (with slash)
> 
> This results in a linker error:
> 
>   ld: cannot find .../resolve_btfids-in.o: No such file or directory
> 
> Fix this by checking the origin of OUTPUT.  When it is "command line"
> or "environment" (indicating leakage from a parent build such as
> kselftest), use 'override' to reset it to the correct directory.  When
> built normally via the kernel build system, OUTPUT is set by
> scripts/Makefile.include with origin "file" from the O= parameter,
> which is correct and remains unaffected.
> 
> The fix can be reproduced and verified with:
> 
>   make -C tools/bpf/resolve_btfids clean
>   # Before fix: fails with corrupted paths
>   make OUTPUT=/path/to/selftests/mm -C tools/bpf/resolve_btfids
>   # After fix: succeeds, artifacts in resolve_btfids directory
> 
>   # Also test environment variable leakage:
>   OUTPUT=/path/to/selftests/mm make -C tools/bpf/resolve_btfids
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  tools/bpf/resolve_btfids/Makefile | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 7672208f65e4..eee88c73fd7a 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -26,6 +26,22 @@ HOSTAR  ?= ar
>  HOSTPKG_CONFIG ?= pkg-config
>  CROSS_COMPILE =
>  
> +# If OUTPUT was inherited from a parent build's command line (e.g. from
> +# kselftest), it points to the wrong directory and may lack a trailing
> +# slash.  The tools/build Makefile.build concatenates $(OUTPUT) with
> +# filenames without a separating slash ($(OUTPUT)%.o), so a missing
> +# trailing '/' produces corrupted paths such as "mmmain.o" instead of
> +# "mm/main.o", and the linker cannot find resolve_btfids-in.o.
> +#
> +# When built via the kernel build system, OUTPUT is set by
> +# scripts/Makefile.include (origin "file") from the O= parameter, which
> +# is correct.  Only a command-line origin indicates leakage from a
> +# parent build and needs to be reset.  Both "command line" and
> +# "environment" origins indicate leakage; "file" (set by Makefile.include
> +# from O=) and "undefined" are legitimate and must not be overridden.
> +ifneq ($(filter command line environment,$(origin OUTPUT)),)
> +override OUTPUT := $(srctree)/tools/bpf/resolve_btfids/
> +endif
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/

This seems to be a real bug, but the proposed diff is just wrong.
It doesn't even fix the case you target.

The `override` runs in the outer make, but the corruption happens in
the nested sub-make (resolve_btfids/Makefile:105):

  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
	$(Q)$(MAKE) $(build)=resolve_btfids

Try this:

    $ cat parent.mk
    ifneq ($(filter command line environment,$(origin OUTPUT)),)
      override OUTPUT := /correct/
    endif
    export OUTPUT
    all: ; @$(MAKE) --no-print-directory -f child.mk

    $ cat child.mk
    all: ; @echo "OUTPUT=[$(OUTPUT)] -> $(OUTPUT)main.o"

    $ make -f parent.mk OUTPUT=/leaked/mm
    OUTPUT=[/leaked/mm] -> /leaked/mmmain.o   # override invisible; still broken

Your standalone repro probably only succeeds on a dirty tree.
Have you tried testing from clean?

Also bpf/Makefile:440 and hid/Makefile:159 deliberately pass
OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ on the command line.
And so the patch breaks those too:

  $ mkdir -p /tmp/o/resolve_btfids && make -C tools/bpf/resolve_btfids clean \
      && make -C tools/bpf/resolve_btfids OUTPUT=/tmp/o/resolve_btfids/
  ...
  make[1]: *** No rule to make target '.../resolve_btfids/fixdep'.  Stop.
  make: *** [.../tools/build/Makefile.include:15: fixdep] Error 2


I think a proper fix is to figure out a way to avoid generic OUTPUT to
fall through to resolve_btids (somewhere in selftests/lib.mk
probably).

Please make sure to test your change properly before submitting.

pw-bot: cr


>  
>  LIBBPF_SRC := $(srctree)/tools/lib/bpf/

