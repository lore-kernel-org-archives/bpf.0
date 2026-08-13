Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4041D23E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618739; cv=none; b=ECn0BAKrXVY7SH6Jr6HVTvrY3yZ5OicqQLFuEI8XAJ/xYkNI3cjqcI0jCxlyrSLoBaV89bC3E/RYqMn+98JzpyxuhcdjYLGOluXx1tNL1eiuyPqXMW0mgRzuxuWpnrHX8HdJLgZx6NBrGW+pns1T7QCxG98//xXamff3wnaGWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618739; c=relaxed/simple;
	bh=Fqzrf0c2oHZqHvAErMmb00W5PvWM9c8tM/DAUJZyZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d55TDJCvNQn09dL53hMsx0cqArKejFphjf/Z45DRAazGdzkf/vDIFwonVyrw0mb8fRlo+W6D8ImxrU3eLk15h7f/oQBjvJ5NUPJYGz9W0ACvOGq7r0IwACxFS9KMU3jjVNk4E1PKDSwi+yoa35mstnhMuibqoy2dTpvQqXtR7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuQVPvsY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuQVPvsY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954dff6536so14333225e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786618734; x=1787223534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zF7uWzlZDW/sG73C3vYL1MwLDbuHk+pWvcN9523/eB4=;
        b=OuQVPvsYNIbhqIxi522jJye2vTZeggGfPO/WH2NrvCfEwIojPFHh9UUSTDpvny50ae
         f0IWbsrDwbnuNOUZIF+WL0YTNpF6Ehf0zpIbRipH/q/hG+LCB9KwFSm+k8nkeq8b+O6Z
         ujC7H78x2LO+am3kTjfdLAQ9Mlh5rQamAceM5y+eg3ciEZ8RW0khAK0pbkbJXFkKetuR
         RrxqKclC005qEI6yGiXM/g6yUZShuAv1yNMW4idpWpdP7LDCTulXdVAY+YX9WrflGDN2
         M9MuTuvAXdUKAHETFJqrK4WJGkQDZXcc17K26Bu4pxaU/J/pvuUi7vKbdIgo12vK3Wbc
         cEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786618734; x=1787223534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zF7uWzlZDW/sG73C3vYL1MwLDbuHk+pWvcN9523/eB4=;
        b=dU90fOLymK5x7S58MLzesS9HzKgocGArK49npaoYv6Hw630SMfzE9Ym/7mwLqxRoFW
         6GPgsesM+0+uza1B7gigSy3QzQh4HXSOHVRP/C41EMa6vifABD+1WIx1DmVuUU8HmCcn
         TVI4ihnmzTxW3fIW17AzSvAf1+PMEsmPx0XoQXgZncfO/MqsXD7vhD4LP2zukDugM30f
         ZBvvtTUMZQ4hzEGlfLyeseHsiH1x/Y0ynu9xv0PHKdRBoRnvrWd5bXh/8TMkWeHLQQsx
         ekvgu40h2Ns6N1tzrtQWYhqXuVYXGiyq7yLjMBf4CANES2DNZ3+GkRnnSCYeBiXLmSpZ
         CvUw==
X-Gm-Message-State: AOJu0YwUPr4kqd5qPv36dYai+P1y2pgHWkTL9U0T34P46xsPEzAilUNY
	LZwC2SDxBFTUyQPfHBF41F7gYnZF21Ej8zwlkjN2O5nVe9sWO0pnx8pIr2kO8xofGFZQQg==
X-Gm-Gg: AR+sD11iEFB39j+aZQ9kdVTED6lqMrfXYBfMzN1P827sysBA8sYvDfJz72Sz6zsjkLK
	a9+nRQ98Qxm0aRJDnkqgT0EPtu7G35LIf4OCn5wpFU4oIWdAC+GfVUbDgHV0b4kJjBRr8ZN2JSc
	w6xs56UFyYF5M5ayvp5reOUUM9I1ytAFFf3XSKXsE0WoepGQZy90b9UdYqOHwRubOq0+NpNEk3N
	DTCgkZbYqaRZ4Foq5WKWhfhTgPsEDovRUXnx86EdAScyEPgyzU/X4J+HeysK+88tz4IKejTLoqp
	HVgPSRC5ez3o8IyOk035xQJw3oEUuLZAd4foA0jhwhwJ++Ovk+tE32ZiKKXRas6vqe74qoGOF15
	9V1QB/PAP6IG7oYfIc1gTyZf6AwMkrN0bfF4mRNvC6vEN+Nob2jWFiYFvW9/1hO7nJI6S/hvw+f
	jB/VqvVI9b3m0S6jlMauWdy874xjCh/hnNZC0w56PBVANYvCtBVGBKHa1hzSO/7oytwSu38lT8W
	E/sKWRDT8bc0Ic4qkIe
