Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792521739;
	b=hOJ/feTTwzNcPemGjRBdAczN9YVre0J5ncz+FMGpGdwHpmnuP1x2IhhxdEb10mNfEgjY
	 sAaAQA69KVguAxyWUxkOOZprETeRw9jEYocIfK/np6EjMLkejjpZnaaWUwL2I5Ubrdvco
	 LFHBuelv5p5ztlXNvkie3nOaUzaR+kFHqCoJH5lGU49tySiwHz3ihoBK4BreAL/PMlgHl
	 /IHF+HdR7n0Q0bVsx/ktW6aTFTQbV4uZHigXwTbvugPrErGA/lsdYprU+AISWeGuhy+zU
	 X9vsxS/H4V6qIoqjUX4VNqdWJ8ZSFAE+zRlOFNXoAfeYexX8byP1wf5DUbGL4/oLSjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521739;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jUtbVh0o2LJHbMc08tIXjm+HG6ZwcUXAt7C4o4W0peQ=;
	b=q+ro9XTO1620G6AtOeItz7W2fgQkrtZnCMQXJfPjtDzF0c6r7faLmi2DSK8VFBFNpbWK
	 YQh9t4cIPxT54CAKB1Lnj5u30zJn3hdbUqADVurNZwY1J5xTY7UkJRmA+EfL1qA0GlroM
	 7/80+6GHghnzm2p3iIaxv1cbZhAMDbtTx2XSWV6emzYhEVbY6otkc+rqGpLce1lpIpW0L
	 QUAI3BBtPhyIIVS6k94+g2+xgr2e/u74+IUeW08zHjD+rb18dl6G+nqDPqkdGXiCH02KR
	 xl0HXBltodP6XLmxv+CCswTyCvhmFycW3sCEViGaci1dX9KqZBLYVZhJuKNLRv6mdBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=bPWErbvq;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=kJPrGhzh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9575606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9575606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=bPWErbvq;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=kJPrGhzh
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KIcQG4889890
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=jUtbVh0o2LJHbMc08tIXjm+HG6ZwcUXAt7C4o4W0peQ=; b=bPWE
	rbvqW1iU8rtZ0EZrtlNB3aLjK4HmA4PaxEZPDnW5R0dlUfF05Q4Uiqiiw6K/ZqGg
	zMTpGScNjjskiIQWthren6uYqgD2tz+pcDt9JTTkvasfAMCzNQDrfSiOcCvAkStM
	uxvfawOCqGz5MKsju2sSqULb8j7Q76lgofgvPoLsb0QRjajJ2MvgEHyAM2ZDtQg3
	31Xfu8SVIjQA11OApOISMwuTklF+8iJgHyQxX4u3tPZCOXQ6jqQeJveDJa4qURUc
	d9rUKzCnTalVNtpmwBJUM9dOZKSl6YRhDyOfQ2G9UNN9sJz69g0ZD+/p/MLIeC8D
	RBvPB0HgNDcs26Ko+A==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hdw6uubev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:42:12 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0c6e715e2so41659737b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521731; cv=none;
        d=google.com; s=arc-20260327;
        b=pjzWdrKMgIANc/AhY5LR/l56b5sRSdiIystAGBVYJzGIuk5hyJQGvMR2nYfTUlQE8Y
         XPGLbsnPc5ZYzt/XBcUC8WWY4NLrex3diE3KuCRthDJpXTcaB4R/YMnEu4bqgQnpUGjt
         8IiRgZ8eRjSm+djGgrX9ItvZKDnLQMEhGCB6pJvwKMuelZ7K11NYr8/kZyndcuhLl3/R
         40CEHYWfyDY+A65fRZhQLuN0LkEvZT3zawYaIKqPgF8L4eLKCv2s8YtIRjcpisVEJy+H
         JsiyYZDAJ8uTlNmB0dQ5tADnsKu51fcQ+mwCGr/TkOxSIceCRPKAJdLYF7BkZ3EIoV2G
         xyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUtbVh0o2LJHbMc08tIXjm+HG6ZwcUXAt7C4o4W0peQ=;
        fh=r8kaHLjg88S7A9/bKt3YvVHt52fuZuJsDGk+uonfHrc=;
        b=FuViJ4ZhuUHcDrXe78hP+ZQa1+Ys1K1C3H0bU1ox5K3W5WamLBbLALOPwhsDqMcvzo
         iklhlT1sq3/caDAeyGiqvh+8G4YsfHT39kYXKVWDEtzX7GtwDXVo3CXVVFWU/X6Z2nDj
         MPSoldRFMX1J+xWJh5Pmt+KtsVhJAu0bKIzKONREpvxjR7zPHicUobtVADuGH4WvUr3J
         IqWd/Y+aPVV1ndxZulwQb5l+PMX9o+08RTZPVkAoscAgBH27kOKEW3Vaiz20n4DaU5BT
         hN+AVqro3PgnnPdOLrb0olLa6C9/+TYXyiB/qJv3ws4s1UmqYusH0KaQ5YBmmkr4FAIg
         /oVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1792521731; x=1793126531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUtbVh0o2LJHbMc08tIXjm+HG6ZwcUXAt7C4o4W0peQ=;
        b=kJPrGhzh0Uyf6mJdwgfooecWM6YaWLthMIcsg6DdGL1Rh4NBAALmuStOgld8Rjgy3h
         gFlBoxMsY0r9jNVTxB6rYVv84zuzQf6jo5kpjNI30MNGwI6VGnhSJUoPwTMhjoVlxv8S
         LgX2NTkJ8SJMvCU/UrKUk08cuA9ZRtJ7uoL7b7KFPeF7K4isfOO/N0QayTuTNB+cebFO
         YoUCa7lyd+0JyXNvixtzM6zvG4ZsPCQ0Iq7e9MJqBV9yyOkbkudNFSijOuYRi77wyLpb
         WhejsknAhzNkTmGXkWMKdw77RG0nBKADyuy8FaXJaZkl6LZfeng4vud1hnJ4pNmx79j/
         rv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521731; x=1793126531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUtbVh0o2LJHbMc08tIXjm+HG6ZwcUXAt7C4o4W0peQ=;
        b=IlqfvM6YbxvDM4Nk0Dqm7X4zPber3IVPV3PdGVlUL4Z61+EePd9dLurJ3L025VntR8
         k9iKh8DmCXwYEqED0HUZsOREZcFQASnaQDSfkRxIjCsK5iysrKRUNw6AXMmb4O/xZOPQ
         Q+yQq+c+gdkSnHTzA9D6lkvaERRB7Omd1IJz4yCfigGnZlfBGf6cO2qJAG24odkoNuCB
         j7EFAC7Qm2HqEMAWMqk15q+oPbHiZnqPPvDrmxWzVc3T+HhtRuJjMrioo/jB++Yy9Hjj
         pCLjINA7PmKMTYqkzKB7giYHX6N+/o8RAyv3soqdRB/yDUANxtvpvoJ4SnOpO/IRFScU
         owSw==
