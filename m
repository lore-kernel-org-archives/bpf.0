Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66233644CC
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765310; cv=none; b=VNbIyBMq2OSX7NGxGTjyuKVvqmmcT1Ng4Mx8eitwXBbPQ1DmOBn8RHYVgFJoEF0CSy1mHL6NA2sMwZAgCPlqaYdhnT6Rul2B952q/f6PzZCuztPqF57sLWQPzuvi6f+Ixn0ujxBCh2KNTS1J1WKwnDmXAfmBtTZCQWOuXKM2ZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765310; c=relaxed/simple;
	bh=iILEPiIwHnRLPmGOXZksIFB/R7vwmo7XIFrxPFnzMww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdZ8a4p+Q1LBsAWRU7mp9OmRlYol3T21BKQR4/ywEA682VAY6Tw8jVcLRaIVBSSDKExMv9j0LtDGAJMh3KuVvyymMV7UtTa7KRsD5KpWnBpQF6WsI9WK1LrCOZcnPNYNqIqmIIvgcr2w+uNR3GyrTLkKpy+wIgW6TcmogjBlDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sgvB0PCn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sgvB0PCn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772765297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnyKKhjUMQdtzRPCfQPC86cjX+ja946dn+HfEgoK+6o=;
	b=sgvB0PCnBRwb1VGN0eWlNdAfrgF/e0dmDdld/mgOqotUQjvTFKOuQeWjJVJMXQc4TAP4Gu
	t3QgDMgYslR3F2uJGv+YRpgH/N4RnlkV5QBkEtg8KSrMuhgq5NXAzJb/GS707tQDo7TwC1
	SLSWIcuuJsGGBMFs9PkJBFeGpIUb5Hs=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Varun R Mallya <varunrmallya@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in
 fexit_bpf2bpf.c
Date: Fri, 06 Mar 2026 10:47:59 +0800
Message-ID: <13961058.uLZWGnKmhe@7940hx>
In-Reply-To:
 <CAADnVQ+gA+4UHjz8BvN7fSRehZ9c0vdYGVJ4e01ecat3beCwAQ@mail.gmail.com>
References:
 <20260305222132.470700-1-varunrmallya@gmail.com>
 <CAADnVQL7BpNh_WuR3bPKuVPeKLOgnkY+MUwDG2WgN1ZPtD734w@mail.gmail.com>
 <CAADnVQ+gA+4UHjz8BvN7fSRehZ9c0vdYGVJ4e01ecat3beCwAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/6 10:26 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Thu, Mar 5, 2026 at 5:40=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 5, 2026 at 5:16=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> > >
> > > On 2026/3/6 06:21 Varun R Mallya <varunrmallya@gmail.com> write:
> > > > Building selftests with
> > > > clang 23.0.0 (6fae863eba8a72cdd82f37e7111a46a70be525e0) triggers
> > > > the following error:
> > > >
> > > >   tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:117:12:
> > > >   error: assigning to 'char *' from 'const char *' discards qualifi=
ers
> > > >   [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > > >
> > > > The variable `tgt_name` is declared as `char *`, but it stores the
> > > > result of strstr(prog_name[i], "/"). Since `prog_name[i]` is a
> > > > `const char *`, the returned pointer should also be treated as
> > > > const-qualified.
> > > >
> > > > Update `tgt_name` to `const char *` to match the type of the underl=
ying
> > > > string and silence the compiler warning.
> > > >
> > > > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c=
 b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > > > index 23d933f1aec6..92c20803ea76 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > > > @@ -111,7 +111,7 @@ static void test_fexit_bpf2bpf_common(const cha=
r *obj_file,
> > > >               struct bpf_link_info link_info;
> > > >               struct bpf_program *pos;
> > > >               const char *pos_sec_name;
> > > > -             char *tgt_name;
> > > > +             const char *tgt_name;
> > >
> > > I have been suffering from this build error too. So,
> > >
> > > Acked-by: Menglong Dong <menglong.dong@linux.dev>
> >
> > Looks like this patch was lost. Pls resend.
>=20
> Ohh. I see it now. Your reply got delivered before the patch itself
> and the patch went to spam.
> No need to resend.

Okay!