X-Received: by 2002:a05:600c:46ce:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-49982193132mr46948415e9.7.1786618733847;
        Thu, 13 Aug 2026 03:58:53 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1063esm67637475e9.6.2026.08.13.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:58:53 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:58:51 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <an2ja1m_Bn09XpqC@gmail.com>
References: <20260812154328.72834-4-mahe.tardy@gmail.com>
 <389d7d5984e3995303dc4ac505c8629e5d486bef420ffa47d5ee2edf3761cec6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389d7d5984e3995303dc4ac505c8629e5d486bef420ffa47d5ee2edf3761cec6@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:25:42PM +0000, bot+bpf-ci@kernel.org wrote:
> > Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
> > bpf setup program creates a ksock context and connects the socket.
> > Another LSM sleepable bpf program looks up the context and send test
> > data. The userspace harness creates a network namespace and a new socket
> > on loopback, run the setup and send syscall bpf progs then check that
> > the userspace socket received the data from bpf.
> 
> The description says "run the setup and send syscall bpf progs" but the
> test adds only one SEC("syscall") program, ksock_setup:
> 
> tools/testing/selftests/bpf/progs/ksock_lsm.c:
>     SEC("syscall")
>     int ksock_setup(void *ctx)
>     { ... }
> 
> which the harness runs once:
> 
>     err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup), &opts);
> 
> The send doesn't happen in a syscall program at all. It happens in the
> sleepable LSM program ksock_socket_bind (SEC("lsm.s/socket_bind")), which
> the harness triggers indirectly:
> 
>     skel->links.ksock_socket_bind = bpf_program__attach_lsm(skel->progs.ksock_socket_bind);
>     ...
>     skel->bss->target_pid = getpid();
>     err = bind(tfd, (struct sockaddr *)&trigger_addr, sizeof(trigger_addr));
> 
> This also contradicts the preceding sentence which correctly states the
> sender is "Another LSM sleepable bpf program". Should this say "run the
> setup syscall bpf prog and trigger the LSM send hook" or similar?
> 
> Also in the same sentences: "looks up the context and send test data"
> (sends) and "The userspace harness ... run the setup" (runs).

Yeah this is from a earlier version of this, will fix it.

> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > new file mode 100644
> > index 0000000000000..30e89d34d388f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > @@ -0,0 +1,127 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Isovalent */
> > +
> > +#include <arpa/inet.h>
> > +
> > +#include "test_progs.h"
> > +#include "network_helpers.h"
> > +#include "ksock_lsm.skel.h"
> > +
> > +#define NS_TEST "ksock_lsm_ns"
> > +#define RECV_PORT 7777
> > +#define RECV_TIMEOUT_SEC 5
> > +
> > +struct ksock_test_env {
> > +	bool netns_created;
> > +	struct nstoken *nstoken;
> > +	int rfd;
> > +};
> > +
> > +static bool ksock_test_env_setup(struct ksock_test_env *env)
> > +{
> 
> [ ... ]
> 
> > +	memset(env, 0, sizeof(*env));
> > +	env->rfd = -1;
> > +
> > +	SYS(fail, "ip netns add %s", NS_TEST);
> > +	env->netns_created = true;
> > +	SYS(fail, "ip -net %s link set lo up", NS_TEST);
> 
> This isn't a bug, but the test hand-rolls network namespace setup that
> network_helpers.h (already included at the top) provides verbatim. Could
> ksock_test_env_setup() use make_netns() here?
> 
> make_netns() in tools/testing/selftests/bpf/network_helpers.c runs exactly
> those two commands:
> 
>     r = asprintf(&cmd, "ip netns add %s", name);
>     ...
>     r = asprintf(&cmd, "ip -n %s link set lo up", name);
> 
> and it also unwinds the namespace if bringing lo up fails, which the
> open-coded version does not do. The current path leaves the netns to be
> cleaned up by the caller's fail: label instead.
> 
> The teardown at the end of test_ksock_lsm():
> 
>     SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", NS_TEST);
> 
> is also what remove_netns() does, and SYS_NOFAIL() already appends
> " >/dev/null 2>&1" (test_progs.h), so the explicit redirection is applied
> twice and the command ends up as
> "ip netns del ksock_lsm_ns >/dev/null 2>&1 >/dev/null 2>&1".
> 
> Using make_netns()/remove_netns() would remove the duplicated redirection,
> drop the env->netns_created bookkeeping field, and inherit the shared
> helper's teardown-on-partial-failure behaviour.

Good point.

> 
> > +
> > +	env->nstoken = open_netns(NS_TEST);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

