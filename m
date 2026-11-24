Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551442;
	b=WUr5K4fgUjBmP7WP4PRLlaOe9VqwWZIDMFBS9S2cy3Vhyl4za4LcFZWBcuPtNhw3LVH1
	 hogfYoZm00FPZz0vt50aGC74xO1BxwMJ1VFPZqJCAhgG0efqB165W9XPdjRutP500HZDo
	 YXijeNPq4qhU4DhzrqCvjJn2YZXEloI/n5noDx4DQ3vBaMWSoCkxGo98CU/djb9AE5K5U
	 kPXVuH/2AuN3vHdmagJKQn8sr/sFmT6kG6D3K8A26tIxZZG6taaLOOq4vdCHa73+IHOqV
	 aD3cZMgbCh+iFtkPazE2rR2BQWpyrStoFCDsxbgFL/EIkI5cYMKvveIiN1gyiaDvC9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551442;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VFtmMHSm5yw/EKK7RU5V/ejPnvYMaU4rRiO/Vhgj0Ec=;
	b=JyfLp3H51guNG1yoNynQVlNIJZxkhdlP2m9TpxjIojIcK1NApz+m347DFfgubP2UQv+M
	 jj7skguRp1jiINo6XFcb9zXYmUPrnqhVhYdsMlK82sGbJDyYg8/QPTS5NpMobRKSdmcRT
	 aIEB17RQBJGwiApoYSOrW0QMordQh8D0DjqNHWYml4Q1jVLIGu/78XOuo1sSohpn+m4LA
	 QOt/RUhKXfU5tG8MeiV+pwmVzTCGE+Q9zXsDDMe1Iv4NyMTO2TIkGKy9IgSOyOKWGqEfh
	 kCaGmH/jZYu5LoG55pS95imJGfDD9NEsg6WARGLOrypNIVzhtQv2qgNujAlEctpHvGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=jijxz6HI;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=BQwjMrWX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333A606A32E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C333A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=jijxz6HI;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=BQwjMrWX
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOIIG9Z2513667
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=VFtmMHSm5yw/EKK7RU5V/ejPnvYMaU4rRiO/Vhgj0Ec=; b=jijx
	z6HI+Xn9XT6koPbLs8Ji09WRJ3iVc82WA9KY7k9jRjdJBt+zlpyb/MqM7aYaMHfO
	ZxmemnsWP9tku/QKlziB1vhBTTeADObXkzYdgtA4kvSbEZmShjo2BzqIuanQKmAg
	R916kxa1Q2hA5mv+0Xv1gOE8qKkrt9uPo1L/z+8AVTxvBVbCkrfXsEDU3owguLbd
	/SFHKproHF4HLrotZRL1NW4M+Txr0VcrdYP+kPz8K8XYLv1CJII1cY19p2LnWeMJ
	9we7S8NOd5HvB6lhvcQ3OuMuUYBfbRTsVdJhUYU027uJn7ExzTsQk7/Z6V+wV/ZI
	u/kQoRhb/vZ9xr05ag==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4j4va04fbq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:17:20 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67c58f18a42so8948943d50.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:17:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795551439; cv=none;
        d=google.com; s=arc-20260327;
        b=n75Dho9o/DQWaLq+Vg7+jXc3Oz5hvc034iq52hswFVXMnX1ODi14DJNJuCVBAc4LRH
         04eMOPMgH8aSKiz1BvlMsmmKVuftJEFDo06Ofo6Y5lC3uMLblEdt6F+0NalzdPlV4C4+
         kYyEQDJFaIi9SJdPSSKtkMOHbtBbQeHM0cShRqjW1AEaovv2CsaqLdZrPr+3D2wUFPW8
         OiZqwPFb+ZQ8L53g3xd7bB6YW1oT8q86qNaMnES/aRFPck9MzSKP1mxce2DovNFLsfvQ
         pp+HYc7ppoqwLWZ9qiJPMiqwP7EJvdJH6ErvWQD/FHBwrE8e0/T9SHZM50Fl7BlOgmGd
         Xhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFtmMHSm5yw/EKK7RU5V/ejPnvYMaU4rRiO/Vhgj0Ec=;
        fh=iM6G/ZE6+N45+DmL98L2fQGJyyl0RxFa0rd2KWO+Xmc=;
        b=U6hAK4S4jh4haFbrrnb1kcQidqo2c3wv0+q7ZUT+Eh52ofAELSKGVqeUmMvhlK8e8C
         Nd8S2gqPHP1G8RnvFR+veaUOT3pyQmcbA7sgQSjqL+r7XyMTmPXayC04+NG76TDkGkLR
         JmNhfqJwUx+rWkyZX48Q6lh1Kl9dLL/+c3F1SgjtH3+1Fls6/GkFg2yiUQFZX7R7CG0r
         VKc7IjWj47RN56RM2QVdO+u3bkYaDRPWEL2IUtcaL+QXppSiC0A4XzCYmRUvEhycyutL
         kAj4Df9GrOfYi+Isl7q1Mabf2bNlHjL5KUou/ZA5q1+7UeGiNgc7AfnEHOFFaXqVYSLI
         K9zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1795551439; x=1796156239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VFtmMHSm5yw/EKK7RU5V/ejPnvYMaU4rRiO/Vhgj0Ec=;
        b=BQwjMrWXyYGwRkdQeoBAe+5qqkcLrGCK5B0YHdNf6nWjoYyalACqbdvAWfEF4udyoJ
         einOujPR7q6O2SrGay78w4h+jWaaTHv1SrckclqiLG4hTQMacfCI03Qr/DxNqu9XW5hB
         qA/ZbtisIw1aNs6g2TMbcm0xL2AMCA715DPgZe9H6INCOkJE7fAZAF7rap8+GBmYRUjO
         Z+LK/+nVnbzqVz4Nm4OLGVOi8dWkVUjBn477gyWoU7bjFuxkHGpWWfYvXF0RzHQ5yOx2
         +kY56ZOGrcp4OhIFIRauFL16aL4gb2LDCN7lnq8tf2rlRhvQpxqCBUgUB6sqt82XOKA/
         54pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551439; x=1796156239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFtmMHSm5yw/EKK7RU5V/ejPnvYMaU4rRiO/Vhgj0Ec=;
        b=J4CVpCEsb6+p/Q9WRK25K1rL+Dfu9+nGgjqpUWk60JJ7vT94K0w7fntFqmserSV/ZA
         RalAQAX9/te3WuHN3fv7bRkekUDgVnsg3W7P3Uxex8Eoz1JnqFK/QAIzVK4jS3RauE52
         F8hq6qKnynjYxcvNu8TtZ9qDwLlw8WIfX87PnAUkCOYGvyDVW8EqUY/jZ/22zTsOWoqg
         ibmwCIxTujZXvWtQb0W9TBBFmzEtvJGkjYjsEmkbOS0xIt4AbdNH9BSujM3qO4+vYTzt
         8h0u0xset3drMVEcFqoPJm7MCMqnGwZQrrI47wf83SXSNwoXRc4u4gX1XX6nrYvfCzNc
         kt7w==
