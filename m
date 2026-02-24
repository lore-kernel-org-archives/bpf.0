Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543125B1C7
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965738; cv=pass; b=ZL59a9eN42/V28gtIXvAKd6fy0wyY2qMDxPBFmzc05A4CZlVSMicLlpKc4eEbjJDFAA4SXkvJg+qMbI3qhXXY2fpOTjTC/yjApGcLdZBptFiUShe43XcPO6X0yvsnRQ0aqYd1cbAJrJbFXJrQdkCq0y6pD9Pe20Id4yQeoqYDEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965738; c=relaxed/simple;
	bh=mnISPsJImprH168AWpbgdFRVqAmxfR7AIlg8dt16f00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNaJ68lKQ9GFbDWRQG32gHo4hgVlYdqfYL/Ig8M1Gg6NaCJi8WhhUzy+BKSxBxVUYeetE9AGTIehb4r2mbYQTc8lKRm7WUh1m74IsRmYasyrZNpxnbSdb+TiJf1gIX6u2uz2S6kh4pJqwnjP3TjH2yi6SqdAeOdZN1v+/hh3x0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=bLwUVwVO; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=N+g8xVZs; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="bLwUVwVO";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="N+g8xVZs"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OKalB01595629
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=default; bh=WlZGPMdZypZmN+ZFMakIn+2UUV
	GCEw9NXdFUQ2o1k8M=; b=bLwUVwVO9h8WftaNjcSYOxMZWjl0jV8aHsFRJ5E8mr
	azjqzd4vIwz8oEfGeMjw6TeCtU7YVF+5s2xVRWWVurca4S+bclbABBc5d1LUcb2P
	Mo8oSkXtGRLkWNgLTe4eMSVZE+g5J2L7V9gJa/0kBElleKnEibbHXr5q+X+wWRb4
	YtzF6XAsjfC0d6fuwoPjy9JpWCO3RBO3CeZ6FAsVT+AVuMyu71Qs6Gq0y0B5w/zh
	2khiJNSt2V2wguEMuOjSpeqoY/Xhp+CLHi7/b1ISgO2cPazhJiOiG3FdcaB+wrYZ
	+dgNuet+8BtOLFDuGpH61Vh3BPeHbWFRFhRlRJFVs0VA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4chk66r0kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:42:15 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-797a92852d3so94981307b3.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771965735; cv=none;
        d=google.com; s=arc-20240605;
        b=XG9oGZL5jl9wMRHfvnuJoQlTfwKz7zl5LuQIW9hR8ljjQ4P0ItEgxQMcVB6PxmGrDk
         jGQdEIAMLxku3PDVBrWlBRwmIqfq9bGyTdSyVU6Y6k6LMOzY32uzCBMjh4kkKYAIBb7e
         eFC6yyoWCc2o9flVWjxbHb/tLc02WK2Xc//YbCqM+VVhddauakH4BAZuR2OY/vCDZBhO
         ZCnuetepI5O6UWLc9Xo4CSFa0ifc3SOIjT4IhbzHlm2hEjkKurx6K3i5FikE0TFnB3v/
         hvOUTX1lZCK2Xdhf0b9Sure8zFDwSe8xbEEwyfkS8RaA1a9eBpRgSccDR+GJqMcEh4AA
         M96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WlZGPMdZypZmN+ZFMakIn+2UUVGCEw9NXdFUQ2o1k8M=;
        fh=AViG/WVHQV3VSN1+/7gGN99xGFfqgKWnmAronJ/Jcf8=;
        b=CAcwDhse1BQLRJLrJVgiOtOWN9NQ9Fo+ZWzwsez4pvt3ypcFUQ4jUAILKpNQ+VMJH5
         d3aOZ2F2wS2UqWBz8orauWTMz3w3Xj/gA1XODyI2Db5ttoQFT25uxtE7Po3O6oTjvP5C
         r4rLBYINdGc/9Frl7amrb1hHBhm56ky6jwv5GeVhtnYQNAgwxP52QmZgn74TXtZ0nZdN
         A/k2u2ffbo2NV+foV8AIlsTtGx6iDeUcLBb8roJ47ZSyBhlxKlTY8VqeXdeF8q5azCG7
         a/bLu/caibGaWeGOM0hYFNhCCAYIpGG3yBz7gWtJ6UXJabG+JEsqhKSsr6X1tsWY+FFb
         YaBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1771965735; x=1772570535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZGPMdZypZmN+ZFMakIn+2UUVGCEw9NXdFUQ2o1k8M=;
        b=N+g8xVZssz0d/2BmphQ8+B4fndXSvHt83Vi+jXDl8EF36dbEFKzNlLG5FCbCdwsP55
         8qVuKw9BUKIjrT61+K2l+U/f28GCJYZhZQMtwFftjTRl+yAinIh5E0Wi6/NCweco27SY
         zNxaaizqr13Gxywzf9ncyXCUmlvca0JgeRUw0cEVEORa/sHJ0by+fT0vRYW1uI7GgSH3
         QfgdmucnowHFleEq8DjqxdFFMjWk+QCvL8+t4i1XLTgnBXSZWNCtbaUgXSx5mbgCXskJ
         tCkAaZCGfdSkTQh0OT29mOKR5Gt+oTuujfAw3myO+gfkN2HC5ikoARaPs7eKQ5VNVVss
         0TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771965735; x=1772570535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlZGPMdZypZmN+ZFMakIn+2UUVGCEw9NXdFUQ2o1k8M=;
        b=wxikOHFxmY2RJMmMKc9QU4sz+I2DXRhW/VH8adUiWtvbQJIm9q3BF83ZPhisJM6IpG
         MwN+berKnkY4feo4RYpHNHjoo/ce2Q86l6I1x7cCuBUyXioCgn7254XomzjlwZPCqCfl
         Qv7DG8DWghygjv9gRusjIhJUW4yd+O99NCWIRyFRhudGFmC6UCClIlOA+/k3ArVgcUPh
         KI9MX0+noA94bFZ8VC5WxMyXgVI4JsQscK2cLsWzbq9ClNwWlWsK905L+3qB9L+qSk0D
         84eM3WS9wffAZIIxcFnSeJV9ULm42MSHJgFagyZWiSudtv4RV2lxXJJ7ATDT3euUkPfF
         OACg==
