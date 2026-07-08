Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98071371899
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545796; cv=pass; b=mYHDZkKwUoElmyMe8cBeybW/0elv4t7FIZGX7ANV2uH6rAT5A32w/scfJMlXmer61ESATvhVYAjexYJoSYlQlJi/IERdz0G+3DRYb4PWagVXXVQb8xi0MMhbTKSfIXYASVFpYd8aQGZA+z88Rxu3nuNEyqxvJPMJE3cHvJTd4hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545796; c=relaxed/simple;
	bh=3HuV7crMdG9ZTZpKIlTWGkH3YmkxYg3NM1NXulQ3pZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcgHJCgbxoxBZXHrhaEOCNs2OsUAfQEGaGp06knUDU0gDeX1Ktk7Tk51IBwJhQXBBTG7rAR64UyN/MhgbpOR7K8JlWRPRXQzGebyGF4YSxcfqE7POP4OGdWnMggXGLpqi4UuGejzTKwBjjCFnuQz2hGmNo/JJ1/n3DYlbKLAERY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=txTD40GW; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=kH5IlqEV; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="txTD40GW";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="kH5IlqEV"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668K0FGA4014003
	for <bpf@vger.kernel.org>; Wed, 8 Jul 2026 20:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yJNVCjLYwWryvUrpNftPrm6ZMWtz8In5MFqsB12RDHw=; b=txTD
	40GWdVCf/hs5sjhEDpuxoYfrKYtf81Cjh9OKqQTgl/deE938moNVmAgk5q5jELr0
	zyqAc0yZiWShPfzM/xrD/7JQ/wcE7PXBK0bhAJgf2TEShQylsVfMd3fxLCd+mHUq
	BSNeFW6a4Me8BpVoOAhI7lFYC2PVE+AOYiEAwduke0lM/khkBgL+OV8JebYlfx13
	6rrMWEdK2HVtQoVjibQ2Q5c5k8z5YZIVKpNVaatbiQ/w89l+wgmBO58/aJlCNNMl
	LRGdmq8pAwXgg4j7j4/sMw5Ogv0ZEJA2DFjDlCz5ezNtNUxX6LqpumZDIrT2YNEH
	5qepFv1WwHXVYb30tQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4f9kea32y8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 20:58:31 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e2e96ba57so23700417b3.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 13:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783544310; cv=none;
        d=google.com; s=arc-20260327;
        b=EPm7eTjBfOE+9QPtSM2NACJvKSZamyTG3S8qNL8j+oMnmqbdRFSCvLrhMYiM8dE8/O
         /4Y7SLfoHfXUDwlJUUnZtmzIc6Wced0gCaoZ02bsWlT8F9OYfYIpTaMvmzE0dKZ+KYEG
         tW05+MvLKcIrP5T/U6jaC2kr17Ff6dZsiRTQLZi0rvZ/GZ7sgAF5bcUQNztStDvq/Jx8
         /pJGn7XM8QaTF/2qdjlP9zYApSjMstgSH43OO6CZnMA828cYaqqmkV7dkmMTa2jAioFn
         6c4PvEgJsAZUY2fPy29Xo+RA9x+nMpPl7+NJD79k3VAX/4sE1IQ4bHWE8+kSI8iuf6Y/
         7ntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yJNVCjLYwWryvUrpNftPrm6ZMWtz8In5MFqsB12RDHw=;
        fh=XEPoNEBudybeUXWcUGBCuRGzTc25WRGS3V6d3ZksBpg=;
        b=WOQhGCxFVGONf63TsrLPtbWBTPsQAmmZ7qXa0s+mAKbbCQYheiVyyL8DW5bfNMJ/Bs
         Qdwms79rnVp2QZZLnnxLO8IxpE3TjCth1gUqL1jDoe9o4fcOqQSvn8JOSLAuKZVD9omq
         +8U6Wy4QGnU0cm3PT9TZsR+ssE69whPHH2IDteiP1JdMUZFUIWEtF+5IJD/qEGYkHcpE
         qy3dtWLGVW4bhU4CouDgxIYCIC6WW8LDnZpkTLi5+J7SMmfWUnG931WARf0Z8n+r2/1B
         jFitngjWFSipw2g/vQxPIiB2Qc154vuRMmXdCTAaXmTSTQ4dnYP5Sms2uNgFEdLI0YVW
         bPKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1783544310; x=1784149110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yJNVCjLYwWryvUrpNftPrm6ZMWtz8In5MFqsB12RDHw=;
        b=kH5IlqEVPgL7oXBTwZ5dWRHlqWM0WbK6sWst30d/jU8oJWkNfNMXac0IeprY2mCS9V
         CqDU6edMZioqTQo0VqFlD8/XnRHHLQPu05A7FDziwtEzHe6vxEMr8I4WupH3IURKBk9X
         FuVpOFLVvP6nHtl7M8j6I280B/eAivsP3WGDJlqjWHQF0iUn8Tpjqyoi3AdITORzpZYK
         2jR1IcTN2h1OvFaWWRRESIh5Z8f7QIvxeL0Edq+8P3xZ1utLq5SWvtoavF261sVPZbwM
         Kn+XIh3R00DUYf25TMGERfiX1zAqXlfbDW3JOIAdThtowKEa+Y+NZA1U6yGeMWqshr+R
         HwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783544310; x=1784149110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJNVCjLYwWryvUrpNftPrm6ZMWtz8In5MFqsB12RDHw=;
        b=sO0GVAVmmd13mXoqdi08CUvtFYik7cljJCX0aOJdBKTTYDFBGFtcLhXGZfNCElrKq9
         7qIxpRqP8Si2nlOk+L5QUpwRmLOn3gx0wD0WFWFxs5MDu5TtpJSDNUBbISezw64/tz+H
         JDGZ3cv64Dkm5LlSmusuxnnKpr+4soVEmytvcoSvhrvSUIaGTWx01aSNU/vpMoYcaByz
         Dcb/xyx1DwpNqjD64QCJY4PkYjuQ0NrUlHwvpaTS6TPRyuMdKr7RkAEa8w1XedzciTC8
         ZZMZQmAjKyCX1ClmlqIEo4M0r11NY8l4UL+CZWYTuUTYXKGTio/IZxhtb8knuTFaSEU8
         9XEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsLiQ/VSNsNoIyFnGEFuzG8BuG5mpdcrCDY4gbC8QEnGRpCBdkMZCJAkgwkutli5lCe1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRVLeQ0or2Zp0qCUSiHVG7TiIKNuvoYkyfm5pqOJeCi1iE0T7
	6CetbfdEdZcy3leLXcydHTY1AUxBSwthgtuhCUsQ926/NqNN9TiVNLBWjS4RbvrL6REGGlECWXI
	V58qafysTB3EkGAdkOLLjQiyKzvwoerQpyZK4rUus26JtjPS4Sa9QaH29x5e3dkn76IVsAolAuU
	IZh43h6XcEnrV6Yxqch1xHQ2X6bTsW
