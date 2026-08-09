Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A8351C2A
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300357; cv=pass; b=NcHIic6yXRG2jbzYM05TiRj1WnMXmYvNAp2kKXoDSUjtx8vp8PWP7UyujyPbpoJG3TbZIdTXvXeYtf/keNNwuDieR5f69vAeqEapJDrlh6CtXrIv2yENvDC6jGPf+G5JVJFFqq3zNdz/OKo4Yx0aYMoO5valjTT/hSeNWcAHnSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300357; c=relaxed/simple;
	bh=ZRvxCPN/Pn6xKN4kzylsdN8URZcXpD40RKKAE4yvtcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEPd83kJeMsTXSB81dyiUDJ8J9tntcr/Li7q6LE0mFBQ2lGGZtZiYFTtFAJVlAwlqKY6MAMvrq6UB2q81eCWNIohkeeqmDUeKyZg3NMHIwTHBcSH5A9reob4ivwdmlNCHCz+obwXGfnyh2Z9/J4m4t/mTBvZkeeYcuLbx7TAwO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FfTink7w; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gFUI2ecx; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FfTink7w";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gFUI2ecx"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679FmEmb1464648
	for <bpf@vger.kernel.org>; Sun, 9 Aug 2026 18:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=; b=FfTi
	nk7wAnz35vkjyqgaz5kxh8xN/mxzF5PiLfKFsxowFPJ9BLT4e4XeNrIcqhwaVXWE
	dGBuWprH5ZuhY0JxYqZkg7ERi1/Uw3uQDeZL5p+GAl04552mj2ToUocoVEuEfxa0
	jGf+GkVtd58SX5y0mu7mJ/JIAFmr21JTqSg6ish8OBzj6wGxO2Br5377wCjldAXd
	aKt69xzBWYA6ZnkoPLT9g4ZrFweGpVG8siwTezwba1nMzPleA5qh9ilPbtL81hok
	WQcJMzGLPZuXrL9ha2pTuEPlC1AHsbYrCXXU+1HjKsbLzd6VCqKhKFOUC5N4Oo8d
	LUMWSqijyLQ2I86EAg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fxj9116wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 18:32:29 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-821167f53cfso39641567b3.3
        for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 11:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786300349; cv=none;
        d=google.com; s=arc-20260327;
        b=ZN5FNntdD63/0jp5qFG/NGlVGs0ZsK8BnvQ+Ga+hHzwJQpsKu0XXJSLJtJOzAwu6kM
         ZBiqarUylSpdZhwxjgDE+inAbHiCKfI7krJpbD0pl6cc6n5MEjuof4GiEAg2S4kbFVFX
         AmHl/wkCQI8jMo4+pQCtpksdK37Ab01R2Woa6S+0LgASP4GlJEje5hgI60NQMrWHbv7y
         z7S/DD8sWI/lPbYFgX6gVqHWT18qamtnst1e5ZkIxfEU5BCOTDKhr/NqabQuV383iCKW
         omqCXavjd0vNO5HDlp34Zeg4ufN5qoBCuoogSVPiZtsIWU/1qSuSBOlrwbCc4rMVCme3
         fGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        fh=JhJtW9zzOCVEzCBLEyRHkJliHE+OdzQNFDwhlwWEEG0=;
        b=LKwTzCS0vB4CWCNWRwRoWQqoGdh/YcoDxyOZ1aLcYiMdSIaFXn+C8IeHocCpNBg0N0
         TyVNFs+n+/UStYgiq5jGiG9GuIqjW5RelBiQYPTNAKe/MEOAlbk29tZK6mPe2FzTt6A1
         6044g/AaRMf9YLpS6b7qUHg7FgErST/F4tIlxfLPu40cB/X35G9BAmGI6iwVgphQ2xgM
         s1fUGM/U17Z1cdWxpKNe+TrDcQt+usgM0kw1guzF6SdyVKdEh8rPdQ4jARNZ9VlEpF3v
         z3+h/X3oY4NVeaVd6Qp424xuwGgK/KqzT3JelZVv059KrignvKpTbRt25XAuDmwZibuf
         B93w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786300349; x=1786905149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=gFUI2ecxASqj86RV116VD5mzrU5KAA/rbb1xhqriAdMmI9cPJveswvJ71H3YGcfjok
         kJFDFvQBuproli1/q6go3sHtL3OGBP6WxYsJgMpeb2mfmRDZDlZBWKV0qLNYH01FomLa
         SzsO909KdkM7dwdTgO0szrEiZtKk7TSLADHNYkcybF/SG6S+sMQ5b4tp3z1JVb4Qlrmb
         OPlknHMUlotlus548ElwNxz4ZiwUN4ds1ZiTBJv7TcCb4p24FfzKM8ObatNScjjmaia3
         bayhQrZ/dA25V0vzx9R+tj2mTmHKtpri7FPpaBPnzX9BlnwpOMmcj1/dSxUfKKlUCQxi
         jMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786300349; x=1786905149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=UdoFvD+Btd2VAPAyGf7Nv2zBjrym3ig1qMmeWRTr3Q+MLdLrMdPl3zvLGoosrk2PSo
         hoJ8kyQrblFfdrby/EytbF4DtbYooO+4a6CLMTIQ31IaD85JTwHcuWGeEKcFDK0wGA63
         V4gi6S5u3dApNARW3qwL+ybF0ddI1xJtH7du2Glle1JC/1ePTkTfEHWksGYAW+gb4ec5
         okFovM3dpeQ8XdFpfeDKEwor8kmGQAfqYkdFeE8sm7U90GFoXfTonjQchS+vaJANQ27m
         sDvNMZ9Z/6odVPELajQWkVS8w/6pHanyCK03qmbdWwh9r85i1AF/V8EfB0xmV7OC18b5
         E3gw==