X-Gm-Message-State: AOJu0Yx1UdDx5dfc3Qg6YTGOymTnZ0IPJqQNttA/BZcZ5Oj6l4GHL4Vb
	1oWqakLgvJ4rHaivNM6YpNlC9oLj4dfERJzUBJCSF+riEWFCfHCKAJOJavqD87v+zR2m2oj2mkj
	yTzOSAe2f8JeBUSjvt+pYsTeoiH1LhzevXG/VdXAYYny5lK/d+TTXe7kcWRtVTPf7SSFi1S1Yf1
	6oYO0sfmqjPRQwUJL6jFj6NSuH5Lfc4WhsFcKyK6o=
X-Gm-Gg: ATEYQzxvBzX1TXxCKtEA7yAi0LYOaBFEPFSHoB0AVbajNjnZaZhlGkGiF+sTBvFPw2F
	qyosMBIHz/gIRcWPBkqX6Mrrtj1KoOn2NJd0IjJkYCnIDsZdBA0ccU3Ca+Eht1g4kuMCRGl20zz
	IzscVjKzqA5N0jYb51lCElNz6o1T4C1IHWHUoTpn1vPixDV0nkZgtGO7xjI383PHVrszM75+LJd
	+Zt
X-Received: by 2002:a05:690c:c511:b0:798:6619:f1d4 with SMTP id 00721157ae682-7986619f50fmr8137497b3.6.1771965734961;
        Tue, 24 Feb 2026 12:42:14 -0800 (PST)
X-Received: by 2002:a05:690c:c511:b0:798:6619:f1d4 with SMTP id
 00721157ae682-7986619f50fmr8137167b3.6.1771965734427; Tue, 24 Feb 2026
 12:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
 <20260224172340.1704618-2-andrey.grodzovsky@crowdstrike.com> <DGNDVI5OW8LF.38M1D6KV6YVHS@etsalapatis.com>
