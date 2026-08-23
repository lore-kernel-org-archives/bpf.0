Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F91363C55
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508763; cv=pass; b=DoynU0ELpulSkoB343nPFtLZBnnkG0jMk4D+InmgrZ1v0A/hSRrqAOJlPVyny/MzyrpWvBv/E35mkamcGolZi/Shjdeepk/ibDOlrMf4Q3/eqVEVyKsdCnMzfz5HZ+j2HlsQOod/BO/QdtN1jwSIszERh6/zK9yUJn8sZXL8OSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508763; c=relaxed/simple;
	bh=wyBWJmgTNp7vlwajbYDCYodN68wmPISN5vPTPh0h8SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJWQDJtxzF/Iumctg5GUoMG2ZgxV+wUwPtIv5wib1ybWKd5FfqO2zgwrZ52Zg22E1e8L0BOMrsSiwHyabRRfB8mq6kMEz7zDxVnl6if5YQrus5g7TfEeeTjNwgcebm/gBFUEWYQCxdK5cmjSp0VvFSLx8zeDbw7GLPaOCFcSTtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DcUGE9ic; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=MGYFcfgM; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DcUGE9ic";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="MGYFcfgM"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NDTWto2645424
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 18:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=cFzhZwv1ni7kD6Ac44OREgfGpPJmNx78mjrNbzHKaHk=; b=DcUG
	E9icciTIu/la0oEBAoxgJc7T4sLixFSnfEhiCPjupMfW5jILx1IaxSzVxPT56A6K
	yBW5a5u2hvf+KyPeblFhcpqHQ2hl9DXENFuR6ptvtnTammTNQCVisa4q8i7jXORu
	loAvyA8RfbjUtPg+maJcHSHgkgPUKhsGU3bjm3mnB7tm2QMddKNdDmdekg0GO7j0
	d0KQ9LUBUGvL1+isFY3qWIeOwB3GH0On3bXFfNKPLZcImA7gFbc9Tp936gBAFReC
	2/qB5YDq/NsERl2Gypnnjvpik8esaYKqAkmPc+l74Khc+5hxPkz6nMlJA0c1aGiR
	PW7De250NNvcS1Bs2Q==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4g7pjwhat7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 18:12:35 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-845f687dfa2so36798977b3.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 11:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787508754; cv=none;
        d=google.com; s=arc-20260327;
        b=aY641slit7JIk5tvH9QDPq+vIMgbUSojykZW88GiMN67DQIlXEn/oJjJICVmzi3F3k
         gLr9fV8okIYDZ87R7+A3XWfWILY52gjJuiEZmffiH8tc+A85J8aUR64RnoV4sHeg18W7
         PXfxXTQc2GLW7e4Bg37+7EXaL4qv7jT6DOOENpm61vftIDnU2on/01h3px2ZPPFIoQZW
         sdoCVjZ0NTx2LL+EbEF8A6MZvYf5sKpr7AtNPaS7ZRNZzcPBnrGW3lO2Cfhc0U5xIoWr
         YUYKyhPR8rweLrJrZWT57n21yS/YfzkdPNlR8HgYr3nIGQ1ewUowcVtvVfyVk4LxQJ92
         LQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFzhZwv1ni7kD6Ac44OREgfGpPJmNx78mjrNbzHKaHk=;
        fh=O15/nwl8HV8G6ieXo2p7UI0Ao5Ahdq1tXaJVMJ2UZS0=;
        b=lLf0IjkV78UZ4P/yZlB8GsnOkA+blz/yrFlHj/5rofSnG/LCB5/utz4kphjPz/D4e9
         7yqEgvwDSS8uAMc8nQ0URQL8Wf3XXDJlbcxDaSXPRtfd8puh+SE1wVdO1ZahMWcdRg10
         77L0O8vHMunsvtcE32zQHelqHZ3ex3eCi5vjP81KtDzVGSaJrDEK8eeh72nR8M0/KeGu
         JHjnIOsOnaNssnTkzV+JD72o2CdEU/PaWi1GenLV7S+NonBt/qewYStS4hhJYInT9Ut3
         difGVGhoW7RDz+Vh6krgkJoJfstBtSnTqJ461xP5bQuFqyeW0MHlzHgjwGKYoIRceB6C
         mcKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1787508754; x=1788113554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cFzhZwv1ni7kD6Ac44OREgfGpPJmNx78mjrNbzHKaHk=;
        b=MGYFcfgMp+8dQ2d2PfDm2CcD8wvQ45wj4qw0CNk5lRkWysIp+Tv2yn4NRxpJRE+a0a
         UKvrDrxtMv/3cthr9wE0+pp1gMe+lGVKf53oWVMPbyVR+t8KW7S8xhlD8osIoVHHJKVj
         ltnywso2575s8TBUnSMdWRXr4tQxc4rRo5S3rKT/RrMrLofUStrQGPUkSxEVJAM/6uqN
         gr9cruBjIPD3mI6Ask1EdD7mfNvIHdZjONoEZTu9jqvLtqJOwu00Eg0rpo1OXQxeM+fb
         f0LLk/jqX8uzoCwWBYZ+ziVeoUA6Gkno53MYXyuR9YEwYuuQOMlecFt3X4GE82pQBlz0
         zBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787508754; x=1788113554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFzhZwv1ni7kD6Ac44OREgfGpPJmNx78mjrNbzHKaHk=;
        b=MYpWkbksNSBkNMPGpV6EvnWvQpUlV5EUwGVxm4v1if2hdGEz/q7XHvD2dHiJ9uKiF4
         XoELY7Yi8kxL47dH832HaCgNxDtA/x/qkSXG+OZXzuA1F9LuZ/xiP29VHm28Wbvx8HAb
         KlgzNWsH7MPPb5B7+2p0rwE2CWATt1/9ys9HDL//ojeNhdrNQW4NCaJ6mpock15DjmNP
         gmV7WFVdqZbFXkLy0OJBlYhaboapVQAwid0ufIso22DabWLD/2r2MU7ztEQWA81jmbIU
         U20/iDD1b/OvG3JwaLImCNN9DiG9iNYqzXmRSAEl3pobgCLOmdrp0hWsBEhvqfO8uKxx
         bqUQ==
