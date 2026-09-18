Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104327AC57
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692575; cv=pass; b=p8OUCPKqrvFa8P8ZGQ+0xU0EcMzZTxpRaZdfJ4MSqq4nLbX3L1KDEgEBbxoxi8j0azTSSXGzIKeboj8xCZ1kcLrU6QVoJuG0Jvyz5tuVfxIrc7F1l8yClu/Fu2fX5YG4cLrlpSoe0BFPOKbgbdtSNvEb4gNBe4OWYe2F92CxbJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692575; c=relaxed/simple;
	bh=uabo6aboTS2IHRfMBkbstDPslMh+pSkVjmfAlELN1O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJSe0BsT6Jzta5bMvsbunA08EGr3MF9fB64RhzWJZJlhpHtDNn7FXHPwE8PsygqMmFpXGGs4myuQ7jRFyBG/XFw3ewkwDrViSvP+dhhdnQdoL/sbtQjXIqDKd7gij4cjCUoYh7D3aPyLfkOLOHZKmKcH5bAUs5VE20U49WREWzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=nAm2VKkM; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ATecxBb9; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="nAm2VKkM";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ATecxBb9"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HII6P63369870
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 00:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=JrTA2HwGMKIp7t4pWKHEf1FBnA9XzoQUlR6nw/XdevE=; b=nAm2
	VKkMyW2bhU4dTw3v+X97ZY/W6M1TN5X6gsN0OM0LBT3F9yVF2CV33sZTIQtzlQey
	m8ZV5W60SsTtUl8DzFzkYeg2PqY0gRJVkWBETuVRmyG86C7yLpkZlL7EolJCgGb/
	StH3wGZ5LBTiGjYIOfyNyNFVgKjehTMUX7hPAwZQA1IBoCMDys94bou7F0u7jmgY
	DnNcx7qsBD5aWWGHk3AX33yderZYk7tXvDQy2j5NvNfwJh0tu0ZOAk8Mav9e5MxW
	GVDBweaCwsVY1YgTmco4yTM9YLSbVsruSi7jjubSV9TyIMIuGL/eG+MmOE7LERHI
	jyCCA1TqMKx3fpPiVg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gr3dpn4f0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 00:49:26 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8914aeaa16aso2423547b3.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789692566; cv=none;
        d=google.com; s=arc-20260327;
        b=DL/NZli9gMtPOZBjIPnPxKOHHXqCAK8Sj0CRFcGGXThRQf4d76Uea93RgwTzUtnu/G
         nuJOpS1NlrVPDUgNqYA8A+x/Xrm+ldYgcEDo83xNeNbj8cz4pZ/QXS1vIZ+O2IE4s/GC
         WtDtLnFyKZGXXN25jI89ge4ilOrzMtYdf3HsoxTZinBg4ZbrJOpKSQKCPuUtknKREByV
         QZTUyIt1clH9zikd93UYUqya9dJYpGLj6hsfznTSS4widPP2rAG8Yl0i5z04ssrW3tVN
         PK77YCLWAMy/dgTrD2RUysgCJSeAAp34edT1weDmR77DzoFVQahQyzBQM2D8YUCJciLQ
         ZUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JrTA2HwGMKIp7t4pWKHEf1FBnA9XzoQUlR6nw/XdevE=;
        fh=yEwDLFEpR7vZPZHgjppIeIj4fICB1i8cqKOclAVC8Rs=;
        b=D/zWnloj4gXyzLn3F3LVwxgAJwl0luh7bY85zeGc6OW17ocroFo0aoc1bs0vr1+6j0
         ZbLM+jdtQO5Flbgsut/wUXwNQ3fvMT/vEblYW7ogurjYAUvSl3UGfg6kT8Hg52j/4n/n
         hrLk5fE2g2NTt14AwXWe1+Rpof14bqUCK17aUoS92ELCHYtzJZ+o12kNmHuyWMHO/fVc
         VTZrP9gg/hGbqBGzr5kt2Ve4V+BN0QPGDOj3VaM/At4pYiP3GiGSGKEFNI/zDZfFv/La
         s52v4mm3U3E/puAUpRQKUKOJATYxJSDoeB6eGnV98CIrVRCGHOGBybplNNrCQUs/Z37D
         UsXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1789692566; x=1790297366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JrTA2HwGMKIp7t4pWKHEf1FBnA9XzoQUlR6nw/XdevE=;
        b=ATecxBb9OkYmnoeQ/tfsJ615Fle8DuvsoHchcmrKG/l9OEUQC9qTncPCl9m0cC3yoh
         8f2/SF3io768yfIR5si17L8BiMVaDK/4NdXp61debBVbL92pCtjB8IZxVDhLi86qhsjZ
         MqAhps73e5LqDs426YpvF372kTHsUmygh8SIinsntvLkQqqb2Jj2QM5C2jaYi7vINW/Y
         ewbMf5ELjXck31rEWFpTyrFJsoCVhCzNP3aWwuWLqNeLvOYQFAmfDBQDtWEQjI2ggPxT
         6hygOBKYS/9OPvcLX61wwaGmbUGKpJ614WtEOANYDGMYx3mdzSWTD1oc/4gZiOS8EMLU
         gVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789692566; x=1790297366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrTA2HwGMKIp7t4pWKHEf1FBnA9XzoQUlR6nw/XdevE=;
        b=jLvbFMeey52Z3Dbpcb/1cn4ALFSERqUaSdZSOzHR5ZMXtBJ/lxZuomrwqJCNHLPKG/
         v2hWdvC6VWJiWOxdPyE1AjuJ+NNnQGmVHhOh9wLRiQ1Mhx5qEGTiHYKIiw/aqp8b1iBv
         nDE8O9G4Oc8vbxnmgrC3vuajTtTpZJUkzw3+yIoKx8sSHTzj6B+JjYuTCX+UKx7xVkTs
         bxJIYYk0YJFNubiNO3SqIh6qDB0080aaD2qOtFsjyN4gyqwFPrRpvVriXtddXTrRBqhQ
         64qblBWNOzzTqVaS6nDjRAhsgPPbra55gzLQfUlJHM/YLEJH4zFrLUZl67KO5Rc6IaXv
         oaew==
