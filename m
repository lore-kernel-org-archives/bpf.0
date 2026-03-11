Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5237320A14
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236126; cv=pass; b=gQKrJb5c7U1b0+mw6VOz0mH0Yi9YsO9qFojIIFi2HNOiKFiSAaJiRoaaKtkZEKGLgZf46O7Vdy967PmT4LH3gBp+Pq0TG/lPpa5BdUZCMBsjovehrdXdJ1EMaJInKxTbUpSuvLJZmnyp3ccu4e1s9uWwoX4ZMCLy7jrpBuiiZ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236126; c=relaxed/simple;
	bh=nvOKUMRUe0usnrxc7Ff+ieh4hYzaeRGoH8OxHCp9t5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oT5AN++bCk6HNbTiIljLHcsJ8Xh7IuTsedDjdQNgXQQpO7akPN44ZFI2jEBLgwj8M4F0hdCoGMm57skAD62+ZXrbtyvkkJSSy5rmxgBvsnWqC95xSxYVluO4Hrj1KTy4jmKyo7pjq7ICY7Sch1KEtUetqAh9Szo94G7X2VV5OoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=JVe5GrEt; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=QqlnDdGK; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="JVe5GrEt";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="QqlnDdGK"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BAvgCM3430988
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=7S9S9UoOMIuHa5NlvzI7Vk3PifRxd+RjHqSmXhMVW/U=; b=JVe5
	GrEtGz16mLQaUBOe7seRPrW0V1tHU6Ry08Zgtl5Yfa+Fg8ufRxcEC7JARn1K+vbi
	6IEmmOsL1cs0k9L+X5T3BFYoUIEb/d2n8mdYFlSXnwfq4Wmakn6IDtUCWdUdRGLw
	j+LT7/erSEp49xk9npUtHos84vtssCGdC306z4JwYQNS3tNUVkkHNRsDC7eDfrBf
	VkYwAUMKIwxDeFy0iJzRN48fgNfKtrUxQUo1L+2L6Q1O1YUJxRrabKlZiL0kdlQx
	XkDwnDncmB4hJSDVGEGnyvkezhz0jefArFGcQopkE8o3NLRBdrzmJSnFWh19inff
	xa0lMpJiFwoiXr7Atg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cu73mrgv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:35:17 +0000 (GMT)