In-Reply-To: <DGNDVI5OW8LF.38M1D6KV6YVHS@etsalapatis.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 24 Feb 2026 15:42:03 -0500
X-Gm-Features: AaiRm52JH3ICQQqkv74_OmBx1HFKbtP_-y6zlLJNIVzHyWnlljZuZrZroFZ8r-M
Message-ID: <CAOu3gNipY0dHCjoYoit4XH2PYG2J0Fpk7F=0eWnyGd98_6JwWw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v2 1/2] libbpf: Handle
 duplicate kprobe symbols in attach_kprobe_opts
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=R5MO2NRX c=1 sm=1 tr=0 ts=699e0d27 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=CbNFBKWpDDtCZVcQraAA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3OCBTYWx0ZWRfXyfFrsGpnQF+w
 In41VRmecZhvkR7iHJ/t/gWSGHllx5oA5Cz1/N22xufROkedFb02e6tyOwmxqG9s0cJgJjTUqMF
 5fOp16h2tgKP29/HPjaXdTin8pe5GspHjp2l9ZoGL6Kcsj4mz0XSzFLzugS7ZWMVLGF92BadQdG
 gQVj12DbRBNdMYY/OLY4fmkdyY0i8pqIQQP3ULEKsyjI0o/hkGJxOvq77wW6MIohXeL7aMEecTj
 g03D6wB6A0sILdbqSa7VyJ3LX/5tlXPpfp+XSspSLRXeP0NFZxUqt/+OabvtjckgbD1fK0Uq5BI
 xNBXlQQzMQUq/tmKI0J2MwmvS98TKdpekqDtwAXFr/OrbT+ogTHPVNVn92QvXfuZaKsGbALsjEe
 D3uWHf6Ryp63qiCAbqqZy5l7Qr3n4IMshPR6jp0OH50qkV1rbbrWh4EwQt952ehBMSa4COmFHZr
 QK1UChZIm+9cyeexdkA==
X-Proofpoint-GUID: n-3OMahvSQjGbJOc4aYvhuzYh_w8rmu-
X-Proofpoint-ORIG-GUID: n-3OMahvSQjGbJOc4aYvhuzYh_w8rmu-
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11711
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240178

Hey Emil, sorry for sending this twice. My reply was dropped
from bpf@vger.kernel.org due to formatting issues.

>
> On Tue Feb 24, 2026 at 12:23 PM EST, Andrey Grodzovsky wrote:
> > When attaching a kprobe to a function that has duplicate symbols in
> > kallsyms (e.g. same name in vmlinux and a module), the kernel returns
> > EADDRNOTAVAIL (or EINVAL via the legacy path). Detect this and retry
> > by resolving the vmlinux address through kallsyms, skipping module
> > symbols, and using the absolute address for probe creation.
> >
> > Extend libbpf_kallsyms_parse() to support module name extraction and
> > add a skip_if_module flag so callers can filter module symbols at the
> > parse level without changing callback signatures.
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 153 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 135 insertions(+), 18 deletions(-)
> >
>
>
> Nit: Missing newline between comment open and the text.
>
> > +              * duplicate symbol name. Reject such symbols to avoid
> > +              * ambiguous resolution.
> > +              */
> > +             if (data->kaddr && data->kaddr != sym_addr) {
>
> Q: Is it possible that data->kaddr == sym_addr in the first place - that
> is, can we get the same symbol resolution twice? If not, can we simplify
> this to if (data->kaddr) { ... } ?

I looked into this.

I confirmed it happens for data symbols - zero-sized lock_class_key
objects produce many duplicate name+address entries in
kallsyms:

ffffffff96307908 __key.0
ffffffff96307908 __key.1
ffffffff96307908 __key.2

For text symbols, I didn't find but, I belive, this could still occur
with weak functions - if the kernel defines a __weak function in a
header or common file and multiple subsystems include it
without overriding it with a strong version, the linker
may retain multiple entries pointing to the same fallback
implementation. In that case the resolution is not ambiguous - both entries
point to the same code, so we should not reject it. So my prefernce is
To keep this extra check just because of this theoretical possibility.
happen. But yea, I don't have proof this actually can happen.
Let me know what you think.

Andrey

>
> > +                     pr_warn("kernel symbol '%s': resolution is ambiguous: 0x%llx or 0x%llx\n",
> > +                     sym_name, data->kaddr, sym_addr);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             data->kaddr = sym_addr;
> > +             pr_debug("found kernel symbol %s at address 0x%llx\n",
> > +                      sym_name, data->kaddr);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