X-Forwarded-Encrypted: i=1; AKwUvBxkddDq0UNQPXDj59x+39EoORGCt5qw0YEylY2AfUuynOHXpb8yMPqVzJObxqVlxp1f/5k=@vger.kernel.org
X-Gm-Message-State: AFuF++nyp2g0PIRm5XTldngEPN6sN+7TPA45z7FU8uevxR2v4gScaQPi
	/FhfzYCGIqwgFSLYt7FZ3gWMYvv2uYQhSuVJzvqwLd6CegZyGNTtv+H2dlMs1Azh6WQJ8K7OA1z
	gIFkaDkseUomxPesoDO0ejjlY4HcgydMEqUPZ/pb0Raznc2+e2JmUc6FqmuBLfNkR/HxZeG8VAd
	aaWfyW0N1WDoRTOOdE/0ma/1RyO3jt
X-Gm-Gg: AYBFou2iv9QwJvbu0gRi3RVue8kNuwZt17LbZ5IK/HXnlkXTEoeMjKyg5VgjspxsdBt
	L3VRbVDjs5fTk9zm00fhYuyM8ByoV/ImE8p2lZxwW7TUp9xvXykM+pfKFz4u6J1i+4q+XyymP2e
	ZYHshqIB+/CcbVXHcHNXHYTjI1XmN+26pJR86/V7MVvGm2SK0Nw8HZvJ0Deg==
X-Received: by 2002:a05:690c:4026:b0:88f:73b0:fa87 with SMTP id 00721157ae682-897311d541cmr2406317b3.11.1789692566553;
        Thu, 17 Sep 2026 17:49:26 -0700 (PDT)
X-Received: by 2002:a05:690c:4026:b0:88f:73b0:fa87 with SMTP id
 00721157ae682-897311d541cmr2406197b3.11.1789692565954; Thu, 17 Sep 2026
 17:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4zRHEeQ@mail.gmail.com> <CAOu3gNhjPamqZgcxBj7Sgmr+B76qPC+O1hdWg7dY3uNuat+UMA@mail.gmail.com>
In-Reply-To: <CAOu3gNhjPamqZgcxBj7Sgmr+B76qPC+O1hdWg7dY3uNuat+UMA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 17 Sep 2026 20:49:13 -0400
X-Gm-Features: AcwNN1XENE7b2PhilXUV9R3tnI_4VG0H2DTo0CTeGlbU3eQ7adQBrAzjEPZozgU
Message-ID: <CAOu3gNhbz0m7=cPAAD-NWPix-TCL7B3iFFTHn1JzaaukAXP3oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] libbpf: BPF program dynamic loading
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: VE-cHydN9XhP-faoGDJdsX2tQLNiHUyh
X-Proofpoint-GUID: VE-cHydN9XhP-faoGDJdsX2tQLNiHUyh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDAwNyBTYWx0ZWRfX3LH8GDQuUgC1
 MMPym0dEWeD98wbEzZHS9sSJ+5/M0JrtdtTMY4Yybz6es+YvQzB5pHD1XnkWFzw511duM/rmWyR
 VtALK6zVDSAjEOz0H5uwfpQ4tPVJwmJy9PRWgw4knbBq0phQ8JcZ