X-Gm-Gg: AfdE7cnFbhZZibX0qRGOAZMkmKUoBNtF2//QvIN5+aL6r4XU6GQZXycySAY96nq/5tW
	KlNs0UgAeRUJEZ82XxWCli2Olc3MM6VeglcVYT+Ss5nBJBFNTiGuYLL969hGNnxYV+AHyNRtkLR
	jjuslvRd5sCZggMctTPdAHnENopCwzra23x9DqlSCOPFyDFipRwaxd8MswqBooi/SyTXQ2iQ==
X-Received: by 2002:a05:690c:e1db:10b0:81e:531c:e0d3 with SMTP id 00721157ae682-81e531ce286mr17969207b3.59.1783544310044;
        Wed, 08 Jul 2026 13:58:30 -0700 (PDT)
X-Received: by 2002:a05:690c:e1db:10b0:81e:531c:e0d3 with SMTP id
 00721157ae682-81e531ce286mr17968947b3.59.1783544309353; Wed, 08 Jul 2026
 13:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com> <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com>
In-Reply-To: <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 8 Jul 2026 16:58:18 -0400
X-Gm-Features: AUfX_mwUggi7E1HrKF5_gL4Zq4eIDG-OwCHX5NZB_7_DIDhmVJz1dCILDnDy18E
Message-ID: <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIwNiBTYWx0ZWRfX4jsB6cq6I6if
 Td8C7XhGmhXcGB9o5jVGxjOnW2eefQ2q8J3gNEADgj0bLfqzqdwZhhnjBQh5vLFE5hxxxyyau7r
 jpewQsnNcewplDfeLifG3Tuull7xk4/AXU2wfFVVo+X4u4zc6x7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwNiBTYWx0ZWRfX42fqV2XJI6qe
 OFd8G3e4Mo3Or5tdCZSfRZHu3OGGQeNGSzAoUkyXwKWsV7OousrxH+9UY/GHuAr1pePzldQRC6E
 OVQS/x0LNoh1c6oIXTS1hNIZdMQEkZd928R/yhRzTKivmjK5tprxN8KuAIysMHluAVhqZk0r92x
 JEGU0hLTeDrJ5Ee7dzHcTJldPpPKnGkevoh++FXJR7pmgFnPm9AKnJp9I7w0A8B0Ry83q8qbN18
 UnmEU/T02dLUgVHDB6+4cY7E5dRgyNRxASU7jjsmqpBPdfaYPFOspJgnSjRNGsuGBKj70IUED13
 ahX39AOj9OSRGdniHpC2aY4uCGuURn2f5OpL9ExANqimkc6trgKan7MaAhrjrIe2D0t1GLTGWKp
 JBL7C+PgTlE3NPuF/xVI7LPFgom88i195hRr3lm8bO9Uno31Ek3H0yBC/izTBQ0JVe5XDP/JAlb
 QW7uk8HWibjiA4Jx8sg==
