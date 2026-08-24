Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54717375F97
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598848; cv=pass; b=CwIcAsTrokTdOuT3eiRhN2XD0Vri0EG4Z0jLM6yZ2lvUM6YCxDF7M8kDZF6ZCkZ+S4y2lMSLdT3Nn1Cyz6H6JRcJCvlMGYOU2BgVKqhspgzsueRR7iUVjGCRxN6swgwGCUafzIaQdkzD+K+317nMl6Z40bNRAmTpAYFsTj8HEy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598848; c=relaxed/simple;
	bh=c58jzVdyyMvHGU7R3HVy4hGK72xD9IqPTkGCO70P5/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr1COkCwzq1ykqmxTZd33dvR2sGjxf9LKEHzjvgTIviLfplW4p0mC4kOFBim00Fa5mCpJGPTbEkjngUiKEBEwNo3chRu4UCO1fS+faKT8XHOAslhicaLR1ZEafE8xADVTFt1kClVJJ+x+0ekcGO6F221+Vpm5Nmr9Xc2SaMVGm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=o1/hisuc; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EUi78I2H; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="o1/hisuc";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EUi78I2H"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OIhL0t2346807
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=QJUvWDRZ1YZ9VITCmcc7TBObPVlxhG1FdePbCBv5Pmw=; b=o1/h
	isucyXhC1gaewn2LEf/ot81N5diP5gz6A5o+kxLPNOQ6TTxeDsvJIlBe9Kd4Tja0
	V5bgkdNz/NJ0Y08tOZirAH7l/lQ2y8woe7e70uHvVc3FcEksT5OZiPPlkCamMk0F
	nGWxo8RFdQxF1A1jiBKrB6AmpVVhw4JKZXUy2GhgAUjxAqxdvNH5MPtw1jRb3axU
	j8YRvZO1nUkJcMd8bIx5LjK7tEmEVclQ7HBcqdbPYQS+RxPeBExcPbAurPZ07Vhg
	kfIPIdsVBDKkG8fKDiQ4N0a+xW4NckKHE91uLeM4BQbiju2i9VCT194uBGVmic13
	ITcEU6rzm3VfaRx2IA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4g7r8bn7b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:14:06 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6abfca68so53251557b3.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598845; cv=none;
        d=google.com; s=arc-20260327;
        b=Kwvjh0EeUgjs4FgndFbVQoadl0UAG/R4RKzPWXfXOnmS+Xj/3A2BJH4ZmEuxbOA09J
         t3zBSKxKPHRmRe3Tm/NpuKe7AtEYsg6ZTTtokwpoj3E8ht02TsJ/TY9lWOsXDWx9wEI9
         nx+Ihv+kGJuN+C/OicDlWGqsIWY/WOma2dJGP/WEfuSb84LuhjUGYv6G0O4dHFRY9vuh
         xL1Z5EGZ0WvoHF3UzrCIQyC/vlQwI3SSILAvR/UJpTspJ03mfC4IHUu1jV03cMjHuKKy
         KyWBXfgSHBQAra9kLLG2RxGqBY+C+M699162Xr+Uv8NF0H91HabWhijNQ2cWe9Yh8xbM
         XNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJUvWDRZ1YZ9VITCmcc7TBObPVlxhG1FdePbCBv5Pmw=;
        fh=O15/nwl8HV8G6ieXo2p7UI0Ao5Ahdq1tXaJVMJ2UZS0=;
        b=BiHRuMncPUbNXjbTVOmPEBljbTK7XuOsE/RPEGcHVMDFU6Q88d0bS5/34LtmaQgUKO
         ao6Pa322G8A6tKDw45W26v3EzEGncXRnPDnvBFdK8Barmd6fc52M5fMlJoJp+o7xOewN
         T9BycjaOxvsgA2gKCL5DHins4jAIh+MF2byd5YI7U9jZGkZMu/NiwpDCm+oRDqEKqYQi
         HdingXZYiAF8Bb8qvTGtaR5Q1Ud81IqdimqwpbNVXJavtG6qBtPfSzfvWD1DMQbveDHQ
         zir93brHmLCODcXbRZgF3CKsu7AU+Gqh+ZBJAEl7l6NiDwpxbDZjMzktEaPz0PUZhcjQ
         nuug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1787598845; x=1788203645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QJUvWDRZ1YZ9VITCmcc7TBObPVlxhG1FdePbCBv5Pmw=;
        b=EUi78I2HUry0htYwQxCRfRFQG3oJDVPgltBvxNb+iILX4vLHfy1ac2adOrKhNSBebc
         Ad1hkMf1I/dagajqbAdJKLTzun6JtUkwg+SM8mbadd/R7I6mrvJJNzoipfektD5P1od1
         vOT+w81ja2S4wDKqI+uyOM0vP8brhi698DtEOJV8opBZap2HMUMVSf9+KHI4T/B6EXLF
         u7PBuYOBsES/6p1azQXsZHVSnMAozlq9QgJlWy3LfjZD0GgP6G64Mr6CwOQ8WVWuUTMM
         8FAHcTQGWcqJuxtLEPOyKL6O+HdfRrRIwd4PwC6gZeDLNx7FJ7e85IPN1udyyc0sT3qA
         B52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598845; x=1788203645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJUvWDRZ1YZ9VITCmcc7TBObPVlxhG1FdePbCBv5Pmw=;
        b=nmQxOCmTf4o2sx4PLW6GzjKYYm5KBbdoebxtN7pR2Jbff3OnJP4rlOtmWrva6sutZ5
         k0qzNxTChr6N023A7wxovoLZF9d67TiXBT1U+MtdOMzRjIj+ttX8ltR4oUgdKJ8HRpr5
         NzX5DYbcNMbSrJgCP0cMftUEQ0/VWlAOTuSsackZ5rJ0Y3EV/hF/kQNt85VTIwI/ZngT
         sYI0OvqOOzNetWfI5MWmLfOISxwbLIUCfwubU0rbUbLukfGx93v8PJm58Ce3cw3dMGhW
         zVnQ6JmaXcapuOaqC7gLM6FkBilv8taJJV1j+dnqt7AIAyd6gnYbXr2+88VpigkYpHqc
         1IXA==