X-Gm-Message-State: AFuF++maT3mkoZje9uJfaJ/7W9P41yjt4Jl3//TKqTTccxqBYeCsRarO
	fJ1/qJ/uNfZsTGwAXhXN4lxj031kaVjSn7miDv/ysiOpcy1DdlcTlQcAm101pQ+8fm4c4mZRBMK
	X4ghHGtYhRJrY14yl3UOEi26i0lpcvpJvGey3xfd/mYz7BTu6bUrBr0wwpUP7fbKZ5GRqE2sCEX
	CT5CcR0Swc4TQc/slY5n2Q1XwxA0dV
X-Gm-Gg: AR+sD11OWKO0CMqKiA5OnKOTQYRg5RSvCAnWCH6QFkcO23G8RAuTUNamBilTTd1wCzg
	SozRI4L2aBfJv4RJzXRyyZp77BfFTt89cKgcLLfvs4DYHIoMmLcSKC6LyD1XxKEwqQqAON/nYYv
	CYKnib1u/fpdsz/v4nrxomFKXiL1jJVWEP347k8wHbuwtJMMzlRNZ1/x7N3w==
X-Received: by 2002:a05:690c:389:b0:81e:d792:a019 with SMTP id 00721157ae682-84c93848f54mr43296177b3.6.1787508754404;
        Sun, 23 Aug 2026 11:12:34 -0700 (PDT)
X-Received: by 2002:a05:690c:389:b0:81e:d792:a019 with SMTP id
 00721157ae682-84c93848f54mr43296017b3.6.1787508753634; Sun, 23 Aug 2026
 11:12:33 -0700 (PDT)
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
 <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
 <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com>
 <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com>
 <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com> <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com>
