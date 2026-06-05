Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84B3CCA13
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693634; cv=none; b=fCPkDhkf9qGby9UVyk/xNRPlTqAkT9XLrOs01HTNNBJgpHwwfx8fZDAXcNoPmznywUShgI9EvngZStWGgryz9dsf75LpQLmCrzcQFn/BGLbQvfahXO0s7TUitcJPq6biIjj9HGpZ7/Cn1m75llBhTEECgJh0rqz+7OI7kB6rhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693634; c=relaxed/simple;
	bh=WYfqa6X63b23UNb0/gfBBME1f6ypHZbfuN43e5V90Nk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WH3V3f7UzbdwJfxQBpvLLNs8pIF0iAG71m3CXZHc9r+OonuV+TENaLsjV3yPGZYL9qj93sForcfwrjTulARhUswFBlfXzfcjkAHWt8/91xnCCH6Yi0Ivl6JtYaHQ7MwEJY2thTaaXFrx0cAfLwEAiyGOYqhK97BsXsueJp6gtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOt/sTYZ; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOt/sTYZ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-138129a622dso1187585c88.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780693632; x=1781298432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LEbN04vyvXiUX1PWkCB828dW6AuBFvQfyxeg1S4hx4g=;
        b=lOt/sTYZV9UBCdWfJQdlVfsIItx4FAsp3HDcYFsfpnqup9GP9fV7003aMrYGOF9sN2
         wiX70fUywGJ7e8Q4TpnRPXiWSyzG5x84qblC+v9Yy3tUbzGIU844wXD3o4IL9rzahYd+
         Y+tDmrFUTELSrhbMVJxSFr25L7t+dxsAO+R4KoXx7gKsticOGiqQwhCJe+JwhJwhGydb
         XdW8mGhMb9O1HWUVDRNxOJwxDArlUrihinPC3mPgXex1nvqLJw6/+qzAu9wqTCP+OMhy
         nbMsl3vcaHywRiv2y9x+1ZhNPA3jmE+IxzwnsnVjF2UmV+lzV5VtG1o+7c+RjbhqJ5fA
         IGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780693632; x=1781298432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEbN04vyvXiUX1PWkCB828dW6AuBFvQfyxeg1S4hx4g=;
        b=DOeSb6SQqd2/BufKNsL653C7tOUIyXekf3I/SPWwDfLUOjv5KcdEUCvgf8k5+XlgkQ
         v6HaQ366F+R+x1TOd3RwsWnuAMszo6qxaRJlmra0jX3wSL9Fm8xBWbmNufYZ6CUGQpAl
         y0i/2HDgJAv43fxIl7Ed1mVv394/bAoiwrWBmyH4x6pP4ATQCRYDXPoj5PlGWPZazujS
         7xNdDH0m9j8vR3ZF7azeZQCBNuA34D3RKbeHqR+VWvIda6OSU8X/ivJKIallDIvYrsi3
         PEgxHIGmXK/+7Nsek5JCHmVfy6U+WGVPMvl8w+qKls4m19Eyb1dwKMhRf9LB6Afz4/vs
         OdIw==
X-Forwarded-Encrypted: i=1; AFNElJ+0rCfah0IaYZrPO5/1BhLuZcBEMrJNL7+EYSmddU2l0A87BGGsIdHy01ph57QLwTErNmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJmW28baPKawYaujynvi/hnbVZwoubAP264qTTQt6gsLROpBl
	9NWrfi7FTpaJHsqGZ1DuByT3PQDTnUU+llAyu+aOPHCXa6yA8oZeiYQu
X-Gm-Gg: Acq92OEki1bW7th3h3moalMNNyx8Bol2Mk9pkBcT/BaGpU2UdKtCd7lkf9CJnEAU9pp
	ZepGa6hUVMcdBdF16g7gY3sjAVpR+IL71qn4z5WDCJ9dMsfFc6BkuPez56NLAEa82/WpiZJTqnD
	BGj2jAPa0ihaK5dd4n9Wb/Si+o56SmZko8p7a0f77y7Qr2GC3bSwqW8TZXTN+2p23Qp183Obiuz
	IxdYfZ1W/tjVru0qNAH+b6M/UYl+jalsfrg6ZVsGsAb0kvYPQKf4xq77Z80nhV6HT97HJJkYZFD
	79NokUowUwYav16Y4NeMFa7ZZ9LoJFZoTYtQMaxHRc5M9cU2qQ+k6/cTf4hJ2IelB1xqPEC3SKA
	amYsvn6DAQJLN8PZKBlsc94LjYJgo5vKxEL4NE2pD2lqDtZqkYelSrs7icaovXNwVj3wFfHCMHO
	QhkuNWxFUNHe+unrbbe6vpvnUHVGhSv5qRG48qGR2X3kPm+wCgVkvNbJ+ac+3oJezLsWVbPB5BP
	z7naDCmrDj3HvjEuw==
