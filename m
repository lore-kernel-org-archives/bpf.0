Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934522F9D98;
	Tue, 24 Mar 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774335513; cv=none; b=iukTMtBeCejpOKtmmCN/ma6iKQmdeqL5Yb9IAmO2ByF9ITkv4nrzI6T/N7cv42UANlSG+fkuO4oQrwy7t+Q2LIEqnkuQ9ab12ydQUx3H9pwgtPvAPl6T0O0UuTEB8Gwt6EWe/IlZqtkPErUZ7lvfGmVZ2D592jlUf3KYCS4kCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774335513; c=relaxed/simple;
	bh=lQ/mc0vvd2Gt23nmsGc/fXUoUtUsNAdvBalpI0Yyu9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9eJODwsLTJy+9sBgte47HdyAVoijiSEsYx11cuIzZLffQf2ibqi9hbpFyjGC0lExwbWK3B6MEEa0kQEQY3bpUShmC/sGNXr9uomI/saVLbtdoQ/YSX4vmYh/ZHff2XwrL+NJu6TO7BZmMLImED4idZiOXRHS4DyKWOarU3/Bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8A71476;
	Mon, 23 Mar 2026 23:58:17 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A87193F63F;
	Mon, 23 Mar 2026 23:58:22 -0700 (PDT)
Date: Tue, 24 Mar 2026 06:58:20 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Lorenz Bauer <lmb@isovalent.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 5/6] selftests/bpf: Initialize operation name before use
Message-ID: <20260324065820.GC43072@e132581.arm.com>
References: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
 <20260323-tools_build_fix_zero_init_bpf_only-v1-5-d1cfad2f4cd1@arm.com>
 <31243215-918a-4f03-917b-de869b7b7bf1@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31243215-918a-4f03-917b-de869b7b7bf1@linux.dev>

On Mon, Mar 23, 2026 at 03:52:38PM -0700, Ihor Solodrai wrote:
> On 3/23/26 8:40 AM, Leo Yan wrote:
> > ASAN reports stack-buffer-overflow due to the uninitialized op_name.
> > 
> > Initialize it to fix the issue.
> > 
> > Fixes: 054b6c7866c7 ("selftests/bpf: Add verifier log tests for BPF_BTF_LOAD command")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/verifier_log.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> > index aaa2854974c0a91cbbb9fc13ae0f966de1bcc818..dcbe2ef995c5b211c2b86b9555c02144e11ee7d6 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> > @@ -317,6 +317,7 @@ static void verif_btf_log_subtest(bool bad_btf)
> >  	res = load_btf(&opts, true);
> >  	ASSERT_EQ(res, -ENOSPC, "half_log_fd");
> >  	ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
> > +	snprintf(op_name, sizeof(op_name), "log_fixed");
> 
> You should use strscpy() here.

Sure, I will change to :

  strscpy(op_name, "log_fixed", sizeof(op_name));

> This patch looks very unrelated.
> Did this surface only after the changes in the makefiles?

Yes.  This change fixes ASAN error reported by BPF CI:

  https://github.com/kernel-patches/bpf/actions/runs/23239705647/job/67554431963

Thanks,
Leo

> >  	ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name);
> >  
> >  	/* validate rolling verifier log logic: try all variations of log buf
> > 
> 
