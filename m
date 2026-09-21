Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC864534A9
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982527; cv=pass; b=s+kZIFzrM4+eImejW/vfDg79+hw12vC+nS3DUHw5n2G/MGgLMQFKPsvjBEWhXOOimtGBKvGW+LqcwqGehuK2zWGX6d4rIkzCpchD9pC+GC4aTfGdcW407+ly7ZHA5NHqs9sp6d0OokdnUnXau/hLpFfCwaX8V+4JViZ1E5UQXps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982527; c=relaxed/simple;
	bh=hqdt3u8jCZRU7i15Gds4QdFvF2nrfx3fmaJvhq9NnOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fec5J5rTIhIR9rkWf1rTnLzPIorHUFvVF/SqGe4zkT+taM+mI4rCcWJs3LG7Xx+UeHhGHbB9v42LuN9PAaunEar9O8XBvNaDPnipDiRJ9bTWLvhQy+xEbbGWVUJfQTZpsiaBOZsvlQYGuJtnr/HiX1XE5986F8oa9YvdQ34auF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US/CpIsr; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US/CpIsr"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a98dfb8002so3790406a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789982524; cv=none;
        d=google.com; s=arc-20260327;
        b=NQJDwAzdYiz5f40gONvJopmbpswp1LLcN5OQmNudiX28wd0FONeOlWIg3XBXSzAtrm
         GI4F8fSJv+U1QWvcEcVl3hRjpr0iK9B2x+Z4PA+5vXk9Q4PnBsLmibdB+1+JiFJ7Blo5
         PRn/zCrUp48V0Zbhg8B5IR68wqeeeD1zHo/oAy68oteYMEWh6lgKwzTbWjWMhlAGgU8+
         0K0Wcednfs4UfQi1vZ9asHKtuILVBldmRvYAcaiLeqnVvgAXdXw3TczCbNIy2lOGDR6t
         TThniUW30nM6n7qbwjhaSBkW4Yy7FvD8jPCVs2DloX1G/GDFX3zhOZGd4MEhnK3E/kuf
         p5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRimAqTrykfY5xHk+b/on9tWMPf6/fHaN43wr8alvnY=;
        fh=JrhgCnAikvvfB7IDLxact1PMuBp3bg7HblfGMuGQIAI=;
        b=JU/F/Znlmje0C+AxIXkVxiqMtKFq1hJO0hZBTKNIKaHaGm0DdPYXD8L2my08AsG2HZ
         NACMQmnRBuOAHFl5hUMI8PV2aMLmI0+W2pCx2GtWcoJKvoRVafYiwNOnQVGLTVZh8rWi
         VtrjQda1VPVDWuO7jRrDD1dZNwtH/mkcYOg9o1tgotub8cMsE6tmT2CY1dRIbLVjSQuX
         QuhZRJp+x9XJpcvyQuuRVnhEB6rUcRQ2rmJFF45FXC0AYNFHxJmLfUkPZ0iRWbKqOh++
         EcEkvm0JTVMEEQM8C1ZT7bpcNWYrRaxqFpbYdtJ6JJHXGSuipWgcuniTehbNjufhmGd7
         /PVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789982524; x=1790587324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRimAqTrykfY5xHk+b/on9tWMPf6/fHaN43wr8alvnY=;
        b=US/CpIsrjeWBfOTqnzFGMcHb6VmvK+629h8KYtDlhr4k46xuKUpDQZN5yChO8wX2TY
         DJ0UEkftc/0YGvG83K0pO/CJXF1ZDJErvpP4QIlt8SKUTrwhWFosbP3xamqXTJqwe9NZ
         RBBdIFbdOIpo0lE6oMjIMMlQUie+DekqHz441coB6Sci2VzIqDCXS9cvY02MPOh/0w2l
         X+OaKKH32XWXRm0CNfzjacpIoTiRn8U1bei3WYk4EMv4Bnl85OndTVck9W173iisdlzR
         /CUoj4tvwGcRl5PHTgAnRcZFb/6Bkidhxy18cHI0AnhIBoeAdrvy9S+G9MeVOKPq9WAV
         CODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982524; x=1790587324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRimAqTrykfY5xHk+b/on9tWMPf6/fHaN43wr8alvnY=;
        b=re0q1/AQy9whzTcv7Rwp9Bsr7WlzM07z/KA3Gbro2xCnWXVgO57W0muj3jXcMCKl+f
         kIAC5M1G0dWfLO4F4hWg9BoutTJSqlTnKysqQWzh5LrN03kMGQXUNzg+tDVxIqKCIgZN
         eST2mXGA3MOqJwdnUioMnO7m10uLh/NL7caKR9iXODlhMmHZ1g7S6CocerIN8d5UwUTR
         fku4/hi8vR2MTaakvb3AQLxD49tBrDYhs9i2keFLmF5kX966AXsq7Uv2iJ+Qc2myOckB
         sLMFB5VHWQPRoSIkDLX53CW28Kb9nyYv9Ol8evWfHmvRf6fFYXMwp+ugRXwbtSwBjZ5d
         db1Q==