X-Authority-Analysis: v=2.4 cv=UerE26SN c=1 sm=1 tr=0 ts=6aac8a97 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=Pgacwa0oAAAA:8 a=rlCgVymONP-Ov0OCyKcA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=xnLNWz09G3ZUmE6K9NTY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDAwNyBTYWx0ZWRfX1XQDloBDmXma
 s+CV9+hUAmxDqSvVFXfNbQmaNzzPvS1YphXUl+OzgwvZ511+qhySjBf0IjNJ7gAa0vkPfoHYD1M
 kqImdulPIkVB3ETaVX2Vr7FynJ8Mx2xlbe4zb1lZx2EWwMaqVacVu/bgSlm4bTG2vOo4vC/LlmS
 9K6RJDsHgtJgCwY3jjlgGEo5ziqyEcu2PrOrIGuOjoRWmX43DA9mWIsAIUtvcdb9FcFUt/PzhWE
 varyDZ7jKrmOu+0m4+hea4E70p5+gLPYvCEORxV7NYtKyiCJ9q4NLdCdujI0h+vr/yzhpgRiX0W
 hkiVp3JAyur9+Mf5HljH6G918vAnp6ROuvnAz5TofgMQZbD5fFesr6dNpOJxtNf3V2sZTDB/JTY
 8f+RGR8xu4foodoO345B2L/ZDdcAwhniG/tmCbrf0zSvkAdBpkRRmbtkMwUv4P77BdQFmxOraBl
 P3tSTU6Hw1LAFxXX3Yw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180007

