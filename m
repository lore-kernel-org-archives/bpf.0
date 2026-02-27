Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08A3624A3
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231302; cv=pass; b=WoxjjT3RAvlN7HubFe+3GmI6oCzwQi3svsXO/Pi20lXdc/yIUDFuXej016+uqZGMMsxFeVxV06Cti+DHIcnSW6rftaf+CnuK8PFtUFz9/eL9SwSs0DSf9ZC5uo2IgIoHfd9KkxwT4kBVnCw/GlyCL67pxBMQ8FEuJw/VGuT9DwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231302; c=relaxed/simple;
	bh=RrAgxBkR/lFQ+itdDU9V1LQ1M5mKPBoFb43/f4yg7ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb+rL3G6YxXT1K4I9h/vGyTzieJ2Mv+gRSCwgX4mFV+3a/7aWNJC2JJZB9LhHCXAuubjK3sqo9XNClOKbtWVIMQgMqekXvYilX2s5InjoUEjR2EnJLslEGePUpooviHey/6UtGvduk6V8Z/wCH65KwiTK+THVvIc79tvKvLadoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=rcIiH85l; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=khprO+eJ; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="rcIiH85l";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="khprO+eJ"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK1LKQ1101925
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=; b=rcIi
	H85lwEjHEa+jVsubmCLh/twR8zxBwWwbPc/5IXvOsyrQbHvLb1u4Q/xkPxdR/YsT
	BXITZ41cWeWDuuDdhf8fq9R0f/ukITV03/660Ycq/zyoJuNT4vF+nRlno2YtlPty
	4P389IsH89F8fqxhLEA0l36deeGq09sLhtw2sccPOJCTmIC0KTvQTADBw2O4OCVP
	V5Dac7sJsL1nSoBnKDfjgO5x1Bu3mUsbtP0FmfpBjuoRlAvPARNcDJvFZOwHJgwh
	wINvzOey8FFGft7COWKbiUEjJ96L9uwtxVFl9ludJZu6t44Un+KwfysEyaWWMzbs
	fK5YW7ztxReYcPY6hQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ck5sq34s2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:28:20 +0000 (GMT)