X-Forwarded-Encrypted: i=1; AL+hErFSjxG+A1soSC0ySdlx8YEMSzZAh6pnQAky4+Fc+16TwTECTTQ1PquwIEyG1NxuIKfHj6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R6bPLd7ToMni7S8PEh5Vd3+YpWe+yJpQQ1NGyGZzsyvjGK59U
	3HlKC1NojU/F/33CMILnsXNqiBDZX+OUZsbMqpN/HpYMTuiAIlQuEFxIhGl1V6M4gQqj2WgfihQ
	DmdxcqPh39HyXC3Cx/Wo5DMwmWU0xCgIn0EvNhOYGgPiJvdd1YgZjB2UR7704eTaQa57pwZSwLr
	mErvQLjWll0AflkoUgfPW2Q2dfFXZV
X-Gm-Gg: AZFdTZfg+xB7d8N2TgXKPAm3P4JIPjsmAuRMl2WPf+xZiuHZE836U0+a46nKSZMPjGR
	8viYJzk1lFMk5n4OkpivUjRhviWh5k9zl62wL8G9FkNPRhrppCjC16uV7d0u5VkeC+8ydVpP9F8
	z5LFFBpcDIgtSU+xYFF/GPS3kx+4aBoNL2RYiVw3lumUw9oRZAAeCRCpL0Jg==
X-Received: by 2002:a05:690e:169e:b0:67c:1101:c0be with SMTP id 956f58d0204a3-67df4519f6emr6277158d50.100.1795551439238;
        Tue, 24 Nov 2026 12:17:19 -0800 (PST)
