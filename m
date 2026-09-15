Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A454AFE25
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499684; cv=none; b=FK2BQS5QqFiQfHTI9RL/PGBySLkEdYhv2WqQ45wRv7reug3+52ImwS1afAqZExFzwchwabUC0XFrYbc7DKGGbF17eFfHgH1lgJ0iie0d/crohcJXQdOCS1/UUJP4zK5NodN7pCtK2axVBI2x3e0tk2CYjwyOi+wLwWQS4xHNJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499684; c=relaxed/simple;
	bh=E35+f7z6t8rP3/jLjyyIlthQLDp26GKl793wDUvTYBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=I9t8QsC7cPKdxzBgWWdZp1VLxVTlYnFa1yRRmmYE3KXZwAQjcnyGdQLPX6tqR2Nq5t8mluxPW2Lj6F1hhA0BatLc8xPAO1HQ3BUh6geneWWgPdM/kFRdZdHNYN/8gIpjb/Q4PM8skM6SsGxRYrCJPvpftBpKPTQXpWlMKeqcDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JoM9WhDg; arc=none smtp.client-ip=91.218.175.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JoM9WhDg"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E35+f7z6t8rP3/jLjyyIlthQLDp26GKl793wDUvTYBQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789499678; v=1; x=1790104478;
 b=JoM9WhDggoZ5VZ/YPligj39H7nrS42hMTKAu3dKMNJhMBJi8l/GmHM1f+tB/YHYBZaXyXIAR
 ZfVApS0JAX8FuY/fHAWXNb+IeebZMx2qnSe1YAMbbfHoSOcWOpk7JRQD0MQ0vpJ7INj8VMCUldZ
 Vt/lvCP/s5w+J5AOwxm5nD3U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b5c3ccab0652c0eb;
	Tue, 15 Sep 2026 19:14:38 +0000
X-Mizu-Trace-ID: b5c3ccab0652c0eb
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 19:14:37 +0000
Message-Id: <DLG4OYLUDJ69.23VI84CLNNRRU@linux.dev>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Detach a trampoline prog
 while a task sleeps before it
From: "Florent Revest" <florent.revest@linux.dev>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kpsingh@kernel.org>, <john.fastabend@gmail.com>, <leon.hwang@linux.dev>,
 <zirajs7@gmail.com>, <rhkrqnwk98@gmail.com>, <puranjay@kernel.org>,
 <xukuohai@huaweicloud.com>, <iii@linux.ibm.com>, <hbathini@linux.ibm.com>,
 <chleroy@kernel.org>, <naveen@kernel.org>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <yangtiezhu@loongson.cn>, <hengqi.chen@gmail.com>,
 <linux-kernel@vger.kernel.org>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <mason@kernel.org>,
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-3-florent.revest@linux.dev>
 <1846328ba25c25cd5bfe44219f2836f50f90e4c5e243a40042800f67e8d5f372@mail.kernel.org>
In-Reply-To: <1846328ba25c25cd5bfe44219f2836f50f90e4c5e243a40042800f67e8d5f372@mail.kernel.org>

On Sat Sep 12, 2026 at 10:53 AM UTC,  wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c=
 b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
> > new file mode 100644
> > index 000000000000..9a0e1fc44c74
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <pthread.h>
> > +#include <poll.h>
> > +#include <sys/mman.h>
> > +#include <sys/syscall.h>
> > +#include <linux/userfaultfd.h>
> > +#include "tramp_prog_detach.skel.h"
> > +#include "testing_helpers.h"
> > +
> > +/*
> > + * Detach and free a prog while a task sleeps in the prog that runs be=
fore it
> > + * in the same trampoline image, then let that task continue through t=
he
> > + * image. It must not call into the freed prog.
> > + *
> > + * The task is held in a sleepable fentry prog with userfaultfd, like
> > + * bpf_mod_race does.
> > + */
>
> This isn't a bug, but does "a sleepable fentry prog" still cover both
> subtests?  serial_test_tramp_prog_detach() runs test_detach(false) and
> test_detach(true), and the second one holds the task in the prog from
> SEC("?fexit.s/bpf_fentry_test1").
>
> Would dropping "fentry" here, so it just reads "a sleepable prog", match
> what the file does now?  The per-subtest comments in
> serial_test_tramp_prog_detach() already spell out the fentry and fexit
> cases.

Sure, will say "a sleepable prog" in v3.

> > +
> > +static int test_setup_uffd(void *fault_addr)
> > +{
> > +	struct uffdio_register uffd_register =3D {};
> > +	struct uffdio_api uffd_api =3D {};
> > +	int uffd;
> > +
> > +	uffd =3D syscall(__NR_userfaultfd, O_CLOEXEC);
> > +	if (uffd < 0)
> > +		return -errno;
> > +
> > +	uffd_api.api =3D UFFD_API;
> > +	uffd_api.features =3D 0;
> > +	if (ioctl(uffd, UFFDIO_API, &uffd_api)) {
> > +		close(uffd);
> > +		return -1;
> > +	}
> > +
> > +	uffd_register.range.start =3D (unsigned long)fault_addr;
> > +	uffd_register.range.len =3D getpagesize();
> > +	uffd_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> > +	if (ioctl(uffd, UFFDIO_REGISTER, &uffd_register)) {
> > +		close(uffd);
> > +		return -1;
> > +	}
> > +	return uffd;
> > +}
>
> This isn't a bug either, but this test_setup_uffd() looks like the
> same helper that already lives in prog_tests/bpf_mod_race.c: same
> name, same uffd_register/uffd_api/uffd locals, same UFFDIO_API then
> UFFDIO_REGISTER order, and the same close()/return -1 handling.  The
> only difference is that bpf_mod_race.c goes through its local
> sys_userfaultfd() wrapper instead of calling
> syscall(__NR_userfaultfd, O_CLOEXEC) directly.
>
> There is no shared userfaultfd helper in testing_helpers.h today, so
> the two copies would have to be kept in sync by hand.  Would it be
> worth moving it into testing_helpers.c so both tests share one copy?

Sure why not, I'll try that in v3.
