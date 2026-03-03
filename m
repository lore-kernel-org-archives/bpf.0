Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5953264C8
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557026; cv=pass; b=GcJIFpL08I1a8WRQOBnyQ3g5HErwUCYJTl+EcC1//0ISKGdLQskAM1YpCLumGV88tSvl4wR/IvwC6EDiafbwocbxnmI66nn0EU8Iz+wiABdAuiycIizZH1cSVb9UeWkq4OXNpA9z1wqQC3ox6pAOX7NMYXdpATlXNjw5SRMu4Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557026; c=relaxed/simple;
	bh=IEGVLKkyRX2CmiVfdaYDuDbH8C7Ff9yzlnH/vBjXtYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmhqiutHCTOnZWq1eTPj7hW9w5BfxB7A1rYME3h5pIcBl3EoOGfh2Xeo3TRU+TK1tvHZ2lhntpMbOzHDOvEDMHGm+gGfj0TeqX/yuLiNxDZkqJelI21U/I2xLZyJzce61c4C4N3qXcakac/iq5a6ujiGXu/RDaiemIKLe/Mxtik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj9zqURz; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj9zqURz"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4398f8e2837so5063175f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 08:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772557023; cv=none;
        d=google.com; s=arc-20240605;
        b=euTwM7hXhqo+fM2gNYqDMRN9RT4tVi8WYrnR51/2W0B0DDv6RZFyKZwTxmI4zyePoL
         MXyZdQA9QpAtwe30eBhDPlgRFz0YKLjyKqUHUeSW0V3nOpBh/yevTM7+yvSnz3Im3e05
         K25Ve5LYTWLacOFHn+MRm/dKk9cnFOAI8I1BeM5jdOuLtiZ5gXg4sS+vxy9ZlVIRvpWC
         okwNCAXWeXX8M6rpkjG1/sR4JnaXw7zht3iT9WucOqFcG7Bv82tQBsZZ/98ifvkZlC6e
         s48JngkW63r0YB+V0Crj7Pe/V/tUGolrSg5zt5bq7gQGsP2zIk1oUidXfkv+uoulUUtq
         Fvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmVVCwSx9gOlnl+9iTJ9vMHKCvwk//C3zJgzS58JBmI=;
        fh=IFZPqXvBOZv/f+ZqyqSVNBBhDUbodw1kAXKkrCZdEtk=;
        b=HWWjLAaeF4LT7c61DwFAepHxXQHTtEd8dO92L3YllneVtEqBYCqw/kinE4BIQA96B+
         VTbYo4N9oyVJRKu+6Na0G78/5f7cvg9VRgzE8vQ6oQQkxa3w9PhVGP5pKJjU2rqWi6HG
         J+EclRTeo57NcSvoXHravtm/eOsyco+Lx3REew4Lz72z7aLzKJEMJ/1Pzz5Gb0zA3cn7
         piOu3cGJNRCYte7N1v3nGQqIHTt1ajKVq0EUG84VRlgq/Z86//3ha4knY6a9O1f6qttL
         ynj5OzyYNGJBrhfWgfIUzHZ00RW7y/5E2hT2G0xVywd1i2ohpZCoVwS7hxHHCU+g2Y38
         dDIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772557023; x=1773161823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmVVCwSx9gOlnl+9iTJ9vMHKCvwk//C3zJgzS58JBmI=;
        b=Lj9zqURzNEwtfWqsR6wAOon+6hxNt4Y/9m5ZHCCM5+0J3X35H1c6xIf9a0XKRVXJRg
         yA8pm0wdvIDcTWwz3abpmH582Sxp7cfrBEtYnyeOlub+8faqYZNVaNOI/SR6QQWbDziu
         eAohHWIPPA4hpUFAYId96u5AqawwtUgkFNQOtroQFeqMCrzLTijER2H8YWdA3fGMikzY
         5/n/eT3SbupvRy/D7hLgLaqgxTwfhIhK5NKA38qbuQ4DT5eYUQY6SoDffytj7OEwHEQK
         +4RM6ApZjxFmfon4DrtKU0BP5f8S0eqmsZUdYeXv1Ffx04eNWnIVDlDGTNo2Hv3h4eKw
         vG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557023; x=1773161823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmVVCwSx9gOlnl+9iTJ9vMHKCvwk//C3zJgzS58JBmI=;
        b=BZ6H4TKHkMHc9qK06KBSBz0hCzll+v6k846FEtxyqhI9GvtSApvujL1U9hopHLPGe9
         RZOeXd3mNY6JwOyzxdFhpz2+HxooYmvyeNCJSpLfPCnRFl1mLj4AdBENl6raVUpvsk8v
         w9rZq8A5y8TbKYGzB4HVWefkkBAP/dMo7tc4OaVaGUDXI+U3Gu6QMw0EyRMpD9XWHxUC
         Xa1Gw/zMBUhf3+a/1vu9sd8pJEAfoaRIKqqdB7mQjYEJFF/RRRAm0M81gnFcW4nFQnsF
         J5RMZHZLDRsmH9mYLM0C8lw9CoiPpqQDLxuQ9DBXlfDMehdqs2dlBqZaZ5jdbQSg6PTX
         pueA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqGQmx52Lo6DP3j+VbeYVQg90+xaKN2gqb9m+gSj5wdwlRYdooEELG52wTjJJhSxEfFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPvxMCgd5EdWcKBvmzM4/J7lWy/nDy1jFFdsxFAwKiJYikrx9P
	8XMZrMNj7rTzRGxdMtFkwGq9PonpsQNUJDJVipChco5UcEnrZA1MeD90jymE/PDl9GyIp7p8Iam
	qHaMfcADdNw1iq1jPYb7EdalYmeyAvD4=