X-Authority-Analysis: v=2.4 cv=P8kKQCAu c=1 sm=1 tr=0 ts=6a4eb9f7 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=Pgacwa0oAAAA:8
 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=YRIT4crWzRg214YcnGoA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=xnLNWz09G3ZUmE6K9NTY:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 2gZEuv9nAgS_7UA1i0qjtQAyj0BD0nnT
X-Proofpoint-ORIG-GUID: 2gZEuv9nAgS_7UA1i0qjtQAyj0BD0nnT
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11841
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080206

On Mon, Mar 16, 2026 at 10:23=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Wed, Mar 11, 2026 at 6:52=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 6, 2026 at 9:22=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > Mykyta and Andrii Hi!
> > >
> > > We're evaluating the bpf_object__prepare() +
> > > bpf_program__clone() API for use in a production BPF
> > > application that manages hundreds of BPF programs with
> > > selective (dynamic) loading =E2=80=94 some programs are loaded at
> > > startup, others loaded/unloaded at runtime based on feature
> > > configuration.
> > >
> > > We have a few questions about the intended usage and
> > > potential extensions of this API:
> > >
> > > 1. Compatibility with bpf_object__load() and object state
> > >
> > > After bpf_object__prepare(), the object is in OBJ_PREPARED
> > > state. Several libbpf APIs (e.g., bpf_program__set_type())
> > > gate on OBJ_LOADED state.
> > >
> > > Is there a recommended way to transition the object to
> > > OBJ_LOADED after cloning all desired programs? For example,
> > > would a bpf_object__finalize() or similar API that runs
> > > post_load_cleanup() and sets OBJ_LOADED be in scope? This
> > > would allow users to benefit from prepare() + clone() for
> > > selective loading while keeping the object in a state that
> > > the rest of libbpf expects. Or, is the new API not intended
> > > to work with bpf_object in the first place ?
> >
> > exactly, it's not. It's an escape hatch out of bpf_object into
> > low-level FD, it was never designed to produce something that should
> > be put back into bpf_object. This clone stuff if for generic low-level
> > tooling like veristat and/or maybe bpftool's generic program loading.
> > And another one is cloning the same fentry program to be attached into
> > multiple uniform targets (I do a similar hack in retsnoop, for
> > instance).
> >
> > In none of those cases cloned FDs are meant to be interoperable with
> > bpf_object/bpf_program abstractions.
> >
> > >
> > > 2. Storing the clone FD back on struct bpf_program
> > >
> > > bpf_program__clone() returns a caller-owned FD, but APIs
> > > like bpf_program__attach() read prog->fd internally.
> > > Without a way to set the FD back on the program struct, the
> > > caller must reimplement attach logic (section-type dispatch
> > > for kprobe, fentry, raw_tp, etc.).
> > >
> > > Would a bpf_program__set_fd() setter (similar to the
> > > existing btf__set_fd()) be acceptable to store the clone FD
> > > back, making bpf_program__attach() and related APIs usable
> > > with cloned programs?
> >
> > technically this could be done, probably, but it just feels too dirty,
> > tbh... there is so much program-specific information that libbpf
> > internally preserves (and gives access to most of it through
> > bpf_program's getter) that would need to be invalidated and/or
> > re-fetched with this set_fd() approach, that I don't really even want
> > to consider this too seriously... but see below
> >
> > >
> > > 3. Use case: selective program loading from a single BPF
> > >  object
> > >
> > > Our use case involves a single large BPF object (skeleton)
> > > with hundreds of programs where a subset is loaded at
> > > startup and others are loaded/unloaded dynamically based on
> > > runtime configuration. The current approach requires either:
> > > - Loading all programs upfront (wasteful), or
> > > - Maintaining out-of-tree patches to libbpf for selective
> > > loading
> > >
> > > Last year we made an attempt to upstream our solution to
> > > this use case to libbpf[1] but Andrii pointed out how our
> > > approach was problematic for upstream. He then proposed
> > > splitting bpf_object__load() into two steps:
> > > bpf_object__prepare() (creates maps, loads BTF, does
> > > relocations, produces final program instructions) and then
> > > bpf_object__load().  We are trying to follow up on his
> > > input and become more upstream compliant.
> > >
> > > The prepare() + clone() API seems similiar to this,
> > > but the questions above about object state and FD ownership
> > > are the main gaps for production adoption. Are there plans
> > > to address these in future revisions, or is this
> > > intentionally scoped to testing/tooling use cases only?
> >
> > I remember your use case. I don't think clone is really a great fit
> > *if* you still want to stay at bpf_object/bpf skeleton high-level of
> > API (i.e., if you want to use bpf_program__attach() APIs and BPF
> > links).
> >
> > While definitely a complication, I think we can add support for
> > loading BPF program after bpf_object__load() happened. You'd have to
> > keep your optional programs as non-autoloaded (or
> > bpf_program__set_autoload(false) explicitly), and I'm thinking we
> > might want to make this behavior opt-in explicitly through
> > bpf_object_open_opts(), as there are various points in bpf_object
> > lifetime where we make some decisions with the assumption that
> > programs will never be loaded, so we'll need to explicitly indicate
> > that *all* programs would need to be considered loadable, but maybe
> > much later.
> >
> > Another thing that won't (or rather might not) work is declarative
> > prog_array initialization and struct_ops. Those two steps happen in
> > bpf_object__load() after all programs are loaded. I don't think that
> > is the problem for you, but I just want to point out that program
> > loading is not always the last step.
> >
> > But other than that, despite added complications, it's probably better
> > to just allow to load programs lazily after bpf_object__load(), after
> > all.
>
> Thanks for the detailed info! We can start working on this ourselves
> once we have some available time, we hope for your guidance during the pr=
ocess.
>
> Andrey

Hey Andrii, getting back to this important topic -

I reviewed the proposed solution and the code . An object-wide
bpf_object_open_opts flag that means "all programs must be
considered loadable, but maybe later" collapses two things that need
to stay separate: a program that is not currently loaded but may load
later (feature gated, config-driven), and a program that is
permanently not going to load on this object instance (e.g. it
targets a kernel symbol/struct field that doesn't exist on the running
kernel, or it lost out to an equivalent alternative implementation and
will never be used). Today those are distinguished by the autoload
bool: false + never load =3D the second case. If the semantics of "not
autoloaded" change object-wide to "loadable later," we lose the
ability to express the second case at all -- every non-autoloaded
program in the object now implicitly carries the cost and risk of
being treated as eventually loadable, even the ones that never will
be. So, every non-autoloaded program is implicitly pulled into
relocation resolution and map creation, since nothing can rule out
that it might load. For a program that  never will, that's
wasted preprocessing, and if its relocations fail against this
kernel's BTF, that failure is no longer isolated to just that program.

Given this I wonder if it's reasonable to re-evaluate the approach of
per-program enum from the original patch series we prosposed , rather than =
a
boolean plus an object-wide opt-in flag. Keeping disabled as its own
per-program state (excluded from relocation and map-creation, failures
isolated) alongside auto and the new dynamic case state gets us
the capabilities we want without forcing every already-
disabled program in an object to be reclassified as "maybe loadable.

Thanks!
Andrey
>
>
> >
> > >
> > > Thanks,
> > > Andrey
> > >
> > > [1] -https://urldefense.com/v3/__https://lore.kernel.org/all/20250122=
215206.59859-1-slava.imameev@crowdstrike.com/t/*m93ec917b3dfe3115be2a4b6439=
e2c649c791686d__;Iw!!BmdzS3_lV9HdKG8!w-rWKr0W2k1zo6qkXsDgmORVg5c3X9udhVYztk=
yvYonp_0GlVjNom_gDbcKSSOd7U-A_SQbGGfppVaaB5OYu01bMugTLr-R_tnkExA$
> > >
> > > On Fri, Feb 20, 2026 at 2:18=E2=80=AFPM Mykyta Yatsenko
> > > <mykyta.yatsenko5@gmail.com> wrote:
> > > >
> > > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > > >
> > > > Add bpf_program__clone() API that loads a single BPF program from a
> > > > prepared BPF object into the kernel, returning a file descriptor ow=
ned
> > > > by the caller.
> > > >
> > > > After bpf_object__prepare(), callers can use bpf_program__clone() t=
o
> > > > load individual programs with custom bpf_prog_load_opts, instead of
> > > > loading all programs at once via bpf_object__load(). Non-zero field=
s in
> > > > opts override the defaults derived from the program and object
> > > > internals; passing NULL opts populates everything automatically.
> > > >
> > > > Internally, bpf_program__clone() resolves BTF-based attach targets
> > > > (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> > > > func/line info, fd_array, license, and kern_version from the
> > > > prepared object before calling bpf_prog_load().
> > > >
> > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
> > > >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bm=
dzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6=
UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  |  1 +
> > > >  3 files changed, 82 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 0c8bf0b5cce4..4b084bda3f47 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struc=
t bpf_program *prog)
> > > >         return prog->line_info_cnt;
> > > >  }
> > > >
> > > > +int bpf_program__clone(struct bpf_program *prog, const struct bpf_=
prog_load_opts *opts)
> > > > +{
> > > > +       LIBBPF_OPTS(bpf_prog_load_opts, attr);
> > > > +       struct bpf_prog_load_opts *pattr =3D &attr;
> > > > +       struct bpf_object *obj;
> > > > +       int err, fd;
> > > > +
> > > > +       if (!prog)
> > > > +               return libbpf_err(-EINVAL);
> > > > +
> > > > +       if (!OPTS_VALID(opts, bpf_prog_load_opts))
> > > > +               return libbpf_err(-EINVAL);
> > > > +
> > > > +       obj =3D prog->obj;
> > > > +       if (obj->state < OBJ_PREPARED)
> > > > +               return libbpf_err(-EINVAL);
> > > > +
> > > > +       /* Copy caller opts, fall back to prog/object defaults */
> > > > +       OPTS_SET(pattr, expected_attach_type,
> > > > +                OPTS_GET(opts, expected_attach_type, 0) ?: prog->e=
xpected_attach_type);
> > > > +       OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id=
, 0) ?: prog->attach_btf_id);
> > > > +       OPTS_SET(pattr, attach_btf_obj_fd,
> > > > +                OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->atta=
ch_btf_obj_fd);
> > > > +       OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_=
fd, 0) ?: prog->attach_prog_fd);
> > > > +       OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?=
: prog->prog_flags);
> > > > +       OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, =
0) ?: prog->prog_ifindex);
> > > > +       OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, =
0) ?: obj->kern_version);
> > > > +       OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?:=
 obj->fd_array);