In-Reply-To: <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sun, 23 Aug 2026 14:12:21 -0400
X-Gm-Features: AcwNN1Woem1kI9456UASPi-2Fh5yfdGNWihoqSVAWqzckxuoY-UUKsyf4h8KB9A
Message-ID: <CAOu3gNjD0rH6nD5mJTwaJ+=L+mhLzVBM9jwQ1XMF1XaNuszLAw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: wR3-LKTb-W_WSuXfIDaHbegMJ2UHV4Ka
X-Authority-Analysis: v=2.4 cv=Ja+Ma0KV c=1 sm=1 tr=0 ts=6a8b3813 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=kdThuS-Off6B-rCXx0YA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: wR3-LKTb-W_WSuXfIDaHbegMJ2UHV4Ka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE2NSBTYWx0ZWRfXxOVKOInYPIOf
 5FXAktrmGAjiyZ8W9mEqLS+9Zph/0m55TgMwiUiGbe9i1jqsqgrIO/p+ALlMiJJj0Bl10wLCcFn
 XaKWwsjn4vkxKXaBWo1hIoSd+BRUVH1wLfDkpRaQ6XLt6ON6m0MLZyF1+N/UGiPE28StB6z66sY
 27l9CEXtgSA/OxrHnohA9ifjnhw39WdJTbBuTqJja7HQV8CRSVoVBrSymlU5aqQvjMlfQysCkX5
 ZGeXbc+7QOMBCQzjm8Pb8xnIJRfPOJcupMMdsb5oeaisNqu2qYHEiu8hl6kJBcZ6QJ1uU/t/Wpv
 h1H9eH8QAEcwb4r3TZoZBBlZ7IQeti5+j847VXBYXuq6QKbXZL8LGsFK+kxSfwttuXEvlMFTQ8J
 lcxc280cSkR6eopq+TqERkiyfgo7P0ukqkHeczb+kxyMO1Nyh97ywZksVs/Bxjqs0Ve1KxjEUa8
 mQZYzOnMoG7MEY5JQ8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE2NSBTYWx0ZWRfX07iNdMqz6mu2
 Fuhr8fkTPzS7eRoTR9udXwRmVnGWTlvBHTYWknljqZZ2baKH5Y7gmtiW3NuiZKirS3Q4X3s42lo
 Ia66zNzq26Y74Os0Zmv73Sm/7gAbQZUBAdVKpiTgf0INsmity0SO
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11884
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230165

On Fri, Aug 21, 2026 at 1:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 17, 2026 at 8:32=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > > > > Hey Andrii, getting back to this important topic -
> > > > >
> > > > > I reviewed the proposed solution and the code . An object-wide
> > > > > bpf_object_open_opts flag that means "all programs must be
> > > > > considered loadable, but maybe later" collapses two things that n=
eed
> > > > > to stay separate: a program that is not currently loaded but may =
load
> > > > > later (feature gated, config-driven), and a program that is
> > > > > permanently not going to load on this object instance (e.g. it
> > > > > targets a kernel symbol/struct field that doesn't exist on the ru=
nning
> > > > > kernel, or it lost out to an equivalent alternative implementatio=
n and
> > > > > will never be used). Today those are distinguished by the autoloa=
d
> > > > > bool: false + never load =3D the second case. If the semantics of=
 "not
> > > > > autoloaded" change object-wide to "loadable later," we lose the
> > > > > ability to express the second case at all -- every non-autoloaded
> > > > > program in the object now implicitly carries the cost and risk of
> > > > > being treated as eventually loadable, even the ones that never wi=
ll
> > > > > be. So, every non-autoloaded program is implicitly pulled into
> > > > > relocation resolution and map creation, since nothing can rule ou=
t
> > > > > that it might load. For a program that  never will, that's
> > > > > wasted preprocessing, and if its relocations fail against this
> > > > > kernel's BTF, that failure is no longer isolated to just that pro=
gram.
> > > > >
> > > > > Given this I wonder if it's reasonable to re-evaluate the approac=
h of
> > > > > per-program enum from the original patch series we prosposed , ra=
ther than a
> > > > > boolean plus an object-wide opt-in flag. Keeping disabled as its =
own
> > > > > per-program state (excluded from relocation and map-creation, fai=
lures
> > > > > isolated) alongside auto and the new dynamic case state gets us
> > > > > the capabilities we want without forcing every already-
> > > > > disabled program in an object to be reclassified as "maybe loadab=
le.
> > > > >
> > > >
> > > > Goodness, 4 month since that discussion... I don't remember all the
> > > > details, we can start a new conversation and go over details, but I=
'm
> > > > just about to leave for vacation and Mykyta is still out on vacatio=
n,
> > > > so I'd suggest to restart this conversation with all the details an=
ew
> > > > in about a month of so, if that's ok?
> > >
> > > Defenetly! So just to clarify, per your advice from earlier in this t=
hread,
> > > we don't plan to rely on the cloned sessions concept anymore and sugg=
est
> > > instead to review again the approach we proposed initially [1].
> > >
> > > >
> > > > Explicit tri-state per program vs implicit tri-state (if not
> > > > explicitly disabled -> maybe enabled, if per-object setting is set)=
 is