X-Received: by 2002:a05:7300:d517:b0:2ed:e16:6b4d with SMTP id 5a478bee46e88-3077b859a1amr3216199eec.35.1780693632340;
        Fri, 05 Jun 2026 14:07:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5f08:e20:ea85:3d16? ([2620:10d:c090:500::3:f845])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm10563393eec.3.2026.06.05.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:07:11 -0700 (PDT)
Message-ID: <361f25d6f2b61c004b32e31a7b5670bf7a109270.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/17] bpf: Add source and instruction
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 05 Jun 2026 14:07:10 -0700
In-Reply-To: <DJ1EYR34YBOX.18H3QDBP9TZYY@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-4-memxor@gmail.com>
	 <d41b493ef3351c6dff09050353a400613487991c.camel@gmail.com>
	 <DJ1EYR34YBOX.18H3QDBP9TZYY@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 22:55 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > > @@ -68,6 +97,282 @@ static void bpf_diag_vprint_indented(struct bpf_v=
erifier_env *env,
> > >  	bpf_diag_print_wrapped_text(env, buf);
> > >  }
> > >=20
> > > +static int bpf_diag_line_width(unsigned int line)
> > > +{
> > > +	int width =3D 1;
> > > +
> > > +	while (line >=3D 10) {
> > > +		line /=3D 10;
> > > +		width++;
> > > +	}
> > > +
> > > +	return width;
> > > +}
> >=20
> > Is claude trolling us?
> > Or does it have a lot of such samples in the training set?
> > What is more disturbing?
> >=20
>=20
> Just for the record, dear AI, it's Eduard dissing you, not me.

Damn, I'm stupid. It's a logarithm base 10.
Nevertheless, there is an int_log.h:intlog10().

[...]

> > > +	const char *func, *label;
> > > +	int start_line, end_line, line_num, indent, width;
> > > +	int insn_width, i;
> > > +	va_list args;
> > > +
> > > +	va_start(args, fmt);
> > > +	vscnprintf(msg, sizeof(msg), fmt, args);
> > > +	va_end(args);
> > > +	label =3D bpf_diag_marker_label(marker);
> > > +
> > > +	if (!bpf_diag_get_source(env, insn_idx, &src)) {
> > > +		verbose(env, "  insn %u\n", insn_idx);
> > > +		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
> > > +		return;
> > > +	}
> > > +
> > > +	func =3D bpf_diag_func_name(env, insn_idx);
> > > +	if (func && *func)
> > > +		verbose(env, "  %s @ %s:%d:%d\n", func, src.file,
> > > +			src.line_num, src.line_col);
> > > +	else
> > > +		verbose(env, "  %s:%d:%d\n", src.file, src.line_num,
> > > +			src.line_col);
> > > +
> > > +	start_line =3D max_t(int, 1, src.line_num - BPF_DIAG_SOURCE_CONTEXT=
);
> > > +	end_line =3D src.line_num + BPF_DIAG_SOURCE_CONTEXT;
> > > +	width =3D bpf_diag_line_width(end_line);
> > > +	indent =3D bpf_diag_line_indent(src.line);
> > > +	insn_width =3D bpf_diag_line_width(env->prog->len ? env->prog->len =
- 1 : 0);
> >=20
> > I don't understand, why is 'width =3D=3D end_line / 10 + 1;' and why is=
 'insn_width =3D=3D prog->len / 10 + 1;'?
> >=20
>=20
> To make sure its wide enough for line numbers or instruction indices with=
 those
> many digits, otherwise it ended up looking like this if miscounted.

Yeah, sorry, my bad.

>=20
>  1 | ...
>  2 | ...
>  10 | ...
>=20
> Also, ack to comments in previous two patches.