X-Gm-Message-State: AFuF++nobaI0c2TBVu43Mex8VWUISQUXKrrb/pMd9YFuEfR9echOHPU7
	JYC+gWCQsOd0srS2cMt26amaQQOhHuyuOC5HEfUvroSnY0TpZBeLOgMejHDFUOd3TfB7GmPlmp+
	ELutCMc680byWm5Tfkbn4t/e9xhbCXw0U9bqrMQHtejJmyi+/f2WvzRlykI+DR9m/JbH3imubDq
	zjLQG7OdEc7K9qMBN/qIvVy5REz8lM
X-Gm-Gg: AR+sD13uqOzj4WwDUWeEZz/I8G1aWe23iv50ZLFDZ3DcmGTBNjnu3dn6NMu5DLKzqrc
	VOq8IMGGy6UuzhBuqGSCeMRU37r5GUntGRofqdGn16sbowdycuS3HzggzGocGInIihegSC71yW1
	SjV+rVdKQSO0gOjPIYeNo4G582xKDBWVwZh8lOimNP6vxMoqm1DlQ+XpC5Wg==
X-Received: by 2002:a05:690c:6710:b0:836:ec4d:bb29 with SMTP id 00721157ae682-84c99f96439mr86192397b3.34.1787598845401;
        Mon, 24 Aug 2026 12:14:05 -0700 (PDT)
X-Received: by 2002:a05:690c:6710:b0:836:ec4d:bb29 with SMTP id
 00721157ae682-84c99f96439mr86191977b3.34.1787598844637; Mon, 24 Aug 2026
 12:14:04 -0700 (PDT)
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
Date: Mon, 24 Aug 2026 15:13:53 -0400
X-Gm-Features: AcwNN1WGM8mX9a4BV2A7_GJ-Bh169Z2XFGP4ozu9X7iBzi60sOdCH1z0wx0bEJg
Message-ID: <CAOu3gNj25-wRO0fSK2FRPyBFo767ksqso2TkBy6yRbbiwhEAzg@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: bUiWtEhBndHOaq5LjX7ddtKmfZ6JDScH
X-Authority-Analysis: v=2.4 cv=FI4rAeos c=1 sm=1 tr=0 ts=6a8c97fe cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=kdThuS-Off6B-rCXx0YA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2MiBTYWx0ZWRfXxvb7OdlOFTsB
 cnRAfwHcAOBZp2zsFLweRvoSSwSTvPl+dKa3Hjl9MUArEBkbY6h+GK35eGdqCytj0IMM7kdf8oZ
 +ANwtgScHHzhYuojHGxYqCA7Fxhmi13aI16AuSjUCws3KpjoPUfUGE3KHjcrn6+NaVbTP6YiK6G
 lYjFy6CVUnWZjGDbj4qRddQ5SpL0rVU0jgNb2ZRChCkg25AeVTS5zQEFKtNaKYv/ZUkNMio59vf
 si3jSXW6CrgZwOfif3QlOYUkCnzx4W7gJ0laq5Ui5wvd3c/3QYjB2Oi8CwBUslZ5sFP6pWfZo0t
 GmVYy8GgDo8ripmgNTb6h/9tljwYz3N2QdpR1h7fuAuJa/eoJp7TG+d0qcSAH+Zfp/Db8oawSBN
 +qujhHWKNDgpzjq5IjLz/sKgKuDn7ajvflUNeOkf4yIST1Mt+3maLuiYpKTM7MKECteIkDHR/qA
 mSgyquuYtxfAjJKi9NA==
X-Proofpoint-ORIG-GUID: bUiWtEhBndHOaq5LjX7ddtKmfZ6JDScH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2MiBTYWx0ZWRfX3PXQJN6yX/Be
 XWsNiltgocEfuZIv8s8o7AwarM4Fa2gHc8Fg596pd0ZAPmhH+dmXFn57Ojn65VfBtgTFlDhDVUx
 EVdl4hJP/ms6UY1Xc9DXEn06BkqgQrOprV/VyvHnIVccWt6JoD9d
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11885
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240162

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

Hi,

Please disregard my previous empty email; I accidentally pressed send
before finishing.
Regarding the tags, I realized while working on the implementation
that processing all of them and matching a tag to a program would be
extra O(BTF types) itration per program. This looks like it could
cause a performance hit during load.
If we go with the SEC() prefix approach you initially mentioned, we
could piggyback off the bpf_object_init_progs iteration for each
program and avoid the extra O(BTF types) iteration for each, which
seems  more efficient.

Let me know what you think.

Thanks,
Andrey

>
> For bpf_program__set_autoload() API, I *think* we can manage backwards
> compatibility by converting bool argument to enum with zero matching
> to "don't load", 1 matching to "eagerly load" and 2 will be "lazy load
> maybe later if user ask for it".
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