X-Gm-Message-State: AFuF++maXKfaVqFlZFLkzri2m9RNll6XN/K7BXtT0QokEB5fAMbGmLPa
	DMlrUTnkgq9DhQ7BGy6sc8AdIn3B3GxMEMz8hPlWgiwiubm817M08d5cob4QAI1ccsJSF82xvhl
	pHhV3TK9xaaF7NNZIRp50TfMNuYFM2GQ=
X-Gm-Gg: AYBFou107Pq1z67uqqcloQhwN5bSJDarLSNwmLS9tzfJYJPaCmTGZAGuCHqNlIUZRwE
	pUfyv5k88FZkvkX7mXIo0P1BsgrdroNGgCdNBE98ttq9YnZYkRzmLdRPvgdqEAlabdOg1b656Rl
	Q4sj5isIfh+Ult6s6w7TKnXw3Mk3eJFhE+4Sv9yJW1kOtWxvo9guFHTCFjmQVI3aGAzxqUmRA5c
	5DVrV4KNoYkhrHGKrlNFKxiITNX1auiRQAqBRtxqGdmYqJaw/UiQhZ+P0zn+5dMzNsF5Ql/BE/I
	u6+MnqWWHfWWWeuF1HGTRbvL4HFD81MhHlrzei03txGEt/xWyIS5
X-Received: by 2002:a17:907:5cb:b0:c21:450d:cd7e with SMTP id
 a640c23a62f3a-c2a15788ea4mr816301766b.9.1789982523770; Mon, 21 Sep 2026
 02:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921075855.2065871-3-nickolay.lysenko@gmail.com> <447aaf4b6cf6a6df572afd5323e516ab32554c776b63c08639abde301eba925e@mail.kernel.org>
In-Reply-To: <447aaf4b6cf6a6df572afd5323e516ab32554c776b63c08639abde301eba925e@mail.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Mon, 21 Sep 2026 11:21:50 +0200
X-Gm-Features: AcwNN1UfUQ-6-swm1lrdJDmFp4LWNbku9VR60SUcN_Ko9xw3EwJeVLRuAdZwxXs
Message-ID: <CAMtxOX0fj6V=4n_wmT1OYpt+bwahwbkR_cey9z9H5r4Cto05fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/9] selftests/bpf: drop stale lines, restore
 two header dependencies
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:06=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index bfb788ea65618..3606ee8ab7949 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
> > @@ -339,7 +336,7 @@ $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING=
_HELPERS)
> >  $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(=
TRACE_HELPERS)
> >  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> >  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
> > -$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> > +$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS) flow_dissector_load.=
h
>                                                        ^^^^^^^^^^^^^^^^^^=
^^
> >  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
> >  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HE=
LPERS)
> >  $(OUTPUT)/xsk.o: $(BPFOBJ)
>
> This isn't a bug, but since the patch is already retiring the stale
> references to flow_dissector_load.h, would it make sense to drop the
> TRUNNER_EXTRA_SOURCES entry in the same go? Only flow_dissector_load.c
> seems to include the header now, and that binary gets its dependency from
> the line restored above.

Thanks. Patch 9 removes TRUNNER_EXTRA_SOURCES entirely, including the
flow_dissector_load.h entry. The dependency added here on the
flow_dissector_load binary remains. I would leave that cleanup in patch 9,
together with the runner restructuring.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/355776=
80350
