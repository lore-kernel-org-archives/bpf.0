Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792F42DFF5
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952600; cv=pass; b=t+GQNmG2ikt6DUIu/214IqPfnFfWiERpykRM2F3Ls9PLupxa65/zdTPeK55FPE7+cm4Z5fxQjG4+th3Nbjj99fLhXD1uNYmZvUC1/bZspHxDxXwp11ife4e1Sjaultu8RGsE8dFWIa/OFfke0pBx7RzXeDmzXF9gIt4Nd86fOM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952600; c=relaxed/simple;
	bh=NZwhCQzuNwR93eVgivOgdbv59Ot1fi3ozfXk+zFBRE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8gCmAl0rxPX+I1VEDhKCFba+idNty2uSTp5so0URQkfA/4EX9LGImMSp0OY8vWlszhSdRSyZJ+J0A/RmdXr76oKlKdEKbxr37wI1UzSeBhXPQ6luPS8/CozJffqeMUOkSvadeMguggdhhUa5H+/DwGzJzCa+YTynyV4bmyZOOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YxTuKceW; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=LNBmsDhL; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YxTuKceW";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="LNBmsDhL"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCAWEL1070620
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=8VG8L95Re9xUzZH9ed/HsdnWDFV+pJA6I+pHtnKXZ6o=; b=YxTu
	KceW54NW5/nomQqV7R4+YWbqNueA1S1ev9YVYLCBYkXlBO3pi5nef6LcLhYgqu8O
	P10Oe7Huz7zpVGwv90XjVTcwfILVE3SUrYfL6lpiMP1nGXckMifLvkAYMmKQUh6J
	LauZqnpqX70NP2A15Gg6p5gz3e/TLjE1o3MxDzHfEW9UoNe64gcGP0RoEu7q+BcU
	/eCido8xqRkJwWzAXoYs0sMYtNoMGJw3SkB3pumhsV5/YVF2H36uVGrPvn51XqGg
	iMcokTgGQGfEgyIQHjZvtg3RX45BOAXGiX7o9ab6uPnRvzzJsKhmBuKUL8ukFjB1
	A2fzL/1r57MmtAo8Vg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fc23abs26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:56:27 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81eb83325b5so1618967b3.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 06:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783950987; cv=none;
        d=google.com; s=arc-20260327;
        b=W0b7uoZhq6SMc3v1RQXJmH369XUjd4HPQLoxFdTpFRIzI9voFEpYfKsiz06ItlAWih
         5BIpEEDm3syIMRrl/hpB6qcSGbZ41w01n/BxgYvpghnmPfDCh1nWaJSZ7pa/AadMt7+u
         Sx70Es/1yddc6YsG0j9bn5SAfF0yOwCSP0ZrzooKEDxcgR655db94LmCc1MvNi3O6aO5
         b8aTjIVHHR54B8Ioo5pOoRWrOCEYh9TUAHYL/n4YkrV9AYV70ssAvPG0nGlF/ShyqYWS
         ADpT8cads6daFkvROk39iF9r0CC6+lIEWiSTJmxH/Nj9+SQuLHY8Phs4rH3CP1sYkOzm
         LKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8VG8L95Re9xUzZH9ed/HsdnWDFV+pJA6I+pHtnKXZ6o=;
        fh=/T1mQyQYEvsYAUPDrUlcfC5719jpKbo/XmBxspmxCHs=;
        b=b0MYA7PtD0fZTLR0lslV4orhiyVCR1tQrMrmV3bQok/EbGlVZc3xzmKIp27KP6EwkK
         fsT2Fee/akJqMJRSzivEjczYHjr1LMSNCl6I+SNnyzz7FIvzYKExV18FpK259FctmSLD
         mJ8uY3LG5t3ShsMMYF5wN8x64KnRJ/ZwkZI0MLnmGv/IBQIWXTfKVPXcg8fn31qDRuro
         W072kFaZCPNR2xtSUc2h06xbCY0+KrazIoiE7DKdGtr3rF6IEHBjj2wXCn2EICZyws58
         dVKwGHX3JzBCWS5mr8nY86xD5yASS+ykrQ7saBU9lmqThthKkG1QS4QYr7dWaIUYZLUu
         NOkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1783950987; x=1784555787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8VG8L95Re9xUzZH9ed/HsdnWDFV+pJA6I+pHtnKXZ6o=;
        b=LNBmsDhLQxb44ixfPzksFr4x+aO/dgkQ6xM5bPO64WM5wheFApULHmKa4GCDucmtpe
         9x1quSFVdFiYr0lyO6DYU3r8j5u7Sevpk2qCYz8OFvHNe+di6V7Ecg4J67wIpe9LNit/
         Fuci/TCw92pRuzxwV/cfTDuySWZkbNnuylBGDtHXBbi1oQiS7ZGRoFZU1LIRzJidQUrj
         sCHscWqHb2G912yvzln7nwoPOUhXywlbj/TdBrocioCyxdB4MtV2W80MQvij6+8i6q/t
         v/12gdiDWBzBIOAEjJin6mt+tOLiW7YMp7g1qCTUPhcrQde8ulKWLZnvXg4e/o9xVXfB
         XYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950987; x=1784555787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VG8L95Re9xUzZH9ed/HsdnWDFV+pJA6I+pHtnKXZ6o=;
        b=kF/swvaN1nUE/hJPpxZKI9D/zTlMjdezDdmwkj5JWfKNqJdDG3iZEqBWGKsJpRwboQ
         YfsfBj5SKjLMyyXq2Sx9sjkL37L+NzV285J4GqTXCZfC3oBQvOxx0X4EFBKTYU9CpMLp
         wuds/cQW069yd+OT3ZsC3KdYbOuf52losvPSjUFdPPn/vKdhBzDycvPLV+zN4BLFmcnk
         P+v7nOpZdZ53KuBdWvbSYjzRnI0SRu/Kay9WuRYQp/6WXWRI9oa8wMUrWxNM+myK5xmW
         f14qtvuYMYVqlenExgYomnz2++8TZvOA450eQuUl7LsjPoKPL2q4SMvQe5147+04cTa6
         x8EQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgnpUfOM3ivDO0ZtdTvp8n9D0AUwcXcblyC6qOiJ51bj4dIs5H9h3ZI1p6G1z/oOedVAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIkcgXegG8Hynrj1Qb2OEmrfKmMXyI0Oe2YZ9CY7zHG1eG9Hm
	rNjzmWWJCX7OwXSQ7sN8byDsRtYjvq34IsG0M+J5tIp04ryiqxnz/PIEcZiuzOtQ3Oj0JUDvdEs
	VQma5cLleyeX9+2OaS2fq4tZ3e6bzIjrSQKr1JcvLrJQmtzveUVzIez39piMAaq38fJDo5EyVCB
	j+Iuasn5jT/mDlvKUt0Tay3oBbQTFy