Received: from 04WPEXCH007.crowdstrike.sys (10.100.11.74) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Mar 2026 13:35:16 +0000
Received: from mail-yw1-f200.google.com (10.100.11.78) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Mar 2026 13:35:16 +0000
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7949310b90cso290831287b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773236116; cv=none;
        d=google.com; s=arc-20240605;
        b=AbLpJ81pIM3cGVoGKoZjLcMB7m2zcp0KStFxsvwJG78BIeb3vM/EAVorMZq7+91HN8
         cEMCcKIiwlaAB/8R99fsl6/p8sUfGZE/tzBVHbRgnysolkcwzy1B3tj76vCqJJXS6nFw
         vn6vU27kl94j14Ds3U1j1I4JzPap3kDYV+flHqbEo2aqiLlZzgsFOA7naGNEUVyg5RV1
         cY5Ee7W0GmgiN/84Mq+dgWa+dcJ2c0kmOlZgEl8v3BZl5BfKw0j2RS7cYJrhBNAxutQT
         EvnRFR/lxhT3+0mjJGgAjcIGNtl44Q6DfrmqIvIUFk2zLC4BG+MwlIIefP5cL36uzN2W
         vuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7S9S9UoOMIuHa5NlvzI7Vk3PifRxd+RjHqSmXhMVW/U=;
        fh=mEFf9t2ltM76T2CuUxUcd63aluRwapzyYCSPmTOfYFY=;
        b=lKkyTmR24jKzcUcctA03aAKvwoouP1U22O0cxELZMab+I+lCLKnspWFdMPTAhf2pGC
         4301g/8qaFn9REefjzChgvYs3e/CQjXuMNSar1r2fUD938C+juSMOG3qdVVXMoJkeqfx
         KoNm11905NYtNvhG9cZ/i7mj7hfWiD4/wsjqR+LlgjLj4UAAEfuBwxZDqNj6F+UBggsM
         JwJdNoES9qRXDLmQ4pwrqLSC24ptLrKPEZqXVOT0DkVLni8FT7Ybvf1uxGpSrhVNPfCi
         7RUiqZ27qCJXAte2J85Z6CxC/n39n9m99v0sYQLvXK0ktxDSeMAdCSSRFTBb04JuWQVm
         ultA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1773236116; x=1773840916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S9S9UoOMIuHa5NlvzI7Vk3PifRxd+RjHqSmXhMVW/U=;
        b=QqlnDdGK8fpine4ioW/TOoJOjhn9JrCBkgie2eFWjsNCzNkLMxtMys6vZi2qDom/Ar
         gYTe/NOAG9H6GJVGehHqm5UK1UBrsNQ54e8nV2IlV3MP3L9msqkDosMt6sQ11yuq0/ic
         N0CO6/+udr/WVlyKGhOhgujpX0SOhf5FWXTqsaue8qzEYClOMiyqPihQvWjtQe3YZ8b8
         h+iA1I1ldtet/diVLITPQutdLVs4EQxXeGL2EV/VdrufAFcRQTt2+fE41BU5aUOg8Bpv
         LiNSusaN5AmPyo/Y3mODNFFNd7A7NtkbDq2/ue0W7L8Uf8A6zU34qdekIQmXxWS0Vif1
         Tm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236116; x=1773840916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7S9S9UoOMIuHa5NlvzI7Vk3PifRxd+RjHqSmXhMVW/U=;
        b=ggMvyVxa43pflvOCeGhlqrCq/rshsSRkgu2EfxDXh/93ok5cmSlrE/RrdtFFlnOp8h
         11JNBJ7vs0Ea6uZx/SZA4sovSQuK07D8EK6wDe31DiLEmqbXzE4CjAKvnirZXkqyti19
         ptFIx2GJBEK40k4vKFdqLo0HU8lq8FKPVj3mAQht2HZB8nRU9HQria1fgfl6RQ9NkCls
         +2aHl+wPLETXiY9UMuKrruYN3nwx7K+TOgAIgBrtpzPR8fmF/YDrUE+02Y54rAfMIR1O
         bvYT+D1/Zj/R9lZ4VrbEQpKL5xCOuymPw6JL92fzigH2KUw0gX5frEmwu0NNw4wZByGR
         mLkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8o58Lm27ulANh/csTTPOF5vHejF5SHKql2Im7/rzJhMflPKD8UznX3+lkYblqHHVmS/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZSrzFUOu4B/H7877rbcCrPpqXHQ4eu8R2UhpIkbKd2JKljty
	gw584Ax0i7/9OF3mG7gsoKMRG9I1AtwsydYA/FeT9mZyf8SnRcS6aYxICboSo/ZB8+7roFEND4G
	uisHJp8j7nHj1dFOi0lSFXPDhQMmOjXTgMHFJn0/ay3qUmg7ax6hy0/5Mm2rrqB4Nn5MZukyMbA
	IbRZ47CGkO0EZTQJEGRjxsqf05mdKnh4hVWNv6ml4cWeM=
X-Gm-Gg: ATEYQzzbQL0d4xGKkbonZBpnPghKs8nB6xg8jTM+RMO6s1zaiQZndhqJKmeWt5NFmsM
	o04o2f6lTgdBHcR4Bzw2HQnW44eAiv3RgdbYFD4Zqrz1K53hI3t2r+g11RBeBjW24/mZMkcRH+o
	KstwFKg4bD/wEAfA92WuO4DQYgDgkNwgSIjBqByPVvm2iG8Q8iCx72VMaAeF04YQPcwnwDJDzda
	PCh
X-Received: by 2002:a05:690c:ec5:b0:798:cab4:5579 with SMTP id 00721157ae682-79917e5b163mr24025617b3.13.1773236115695;
        Wed, 11 Mar 2026 06:35:15 -0700 (PDT)
X-Received: by 2002:a05:690c:ec5:b0:798:cab4:5579 with SMTP id
 00721157ae682-79917e5b163mr24025127b3.13.1773236115034; Wed, 11 Mar 2026
 06:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <878qc0mtq7.fsf@gmail.com>
