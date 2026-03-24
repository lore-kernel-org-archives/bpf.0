Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127336C9E5
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367739; cv=pass; b=XbQLIIfgXY0ZtCJz8hD7wVSYKI0EDkFRWNKEqtN/Rgt/a3o9ZwzkyaK27BTSeTaGj/cUbESydtPpJiGHS7ER+nFIif8D6ovlSPP8MvqHsxSdwfhD3VdIYxiHQaBRgaJZyOpQJE19EUTA2xcabpdahBwdUjhFL+0v8YRvVXqEaBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367739; c=relaxed/simple;
	bh=agkUattKYKS6hTX3T/qy79TAvmS3mkdNShYWcGbK5XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onMopeLttmLvKVhhJp1Wp6/rsMQlJlCojjgNdrNnu3MBKAEXh96Wsyri7RsBCHsrP6Pzfz9Hv7SJN8ggmZpnQigwRzBROKKlpC9Nr6Mx46TUEIJzx310ovn/vfJ+wvrdFrTCiQJDpvCYc7oYzaCcWqHYJx/0mrD8+KTVQhDjd1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjIQeho8; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjIQeho8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso4385790f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367735; cv=none;
        d=google.com; s=arc-20240605;
        b=i6HN0mL2PUMBApZxKxRO7ojy5SkxaEMRvw/W2r6FLvvaBGpzQmxu86VZ0SD3aMPi5j
         VufKf4XK5VZY/meo2z/DrgQIEtVfbm48M/4s/RkC9yEcAADCzywgUN2sahPy41iNEvk1
         IbaEJSoTDr5djU0dTByfbq6Gci7T0Fj7kd/LZsxaXkKptfRMZ0HNGc14kXGPg3txOLsv
         OktHlp1cJVu+EPa0ixjMfdHYNMPqALzz7LAMdBMZAu6UEhtwB9fxAax7q4FdqKRDr6sO
         RuPEhnx7tgQMwb9CKxhRuNqHEL0SxSAKHXZOQ9rm14sdprS51s+j1QO5zs34tN7o4W5L
         zSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/3OhNPFF53dFC048CnXCU+MpM/yyzQDjUWEZB/ZZUIA=;
        fh=uHBWIOWL7hnhTzzqsD9nnAZfg5LLegZ20b+QCpmtBIg=;
        b=HRjjDmds+XzSN6hUTxWz84gsHq/gInAv2AfEEW490cDR6WWNoZdXVRoq1FZhiM4rZP
         Wy0NXE3VP098dj3eyoW3+GI1WYJjX2u68s4sSvgH2Kqn1U9SL3oY8o+0Pr8BmQGuScIt
         58hjgku3x4BpW6IeLdD7AGROywjcj8+mYHzzlqL/rh6tYIuRtB9XsDDTmXoznAUxuSKc
         s4e4CsxKBB6jH7bRHkM/pi2eDBK380Ny1xdWqEZS07YUFSQwr9CD8Hx4Ct2UKBOkOFk7
         NFWyhknQeTfRoqivdLHt6VBDXzO6+E4izbCAirrGw0553vYfKM7HeclwnyZsMK/4/LyV
         2cow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367735; x=1774972535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3OhNPFF53dFC048CnXCU+MpM/yyzQDjUWEZB/ZZUIA=;
        b=rjIQeho8/atppzNRRSqIlisNezrQeKUf/MrYc6A4Lsnj0K7MnAW7uHHPBs+6t8gnyM
         KLpSgkfD/NbB3ZfyIjC3Sc1CaeaIC9Xsp93yDSMDwJQa8NAuKdkYIaFer4T1sGh7dhGd
         6kpZ7eoyo5Qu2rehY4cy6Zg4MyN+57lhl7rIrz7jQuD7pxPfE0jPEt4rYVpasAziDXb9
         I+H8QHXVLvpCIr8ijzYZ17hS2PYkOXuifLf+fvSJ9/xd83OhIyMORfFaYzV6qaaMVYFw
         uqpYNjZHYyOQVZPQ7DPoYD4dSn61O3e5wDvgl9PRZtDwjpB/81JAY3rXjK3TElv3ULDb
         H6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367735; x=1774972535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3OhNPFF53dFC048CnXCU+MpM/yyzQDjUWEZB/ZZUIA=;
        b=Joq6nCCue91mKE07atAJHmKfxVYfzo1AMREO6aa4HoAcQUH6TGF4SvYDcvWQL38cyM
         JcVbNyJ29CQgtTV293KQ1ZESfVHl/j0ZClTwwRkH8NmtU/wuVKb5gLD+XzUREeTYf10k
         5OdtyWr35c+xM3ajUpLXjJCXQe4iy4SeFWm2uU+UI+E36jLe+hKC7AfT//p8sYjKBkXH
         Lt51y4ySMY5mrElhhyUr4LX4nwGZu9N/XLkGH4mfm75sNlgdTQjhMMeq29HLp3v9UwIa
         op1ycYl1yoZ+6rwl+YQDzomeaPF+G7tEzN4fXnCO/ODqh6RbEErq3CpfpLBNbqpjRo76
         MkYA==