X-Gm-Gg: AfdE7cn14cEbw8nFVJRQ6p83TI5hYNlvMiS6sfhNmhitjp/wz5qeEsDcuggxzmSiMdk
	r1BxvFKyyKS4l7jx0Jx5eT4usHhwJYjJEnHsLvnFwQ02BXq8ygoACGJOWvi7IXQXyROfn/UIWRG
	01py3AgcqC7vHrJr0q0abGpXxJQ57d2Nkp1gNF8UWnL3LDj8rDT6ONcAEA7MNaMNhXMfRchQ==
X-Received: by 2002:a05:690c:688e:b0:81c:8370:fa62 with SMTP id 00721157ae682-81e9010c677mr71742707b3.41.1783950987357;
        Mon, 13 Jul 2026 06:56:27 -0700 (PDT)
X-Received: by 2002:a05:690c:688e:b0:81c:8370:fa62 with SMTP id
 00721157ae682-81e9010c677mr71742487b3.41.1783950986698; Mon, 13 Jul 2026
 06:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com>
 <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com>
 <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com> <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 13 Jul 2026 09:56:15 -0400
X-Gm-Features: AUfX_mxAS1IJFYan_n5rHFwG4_uTUSR2CIAglUnrU6hyC5XcKqDeV7GMvcTvNjU
Message-ID: <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: VTeewVqvgzvwVE-GzOx82mrzj5hpi5sl
X-Proofpoint-ORIG-GUID: VTeewVqvgzvwVE-GzOx82mrzj5hpi5sl
X-Authority-Analysis: v=2.4 cv=V8VNF+ni c=1 sm=1 tr=0 ts=6a54ee8b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=4Zh9gSnVrSdOt92HVi0A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NSBTYWx0ZWRfX5U98OZNQyKHK
 +N9AaSJV7zSxAj+OGQdChk5IFtxnOet6mv/naKz+SGscMO9pbIE499RaHDgRuow8W7+K9tozsEh
 +ctAGRWKhT4Wkw2eV4a4Dk1MQUKPNcAcUWJrJOfBTuYHlEr9J65HetQ95s0ifU5o2GFZREHcENZ
 4fZ8vkEVbopTySTNANkHW0+EFPzBwpb0B7nsAI6iDCfU2iwoIB3jlW0usCDDMusaQ90bTKilAqN
 yyM2BLrMfBFrwlv+4Y6ICLVG1Hszh3rOH+ze2K6QOpiu5CIpbKEZdQaDTszrPkvqzmtyaGL/Evr
 zoFutGdmLqwkX9sa+KSuwU58pBju6QgQ9fg8j0TmeHqijmUHmH3evLJp3amz1SgS6sKJjmwQjVf
 IVMXptMN2kcTdgtjf8grR8LdXq++8J9SDEQCMAZ3SduVpyV9HDIQZhPDavfYu/IbE3hYsYE195m
 kPFvOPBOnMyeGClvOHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NSBTYWx0ZWRfX9pNA9AB5cOjM
 xdAcA7aUzQxu6EVdiUXUyk77i9yunnZTCirlWZj7OlCpMGwTn7RlOur2LP9zJeBvyB9xy8/yB/Q
 cevVW1cpPiOhKUik2rJz0MV8LGh/kdwque6Pb+RskKY6q4JXqfGK
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11846
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130145