X-Forwarded-Encrypted: i=1; AKwUvBykQmSArfVwWXYcR784/2elSBYlwRYOF3NM3Go9xXtmvprCdzA7t0aw0xTyES3SVNhPf3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+i+yQaSvkDgqp1ffNGVF8hbZa71UnKtRl1xZnwdhvuMVKas2i
	z6nM8pXIZGL/oNJ+R0naPrQuLRXHB+ZWQR2R/7S0L/8dIwt2dHjmNGa1mcy75gyduD/6SXCSnJg
	J/OR0om02dOBZ90MoPWVnXvOFmZ16aq822dpgTFwZrZeZIPpm3s0UV3N2hg+GRMXFdnAvrsawaW
	gfhXh1VxXHiPB91Ke65NK3rxL6lhzL3HUdFoZp
X-Gm-Gg: AYBFou0+TDBUrLP1Gvkp4S0BEbV9LGyV/dq3sGpQR/lLvk1JjlCbwN2J4SeBNM6Piug
	LkTDqItO4RAPy/0tBWuJoURk4mVOlLCvUwnhTXFM25aBve978Y4kuVfNEpOFhExkAn/YQPNOUMX
	GpIa7jt1e4DtpqrNU/p8/AQkC3kX5kH5Mh0W1+k+0a+jITWy5o+H2EVax6
X-Received: by 2002:a05:690e:458a:20b0:679:9b34:a2d0 with SMTP id 956f58d0204a3-67a0e04c052mr35868d50.18.1792521731422;
        Tue, 20 Oct 2026 11:42:11 -0700 (PDT)