In-Reply-To: <878qc0mtq7.fsf@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 11 Mar 2026 09:35:03 -0400
X-Gm-Features: AaiRm50qeQwLrTfj7En6df6JBUpMzshSf1hFMmf5aksO9oNquOKnHsTpuUScVps
Message-ID: <CAOu3gNhWV6iWsGqFrkL-xgrkJA_YdpvrOsOgk02R9_scVn0DZA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-GUID: 2ebQ_ogiOu537Oio62fUfMFgYY4mZQZS
X-Proofpoint-ORIG-GUID: 2ebQ_ogiOu537Oio62fUfMFgYY4mZQZS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfX9k3TkybhhXkg
 ySPONx+HyXN3mbCdilm6iV1Ej6A9miFMPY2yT5UK/Sh8XE9iI7pRnHoRdJJrESAm1dmvRgo6UlI
 FpKsa5jCxEdeLTXwgYMuM+PquIj5OJBg+jYWJBToJfqlZnahc61WskgnDULSW03Nzqr+z9/pBQm
 a+sjb5O4w75ZLOh7Ur8maLpS9Gb2XcQJmUHblzEzNbmH8QehNlDO+Kl8lU5uxb/QeDSFMqkrSWA
 zy3VTbXgDw2TUZTCh5o4kkG5GJOZ7g3EBR08AhuMYhnAjXoOujPpTBM2SKKO8Bu0v7mG1y1GozM
 Anm3sY6peDSm5vXNfAhNXT9V8RnBdSLxGT+B0DjEKdap4EwM6mEIykPEZAPOF+0KhhNm7C6EBmS
 0UXoNvtA61aCCjsqVUSPlXiYtkEkY3ovWe21Wwdwf54sbMZr+4o0QvqbkfrclV/EjM6YsfHreY/
 NLDyCX18MMzksVvfsxw==
X-Authority-Analysis: v=2.4 cv=UYBciaSN c=1 sm=1 tr=0 ts=69b16f95 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=Pgacwa0oAAAA:8 a=pGLkceISAAAA:8
 a=VabnemYjAAAA:8 a=iieZuBFDrjkZybkJEKkA:9 a=QEXdDO2ut3YA:10
 a=xnLNWz09G3ZUmE6K9NTY:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11726
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110114

Thanks for the reply and all the clarifications! We are looking forward
for this patchset to be merged so we can try to integrate it into our
dynamic loading solutions.

We will reach out with further questions down the road as we take a deeper
look into this.

Andrey