X-Received: by 2002:a05:690e:169e:b0:67c:1101:c0be with SMTP id
 956f58d0204a3-67df4519f6emr6277143d50.100.1795551438819; Tue, 24 Nov 2026
 12:17:18 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123223227.745345-2-almagui@kernel.org> <daac95452e1e87f874f41492facf95fd16118d93b67f7964e3510368751148b0@mail.kernel.org>
In-Reply-To: <daac95452e1e87f874f41492facf95fd16118d93b67f7964e3510368751148b0@mail.kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 24 Nov 2026 15:17:04 -0500
X-Gm-Features: Aa3M54oIQCQouxrbIK0630QF9poI62eMT0apzfcXRRLloaMFm4qjFkkToT7ZgiA
Message-ID: <CAOu3gNi-gniBMx-zWfWQDNPn0FygX2cKbdWjYk=dH8B_4tUSbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: Support CO-RE relocation of tracing
 program arguments
To: bot+bpf-ci@kernel.org
Cc: almagui@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
        john.fastabend@gmail.com, bpf@vger.kernel.org, martin.lau@kernel.org,
        mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b05f0d0 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=LuO3Ysfs2d92ZD7supAA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3OSBTYWx0ZWRfXz/XBLwaG8NDm
 ohceR647eKKQG4fZvLccnNiaDpUWwTlbBbpXjbqK6AtFsFnMzZErPhe/gTi9eXbvD7j/ql5csa8
 KcVNiAI4V3wGIcqcyfbaeu6xwUdZgcNoDzq3VZqJfo2vMzU/WLwzL/qXYeX1wvo1n9fm3nXl3dU
 z0wIGnn6xTRiFb7bjVnlIAOrR32td4OCQ2ACsMv/9M06iBjM+fvDAfD1oIFs8oCjRO5DeaYOemi
 KqXCkQTPsSet3Khd0KNTJtqzlPieK8KfMdHslAuby3IFgbNVvVb8hLF+tDEN3kBqE7/oNCHQ3RO
 pJnxpKHZ08701PVMYOA/W7lT+6rmLwGI6jtKwVxsEWNQ1YxlBeACEqeIBylzZsmGMcQnsdPkwa+
 aNSog1hC4PtvTgWMAPzyhUe40htvV0tHM1kla8QOp58C5UcApPEr+raA1/vAY/pJFDa365lQyzv
 MQH8UqQHW18ydpe0GqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3OSBTYWx0ZWRfX2JX2C5a0p6Ql
 JBJrPYQofZDywzI3d+Xt24ciO2iPxjmQeUbHj+ahQuXt5q+Nfbd9PT5Sq87XNZomhaPYOosqtgF
 YHHyi+UfCqDCgh9VJOrKM4kLNOjxZvOyaW7kwzE0LXjRgUIUiIYR
X-Proofpoint-GUID: pFkRPklZ4Jez_tCAkezaFkKy5mGM6XC0
X-Proofpoint-ORIG-GUID: pFkRPklZ4Jez_tCAkezaFkKy5mGM6XC0
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240079

On Mon, Nov 23, 2026 at 6:23=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > libbpf: Support CO-RE relocation of tracing program arguments
>
> TL;DR:
> - Changing attach target or type after bpf_object__prepare() may silently=
 load
>   stale argument offsets, reading the wrong arguments
> - bpf_tracing.h comments advise by-value struct member access that can fa=
il to
>   load (non-8-byte-aligned offsets)
>
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
>
> [ ... ]
>
> > + * On big-endian architectures (e.g., s390x), the verifier only allows=
 loads
> > + * of whole 8-byte context slots, so loads of integer and enum argumen=
ts (and
> > + * return values) smaller than 8 bytes are widened to their slot. That=
 only
>
> [ ... ]
>
> > + * Structs passed by value that are larger than 8 bytes can't be copie=
d out
> > + * of the program context as a whole, so they can't be used as argumen=
ts of
> > + * BPF_PROG_CORE; use an explicit __bpf_func_args struct and access th=
eir
> > + * members individually instead.
>
> Is this advice accurate for every struct?
>
> btf_ctx_access() rejects any context offset that is not a multiple of 8, =
on
> all architectures:
>
>     if (off % 8) {
>         bpf_log(log, "func '%s' offset %d is not multiple of 8\n", tname,=
 off);
>         return false;
>     }
>
> Nested member matching produces slot_offset + member_offset, so a member =
of
> a by-value struct argument at a non-8-byte-aligned offset can never be re=
ad.
> For example, with bpf_testmod_test_struct_arg_9(..., struct
> bpf_testmod_struct_arg_5 h, long i), where the struct is { char a; short =
b;
> int c; long d; }:
>
>     struct args9 { struct bpf_testmod_struct_arg_5 h; } __bpf_func_args;
>     ... return args->h.c;   /* ctx offset 7*8 + 4 =3D 60 */
>
> This fails to load with "offset 60 is not multiple of 8", yet it is what =
the
> comment recommends.  BPF_PROG2() handles this struct by loading whole u64
> slots.  The same applies to by-value structs of 8 bytes or less with memb=
ers
> at a non-zero offset, such as { int a; int b; }.
>
> Also, the big-endian paragraph says "the verifier only allows loads of wh=
ole
> 8-byte context slots".  bpf_tracing_ctx_access() only requires off % size=
 =3D=3D
