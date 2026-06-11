Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99C3BCD07
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170642; cv=none; b=Am1VAPEqYWZNuh4bjMCEvkJukf9WERWgBYLnh90tZQf6GuMgz1zHL+/ixUNlJ8y9FrIAKHKAGs4W/70wEt/l1x2QbYjobQO789zdRqGk1oPtphZMH8tBVdN90aSbzTKIK7qJtl2KWh7AMEOcKXbnpW0bJKje22Efc/GDfjc5IQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170642; c=relaxed/simple;
	bh=Mr4/aftxKuwV6KPHbOr6owQqRVBsrMmBIBI8SgmcPmk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnsT6IsC/KtCcXZ+nldYc1oQSZLBBAZ5zgv6r6c19VclT/eqMz8QJjKcffBlI/t1cATT0DWiN8jTYmowdqzZz2Oj8zTBt1GZiAnCoVoDNrlcn9Wwy40lhUEkYuqqx6Vzd1h6UkUE4VUpJMJzILr5TF+tyD0S20cw6YnqMBZdOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNbSGtTG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNbSGtTG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45efb698ef2so3870316f8f.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781170639; x=1781775439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqHKc0YMAqihL2p8VoSHp+WXE0TvBBK0sq69OmFdgVc=;
        b=hNbSGtTGEjq/fBBCWFaNQesfK0EdLyYF1WTlwrhD/LIgYOFGgDIntICsTxkI8FmoU7
         0wiExWWHyfzy7Kxg2o5lCXyKMCfX6Cvd2/5B8SrHc+66TAsGLiAATfzsF3trHKsEtXoc
         MDbRmtE4k6Te7TckoPHsfi8+IS7lsLMDsY43hAn+1c+wh/wurP+z5lguipixfnZa3jL4
         t5sBGwSNjcxkthN3Aflq2/13pQ7TTP6EXxkgNLZsGKrcvFhdkxeMFwW/t4A1jwpMsDh2
         6fNnc6EB43qBypuDTuMvTHaZiFnChuoPzL2TER8MS+priFZeUmRe1BjISPW6SgCySRc6
         1Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170639; x=1781775439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqHKc0YMAqihL2p8VoSHp+WXE0TvBBK0sq69OmFdgVc=;
        b=qnTYNhdbBTjgMEdgrh53rphEkiUvmvQKNsq9ZP95cEtCrIgj4XgK4Xz8dchxa/fZaT
         Elk08r+2qJhbf8z+MRVoXpdRvZqlTwD+2YWQo/XohpTnjD84oA0eZsUmiM9d4kdlTkaz
         x0bLt1cdQKwviBVgSMj8iT/ySkPCxFTionhIc2XhwdK7QFMAid1Tvqh7go8J9r2gU+VM
         KSvA1Ku0bQXUrebneF2d8znk/ymAvONk9272JDEhIUg9TddryqNLwsj6V+hPklDTUGTj
         hDhjQg00XOK5dJT40I1w0c3lgcemve3wC8Unmmo9KeLZHnoVWsBP99wab9wYchfRoaQD
         DU9g==
X-Gm-Message-State: AOJu0Yy+Bxws5lQUvNjqmCoi3veL5rNhR1QtJEwQ+bVwb9hKztWv+Xgm
	zXtgQqO9Sed6tjxqWNRSAqKp+vBDhFZ6sNp8+gkCaeX8pbFybVdj1iS6
X-Gm-Gg: Acq92OG7aW4DMHchFpxP1E2bI8yV+9M2TfEHXLZMk6GJiuEoOnl/2LcSWeGZYwJ8X2I
	06T0kZmw5+zE0+Ai5b7jC38FRa0D8b/4rnMdKg7E53HNXgTuACyiKp34KJw4blx2PWj6m++FIZX
	FQfArw2x3KCKagqqRXuLmYF2bxRwa8WqUvrc3JzCuCKqO4HPWBje+IXbUFmsdS/lGC4rbTw/svA
	B0qxzEotk5aDOSGSXVqiIoqZPG1D8WVGhHpmMqXNePqPVDhHWlE/xWbar3e+6TSR3FAQoZVQb8x
	J5tY4hhqrXvqEEBe/IXNX3fL4Q/d9pcCKMNPgIWeQMGrrNCcrtHW0Aso2f0ba7Njw8CwO4MAAgK
	bwt6ZCnzbOLLDg/7CZlyuvWPKTvRShcMLnSJVvwxZztle8CnLQiuiyXjAxyhyjEHrOdkNm9BLm2
	I4AYsz3KDSmSiFKZuvkWsrVRgfLzEA4Nb81SBe
X-Received: by 2002:a5d:5e8f:0:b0:460:3234:77d5 with SMTP id ffacd0b85a97d-460677eeb0cmr3137647f8f.43.1781170638608;
        Thu, 11 Jun 2026 02:37:18 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm85187040f8f.6.2026.06.11.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:37:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jun 2026 11:37:16 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 4/6] selftests/bpf: Add uprobe_multi path_fd
 test
Message-ID: <aiqBzKbxqi1nN1lk@krava>
References: <20260610143627.804790-5-jolsa@kernel.org>
 <20260610145046.1D3D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610145046.1D3D11F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 02:50:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The selftest references a nonexistent struct member `path_fd` and an undeclared flag `BPF_F_UPROBE_MULTI_PATH_FD`, which will cause a compilation error.
> --
> 
> commit e5937d581d08ece9671b371d37fb6cd0d497b692
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Add uprobe_multi path_fd test
> 
> This commit adds a uprobe_multi link API selftest that opens /proc/self/exe
> and passes the resulting descriptor through opts.uprobe_multi.path_fd with
> BPF_F_UPROBE_MULTI_PATH_FD set.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 56cbea280fbd2..ffcf3c92f0474 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> 
> [ ... ]
> 
> > @@ -757,6 +758,65 @@ static void test_link_api(void)
> >  	__test_link_api(&child);
> >  }
> >  
> > +static void test_link_api_path_fd(void)
> > +{
> > +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> > +	const char *resolve_path = "/proc/self/exe";
> > +	int prog_fd, link_fd = -1, path_fd = -1;
> 
> [ ... ]
> 
> > +	path_fd = open(resolve_path, O_RDONLY);
> > +	if (!ASSERT_GE(path_fd, 0, "path_fd"))
> > +		goto cleanup;
> > +
> > +	opts.uprobe_multi.path_fd = path_fd;
> > +	opts.uprobe_multi.offsets = offsets;
> > +	opts.uprobe_multi.cnt = ARRAY_SIZE(syms);
> > +	opts.uprobe_multi.flags = BPF_F_UPROBE_MULTI_PATH_FD;
> 
> [Severity: Low]
> Does this code reference an API that hasn't been introduced yet?
> 
> The struct field path_fd is not a valid member of uprobe_multi within
> struct bpf_link_create_opts in the libbpf headers, and the
> BPF_F_UPROBE_MULTI_PATH_FD macro is undeclared.
> 
> Because the patch doesn't include the corresponding kernel or libbpf
> changes, it looks like this will cause a compilation error.

compiles fine, it was introduced in:
  bpf: Add support to specify uprobe_multi target via file descriptor

jirka
