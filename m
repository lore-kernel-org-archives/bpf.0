Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370673290C4
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475380; cv=none; b=N5vDyBd3dPIHoVohyjPqLf+olmtAOqvGbEZYNiO/Ve0mPDf7dC7DB3Iw+qipFT44cpKodr4n/Bkk60UkUNBg+HAVloB3otSa25lNMDA69PJ1ObJIoDQedKspbtSxzRCWC4Z1aeyElKoAjbjdrMZRv2UjD83zBhEToQKTqPQ+/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475380; c=relaxed/simple;
	bh=iz1fSpZVNXeLgggcb5xsiGU0Q8slI2axIwIPVuRpvOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUAMn7bzAsc/qcemwZD/qbla8LWU19bPBGnszT6oxU3IgNe3PZYNm+Frb5u6UNUFTTkM77VtVLevf2+WPfS4Xcso+EbfPkElj5xQW0L0tfMA+1lCcTHD4c/8cVf/Ty6Bk68M+fIdYDkueIEOOmD07o9u8IbDA13DjT8xHLZ8oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipekr+Dq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipekr+Dq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-487035181a7so2130465e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774475378; x=1775080178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mz0kcj+ndhoxRF+/ebTLeUq+YLmqb2xPLvFnCoHBQP8=;
        b=ipekr+Dqnsny0EGTmIEEO9wyP6eO14YaPLriyBCZjD9tXpPQTiAlUGawYgIgoc+8Ak
         ZNQFmRBPulAd+/A2LekW4p1NIJkCbv6/QeA/Lx+cs+unSsZ3aM05ppKnB9xlLApejlQJ
         A4xkbXA2uTJmv/LseYp/tvq87A8sKKMbPHrfgdVVxS8liPnEULn7uxelAHB+mJEpafkZ
         PxBgE3GtAIMJjJWUiNQz6g4hzxLq4IhMpATEiK0tX9O3XI1PRA7biciUXdmQGq9a1oum
         AkJ/1fnQE/bs3pluSQU0cn0Bdyp8sA/oPVa3LAceiexcjs2fYA5f1S2Y+jax86iJOOWL
         64fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774475378; x=1775080178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz0kcj+ndhoxRF+/ebTLeUq+YLmqb2xPLvFnCoHBQP8=;
        b=Z58nFe602tCZDrsj4RDyCSFKE7mzPwxxMucGBi7n6XUPWZxG5olV4cBjIi3KkY2xeV
         7zQ7y1XnRgOO++QJB+ZST0HmQm8KndpbPCCIRM+cU5zK1oHOlQWtt6lnDsW8qgZEVObx
         JoiXcxphD5wVlg/QecEyyiDG56PG/24oSQSlbJeKhWVG3H0nkWKU679XW7v0zXhtIAIN
         zBR3tUT9kNrxXOEfbcl19R8sAXwWkblH1dMsWdcHTsgOTizeD8Dudn9MPRgCNv608wYq
         ptTnfqL5/JwLKEPVqv45AD2Uygf99dK4um0dYY3O412aX5rtx+8l2DTU3FXQLhMgWZQ6
         XVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXawrsIVooZLW8TkL1scx8M82bhYASsdHsPpv0apUpBsnyMIwlsHlju03PC2NqJCAM1Ewo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSYCp0g/lkaAEauyPIdWXisn8VpKCA3C6UjUuPGsKhI8vxbVR
	kIqZ9GS7gLY5u+vIBTVi8Mv3j+h8N5R0pC9yDAWCLHng/jox/jeMSJJ4
X-Gm-Gg: ATEYQzyX5cJC9St0/2IB2jDz+cMdPW1j8lOY7xcv0BqLiF+EiSU5STC7JaRlFdAbuA9
	VrjnwDFFTdLrjTv5REVnaWB2tU7A4cmznxrlMxRx/LoTUs54WrQD43EAk1op/awVju7hbUndk7Z
	qHc/xfHXOyGWPgj+NH9w7j54gH2MJ6tL5S19k/0DGFPF4lpSq4y7+gL6jnrGlSXi8JJMrPTS6y1
	Y+PSsbb91vhd9Zg7Uxc7C+C5FbxMRy/7EqXPcFF8UNY9VXDJQhoAFvFpHkcVU8t6Ut3rsPPXLHG
	eoE5kxdrYNzHsm40FocZr69bKuXCW2v8CeP5UVWgv/54BODZdfK82niAB9l+A9NFNZ6FgkV86+l
	NPgiYPTPZKmicerAy7IamayIoMTI8Iv4JlrTeGIs1FlA75xVf/18155S3mOlEXr3lXZwH+/i1To
	fABd6CNlcojZ57ZOz2YltQurWa3gAWJDpouGAPdIC1rQ==
X-Received: by 2002:a05:600c:a4f:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-487160350d6mr70549235e9.22.1774475377407;
        Wed, 25 Mar 2026 14:49:37 -0700 (PDT)
Received: from krava (h082218179122.host.wavenet.at. [82.218.179.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb38086sm11724845e9.4.2026.03.25.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:49:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 22:49:33 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv4 bpf-next 25/25] selftests/bpf: Add tracing multi attach
 rollback tests
Message-ID: <acRYbQkfgTWqJAAT@krava>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-26-jolsa@kernel.org>
 <f222748c-69ce-4c63-826b-4f2d67fd4ec9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f222748c-69ce-4c63-826b-4f2d67fd4ec9@linux.dev>

On Wed, Mar 25, 2026 at 02:45:59PM +0800, Leon Hwang wrote:

SNIP

> > +static void test_rollback_unlink(void)
> > +{
> > +	struct tracing_multi_rollback *skel, *extra;
> > +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> > +	struct tracing_multi_rollback **fillers;
> > +	size_t cnt = FUNCS_CNT;
> > +	__u32 *ids = NULL;
> > +	int err, max;
> > +
> > +	max = get_bpf_max_tramp_links();
> > +	if (!ASSERT_GE(max, 1, "bpf_max_tramp_links"))
> > +		return;
> > +
> > +	/* Attach maximum allowed programs to bpf_fentry_test10 */
> > +	fillers = fillers_load_and_link(max);
> > +	if (!ASSERT_OK_PTR(fillers, "fillers_load_and_link"))
> > +		return;
> > +
> > +	extra = extra_load_and_link();
> > +	if (!ASSERT_OK_PTR(extra, "extra_load_and_link"))
> 
> Should cleanup fillers here?

yep, should jump to cleanup, thanks

jirka