> > > > probably not the most blocking part of this. But again, let's come
> > > > back to this with fresh heads :)
> > >
> > > We will gladly review it again and adapt it so that it is acceptable
> > > to the community and can be
> > > beneficial to all users of libbpf.
> > >
> > > I will reach out again in the second half of August.
> > >
> > > Thans,
> > > Andrey
> > >
> > > [1] -https://urldefense.com/v3/__https://lore.kernel.org/all/20250122=
215206.59859-1-slava.imameev@crowdstrike.com/t/*m93ec917b3dfe3115be2a4b6439=
e2c649c791686d__;Iw!!BmdzS3_lV9HdKG8!zLLCzrdLf22D2nAvCY9zolVFNQrG3_TnvtoRIv=
m-HpwGPt9OIpIoC7q0ZWjijb396RLVMFi29c1j_DDBPPtC79aACUXBshO-eDCGtA$
> >
> > Hi Andrii,
> >
> > Following up as promised from our discussion last month regarding
> > dynamic program loading.
> >
> > I reviewed our initial patchset and the subsequent mailing list
> > thread. It seems the conversation previously veered into unrelated
> > topics, such as concurrent programs loading and dynamic map loading,
> > which are beyond the scope of the dynamic program loading capability
> > we are trying to introduce.
> >
> > To recap our main point from July, using a global object-wide flag
> > collapses two distinct states: programs that are genuinely disabled
> > (e.g., due to missing kernel symbols, where we want failure isolation)
> > and programs intended for late, dynamic loading. If we use a
> > per-object setting, every non-autoloaded program is forced into
> > relocation resolution, potentially causing load failure and wasting
> > preprocessing time.
> >
> > If that is ok with you, I would like to resend the original two-patch
> > series as an RFC with a cover letter, rebased and retested against the
> > latest bpf-next branch. This way we can review and discuss the
> > approach from a clean slate.
> >
>
> yes, let's start with resending patches (you can drop RFC, otherwise
> CI testing story is worse) and let's go from there.
>
> I'm actually wondering, if we are going to introduce a their auto-load
> state from current true/false, whether we should also have a new SEC()
> naming convention for such programs so that one can declaratively
> specify that this program *might* be loaded after object load, and as
> such should go through a proper relocation and other manipulations.
> I.e., we have SEC("raw_tp/...") for eager load, SEC("?raw_tp/...") for
> default no-load, perhaps we have to add SEC("!raw_tp/...") (or some
> other appropriate prefix) for lazy-load programs?
>
> And actually (I won't erase the above, but it just occurred to me)
> nowadays perhaps decl_tag is the better way to go. Can you experiment
> with this? We can bikeshed on naming later ;)

Will add  the tag and more tests to cover it.
>
> For bpf_program__set_autoload() API, I *think* we can manage backwards
> compatibility by converting bool argument to enum with zero matching
> to "don't load", 1 matching to "eagerly load" and 2 will be "lazy load
> maybe later if user ask for it".

Will do this cleanup.

I will be back with either the ready patchset or more questions as
soon as possible.

Thanks,
Andrey

>
> > Thanks,
> > Andrey
> > >
> > >
> > >
> > > >
> > > >
> > > > > Thanks!
> > > > > Andrey
> > > > > >
> > > > > >
> > > >
> > > > [...]