On Wed, Sep 16, 2026 at 8:45=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Fri, Sep 11, 2026 at 7:47=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > This series was originally posted in January 2025 [1] as
> > > a two-patch RFC introducing a per-program tri-state load type
> > > (disabled/auto/dynamic) to let large BPF applications load a subset o=
f
> > > their programs lazily, after the initial bpf_object load.
> > >
> > > We looked at the object-wide opt-in flag Andrii suggested as a
> > > lighter-weight alternative to a per-program enum ("all programs may l=
oad
> > > later, opt in via bpf_object_open_opts"). Problem was that it collaps=
es two
> > > states that need to stay distinguishable at the level of a single pro=
gram:[2]
> > >
> > >   - a program that is not currently loaded but is *expected* to load
> > >     later, gated on runtime configuration; and
> > >   - a program that is *permanently* not going to load on this kernel
> > >     (e.g. it targets a symbol or struct field that doesn't exist on t=
he
> > >     running kernel, or it lost out to an alternative implementation a=
nd
> > >     will never be used on this object instance).
> > >
> > > A per-program enum keeps that distinction where it belongs: disabled
> > > stays fully excluded from relocation/map-creation with isolated failu=
re
> > > handling, auto is unchanged, and the new dynamic state is the only on=
e
> > > that opts a given program into later loading -- without implicitly
> > > promoting every other disabled program in the object along with it.
> > >
> > > This v2 keeps the same programs and tests we originally proposed, and
> > > addresses two additional requests from Andrii [3]:
> > >
> > > 1. bpf_program__set_autoload() is converted from bool to the new
> > >    enum bpf_prog_load_type, so it remains source- and ABI-compatible
> > >    with the ~200 existing bool callers (false->0, true->1 already mat=
ch
> > >    the enum's DISABLED/AUTO numbering), while becoming a thin forward=
er
> > >    to bpf_program__set_load_type(). It intentionally continues to rej=
ect
> > >    BPF_PROG_LOAD_TYPE_DYNAMIC, to preserve its original on/off meanin=
g --
> > >    dynamic load is only reachable through set_load_type().
> > >
> > > 2. A declarative way to mark a program dynamic-load-eligible from its
> > >    source, as an alternative to an imperative set_load_type() call, u=
sing
> > >    a new BTF decl_tag.
> > >
> > > Motivation:
> > >
> > > Security tools built on top of libbpf commonly ship as a single large
> > > BPF object containing many programs, only a subset of which are neede=
d
> > > on any given system -- the rest are gated on optional features or on
> > > kernel/runtime capabilities that vary across deployments. For this cl=
ass
> > > of application, per-program dynamic loading helps in two ways:
> > >
> > >   - it shortens the initial load, since only the programs actually
> > >     needed for the running configuration are loaded and attached up
> > >     front instead of the whole object; and
> > >   - it lets a single failing program be unloaded and possibly
> > >     reloaded (or a feature toggled at runtime) without tearing down
> > >     and reloading the entire bpf_object.
> > >
> > > Both reduce the time window during which the tool is partially loaded=
 or
> > > inactive -- for a security tool specifically, that is also the time
> > > window during which the system it protects is unprotected.
> > >
> > > We have been running this with our internal fork of libbpf in product=
ion
> > > for about a year. Depending on kernel and configuration support, arou=
nd
> > > 250 of our programs are potentially loadable on any given system; wit=
h
> > > dynamic loading, only around 90 of those are actually loaded by defau=
lt,
> > > growing to the full 250 only when every optional feature is enabled.
> > > Cutting the default set of loaded programs from 250 down to 90 measur=
ably
> > > reduces load time (we observed ~60% reduction in our own measurements=
),
> > > and since unload time scales with the number of loaded programs, it
> > > correspondingly shortens unload time as well -- which matters, since
> > > slow unload can delay system shutdown. We believe this functionality
> > > would benefit other libbpf consumers with similarly large, modular BP=
F
> > > applications.
> > >
> >
> > we should try to use this functionality in veristat, see if it can
> > more cleanly replace clone-based solution we have currently.
>
> I will look into this, in my next patchset iteration, I moved (by your
> suggestion)  the gating for manual loading from OBJ_LOADED ->
> OBJ_PREPARED, this at least according to code review should allow
> this. I will dig deeper into it.
>
> Andrey

Following on this - I  swapped bpf_program__clone() for
set_load_strategy(MANUAL) + load_manually()/unload_manually() in
veristat's process_obj()/process_prog(). Builds clean, test_progs -t
veristat passes.

One isue spotted : load_manually() calls bpf_prog_bind_map() for
RODATA maps on every load (via bpf_object_load_prog()), which clone()
deliberately skips to avoid mutating object state and Mykyta even has
explicit comment about wanting to avoid this. Since veristat loads
each program individually, shared RODATA maps now get bound on every
load. But they also get unbounded once we unload the program (drop its
FD).

Andrey

>
> >
> > >
> > > [1] https://urldefense.com/v3/__https://lore.kernel.org/bpf/202501222=
15206.59859-1-slava.imameev@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!1zjO5-1CVI=
Chpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjBPDLExnfctIUG_V2ATb=
p4Ecz6a8j3WfggToQ$
> > > [2] https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAOu3gNjg=
5vQ=3Dt0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia*rdNw@mail.gmail.com/__;Kw!!BmdzS3_l=
V9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjB=
PDLExnfctIUG_V2ATbp4Ecz6a8j29k6Njrg$
> > > [3] https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAEf4BzZK=
y5Wv_TxtEqsbzW*v-tO28kgY=3D9RhXrnbPhOZcVbOSA@mail.gmail.com/__;Kw!!BmdzS3_l=
V9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_isDyjB=
PDLExnfctIUG_V2ATbp4Ecz6a8j2Xo62azw$
> > >
> > > Andrey Grodzovsky (2):
> > >   libbpf: Convert bpf_program__set_autoload() to load-type enum
> > >   libbpf: Support declarative dynamic load via BTF decl_tag
> > >
> > > Slava Imameev (3):
> > >   libbpf: BPF program load type enum
> > >   libbpf: BPF programs dynamic loading and attaching
> > >   selftests/bpf: Cover BPF program dynamic loading
> > >
> > >  tools/lib/bpf/bpf_helpers.h                   |   5 +
> > >  tools/lib/bpf/libbpf.c                        | 273 ++++++++++++++++=
--
> > >  tools/lib/bpf/libbpf.h                        |  32 +-
> > >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bmdz=
S3_lV9HdKG8!1zjO5-1CVIChpj-ePa0a0tLxU67BvclwUXzHIWVFj9j9rj9WraXxTZW7Bumk_is=
DyjBPDLExnfctIUG_V2ATbp4Ecz6a8j2Lf3q1jA$                       |   4 +
> > >  .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++
> > >  .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++
> > >  .../selftests/bpf/progs/test_dynamicload.c    |  40 +++
> > >  .../selftests/bpf/progs/test_load_type.c      |  31 ++
> > >  8 files changed, 741 insertions(+), 33 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicloa=
d.c
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.=
c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicloa=
d.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.=
c
> > >
> > > --
> > > 2.34.1
> > >
> >