On Mon, Mar 9, 2026 at 8:08=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> writes:
>
> Hi,
> Thanks for reaching out, I'm providing my own opinion on this, I did not
> discuss this with Andrii in depth.
>
> bpf_object__finalize() - you probably do not need this, the mentioned
> example of bpf_program__set_type() actually rejects when object is in
> LOADED state (you can't mutate loaded program).
>
> To make your dynamic loading/unloading work, you need to keep your
> object in the PREPARED state indefinitely. As clone() uses some of the
> fields that are destroyed by the post_load_cleanup(). calling
> bpf_object__load() in this setup may be unsafe (leaking fd, etc).
>
> We have a precedent with bpf_map__reuse_fd(), bpf_program__set_fd() does
> not seem too extreme to me, but it seems like some lifecycle invariants
> are changing, as we'll have loaded program in prepared object, which I'm
> not 100% sure is a problem right now, but possibly going to break
> something.
>
> Also a small detail: bpf_program__clone() does not support PROG_ARRAY
> maps (just in case you need that) (see cover letter for details).
>
> > Mykyta and Andrii Hi!
> >
> > We're evaluating the bpf_object__prepare() +
> > bpf_program__clone() API for use in a production BPF
> > application that manages hundreds of BPF programs with
> > selective (dynamic) loading =E2=80=94 some programs are loaded at
> > startup, others loaded/unloaded at runtime based on feature
> > configuration.
> >
> > We have a few questions about the intended usage and
> > potential extensions of this API:
> >
> > 1. Compatibility with bpf_object__load() and object state
> >
> > After bpf_object__prepare(), the object is in OBJ_PREPARED
> > state. Several libbpf APIs (e.g., bpf_program__set_type())
> > gate on OBJ_LOADED state.
> >
> > Is there a recommended way to transition the object to
> > OBJ_LOADED after cloning all desired programs? For example,
> > would a bpf_object__finalize() or similar API that runs
> > post_load_cleanup() and sets OBJ_LOADED be in scope? This
> > would allow users to benefit from prepare() + clone() for
> > selective loading while keeping the object in a state that
> > the rest of libbpf expects. Or, is the new API not intended
> > to work with bpf_object in the first place ?
> >
> > 2. Storing the clone FD back on struct bpf_program
> >
> > bpf_program__clone() returns a caller-owned FD, but APIs
> > like bpf_program__attach() read prog->fd internally.
> > Without a way to set the FD back on the program struct, the
> > caller must reimplement attach logic (section-type dispatch
> > for kprobe, fentry, raw_tp, etc.).
> >
> > Would a bpf_program__set_fd() setter (similar to the
> > existing btf__set_fd()) be acceptable to store the clone FD
> > back, making bpf_program__attach() and related APIs usable
> > with cloned programs?
> >
> > 3. Use case: selective program loading from a single BPF
> >  object
> >
> > Our use case involves a single large BPF object (skeleton)
> > with hundreds of programs where a subset is loaded at
> > startup and others are loaded/unloaded dynamically based on
> > runtime configuration. The current approach requires either:
> > - Loading all programs upfront (wasteful), or
> > - Maintaining out-of-tree patches to libbpf for selective
> > loading
> >
> > Last year we made an attempt to upstream our solution to
> > this use case to libbpf[1] but Andrii pointed out how our
> > approach was problematic for upstream. He then proposed
> > splitting bpf_object__load() into two steps:
> > bpf_object__prepare() (creates maps, loads BTF, does
> > relocations, produces final program instructions) and then
> > bpf_object__load().  We are trying to follow up on his
> > input and become more upstream compliant.
> >
> > The prepare() + clone() API seems similiar to this,
> > but the questions above about object state and FD ownership
> > are the main gaps for production adoption. Are there plans
> > to address these in future revisions, or is this
> > intentionally scoped to testing/tooling use cases only?
> >
> > Thanks,
> > Andrey
> >
> > [1] -https://urldefense.com/v3/__https://lore.kernel.org/all/2025012221=
5206.59859-1-slava.imameev@crowdstrike.com/t/*m93ec917b3dfe3115be2a4b6439e2=
c649c791686d__;Iw!!BmdzS3_lV9HdKG8!wUu6d5O6o0uz-H7DEauZ0RGiTE7PdgMOgRPqHPUf=
mckEC1CBLs9ELwahqm-eLff0agg3fL7Ii21gdx8YQZkJyFxBWRFv-gkIXMwtIjk$
> >
> > On Fri, Feb 20, 2026 at 2:18=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Add bpf_program__clone() API that loads a single BPF program from a
> >> prepared BPF object into the kernel, returning a file descriptor owned
> >> by the caller.
> >>
> >> After bpf_object__prepare(), callers can use bpf_program__clone() to
> >> load individual programs with custom bpf_prog_load_opts, instead of
> >> loading all programs at once via bpf_object__load(). Non-zero fields i=
n
> >> opts override the defaults derived from the program and object
> >> internals; passing NULL opts populates everything automatically.
> >>
> >> Internally, bpf_program__clone() resolves BTF-based attach targets
> >> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> >> func/line info, fd_array, license, and kern_version from the
> >> prepared object before calling bpf_prog_load().
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c   | 64 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
> >>  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS=
3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6Uok=
YqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  |  1 +
> >>  3 files changed, 82 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 0c8bf0b5cce4..4b084bda3f47 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct b=
pf_program *prog)
> >>         return prog->line_info_cnt;
> >>  }
> >>
> >> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro=
g_load_opts *opts)
> >> +{
> >> +       LIBBPF_OPTS(bpf_prog_load_opts, attr);
> >> +       struct bpf_prog_load_opts *pattr =3D &attr;
> >> +       struct bpf_object *obj;
> >> +       int err, fd;
> >> +
> >> +       if (!prog)
> >> +               return libbpf_err(-EINVAL);
> >> +
> >> +       if (!OPTS_VALID(opts, bpf_prog_load_opts))
> >> +               return libbpf_err(-EINVAL);
> >> +
> >> +       obj =3D prog->obj;
> >> +       if (obj->state < OBJ_PREPARED)
> >> +               return libbpf_err(-EINVAL);
> >> +
> >> +       /* Copy caller opts, fall back to prog/object defaults */
> >> +       OPTS_SET(pattr, expected_attach_type,
> >> +                OPTS_GET(opts, expected_attach_type, 0) ?: prog->expe=
cted_attach_type);
> >> +       OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0=
) ?: prog->attach_btf_id);
> >> +       OPTS_SET(pattr, attach_btf_obj_fd,
> >> +                OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_=
btf_obj_fd);
> >> +       OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd,=
 0) ?: prog->attach_prog_fd);
