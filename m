Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4029DB86
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793990; cv=none; b=H/vXMMtAWHPz5cmw5v4YQ2MwiyNZ9qhpn7ZxUOSw8SbUlwuF+qxJ8IZ+BpicRnq96tfUairEatAN8jeNTsZvBJfnkXDteOAT1s3Rzywz/zrPyV2hEl7KtH0fVtnwVZ+2g6tccBMM+Krkb9MFb1wzGAZbdt7heC8KrTcdJwxKO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793990; c=relaxed/simple;
	bh=12TIH/ruxgKdIOU8pjWtlJBdXrxl9KsvEs+uhot3q/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+lBOzW/XpGetwuQ4H5SXyLZXS8rKKq+Ai5nZBfidCKXA5CDQUEiEORHeir1o4ZlGKV08DtpY25ZuqGD3heMWfJPdJayGVQS+LDLIuPwtRbEnC0hGKCFy3LMLxsksZQScqcljypxijqSxWXI79yCFdjd2XZf+5y4dTp8KMdArx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFMcz95p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFMcz95p"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso884416b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 21:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775793989; x=1776398789; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6zByR4I42nJU+U7WNsfen5fUnNABHZ3cyk6mFVO9Ap0=;
        b=HFMcz95pBIWLDzurUHcdYWH8W7cxdN0Wy3wZP2UaotsXYvV+vbqlB90VFygkQVUNZw
         R+ehwprmqootVH4G/OeNyszuX1KKMTR1gpn1ZJ0zTiQY72P3W1Q9Js8jP9e9ELNHNooq
         X4ZojuyuF7c/GL/s90rVnGzazJ8gAxuIvnvTou5r48lD48ZUrHjTmnKrqf9URlKu2Bok
         pG1qV63/OSpHUsddATRDFcxuLzD7+M+dMs1BKH5uf2kFzWeRpc7PQj2DWjTvy1QbRlLS
         /nwYDvJ+8vofUejvpBWZf+ptcviiztxomEFGkWd2qJvKOkwL8h/Zud7oiEbvpVKgP31I
         TeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775793989; x=1776398789;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zByR4I42nJU+U7WNsfen5fUnNABHZ3cyk6mFVO9Ap0=;
        b=XMkimBYaKbZZ7DFsk9v82Z58XdawDWV5TOLR2Wf73iSaKHJDDL1TwH36PmBfVDXYHx
         Cz3JPdQMJTsn2SD2RYsHiCMWEu36FNkUGSG7ygDBT7C9yZxVn0QXTEVWAqNb8jGwsq3Q
         Ubnak6ioCyBhf+ZaKOx/Ps6UDhP22ox/jmZbonpaa/wai5hvU5HOy6Ca2YqzdU0e/b4M
         IzBmFByFjSyHUMhf/TequgakMypm7DsFltQg/hIIP9+Y5a67LZPyUJlLaTAuoIX6lXDQ
         F40m2Je5h+RWMqkuEr9v/9wFN+3X34VzMMB5c+9vWLEe+Ev1nJPHslWBt/vky/MuM0EL
         wWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtqL2CM11C0mQ1O/ZJKiR64LaAXZWjqEvOwzO1BzWJNn875b6zyhy1UYetudLAydQZtyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbCJXolBSOu0kjQSVNtDUI1WEpwQZd4nT71hBHxfUZtZqkjxi
	3ojFPxlgzTRd4ThOVg+tbCscGvDSjUOavBRdLtHrQqEg7vfCBEvuewlG
X-Gm-Gg: AeBDievxvsssdZvPYJeU/gYRpbfMp9UKlEbmj43uRqSPbMqHkesqpqqYEbEqw6Zk0jA
	GfbjE4D3xi95Ey1FgdrZFReWn89u1aaYrvMkKZ4zS3BWl0jOyT4eCte7ujGzNk9u7pnwIt+sU3J
	2w/BOBMOLz3IpC1rq1AC/9/vB/J9SCdi+HeYA0BXlZLzs//nAKW6cpqcQMg7ScBmWDgWbeC5tTN
	EQc2qxEwunjHNqhqa4e5LgtAltT8u6+L8isD2HR8gGfa8sbhTYuBZlwHWv1SVVNSCDW5U8dKEKe
	pB/DqLXSZs35b6P4Qt1Wzan4VCj50glgQgbaRTbSpXS2lsbUd9Vg4FyJNBhvcUCBAHIgMQfHtMj
	JdQZLpKGWmFlOPbsotDggkGJfxCFKm034M/lroe+NP/dM+cy5oLmsyb/IZaJ/Ck1I7pZmN4V+zt
	ccKDShd0RaBpQ4qusGxWaDcdfbnRyMKvj9UYXfvZfXo+DiYEop5u6I
X-Received: by 2002:a05:6a00:847:b0:829:7b30:92f4 with SMTP id d2e1a72fcca58-82f0d1ec618mr1470423b3a.16.1775793989026;
        Thu, 09 Apr 2026 21:06:29 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b2455sm1082944b3a.35.2026.04.09.21.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:06:28 -0700 (PDT)
Message-ID: <cc3f05c2e39396764347d73a49d9305de853f48a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/13] bpf: change logging scheme for live
 stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 21:06:26 -0700
In-Reply-To: <ae3905f1e84c416687ced8fb9db48af481b77a68915805e80e4be42147699821@mail.kernel.org>
References: <20260409-patch-set-v2-9-651804512349@gmail.com>
	 <ae3905f1e84c416687ced8fb9db48af481b77a68915805e80e4be42147699821@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 02:02 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index c13f57ddf582..f296c3304752 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +static void print_instance(struct bpf_verifier_env *env, struct func_i=
nstance *instance)
> > +{
> > +	int start =3D env->subprog_info[instance->subprog].start;
> > +	struct bpf_insn *insns =3D env->prog->insnsi;
> > +	struct per_frame_masks *masks;
> > +	int insn_idx, frame, pos, insn_pos, i;
>=20
> Should pos and insn_pos be u64 here?  They store env->log.end_pos
> which is u64, and are later passed to bpf_vlog_reset() which takes a
> u64 new_pos parameter:

Yeap, u64 is needed.

[...]