On Fri, Jul 10, 2026 at 6:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 8, 2026 at 1:58=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Mon, Mar 16, 2026 at 10:23=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 6:52=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 6, 2026 at 9:22=E2=80=AFAM Andrey Grodzovsky
> > > > <andrey.grodzovsky@crowdstrike.com> wrote:
> > > > >
> > > > > Mykyta and Andrii Hi!
> > > > >
> > > > > We're evaluating the bpf_object__prepare() +
> > > > > bpf_program__clone() API for use in a production BPF
> > > > > application that manages hundreds of BPF programs with
> > > > > selective (dynamic) loading =E2=80=94 some programs are loaded at
> > > > > startup, others loaded/unloaded at runtime based on feature
> > > > > configuration.
> > > > >
> > > > > We have a few questions about the intended usage and
> > > > > potential extensions of this API:
> > > > >
> > > > > 1. Compatibility with bpf_object__load() and object state
> > > > >
> > > > > After bpf_object__prepare(), the object is in OBJ_PREPARED
> > > > > state. Several libbpf APIs (e.g., bpf_program__set_type())
> > > > > gate on OBJ_LOADED state.
> > > > >
> > > > > Is there a recommended way to transition the object to
> > > > > OBJ_LOADED after cloning all desired programs? For example,
> > > > > would a bpf_object__finalize() or similar API that runs
> > > > > post_load_cleanup() and sets OBJ_LOADED be in scope? This
> > > > > would allow users to benefit from prepare() + clone() for
> > > > > selective loading while keeping the object in a state that
> > > > > the rest of libbpf expects. Or, is the new API not intended
> > > > > to work with bpf_object in the first place ?
> > > >
> > > > exactly, it's not. It's an escape hatch out of bpf_object into
> > > > low-level FD, it was never designed to produce something that shoul=
d
> > > > be put back into bpf_object. This clone stuff if for generic low-le=
vel
> > > > tooling like veristat and/or maybe bpftool's generic program loadin=
g.
> > > > And another one is cloning the same fentry program to be attached i=
nto
> > > > multiple uniform targets (I do a similar hack in retsnoop, for
> > > > instance).
> > > >
> > > > In none of those cases cloned FDs are meant to be interoperable wit=
h
> > > > bpf_object/bpf_program abstractions.
> > > >
> > > > >
> > > > > 2. Storing the clone FD back on struct bpf_program
> > > > >
> > > > > bpf_program__clone() returns a caller-owned FD, but APIs
> > > > > like bpf_program__attach() read prog->fd internally.
> > > > > Without a way to set the FD back on the program struct, the
> > > > > caller must reimplement attach logic (section-type dispatch
> > > > > for kprobe, fentry, raw_tp, etc.).
> > > > >
> > > > > Would a bpf_program__set_fd() setter (similar to the
> > > > > existing btf__set_fd()) be acceptable to store the clone FD
> > > > > back, making bpf_program__attach() and related APIs usable
> > > > > with cloned programs?
> > > >
> > > > technically this could be done, probably, but it just feels too dir=
ty,
> > > > tbh... there is so much program-specific information that libbpf
> > > > internally preserves (and gives access to most of it through
> > > > bpf_program's getter) that would need to be invalidated and/or
> > > > re-fetched with this set_fd() approach, that I don't really even wa=
nt
> > > > to consider this too seriously... but see below
> > > >
> > > > >
> > > > > 3. Use case: selective program loading from a single BPF
> > > > >  object
> > > > >
> > > > > Our use case involves a single large BPF object (skeleton)
> > > > > with hundreds of programs where a subset is loaded at
> > > > > startup and others are loaded/unloaded dynamically based on
> > > > > runtime configuration. The current approach requires either:
> > > > > - Loading all programs upfront (wasteful), or
> > > > > - Maintaining out-of-tree patches to libbpf for selective
> > > > > loading
> > > > >
> > > > > Last year we made an attempt to upstream our solution to
> > > > > this use case to libbpf[1] but Andrii pointed out how our
> > > > > approach was problematic for upstream. He then proposed
> > > > > splitting bpf_object__load() into two steps:
> > > > > bpf_object__prepare() (creates maps, loads BTF, does
> > > > > relocations, produces final program instructions) and then
> > > > > bpf_object__load().  We are trying to follow up on his
> > > > > input and become more upstream compliant.
> > > > >
> > > > > The prepare() + clone() API seems similiar to this,
> > > > > but the questions above about object state and FD ownership
> > > > > are the main gaps for production adoption. Are there plans
> > > > > to address these in future revisions, or is this
> > > > > intentionally scoped to testing/tooling use cases only?
> > > >
> > > > I remember your use case. I don't think clone is really a great fit
> > > > *if* you still want to stay at bpf_object/bpf skeleton high-level o=
f
> > > > API (i.e., if you want to use bpf_program__attach() APIs and BPF
> > > > links).
> > > >
> > > > While definitely a complication, I think we can add support for
> > > > loading BPF program after bpf_object__load() happened. You'd have t=
o
> > > > keep your optional programs as non-autoloaded (or
> > > > bpf_program__set_autoload(false) explicitly), and I'm thinking we
> > > > might want to make this behavior opt-in explicitly through
> > > > bpf_object_open_opts(), as there are various points in bpf_object
> > > > lifetime where we make some decisions with the assumption that
> > > > programs will never be loaded, so we'll need to explicitly indicate
> > > > that *all* programs would need to be considered loadable, but maybe
> > > > much later.
> > > >
> > > > Another thing that won't (or rather might not) work is declarative
> > > > prog_array initialization and struct_ops. Those two steps happen in
> > > > bpf_object__load() after all programs are loaded. I don't think tha=
t
> > > > is the problem for you, but I just want to point out that program
> > > > loading is not always the last step.
> > > >
> > > > But other than that, despite added complications, it's probably bet=
ter
> > > > to just allow to load programs lazily after bpf_object__load(), aft=
er
> > > > all.
> > >
> > > Thanks for the detailed info! We can start working on this ourselves
> > > once we have some available time, we hope for your guidance during th=
e process.
> > >
> > > Andrey
> >
> > Hey Andrii, getting back to this important topic -
> >
> > I reviewed the proposed solution and the code . An object-wide
> > bpf_object_open_opts flag that means "all programs must be
> > considered loadable, but maybe later" collapses two things that need
> > to stay separate: a program that is not currently loaded but may load
> > later (feature gated, config-driven), and a program that is
> > permanently not going to load on this object instance (e.g. it
> > targets a kernel symbol/struct field that doesn't exist on the running
> > kernel, or it lost out to an equivalent alternative implementation and
> > will never be used). Today those are distinguished by the autoload
> > bool: false + never load =3D the second case. If the semantics of "not
> > autoloaded" change object-wide to "loadable later," we lose the
> > ability to express the second case at all -- every non-autoloaded
> > program in the object now implicitly carries the cost and risk of
> > being treated as eventually loadable, even the ones that never will
> > be. So, every non-autoloaded program is implicitly pulled into
> > relocation resolution and map creation, since nothing can rule out
> > that it might load. For a program that  never will, that's
> > wasted preprocessing, and if its relocations fail against this
> > kernel's BTF, that failure is no longer isolated to just that program.
> >
> > Given this I wonder if it's reasonable to re-evaluate the approach of
> > per-program enum from the original patch series we prosposed , rather t=
han a
> > boolean plus an object-wide opt-in flag. Keeping disabled as its own
> > per-program state (excluded from relocation and map-creation, failures
> > isolated) alongside auto and the new dynamic case state gets us
> > the capabilities we want without forcing every already-
> > disabled program in an object to be reclassified as "maybe loadable.
> >
>
> Goodness, 4 month since that discussion... I don't remember all the
> details, we can start a new conversation and go over details, but I'm
> just about to leave for vacation and Mykyta is still out on vacation,
> so I'd suggest to restart this conversation with all the details anew
> in about a month of so, if that's ok?

Defenetly! So just to clarify, per your advice from earlier in this thread,
we don't plan to rely on the cloned sessions concept anymore and suggest
instead to review again the approach we proposed initially [1].

>
> Explicit tri-state per program vs implicit tri-state (if not
> explicitly disabled -> maybe enabled, if per-object setting is set) is
> probably not the most blocking part of this. But again, let's come
> back to this with fresh heads :)

We will gladly review it again and adapt it so that it is acceptable
to the community and can be
beneficial to all users of libbpf.

I will reach out again in the second half of August.

Thans,
Andrey

[1] -https://lore.kernel.org/all/20250122215206.59859-1-slava.imameev@crowd=
strike.com/t/#m93ec917b3dfe3115be2a4b6439e2c649c791686d



>
>
> > Thanks!
> > Andrey
> > >
> > >
>
> [...]