> >> +       OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: p=
rog->prog_flags);
> >> +       OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) =
?: prog->prog_ifindex);
> >> +       OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) =
?: obj->kern_version);
> >> +       OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: ob=
j->fd_array);
> >> +       OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->=
token_fd);
> >> +       if (attr.token_fd)
> >> +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> >> +
> >> +       /* BTF func/line info */
> >> +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> >> +               OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_f=
d, 0) ?: btf__fd(obj->btf));
> >> +               OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, N=
ULL) ?: prog->func_info);
> >> +               OPTS_SET(pattr, func_info_cnt,
> >> +                        OPTS_GET(opts, func_info_cnt, 0) ?: prog->fun=
c_info_cnt);
> >> +               OPTS_SET(pattr, func_info_rec_size,
> >> +                        OPTS_GET(opts, func_info_rec_size, 0) ?: prog=
->func_info_rec_size);
> >> +               OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, N=
ULL) ?: prog->line_info);
> >> +               OPTS_SET(pattr, line_info_cnt,
> >> +                        OPTS_GET(opts, line_info_cnt, 0) ?: prog->lin=
e_info_cnt);
> >> +               OPTS_SET(pattr, line_info_rec_size,
> >> +                        OPTS_GET(opts, line_info_rec_size, 0) ?: prog=
->line_info_rec_size);
> >> +       }
> >> +
> >> +       OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
> >> +       OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
> >> +       OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
> >> +
> >> +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc. *=
/
> >> +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> >> +               err =3D prog->sec_def->prog_prepare_load_fn(prog, patt=
r, prog->sec_def->cookie);
> >> +               if (err)
> >> +                       return libbpf_err(err);
> >> +       }
> >> +
> >> +       fd =3D bpf_prog_load(prog->type, prog->name, obj->license, pro=
g->insns, prog->insns_cnt,
> >> +                          pattr);
> >> +
> >> +       return libbpf_err(fd);
> >> +}
> >> +
> >>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                 =
      \
> >>         .sec =3D (char *)sec_pfx,                                     =
        \
> >>         .prog_type =3D BPF_PROG_TYPE_##ptype,                         =
        \
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index dfc37a615578..0be34852350f 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(con=
st char *sec,
> >>   */
> >>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> >>
> >> +/**
> >> + * @brief **bpf_program__clone()** loads a single BPF program from a =
prepared
> >> + * BPF object into the kernel, returning its file descriptor.
> >> + *
> >> + * The BPF object must have been previously prepared with
> >> + * **bpf_object__prepare()**. If @opts is provided, any non-zero fiel=
d
> >> + * overrides the defaults derived from the program/object internals.
> >> + * If @opts is NULL, all fields are populated automatically.
> >> + *
> >> + * The returned FD is owned by the caller and must be closed with clo=
se().
> >> + *
> >> + * @param prog BPF program from a prepared object
> >> + * @param opts Optional load options; non-zero fields override defaul=
ts
> >> + * @return program FD (>=3D 0) on success; negative error code on fai=
lure
> >> + */
> >> +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const str=
uct bpf_prog_load_opts *opts);
> >> +
> >>  #ifdef __cplusplus
> >>  } /* extern "C" */
> >>  #endif
> >> diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.m=
ap__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtf=
aqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  b/tools/lib/bpf/https=
://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0W=
l_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel=
1BiJSjA99yzJZk$
> >> index d18fbcea7578..e727a54e373a 100644
> >> --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!=
BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0=
N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> >> +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!=
BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0=
N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> >> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
> >>                 bpf_map__set_exclusive_program;
> >>                 bpf_map__exclusive_program;
> >>                 bpf_prog_assoc_struct_ops;
> >> +               bpf_program__clone;
> >>                 bpf_program__assoc_struct_ops;
> >>                 btf__permute;
> >>  } LIBBPF_1.6.0;
> >>
> >> --
> >> 2.47.3
> >>
> >>