X-Forwarded-Encrypted: i=1; AJvYcCUNs6g5oCItMI1taXkdXY5TD5mbA6d0ZmCRvSyVs59apEuLCTfP8GrpOXViiTi28lHcA8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojqmRm7bxhkmVs2zTEgRj9MQO/wBPRa2d+K3KZhxwN0Wf3Q2L
	GqEAN/SZmdgYpEM2Bez4JVativ5FmuAIbZ546j4xlHi9negFgq52T7sZQWMY5+/gkDwRfA5jRzK
	wX4VX+dKGwq/dp0sQAhK8srjZmr4lyOA=
X-Gm-Gg: ATEYQzzA/YsE9WTFu+iFSDyRSA30t3pvA7Fd36gqHheHg0ZpMfD9l5kRssIJ93RLPZS
	3aY+htguN8qgfWJkNx31zsGDcx2Zavapm5ogbQvhUiHkJiMt04fFROadDqepLnkUOEhC90QRW9E
	3XaqvqevibkJr53xSmLt+7JxavM45p9/jZZ69Yuk+46Pm9yTycM4XhTewGuSE0boU9J+8T48TkK
	P446z+q2lyO63W4x2uYHegD/jAttObktn9KVV3pf/0EfWyeCycK4l53J+9A+u237t+f8+cK0DLs
	9HaTWpEdc2y2OVEoeEYUEpMHVvgw7EbINDJikpVbvnLdhFQMuooQqbWsXdXAcKyOiYpRMgWqVyb
	O03BN4eCiaYiyIu9OamNcBdmCTeaKWOy3MX1Q
X-Received: by 2002:a5d:5d0b:0:b0:43b:447a:11b8 with SMTP id
 ffacd0b85a97d-43b8899533cmr19587f8f.6.1774367734362; Tue, 24 Mar 2026
 08:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
 <20260323-tools_build_fix_zero_init_bpf_only-v1-5-d1cfad2f4cd1@arm.com>
 <31243215-918a-4f03-917b-de869b7b7bf1@linux.dev> <20260324065820.GC43072@e132581.arm.com>
In-Reply-To: <20260324065820.GC43072@e132581.arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:55:23 -0700
X-Gm-Features: AQROBzC5IXAEUJFbmA8caaR_jFD39ZGF7akzX-go1yOK6QjtBXhXNQ_zLdejUkM
Message-ID: <CAADnVQKJLO+7NnbPvmTraZr8hq8ENSh2f85a21b717ye=NgpUg@mail.gmail.com>
Subject: Re: [PATCH 5/6] selftests/bpf: Initialize operation name before use
To: Leo Yan <leo.yan@arm.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Lorenz Bauer <lmb@isovalent.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:58=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On Mon, Mar 23, 2026 at 03:52:38PM -0700, Ihor Solodrai wrote:
> > On 3/23/26 8:40 AM, Leo Yan wrote:
> > > ASAN reports stack-buffer-overflow due to the uninitialized op_name.
> > >
> > > Initialize it to fix the issue.
> > >
> > > Fixes: 054b6c7866c7 ("selftests/bpf: Add verifier log tests for BPF_B=
TF_LOAD command")
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/verifier_log.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/=
tools/testing/selftests/bpf/prog_tests/verifier_log.c
> > > index aaa2854974c0a91cbbb9fc13ae0f966de1bcc818..dcbe2ef995c5b211c2b86=
b9555c02144e11ee7d6 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> > > @@ -317,6 +317,7 @@ static void verif_btf_log_subtest(bool bad_btf)
> > >     res =3D load_btf(&opts, true);
> > >     ASSERT_EQ(res, -ENOSPC, "half_log_fd");
> > >     ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
> > > +   snprintf(op_name, sizeof(op_name), "log_fixed");
> >
> > You should use strscpy() here.
>
> Sure, I will change to :
>
>   strscpy(op_name, "log_fixed", sizeof(op_name));
>
> > This patch looks very unrelated.
> > Did this surface only after the changes in the makefiles?
>
> Yes.  This change fixes ASAN error reported by BPF CI:
>
>   https://github.com/kernel-patches/bpf/actions/runs/23239705647/job/6755=
4431963

When you respin please use [PATHC bpf-next v2] subject.
Otherwise CI doesn't run all tests.