X-Received: by 2002:a05:690e:458a:20b0:679:9b34:a2d0 with SMTP id
 956f58d0204a3-67a0e04c052mr35857d50.18.1792521730753; Tue, 20 Oct 2026
 11:42:10 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-8-andrey.grodzovsky@crowdstrike.com>
 <sashiko-outbox-166685@kernel.org> <CAOu3gNj7fYONFo2-UqcBVv5Uk2=d4Cw=0fvQvLPCwiDA6zc3Wg@mail.gmail.com>
 <CAEf4BzbxEBC7CGDTZF_3nvupgB4QGcV_k0e1mo5Zjm-g2nBWsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbxEBC7CGDTZF_3nvupgB4QGcV_k0e1mo5Zjm-g2nBWsQ@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 20 Oct 2026 14:41:59 -0400
X-Gm-Features: AclHuK_WP2x-Ao-uFvy9C4kOMSC1LmRigf4JRrtOW4zkWzOcYDHv3TKhJn85JD8
Message-ID: <CAOu3gNjphM=_y+L0x+oHdw6AXRjQ9_KGfuLzqtb4CPFqO3n78w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NCBTYWx0ZWRfX8oyJMocvMxF+
 IFVuEjrgSx+JcmJmzCUy66AaHghKKl4X5QwB1VLH4I0FVeQuTz5S9QBdATpwxpbo+xT8G+Kz2rb
 oeVwTAJPatA25zPkpllOoapX7XQNRffyv3UZQnoGXLOD/93OR6lN
X-Proofpoint-ORIG-GUID: 5G7sNygq_s6EHZa6GLeZ7IMAYdSFdPwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NCBTYWx0ZWRfX+Sa/wD+6vDOe
 UrqnPEVUJHhL1gThij76kgfh2juUUAsbtFZ3prLxfJBEgkRJDVGUbgnMOtRlT8wPZ0ZyMYuOtkO
 BzWcTFOhRsyTUh7wLC7vBIuwAcZlRtlketDPkrOYu6sLy1vW+9gH+RmJedeuc6CEdv6HZbjVZV7
 bAFjAfUq4f9pnMs+fI+hX6EGDvEmGoEBN1ohU6bHVkipu02v5oZ+bNja6zh1cKS2r0CaxQ5JP66
 udwRK4U+EfWCvKNTRatSoUtY79Q+06fakXU0wWPwFKcuBbLwiKhMQFMgW7MZYC6Tl6YlABQo2o+
 kn9ajYZK3fPA6XBxgL08xqYnPreqaHdDdLm68RKvOud4IfrLZKFDyUFFyO1JQEhd+ozu3ZFzdxo
 PYzvCvgxShvkMLPmoc3XJbqmt6F+QOoHI0jflHFWZC7qbNu5lMUbEd7HiUM0dhf5Ex6S4PdwuCs
 eu62XpHy58xor4vDuSQ==
X-Proofpoint-GUID: 5G7sNygq_s6EHZa6GLeZ7IMAYdSFdPwH
X-Authority-Analysis: v=2.4 cv=ZbuIpcVA c=1 sm=1 tr=0 ts=6ad7b604 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=c92rfblmAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=8S6rCJZtphWnspf-Qy4A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11941
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200074