> 0, so narrow loads at the start of a slot are accepted.  The actual
> constraint is 8-byte-aligned offsets, which is how the commit message
> describes it ("only allows 8-byte-aligned context accesses").
>
> Could both comments describe the 8-byte-aligned offset rule instead?
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > +/* Find the BTF type of the attach target of a BTF-attached tracing pr=
ogram */
> > +static int bpf_prog_attach_target(const struct bpf_program *prog,
> > +                               const struct btf **btf, __u32 *btf_id)
> > +{
>
> [ ... ]
>
> > +     if (prog->attach_btf_id) {
> > +             /* set via bpf_program__set_attach_target() */
> > +             btf_obj_fd =3D prog->attach_btf_obj_fd;
> > +             btf_type_id =3D prog->attach_btf_id;
> > +     } else {
> > +             const char *attach_name =3D strchr(prog->sec_name, '/');
>
> Function-argument relocations are now resolved during bpf_object__prepare=
():
>
> bpf_object__prepare() -> bpf_object__relocate() -> bpf_object__relocate_c=
ore()
>   -> bpf_core_resolve_relo() -> bpf_core_args_find_cands()
>     -> bpf_prog_attach_target()
>
> bpf_program__set_attach_target() and bpf_program__set_expected_attach_typ=
e()
> only reject obj->state >=3D OBJ_LOADED, so both still succeed in OBJ_PREP=
ARED.
> Before this patch nothing in prepare read the attach target, so open ->
> bpf_object__prepare() -> bpf_program__set_attach_target() ->
> bpf_object__load() worked.

This also means one unresolvable MANUAL program fails the whole
object, it would manifest now during the early bpf_object_prepare()
instead of only during later bpf_program__load() which might even
never come at all if the user doens't need this specific program. So
in total this somewhat increases fragility/decrease robustness against
load failures that manual loading previously provided.

Andrey

>
> With __bpf_func_args or BPF_PROG_CORE() in use, that sequence now loads
> instructions whose context offsets and sizes were computed for the old
> target.  At load time libbpf_prepare_prog_load() skips resolution because
> prog->attach_btf_id is non-zero, and the new attach_btf_id is passed to t=
he
> kernel, so nothing is redone and nothing reports an error.
>
> For example, SEC("fentry/foo") with struct args { int a; int b; } and foo=
(int
> a, int b).  After prepare, bpf_program__set_attach_target(prog, 0, "bar")
> with bar(int b, int a) loads fine, and args->a reads bar's slot 0, which =
is
> b.  The verifier accepts it because both slots are scalars.  Changing fen=
try
> to fexit via set_expected_attach_type() after prepare similarly leaves a
> __bpf_func_ret member resolved as missing.
>
> Can these setters be refused in OBJ_PREPARED for programs with function
> argument relocations, or can the target used during relocation be recorde=
d
> and compared at load/clone time?  The commit message does not mention thi=
s
> limitation, and no later commit in the series changes it.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://urldefense.com/v3/__https://github.com/kernel-patches/vmtest=
/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!w-hd0PfhYJsIrtg22Giy2F=
nAvkiYA7LGfOELMjPH8a2ryQInaef28p4GeE55YdQMRWRwtRe0FeqVsZVHDfyK7NCmfxnc9Vjl$
>
> CI run summary: https://urldefense.com/v3/__https://github.com/kernel-pat=
ches/bpf/actions/runs/45283084474__;!!BmdzS3_lV9HdKG8!w-hd0PfhYJsIrtg22Giy2=
FnAvkiYA7LGfOELMjPH8a2ryQInaef28p4GeE55YdQMRWRwtRe0FeqVsZVHDfyK7NCmf4lscwP2=
$
