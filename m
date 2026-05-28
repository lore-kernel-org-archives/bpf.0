Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5F3F0AAC
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973211; cv=none; b=N1BKpsvyGytSejBUfn+ITYhACZAKwPjk6IuJ5WbKjekgDbmds/VdkTDgynn0ps+NGUEsN0ADbOBDWXhtKRYNTPbuPMhn6EZ70IQBDATmvfMQSDDnJn07exPPuGdcTfsPBi70NEmetyJXZHCTepNzU+a/m8/SQIUV2EWr3oBiI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973211; c=relaxed/simple;
	bh=o8YVIxQfIVe8G77mNJVV47Yf+bL1xmbDE2RYHEgv5YY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BwPd6KaNL1fcSnyzw71f4VHBLb5aO4n25/ViW3wNQaWW8LKlplKomlf1cWOp1/lXgx9yTMfA/wKaFUHa5cCbOpUPPpnBwkPDlrTkUlFEBr46f4znPRVm0LwyiAsFig1IjjooGI5Sli5yEbQDQpH7Fg41kWDnkZsJlgw92o4WMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Q0QUEUDs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Q0QUEUDs"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso2255391666b.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779973207; x=1780578007; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWX58gHfqJsslfdS6Ak/5KD2sNpGKduMo9iQFj+NBgY=;
        b=Q0QUEUDsXtflsoaiPs5AQJXrjbfC5BxOGm4rackEDchxxD94+hdKtTQW0nrgGvrG9i
         ywrJXtF4CcxupJa5EvNmxCRBgAkajAwlktFUCQzhIBLlq5xs7URRrvOugbycwACqsuLv
         ApNljseXo3g7y6+uVmJnvilWOP5kj0Qajovzy/ByC2NpxBrdqvBZGU7RvpCTrpXZW14x
         jgHptNZmgDbwKzVZEm/9Acx/cGnkggP7SCxj4ZFXdNJB1BvjqKWm2QgmYcz9Esgj/9JN
         HeKu00581kVuv6oVZkizg0HD//3GmcaZBobOOq+Izru1J1TMZg3fazpTQxDSir+oCgvL
         JOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973207; x=1780578007;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWX58gHfqJsslfdS6Ak/5KD2sNpGKduMo9iQFj+NBgY=;
        b=kbkQn8p4fWP4kvSjdo47Vgyx+4cjCAXRPZ66LTJ0T7rTcp2moooLYqyLK54TJEqnnl
         3YTYGGNkD5sl/F1jyrpj8zRvOHLCLEcPNZxF6cEipGwFSCKbK/dPTjcgin/S7wiP/JHx
         6PiGPv4mUuJAOiK3oBvShGCAsv2mtGnwMw+X/4aSNr9WI6GECuYbF20q3iVpwTb4kkFk
         jjEz77nf+Vap+X7eVcbKalWP+knuJzoLTDQ/VEALcBmuG2Arm8PviKHET9ne7du0/N+t
         5NJijyhd0nB2YB2kCgRBWcLuBZt6edo6toXxiTc0cfrL+GGbvBUQiitMUqT02QYpwZ1L
         Mx3A==
X-Forwarded-Encrypted: i=1; AFNElJ8t9J574Pp0ZjWl6nmuzRetwopKTYCDpNT2zD9Z3mMXlosIxaDfOwVJpxwbE3V8qZXeSNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTbJoL5UwEfL2vT9drhh435DzMvXsC6vUB0tjPWnWFAzXuksS
	C5MIDizQQxE3yI2sMDMzSUAir+TDs9cAxUVuzTfYGaW2zHsINKbduzWe0ubakxMBvu4=
X-Gm-Gg: Acq92OGfsgtuUK2imVkoiuYrynXQxOll8zaX0L1KWB0QYIz5VKwl6Zl7Y14E6W7yUQg
	Z9TYsHBpFQh+1tOl9uUqUc1J6HOVgMmNJRx+EHhkNQMGPfuJ4xr1VMyiVrJH2f+dshA766MTAIm
	PDZyoBc2Bsf3HP7AFCzInBd7IFq2qIUusCtHMKsLVCBRh1z3uFq3WCJAmnbRseCMSdTjF/bRNx+
	Jt+MKnMcHJloo2dEgaO5r4jZuBBQbbREDScnzdWC8RmdtAaBGXsljX/psSHASmWoKPndHZqZ01X
	NoB17peT+QPx2fdUm/dMdBnWrCR+ElA2IdK/x2MjQhn9ZROwo4b637gug5/UvcBnB7pI708hNwE
	ySU35ihtgTBAv4Gt7b1jkeaK26dAwAWfbooX+scPIWedlkrLZL4j8XHXl4T9jfRMDD9L8ia19Xe
	PMtAJFVHM4D/iDvOcAZCG9Gq+Vze2dg+Tek+i0
X-Received: by 2002:a17:907:75d2:b0:bd3:7b11:7870 with SMTP id a640c23a62f3a-bdd22a3d645mr1299661266b.5.1779973207057;
        Thu, 28 May 2026 06:00:07 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be8a8637bb1sm38485166b.39.2026.05.28.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:00:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 13/13] selftests/bpf: Add tests for forked/cloned
 optimized uprobes
In-Reply-To: <20260526205840.173790-14-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:40 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-14-jolsa@kernel.org>
Date: Thu, 28 May 2026 15:00:05 +0200
Message-ID: <87ldd3665m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> Adding tests for forked/cloned optimized uprobes and make
> sure the child can properly execute optimized probe for
> both fork (dups mm) and clone with CLONE_VM.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index efff0c515184..033d32b4cc27 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -4,6 +4,8 @@
>  
>  #ifdef __x86_64__
>  
> +#define _GNU_SOURCE
> +#include <sched.h>
>  #include <unistd.h>
>  #include <asm/ptrace.h>
>  #include <linux/compiler.h>
> @@ -936,6 +938,88 @@ static void test_uprobe_error(void)
>  	ASSERT_EQ(errno, EPROTO, "errno");
>  }
>  
> +__attribute__((aligned(16)))
> +__nocf_check __weak __naked void uprobe_fork_test(void)
> +{
> +	asm volatile (
> +		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
> +		"ret\n"
> +	);
> +}
> +
> +static int child_func(void *arg)

Nit: Could annotate with noreturn:

#include <stdnoreturn.h>

/* ... */

static noreturn int child_func(void *arg)

> +{
> +	struct uprobe_syscall_executed *skel = arg;
> +
> +	/* Make sure the child's probe is still there and optimized.. */
> +	if (memcmp(uprobe_fork_test, lea_rsp, sizeof(lea_rsp)))
> +		_exit(1);
> +
> +	skel->bss->pid = getpid();
> +
> +	/* .. and it executes properly. */
> +	uprobe_fork_test();
> +
> +	if (skel->bss->executed != 3)
> +		_exit(2);
> +
> +	_exit(0);
> +}

[...]

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