> > > > +       OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: ob=
j->token_fd);
> > > > +       if (attr.token_fd)
> > > > +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> > > > +
> > > > +       /* BTF func/line info */
> > > > +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> > > > +               OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_bt=
f_fd, 0) ?: btf__fd(obj->btf));
> > > > +               OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info=
, NULL) ?: prog->func_info);
> > > > +               OPTS_SET(pattr, func_info_cnt,
> > > > +                        OPTS_GET(opts, func_info_cnt, 0) ?: prog->=
func_info_cnt);
> > > > +               OPTS_SET(pattr, func_info_rec_size,
> > > > +                        OPTS_GET(opts, func_info_rec_size, 0) ?: p=
rog->func_info_rec_size);
> > > > +               OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info=
, NULL) ?: prog->line_info);
> > > > +               OPTS_SET(pattr, line_info_cnt,
> > > > +                        OPTS_GET(opts, line_info_cnt, 0) ?: prog->=
line_info_cnt);
> > > > +               OPTS_SET(pattr, line_info_rec_size,
> > > > +                        OPTS_GET(opts, line_info_rec_size, 0) ?: p=
rog->line_info_rec_size);
> > > > +       }
> > > > +
> > > > +       OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
> > > > +       OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
> > > > +       OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
> > > > +
> > > > +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc=
. */
> > > > +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> > > > +               err =3D prog->sec_def->prog_prepare_load_fn(prog, p=
attr, prog->sec_def->cookie);
> > > > +               if (err)
> > > > +                       return libbpf_err(err);
> > > > +       }
> > > > +
> > > > +       fd =3D bpf_prog_load(prog->type, prog->name, obj->license, =
prog->insns, prog->insns_cnt,
> > > > +                          pattr);
> > > > +
> > > > +       return libbpf_err(fd);
> > > > +}
> > > > +
> > > >  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {              =
         \
> > > >         .sec =3D (char *)sec_pfx,                                  =
           \
> > > >         .prog_type =3D BPF_PROG_TYPE_##ptype,                      =
           \
> > > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > > index dfc37a615578..0be34852350f 100644
> > > > --- a/tools/lib/bpf/libbpf.h
> > > > +++ b/tools/lib/bpf/libbpf.h
> > > > @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(=
const char *sec,
> > > >   */
> > > >  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> > > >
> > > > +/**
> > > > + * @brief **bpf_program__clone()** loads a single BPF program from=
 a prepared
> > > > + * BPF object into the kernel, returning its file descriptor.
> > > > + *
> > > > + * The BPF object must have been previously prepared with
> > > > + * **bpf_object__prepare()**. If @opts is provided, any non-zero f=
ield
> > > > + * overrides the defaults derived from the program/object internal=
s.
> > > > + * If @opts is NULL, all fields are populated automatically.
> > > > + *
> > > > + * The returned FD is owned by the caller and must be closed with =
close().
> > > > + *
> > > > + * @param prog BPF program from a prepared object
> > > > + * @param opts Optional load options; non-zero fields override def=
aults
> > > > + * @return program FD (>=3D 0) on success; negative error code on =
failure
> > > > + */
> > > > +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const =
struct bpf_prog_load_opts *opts);
> > > > +
> > > >  #ifdef __cplusplus
> > > >  } /* extern "C" */
> > > >  #endif
> > > > diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbp=
f.map__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhh=
JtfaqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  b/tools/lib/bpf/ht=
tps://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbE=
w0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4=
Rel1BiJSjA99yzJZk$
> > > > index d18fbcea7578..e727a54e373a 100644
> > > > --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__=
;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd=
4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> > > > +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__=
;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd=
4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> > > > @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
> > > >                 bpf_map__set_exclusive_program;
> > > >                 bpf_map__exclusive_program;
> > > >                 bpf_prog_assoc_struct_ops;
> > > > +               bpf_program__clone;
> > > >                 bpf_program__assoc_struct_ops;
> > > >                 btf__permute;
> > > >  } LIBBPF_1.6.0;
> > > >
> > > > --
> > > > 2.47.3
> > > >
> > > >