X-Gm-Message-State: AOJu0Yy0FcBofXiQSNoP6hnghvszwIBHtNaDFtrB/nT/V25UqRyxH427
	XK6Uoi2DSwpuT6/Yl8k0AxgtqLTxgGm3D2c1uEYZCTJtIJj/g0miwY57P8W92utO1wmvVamRlSO
	YJmj9WjXqMsM0CxMHtwKIFnrWXXateZMCH8GF2dbz98JdQr3Wvv/oBBxRA2xOgtiFEI3LEz9TSC
	h3jOM6dGgXanxloQey4QObyaC+SggT
X-Gm-Gg: AR+sD111yz2FtHgsJGHRNehFSXkkh+vppLpwOWkyT5vQE4Q+3PpCeGYnwhio6MuSzDQ
	dUmVoWoAuLSPjOdVRIK0fUtAyNNMY/n5S/PbfnXRQY1m63+4oUfS1o99JNouFJKFWC9nbZeiqD3
	mtDtXKvnn6ZfnoVEK/VbiIktCbIA55Oc8IiNRjI1r7Ph66tfcVUx0Tn+ZLOQ==
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id 00721157ae682-8257357f604mr89550467b3.13.1786300348843;
        Sun, 09 Aug 2026 11:32:28 -0700 (PDT)
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id
 00721157ae682-8257357f604mr89550147b3.13.1786300348210; Sun, 09 Aug 2026
 11:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com> <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
In-Reply-To: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sun, 9 Aug 2026 14:32:16 -0400
X-Gm-Features: AUfX_mxB61PImxk7Ub1YrOZ365ALM_DPyxKzut-8yKDjXWIjCGfwpeEyQKycU1U
Message-ID: <CAOu3gNhgRTh8uZdfNf+XBpYuJWAFu5i+UNjQC2jce4DdRc-bGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a78c7bd cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=jPl8K6pqbzkCHX85MxAA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: xRLUh2_j4MfEiDsp1zE_773piN6CFHxc
X-Proofpoint-ORIG-GUID: xRLUh2_j4MfEiDsp1zE_773piN6CFHxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX5yP7VVpP/Gna
 kytdMFfAfl9lx12Z3wD1q+h0z7mYWJwHkGNyiB9KNOYfgW9LzuC72/V/jG9pQYZz91/aKR6MiAC
 Pkx1lESJN5Q/T6mXYMtMJOr4ErIpG34mj7E90pCoP+uDaibqdrdQeehBRr+lIuSsKE4N+WXvE62
 Bg1pCfCuEA3KRDcUCfzOAnaSd0HrY8Xe4cVGXhhT/1DQmJSsc1CrwkHCosUsekEOFoF9eDYGUi9
 bhmYzeEQHjf3zY8h1Tw3j2JJ5g9T+Gvv3v04XKsjX5D2yPRxKeUPkBcy5awELKDKg1V/9zxPkB8
 n9Q7M1Fgr81HJiVKpuJI35HVs2QJ5MBVmNLn5snXZsnjhJINd2nrP14FYS35htsn5CIkT9s5Ewl
 ePddmfQvM1ytgaAP5bVkX11ZXu8xEVJ72TdoMG+KoZF+oKcE8RLgiy53+n0/Q87RuRrKzvZe1nl
 SSC7AMIJI3IynuX4ilQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX6sZG2VggR3un
 gW9j72QIl42CV32CP1bujYiS4AcfDGrcFo2e5NzJyzbOEVCP/ZAS9WmNOU5pwGUAXxYU/wvNI3A
 VzaXj6XQzQOKlkLDW1AZRhCFZ/TqzK82U1DNsHDpiDsftZyjmKeH
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090168

On Thu, Aug 6, 2026 at 5:52=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > > callers rely on ftrace always being on). Refuse the write instead of
> > > leaving it in an inconsistent "disables some, not all" state: return
> > > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > > unaffected.
> > >
> > > Update the docs to note the deprecation up front.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >
> > Sashiko's comments make sense. Other than those:
> >
>
> The bot has 2 comments.
>
> In my opinion, the test-breaking comment is wrong as he looked
> strictly at this patch w/o reviewing the follow-up live patch testing
> changes which update the tests to avoid breaks.
>
> The cleanup comment is valid but since we aren't sure if we'll need to
> revert this change later if it breaks userspace in some unseen way, I
> wonder how extensive the cleanup should be? Steven, can you advise
> please ?
>
> Andrey

Gentle ping on this question above Steven.

Andrey

>
> > Acked-by: Song Liu <song@kernel.org>
> >
> > > ---
> > >  Documentation/trace/ftrace.rst |  5 ++++
> > >  kernel/trace/ftrace.c          | 43 +++++---------------------------=
--
> > >  2 files changed, 11 insertions(+), 37 deletions(-)
> > >