On Tue, Oct 20, 2026 at 2:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 19, 2026 at 7:53=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Sat, Oct 10, 2026 at 11:08=E2=80=AFAM <sashiko-bot@kernel.org> wrote=
:
> > >
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [Medium] bpf: veristat uninitialized memory read of log buffer on e=
arly load failure
> > > - [Low] bpf: veristat skips cleanup and info retrieval when BPF progr=
am fd is 0
> > > --
> > >
> > > commit 9ac34aec88e7eee9b39c53e8055bc5989345ce5b
> > > Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > > Subject: selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MA=
NUAL
> > >
> > > This commit updates the veristat utility to verify programs using
> > > BPF_PROG_LOAD_STRATEGY_MANUAL alongside bpf_program__load() and
> > > bpf_program__unload(). It replaces the previous use of bpf_program__c=
lone(),
> > > ensuring RODATA maps are properly bound during verification and subse=
quently
> > > dropped upon unload.
> > >
> > > > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing=
/selftests/bpf/veristat.c
> > > > index 9cfc9b4b41c12..0cd19b59037f6 100644
> > > > --- a/tools/testing/selftests/bpf/veristat.c
> > > > +++ b/tools/testing/selftests/bpf/veristat.c
> > > [ ... ]
> > > > @@ -1726,18 +1725,15 @@ static int process_prog(const char *filenam=
e, struct bpf_object *obj, struct bpf
> > > >       if (env.force_reg_invariants)
> > > >               bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANT=
S);
> > > >
> > > > -     opts.log_buf =3D buf;
> > > > -     opts.log_size =3D buf_sz;
> > > > -     opts.log_level =3D log_level;
> > > > +     bpf_program__set_log_buf(prog, buf, buf_sz);
> > > > +     bpf_program__set_log_level(prog, log_level);
> > > >
> > > >       cgroup_err =3D reset_stat_cgroup();
> > > >       mem_peak_a =3D cgroup_memory_peak();
> > > > -     fd =3D bpf_program__clone(prog, &opts);
> > > > -     if (fd < 0) {
> > > > -             err =3D fd;
> > > > -             if (env.verbose)
> > > > -                     fprintf(stderr, "Failed to load program %s %d=
\n", prog_name, err);
> > > > -     }
> > > > +     err =3D bpf_program__load(prog);
> > >
> > > [Severity: Medium]
> > > If bpf_program__load() returns an early error (e.g. from libbpf witho=
ut
> > > calling the kernel), could the dynamically allocated buf remain
> > > uninitialized?
> > >
> > > When env.verbose or env.top_src_lines > 0 is set, buf is allocated
> > > via malloc() but the fallback initialization only null-terminates the
> > > static array:
> > >
> > >         if (env.verbose || env.top_src_lines > 0) {
> > >                 buf =3D malloc(buf_sz);
> > >         ...
> > >         verif_log_buf[0] =3D '\0';
> > >
> > > If bpf_program__load() returns early without modifying the buffer,
> > > parse_verif_log(buf, ...) will read this uninitialized memory. Could
> > > buf[0] =3D '\0' be set directly on buf before loading?
> > >
> >
> > While this is a true observation, it seems to me this exact scenario
> > would also happen in the `clone` case, so it looks like a pre-existing
> > issue.
> >
> > > > +     fd =3D err =3D=3D 0 ? bpf_program__fd(prog) : -1;
> > >
> > > [Severity: Low]
> > > If standard input is closed, can bpf_program__load() assign file desc=
riptor
> > > 0 to the loaded program?
> > >
> > > If fd 0 is assigned, later checks will explicitly skip handling it:
> > >
> > >         if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =
=3D=3D 0)
> > >
> > > This causes the program's JIT statistics to be skipped. Should this c=
heck
> > > test for fd >=3D 0 instead of fd > 0?
> >
> > Same as above , I thiink the issue was pre-existing.
> >
> > >
> > > > +     if (err && env.verbose)
> > > > +             fprintf(stderr, "Failed to load program %s %d\n", pro=
g_name, err);
> > > >       mem_peak_b =3D cgroup_memory_peak();
> > > >       if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> > > >               mem_peak =3D mem_peak_b - mem_peak_a;
> > > [ ... ]
> > > > @@ -1774,7 +1770,7 @@ static int process_prog(const char *filename,=
 struct bpf_object *obj, struct bpf
> > > >       if (verif_log_buf !=3D buf)
> > > >               free(buf);
> > > >       if (fd > 0)
> > > > -             close(fd);
> > > > +             bpf_program__unload(prog);
> > >
> > > [Severity: Low]
> > > Similar to the issue above, if fd is 0, will this prevent the program=
 from
> > > being immediately unloaded and leave it in the kernel until the entir=
e
> > > BPF object is closed?
> > >
> > > Should this check also use if (fd >=3D 0) to ensure cleanup occurs?
> > >
> > > >       return 0;
> > > >  }
> >
> > To summarize, I agree all the 3 issues definitely need to be addressed
> > and I am happy to fix it. I just don't know if it should be as a part
> > of this patch-set or a standalone fix?
> >
>
> let's just land what you have, don't add fixes for preexisting issue
> to your patch set

Understood!

Thanks.
Andrey

>
>
> >
> > Andrey
> >
> > >
> > > --
> > > Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.=
dev/*/patchset/20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com?pa=
rt=3D7__;Iw!!BmdzS3_lV9HdKG8!3il3wicS8Eiw2ogONUagDMIrsqcvvmLZ1xXNrquJMEVXEJ=
r85kqsNp4CNFasNUc417QJ6t73GShkLS7-x-efgKPJp1HzLOdaJg$
> >