Received: from 04WPEXCH014.crowdstrike.sys (10.100.11.87) by
 04WPEXCH013.crowdstrike.sys (10.100.11.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 22:28:17 +0000
Received: from mail-yx1-f69.google.com (10.100.11.78) by
 04WPEXCH014.crowdstrike.sys (10.100.11.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 27 Feb 2026 22:28:17 +0000
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-649deeeb00fso3804311d50.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:28:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772231297; cv=none;
        d=google.com; s=arc-20240605;
        b=kjNTwSnLvd+CLOjhKNr6SwLkX4bu31w7mv++YMWKII4wHR4nZ0LBquvIolPeD5RRY0
         oWsYIS4lV3QoNLSAvuRVH9weL0Dozwzg8/u5VnHwNcfe5MhtjCkJzwydizDsxNUCNtmz
         zHgXZW02y6NT/fR6k6qjC5Lsx9UpV3KX3Xe255F0zSj0HIgcRhUTD+GMHwgFgKHyfxW6
         t1pBDfjq+SWkU7ibA1vgcRw6IsEE1nDJyGDlaxp3F0zCh5Up3oPcG6o5e5LfSYHPCg0e
         HgMirQdQjSefhGVG+G+vYn77EoxG6HW5I2AZB020oqFt8tkW60o2i1x2RUzyKAeZBDEj
         m9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=;
        fh=tXzaMKxiqWZeTNNjANs6trTLO66nUaik/m7m3aRWZ6U=;
        b=Dz78gqjGqlO3J5gTAVcD+v8j4sgxR4zSLsXMSUIB8MOVc5OWzJEFiNnCTp2ObR1GW2
         hqfCRlsAuhkNuYTRpaNeP0B1fKYZbd46bSa1Efht9KASVSbDQcu2Fex1Uo11FboQRoaI
         0u7/94bbKADWhqJ+HBCQZLaMYE+EIMbFVsvLG6F2aFzHaH3B4kj+QdFjxpzdyyDbLRTC
         tLsmEVYDXNjKxk8RZ3+z6VReDHfboBH72ZVcsXxoYX37Xi1PbczQ+dQNCdHc5YCceFr8
         7HDqZx0hXCh8mtaCxs5bQjuT3uUu9KBuJV5pQ8Ax75e9OT6Hlxi6e2zWMh9agSACc2GF
         XYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772231297; x=1772836097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=;
        b=khprO+eJLwclk4H7C/ZfaUwCAMYKuFYuW8cJdPP0JMqCtVNjMhZ1K2oMngBNOa63dG
         RrkmVs/6a9TG5HpB1stL+O/glWZBNpcfIfTH+Hx4lSHpJYpd9vlqfmJiH5fVs4nHODcK
         QB5lqHcI9hGJhnMtYakOu5ZKI/5oq4WqCVR5SS8bIvY9yvc0aB0ZG5apbTPRj3PDWUAw
         oaB+xyoV9kDgcn0jLIzB8j4E8KYvmm35azI6vXOZhA6WaGOgB5U+fCTrfT0R7vrEdG52
         QiquruCbwm5gTR8hcD94TzGKsJShK+t83Oe4th+SMrZOC9R9aSKe6WpT6Y3QN/q7Z3rh
         GcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231297; x=1772836097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=;
        b=H7rZP9ghQGYlhOfWz6QTHdgtnW97uqard9/1XwQ6AiyK/JBYW3eWvLM7HIr0yByLo0
         WswOZnElrhr8S/iwf0G1a0DoZHL6HozyhZ+4O9UZFC1Cpqe1tz0pf12hoc5t1lQdmIzI
         PSd5Mt7ijYEmdW/m63Nnrsa4TVC0EHiJXsj//JYBTnasNRy/dLdcrsw2OScy71PdajFx
         1nGHrUe7NN9XjljSDZz6VsEbYxJ7tP1BnKR+eYEOsyck3pHAK6HjvSwMBk3dKBG+sGKB
         tb1cftFeD+nUGPVYPQ1az2vW5qxHVp8NDT003Vvwe+VD6A/xjjItnNO8FiBZHADYMAfl
         DsUQ==
X-Gm-Message-State: AOJu0YxiD5MqxWBhX6YrXHftupJPZexFnSYeUjzYv43rkhetJkd3LxwQ
	1dNkUUhCZnbKjzktLiWPlOcWj6JVN2FhePyBchcoPQR2E5bdGzTw+EYjd+j96eBve+JtRTb1Vto
	ZCsCrymScWFEbayRgFzGfZOKNWSoqY3/zVZnofA6GGF+vhuNbVTJ60EMwoaJwMiIME87oqDx1Ts
	S1vg4dRbAAvrWaFiQMwh/6T+iEf2Sn1o1pg3UB/X83cX8=
X-Gm-Gg: ATEYQzwREVmRytDbBb00NY5ZQVGQCW44H98raEJuUboUJcJh7579Tro6mVHNF7TVnTi
	PdIvUJJRw4sI/2XEQLmKmdxw8jVwopD1tttnzDzeC8bQdL4LYqpbgyo9jRn/UCEiunl8/vNol6K
	cI4fSHWw7uBQmaUx5BwrmVUQ8r8/cBrcmwvq9+CgaPC6vEJ7ZKVsuW9L5yfTkkjPo3CBo9YlnoT
	UB4
X-Received: by 2002:a05:690e:5:b0:644:4b86:e7d1 with SMTP id 956f58d0204a3-64cc202cd9bmr2889260d50.10.1772231296685;
        Fri, 27 Feb 2026 14:28:16 -0800 (PST)
X-Received: by 2002:a05:690e:5:b0:644:4b86:e7d1 with SMTP id
 956f58d0204a3-64cc202cd9bmr2889235d50.10.1772231296100; Fri, 27 Feb 2026
 14:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com> <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
In-Reply-To: <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 27 Feb 2026 17:28:05 -0500
X-Gm-Features: AaiRm50ZrstSXF_bNnA7UbOOTkJ2XmjQIkoaG7OYxmYN5Xhi0tg3Y1H31Kr_lXg
Message-ID: <CAOu3gNgRpMd9poZYibhGg+UfQXiHpB3ucnhvghoT0TF1rFfmPQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 1/3] libbpf: Optimize
 kprobe.session attachment for exact function names
To: bot+bpf-ci@kernel.org, yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        martin.lau@kernel.org, eddyz87@gmail.com, clm@meta.com,
        ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=JdexbEKV c=1 sm=1 tr=0 ts=69a21a84 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22
 a=VwQbUJbxAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=Pf4_4UIYwLVlXi1egjwA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 7HB5I-Ho7PE2qYyfKJ3CTVA3nngiYQ9r
X-Proofpoint-ORIG-GUID: 7HB5I-Ho7PE2qYyfKJ3CTVA3nngiYQ9r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE5OSBTYWx0ZWRfX/+Vg335x2aTe
 7qBaChi/9Ppt3/Pc+YgJzrp30XTDlGouDT6utisvswwNvwtUm0SULkzkb6weVUqZFBtoi6uUxEs
 E0er1Kl28MrVYlTlVIbfZ8MkWk236rGaA0ZxCkuIahvYsf4cOmDHZw4OPvAoJnUnH4OIMS4nZo+
 GrBki+yOEzaV1cXSr5n5zF14+7+9iFjUULSg/ZnVFfjo/dGOiKsnqg3a/I75laR14yaz7rNgRQV
 I5JKxtn6L65SL3uENXgZHt1Hu6Ho70IMN90jYNbjyGycf5L6b+7emYuYcz+YFnDWJbLmvumI1aj
 ZD8tSVz2NW/sxqXYUI/+o8nGjw/Mai7MqWGCImyHahcRhPu4UOjRiTp+pKnUZI51nf6htV/s64t
 ShNVNw55zDFyMWPjishekfpozDeHtSXTGzPXmM/3DLQbHNL9uGeW5RGsQiXfWOZSSJ/RAklZ1Is
 SvVZUsPUuUSKOaQqaxA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270199

On Fri, Feb 27, 2026 at 4:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -12041,7 +12041,15 @@ struct kprobe_multi_resolve res =3D {
> >       if (addrs && syms)
> >               return libbpf_err_ptr(-EINVAL);
> >
> > -     if (pattern) {
> > +     /*
> > +      * Exact function name (no wildcards): bypass kallsyms parsing
> > +      * and pass the symbol directly to the kernel via syms[] array.
> > +      * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> > +      */
> > +     if (pattern && !strpbrk(pattern, "*?")) {
> > +             syms =3D &pattern;
> > +             cnt =3D 1;
> > +     } else if (pattern) {
>
> When the fast path is taken here, unique_match is never checked.
> The unique_match validation is inside the "else if (pattern)"
> branch:
>
>     if (unique_match && res.cnt !=3D 1) {
>         pr_warn("prog '%s': failed to find a unique match ...");
>         err =3D -EINVAL;
>         goto error;
>     }
>
> Before this change, a caller passing an exact function name with
> unique_match =3D true would go through kallsyms parsing, which could
> find multiple addresses for same-named static functions across
> different translation units, and the unique_match check would
> correctly return an error.
>
> With the fast path, the name goes directly to the kernel's
> ftrace_lookup_symbols(), which resolves only the first match via
> kallsyms_callback() skipping duplicates:
>
>     if (args->addrs[idx])
>         return 0;
>
> Should the fast path condition also check unique_match, for
> example:
>
>     if (pattern && !strpbrk(pattern, "*?") && !unique_match) {
>
> This would preserve the optimization for the common case while
> falling back to the slow path when unique_match is explicitly
> requested.
>

I am not sure this makes sense, according to the original patchset [1]
this flag was specifically tailored for patterns with wildcards where
this indeed
makes sense. in our case, cnt =3D=3D 1 from the get go since no wildcards s=
o this
check can't ever fail.

Andrii, Yonghong - any suggestions ?

[1] - https://lore.kernel.org/bpf/20241218225246.3170300-1-yonghong.song@li=
nux.dev/

Andrey


> > [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://urldefense.com/v3/__https://github.com/kernel-patches/vmtest=
/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI2bmb=
4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuPuGlVKW$
>
> CI run summary: https://urldefense.com/v3/__https://github.com/kernel-pat=
ches/bpf/actions/runs/22503275616__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI2bm=
b4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuGeekJPd=
$
>
> AI-authorship-score: medium
> AI-authorship-explanation: Comments are unusually verbose for a simple op=
timization, and the commit message is well-structured with distinct section=
s, but the iterative v1-v3 refinement following reviewer feedback is typica=
l of human development.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: The fast path bypasses the unique_match check=
, which could silently attach to the wrong function among same-named static=
s, but requires the uncommon combination of unique_match=3Dtrue with an exa=
ct name matching multiple kernel functions.