X-Gm-Gg: ATEYQzx6oqPX7aeZv5gOsAhLzVfzeV7E+AFjz7qywD7N/O2ZqPbG0U15IWRhHoLu5a7
	hCvtna6Mp0Gk3txAXPPyN3wQieJBgqOdMQko1RcmizAHQHT6TcQilAtpJk16nR6WmyEivDYHyPm
	F3hm6OvZkKu6wGrS5IfzvTekZlSkkYGLueRbCm+I79u22ARkxTmyma2rWegpuimBo+pugANKT8/
	eWWbmaLPLHoi+ictW5lxoGWWaprz95BvmY4JGbd40IJD6kjvAoCkCdIkADej4cwhHsZTuo2PrZ+
	Gq3JfGnF7DwxsSCOTCKi3PQIX2oKQgpoAmFvWyMXqfQcbz7nfnDxnbEv+is1sXNBAXxj9GuuALM
	XoRZ7/+nhen07tauTSk9bVBEBjw==
X-Received: by 2002:a05:6000:238a:b0:439:c550:d92a with SMTP id
 ffacd0b85a97d-439c550d9d5mr1891155f8f.53.1772557022817; Tue, 03 Mar 2026
 08:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302114059.3697879-5-alan.maguire@oracle.com> <81e5bdca3b0c4eb5703b200781e30fa14ac256ba8042bb27dac98d28e743b7de@mail.kernel.org>
In-Reply-To: <81e5bdca3b0c4eb5703b200781e30fa14ac256ba8042bb27dac98d28e743b7de@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 08:56:51 -0800
X-Gm-Features: AaiRm533ZWMH1jUzT31LWneje3U3H1DGZ53i3enu89tT9WS4SvRK1TKsMHFeFOs
Message-ID: <CAADnVQLSndJcV1wdBLZ8NP5_-do4cyJeQEGG+o03mJh3tPWi7A@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 4/8] libbpf: Add layout encoding support
To: bot+bpf-ci@kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:18=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 9f4d1bd73b4d..e87003711543 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > @@ -1186,12 +1229,26 @@ static struct btf *btf_new_empty(struct btf *ba=
se_btf)
> >
> >  struct btf *btf__new_empty(void)
> >  {
> > -     return libbpf_ptr(btf_new_empty(NULL));
> > +     LIBBPF_OPTS(btf_new_opts, opts);
> > +
> > +     return libbpf_ptr(btf_new_empty(&opts));
> >  }
>
> This isn't a bug, but Eduard Zingerman noted in v8 review that
> btf_new_empty(NULL) should work fine because OPTS_GET already
> handles NULL opts by returning default values. The LIBBPF_OPTS
> wrapper could be simplified back to just passing NULL here.
>
> https://lore.kernel.org/bpf/1456370aa292410bdda4bff85bead8e091675f4c.came=
l@gmail.com/

Agree with Eduard here. Why change it?

Also AI review on patch 6 makes sense too.
Pls respin.

pw-bot: cr
